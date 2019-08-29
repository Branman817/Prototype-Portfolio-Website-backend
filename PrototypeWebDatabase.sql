USE [Employee]
GO
/****** Object:  Table [dbo].[EmployeeMaster]    Script Date: 8/28/2019 9:45:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeMaster](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[LoginName] [varchar](50) NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[IsApproved] [int] NULL,
	[Status] [int] NULL,
	[TotalCnt] [int] NULL,
 CONSTRAINT [PK_EmployeeMaster] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Usp_Login]    Script Date: 8/28/2019 9:45:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE proc [dbo].[Usp_Login]
	@UserName varchar(50)='',
	@Password varchar(50)=''
	as begin
		declare @UserId int=0, @TotalCnt int =0
		select @UserId=UserId, @TotalCnt=TotalCnt from EmployeeMaster um
		where LoginName=@UserName and Password=@Password and Status IN (3) and IsApproved=1
		if(@TotalCnt>=5)
		begin
			select 0 UserId,'' Username,'' LoginName,'' Password,'' Email,
			0 isApproved, -1 Status
		end
		if(@UserId>0)
		begin
			select UserId, UserName, LoginName, Password, Email, IsApproved, Status
			from EmployeeMaster
			where UserId=@UserId
		end
		else
		begin
			Update EmployeeMaster set @TotalCnt = @TotalCnt+1
			where LoginName=@UserName and Status=1 and IsApproved=1
			select 0 UserId,'' Username,'' LoginName,'' Password,'' Email,
			0 isApproved, 0 Status
		end
	end
GO
