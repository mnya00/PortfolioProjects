--select*
--from PortfolioProject..['covid deaths']
--order by 3,4

--select*
--from PortfolioProject..['covid vaccinations']
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..covidDeaths
order by 1,2

--looking at Total cases vs Total deaths
-- shows likelihood of dying if you contract covid in a particular country

select location, date, total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..covidDeaths
order by 1,2

select location, date, total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..covidDeaths
where location like '%erman%'
order by 1,2

--looking at Total cases vs Population
--Shows what percentage of population got Covid

select location, date, total_cases, population,(total_cases/population)*100 as InfectionPercentage
from PortfolioProject..covidDeaths
where location like '%erman%'
order by 1,2

--Looking at countries with highest infection rate compared to population

select location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 as InfectionPercentage
from PortfolioProject..covidDeaths
GROUP BY location, population
order by InfectionPercentage desc

--showing countries with highest death count per population

Select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

--breakdown by continent
--showing continents with the highest death count per population

Select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


--Global numbers

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from PortfolioProject..covidDeaths
where continent is not null
order by 1,2

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from PortfolioProject..covidDeaths
where continent is not null
group by date
order by 1,2


--Looking at total population vs vaccinations


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

--Looking at Total population vs increasing sum of vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert (bigint, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingCountofVaccinations
from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3


--Use CTE

with Popvsvac (continent, location, date, population, new_vaccinations, RollingCountofVaccinations)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert (bigint, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingCountofVaccinations
from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
)
select*, (RollingCountofVaccinations/population)*100
from Popvsvac

--temp table

drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingCountofVaccinations numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert (bigint, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingCountofVaccinations
from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null

select*, (RollingCountofVaccinations/population)*100
from #PercentPopulationVaccinated


--creating view to store data for later visualizations

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert (bigint, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingCountofVaccinations
from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null



create view HighestDeathperContinent as
Select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent is not null
group by continent
--order by TotalDeathCount desc


create view HighestDeathperCountry as
Select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent is not null
group by location

create view HighestInfectionperCountry as
select location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 as InfectionPercentage
from PortfolioProject..covidDeaths
GROUP BY location, population

create view PercentageInfectionsGermany as
select location, date, total_cases, population,(total_cases/population)*100 as InfectionPercentage
from PortfolioProject..covidDeaths
where location like '%erman%'
--order by 1,2

