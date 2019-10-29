{-# LANGUAGE OverloadedStrings #-}

import           Control.Concurrent                             (forkIO,
                                                                 threadDelay)
import           Control.Monad                                  (forever)
import           Control.Monad.IO.Class                         (liftIO)
import           System.Metrics.Prometheus.Concurrent.RegistryT
import           System.Metrics.Prometheus.Http.Scrape          (serveHttpTextMetricsT)
import           System.Metrics.Prometheus.Metric.Counter       (inc)
import           System.Metrics.Prometheus.MetricId

main :: IO ()
main = runRegistryT $ do
    -- Labels can be defined as lists or added to an empty label set
    connectSuccessGauge <- registerGauge "example_connections" (fromList [("login", "success")])
    connectFailureGauge <- registerGauge "example_connections" (addLabel "login" "failure" mempty)
    connectCounter <- registerCounter "example_connection_total" mempty
    latencyHistogram <- registerHistogram "example_round_trip_latency_ms" mempty [10, 20..100]

    liftIO . forkIO . forever $ do
      inc connectCounter -- increment a counter
      threadDelay (3000 * 1000)

    -- [...] pass metric handles to the rest of the app

    serveHttpTextMetricsT 8080 ["metrics"] -- http://localhost:8080/metric server
