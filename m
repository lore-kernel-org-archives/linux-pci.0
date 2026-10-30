Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793330570;
	b=G8balb3FkcwBr/YWlKgQFAGw3gG4i5UNGA4tynJjlqWXymTPEUaNDPLROQRBANvDQXiO
	 qyXk8Fe3Tet3M4LDhnz4f1f7JmpvqyqoQBnmlGEpjRtia7eLP940NA583EZtzWBeLhX89
	 UaioMhi9GnzVt9SPqU6afdbCvjLk5Zr1bC6W+ZEWSwWKiO6XkANG9hRLDA70nBnZHDR9R
	 zDW4qlpBSVN3uPNPZe8jBdnaFyOgW6Z+Fmt1RUE9Fo96pwrtOQ4g8JnJFXnS9Pn4j/rES
	 x9M1T0sRQllTDfMaWHMCEo1JV6EP4WSD62ZNx9LupP4M0MUE9/OsEdOB6DDaUMvtNFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330570;
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
	bh=uXeMHFrPeHJ9468WEDrU1BdD3C8oaxjeP66Nu8ra2gg=;
	b=a/15Zx36+OtD5GMgaSCDOMYrfYcM177k8L6oOelfzp4XLyEo3H6K18AWwq+Tg+cM68Ny
	 DHMEoPRYNGbe9urM0NNSBgVl0tpuoOBhzoTjHnSX/ulMKDQJ4NnguHADTyrjbSm2AbBUa
	 lu3R1rhCKjjkV9+F4DALNSQ7oQ6n8KkVb1jDjpG/TXvmAQ5I3OYYDH9xKnqhFDNCQZ1Ig
	 fZ9yUGMJPFb3+7dc0OghgtoQqam/xIfwaUjtksC3qgzmlfJ9B62Cfk+EDOLyo+oNnvIZx
	 OxH/IFldgEnCieTO6UeMrp/8VCg9cQdq4ayeahW6OiB+P6yjKunau7ZojwBhU7edS5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d8hCqjCs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.34
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60036606A322;
	Fri, 30 Oct 2026 03:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60036606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d8hCqjCs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2BaY1iylgMUueqtoLMW2tS9uBNlJUVET/8PqyLZzkrgI6D0ImJG7y0HLUOilomdzEYKu5p16Fahc60nM4Z4v/XgZNht+fL2kipzud5xLF6mBM9rh3+kAAcUsabGoNDunJJ8U2JV1G0sdc0qSFVSYlwz9375XpOG4laVdxahZj72S08PGLBP+NmvCcCK5iVXjsm/h6LfkSEPUgTB+UjdQsFpOX5/cTDazomUYAPolGP0ulclguWVhAIyIi78K6fFDzuzK6APYilQYYUReqivUmsws72OD80FCpfR5/xl3holQuUP9Aghwa1SfXx+VxWQrQN5ts866K+BPqeE1hIh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXeMHFrPeHJ9468WEDrU1BdD3C8oaxjeP66Nu8ra2gg=;
 b=QPwlZGgg9rJ/ysOdODSmyw6Q/Do85qNMNfoNBnIUOGi2jDPzhuKVjS1aaN9sqrPjCcOgepELOsDbc4sNnKjAhbIG29+JTc6eVGXMxeafGiQsX8WTfzScuXXWz7YLpD0aXO9Ye/d2aBWIJB4SRmic5F0xsDr1ZVTQSrF/Zjqk3bL8EsvmzrFZOsimNPbM9PSribbFJKwoimB8UOCSMMSFO3xYLlAjH3g0niF2AGTzH1efyreoMY8uHuIFlJdJyKGSO7xmGdykxB8skY095yh61cSYEhIwW5avvR9+bRruxYLAhmWQrDfbJ50BXEaJ6aaUT2hb1dypuLsX072EbH0olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXeMHFrPeHJ9468WEDrU1BdD3C8oaxjeP66Nu8ra2gg=;
 b=d8hCqjCsCasuTWNDsJN5njbbl7/6auRWxVV9xlPIvuuLZX6ry6pWSieM8iW+di2W73jbRexzE6pNIiOnV6fQGkdDAOJfnjdojKsZhg/Sf515EzqrjJmbFm9YNFVrj+SsFx7cgEQhVvkudDom4+YPUZ4XXHLSLSI6v2MHBTTI+Oelgf33pGtmBoZfp05pjchFkR4ag0j1fXpQISPsKm9M8EKLa+KJAfMv5YIvwoheveTvVJiAFiBSNM/n6RplDPk/XWkS6faDLMQ5GE8AL/oIa5jhPxucojl5NsuU3asTiFKWS18tFOfau5jhm4ZqbiPjGZk/l8QJGi1jF42gk089rQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 03:22:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 03:22:43 +0000
