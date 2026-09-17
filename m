Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A13BD225;
	Thu, 17 Sep 2026 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634922; cv=fail; b=M5VJHkHz2XiJrNxLMJkxHKVy9zuqXK3+VRHIC8q63E3oz3ymjWwkofTZejz4WohYOClfwUXmBfGWuAXJwiohRCilc+URZ9zE9R4BHOXr2hSE5fkybc/QiIKuT6y2ScaVaHW3hMHYMdINOSY9hrXSNGlzyaEvKjZ0/CVrOrr3tn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634922; c=relaxed/simple;
	bh=PcXVfYDt05emT7YLcIql0M9mJPuaCjicujbkFKzo2wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bhu0BtM9PDwDi7+UY1sEJRg2sSNsz/r9+NgiOM+xapsQZRY+hEZzhqASungzxxQBtgjjPYkqy9dgCJRDl1gXotWs+hbvMtihlumoev50CO85NCKmls/FKbKJv4kPKKTpY89H/PraRXFHBaaaRh8FRskZq1kgSwbfHztkNSoibYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fp0HjEcj; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fp0HjEcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icUAIOZfk4NfWwUUQ9NOjsP4hiQmPtIoFjuKwM7cd9FnK4t9x/oT/ndPocuWBmFz5RFvxYjM7Vooo5o2zA2CcTfyMasBqr6dS4s3ND9p8knyygJqdnK8Uf9oCmLH3UPO8Yklu33KS8mS4V0ysz6HDeJb0uyNl6n1ME+/+uurGXOWPqz5bTC/MU35Wf/HZuy+al4zz/p382P4JYIyq2caIIfBoS01D2JlXVUIAsRSeLEei4leJAMmizpuv1M7xYAsYxP5AAWrXVrzjWsYxBLDSyPbW9CCXAaIM7/V/UndOVVBfhWNDDMyy2Hexb3bZUanxGenVJro/guIe4g2BO21Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9/sty7MP1HeFPqvOYirpb+6XSFGEsm5NBcyHxEIg3E=;
 b=H3ncf3od9pZ1nOMbnjB0a4rKAahU/rTLT45h6bgG1/qyTorxJheOMqNAiyRwHFNcavqAwry7N9SMyXfb1QHauYrqmO6vhYnjfggYfV1pruGrbbNvl1JnFifGL5KoOzFsTgoraaFqdrki7/IYGKdOwLh6P1vissxI0ac15C+L6htG+za1OtLC5Z3+9Ok4eOpImzcKH3hboNZPLt82EXrhRvNMAHyxKBHLRQuLE/YJIL3MirTMKm2uI1Y/rkKc0oWt6K7WVFBX4gPLek2vz2+9eeOO8Eh0r7EoeSwQieel6LcOVZxe7Cie2fx6Vo5DEoo0jpxj3H181EQizto4tAjXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9/sty7MP1HeFPqvOYirpb+6XSFGEsm5NBcyHxEIg3E=;
 b=Fp0HjEcjueTjmTrHCNu9vowxog23YgzU3CfDu7cth9U1wzd0oUktMi/PEgwSMqU4FP3/VsaXGstoSr2YxTgsTTe7pCdvbgDbYbv1qOjdtA+8j9yCa3N5eUJV0I3wTHmCzM/cnIB0wyFHnPI0cLSCeL2TNLxhI0xaJMKrx0ILFDcUgqxCB7KHMMh3Va3UDBnj2ChtesJuGakFBpjjdcvpVXDXG3kp8jg7+vbLL4Qb1gskaTcszvnvleiCus6B2ghTLmjLcVuKiiAqQwbZqwy7rRZkZS6HLjImoUOWxtSoYHyy7j2giG6XXKrlrqLwAA2W2qBEolok21I8Y2EZKiL7RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 08:48:14 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:48:14 +0000
