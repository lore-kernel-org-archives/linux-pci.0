Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E4420880;
	Tue,  7 Jul 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402268; cv=fail; b=VyfNMcCVwWUJ1xaLx26YJoW/02S9hgVYnJ3Lwt8RvzWt7zs3uxbffsS4bQWQrwrxcOQZCcjn+CpAfDmV2qBbajzSBKPyZIIaw1iwO+xhsdsFmYZL8G3l3QwCzwYb5zC+mnp8GVdSZY1U74hj7H+m4hEvF6qA1Y9U3uOwy4rsf+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402268; c=relaxed/simple;
	bh=jnzxQ6+XVaaM7Y4ZbyCtTulYiOC92U7JVSrkL13nvek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kndkYIlYWuZyDHOSti6MULuITRsE+FHs5ajltgbjERZ5TKKanGdEI6wS+Qx7nDR+FnyX31dqmhPFb2rI8TAzkrZ4vOfzwDN/gWrUNx7/8qKDOxFdR2Ak1HCsKBx0JxrIuJBYzuMdZSEE2ybGPZ+DZXYN+bCgwPl+cbPO4QzBS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlCxbyfn; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlCxbyfn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTUVoz6CLhJDS1iW3xX6FozxAWKbqk5q1004GOYKab4lyhX956UtgY7nD22SgS3dlZiej8aQKsQOves3BWECIHLXtPrkkrApGQgSdn3HkW3XMV/62cVmly5aaOMTPNjXNio0+0RMqpKxRoCMnrvhNmp5V6AhNQsgFGH6MWHkknuBDYmJe+1mkjgZ5bHjSf9kYwgTYFPYdN7fz7x8rkpxo4+5buDJeobBg0sKYua7nMWiH6gp/RILwY6Vmjjr3HqRip2NRNuFCzS7BjoQzASIPXvrgTuzBeQ587pCd7KxVtyKB8E0mPYS8A4DbjZA7Fj2Z9ReVFSCgRW8IAoH79Ainw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA639S7viWXfUI2PqrqsTEEwZM9UTVhUsqII+GDMaus=;
 b=two2NibqZ2koPwfhm5FEVo/cfpqoyDWUD+hHkzFMcN75H+DX2eS51kwg8y2Rdx25mwfU56J3laPetquwCj5wfkf1n+UM3J8KWLC/2W0vQdmLp0rGfmp7OqkE8xx7fSLc8u4i8xHNtdAY1c4ko7GhJ75dKyIGTmQ1z58RXwnpmu0rsUWbJTJbDfrCs4xy6R4QnuqTZYW8kYMq032HT7as2tJxVeZ8MgRZy9yCowuTWLg1cFov98DNwKqZhHpWGX+PJrmS5RFiUp17q6BxsRzbRU7mJCdWCVS9DLwO4Fstt5p3W8CkgXyHm2hZCx8GihFEJCHLRQSjyj5UjIn+7wOIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA639S7viWXfUI2PqrqsTEEwZM9UTVhUsqII+GDMaus=;
 b=FlCxbyfnF58iNGQZ5Wb7M8DVii//tUEfti8lYCjbg4RZATq5ZYS+dp9YOJmCg2L6R+HHobZsAa+kyV0vWZt+DQxJTJhQDO+miYSd66n45OYqFV8Twx3ARlhPdxj03yrctpT3mb+3Pk5cXjofXM4stFRLqe23JPpecgzXh4NuhMR1Vt7G/KpnKpeQFjjsBoTM9Hnr+VTNmRZt4Tpm6K0uZgMh0Zu7eWANj7w7i/+QHHKN9am7W490YZhe694fG0ZdZQ0q703GuxK0fxHTy1WBHPmMQ4F6+GR6V1vrVssfVmP6UESjhUiA5Vx4jUytAbhliA+XqP28IRzeR7KXHOsavQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 05:31:00 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:30:59 +0000
