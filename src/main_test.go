package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"
)

type HealthCheckBody struct {
	message string
}

func TestBaseHTML(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	w := httptest.NewRecorder()
	base(w, req)
	res := w.Result()
	defer res.Body.Close()

	data, err := ioutil.ReadAll(res.Body)
	if err != nil {
		t.Errorf("expected error to be nil got %v", err)
	}

	if string(data) != getTestBaseHTMLExpected() {
		t.Errorf("test expected %v got %v", getTestBaseHTMLExpected(), string(data))
	}
}

func getTestBaseHTMLExpected() string {
	return "Hello there, \nWelcome to the best website ever!"
}

func TestBaseHealthCheck(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	w := httptest.NewRecorder()
	base(w, req)
	res := w.Result()
	defer res.Body.Close()

	if res.StatusCode != http.StatusOK {
		t.Errorf("test expected %v got %v status code", http.StatusOK, res.StatusCode)
	}
}

func getTestSecretRouteExpected() string {
	return "secret route initiated"
}

func TestSecretRoute(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	w := httptest.NewRecorder()
	base(w, req)
	res := w.Result()
	defer res.Body.Close()

	data, err := ioutil.ReadAll(res.Body)
	if err != nil {
		t.Errorf("expected error to be nil got %v", err)
	}

	// top secret route firing off random number(%d) of times!!!\n", n)
	if string(data) != getTestSecretRouteExpected() {
		t.Errorf("test expected %v got %v", getTestSecretRouteExpected(), string(data))
	}
}
