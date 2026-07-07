Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F522301;
	Tue,  7 Jul 2026 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388060; cv=fail; b=eFVeqmotiPQ6FQO74vMetuRfc4Npva4rRRWIS7Usu4dTBLLEnXcIqoaItP4G4XwBEJXz65jHC3EzwNrywaHpBEu2ONLiJhiE4bZ78/upXItAQPwaTvqzsuLJKD2He2GFQh2Grb72E1ok+TVERSKZUxDlMxsdjg4xKkFtRWjnI4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388060; c=relaxed/simple;
	bh=UdQGjSc+wgfurB4ErII1Ouo3ge4z11pFoNmFetzFflE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgWkDtEyp5+U1xjX31hCAHQiyQBPf5M7Nqd0X6WpInwVkjjND4OV61VISJ/HJFpfjzRtFUDC/37AYFf0/YRkoNV0iM9o1zXGlSr4ymKYJlLwaDBZ2p12ndV0+uTOC0Au4uygGWVDsOzZDAtlUYtdx8tkIfQj87z7pfm0xYliJKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rPmIYUSL; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rPmIYUSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGZhfTwdYXGpOAXDrG67zaKwlxStZU+cijixKKnXFmK1wtPCaBt0e4fkYeFmLbBrCmkxDpOuZJWAAyEWsSPMIdeVudcCU/xiR/IZEhG523COaPaEdvYs+7SQeOvZyrrGL6S+TTiJPHOHMRMH9S/oCB3R82rir4M51YCG0vVSM0IHoPTmOTNXPnPnSaswvMG6lq1WIjNGLmSl4CcJtsF0w/9yF6clQf8GE7IGf1317v0T2WwDY9IvUiZuxgoqiZgmed3bb0Loe8z08YrvwCjDl8hYrAmXk4hsw2zZRBNWlZ3XAf0s8uk1uYuLqyMZ8CoXsho5gDF8eX0P3EWWQlCLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdMpi37f11Ej/GQLai3g1nvyt82su2qjDUZ3bVQpi3Y=;
 b=lPoHnMv82vi15RYecN4RX7+YvC/0ZKmNDirqCX7VwaXKNxh9rbPNGKV0jgPIILMo30Tp5SO4sdFAsSxP6cNmI2kTE4nIgSaYQLiPzO64XDQBIla1jj43JzTep/deFzSo/7PMPS1Tnl4/SH/3ygOjthUEhFwYCmBOGxk3bhT5+qsk1RTb0UmbHz6eFAuljb7A8ych09xvhM0+2CHcLL1vGgzrNjZb2K0YXe75M9W6E8cuyBppBLz1U9Bk60fAtLf0yr4Zda49Vnjwzf1ktX9VbUNV+Dh53hkMRx5iYGnk6JgsNB/icvyRaM+057HxIBcDnU698k4rNG8oBX2juE2ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdMpi37f11Ej/GQLai3g1nvyt82su2qjDUZ3bVQpi3Y=;
 b=rPmIYUSLECEuy9AdPZhyURf2RPouUZIqaz7yCzoQHODHDWB0HzqBGXb09lR7n8LFZkPFyMy0ivVBB1uOLXmeL65KKGNnzYCe9Vi/p3e6BlUzAtWpqeMidGqLeg6o3MtUAQthlRBZ5JKvlpgz4g4BdDEJ7SVK4jbyidCUSRHcXXX4iTAemIpdBwQeUj3kEzIrIV2DcCesaXfbksbOKT2OKUhBWADSGkbwpnBOpNQYYIWWBSezK94oy3xj7/0+Gg8c6UKHSOqUC4xkr5GDXtqSn9aveat8ol3GllsacwQPTDFjcRH9yRsW31fKYMKm/trT7NTG4NuGeo3XgHC1J+1Dcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 01:34:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 01:34:12 +0000