Date: Tue, 7 Jul 2026 13:30:50 +0800
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
Subject: Re: [PATCH v8 04/10] cxl: Cache endpoint decoder settings during PCI
 enumeration
Message-ID: <akyNQjte2TmeLhE8@MWDK4CY14F>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703220508.546528-5-smadhavan@nvidia.com>
X-ClientProxiedBy: SI3PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:4:297::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acd17b1-20c4-4065-1b6d-08dedbe8ed2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|56012099006|5023799004|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Sdh3bcR7pdSNT/sIYU/zcXVsD3E4YCbvyCpcdvU8vM0IlqAxjnfa6xw+dCoIlEHEDONodBsGwGX9Z7Y3Q4lDKoGtw18vufm/igbbzwXAKBQorFo3fH00vPK7Zu09BaAzYzQXm4vz8eAiQ8u1CwwLuYvceqEQhOG2gjTiMOF9ZDojnnRIvyVfGo8LCskIzwSLrKqp1TrjXUuGBv52BM4mExcLcILqwpCVIH3kdgrYBIYGBbRfwfyzuSeu77Ajx6Cg9TdxFInLWArJbDKf+vfrCdWeXGtFWzB2aa4RsFlbw85pl74S8CV55Yud9ecIyEB43PiJJbSnSZqMFnmCMuz5pTvxEz+e04DrKjsBWguQfqYnyWnCwpONM4r3+SLmoD42xFmhcGKpvu5sSFjuFfjS1maSnV+8fSRWKUsk6YOtlMQMSgqXS3mT18d5tTumfmsh6Fr6PxPziIKaQKs8Urc3H5MV5bOp1qgVV+WIzHfqBl5rXpOyxmB3lf5MljD6tJBoig4oRGqd/h97dYK5uqDLWIfZxRK2rqKlHtJ8aphLDPdfZRLR/dLk02nDtTH3P+Eh4xLVAeN0fADOYGzcu4NQBJnVyCPYcSs/nZegzgxxewwiXHtsGXJyoIh1YiO/aamKWlHmYaUZfygrqUCfn7uI3dSiZDonUON+NC/G1UVqtAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnm9EG0/rjRaGrmdIkGZNehbwF2sI7XSyLXRCg4c2hMjosdWhOBd2FO6aRkj?=
 =?us-ascii?Q?23cB7I2HcHEt9rL5jFE8TOf5k59YzB/ilmv6z8w5jlgpABDDRjkQZgNR40GC?=
 =?us-ascii?Q?+7S6ODIGXDUwMRqDiqI2MwWvpJIDwmvxIMZIAC674KUuajTtIBAG+P8miF7G?=
 =?us-ascii?Q?muNbUScOhl66zcZyYOFnXoT1C41vtZ5tZf5G/gSAfy1MilvGAlM+xjbMm+NW?=
 =?us-ascii?Q?+kZA800Iiw9j05YJ5Ea3lbTc0NAH/zGzfDIv/NwNvPViPjFNKDukWLE71mR5?=
 =?us-ascii?Q?OdGAJLmNW7z3JUKgQJvOw5WBi5J9wjBKl3Wtpfc8Q98Uvt6MsQfFEL+CWV64?=
 =?us-ascii?Q?YXzP56zMXTmNs+FlhYeZ59aGZTNUBFnicZgPY5cejZQz4F0hptR8F4qypRXf?=
 =?us-ascii?Q?zxEJentx4Q/g/Yqy7QTzyWQYRyq+WXipNOWTnF91i9TS8xFkpIoV9ucuOLsw?=
 =?us-ascii?Q?budYKnBiNlxfjNIvevkfWR+HPohJavyos6U5B/FkgwXEzc1R/lsvGgpdeFML?=
 =?us-ascii?Q?DarX50R+KYPXzNyP/vqSWm0MyuVOGNQaGQ4lyTTLEY2X3bijRsh3RCUBlRcG?=
 =?us-ascii?Q?YTK9OgrvBsBhHveHOqwUPaimD8CSQ7hGw+IsNGG0sm0j/U5tIA84JOS+RNfK?=
 =?us-ascii?Q?mgCSa9Sln7IahGcWfFgwKJcrumL4OZTtMF8mwFb5RLdPdyw1YrUUj8+NwH0b?=
 =?us-ascii?Q?4YSacCVeevNY67LN0mqSjC0/A2oPXjuw1ccuMk6VXaSgxsl90SgmKSpz6zjE?=
 =?us-ascii?Q?STPtYWtuBBGwgu9ffnBr4tSt1oWWIW+BQSUT6ac4y/pZZE25tJluFv6io7kd?=
 =?us-ascii?Q?YbdFcj0zC1jzTsro3ISZOZdH9hJ6gc17XeIW7cXhwlA7S0TEiCjf3TKnM8JX?=
 =?us-ascii?Q?ZKVxzZsSyN+k7o2TmDVcKW3ip3+hmyPoxpdXhxiEjGXBjT62vOEg65uiWhAW?=
 =?us-ascii?Q?KvNk5HF7W9aTV48JgxlyWw2bg5u3jKJMkuK+fvkDrkaeZqws2+m2z0hkhkFJ?=
 =?us-ascii?Q?kwLqHmr3hBYG8uqCEAdEMMMOl8roiAQfvo5jz4NkK+xB3t+PmA4EV5twkrHM?=
 =?us-ascii?Q?DpLAp246l8UTDtBla0eT12rkvWnpKTZq91WMc8N5F2XKXluUlSVXIzu4axuE?=
 =?us-ascii?Q?Dn1SaD2uZjiC3qgXiZ/VFU16XNLa0caUuSgratH39haHmtRduFOrhjiqmOyB?=
 =?us-ascii?Q?fOpfa3jvkvN99q6TYMCjkPiYP6cHn416y8UOVLycm04s7QhBD005iQB2Ppp+?=
 =?us-ascii?Q?M17TcxVEcN1CJqpNY7ihL9uRjUm+DiFVnvzNmTXJuMGvyPrOK8AWgcxv+ebX?=
 =?us-ascii?Q?GX5sJkEmPQqDtq9vH19fdCmF0RZVyxWbqQJswEVT07OOxcfJT0sVhdplZjU8?=
 =?us-ascii?Q?XwMqM7kE7RhLH3IJd0n/+t+Swf3ryAcCQlWjWNqxmYtU7r/DMcewqDmTT05W?=
 =?us-ascii?Q?VHcbm2DMGCCJbDnZ67S/9xsrTehcePPR1GXTvSI/OsYkQpwoFU85VT6yOQez?=
 =?us-ascii?Q?PBRDt026M6jiXd9YXsigiXqYg3AH1v4uRbO77N2/cNFRHFTc7dxqzVN1DZah?=
 =?us-ascii?Q?J5Z/wSglEh4Wl+9VXHXITSLZL4U43l8IQUH9NENkCFOWv/FFcOf397IkCUHA?=
 =?us-ascii?Q?huadIuPFATgGUb9yitM/RynH756ESbaZkn8mPAiN8oStAw1YaZG8LypS1waM?=
 =?us-ascii?Q?zxjBESrqVO0Dop6p6yxDci60089gkxoZIJZJHgqpU/ODZAbF4bCRV9r43UTO?=
 =?us-ascii?Q?im6pnUlq/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd17b1-20c4-4065-1b6d-08dedbe8ed2e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:30:59.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asoP84JcRuB82htT7CNBAmM+z6pLQXyhDCHOxizEcog4A7mR7b/YuE3ruW/5cPkhx4LqxoEGu6W7JMMLpgAyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

