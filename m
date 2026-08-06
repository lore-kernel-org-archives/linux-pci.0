Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43398834;
	Thu,  6 Aug 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041371; cv=fail; b=l3MTFBEHI+CrLQaEGMh26dBHcaMYNErV/v89tfWjNE94ucFCLWVmb8LKqllF07lx7LoBxrWqyL/ZPQsX5t9ahKcZ4n6KOIOsadRUZDKZMwwYNGegHatuBxigWbTxGEhrJf3KslJlK92dDf9SPPbR+qzTCuLE7mLcO0TgZMso38U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041371; c=relaxed/simple;
	bh=unhbHpeeWVYbBYE+ovUtVv5R3hiriMFAUNayDK8KcqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Or5tb8bdcq77s0Fam9mMNRmDeFwrZvoHvFBHrTTS0ILUqUWHeLyOyZqqCuI+APLXDhKxWCVIOhIMWYxVAPg6EUTd+2vbp/wfjZS+CLmNZ/s65M+fkFticKqmzMpKakjhuXM5FrN8SVLdbeog60cvoI1vWaagngOchmOHki5Dq3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GyQvR1fx; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GyQvR1fx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDHz8pDQjMR9qTFOzHgQvUOSNhR+R/a691eJzPoxmAlwiMf/zG19kkkcKYIY+aE9CPPGV5mnPwMzxuqIZe9LRk2Pk6lVl9xSVpp5OKu+Eg9kuQdaqQ4PHTf1cCKzoggLt8LpELlupLiSmgR1+GcCTj0yZqGD1l0xrDBVk+oAzG14jhQO0UemBJrCn+lMFZ/YHz66Yl2sROiiKRM7aE9TlR+pj8oGhg/S4qbJwaypqJh1yzzknJCnnm9P7PWpVlmeIXz89SViFzPEuGTy9bgDVdJVI3LqTfbqOMcmGobMimkQ785RyL5WM038eLgqyZAG5e2C7EvcsAbIJWYg593Z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZM1hYaXWLiWR6tI9ukCGyhLihmmYfHs7ZcRDQEerBA=;
 b=PNUxOeQ8W1DRHhpaqcXf92tXzCBxjtzlR5ZVFmB/ivdzJljRou0LUZzvumx0o1/0Ml5q7D3pqrL3An1NZ4fvOH/kn2fS1l/nKujWtp+rZp+o3q1VsBYTQhl2dISs9Hgo4MwWO+AiSytOZ5vJeBhNSwQUgBOBMu6t4DCK+DzrIpe2V9b8ZxaHSLU5LENX/Z1/2Eu3zti4MwTPU2iBgpyHZ7fWqIqpdQP/hju5MpY2Bvew1cj/D9LyU/2tQT/AW+bYgdi8l5YC44xc8v/l8GT0znjpk6pOGtMe6fff4axfbqEYB2t+ZD89nnfv8hgOzi9jefK8d/xCzklluZaRitYdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZM1hYaXWLiWR6tI9ukCGyhLihmmYfHs7ZcRDQEerBA=;
 b=GyQvR1fxovhhKdGeVQIiVUbK/kgKEwqVau3CO36PWCRzUrsPq5qYh61a756lOct1bUPTVroYdTh40uhJbb3P4WVwFAePhKyFaV49m1wKdC58GWVyEZH5Jf2rsApSKzPMaUJzZnO4Rtobu+MYSgeBMkGCRMHhHx9ov6JWOnhYQicNwa2s3Y1eMuUfhoKxsif0lfxOsqLIUyoHX18GXSl4TGNQAdJ5tsjM8dNLEE1DJnR/kNKdbxSsagX89WoElZlwr31skI8VrZsTEzKHeMI3d+pXlIe9+dYyJeECsw2WQ6jCyD7YtHunVA9tXQ673B6+V7Zp+mDWFredCQMBGdF19Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:36:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:36:04 +0000