Date: Thu, 17 Sep 2026 16:48:08 +0800
From: Richard Cheng <icheng@nvidia.com>
To: mhonap@nvidia.com
Cc: alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com, jic23@kernel.org, 
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com, kees@kernel.org, 
	gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/27] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Message-ID: <aqun1vZcE3gQzXD9@MWDK4CY14F>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-7-mhonap@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916183540.3813685-7-mhonap@nvidia.com>
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 838c2aa4-db18-4525-9bb7-08df149868ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|4143699003|6133799003|11063799006|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	9BBblMt084Zs8Rl+aUegqlCGTRCKVEtOhG/FSLnVKdgRQPifLnAAQong/Nyu7JvEBKcpy3WSFdu4cnA9AkbA5zlRo90jo0mPpO6n1T7tIAhnXIDXu6/uiuZuEA/YEILQtOZ/jUPVLvVNPYH2hUvWW9zbUX13+ErnYAsxvTijmpdZ9m/Y12hfL9gNtSV4xBp2ffEH6YK7u3L6o9Wk6U0ngSjyqmOj5CkxgYyn3oZl4FZgPygSwoI0ikTU9Jt52M3GO71NhNhZirMgPFtH2BsKZWqSsqTfe/I/4w5cNLRkAwtLfmgroKb70gSH9Q6ZtW0YOso9CsvWjono8Ckx/nJE25GVB9UqR7m5xBbOuV9q20s0OcMcdVTJN7imxNt0FiMdnRea5JyEHP5CmZ1dQtAQqXVltP6FxnnpnrX2mxA0GN8/UuGe/1HxU0QgPgRGeQroKeuZRL6nLeadYeKzd1PhkcZOa6nn9nnVeiT//HItM7HGkhnWmsphZg9BCjPCRauz/NcOBmukrvtMXSmk0y/drBfhjANK4evJElhtg1+5HVSzPx/H0m86zbAz+rVlUL2HEM5uZx3E4OxjLAPvZsx2ljp/tyIHivLx2qQsyBGwKMZ18u4s0SCA65bYiOTJhKGW640c6zaURuDywVo2JXzE4T2DqHYD7/3rHbKFyNHHBJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dpc+av2i0y4y9xgsbNg1X+QIXjCDJmkrvcuR6yVlrcsqgLEoeOsaEsPcryqG?=
 =?us-ascii?Q?RPXu7G5AP47OHbzEFgjIK31zc18v6WTkanP2ygembVgO1ZpX0/PsqKYYhy+C?=
 =?us-ascii?Q?r6wFpoP0MnpDGef9EkTQ1OCwLOSTSH0sTVJgv32j3/nFLlKNwHeZTOhNRVZA?=
 =?us-ascii?Q?1XVPD9HRkeKIKz+tPVNlnRJ8NaV79QmnWkoDvl8OLG0pDFaQGxRNIvShuFTn?=
 =?us-ascii?Q?I10i59cuTZyWNdqY7x1YY/VK3DsgCaaW4ROux/2cFciaiE7dBxlqGIxmWN/u?=
 =?us-ascii?Q?TtStI4tE87L2klk01wijk14qbwouGwmHVaxrqM6FAhS+Iez6atdCJ1mmS0ET?=
 =?us-ascii?Q?JzQzLRthCTUUfUYP7pxzOAQzmV6cpSckVAFqVIC300MZ5G2eaVL1sJGZ1ZDN?=
 =?us-ascii?Q?g35MFUYjbWDFFIDUokazdRkEDShTPn1//QZESsgsQ63/gJXmFizu7+Hgpkif?=
 =?us-ascii?Q?LokE/FlHS7UEbIT+u5f6YR+jtgThxJfxvoIF675p+sh6GqbdLrRC3NVucTLf?=
 =?us-ascii?Q?HKKFRAqk9alFLqvxpJwrs+zmd8zG3WYGXLHB/RTx9oeQKGwwKRcHqadtkW06?=
 =?us-ascii?Q?LTTye/yfydnfDDlTWHNtdu+4Sv+R/W4w0iNONMOQ/FZNGJKJY6vw2OhbITkZ?=
 =?us-ascii?Q?Ej2k7hw4X48zeiAIJ+KHn5NAANedsSxQ59pSvdwbO48Y1gNOCL5EQnuaSnDS?=
 =?us-ascii?Q?WRvs+ferq4TZ5ufeqf1yqrk1Pn38+lbAM6KReJsblp/GN0egoprtJZKR4t0E?=
 =?us-ascii?Q?oGDl8/3a/J2HiffvE3LgDoz/ZYsgVJp63Gs3Dl+2vE28uOvibnlk0xl9N1lA?=
 =?us-ascii?Q?wDao+v1JIaMQwNYx6bVh0C8ki1cM/B6EZ/ED7nS277bIft5S9LleyNrvou7m?=
 =?us-ascii?Q?VlWKYcth13AQehQfXhxoDESdhvdv4ILAaHzqqgfxwSBuxjieZPbVy3sSsLQW?=
 =?us-ascii?Q?JTN8hbt+mHs9S8EkmMdP8Bo9l26T+lu0D/2+puKxaVH/WJd9qb09Zrvuq2eU?=
 =?us-ascii?Q?dtB9E8URL/+sGR8oommJF2jxNWZND7HpF6rVT6rMD2XD3/Dz3hKBmBL7J67G?=
 =?us-ascii?Q?7+c9GoKgkYLT/A0jR1KHzwIlAM1ipggQ1YYq3qmolriL4AE969eoCdSTyl69?=
 =?us-ascii?Q?w+K6RIz67epi8uoVDuq0H0eYXUCzNzDSEQVcCZ75Kf0AgBWUP6qzRaBohI0m?=
 =?us-ascii?Q?uvUcOwPE2NjatuqFyM3DV2fCdMq/NAmNLp3PzxHVFQzJ5gmHTu97hUbIO8kY?=
 =?us-ascii?Q?eJ31jbeM8v+cnupgZfYBnxDafrBtTCmk0TfVdqcviBdFsdzPvK+69jnOqM28?=
 =?us-ascii?Q?UreDpPxbJeKVugibOtgQKhnOjHP3DE+ALkTWXDwlskCmaWj+pdoI+0oo3nhx?=
 =?us-ascii?Q?lcRyvQLQlUBNKuHnwd3NC2WJACXY9tGX6ItI4AuGpEI4/A16Dd+WmCJqmLgq?=
 =?us-ascii?Q?Std+c79PNRtClCdHVpG/mkHU1FLPk1kUqwdJaLTtcxWP6GM0ENqeghbi5kQc?=
 =?us-ascii?Q?VLiJt67K2GAHH5Ug1XnaJ4XmlfM46vKi/nhjNgadYrbZvPOYPa+fTSRAtLBN?=
 =?us-ascii?Q?kZISgR7LnF4Ik9rGK6J2JyEjzyFqYMxDcqgtysadXvYDgzdlN4jtRGiAbnN6?=
 =?us-ascii?Q?4IUxqLved4wjKtu6Bsf5ctNqBqNYfbCg7N8Zxt0k3KF3HxrsM9e4jIY6mPV2?=
 =?us-ascii?Q?bBgPeZMTThe30jq+Na/uLPT37lGiFNvJSBH2GFt+FfSLEzgz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838c2aa4-db18-4525-9bb7-08df149868ba
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:48:13.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdptcSY6fPzIhOgFra/1eyiAHegmJAJlUqTyBauTvN/6fktjax5Z2B+LJFtyQk1hBTaOq094tNcwBPcye1Xxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

