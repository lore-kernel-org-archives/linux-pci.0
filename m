Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793349392;
	b=V5m4ntIQkhNDKOBSNqtaYP2Q8GdsGA1S0IiYdHjUSM0YeQHqyGafkdFYKQkUKvwoafRB
	 Yjrceegeud4uslXOk1bjubmCKzqp7pRLn09MqQIKyU9gFyF5K0LQ7Sa9ilp3RFdBz4Q+o
	 D2T61xgcWzcM7EhIw01vpFoSKLK86hO8szQK970kyTPAqghS67cNEDaorXWu+UWg0Ulvc
	 Pj+DANPzHBdBhBZ9QdRJcwq8CCTeX9n/FkU7aycss+/4WsRMpDysbu1UivPBW9Lq6liP9
	 4tsX29DrfJhDvC+czgjeXP7kCjvqTVqz4q6ZBCiSFOGZcYFe3cHGFt4lRxxTGBHvz4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349392;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qlNE7SOOEfmF0k7hNyTtBWE4H7TMa7AeS/GDWIKc/bM=;
	b=VzGxChtqbJV/39KY08/fmwx+HRhcTGhzt0OjSKrUCe7G2LSmQOmt7ASN8BGWBSs/+viF
	 h095Qgs4y6IA4sfgUhEvhZS1o0uOTWkWq3yRl7aHFtQf8JEDjl/XFHVPouRx8sAkuOFpH
	 EPbA3MUmTl+EigldmssC1DIaOdP7jSoM0vW5OtwAMI0wQda4iiUf8zLwsXv8K78CaYaT6
	 h972TIRdMbooiXVtkoDqNv5c7er5EveQfY0JwAKeSqEysZP2VF8ssH+emHExAyNnPRIO+
	 ygNLX78ZUl/bm23CHSh2ELHA0rAp8wK6b6dUBZ2tOPtxRsFbr3YD5hXnU6xO2FbpWjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N3Rt3T9S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F6606A324;
	Fri, 30 Oct 2026 08:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943F6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N3Rt3T9S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmOWFYLPGG24Lu112GARhRWmC33WJGK5V5XrvXFRN5LkJa+//nIJ8Q1vDjsjp3I5g9LxoZDulzoyKuH9sX90zUpQdGPEMmJaomZMu4+0btVQLz2b/+kR9+jf8Dt3AOV9cJpecZAUBDds/yFDxTh/Eu0mLtl32yc95F4XHvbNxufo2kgOuXN/XvDO5Kdk3X4Joe8bbTQQ/joyqTni1R6i5yZgOfWY8xD0kASPaqNsA58VDWa7BWYE9g+A/9HbX/EDz5NK5myKyJG2V7yVs8BwjhGG8n+KPTM+DCESI7iSx+U3fLSjbgqpQqH3tMWcT3phAzqTxrlKfxEVwEEvX4PcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlNE7SOOEfmF0k7hNyTtBWE4H7TMa7AeS/GDWIKc/bM=;
 b=QJeVcgZeWlpX564rOr4kGYI3Cj8B8+bwjWokOkCWXKmeAZHDPmGj1VoHWHqEkfbxwVPdO4fd44hT0x64Djd8kVbouQ9UvZSefhFkrsp0vevSPxUccqkcmAgqT8Ayetsrv0YBhudW7CKxsVxJ5GKeuScxQ09AWk1xbmrGfXXcHidzqGv8MJySMt7O0VITonrNjNpXjbzlv4GZ8KQ7GAb4RId/G+31NjMuxlV4kAhLBDnww1EplniMZZFoDCSoIGOkHKH9Dt0JEqYWv9bQxR/bSD2Wa6JQxH0p7tVT3abJsXD9HB5YIc7DF+Q/4iFvnV428FXNXC/4QkV2P68+bUs/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlNE7SOOEfmF0k7hNyTtBWE4H7TMa7AeS/GDWIKc/bM=;
 b=N3Rt3T9S6+Sn7g4ZtgeklNAXItzQTzpULz+wNajqHwUY8yrzOvW18lvkffTsBmszoWXN8ope0OJHvobugdyV+L9H7mIsOZtDPWcWlXWiAPaj5EprGfLcG1EHhmAkZuwE9mACKLb0HfcuLBLYNuOjxCDO0urr/F11wlnWfg6cOKITTxmoKtw8xkIsdZ2skXeopw7LL770j1kXZM0VyTF87xdg+IabY2RtHa8xXVhvp1NOm4lfqHMBx5X0sPOqafFTQJaBseGPyA3IWyhw0Fp34AcVUA7wiL0P/tfQZU1WBPjQmSkMGLHvt/2ydMWMS2IW5hybmVigpwS6lqvv95S2Jg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:36:27 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:36:27 +0000