Date: Thu, 6 Aug 2026 14:35:57 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs
Message-ID: <anTUDdTR_e92IFun@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-10-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-10-adrian.hunter@intel.com>
X-ClientProxiedBy: SA9PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:806:28::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b1be84-993a-4de0-490a-08def3e9922a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	wbOljKC1ddmvwEquF8N4cAJoQJfoTU4LkUEjNGURMLeoJ1egYn2UEGst+RooCaSHohyBeVwetAmhk0oZoBNOrWiQINPnhclNXmhC2ZYZx5AGOvvAJDsLeR6RMGuw2lSTvN2Bjji3PdmkdBrYzzRD608zlewo0zyBYfnZSWyQ9HKG6vyfu500fGvwvKFlGaynup7XgyTriUnVVegoi4FD5WHIpNW8V+0dptVD/lz0DHxOQEDz3sf05gpwMRtdDxdNJPgwioeYXhAVgWiiGiqC5BA7wr5ChAiA+XjxEwbOXW1QuITdZAjrsdFL4vRWq1A7TKri6tgFMI0Hl7BCMcp8mGuCHuNQLasSj8d2Slfe66243gzLr+VaSDNEAn29UpdT4u/X0OQ07aS445f4QRbT7MkWDY/5YrU+/5LFQo/DssrG1b69oYjJ/u1USfe8PMWAVZIAlxk7l0c+xPJbCHR5PTFP//3nfsHyHf/jBp7jlocpWQP18aT4txRYeOTD9arQrJOPsWMsxKs1lDTqvpLvTepXUTVD1WsSXD6iK9evuqmWolwLP9MhG3531WwgfFeJHQBTi0Xl9St2t0rWBqrBQkTpHDQh6LnXmX88jknavtqvs3iooOZBubB/gMzzoeeMZVxWi7sEpNg3yhhL9TcK3IBTr1EPAuy5z1vFZ9hT5Kg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6L1p4MOPZjmH3wk9UOwUzVPmOhD+5UufACHhGPn0p1pJiDO9yvbPVeL8eM8?=
 =?us-ascii?Q?jwZnYAHCdxEesKpTR//xNuaNsarukUcLTwvc6Y0AWj667bJC5+IR1suN4l0x?=
 =?us-ascii?Q?JyCKRzmGLGh2o6eP45m8nIPvsjj98uXQJIHxR3wkq5VnJHoq646rAJ7aXQ0g?=
 =?us-ascii?Q?+VSayLFL7/HIFI0lJx+uqYepTvz1ltyXG0hwZuhPWmH5Gw8691baNA3k3q0E?=
 =?us-ascii?Q?DPEsHx7zeoevsgQH1A+sUKWVUsJOf80DZGWuhhdM7HDnRcDOhDWg1CHDhFuh?=
 =?us-ascii?Q?UxGyGtLpwdCCw7I1UqoD/m308odwHX/ShYr3CZuryefnQvb49Axnl6NFDi6A?=
 =?us-ascii?Q?u0z7exVRKW+b9V0JPuACPMDK7+VjJBYZZq2VJHqFrFsVeO/SZuepJYMSudDc?=
 =?us-ascii?Q?HAplmDwOIGQmuTDfAt3O+QFR5aSY+4m/BcnI6bcOrys8Xe0Mwj1Bw8NZ0E9t?=
 =?us-ascii?Q?CcJ13pmEADXq8X4xFoNwUoE30pI/XgYCjV4a+641nbfF603FtgRbFcsIIbSB?=
 =?us-ascii?Q?Tfxd7nPQwFP7rVvbGNU3dJvQZDS3NVcPzfahvH6xGuBEHOKZhOVUqhkr43pS?=
 =?us-ascii?Q?2VVxUnAoientM43AfDi5xvgl7YfCNLExIxYtw1gyt66pNrFXxDOOlYnNYgRG?=
 =?us-ascii?Q?jSR2VEw7cw5RJnDR4KTd4aXm5XBLJVG1dPmXE0m0aOuy2g9OGSdA6DCaefwK?=
 =?us-ascii?Q?Oc6Hik6yDwxj9VEU0+nsZP1XLPBviUdwPd8U3P68X2RSD3HtEGh7uFqVRJPK?=
 =?us-ascii?Q?CHlVVqgbAvp/87oBP+JBgviBkugFuC/UsgkgNsnbWw84mzi04MO0xhoQrpi2?=
 =?us-ascii?Q?tQvlDI8vAip3X3iwJgs0l5wolt1FKuauWXha4Zit4Q6P+Jg1QzVBzJvzdVE+?=
 =?us-ascii?Q?+y+hGoAhcfEIEvLMd0XUBcf7RvyorIaWmgGT+lyeAFAoF4SMYnouv5MD0ruE?=
 =?us-ascii?Q?q5WMk9CyQXQGzZgPyBzv36pyF8SRyN1HtWLDOvEsCSZv1oYLn/yn9lkMAv0X?=
 =?us-ascii?Q?Vmuxss/PdJuGH7AK860IIwYCu+wwUqFo/ASV0HZtjunXKcgjNd3gQ6jlFShc?=
 =?us-ascii?Q?zJuEEuCwrCx0FAedBb7QsMzsQFmmYMaLZ29r+Ph18uzNY6yk2foDnP4Rx2fJ?=
 =?us-ascii?Q?+nofwDeo0UWVgwc9qu5RBmERfdbFN9puxU9mSlAztsYMopy+vTaYkq5DRf3k?=
 =?us-ascii?Q?hmu3DDH3l/gDI08AIs4MDZCykAkouskcTTc0DTjesb0UpKi5PaumtRMQiNZl?=
 =?us-ascii?Q?gXKkiOLVUsfyZ/f9Dwhxls9/s3m6FTwGDSQjw6/y+osyk9tqAJ4re2a7JURj?=
 =?us-ascii?Q?2ZtV98Obe5guG16m2aERM5Idx8FTG9EHaQKqwqPOl+Pjmq0pyluSNs4SMBja?=
 =?us-ascii?Q?bQRt5rGj4M+y5dm4EPnAsNI/lTo2RetG3XwSSB/SRwbk2BM3H/X9PlkDn1br?=
 =?us-ascii?Q?kJINKvrxHzZHte88dI9SZeUECkNXXNw1o/RmFX3uZTxjXwAl8Z/HAV+3XT4l?=
 =?us-ascii?Q?v0lfZJLu1NU7UerNoAFXOtx3n2ALR3xxpNyKj+gr4ORQ8ignXgYe3+7O8BI6?=
 =?us-ascii?Q?QWO7B0qg4QULZdU5WjzMH8lf8MPUjN2ikBpHXd60kM4u6la8b0fOc26IUnGy?=
 =?us-ascii?Q?1Cc3dAtp3hrADmsBLwyYYZ2niNWM86mqG4PswcsvcYMnYa1kOzcEzIr5dFBu?=
 =?us-ascii?Q?M/MZbOhvDS05od8SIY+pmPsMaIW7lzEWrh3PPWB9KxYPq3qXGu92RNbkVnhO?=
 =?us-ascii?Q?92VKTJKObB3dtscDdB6r1fgM+4pL7zphilOuDrRVGEneum1lAvbg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b1be84-993a-4de0-490a-08def3e9922a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:36:03.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DTxvxn78U8v1XSLQD0kYgFmOBbf56ru2YXLaPPJgCFMFyCtn6nwbzzHiirktDRfgB5vtCwOJPwunLDUBHKV9fUbw7Lq4FtWiGB5nZ+pRvhr+1vetO+7WfSZjGcSxZqk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

On Thu, Aug 06, 2026 at 04:18:52PM +0300, Adrian Hunter wrote:
> An I3C device configured as a wakeup source can wake the system by
> generating an In-Band Interrupt (IBI).
>
> When an IBI is queued for processing, record a wakeup event for the
> device if wakeup is enabled.  Use a 100 ms processing interval to give
> the I3C device driver time to process the IBI.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	None
>
> Changes in V2 and V3:
>
> 	None
>
>
>  drivers/i3c/master.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 2616354dbe54..6c5341491944 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -3384,6 +3384,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>  	}
>  }
>
> +/* Approximate time for IBI handler to run */
> +#define I3C_WAKEUP_PROCESSING_TIME_MS 100
> +
>  /**
>   * i3c_master_queue_ibi() - Queue an IBI
>   * @dev: the device this IBI is coming from
> @@ -3397,6 +3400,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>  	if (!dev->ibi || !slot)
>  		return;
>
> +	if (device_may_wakeup(&dev->dev->dev))
> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
> +
>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
>  }
> --
> 2.53.0
>