On Fri, Jul 03, 2026 at 10:05:02PM +0800, Srirangan Madhavan wrote:
> Populate pci_dev->hdm from PCI capability initialization for CXL.mem
> functions. If Memory Space Enable is clear, temporarily set it while
> reading HDM MMIO and restore the original PCI_COMMAND value before
> returning. This gives driver-free reset paths an early HDM snapshot.
> 
> CXL core later reuses and refreshes the same cache. Move the register
> helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
> available without cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile |   3 +-
>  drivers/cxl/core/hdm.c    |  58 ++++----
>  drivers/cxl/core/regs.c   |   4 +
>  drivers/cxl/core/reset.c  | 288 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |   3 +
>  include/cxl/cxl.h         |  31 +++-
>  6 files changed, 349 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index dc075cee0450..69cf2ea7ee74 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += reset.o
> +obj-$(CONFIG_CXL_HDM) += regs.o reset.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bd1d92e5add2..7a1ade846c9c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -84,18 +84,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
> -static void clear_hdm_info(void *data)
> -{
> -	struct pci_dev *pdev = data;
> -
> -	WRITE_ONCE(pdev->hdm, NULL);
> -}
> -
> -static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +static struct pci_dev *cxl_hdm_to_pci_dev(struct cxl_hdm *cxlhdm)
>  {
>  	struct cxl_port *port = cxlhdm->port;
> -	struct cxl_hdm_info *info;
> -	struct pci_dev *pdev;
>  	struct device *uport;
>  
>  	if (is_cxl_endpoint(port)) {
> @@ -107,42 +98,42 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  	}
>  
>  	if (!dev_is_pci(uport))
> -		return 0;
> +		return NULL;
>  
> -	pdev = to_pci_dev(uport);
> -	info = devm_kzalloc(&pdev->dev,
> -			    struct_size(info, settings, cxlhdm->decoder_count),
> -			    GFP_KERNEL);
> -	if (!info)
> -		return -ENOMEM;
> +	return to_pci_dev(uport);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
>  
> -	info->decoder_count = cxlhdm->decoder_count;
> -	WRITE_ONCE(pdev->hdm, info);
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
> +		return 0;
>  
> -	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (info) {
> +		if (info->decoder_count != cxlhdm->decoder_count)
> +			return -ENXIO;
> +	}
> +
> +	return 0;
>  }
>  
>  static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  				     struct cxl_decoder *cxld)
>  {
> -	struct cxl_port *port = cxlhdm->port;
>  	struct cxl_hdm_info *info;
>  	struct pci_dev *pdev;
> -	struct device *uport;
> -
> -	if (is_cxl_endpoint(port)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> -
> -		uport = cxlmd->dev.parent;
> -	} else {
> -		uport = port->uport_dev;
> -	}
>  
> -	if (!dev_is_pci(uport))
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
>  		return;
>  
> -	pdev = to_pci_dev(uport);
> -	info = READ_ONCE(pdev->hdm);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> @@ -948,6 +939,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..040b0304f63c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 4c977fc47f8d..97b72cc67b6b 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -2,9 +2,16 @@
>  /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -161,3 +168,284 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  				  &settings->interleave_granularity);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> +
> +struct cxl_hdm_decoder_state {
> +	u32 ctrl;
> +	u32 base_low;
> +	u32 base_high;
> +	u32 size_low;
> +	u32 size_high;
> +	u32 target_low;
> +	u32 target_high;
> +};
> +
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end = hdm_start + hdm_size - 1;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		*bar = i;
> +		*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
> +				     struct cxl_register_map *map,
> +				     struct cxl_hdm_info *info)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm_start = map->resource + hdm_map->offset;
> +	info->hdm_size = hdm_map->size;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
> +				  &info->hdm_bar, &info->hdm_offset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	hdm = ioremap(hdm_start, info->hdm_size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
> +					   void __iomem *hdm, int id)
> +{
> +	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_hdm_decoder_state *state,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	bool committed;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, &committed);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	if (!committed)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_decoder_settings *settings;
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	void __iomem *hdm = NULL;
> +	bool restore_command = false;
> +	bool allocated_info = false;
> +	int decoder_count;
> +	u16 command;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		if (info)
> +			return 0;
> +	}
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		restore_command = true;
> +
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +	}
> +
> +	if (!info) {
> +		info = kzalloc_obj(*info, GFP_KERNEL);
> +		if (!info)
> +			goto err_nomem;
> +		allocated_info = true;
> +	}
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	if (!map.component_map.hdm_decoder.valid) {
> +		rc = -ENODEV;
> +		goto out_restore_command;
> +	}
> +
> +	hdm = cxl_pci_hdm_map(pdev, &map, info);
> +	if (IS_ERR(hdm)) {
> +		rc = PTR_ERR(hdm);
> +		hdm = NULL;
> +		goto out_restore_command;
> +	}

