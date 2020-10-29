# Unrd-iOS

Frameworks -
The idea behind the Unrd framework is that it is platfrom agnostic. This allows us to share code accross platforms easily. There is no UIKIt references which would rule out the framework being used on the mac for example.
Another major benefit of this is that we can develop and test without the need for a simulator which can drastically improve the teams speed and feedback loop.

The idea behind the UnrdIOS framework is that we can build all of our iOS specific components here, and easily link the framework with any iOS apps we wish to use those components in.

Schemes - 
There are 3 schemes. One platform agnostic, one iOS specific and 1 for running end to end tests which will actually hit the network. It's important to seperate these as they can be slow/flaky and we wouldnt want to run them often and so could add them in a CI pipeline.
