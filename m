Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959607;
	b=RHKb21SOjtRS1hF6f7I8qeRAGlxCaEs9/1tkcO4jL/0N4KnVvkvBmp78f7PHEn5hkW4v
	 SQfNdQbqmdlMOBFuexJqmcdxW87OmNJSJSkCjKmH7ZY1Mh/lqhL21AxsiD/0KM0ZJc8Xn
	 SPXTxMQ+z5Mw0zyT/GFSo5ghSCi52dtWFHpJt/g1ziVPx0x81epbagFgbupJi/GWJmVaU
	 XKBDA1OEcTYDjxE2Wp5wrAQK+dYC3GnxFcAlm4I8eX9hxORBqKofiPuMWFGvme2he0syr
	 X/AnFD2EDR2ysFmtoyDejcmg5wnPk0EEyuXkjjA6ejgc0PC5gwE5ulzxRG20mhBfq9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959607;
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
	bh=6mCRfscbXK6E/EFyXm6m9CSv3sGCafwrGklUTr+5/iY=;
	b=ry+f3S5Q4nHboJAWKn8mRszZ94yX62UIkuYkEozJ2Hl8a4Oc8TLOSrTnE4d7oBuQ0EYu
	 dTjKYTSKMkQSRZXYmQxouyF6e5w0VWYWyoe2uN724JJElSQPV9VpZrQGtk3J65ZbA2DfB
	 KH6vmTxzDc9Lmkq4WYt1LrYJxzuUvjKTQGmYivG7m8unBhkO5GJhAL+PRBkS4a7UzGOd+
	 W5ETuMmd4JuD/82xbEAHQfF2IGn+PBPQp/xeAN6jANTvckoKDR5wlbaIB2OTvsTuKcZSI
	 G8c6wDzoy7pTQBdTWnooH4FNRlFgKnJNW1e6CFV+GBxkyEZm1aaQ1duElTSYaojvFJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pqNwFoRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.61
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BD606A326;
	Fri,  6 Nov 2026 10:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131BD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pqNwFoRj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOQ08xHwT/w0LYggYXbbSgqmFI7U+hOVB1XpGohETFqtCV8aulKghzajI8dB/4sLcfgtRsWbfWin2CzQ67Pax8UYyIcYphJn+YPqYetD6i265g4PQCo5orqFANWnCN8wX17AhhSikOwYKbkr0cmCmyYY3uKmDejwLTdIONfsq2le75LrZ1l6UNyghYGDiqGv1HmOT6h30gux7GXp94kYjFA03G/WiLwmgBwmMSj8D3XcY2bjt8Di6xpksxkacWWTYMx6VmHUSTMbE9AxoG6SNpe4713R80SgfbbHYvmuZO7xcEKlhJdgw2UA98f1DPXR/9octpqK3TF5USu5eoyE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mCRfscbXK6E/EFyXm6m9CSv3sGCafwrGklUTr+5/iY=;
 b=DYcDcPz4KJnmQWkXbKxeDXcw3BKcCYeFyzDdHxA+kRyF7GZgAzn2GNpzt/GRHc/dUTVBjrByqTZZcvrMDHnlUq57wtQRwAzbmBjUjxuHYJ88DkA5BcxYYmGJy8P+slFgEG73yCK9X/TONSvw/i1rDMoXvPfXULXDcQ6YH3KpkxfEW+kOEbNF0b9hTq+PQsLv740mj6MrUnO7bXyEjTMXkIpY5pijsOO8+JRWOqZ961lUgqELwjFrYVegyB/Qb3Dd5GdJTaEGe+O0zjFp1DcBoB0GhyI3Wc/fp5fwsMqXDRmLqaJNf2dwXgmDdMpbmrZaYQndArK/9u9ScD7Rcdih6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mCRfscbXK6E/EFyXm6m9CSv3sGCafwrGklUTr+5/iY=;
 b=pqNwFoRjXLjHTZ3xCgTcf+EX7eNqIbm2v1CVHoO0gEM3CjK/4br4zBzgHqGGhK0bBwSheuRSFhrF4ArZuTvdbAWWWziH9ExvW9+5pIDCNM5/CMKP+KK8E5WremkzVzGnPqdEqKsF1HeMY8xZWfV8caJyHZpvCzgn84fiEsU+Iqr2f6QT8ZyC5aC653GneT0+CRLtPiTyGIFS6YWd3lk1UjoUjHDmdboHLQtd0EmNIpdDnp+ouqOv7H79gfxn7pPMJ4zZO/LE8YEn8/E/Ye/3FIUMjGAy6w0mAVGTP0ZTHthCD6itoQ8xbHbPkTM9ALR+UVGMbHY6Nshpchp+JGyjvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 10:06:43 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:06:43 +0000