Date: Fri, 30 Oct 2026 16:36:22 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 16/18] PCI/CXL: Expose CXL Reset as a PCI reset method
Message-ID: <auRW9pgDBzcUFn2h@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-17-smadhavan@nvidia.com>
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f31bdc-f05c-458d-ae65-08df3660e328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|261026121527099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	I9PbuvDN8ou1r+iXWCJqDJ62xcKOgjV2REEE6MS9I9zp4KWq2DV3Jn4SJYz8ruIMM7BZoRMj2j61tRRJWYxYhb3ncihz/Squ+S2wiwoM8UwBHWMjmdlCoOJMao28VnCfqSY6vnxTXjKM3p14w61md4SLMl3WEUMW7xwalVze3zq81WYaOF3aDTW+VTYeV+9rFCvFOjY5LfNuq5Z2LV93cDuzFbp/iEROML/PiU7uAdUtRz9dBaIduz14C6/Mxk+gbVTvsE8vNL0zkZ2XJjIcePcdJDxD/3q76InkXuAd6RlqIx+lePF1MEStI6gA5DzSXH8jxVtH3N8ctSWWL9XKzZFD2nLKYKzd2colOYM3/zZzL1Mb7kLImGG60EKSONaQXt4XAO+4nLr2SH/BzNk3aKJ6kfDT3317SRC4VqUgFXF0o12K8MqwhkGXdZt2TzsPshcxEvm1cJYaJGAb1ph9LU3QCAJaerdNpo1FTckTTgBivl7u9lVrqs3W5ezTqGCa687tl6soL8e8JR6OfdmALnCAEg6fG+duGZNw/yekyiF6VGvMBagDZfGmxVOtxok0UWic3uMzYTpzRihO18z4OBosCe7OohMW2l8JmzUhkZwfelK2JvJrvsRxQ+pJBS+iVcE6ATVWog2ZeuOcjk3dvUB3M4Woiau/E/OU2q26PLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsX8ety4Fdx4qtZkeCxm5OtnpU7G37E2pgpGZKNEJAzXmtkc65iC+qFWTSMH?=
 =?us-ascii?Q?KNhGeXcU0OifS2gf/KgCMDuzI9PEljql5VYd4l9jdDLpFW7CAJPAIopAdq8O?=
 =?us-ascii?Q?nXw3npvZSXmuy7Wer4dR2sCCdG86uIB0VwfnHQy55IKDDWirKYBLMCsjCLX5?=
 =?us-ascii?Q?E5fXgxJmlEBsQ+zKeNu+pD+v9MjHj7hJjLVdTIrwu4SqnIi3tZF3dq8eXRhH?=
 =?us-ascii?Q?74nwVbMipRSRLEfI3voMSvDcELqDuaR2YnyWTMeKaEIVRud7mCMJqnXdvARA?=
 =?us-ascii?Q?JGlHMJ0BCPl0gdn1aEknZNdD5JzwRFYqVuMzhw98XVavwaEqJbJZf8CmgE/d?=
 =?us-ascii?Q?k9dHVL7ALZuFl6CTnjzrItYJIVuhS/FFE9yixjzrQhGjdnEdmiolH7MtB9W+?=
 =?us-ascii?Q?G2FgU2VG4VtHCnoDUoxLtDuMCelFtJlOvQ+c25mr3iZhgCTxHG7gp7FfAMDz?=
 =?us-ascii?Q?4oAqfEQfUfwond/hdfMbU/4ebYoSlOQ7wnZaIbAixLyBjRZrdAhRUiV3f8UO?=
 =?us-ascii?Q?JhwjffZcgfHq7r1GZV1lrvGcvjsyF3kDBcYATRnPiOucpUqQItNWyUByyhPO?=
 =?us-ascii?Q?7KHSjUnZQFUcB9cAc5RaXEurOU+Tp89SPc8+6KbPm2TAegEPGSELsYfU9NY8?=
 =?us-ascii?Q?F5WsVxc1AK08nXwwLSddaINZP56pqonkULALwpWHdQd4pTOMEdqZRf4a5X00?=
 =?us-ascii?Q?euuOSgMBLP/ZyB2Ph59Pc9Zd0b+ExQMkbH+m8C+B32pJBHMBiE33fge/qELc?=
 =?us-ascii?Q?pjHT6G6ap71mhxTZeax3wiVjBbJ7gHnDZIhNoC0EcHfA2FHASQJbkieYDr9A?=
 =?us-ascii?Q?d/Ua8iS3h8QDFlOz06guB3jdq3T6/ym6z5V4iUQga53eNi+pViGH28T2/sJM?=
 =?us-ascii?Q?A92H5XPwQFv+/3y0rPgO/oP6y+S8yUHuYNWKxOPvfs2djT8G7yth5/3rf1mQ?=
 =?us-ascii?Q?FLrZl856euVgYmXjqyeDV2btkP0jR2MRtIbFPcKvcTQov6E9HNnXiH+tn8ub?=
 =?us-ascii?Q?FdyY4E8er2tjOvICaQDheQJ8Go7eonP+St3kWibdDRD0dQ4VspUZWY+D/Zaz?=
 =?us-ascii?Q?ETvmaA+aMRka/apMkmX6CEyB1zwnF4Tk6tVuqAQzRDyVdW3mAY3crRaXVqYZ?=
 =?us-ascii?Q?M24DjufdqqTcNSxmXT4daDqfvEgGTG5/8AnVf0v1avK87xl+yjEryrMr+8Q3?=
 =?us-ascii?Q?fHbrpafMPXbU9DbvsyjInb69ttTgjWmcup+ZCMZi03aU5GfSOifplcXuxTbp?=
 =?us-ascii?Q?2Wup53cY6NQcc78kVmsw0LEGw4to17EM41+pfALL2HNpSCkaroihtalfSI0B?=
 =?us-ascii?Q?IStHhmdm6Diq7TGEl830qz1utOvxB1/6YBqjgnHZUlNZRqfeGircrAcYuFvu?=
 =?us-ascii?Q?u+N5p29Wffh2FbB06nqapSSxnmll3PlOIn131l01+n6qMsSkY3SMQoOtQckA?=
 =?us-ascii?Q?MG9XAz/CSsCqepiij6WcEUFnCpl7UxxLWsr3doV/ONiMncmWYixe7NSy3JoG?=
 =?us-ascii?Q?ybiSKUxhtsdLX7llliWLeiZP1Fy4pYhb1wtZIit2ffQmp3dFnPsCYaqNyjty?=
 =?us-ascii?Q?TlIoYhxReB8XGdx+BWr7TqE1SifNQOuqbAJf64Knbg7dxkbIIfR5FG9B2+KB?=
 =?us-ascii?Q?ZuQuAVc0cOUXX6/afSnQSTJQ+t7grWZnLsWnn8wFus11jMkMBviC2jWIpMX7?=
 =?us-ascii?Q?3xSjVBpOQHLvT0a5jV91a7Z/vxKP/DHbUXEl4D+t7vB5zO/l9Mt+KyFnCMV1?=
 =?us-ascii?Q?JRUB8dyJig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f31bdc-f05c-458d-ae65-08df3660e328
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:36:27.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyhlpdQmDaiXJF5mS4ZSeQ5+AdwMNWmzDtjSHumIOzPSNEFCo23OngIzunuASPHASajxNTSSW4lnHWcUa1KV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On Thu, Oct 29, 2026 at 02:57:01PM +0800, Srirangan Madhavan wrote:
> Register cxl_reset with the PCI reset-method interface and place it before
> FLR, which does not reset CXL.cache or CXL.mem protocol state.
> 
> Return -ENOTTY when device capabilities, function scope, cached HDM state,
> or required cache synchronization do not permit a safe reset.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/pci/cxl.c   | 12 +++++++++---
>  drivers/pci/pci.c   |  1 +
>  include/linux/pci.h |  2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 58bbd5b47539..0c4ac0832b34 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -672,7 +672,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
>  	if (rc)
> -		return rc;
> +		return probe ? -ENOTTY : rc;
>  	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>  	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> @@ -681,9 +681,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
>  	if (PCI_POSSIBLE_ERROR(ctrl))
> -		return -ENODEV;
> +		return probe ? -ENOTTY : -ENODEV;
>  	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
> @@ -706,5 +706,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
>  		return -ENOTTY;
>  
> +	/* Raw reset callers may not have saved the PCI state needed for restore. */
> +	if (!pdev->state_saved) {
> +		pci_err(pdev, "CXL reset requires saved PCI state\n");
> +		return -EINVAL;
> +	}
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9031060423cc..f5990d6cc51b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5148,6 +5148,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ },
>  	{ pci_dev_specific_reset, .name = "device_specific" },
>  	{ pci_dev_acpi_reset, .name = "acpi" },
> +	{ cxl_reset_function, .name = "cxl_reset" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7bb37fcb556d..743b57ff885a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -52,7 +52,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> -- 
> 2.43.0
> 
