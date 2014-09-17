# Event Sourcing Example

## Research
* [Exploring CQRS and Event Sourcing [pdf]](http://download.microsoft.com/download/E/A/8/EA8C6E1F-01D8-43BA-992B-35CFCAA4FAE3/CQRS_Journey_Guide.pdf)
* [Project "a CQRS Journey"](http://cqrsjourney.github.io/)
* [github: knewter/eventsourcing-with-kevin](https://github.com/knewter/eventsourcing-with-kevin)
* [Martin Fowler on EventSourcing](http://martinfowler.com/eaaDev/EventSourcing.html)


## Glossary
* CQRS: [Command Query Responsibility Segregation](http://martinfowler.com/bliki/CQRS.html)

## Tangential questions
### How to make the system performant?
* [MemoryImage](http://martinfowler.com/bliki/MemoryImage.html)
* [MemoryImage](http://martinfowler.com/bliki/MemoryImage.html)
### Ordering of events? / Concurrent events


## Advantages
* Built-in auditing
* A better fit for certain domains that are heavy with discrete events

## Domains where Eventsourcing might be helpful
* Shipping
* Shoppingcarts
* Games
  * Players moves are events
* Issue trackers
  * Every interaction with customer is an event
