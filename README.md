
## Composite Combinators Core

For the reference see ExtremelyUsefulCompositeCombinators/code/euc.lua

# MAIN API

* Composite-Combinators-Core->registerCompositeCombinatorPrototype (entityName, compressionRatio, componentsTopLeftOffset, callbacksRemote)

	Register composite combinator prototype  
		__Parameters__:  
			* entityName :: string  
			* compressionRatio :: float how densely components are populated inside of combinator  
			* componentsTopLeftOffset :: Position - initial coordinate to populate components from, argument is given for direction.east  
			* callbacksRemote :: string - callbacks remote interface, should contain next functions:  
		__Callback fucntions__:  
				str GetBuildString(entity)  
				slots SaveStateInfoToSlots(entity)  
				void RestoreStateInfoFromSlots(TODO)  
			
* Composite-Combinators-Core->deletCompositeCombinatorPrototype (entityName)

	Deregister composite combinator prototype  
		__Parameters:__  
			* entityName :: string  
		
* Composite-Combinators-Core->registerComponentPrototype (archetypeEntityName, componentEntityName, connectorIds, entityToStringRemote, stringToDataSlotsRemote, spawnedRemote)

	Register component  
		__Parameters__:  
			* archetypeEntityName :: string archetype name (e.g. 'decider-combinator')  
			* componentEntityName :: string component name (e.g. 'decider-combinator-component')  
			* connectorIds :: TODO REMOVE  
			* entityToStringRemote :: { interface :: string, method :: string }   
			* stringToDataSlotsRemote :: { interface :: string, method :: string }   
			* spawnedRemote :: { interface :: string, method :: string }   
			
# STRING BUILDING API

* Composite-Combinators-Core->strBuilderBegin (identifier, combinatorPrototypeName)
* Composite-Combinators-Core->strBuilderAddComponent (identifier, prototypeName, position, direction, componentString, virtualUnitId)
* Composite-Combinators-Core->strBuilderAddConnection (identifier, virtualUnitId1, virtualUnitId2, connector1, connector2, wire)
* Composite-Combinators-Core->strBuilderCompileAndClose (identifier)
* Composite-Combinators-Core->strBuilderClose (identifier)

# ADVANCED API

* Composite-Combinators-Core->changeLayout (combinatorId)
* Composite-Combinators-Core->refreshDataStorageSlots (combinatorId)
* Composite-Combinators-Core->getComponentEntityId (combinatorId, componentId)
* Composite-Combinators-Core->getComponentPrototype (componentOrArchetypeName)