Date: Fri, 30 Oct 2026 11:22:33 +0800
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
Subject: Re: [PATCH v16 12/18] PCI/CXL: Add CXL Device Reset sequencing
Message-ID: <auQC2UECQ8vaelPz@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-13-smadhavan@nvidia.com>
X-ClientProxiedBy: JH0PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::11) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ee8e0b-c0ed-484d-e2fd-08df36350f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004|261022105027099003|261022075727099003|261021123027099003|261028144727099003|10067099003|261021121427099003|261009223027099003|261026121527099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	RORNds9lY7iWhWnp0fZba1sbiX7GER8x1nGx+9TjUB4roty+NhMDKQN2iMUddMKRsY8i/TRYWtr989zw204FvHtHJsTB3N3eokonN0r18UXL7uSegRqpBbc9MBFvYpp4Dqst7p0QL0OBTZfnu5Z1GtzUKfReUXxkspi+hkDFUExLUuTe0gJmgTkwq7uAm0rmlfg1x+wDzhfvFz41fxTcu7iUi/RpWwGdykCK+O/0iMTSk39bnmb/Jw0G7CddhgV6UHQMV+fSK3lyV8j4UkmmUcBP/x40rqsA5uKKGB5YyceQXIFXjtgOVe4oLvA594yQtFY1tHY4dZMzRLZ8zW79gRacYicPU3Jh+qqJcLoOOGFxTTe22uCaOuhq3siCZx2mJCj7ej29dyuUt3TA9q1XJdHVceCQA6E7K9MjKGvdvLqMMaGqj37DjQsod5goS7WBas2uyy+L26KOXKMrXalfXc6Jy2Xh9l8dvEPVEErQLtNa+nMXeFhhvwibsYmt4hqcjUlIIqN+lsn+nWwQS8Pqs2m64kPioTwEc+ky5Giizun/r/InIw1ukITfeWrknl9EtkMpVHI9cn7suACwVvS9AtfUQI+T1kWulVxUkeCrgVysI+6cGn8wp2rt91vs01jJWv8oLj7gsAgitqWkTv9VvJY22IGfmU6qXdVWUbz49zA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003)(10067099003)(261021121427099003)(261009223027099003)(261026121527099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rU212OirpP6VGoX2SfKvFk8KIE234qvwvkaF1oMhl+A6V9DxtwKpH1PYT+lW?=
 =?us-ascii?Q?dq2ZP3JeH3CffVHb0j/7+oI7pFeSmGxxu2HQqzFBkPV4ufJNFTttQGBOCCnD?=
 =?us-ascii?Q?MjveZYTD0lYhISVmNnkgzvl35aYQ+RrpLrL2VEagrqol+fDF7s3v4Y4UE3Ku?=
 =?us-ascii?Q?5f1eVR2mXkU70cpAeWiigjbmwUfKR6ZFCyjUvD7mp0GGSvw7oQqgNUPpSJPv?=
 =?us-ascii?Q?yvT9Nm0R++7BOXtaIScJHLEYQXvgcuPl9I1dcziLJMi1pRwKkX+6iF5bTX5c?=
 =?us-ascii?Q?F05+3xPNyIduc3KoplCCnClHQaM2UjeUkyELhVVQd0MhtBgdKYO0SF1fz+Ps?=
 =?us-ascii?Q?eF4qEMmiVedmcCBRK3W8qkRPkPFnsPbjkf9teZ8Z8wzQ1BQW3QXPtvhUteg+?=
 =?us-ascii?Q?tLe2epW/ui9hDfLzUFU2htqGlbEcDLxG+AmwnkDK1o2Hd6KgsQUp7CfpYnxI?=
 =?us-ascii?Q?vBibeipHUiUXxVO88vq/xmjIrEAV0qrEbsYpTWw4vyfhy2oNCfdolEdl/So6?=
 =?us-ascii?Q?SXlPumu+dFNK3xLYTOZdNNzAVvQ9CDXbcsdwiUDMsK8VZQZc7tGT/hfsEx3p?=
 =?us-ascii?Q?Ex8of9Okc81IULSfsFr8fe9gu3HxL3vvMM/UbKLjN1+ZZJ/QEEqS3F45RY2u?=
 =?us-ascii?Q?pDNlAnRQZGcI6YY+Hp9fnQwex9QSPkDlgyuHz8q7qqnCVouwUmpW1RMYx0/A?=
 =?us-ascii?Q?epAVXyz3fbCC2POPgg4SbcOLBzLDPXesP5lGg/d9VHZYe8zN/bz3XMShnpoH?=
 =?us-ascii?Q?SJHVUb2d6N2tGYNnHsH67pLkfZkHVCKUWUXzFT9INNUfMXquqZ4CEVcAYl4h?=
 =?us-ascii?Q?cFfrJPrhAKkXSgnzKM+UYpnqZovjTKU6cIEgeGr6oyvQDT1TzBDtLV11HX9X?=
 =?us-ascii?Q?cc2lQXCBotm2FNeu52dEgzgyzVMqvEGgbx0QJzujgr1QcwOGn0DJAWpkUkKq?=
 =?us-ascii?Q?5MYuGVsbAgafHZ9jr5Ix9yWy0nTLLXkdtqARByUgYr8pMHJtY+LdozWBALPh?=
 =?us-ascii?Q?anunTtAfha6zXj0qha4MOXNyljqUIxRR2XWDpyxJFK2LtlGkRI1VwnhjlU+i?=
 =?us-ascii?Q?1+1eee+fznbrcvkfDep6OPMESSrig4V7NlGZ8Nyso5bRbMVWdYSXSi1M4ZsU?=
 =?us-ascii?Q?NDtjHDg91w+f8G3zKCihASpd5XuvUMH0pBH3yFlxEW4K+WDtL3S1LON4uB9q?=
 =?us-ascii?Q?NygJ8z7lzZNaUypGoBoTif2+Inl24puCxo3rknJyOrFdZfakYIj8repOe3Qn?=
 =?us-ascii?Q?dgNlbcFLDgfMwdNhcAImZGW2iVg5lLfrn/49x/UqxjoNUDBMGP14SUk04DaJ?=
 =?us-ascii?Q?rrEykn2HTYDeZQA1gwyfNEclt7J36exKTbZYcnPXk659x5ZSFRRRraY9Q+bG?=
 =?us-ascii?Q?lZAAFtJ0rDVSNze9vqcpTMX85JvpC6pZRk+otJH1lIf1php1GOPgY6k1kr0Y?=
 =?us-ascii?Q?Dhcfwnrajijq6/uOmnFFTuYdPfYAUbHuX5jl0VOw/H39y56Quc0W0Rm8S0tg?=
 =?us-ascii?Q?LBlwwY/mD9pC5xPQuOpg/+VP1sfGusGimysrNUTeU5r9BI9PlTTVg4x6NfDy?=
 =?us-ascii?Q?UmwRE4HAAHX57r6IMTz3m/XSdxUlmzzI4HUrH5jjVLY+stJIquCvR7CITcI5?=
 =?us-ascii?Q?dr+SC4uw0WzXELZncDinzqvtnnACmQuyTCK96wSpYdwIShkHmv142Xkdp1Wb?=
 =?us-ascii?Q?P1SxR+ybkKaewj+lunboQUTsHKfj1r0smPKXtJFX3tyA94Ar0x4crxAZAKXm?=
 =?us-ascii?Q?oNarreZn4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ee8e0b-c0ed-484d-e2fd-08df36350f9c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:22:43.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvAX6RBJTXjV+pQQifsUS5hdaeITtR726Wn0bEhheJXQWQeTAaXd5hOSeWlXaLYom2WpVl0xZpAF4LXoIa0luw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

On Thu, Oct 29, 2026 at 02:56:57PM +0800, Srirangan Madhavan wrote:
> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
> 
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>

Hi Srirangan,

Can you explain this part explicitly ? I find it inconsistent with the spec.
More details below,

 
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
> ---
>  drivers/pci/cxl.c             | 245 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h             |   5 +
>  include/uapi/linux/pci_regs.h |  12 ++
>  3 files changed, 261 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index b992f71d964a..bfc31f821d01 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -3,13 +3,17 @@
>  /*
>   * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
>   * memory device at enumeration, so it can be restored after a reset without
> - * a CXL driver. HDM register formats and programming live in drivers/cxl.
> + * a CXL driver, and implement CXL Device Reset. HDM register formats and
> + * programming live in drivers/cxl.
>   */
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -219,3 +223,242 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  {
>  	cxl_hdm_cache_release(&pdev->hdm);
>  }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +#define CXL_RESET_MAX_WAIT_MS 20000
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +/*
> + * CXL 4.0 section 9.6 permits using the device cache size to determine
> + * a timeout. Use a conservative fixed estimate of 100 ms.
> + */
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec,
> +				  u16 set, u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl2))
> +		return -ENODEV;
> +
> +	/*
> +	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
> +	 * that remains set in the value read back while updating persistent
> +	 * Control2 state.
> +	 */
> +	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> +	ctrl2 &= ~clear;
> +	ctrl2 |= set;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		return rc;
> +
> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	while (time_before(jiffies, deadline)) {
> +		usleep_range(CXL_CACHE_WBI_POLL_US,
> +			     CXL_CACHE_WBI_POLL_US * 2);
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (PCI_POSSIBLE_ERROR(status2))
> +			return -ENODEV;
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;
> +	}
> +
> +	pci_warn(pdev, "timed out waiting for CXL cache writeback and invalidate\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return rc;
> +
> +	return cxl_reset_wait_cache_wbi(pdev, dvsec);
> +}
> +
> +static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
> +					  u16 saved_ctrl2)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc)
> +		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, CXL_RESET_MAX_WAIT_MS);
> +		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +	}
> +
> +	/* Allow one retry after the mandatory 100 ms quiet period. */
> +	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
> +			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
> +			     CXL_RESET_MAX_WAIT_MS);