Date: Fri, 6 Nov 2026 18:06:35 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, jgg@nvidia.com, 
	aneesh.kumar@kernel.org, aik@amd.com, yilun.xu@linux.intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, bhelgaas@google.com, smadhavan@nvidia.com, 
	ilpo.jarvinen@linux.intel.com, Smita.KoralahalliChannabasappa@amd.com, 
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev, terry.bowman@amd.com, 
	nik.borisov@suse.com, brads@mainlining.org, lukas@wunner.de, rrichter@amd.com, 
	gourry@gourry.net
Subject: Re: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Message-ID: <au2j8EmUZmyeNs1h@MWDK4CY14F>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-4-ankita@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105152909.53452-4-ankita@nvidia.com>
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 977b56b1-71cf-4b14-c0d3-08df3beda830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261026121527099003|56012099006|11063799006|4143699003|261009223027099003|261022105027099003|261028144727099003|261021123027099003|261102123227099003|261026140227099003|261021121427099003|261102130727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	dqc80GCcs8Jwi/Z9vLDX0Am/V+t9tlPuGp+YlTItViOe/d/rM7PJ8V0pgvyQ+V5Ud4FZmsfj99PXuFGy2wV1sZx/m9LTheL+/ckZ2NPr7/o3oMvhVuxBIMvZysh8zzSbYZVT9GNDwXYvCOL09xq+qU6ELlTDsQ+q/8Xwn/4ZLJ2vL2zKoX5CLvF17SeiSCELpnvCV0upx0JV4SDzHCLKWfNLf1Le6E4C1t1HaTInUm6GAS24DUDrA8HcBnfsXsPXSjwCUxo5qrj5ezlUQMPvXkMqZxh9rf0Mom/6yRWZFp/uWQNSgpJc4DXebjKnfPGSj1CvtB8c2/kMnLiM94dI1et3SGL35BNVCY3eCYhXV/wX4E1b3dmW4/W/CoR5tBRl8cEK9GKZ4XXMngYwykVXXXbOUQ276o9xQ4y5p9NoKfWjP2Rd062g9iOTaqxSotJhrGWGschQRBVXvaSPIhh1TYY17wmxJtzxpvy34nsMIE/yRbkytQd9aBb0Gc8aksT1KqbopZRUlA8ZlUDL4gsBWJ0xCspF77hofY7Q/eiNsh/Zv6nMFbt+ksd2QQkhSpXfRmh5UCMcPwffni9PB0G6rHqKXrlw6sMKcbUvZbfSbTYknhk0gh1oy6lqao5OGfjj6PalWhft+A7w8bru+C0ZiKGACzLMRIIGS69FEyct//8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(261009223027099003)(261022105027099003)(261028144727099003)(261021123027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261102130727099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pca4tF//ygUmvVV61kdeQD2NngcE2GtMXHBx3WGeWlSNgE9Rv3fWjnEo4u4J?=
 =?us-ascii?Q?B1nDTyXUiMa+zMxmpBuxZQcyDqX3MY8V0K/X3msThaqSlXsnwUCoP7zhqpMY?=
 =?us-ascii?Q?Gv3HsferuPWmQNx9lCXe1WHyfkmWucrX5wEAWOvnoCLO+ilPo6MHFJl7hHMS?=
 =?us-ascii?Q?Lov5vqZi8yG6pNHWi7HOjpyft66csD9A5HclhbBOuban60SPzUjBnyPAgdH4?=
 =?us-ascii?Q?RO1n3rf88gZh6ylAbL/2Hiijpxo+FWi79aUtBUZcPekoVapcn8QXo7dlEMoc?=
 =?us-ascii?Q?C1fgJ4krjtlYEPS8q7Fv+bkqNanpVx+tsmuGTDUtfZNG7VBNSEFTA3u2p54d?=
 =?us-ascii?Q?2TQWIvwBn1JtjdIZbF/8pUmpJM/IEXxOgi5A7sRlA5rL6XnvTllwDqLt0AuT?=
 =?us-ascii?Q?kXzSSuEQtGf/r2ztbMKMM3HYJb2xMOT0FduCwdiUGbP7KqUdRWJ8LQbZw/lF?=
 =?us-ascii?Q?gNoJva5bDOoYQAVVmlsuowoRFikdo/VlhWIjxIgyVi6tAv+YOp6KPWUBFFST?=
 =?us-ascii?Q?QWpHLJKjnREG4UtSo3UVKfug1yXWtHnX9j0e34dGlo5TyyvOwrWnbDfDMuEU?=
 =?us-ascii?Q?2rohWEANrHDEKHZFdb+hGOjTiJsF+dpybwCv2pJktRTSB8blVggTHdByEc81?=
 =?us-ascii?Q?qdM5E7wLfH28bvec/Jkbm0kAWs35ZCFT76w9HKSclJMAVpern6oQQjcEQ00P?=
 =?us-ascii?Q?ltsZTCyrBPk5aHQblQ1R/C99p+wZEueH/Yk5ZccAWPgM0Xp6BNfBfZqGqHu6?=
 =?us-ascii?Q?GYs9XzjOKpozWtQ+DZNpNUb8J6PSwwa5cIoRcPSwKZ34BLAbgekZ9Ra4B5eM?=
 =?us-ascii?Q?bkg6ikZhMvarzacD2/+wo5E53Kb9oqJmVXzv5r31W9GinT3ODMS93E2WKBMv?=
 =?us-ascii?Q?XdBRfFRJYVkMrp4wGKMaqQHUKdh+ePcjqAVYB+JlhyL8PGwjkAiiql7jgIBd?=
 =?us-ascii?Q?+N24Fnr6Ube7PDbBCdgaeZfsdLO3yU9wug1Dvqr7yYqem3BsDfQef73iKsCa?=
 =?us-ascii?Q?3apuIbeduIA+m3VhYh312s/9OBFu73enRZiDD9B2YkV9OrQCmo+s+pfqk7xI?=
 =?us-ascii?Q?+V88kXjXb+WNKJcdaz5M2+e+daXrpK/FM0H336rW2celwKm0AKtnRgeC75ws?=
 =?us-ascii?Q?U1KW2gm7Orf8os3Vj/nW0ft3bxbG6+W1n89RAtPypFB1L3B6DC4yUw7khCxM?=
 =?us-ascii?Q?W3W6srU3vFqwlhffBUT4feQNTyZQ1m7+4yAhfa+jmdn0U0ft0Wg0jYSBxpau?=
 =?us-ascii?Q?IWJU/7u9glcsNTsnwvxdwMcWCTeF2KhfKm3iFRTltrmU4bE8D0dXJUBLDEoK?=
 =?us-ascii?Q?lvCemXL48eFKBPWnbbWlxv4T09HiC0cg+uorFj+pnV+rpSBOv1jfy8o+Myk5?=
 =?us-ascii?Q?zrAFp6SWPgaCKb897R+7Z3y2/Y6ESMJLv2Fvm1TAQf/7mJSCHLVNx5z8o5YI?=
 =?us-ascii?Q?dIEApDsZebH32g94FFqbmeJF5k/XzIVUsEau8hfVcteorK3vIvs6KrIDXp6b?=
 =?us-ascii?Q?AMiVHguqgAx6jBSVOqRcomYIVIZmBHbkVwP0zaw6rUSoEWqRStn6Kyi+jR+W?=
 =?us-ascii?Q?k3JRg9pxV+jMlvHP6517Cu+hqyO9QPoi2I6fx/ooPo7e+K57LzNvvQU+l3qR?=
 =?us-ascii?Q?JQRBUPQACY2duhEDpylm2WbtklezNNmHfs7fXshwqHGAj8SZqL5j14YiqhJP?=
 =?us-ascii?Q?pEeUPHlb6RT0uLHKgk030Je49lby/3HV/cXhwSpST4JPQ+9ztmzIKso2R2A7?=
 =?us-ascii?Q?81bXEiSx9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b56b1-71cf-4b14-c0d3-08df3beda830
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:06:43.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCLSk+C+CNK0LcpweWxYkOKf3xE0KIMZ50c4LV5Uf/uVrpYehLgxNMV6V1hDSKu++S+9R8RqvdHcWq89vkRgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

