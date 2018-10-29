package main

import (
	"io"
	"text/template"
)

type bazel struct {
	rules []rule
	loads map[string]string
}

func (b *bazel) Render(out io.Writer) {
	var t = template.Must(template.New("name").Parse(tmpl))
	t.Execute(out, b)
}

func (b *bazel) Rules() []rule {
	return b.rules
}

func (b *bazel) Loads() map[string]string {
	return b.loads
}

func (b *bazel) Add(r ruler) {
	rr := r.Rule()
	b.loads[rr.Name] = rr.Load
	b.rules = append(b.rules, rr)
}

type ruler interface {
	Rule() rule
}

type rule struct {
	Name       string
	Load       string
	Parameters map[string]string
	URLs       []string
}

var tmpl = `# This file is generated by cmd/3p.

{{range $src, $name := .Loads}}
load({{printf "%q" $name}}, {{printf "%q" $src}})
{{end}}

def repo():
{{range $rule := .Rules}}
    {{$rule.Name}}(
    {{range $key, $val := .Parameters}}    {{$key}} = {{printf "%q" $val}},
    {{end -}}
	{{if .URLs}}    urls = [
	{{range $url := .URLs}}    {{printf "%q" $url}},
	{{- end}}
	],
	{{- end}}
    )
{{end}}
`