Date: Tue, 7 Jul 2026 09:34:04 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 08/10] cxl: Restore CXL HDM state after PCI reset
Message-ID: <akxVmAKRCwVsKdAD@MWDK4CY14F>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703220508.546528-9-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aea7b5b-4128-4b8e-0e8c-08dedbc7d875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+jidC0TfR/cUJKZB2LeZmfxBJ4uhhoXAzOfkd2yRZE9tS9pJfbD9/klqBwa5YZCv04EoyK8kgTGNObjlgSV65iuzCMwNVUh9MpE+eBFwUTHxCEypiKrZCeyazMdrxY9HAZYMo6jsg13efaCPdiXd7sRFn/v/tt89HYmdabHrpJU5VsoL44CbOLN552gB5uXwlPxxnNdOfo1Hj39elIEb1jWZ7lSVTOZhI8SISkToXpW/pXZRm80EgSTKTtj+irZBx4vnsZKTwHHuzWUK1oZwdGpyyOZIonij6sK/DRqvF/spQ34ayPBSUrQS4L/OvyOvuuSXBMZ4o23pu681DGnZ2kuKhiOf8u0bPHtbqZkX8h8MY3+G/z/JWLwI2BO+J9C/ATQDyTS7B90ihXGwzSpZhjxUb9qOPHIaZmxAnQ05wcRwMz2joWMGLxju7499hEpj3LYzJk9XeARF5kP9umCSqvQCDafVKpxAyDM2j6345DmKJOSq2S6LvY6MZq6U8pB69Z1L9ov7mdTo889Tmp9r3e8LxnqZlWvAOzVn7Mk/RNOLrnjQHcTpOi0CK+K5Qokdv83Eq1a3gmlX25QtCOjm70duSMnbBtjfxpGkuhWPKCT6mFcI6Usy5yYY9N0wTzbRCJDU00LNcCZw4zhgzbfBU+E2pjVLnjdA+RL06jHIcvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPW7i0C/pp1Mhj+A9CUgnV4fz9onwv4V88nmp86i54uWXv8GXsRJydPCNlpk?=
 =?us-ascii?Q?UNitx+rz0eODrabN1PKXemm9LDWoiADZbPsUT34g5IOTeaZWLwo2RaPDaY2E?=
 =?us-ascii?Q?IrEjwwgc8tYJzZiPLbOjWc68VCXDr8adsGbvwpZOg3DEcms2sNQqKw/d300z?=
 =?us-ascii?Q?dMUdmRlZt+ukG70xNx+pbphH8EjD5lOM2BQXHuJ6o8EMnaw8CN2JPRPb9xuP?=
 =?us-ascii?Q?MGslUBSDeK0hMFfSWWNoVQ5YYIvwfNznVRx8CZAD4fZdl+aKs2be57rFiSn/?=
 =?us-ascii?Q?tprPlAgyw4lk4bi0T+dx/xODUaFuGiAv/43im2O8pqdfcu00/pZR9hwaNcLJ?=
 =?us-ascii?Q?ojCifaaSku+D103GCtkZUNIqHNH9AGHYBu2Q5jtd1wyMCdJRIL6eGWKi9RH/?=
 =?us-ascii?Q?oNRKCID53tWLwmxkjEwhwWAKpZR7FqAtXIontke2LXeOgAQBDGCRR/6BldIT?=
 =?us-ascii?Q?fYx+0gE/CuTDac+AC4QH9VlvPUw0dEHSd8Y3WoVE/m0R3GRP9LvuoXr5krtM?=
 =?us-ascii?Q?L0fbx07JlAlnVMHhSf4y5sevAVHomYGcWZrILzIww33NbQe6yiZ7dITQit/D?=
 =?us-ascii?Q?5hqq+OSWnCGBE5IJKmOW79MuPCHKjAiIdycUYEtuFJWyFJcwdMKcW/Pao1LX?=
 =?us-ascii?Q?3aIDHoaz4oy4nnFSuqAyVUtBNrH1UUEO+d4tFUCskC4myLuyHRV6UkXFT7VY?=
 =?us-ascii?Q?8YeMFhDnbPWNfhXVmvdCkf4rwv5qkVxt9AOpt9OvRplP4jpyRRvVREEuCXaM?=
 =?us-ascii?Q?nNCV4AzerqhEdC+CxLZmbX+nvpOQSfv2MPqww341BheLyr8c7Xjg9z6Vgofp?=
 =?us-ascii?Q?9Xm6ctzlhjJqRMixiYL/K8ZUMncck8KCYqpNzXsZA2QQWFyvUKolFv4ufTC6?=
 =?us-ascii?Q?LPUqXzmk2E9QO7aAQyZARJ6bi6DT68QKx9NcNCTkKPmO4u1lcvoGWP1dIsa0?=
 =?us-ascii?Q?zPhBvxJPkfobbK6Nz17UkcpqbOJbgnQy6I+iSlj0Q5a42V8wMGIsmmy7rXD2?=
 =?us-ascii?Q?3GHXJB95rqofeD1sXka8eHzOo6ROwN6m6K3737MiPwpyCscM4hgoV8Ii/Nmg?=
 =?us-ascii?Q?jmFerU1RDoFQclM/1bdBVxQZz+WF7X1JUxW7QfOLLaso7IoXnyqgZU3mZVnn?=
 =?us-ascii?Q?TbxWy2zwhiiYodj3YJIV2OdodXpHBDrk9pXJty0kFXFIE8MPb50iPaXSj0Mj?=
 =?us-ascii?Q?p0RruM6oz/YQfj0XSGApj02o782eH7vVjRJshe7uu3dl0kku//zah5uJJunz?=
 =?us-ascii?Q?eHhWzwtbX1+CqIh/44dsydj8iTgvl/CHEPcDZ4+Pi8DShsCojzZGzxqn3XFf?=
 =?us-ascii?Q?pxgXWPu919iTnyqMJDYR/7RipFJjoF6vbfSYdC9c2Xq+BTEBTZ5PBzo/LUeZ?=
 =?us-ascii?Q?/qDbdELiVplynX0xW2l5h2NLwnMaWA59Cxjr+uhpNx7Opk0HTWmc4mi41TmU?=
 =?us-ascii?Q?983Ci1TsvTikSMNlrxvEVhUzK/5k+dqRUzlvuvHU1nAi/8bBcd5+tVsYH64R?=
 =?us-ascii?Q?QNjRk8jQ+Al2sxvW5bO2dGAGjhxmxSR83u2s5cZlOcjhP7n8jlTllJVZJcpc?=
 =?us-ascii?Q?8h2NCjco+WlqY5g9ojirVLqW5vZR8CgYbo/R/QP3Tb7LWtV+t+YzFT/FHEXS?=
 =?us-ascii?Q?O7RbYzwOfO7yzvjyeK8SGAIBFWtYB7lSMscR/jo2hR0GM2x5fTCuzITXptk+?=
 =?us-ascii?Q?xJ/EULroDMSm0YSyCm95kBGAULIgvGdKInRvWEwtGYI1LveaL411mw6KqWvi?=
 =?us-ascii?Q?xs3gX/MkYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aea7b5b-4128-4b8e-0e8c-08dedbc7d875
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 01:34:12.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KidMOdLDiUV/5AxOBiCF1rb/J+7A6BpB6gk6gvSV1ox6Pxce5Vb+TRIfmIcxIwYkcBW1TFdm6GTDn2q9LoM0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