On Thu, Sep 17, 2026 at 12:05:19AM +0800, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
> CXL core in unconditionally would bloat every vfio-pci setup. Detect a
> CXL Type-2 device at bind and request_module("vfio-cxl") only then, then
> hand the device to the registered ops.
> 
> Each bound CXL device pins the provider through
> vfio_pci_get_cxl_ops() (try_module_get) and drops it with
> vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
> device is bound.
> 
> If the provider is absent the device is driven as plain vfio-pci. A
> built-in provider whose initcall has not run yet is waited for with
> -EPROBE_DEFER; the deferred-probe machinery will retry the bind once the
> provider registers.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 84 ++++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    |  3 ++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 2cc5dd20396c..9eede1e56ab5 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2202,6 +2202,84 @@ void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
>  
> +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
> +{
> +	guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
> +
> +	if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
> +		return vfio_pci_cxl_ops;
> +
> +	return NULL;
> +}
> +
> +static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops)
> +{
> +	module_put(ops->owner);
> +}
> +

Anything guarantees that we can finish devres cleanup before dropping module ref ?

This function drops the module ref during vfio_pci_remove(), while devres might still pending.

I see in patch 18 it register vfio_cxl_release_hpa() as a devres callback, and it lives in vfio-cxl.
If this drops the last module ref, another process could unload vfio-cxl before devres invokes that callback.

Best regards,
Richard Cheng.




> +/*
> + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> + * identity before engaging it.
> + */
> +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	if (!pcie_is_cxl(pdev))
> +		return false;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +		(cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
> +/*
> + * Load vfio-cxl on demand for a CXL Type-2 device and hand the device to its
> + * ops. If the provider is absent the device is driven as plain vfio-pci; a
> + * built-in provider whose initcall has not run yet is waited for with
> + * -EPROBE_DEFER.
> + */
> +static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
> +{
> +	const struct vfio_cxl_ops *ops;
> +	int ret;
> +
> +	if (!vfio_pci_is_cxl_type2(vdev->pdev))
> +		return 0;
> +
> +	request_module("vfio-cxl");
> +	ops = vfio_pci_get_cxl_ops();
> +	if (!ops)
> +		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
> +
> +	ret = ops->init(vdev);
> +	if (ret) {
> +		vfio_pci_put_cxl_ops(ops);
> +		return ret;
> +	}
> +
> +	vdev->cxl_ops = ops;
> +	return 0;
> +}
> +
> +static void vfio_pci_core_cxl_release(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops)
> +		return;
> +
> +	vdev->cxl_ops->release(vdev);
> +	vfio_pci_put_cxl_ops(vdev->cxl_ops);
> +}
> +
>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =
> @@ -2223,6 +2301,10 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> +	ret = vfio_pci_core_cxl_init(vdev);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> @@ -2232,6 +2314,8 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  	struct vfio_pci_core_device *vdev =
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
> +	vfio_pci_core_cxl_release(vdev);
> +
>  	mutex_destroy(&vdev->igate);
>  	mutex_destroy(&vdev->ioeventfds_lock);
>  	kfree(vdev->region);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 9fe0d1a3a370..7f3a2bcb5830 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -29,6 +29,7 @@ struct vfio_pci_core_device;
>  struct vfio_pci_region;
>  struct p2pdma_provider;
>  struct dma_buf_attachment;
> +struct vfio_cxl_state;
>  
>  struct vfio_pci_eventfd {
>  	struct eventfd_ctx	*ctx;
> @@ -109,6 +110,8 @@ struct vfio_pci_core_device {
>  	struct vfio_device	vdev;
>  	struct pci_dev		*pdev;
>  	const struct vfio_pci_device_ops *pci_ops;
> +	const struct vfio_cxl_ops *cxl_ops;
> +	struct vfio_cxl_state   *cxl;
>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
>  	/* Flags modified at runtime - dedicated storage unit */
> -- 
> 2.25.1
> 
> 