Hi Srirangan,

Just a question by inspection, I didn't run the hot-remove path to test whether
this can happen or not.

pci_cxl_hdm_init() is hooked into pci_init_capabilities(), which runs inside pci_device_add(), so at bus-scan
time, before pci_assign_unassigned_*() do the assinging of BARs, __pci_cxl_hdm_init() then sets
PCI_COMMAND_MEMORY and ioremaps the register block.

For hot-add via pciehp or arm64/DT where kernel assigns BARs after the scan, the target BAR can still read 0
when the hook runs. In that state pci_resource_start() is just offset, and the code enables memory decode and ioremap
it, which is exactly what pci_enable_device() refuses to do on an IORESOURCE_UNSET BAR, this might fails the platform.

Do you think it would be safer to defer the HDM caching to a point where source are guaranteed assigned ?
and if it stays at enumeration time, it should at least bail on IORESOURCE_UNSET/!res->start and use Register Locator BIR
to pick the BAR.

--Richard

> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	if (info->decoder_count && info->decoder_count != decoder_count) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);
> +	if (!info->decoder_state) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			goto out_restore_failed;
> +	}
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		if (pdev->hdm)
> +			goto out_unmap;
> +		pdev->hdm = info;
> +	}
> +	iounmap(hdm);
> +	return 0;
> +
> +out_restore_failed:
> +	rc = pcibios_err_to_errno(rc);
> +	goto out_unmap;
> +err_nomem:
> +	rc = -ENOMEM;
> +	goto out_restore_command;
> +out_unmap:
> +	if (hdm)
> +		iounmap(hdm);
> +out_restore_command:
> +	if (allocated_info) {
> +		kfree(info->decoder_state);
> +		kfree(info);
> +	}
> +	if (restore_command) {
> +		int rc2;
> +
> +		rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc2 && !rc)
> +			rc = pcibios_err_to_errno(rc2);
> +	}
> +	return rc;
> +}
> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc..2fd186468498 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  static struct resource busn_resource = {
> @@ -2489,6 +2490,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> @@ -2679,6 +2681,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rebar_init(dev);		/* Resizable BAR */
>  	pci_dev3_init(dev);		/* Device 3 capabilities */
>  	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 80839517eabf..2215fe1c3f78 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -121,22 +122,46 @@ struct cxl_regs {
>  	);
>  };
>  
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +struct cxl_hdm_decoder_state;
> +
>  /**
>   * struct cxl_hdm_info - PCI device HDM decoder programming cache
>   * @decoder_count: number of decoder settings entries
> - * @regs: mapped CXL component registers for this HDM decoder block
> + * @hdm_bar: BAR containing the HDM decoder registers
> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
> + * @hdm_size: HDM decoder register resource size
> + * @global_ctrl: cached HDM decoder global control register
> + * @decoder_state: cached raw per-decoder register state
>   * @settings: cached per-decoder programming state
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> -	struct cxl_component_regs regs;
> -	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	struct cxl_hdm_decoder_state *decoder_state;
> +	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>  };
>  
>  int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
>  			   bool *committed);
>  int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
> +#ifdef CONFIG_CXL_HDM
> +void pci_cxl_hdm_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
>  
>  struct cxl_reg_map {
>  	bool valid;
> -- 
> 2.43.0
> 
