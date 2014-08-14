# ratemap.R
# Author: dnaeye (https://github.com/dnaeye)
# Version: 1.0
# Created: 8/14/2014
# main mapping function

ratemap <- function(data, color){
    
    # create a dataframe of coordinates for the shape of each state
    states_map <-map_data("state")
    
    # create dataframe of geographic centers of each state
    cnames <- aggregate(cbind(long, lat) ~ region, data=states_map, FUN=function(x)mean(range(x)))
    cnames <- cnames[-8,]
    
    # create vector of relevant state abbreviations
    state.abb <- subset(state.abb, !state.abb %in% c("AK","HI"))
    
    # replace region column name with state
    names(cnames)[names(cnames)=='region'] <- 'state'
    
    # add state abbreviations to cnames dataframe
    cnames <- cbind(state.abb, cnames)
    
    # change state.abb column name to abb
    names(cnames)[names(cnames)=='state.abb'] <- 'abb'
    
    # creates vector of values for the fill parameter, which fills each
    # state with a color intensity based on its crime rate
    values <- data[,2]
    
    # plot choropleth based on dataframe created by user input
    ggplot(data, aes(map_id = state), environment = environment()) +
        geom_map(aes(fill = values), map = states_map) +
        expand_limits(x = states_map$long, y = states_map$lat) +
        # legend customization to be prettier
        theme(legend.position="bottom",
              axis.ticks=element_blank(),
              axis.title=element_blank(),
              axis.text=element_blank(),
              panel.grid=element_blank(),
              panel.background=element_rect(fill='white')) +
        scale_fill_gradient(low="white", high=color, name='Per 100,000 People') +
        guides(fill=guide_colorbar(barwidth=10, barheight=.5)) +
        # adds state abbreviations as labels onto map using GPS coordinates
        # from cnames
        geom_text(data=cnames, aes(long, lat, label=abb), size=3)
}
