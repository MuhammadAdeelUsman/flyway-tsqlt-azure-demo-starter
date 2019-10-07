/*Show advanced global configuration settings */
sp_configure 'show advanced options', 1
RECONFIGURE
GO


/** CLR enable option **/
/* By default clr enabled is disabled (0) */

-- Enable CLR 
sp_configure 'clr_enabled', 1
RECONFIGURE
GO
sp_configure 'clr enabled';
GO


/** CLR strict security option **/
/* By default strict security is enabled (1) */

-- Desable CLR strict security  
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE
GO
EXEC sp_configure 'clr strict security'
GO


-- Check CLR enabled & strict security status
EXEC sp_configure 'clr enabled';
GO
EXEC sp_configure 'clr strict security'
GO