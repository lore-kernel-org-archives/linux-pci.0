Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8E3B1ED0;
	Fri, 26 Jun 2026 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511737; cv=fail; b=fZzZ/bCvlld+5TGMHbObDacjfeRogfJ5puOpGwErnakF6eeGDt7p6OLqOGyQBzjZkQv08zMo2Oh5E8NdN0cX/btQY/I+RFcKzuo11wgfte/IITpn8u4NScaeEjRt4U8vwFSQEQ0FZQKLNfcCouyGN9fPOHxFXQk3zhvb9Vhj5aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511737; c=relaxed/simple;
	bh=JF/sFl352Lmy+vDkfcWowQdsyRy69dSxCG4APUF5eDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9UhNGg9mXKQ9sdqAga4QXFTeHN6IaHSwlL4YMsQIw4lLsF/lkFY5o1TNEc1ISlm2OUu4xOxrXp2MTBih3I95mXonOJLS9geKIxNs9kCOzAluYW51JwnY8HxYxZaVTThCNVI/s1FG0lCfq41RpVSXxRPxNprpAuR6qI5CBEegjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qn+3hR6b; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qn+3hR6b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuXzBDlKJK1OZXDU0Q8yMiIk/Xhbuv4rgknVVnLfEJh0xrptID6SjUDps2HB56/3v+w7VnenG4F9AaeyuA+8b6CbEEhR3LVnQRAgdjH4lJlHPB0KgRVpDlJYXe0T9OFWB9JGsMuzYReOs8YpfJz9176OyygEaCRKyie8nzAEI8JXLQoWVvEJKYFBWfnZSxAey7NvWGvE82WtoN5dKNKhEBW0HSelD8lmS+/vSYqHPt6bGacqh4/Q+153h/r0mwY6Uj9iItLKro7vGphAtrlfNUjoimRBEdoDktOA8VMoNpf/Pm3TXRtJ0x/1ui+1ZrAcFbsgWr+mshwgAvT806hXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Cu2b4K/h4v2OvOq/Er0xdE6PBB3h+UWnUgMCUyz8Ts=;
 b=gcZf5437G0M2mJ3gFbmNxiOvDv6k9vOCIcp+lK1XpX8SksXknj/RkLW4k+64GO5cKVh5ZvF7LT9X2DPw+Bo0oon8OxTn4i94kzB88H0EWmZTeWwVHmcAc9Cpj2E2p69aYipqLqPo6T1hmX8JhRET7lzrjEQvkc0kIx/OMDlHOQlnNf0qb+hsY4051C3NY0S40fqcxsk/mOPImLkORs2NtjlJX+N+zIceomuq5gjvzLpIPWSauhRgYyD1xSw0X+NYG/Lr6zhMnRCpyScTc4BZNAe7Od1z4g1Fvrq36bJxLI2k72/KmnhGWB9BwPi3+Ufw78Kk/JRRdQy56G80aik3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cu2b4K/h4v2OvOq/Er0xdE6PBB3h+UWnUgMCUyz8Ts=;
 b=qn+3hR6btmjiL9wfEhq+aSi6R2Z2yW0HNAlVFsfj1DXbNfsYtTx6RvJFmGM7pVa9Sxtxb6oSAhdfiqY6BcfIGWdxuJkEbWWd/ZW1ot9/+WX3Hv4TT9L2Ai56vH/FvsdcMbvJIGq+2Iglbs+p+4gyjvuK52ZBY+tAfPkRHnJHJ3sLnuF50mv3Yq5/ctZ8zPx7xqJZ/QqaWDMWMM8stxKGTS6g1v+oSTb1FL8Ocz0zHLBqqGFbB7o1Nirx9bkED5N7Hxos30dPWXw4v8Z+Jnc+uA87v8nFqPUO3fsfkCGTF0KeEWd9M3B2fvu5T9CDvud6yslIvAMWEIcZQLWzF63nLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 22:08:51 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 22:08:50 +0000
Date: Fri, 26 Jun 2026 16:08:46 -0600
From: Alex Williamson <alwilliamson@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
 <alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira
 Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal
 Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, vsethi@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
 <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
 <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
 <icheng@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 08/11] cxl: Coordinate sibling functions for CXL
 reset
