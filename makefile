
run:
	@echo "Running day ${day}..."
	$$(mocv bin)/moc -r $$(mops sources) src/${day}/main.mo