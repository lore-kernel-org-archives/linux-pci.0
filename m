Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45D3845D9;
	Tue,  7 Jul 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402930; cv=fail; b=djSBn2eN4363w8VH2WWZ4d+25t3Dw4eZM/ZMooBCnuJ96XhqtzJLZr767nf4Zaevy6bmkRFhPY0sLmzxMU3tTimUBDgQk6o/Y1PLouiBPgi1geIzJuKqQXEjZIw6HiK3Q8xrH08En6gw06rZiv3XtUH/jzv8OsXqGODc00CI148=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402930; c=relaxed/simple;
	bh=ZirGMUw9MFGX7LNEiVeWQtsv4J63VER/d8/jbdVa/JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GYcoed7LnATHZVJGULgBVMW1JH1eslgcx4GRQ4vwhR6hH7IDqu1ywfwSpPC9P0bR3HSaTFgplQBnrma2TZ3SW9gCEeOJu9W2jE9hyydCA3WVkzADXue0vWKSQ3ker2dJDC0TRrKLiNwy0O/2glaocHP9kIxN3Q2buPOUZymYQ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/XdwVIj; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/XdwVIj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpwmbSGoyNV1SpaSU4hBfugCDfRgmwPkEgBQI8BdGwSmu7yDX7qhTB4+5W/7S1TYkx+rKKMjWncbrdqTMrrP0LRkkxU3tSQ9EvNOcZdgGTP3icH7Goz3nODySZUUHBA0xrSr+ub0nTZjQVZHzlVUNd0e6ot9PJiRGntUnQNIy9+aHYgn5Y9FsXZcAQ4Aodr3kXf1mR5imt7hu46go/J5JXdxgjJtiULVpkkpZVddYciYcv9mcUilhtnYUA7LXCHnotlI53DDqYR6oyZ4rP2OdwzFMKe9x6qInMPbPcMfNIIAOYpNs1TMlpB+V3czUamk/nXGscsuD5f+e4DCtX2xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gedkau2Y640DVBalNzEptCPpm7IWzoRptIPluTkD1iQ=;
 b=BhbXIbXM/yuwydVboQUcLuPtPJe7FEYGRaOuIe0Dxzm4kLw+GVGTjWhQcuJnDmwyUQjGfxfp6rsG+rVnIhMcaYsl2fjb17Yce03w12gbOM/oeiXpGthYDZNZjwlooM4lUBqj2cfgvI0Gv8UwvYPeOvbrixgAUdpW1fv29FF4TxhILLN+Rx8JfjfbRspaH6PN+4R/phblID3YPjs2+caWJyhWlKrSLdE3in+CbE3fsbfgHY9EF5Q7c5hto4XlRAXKNTIfppP/L0ZWaLYt7J72H2TaTKvK6sn+WT+eKGiyCgwvgSV3FHQyxtfKm1junKY0oq1F8arv9X4kDnnln3atMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gedkau2Y640DVBalNzEptCPpm7IWzoRptIPluTkD1iQ=;
 b=k/XdwVIjkaySD+PEdhj9jGahY0TCZsujFJ0lKc+BVSFNQUKOL2wz1PWdmwAyIFAD29NV6CDW5X3OTSMpuqzr36jfeiUtRnwjCMcbSxq0vvUkp80GCFDiS0g0z8mu7BMp335WlRF4V0i5QhEAGLdICzvwHLP1K8aJmJOM5U1M2f3GGIX5E7CcwsUykHYzXWnghGz5I7Nvegn2qCq/XUCNzkePXPXkygRsvnPmHK1RICYqNAG2rqfVKQJK/yhcL27KiYEHtmnrmMFS7Tg1vw8pZ6YPdPhCy6yFFpTQJejRW+am/vUDeB8LLR5rZVSDXLYSmRVZOA7o8MP6LSZSIYV6DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 05:42:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:42:05 +0000