Message-ID: <20260626160846.426e71b6@nvidia.com>
In-Reply-To: <6a3b100798704_3c9f100a9@djbw-dev.notmuch>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
	<20260623032453.3404772-9-smadhavan@nvidia.com>
	<6a3b100798704_3c9f100a9@djbw-dev.notmuch>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0126.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::10) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: ceef85de-b566-4ca6-e69f-08ded3cf809d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|4143699003|18002099003|22082099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	A0E73CjKtd6qpE6v3Bg6lPcxEVZX+6CYysn1GHItagB3Y1wIto3Fdvd2RsWEj61ovq/rVtJTyUvu+hrx6LPnINwMzKjWBUdlKPuR7DAYTygLDvkxKDXDmLsUhbQy1m9o2nEpyMi9Hi1jQZpTcicqoZSb12ZhuBmBi9AKEEXK1+roQyrpDoGiYDwu52Kisaq4teoDsmU+D+H4QHdrgwKbtLYb38OXaUEg5NJ+3oEYvNVTdcT952mXxQpBjmCL0QdR+ZtKdXGsxGmgvhAaL/vVuFIgmzxtjBnMIWt6Af/CXOtus+XcJeuCyXjP9LINE8Sta/tnWmrcjicUyDasQp2FJRBotb5QyBmSI8xOxMxgPQzRXvQkHrxOUlRa3LGLtu1hM/Qr2Y4rEmny5Svcqd9NXcs7ubcc6RlVIGADcSm4ckREQuYUjQT7HUhfSL9FCOQWWWb0YPiUWaBNFt/DWewRN0UQo9QcRb+syKwH10vlRYjA1Bq/zcZlac0cj6Lo9Y3WSVHmbZv+5B9DEIri9JlgOLjaltRXOlmlofVm5nKN2THhDSt/ceIfvtOJ0SY+x+wEcI5eZGXStEg3XrffGsfbhB1l2XnyB2ylPyyzZSPKJx/Pr+/Hdu9k2qEQQUnldEIWMq3P1Xq5FOYivZS4EdlwKHr4jDKKWzrj9ruDGtWtHBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rn6CMvHzsCarUru1f5kTzLNu/qgm9wvKkZpJJyScXWebQBxWCumWfJvVlN0V?=
 =?us-ascii?Q?fHqrO6si4Z0aqJy6mHWO0jldcrq854o2KVdeFIHxWmCVhv998ccljGblTBJt?=
 =?us-ascii?Q?5SL8Q9B7G37rBf7r9G8ydY+bM6vm7OoIzVoUaVJxPQmx+/syPV/eldpR2Ncj?=
 =?us-ascii?Q?ZbAePwPyzKKY25Lkp1jX22Y71zXdUUIDl/YEiaEKaOb+VLqgbc0OpXZMje2G?=
 =?us-ascii?Q?Icbdw92qekv3J7N4eQIV4uTtO0h4UHZAgmE60jPXWw9yaYl/yRSsAplquuaq?=
 =?us-ascii?Q?t5Fkv1vkFSX6Uslf81A/ffTkx0HEVUlXwXtYECpSYC7FVArObFbYK+OFqhb7?=
 =?us-ascii?Q?naAqHFpJuAE3TlaIipYkSSeODBi2tgvnuyXw9OI9BUVePiFxkXKYQPE6e/PE?=
 =?us-ascii?Q?6Cg8XsxuJEurOXYSmOmWDqmC2avov8cCRyeWN+Zl/Vox+h+wHzjgUu9LGs78?=
 =?us-ascii?Q?bS5H+zhgA1PJWVhODkujeS6iFJmHzhLYUEVXYE+kfzHVb5irrQ10n1QVqsMy?=
 =?us-ascii?Q?G1FhiIHmLbMohgLpSEil9vOI9E5JocsDB+UKnRZjxwPaZ8Efq6j3igTbBMyv?=
 =?us-ascii?Q?eRzMzJv5mxkEkkgGeAb6XAaeYZJSYdQP7hkRFIUE10RpKSFL5aog/l9IFJ0z?=
 =?us-ascii?Q?iVNayg2r94zuOdzqNZJZkw1A9XpFgjPVK7mFjOq9EtQitwzZblZfFTIJocNq?=
 =?us-ascii?Q?nhChRQ5z0JKE1mJbYWcRz4T0jAKGlMJYKTI9OkwZBPVvW6jki+PiFmX14EWH?=
 =?us-ascii?Q?tPpE2VkXBUHU63BlFqOvVcfsEm5dskFMEr1KaRHeQt4OQnqoGBO9ugQQXAxy?=
 =?us-ascii?Q?t060tsXYr1QxTW3H4qhkf/5EHwI6zwbsq4xMUT6kxYxTihu3UnNL+kC6oJoK?=
 =?us-ascii?Q?69x6otqFSH6rxXyQOIK2Xh6/EXD4byI4wJPyS+aR/fFLD7AXOwdZ1l+HdWjf?=
 =?us-ascii?Q?sQj1HTm/6dQL6fgCYCT+K5cspY/vamsGHeRYUpwMCy1uVmYl/3rOBq/FrMyS?=
 =?us-ascii?Q?8Xw0qkgLQS0U9Wk1eb8N49Rc2a7cZlujRnj4oJ4MKrEGo1zQvr4+ClZ3Wto1?=
 =?us-ascii?Q?Um7QBeuYrU5h3wIjfnPJViwe/nlr1YLrV3zzdH1/xqUBuITICPhoqlf0kUdj?=
 =?us-ascii?Q?f4g9YtwRa9qhgEqMTk+yEnmhMWUnWnLB5mSUs/yiCCzlhqymA/3LcqOA6uZg?=
 =?us-ascii?Q?xhrRxCCskhPbx+nxNY649DTMIyEpNakMRE2vOKVNXlhNmLkxPm7+qi8LDzQ/?=
 =?us-ascii?Q?SS3+xcQlMSnLwH3FeX0V0hRhXkoQHWw5mfjaKWQnrZM7Q3g2Je0inLtZE4ut?=
 =?us-ascii?Q?zXXrgEvoKLOftna+RKo7qUBpkA6x8oPceUVomH8NR0rZi9vojIxV/DALlzkg?=
 =?us-ascii?Q?aN89Afs++8pSit9bm2uDE/JGpYujRe4Pu5nBwVtVV7FZNcFH+1chQ119cHEI?=
 =?us-ascii?Q?XgfPn83uqsHuVvflzIXxaHoWWcMq7DdjheEBLFTsmwaz7ff2nsCRjlVsQQaz?=
 =?us-ascii?Q?i+kJTK8T4sFmzuzmgtQm4hhm/BWiNy0HeeGUHNv0Ii5k73KoT0HcTOTrDEMQ?=
 =?us-ascii?Q?4DIDyDKhiHgkneuzjaxRlNvnodGfQd7e/c8UuWDWDTKe3//4qtWfBGzbhETw?=
 =?us-ascii?Q?Iqi74zp0Z6IZKTXUdR6Oiy+5KOJZ1Rt22ha3LqEzbw8LSARxxph9XStEj4be?=
 =?us-ascii?Q?QeeZ/emu10+zwn/Bb29WNOk+lA9nxp+6FoQ6hNnaCbgosWbWzZdJp+ntV7Fh?=
 =?us-ascii?Q?xDPVAzfzcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceef85de-b566-4ca6-e69f-08ded3cf809d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 22:08:50.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/d8vf8SyLz5FQdUcjdk3dEmoASgVI2AjEaC+Yn5zl7lu8DW0Tc8YGyZyG7P3UDH5ITkBN2Mo/ccNcPw1kETBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

