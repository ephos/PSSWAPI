BeforeAll {
    Import-Module $PSScriptRoot/../src/PSSWAPI.psd1 -Force
}

Describe 'Get-SWAPIFilm' {
    Context 'When no parameters are passed' {
        BeforeAll {
            Mock -ModuleName PSSWAPI Get-SWAPIFilm {
                return @(
                    @{
                        'Title' = 'A New Hope'
                        'Episode' = 4
                        'Opening Crawl' = 'It is a period of civil war.…'
                        'Director' = 'George Lucas'
                        'Release Date' = '1977-05-25'
                    }
                    @{
                        'Title' = 'The Empire Strikes Back'
                        'Episode' = 5
                        'Opening Crawl' = 'It is a dark time for the…'
                        'Director' = 'Irvin Kershner'
                        'Release Date' = '1980-05-17'
                    }
                )
            }
            $result = Get-SWAPIFilm
        }

        It 'Returns more than 1 movie' {
            ($result | Measure-Object).Count | Should -BeGreaterThan 1
        }
    }

    Context 'When "Title" parameter is passed' {
        BeforeAll {
            Mock -ModuleName PSSWAPI Get-SWAPIFilm -Verifiable -ParameterFilter { $Title -eq 'The Empire Strikes Back' } {
                return @(
                    @{
                        'Title' = 'The Empire Strikes Back'
                        'Episode' = 5
                        'Opening Crawl' = 'It is a dark time for the…'
                        'Director' = 'Irvin Kershner'
                        'Release Date' = '1980-05-17'
                    }
                )
            }
            $result = Get-SWAPIFilm -Title 'The Empire Strikes Back'
        }

        It 'Returns more than 1 movie' {
            ($result | Measure-Object).Count | Should -Be 1
        }

        It 'Returns the movie matching the title' {
            $result.Title | Should -Be 'The Empire Strikes Back'
        }
    }
}