Date: Tue, 7 Jul 2026 13:41:59 +0800
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
Subject: Re: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <akyPp-a87undm473@MWDK4CY14F>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5402c8b6-6b9f-4f64-47b8-08dedbea79f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q3NGfFx0lNtQUV9ss1XEz6CzkghfoNwNk68Yw1m3EVPKYlCIOUQ0HPYD/H9C9Iw8KKh+TvPph2Xz3XnNs8Af47p4kQWwtdmnYSqsS7TpOY2T6zVwsg1ntXR7NQukoH1WQRi+C/mfhtoFrPT2O7KtcH3VYpTmzodTb7NkDKw2UKAQsT7iETkhZpsGwBLrqRpVrgVj+YOzfx31MCC0ToCa0tb4TX0EG1ySVS1wYO4vZwwwSekrjfda/wr0WYMTsaM7wueoJiDOiIqsE2Vj+7/ELZBDymdPN9GU4mUn8CP/d9351sZmCBt6Mx9/jt8VuElJjx21m2MwkdjSfC1KSPeGp6TsIAKlw9/E64cbGdrk3VtIQGavhhMehF6WiWqueCmidStICg0fWp9Mzck+tFwfIllba8ip/ugs9fb91AyDenQSdWCSwTfEDHFGuykD9FstGDZ+PE0VRs5emcdl7mHn77weVJ94wBvqzXIWHtsdcegFQ9cMPV7+Fqwq/Qah5SUVylwTBRQGjxZFUCvnxouQ29VvPZiKxryOlnZ2axJF0Pvx5MaOg5nQmuH/6DbgOLSsL8d1HcHC7ub5D0RuKaMzMmBrBC9OPFxllLNp1TT2j15u3Dfk/EqFpFXtWaLMBetegvVA14Z1r5WioGEI6dQJtYG6nxHQ/k6BnjDJJ2EVarg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtTfDDGNL+zIZBK1hCpR289oKozAEXHPX33SNcmYF3uFJICDRurU0kLvPjYt?=
 =?us-ascii?Q?KtOOanNhMtMoQc0M5rfdQhSvifuSYFXmVGkRrvmjDLk/0G05H6aduNJ9M2Hv?=
 =?us-ascii?Q?9KU+07Tx68e52A8RkqOsaBuN59jQQiqR2TOpUH7CF/2xdnTnsbHAnYBHSgaJ?=
 =?us-ascii?Q?kcALozLmvk+TL96wm+0OYvgV+xnqFrQFSDWPqIF3m2i9lw/MMyp9aZCewwaX?=
 =?us-ascii?Q?t6KzLzVXkXxUIj3aT3xSLi8FXw4dBgQOGgD9FWds3tRLINbQF516mfQ+mJ7t?=
 =?us-ascii?Q?WjA1VbzNH+uLDm4ctQz3WAMVdXTQDUrPu6XCsP4S5k59NuJFTEg1gRsUMaad?=
 =?us-ascii?Q?6+nY8eq44Kyci/9chmaFcN8BJu2NY1ZcTF9LCkJ5i/nmsCby5C/JNxTLdT/N?=
 =?us-ascii?Q?MsMCPi1FplOww3xQb5s40MXJX0tFE3NBStJ0JrtTLyKaTJm7l5YNbd+yQBex?=
 =?us-ascii?Q?yzEsA4svfjjTSQxJlkv/Ch9LRGdAFn4PW4u3F+HcGBiUgyohcjVZl30Ikevj?=
 =?us-ascii?Q?D7miuwxPsuNTITwuWhEUqkx72js5PoQH3qkvvQz4W9nvTJYKiglIlWTB3yoz?=
 =?us-ascii?Q?sJ40MP9ZCy+Dg1Jyn8QUltxjn9T7TYpd5tDrz9sZi4deh1NYrfHO+lW5GFSf?=
 =?us-ascii?Q?nCRTNZWXqbRcx1BAGplGyr1PEM4BzH5xbmlF0SSJq9Fwy6Gk9fwRfJk1DDxn?=
 =?us-ascii?Q?fyc27qJDmsWOFzZtuHDryaY/zD3j/xXmcim+lMN+E3zcEWmZTsXtzRLd3hLs?=
 =?us-ascii?Q?f+7M++82N/S0XveodUyQfnnk5+OGhzDZ72DpZHNlTAzP6OMsj3qXOPqGtn4R?=
 =?us-ascii?Q?XlrhtvMM9E/GoC/EqJuWnb/uDWIDN+FJ38z9nM3sSzd0dqGqCVVHgOCNx0FN?=
 =?us-ascii?Q?1nrORIdf2uczQR8W9mkAZQ8YN6yevu1MatKpNT1Y7GSForm6C8SWCaYRuWu9?=
 =?us-ascii?Q?0lsfYz3KIZmYTCMrqC1MmkOAMF9lM/yhWZ8MU8NlUjcHm+sa8CDVUIQZ6JtZ?=
 =?us-ascii?Q?ygqcPkejEej2u7GgqpIN3rdXQfbWtlwIqEjL3VHI/7bXbyu5qYab8/iJG2+e?=
 =?us-ascii?Q?KjLy9ibPquDK8hI8MxgwnYLXR4TqaOnK/USlmbLRPQukCW6C/ZZdp2Hn3g9n?=
 =?us-ascii?Q?J+ggf4D4nGnp1K2ywh9pp/CNkNeTpm6ixbwIAqaTQTzi6E62gbFlR92V7l+A?=
 =?us-ascii?Q?VyGXh2Vx7Tz/wjcxUeJiirQicmf6pESMqGfgMCU1tVUd3+IMVdKb6QbFSY7i?=
 =?us-ascii?Q?LmKRfeNhYphYXM0Bv81U2GBzRtRcFVdo33kMDitZC1pLHkO0yJpF0v5pr7FG?=
 =?us-ascii?Q?rhRje5ru6WGdmjn3HbSgwnKyFDP7WuqCUev4LsgeS3hc+B8vtNc8en5YpXil?=
 =?us-ascii?Q?i+rS8HQkmEkShwECrHC/qjlqsCUXEIjgHeJGESdoOkb4rvbrs8tK5pr+HaN0?=
 =?us-ascii?Q?OtU0kCJxwPA2Uv2VZuf+owzN0JzB+WBp3HhqwAphtAx6e4a5WpwyAwbmqVi3?=
 =?us-ascii?Q?TgSoPuG143X/JXT+2FHNs0sRl5iUz8UsdfexCPTPvyIcyz27kzOAHnLOd/7L?=
 =?us-ascii?Q?DkIRauFukIGKVnOXCInjiC+OSeQpNrwPdf5saPjjcn6bjRBOxBKEDkGgN282?=
 =?us-ascii?Q?DI2KZqtlboa7/1K4Wzi5cApUhWbhuKpQ8j7YT4SzT7/1FCaMeOpRLHaONjbm?=
 =?us-ascii?Q?/HY+kZacs/qLwHtvKIEgPbftibzeHT4v5MlnMOLmE0xSGxDaROgbzwT8kHyQ?=
 =?us-ascii?Q?JQc/mlB+1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5402c8b6-6b9f-4f64-47b8-08dedbea79f8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:42:05.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPdMwo84nCdav6QVm16ClkwHq5fHP1O8X7wZnJhFfH6FDJGPPlPvJHlIbG+m9impGb8eqKvqzXSX6rFleKcmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

