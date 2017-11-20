// Copyright 2017 Frédéric Guillot. All rights reserved.
// Use of this source code is governed by the Apache 2.0
// license that can be found in the LICENSE file.

package json

import (
	"encoding/json"
	"fmt"
	"github.com/miniflux/miniflux2/model"
	"io"
)

// Parse returns a normalized feed struct.
func Parse(data io.Reader) (*model.Feed, error) {
	jsonFeed := new(JsonFeed)
	decoder := json.NewDecoder(data)
	if err := decoder.Decode(&jsonFeed); err != nil {
		return nil, fmt.Errorf("Unable to parse JSON Feed: %v", err)
	}

	return jsonFeed.Transform(), nil
}