This part will make 100 sec clamps to 20s if I understand correctly.

However the device is still legal to advertise 100s timeout according to the
spec. If the reset procedure takes longer than 20s, driver can read/write to
"Control2" register while device is still resetting, which is prohibited
by the spec, software should access only "Status2" until completion, error,
or expiration of the advertised timeout.

I wonder what's the reason here, if we really going to disagree with the spec,
though I think it's not a wise choice.

Best regards,
Richard Cheng.

> +	pci_info(pdev, "CXL reset timeout: %u ms\n", timeout_ms);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);
> +
> +	for (;;) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (status2 != U16_MAX) {
> +			if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +				return -EIO;
> +			if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +				return 0;
> +		}
> +
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	}
> +}
> +
> +static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
> +{
> +	if (initiate)
> +		return cxl_reset_update_ctrl2(pdev, dvsec,
> +					      PCI_DVSEC_CXL_INIT_CXL_RST |
> +					      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
> +					      0);
> +
> +	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +}
> +
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	if (!pci_wait_for_pending_transaction(pdev)) {
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_clear_memory(pdev, dvsec, true);
> +	if (!rc)
> +		rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
> +	rc2 = cxl_clear_memory(pdev, dvsec, false);
> +	if (rc2)
> +		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
> +	rc = rc ?: rc2;
> +
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	u16 saved_ctrl2;
> +	int rc, rc2;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +		return -ENODEV;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (!rc)
> +		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +	/* Restore cache policy after any attempt to disable caching. */
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	return rc ?: rc2;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	u16 dvsec, cap, ctrl;
> +	int rc;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -ENODEV;
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9e218f236e66..743e65abd758 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -733,9 +733,14 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCI_NPEM
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ca3e77b72d87..7224857c7b30 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,10 +1352,22 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
>  #define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
>  #define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> -- 
> 2.43.0
> 