On Thu, Nov 05, 2026 at 03:29:07PM +0800, Ankit Agrawal wrote:
> The DevIf report range with range ID 0xffff describes the device's
> coherent (CXL) memory window and unlike every other reported range
> carries no BAR number. Recognize
> PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT and recover that window's
> address from the CXL side of the device instead of treating it as a
> BAR-relative offset.
> 
> pci_tsm_retrieve_coherent_range() resolves the window from
> pdev->coh_resource[], snapshotted once with the committed CXL HDM
> decoders range. The range to IPA conversion is applied onto
> range_base/range_len using pdev->coh_resource[]. The ascending BAR order
> checks stay on the BAR path only. The coherent range is required to be
> the last report entry and is not part of the BAR sequence.
> 
> An HDM decoded window lives in the CXL Fixed Memory Window and is not
> part of a BAR. So by construction, no pci_dev resource contains it. So
> the function pci_tsm_coh_resource_contains() validates the range against
> pdev->coh_resource[] instead; the same known-good snapshot
> pci_tsm_retrieve_coherent_range() already trusts.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/pci/Kconfig     |  12 ++++
>  drivers/pci/tsm.c       | 119 ++++++++++++++++++++++++++++------------
>  include/linux/pci-tsm.h |  75 +++++++++++++++++++++++++
>  3 files changed, 170 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 16fbd4212e0f..22c416c84a6f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -139,6 +139,18 @@ config PCI_TSM
>  
>  	  Enable a platform TSM driver to use this capability.
>  
> +config PCI_TSM_CXL_COHERENT
> +	bool "PCI TSM: CXL coherent range support"
> +	depends on PCI_TSM && CXL_RESET
> +	default y
> +	help
> +	  Enables helper functions to manage coherent regions on CXL devices
> +	  for TSM. The device CXL coherent (CXL.mem) ranges could be tracked
> +	  and fetched across subsystems to be reported in a TDISP Device
> +	  Interface Report.
> +
> +	  If unsure, say Y.
> +
>  config PCI_DOE
>  	bool "Enable PCI Data Object Exchange (DOE) support"
>  	help
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index d074bfd18d40..bc3218c58ff0 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -939,8 +939,9 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>  		return -EBUSY;
>  
>  	for (i = 0; i < mmio->nr; i++) {
> -		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> -		int j;
> +		struct pci_tsm_mmio_entry *entry = pci_tsm_mmio_entry(mmio, i);
> +		struct resource *res = &entry->res;
> +		bool coherent = entry->flags & PCI_TSM_MMIO_F_COHERENT;
>  
>  		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
>  			break;
> @@ -950,13 +951,28 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>  					     pci_name(pdev), IORESOURCE_MEM,
>  					     IORES_DESC_ENCRYPTED);
>  
> -		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> -			if (resource_contains(pci_resource_n(pdev, j), res))
> +		/*
> +		 * The coherent (CXL.mem) range isn't BAR-backed, so check it
> +		 * against pdev->coh_resource[] instead of pci_resource_n().
> +		 */
> +		if (coherent) {
> +			if (!pci_tsm_coh_resource_contains(pdev, res))
>  				break;
> -
> -		/* Request is outside of device MMIO */
> -		if (j >= PCI_NUM_RESOURCES)
> -			break;
> +		} else {
> +			struct resource *r;
> +			bool contained = false;
> +
> +			pci_dev_for_each_resource(pdev, r) {
> +				if (resource_contains(r, res)) {
> +					contained = true;
> +					break;
> +				}
> +			}
> +
> +			/* Request is outside of device MMIO */
> +			if (!contained)
> +				break;
> +		}
>  
>  		if (insert_resource(&encrypted_iomem_resource, res) != 0)
>  			break;
> @@ -988,6 +1004,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
>  #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
>  
>  /* An interface report 'pfn' is 4K in size */
>  struct pci_tsm_devif_mmio {
> @@ -1043,6 +1060,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		return NULL;
>  
>  	for (i = 0; i < mmio_range_count; i++) {
> +		struct range window;
>  		u64 range_off;
>  		struct range range;
>  		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
> @@ -1053,33 +1071,58 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		u32 attr = __le32_to_cpu(mmio_data->attributes);
>  		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
>  				    attr);
> +		bool coherent =
> +			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
>  
> -		if (bar >= PCI_STD_NUM_BARS ||
> -		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> -		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> -			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> -			return NULL;
> -		}
> -
> -		if (last_bar > bar) {
> -			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> -			return NULL;
> -		}
> -
> -		if (last_bar < bar) {
> -			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
> -
> -			/* Transition to a new bar */
> -			last_bar = bar;
> +		if (coherent) {
> +			if (i != mmio_range_count - 1) {
> +				pci_dbg(pdev, "Coherent reporting range is not last\n");
> +				return NULL;
> +			}
>  
>  			/*
> -			 * Determine the obfuscated base of the BAR. BAR
> -			 * offsets are never obfuscated.
> +			 * No BAR names the coherent range, so fail closed if
> +			 * neither a CXL region nor a committed HDM decoder
> +			 * resolves its address.
>  			 */
> -			reporting_bar_base = tsm_offset & ~mask;
> -		} else if (tsm_offset < last_reporting_end) {
> -			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> -			return NULL;
> +			if (pci_tsm_retrieve_coherent_range(pdev, &window)) {
> +				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
> +				return NULL;
> +			}
> +
> +			reporting_bar_base = tsm_offset &
> +					     ~((u64)range_len(&window) - 1);

Hi Ankit,

HDM decoder window can have non-power-of-2 sizes, why do we assume a power-of-2 size for
coherent window?

E.g. if we have something like the following
Window start: 4GB
Window size: 768 MB
Reported address: 4GB + 256 MB

Assume MMIO_REPORTING_OFFSET is 0, so no address obfuscation needs to be removed.
The reported page is simply 256 MB into the window.

For this size, the mask leaves the reported address unchanged.

0x110000000 & ~(0x30000000 - 1) = 0x110000000

reporting_bar_base becomes 4GB + 256 MB, rather than actual window base of 4 GB, so
range_off is 0.

The fianl address will be window.start + range_off = 4GB + 0

A KUnit test against your patch series can reproduce this.
Furthermore, pci_tsm_mmio_setup() accepts the wrong result, because the incorrect address
is still insdie the window.

Best regards,
Richard Cheng.

> +		} else {
> +			if (bar >= PCI_STD_NUM_BARS ||
> +			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> +				pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> +				return NULL;
> +			}
> +
> +			if (last_bar > bar) {
> +				pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> +				return NULL;
> +			}
> +
> +			if (last_bar < bar) {
> +				resource_size_t mask = pci_resource_len(pdev, bar) - 1;
> +
> +				/* Transition to a new bar */
> +				last_bar = bar;
> +
> +				/*
> +				 * Determine the obfuscated base of the BAR. BAR
> +				 * offsets are never obfuscated.
> +				 */
> +				reporting_bar_base = tsm_offset & ~mask;
> +			} else if (tsm_offset < last_reporting_end) {
> +				pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> +				return NULL;
> +			}
> +
> +			window.start = pci_resource_start(pdev, bar);
> +			window.end = pci_resource_end(pdev, bar);
>  		}
>  
>  		/* Per spec the tsm_offset never results in overflow / underflow */
> @@ -1090,19 +1133,21 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		}
>  
>  		range_off = tsm_offset - reporting_bar_base;
> -		if (pci_resource_len(pdev, bar) < range_off + size) {
> -			pci_dbg(pdev, "Reporting range larger than BAR size\n");
> +
> +		if (range_len(&window) < range_off + size) {
> +			pci_dbg(pdev, "Reporting range larger than %s size\n",
> +				coherent ? "coherent range" : "BAR");
>  			return NULL;
>  		}
>  
> -		range.start = pci_resource_start(pdev, bar) + range_off;
> +		range.start = window.start + range_off;
>  		range.end = range.start + size - 1;
>  
>  		/* Only record the TEE ranges for later consideration by ioremap() */
>  		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
>  			      attr)) {
> -			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
> -				bar, &range);
> +			pci_dbg(pdev, "Skipping non-TEE range, %s %pra\n",
> +				coherent ? "coherent range" : "BAR", &range);
>  			continue;
>  		}
>  
> @@ -1110,6 +1155,8 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>  		entry->res.end = range.end;
>  		entry->res.flags = IORESOURCE_MEM;
>  		entry->tsm_offset = tsm_offset;
> +		if (coherent)
> +			entry->flags |= PCI_TSM_MMIO_F_COHERENT;
>  		mmio->nr++;
>  	}
>  
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index e54ad057fa8e..7c29f10e7795 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -1,8 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __PCI_TSM_H
>  #define __PCI_TSM_H
> +#include <linux/bits.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/range.h>
>  #include <linux/sockptr.h>
>  
>  struct pci_tsm;
> @@ -199,15 +201,20 @@ enum pci_tsm_req_scope {
>  	PCI_TSM_REQ_DEBUG_WRITE = 3,
>  };
>  
> +/* The range is the device's CXL coherent (CXL.mem) window, not BAR-backed */
> +#define PCI_TSM_MMIO_F_COHERENT BIT(0)
> +
>  /**
>   * struct pci_tsm_mmio_entry - an encrypted MMIO range
>   * @res: MMIO address range (typically Guest Physical Address, GPA)
>   * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
>   *		Translates report addresses to GPA.
> + * @flags: PCI_TSM_MMIO_F_* attributes for the range
>   */
>  struct pci_tsm_mmio_entry {
>  	struct resource res;
>  	u64 tsm_offset;
> +	u32 flags;
>  };
>  
>  struct pci_tsm_mmio {
> @@ -227,6 +234,74 @@ static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
>  	return &mmio->mmio[idx].res;
>  }
>  
> +#ifdef CONFIG_PCI_TSM_CXL_COHERENT
> +/*
> + * pci_tsm_coh_resource_contains() - check a coherent range against the
> + * PCI-core coh_resource[] snapshot
> + * @pdev: device owner of @res
> + * @res: candidate coherent MMIO range to validate
> + *
> + * The coherent (CXL.mem) range isn't BAR-backed. So pci_resource_n()
> + * containment doesn't apply. Check against pdev->coh_resource[] instead.
> + *
> + * Return: true if @res falls within a populated coh_resource[] entry.
> + */
> +static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
> +						 const struct resource *res)
> +{
> +	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *coh_res = &pdev->coh_resource[i];
> +
> +		if (resource_type(coh_res) == IORESOURCE_MEM &&
> +		    resource_contains(coh_res, res))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * pci_tsm_retrieve_coherent_range() - resolve the device's coherent CXL window
> + * @pdev: device owner of the reported ranges
> + * @out: host physical (guest IPA) range of the coherent window
> + *
> + * The coherent range carries no BAR number, so its address comes from
> + * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
> + * decoders.
> + *
> + * Return: 0 with *@out set from the first populated entry, or -ENODEV if no
> + * entry is populated.
> + */
> +static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
> +						  struct range *out)
> +{
> +	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *res = &pdev->coh_resource[i];
> +
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		out->start = res->start;
> +		out->end = res->end;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +#else
> +static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
> +						 const struct resource *res)
> +{
> +	return false;
> +}
> +
> +static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
> +						  struct range *out)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_PCI_TSM_CXL_COHERENT */
> +
>  #ifdef CONFIG_PCI_TSM
>  int pci_tsm_register(struct tsm_dev *tsm_dev);
>  void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> -- 
> 2.53.0
> 