On Fri, Jul 03, 2026 at 10:04:58PM +0800, Srirangan Madhavan wrote:
> Hi folks!
> 
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.
> 
> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
> with the existing PCI reset_method interface.
> 
> v8 changes from v7 [2]:
> - Drop the PCI helper export patch.
> - Drop the multi-function sibling coordination patch. cxl_reset is only
>   exposed as a function-scoped reset method when the CXL reset scope is
>   limited to the target function.
> - Keep the reset-scope discovery needed to reject non-function-scoped
>   CXL resets.
> - Cache HDM location as BAR-relative metadata instead of keeping an
>   enum-time MMIO mapping.
> - Restore HDM through a temporary mapping based on the current BAR
>   assignment after PCI config state is restored.
> - Cache raw HDM decoder register state so uncommitted decoders can be
>   restored as uncommitted, while committed decoders are recommitted
>   through the normal HDM commit flow.
> - Share HDM decoder decode and validation between normal CXL core
>   enumeration and early PCI HDM caching.
> - Put cxl_reset ahead of FLR in reset_method priority because FLR does
>   not reset CXL.cache or CXL.mem protocol state.
>

Hi Srirangan,

Thanks for this, I have some questions and suggestions in your patches,
but overall I let codex ran 260 cxl_reset on a machine with 2 CXL-capable
GPUs, exposed as Type 2 device, and 0 failures for this series, at least
on my HW it works.

Let me summarize what I did
- 100 sequential resets on each GPU, 200 in totoal, all rc=0, device healthy after each.
- 20 rounds of concurrent reset on both GPUs, plus 40 iterations alternating reset_method: 0 failures.
- No WARN/BUG/soft-lockup/refcount, no leaked in /proc/iomem afterward, DVSEC CTRL2/STATUS2 stable across pre/post