On Fri, Jul 03, 2026 at 10:05:06PM +0800, Srirangan Madhavan wrote:
> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
> 
> Keep the target IOMMU reset block active until HDM restore completes so
> Bus Master Enable cannot reopen DMA before decoder state is valid.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c   |   4 +
>  drivers/cxl/core/reset.c | 320 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 310 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a1ade846c9c..96f0de889073 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -137,6 +137,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		info->settings[cxld->id] = cxld->settings;
>  	else
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 8e80e7588046..cfb9b5101c28 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -83,6 +83,21 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> +static int cxld_await_uncommit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  			     void __iomem *hdm)
>  {
> @@ -92,6 +107,8 @@ static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  	u32 ctrl;
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
>  	cxld_set_interleave(settings, &ctrl);
>  	cxld_set_type(settings, &ctrl);
>  	base = settings->hpa_range.start;
> @@ -249,6 +266,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
>  	return hdm;
>  }
>  
> +static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
> +						 int bar,
> +						 resource_size_t offset,
> +						 resource_size_t size)
> +{
> +	resource_size_t hdm_start, bar_len;
> +	void __iomem *hdm;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
> +		return ERR_PTR(-EINVAL);
> +
> +	bar_len = pci_resource_len(pdev, bar);
> +	if (!bar_len || offset > bar_len || size > bar_len - offset)
> +		return ERR_PTR(-ENODEV);
> +
> +	hdm_start = pci_resource_start(pdev, bar) + offset;
> +	hdm = ioremap(hdm_start, size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
>  static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  					   void __iomem *hdm, int id)
>  {
> @@ -261,6 +303,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>  }
>  
> +static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
> +			      bool *restore_command)
> +{
> +	int rc;
> +
> +	*restore_command = false;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (*command & PCI_COMMAND_MEMORY)
> +		return 0;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   *command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*restore_command = true;
> +	return 0;
> +}
> +
> +static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
>  				    struct cxl_hdm_decoder_state *state,
>  				    struct cxl_decoder_settings *settings,
> @@ -455,6 +531,164 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>  		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>  }
>  
> +static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
> +				    int id, bool *locked_committed)
> +{
> +	u32 ctrl;
> +	int rc;
> +
> +	*locked_committed = false;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +			pci_dbg(pdev,
> +				"CXL HDM decoder %d retained locked committed state\n",
> +				id);
> +			*locked_committed = true;
> +			return 0;
> +		}
> +
> +		pci_err(pdev, "CXL HDM decoder %d is locked\n", id);
> +		return -EBUSY;
> +	}
> +
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		return 0;
> +
> +	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	rc = cxld_await_uncommit(hdm, id);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
> +			id, rc);
> +
> +	return rc;
> +}
> +
> +static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
> +					  void __iomem *hdm, int id)
> +{
> +	u32 ctrl = state->ctrl;
> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
> +
> +	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	/* Ensure raw decoder fields are visible before restoring control. */
> +	wmb();
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
> +				   struct cxl_hdm_decoder_state *state,
> +				   struct cxl_decoder_settings *settings,
> +				   void __iomem *hdm)
> +{
> +	bool locked_committed;
> +	int rc;
> +
> +	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id,
> +				      &locked_committed);
> +	if (rc)
> +		return rc;
> +	if (locked_committed)
> +		return 0;
> +
> +	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
> +
> +	if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +
> +	rc = cxl_commit(settings, hdm);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> +			settings->id, rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_restore_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_decoder_state *decoder_state __free(kfree) = NULL;
> +	struct cxl_decoder_settings *settings __free(kfree) = NULL;
> +	struct cxl_hdm_info *info;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	int first_rc = 0;
> +	u32 global_ctrl;
> +	bool restore_command = false;
> +	u16 command;
> +	int hdm_bar;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		if (!info)
> +			return 0;
> +
> +		decoder_count = info->decoder_count;
> +		hdm_bar = info->hdm_bar;
> +		hdm_offset = info->hdm_offset;
> +		hdm_size = info->hdm_size;
> +		global_ctrl = info->global_ctrl;
> +		settings = kmemdup_array(info->settings, decoder_count,
> +					 sizeof(*settings), GFP_KERNEL);
> +		if (!settings)
> +			return -ENOMEM;
> +		decoder_state = kmemdup_array(info->decoder_state,
> +					      decoder_count,
> +					      sizeof(*decoder_state),
> +					      GFP_KERNEL);
> +		if (!decoder_state)
> +			return -ENOMEM;
> +	}
> +
> +	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
> +	if (rc)
> +		return rc;
> +
> +	hdm = cxl_pci_hdm_ioremap_current(pdev, hdm_bar, hdm_offset, hdm_size);
> +	if (IS_ERR(hdm)) {
> +		first_rc = PTR_ERR(hdm);
> +		goto out_restore_command;
> +	}
> +
> +	/*
> +	 * Restore global HDM control before per-decoder commit. PCI config
> +	 * memory decoding is enabled for MMIO access, but IOMMU reset blocks
> +	 * remain active until HDM restore completes.
> +	 */
> +	writel(global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (int i = 0; i < decoder_count; i++) {
> +		int rc;
> +
> +		rc = cxl_restore_hdm_decoder(pdev, &decoder_state[i],
> +					     &settings[i], hdm);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	iounmap(hdm);
> +out_restore_command:
> +	if (restore_command) {
> +		rc = cxl_hdm_restore_command(pdev, command);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	return first_rc;
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> @@ -476,6 +710,7 @@ static const u32 cxl_reset_timeout_ms[] = {
>  
>  struct cxl_reset_context {
>  	struct pci_dev *target;
> +	bool target_prepared;
>  };
>  
>  struct cxl_reset_walk_context {
> @@ -627,6 +862,38 @@ static int cxl_reset_validate_function_scoped(struct cxl_reset_context *ctx)
>  	return wctx.rc;
>  }
>  
> +static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
> +{
> +	if (!ctx->target_prepared)
> +		return;
> +
> +	pci_dev_reset_iommu_done(ctx->target);
> +	ctx->target_prepared = false;
> +}
> +
> +static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +	int rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	ctx->target_prepared = true;
> +	return 0;
> +}
> +
> +static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
> +{
> +	return cxl_restore_hdm(ctx->target);
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> @@ -672,9 +939,11 @@ static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
>  static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
>  				  struct pci_dev *pdev)
>  {
> -	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
> +	struct cxl_hdm_info *info;
>  	int rc;
>  
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
>  	if (!info) {
>  		pci_err(pdev, "CXL HDM decoder state unavailable\n");
>  		return -ENXIO;
> @@ -824,8 +1093,9 @@ static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
>  }
>  
>  static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
> -				  struct pci_dev *pdev)
> +				  struct cxl_reset_context *reset_ctx)
>  {
> +	struct pci_dev *pdev = reset_ctx->target;
>  	int rc;
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);
> @@ -866,6 +1136,25 @@ static int cxl_reset_dvsec(struct pci_dev *pdev)
>  	return dvsec;
>  }
>  
> +static bool cxl_reset_hdm_available(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	/*
> +	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
> +	 * reset-method probes and reset requests can test availability without
> +	 * a CXL driver bound to the device.
> +	 */
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	return info && info->hdm_size;
> +}
> +
> +static bool cxl_reset_scope_hdm_available(struct cxl_reset_context *ctx)
> +{
> +	return cxl_reset_hdm_available(ctx->target);
> +}
> +
>  static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
>  				  u16 clear)
>  {
> @@ -995,18 +1284,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if (!pci_wait_for_pending_transaction(pdev))
> -		pci_err(pdev, "timed out waiting for pending transactions\n");
> -
> -	rc = pci_dev_reset_iommu_prepare(pdev);
> -	if (rc) {
> -		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -		return rc;
> -	}
> -
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
> -		goto out;
> +		return rc;
>  	cache_disabled = true;
>  
>  	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> @@ -1030,7 +1310,6 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  			rc = rc2;
>  	}
>  
> -	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> @@ -1051,11 +1330,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  
>  	cxl_hdm_range_context_init(&range_ctx);
>  
> +	if (!cxl_reset_scope_hdm_available(&ctx)) {
> +		rc = -ENOTTY;
> +		goto out;
> +	}
> +
> +	rc = cxl_pci_target_reset_prepare(&ctx);
> +	if (rc)
> +		goto out;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> -		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
> +		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc = cxl_reset_execute(pdev, dvsec);
> +		if (!rc)
> +			rc = cxl_restore_hdm_decoders(&ctx);
>  	}
> +
> +	cxl_pci_target_reset_done(&ctx);
>  out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
>  	return rc;
> -- 
> 2.43.0
>

Hi Srirangan,

I have some questions.

On failure of cxl_restore_hdm_decoders(), cxl_pci_target_reset_done() still runs and lifts the IOMMU reset
block, after which pci_dev_restore() re-enables Bus Master. That leaves DMA reopened over decoders that were
never restored, the opposite of what you wrote in commit message. If restore fails, the device should be left
in a safe state, etc IOMMU block held, device kept disabled, etc, rather than resumed.
What's the intended recovery when restore returns non-zero ?

--Richard
 