On Tue, 23 Jun 2026 16:00:23 -0700
"Dan Williams (nvidia)" <djbw@kernel.org> wrote:

> Srirangan Madhavan wrote:
> > CXL Device Reset affects all CXL.cache and CXL.mem functions in the reset
> > scope. Lock same-scope siblings with pci_dev_trylock(), save/disable them,
> > drain pending transactions, and hold IOMMU reset blocks until recovery.
> > 
> > Also include mem-capable siblings in HDM range validation and CPU cache
> > invalidation. Cache-only siblings are quiesced, but skipped for HDM range
> > handling.  
> 
> PCI reset locking and ordering is already a source of some burden
> without adding this new sibling model to consider.
> 
> Is there evidence that multi-function CXL devices, where most of the
> functions are non-CXL, is going to be a common occurrence?
> 
> In other words if CXL reset borrowed the bus reset locking model:
> 
>     if (pci_bus_trylock(bus)) {
>         pci_bus_save_and_disable_locked(bus);
>         might_sleep();
> 	rc = cxl_request_and_flush_hdm(bus);
> 	if (rc == 0) {
> 		rc = cxl_reset_execute(pdev);
> 		cxl_release_and_flush_hdm(bus);
> 	}
>         pci_bus_restore_locked(bus);
>         pci_bus_unlock(bus);
>     }
> 
> The cost is disturbing some non-CXL functions, the benefit is reusing an
> existing reset order / locking model.

I'd say further that this exceeds the boundaries of what
pci_reset_function(), or the @reset sysfs attribute per pci_dev, is
scoped to do.  pci_reset_function() must limit the scope to the
pci_dev (and in this case the CXL state associated with only that
pci_dev).  See for instance how bus and slot use cases through
pci_reset_function() are limited to non-multifunction devices.

For multiple functions, the precedent is something more like
pci_reset_bus(), where the caller is responsible for coordinating the
set of affected devices.  The locking is still complicated, but at
least it's managed in vfio-pci-core, with a variant driver that
actually owns the device, rather than pci-core.

Also note that there's currently no mechanism for performing a
multi-function scoped reset through sysfs (excluding raw access to the
parent bridge that bypasses all save/restore mechanics).  I'd suggest
that cxl_reset can only be available as a function scoped reset when
only function 0 supports cxl.mem or cxl.cache, but that may also lead
to the question of whether the reset sysfs attribute should be exposed
at all if it only resets the cxl.io state, for example via FLR.  Thanks,

Alex