I might run more test with KASAN when I have time, but so far it looks good functionally.

Thanks for your work.

Best regards,
Richard Cheng

 
> Motivation:
> -----------
> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>   reset methods.
> 
> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>   the architectural reset mechanism for those protocols.
> 
> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>   before falling back to broader bus reset methods.
> 
> Change Description:
> -------------------
> 
> Patch 1: cxl/hdm: Split decoder programming into a reusable helper
> - Move shared decoder settings to include/cxl/cxl.h.
> - Factor low-level HDM register programming into cxl_commit().
> 
> Patch 2: cxl/hdm: Cache decoder settings on PCI devices
> - Cache CXL core HDM decoder settings in pci_dev->hdm.
> - Refresh the cache as decoders are enumerated, committed, or reset.
> 
> Patch 3: cxl/hdm: Share HDM decoder decode logic
> - Share HDM decoder decode and validation between normal CXL core
>   enumeration and early PCI HDM cache setup.
> 
> Patch 4: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
> - Snapshot endpoint HDM state during PCI capability initialization.
> - Cache the HDM register locator as BAR-relative metadata.
> - Cache raw decoder register state in addition to committed decoder
>   settings.
> 
> Patch 5: PCI/CXL: Add CXL Device Reset helper
> - Add the internal DVSEC reset sequence.
> - Disable CXL.cache, perform cache writeback where supported, initiate
>   CXL Reset, and wait for completion.
> 
> Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
> - Collect enabled cached HDM ranges.
> - Reject reset if affected ranges are busy.
> - Invalidate CPU caches when runtime cache-invalidation support is
>   available, otherwise continue after warning.
> 
> Patch 7: PCI/CXL: Discover the CXL reset scope
> - Discover whether CXL Reset is function-scoped using the Non-CXL
>   Function Map and CXL cache/mem capability bits.
> 
> Patch 8: cxl/pci: Restore CXL HDM state after PCI reset
> - Restore cached global and per-decoder HDM state after reset.
> - Re-map HDM registers from the current BAR assignment during restore.
> - Replay raw decoder state for uncommitted decoders and recommit
>   decoders that were committed before reset.
> 
> Patch 9: PCI/CXL: Expose CXL Reset as a PCI reset method
> - Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
>   CXL devices.
> - Prioritize cxl_reset ahead of FLR.
> 
> Patch 10: Documentation/ABI: Document CXL Reset PCI reset method
> - Document the new reset_method value and reset behavior.
> 
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no runtime provider is available, the kernel emits a warning and
> continues after the affected HDM ranges have been reserved.
> 
> Example:
> 
>     echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>     echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
> 
> Testing:
> - Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
>   CXL Type 2 device. All iterations completed successfully and
>   ResetComplete was observed.
> - Exercised cxl_bus reset separately with an add-on HDM restore patch.
> 
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [2] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/
> 
> Srirangan Madhavan (10):
>   cxl/hdm: Split decoder programming into a reusable helper
>   cxl/hdm: Cache decoder settings on PCI devices
>   cxl/hdm: Share HDM decoder decode logic
>   cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>   PCI/CXL: Add CXL Device Reset helper
>   PCI/CXL: Validate HDM ranges before CXL reset
>   PCI/CXL: Discover the CXL reset scope
>   cxl/pci: Restore CXL HDM state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   Documentation/ABI: Document CXL Reset PCI reset method
> 
>  Documentation/ABI/testing/sysfs-bus-pci |   14 +
>  drivers/cxl/Kconfig                     |    4 +
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/hdm.c                  |  257 ++---
>  drivers/cxl/core/region.c               |    6 +-
>  drivers/cxl/core/regs.c                 |    4 +
>  drivers/cxl/core/reset.c                | 1354 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   43 -
>  drivers/pci/pci.c                       |    2 +
>  drivers/pci/probe.c                     |    3 +
>  include/cxl/cxl.h                       |  102 +-
>  include/linux/pci.h                     |    8 +-
>  include/uapi/linux/pci_regs.h           |   15 +
>  tools/testing/cxl/test/cxl.c            |   10 +-
>  14 files changed, 1615 insertions(+), 209 deletions(-)
>  create mode 100644 drivers/cxl/core/reset.c
> 
> base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
> -- 
> 2.43.0
