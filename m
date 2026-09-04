Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84743932E5;
	Fri,  4 Sep 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513372; cv=fail; b=EwRas6+aFaRpcTCSbRFm/egSdJfPvvYgSF3vJua5AHBOjF/EHVNaMDun2LY/QhjEzOkwPJmziHMqMfc20jUJCCxoWb0YagHikthEzmuW/fLV965Mg/fXtSVEZzb7dRd9X25hpWiqg82e4rip/pTpGK9X4yukqCp+Z513mTm3zMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513372; c=relaxed/simple;
	bh=oE98lO+SPDNxASub3vSXhpPet+lr5Almh2velxiemZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbHDVs/GmVvIvuQmpxjA7uVxbI2BtsOjpfqGnTIn3KZ7x196Ya1LKRlB3ShpS4BURllrxglspZ8yJUpZJjKnIS5h4a9wKoB//Ec+dqZ6nzea/rry3mxfVOA20nRZT3IRz0Hbr4WkeA7prj/t/CasD2LVCVf9KBAzYGbqGNTG9HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJP4Se1t; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJP4Se1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y302owDC3s4epWz8RvhkixuCZtQqmGmVrfadnDNYYVbLAGuVuPrOZOosEHKLI5fuUVcTsMEawTYQL2q0CFEhBeY7pV1afCAp7JbTmnEx0Rlm0I7gj1j/2AUty15uXx6chWTQNsMR01m5qTHEvFU79HMNCLLWttaX8GekW5tc4YDdhUpo4SgmjluX5gLvs6B82VCUcKbqa3g1erxhCGEfKWZbbw+yZ/2Ua4KXvLui8khcspAKFDyK7KLlpGmEh122DN7y1atIyXqIRwBoBoAwtFCPNxxxiBhj1iYW5L0pyamIjoIbyQV9dtV5poTbeEgA/1j0X/E7paaCT48vvuZqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTh4Ke9Sgi6KrqlGQS2/yfuiuES4niavQH3xn8CqLu0=;
 b=MKKDSxYSNcelu6ybSWd+F8HOnAzzDQVrZSkzOLefgTB0cP1AYtywg99zEWVnFPKe1jB6H7DeOzpPbDpVSy8msKu2w+7fiPO5AmsEmDWZaP6e2zy2eBeupZntg6Ds+uOfAIjBhqUzwWDy0gOxE3GzttE9hJLZKZpMWpKhrp6JJxKyuxDklRu0mQp5lghqYpZnjZON282+XY+5NfnX4ntIxdiHAltWo+zogSSeEZyTYpBUh4OvM0maeajkRn6hCkjB8iBqpOpt59uTZW/3CjL2DJZwOJGpPOI1VetGVJJcU2DQK/A2daKABzcHeEo/Gl/FnYs1LJ7Xt1nxOzLg+fy4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTh4Ke9Sgi6KrqlGQS2/yfuiuES4niavQH3xn8CqLu0=;
 b=rJP4Se1tmjoVWhr9QXfuucZ3ge3jhykjvHgSpMiL9xhyydV0JD648Cb2I86ZAbT0xJAq9sPJ0QG0+e+3MNvbflXJn3ul7furb1wk9g90LWN5naqXWMLeIyVSNZ5Mc4ztsWSm7uPj0rYtn9idjvGuhcq0OdKTjqLaEd+BOvzOz7kLLXQjNv6v1xJkVPKRujGje/JnZVkDMZwh+uducymzydRs30biM/3trH23+Srv1cN97uYgPZs3ILP08BSu2J+qjy9rjWMNZpfTpUVNoMeSjO6OdKrP8SpfQ2ukDTc5anyby5kjCQs9R3Kkz6+UfDINkBc9eCT+g94JLt3w5u6bsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:16:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:16:07 +0000
Date: Fri, 4 Sep 2026 17:15:59 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <apqLmL07mEji7e_k@MWDK4CY14F>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 054d9541-8bd2-4c12-c57f-08df0a652690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|10067099003|5023799004|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1BYDJgEFwl68Qjvq+Dl8AcUihKL2OG1neyCJwkxY4ivIDNLRmbrDnJ9HQlbXdt5yqot2Klp7svH6vTjR4FFVXQW5/LteJrBW0yPtrQULLW1Pj8I/BLYhAw92eE+hLgOsIJ7taNZ/LlIHmSPmgXgFtWcOsHU9X3d+1IDW33bRJxe4UAHCeAHb6HuwmGjksrliEd6bUtj/p8qUq3m8K8HvozjZkByR0WS20E1X7NjUQKHBcQhdwEv2yCVaEO3cOPnNZ3cId2c9d98F931VnwT1/ljdUbMctuEjHnJ5UH//Avi3hbZqVQKKKQEXFIUlCMeKlETzwZ47HVKhlWT0Qy7l4DmlnFVbCSwwkgx6eXhlh3ErTUWfkg2FIGFb3KicT7aleoR8zorwoKDpwzhqQxWfqVj+u0Cu0Y97xOWQoznsJo4tZ4goTHUjktMRcBzMgE2FeY9Lv7d8Q2PExZwo9rNKvpOCyc9H0f/Cxy3+jLiriegFA74Eht0hyQtHFSv8FefMs775zLZv3mx8Roxaw3FF9noaf4R6z7/uEmScO2MI1d1fhlcCOe+JkVAoNUvsZmbPu6JASg7AOHNsZR/AI5kxGdVonvgPIKdO72QjLoA3EtuGR4qCHjhj2iiiInGy3WWv6nwugkedf+op3hyyzIFlNsgVjCeHqsz2F4DwMVXiip4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ND7ShRHMdcRoNUEktMIb95iafaiC+rsgCPcQTamzoxN/fj6CG/5Fdu97qLOZ?=
 =?us-ascii?Q?jtv0ThbPmDO/Tn5s1liQVqaNGdyCNGYcy7aQ389ENhFTb9TFDEUcrPV8+kbj?=
 =?us-ascii?Q?BUutUm8jLuA7T03TISx/N7ucckmelc2USR3vVDikOqHAgpoLEbWOMSkGcCBy?=
 =?us-ascii?Q?Nv1ZLj6X84jCSPXKo71fCalj9xu1kk7UF8i0RjUpWdqTgaH5vKb3TMFxKS5h?=
 =?us-ascii?Q?6nnbXHSquC7vIt/Mndk49fkXhxZ+kDEqbXsgfn3AO/jc0zTm9u3xXAQWAiVS?=
 =?us-ascii?Q?JZYVJcCv/YdTY5GVts24detRz4VvsvHbgtrnCJeeIq5ddqDFwEiOxtsmurWf?=
 =?us-ascii?Q?HlWbJDsgzH8cfxbFCTm2pKQw6TV6AxwMefB467ebL6LUwIqZX5byIR+o3QEB?=
 =?us-ascii?Q?0h9088c+8hqtx4zzMp0w2iApnnkP+cQXetZAbceSc5DJ6F+KT5LWTDqVYg99?=
 =?us-ascii?Q?usog2KxcUn4FQUI9f5ud3OsICm/tfc1Ox9ShcJOZmwtQ5ZQx1dNDT1dG0tDw?=
 =?us-ascii?Q?JLqxFZPtC1AJoax4l8h+swe2wXXW8ZNj/AzLbV43Ov38C8c5IN0CzvqNJTb3?=
 =?us-ascii?Q?Cqui+1vHrPzux2+Q33QJ8egCHcegD0ZwptaeaapNB31xfc+JZGB7k8MvOOrW?=
 =?us-ascii?Q?GGqnu/4Jjif4W5Sc5sH9kFqQm8BxuMsELdH/T9YBT3r/iS8XMpFZUS6uZmX8?=
 =?us-ascii?Q?YJDwaaFYfIabpivk8WcZQ+u1qehs7MaGgp6/3ERfHsVyXkRUttjQE0m/6ioh?=
 =?us-ascii?Q?z06CHVKBA81V8LRYLuNwoC1ha8UxFtAIkKOoGTQp/z1y/CXehBHiH7jZPxB5?=
 =?us-ascii?Q?3Frft6Qlb0fMtJ6ghETnJ0buOfAwv8EuNaBzIL3ASdTNJGXr4b4FuLhfBXGO?=
 =?us-ascii?Q?mXrQa3N6ZxnPo3+j70fQdQvo1IWZ+xRDhLFqkwpU1dbTmGgaTja1mvxCsEQ6?=
 =?us-ascii?Q?xUjGb4qMk8hq4OfDDECd5UX9FUHIKAMUecvsdshBwIaeAysaTsARxR1073Qc?=
 =?us-ascii?Q?Bz803YstSQECMUOQx0AeyohfZQK78Nvh+ZmXVWEXS+sb60wexd465z4aV+NV?=
 =?us-ascii?Q?YP7vTqfYR623GIHmg2WTKuaDRjoWDEiP/6zLgIJNJyuEY2HRs9ySQxxI33Ce?=
 =?us-ascii?Q?/aGA+/n7BU0ZxtVcHLQkMuXU7DxkIm9K+BZ3UAMLWWFKBg8Xtqxj+O/ZWtB4?=
 =?us-ascii?Q?J0bW3gBZXrQs6MlfEvPkLcEJcX5cB2veRZ4D4mxcZsZo7Z5JsfIftAMcpgOV?=
 =?us-ascii?Q?5w5Lavp6Cc8KxjVHlNxeAVbHUKtlyINYRgZh58D6Rm9vIo1QXugPdjuF/nLU?=
 =?us-ascii?Q?lSNKKzqc80a+rWailqpvJE9Ap6EpSydB2ll/zbw10ubBkFRxzk62XkRZhCNQ?=
 =?us-ascii?Q?hPM8KloPQ0LnAp37Z5BuwKDWglRlZwlrcfc1NzEmxjWV9EvmEc+nJcbF+LOB?=
 =?us-ascii?Q?AvtxNsP+z/Kw9Hnz8+uSw/97tZ+7chB1+pwcSc1kClFQB1go8Nmc7PnSSC54?=
 =?us-ascii?Q?K+4/0N8iTGkzcoI5CibVxU+wnns7CfKqB0+jdD2ooJnXXei4ruSlXxnmj+gc?=
 =?us-ascii?Q?sYBSJ7zknUa7FMgqfauHcrmumrXDzJwfWQ7MTu30zV+rHbsZVc+jvsuTyJhJ?=
 =?us-ascii?Q?IHl5GS3cOJGEms0feLHfoQiVjAWBWNhlpRMO3J5u9PdAhJoOXOkH7ePWeTqK?=
 =?us-ascii?Q?R9T91K9MQgOzM6nCEHAGF26iw4Y5Yc1UgZSDf0z6Rwv5XNMUYvA52S1UAo81?=
 =?us-ascii?Q?yTpU3Sz/JQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d9541-8bd2-4c12-c57f-08df0a652690
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:16:07.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTyuDEhvpnw4m6HT9B+8AXIT55/Gj9AmUfeZo4X4f2gzce6QXog09cyc8uARW+Ti8w+bztH9LXhDcs/R70Mgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

On Wed, Sep 02, 2026 at 07:27:52AM +0800, Srirangan Madhavan wrote:
> Hi folks!
> 
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
>

Hi Srirangan,
 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.
> 
> CXL Reset is exposed conservatively. The target must be a
> single-function CXL Type 2 device with CXL.cache and CXL.mem enabled,
> and the kernel must have cached HDM state sufficient to validate affected
> ranges and restore decoder programming. The reset preserves device
> memory; it does not request CXL Reset Memory Clear.
> 

It seems reasonable to me, the whole approach.
I wonder if we can document the complete reset-safety contract down ?

Especially what guarantees that all CXL.mem users and functions are quiesced ?
Besides HDM EP , what are other EP state that should be retained or restored ?

I think it will make people understand the mechanism more easily.

Best regards,
Richard Cheng.

> Following Dan's v6 feedback, this uses the existing PCI reset_method
> interface instead of adding a memdev-specific sysfs ABI.
> 
> v11 changes from v10 [2]:
> - Rebase onto v7.3-rc1, which includes the CXL Type 2 enabling work, and
>   use the merged public CXL PCI header.
> - Rename the built-in support symbol to CONFIG_CXL_RESET and fix
>   built-in/module linkage for CONFIG_CXL_BUS=m.
> - Fix tools/testing/cxl linkage without compiling production helper
>   objects twice in the mock cxl_core module.
> - Simplify decoder snapshot handling and preserve endpoint DPA skip
>   ownership under the existing DPA lock.
> - Keep policy out of shared decoder parsing by accepting spec-legal
>   zero-size decoder state, while skipping zero-size ranges during reset
>   validation.
> - Tighten early HDM cache setup, capability checks, BAR bounds, MSE
>   enable/restore handling, and cache publication locking.
> - Keep the conservative multifunction-device rejection requested in
>   earlier review.
> - Harden post-reset failure handling so MSE and BME remain disabled when
>   HDM state cannot be safely restored.
> - Serialize CXL bus-reset HDM restore against region updates and flush
>   posted HDM writes before PCI_COMMAND can restore bus mastering.
> - Address the remaining reviewability and naming feedback from v10.
> 
> Motivation:
> -----------
> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>   reset methods.
> 
> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>   the architectural reset mechanism for those protocols.
> 
> - The PCI reset_method ABI lets userspace select CXL Reset before
>   falling back to broader bus reset methods.
> 
> Change Description:
> -------------------
> 
> Patch 1: cxl: Move HDM decoder programming helpers
> - Introduce a decoder settings snapshot collected under the DPA lock.
> - Move low-level settings-based HDM programming into resource.c.
> 
> Patch 2: cxl: Make HDM commit helpers available to reset code
> - Build generic HDM resource helpers under CONFIG_CXL_RESET.
> - Export the lock and commit helpers needed when cxl_core is modular.
> 
> Patch 3: cxl: Share HDM decoder decode logic
> - Share HDM decoder decode and validation between normal CXL core
>   enumeration and early PCI HDM cache setup.
> - Decode zero-size committed decoder state without imposing caller policy.
> 
> Patch 4: cxl: Cache decoder settings on PCI devices
> - Cache CXL core HDM decoder settings in pci_dev->hdm.
> - Refresh the cache as decoders are enumerated, committed, or reset.
> 
> Patch 5: cxl: Cache endpoint decoder settings during PCI enumeration
> - Snapshot endpoint HDM state during PCI enumeration.
> - Cache the HDM register locator as BAR-relative metadata and preserve raw
>   decoder state for reset restore.
> 
> Patch 6: cxl: Add CXL Device Reset helper
> - Add the internal DVSEC reset sequence.
> - Disable CXL.cache, perform cache writeback where supported, initiate
>   CXL Reset, and wait for completion.
> 
> Patch 7: cxl: Validate HDM ranges before CXL reset
> - Collect enabled cached HDM ranges, reject busy ranges, and perform CPU
>   cache invalidation when a runtime backend is available.
> 
> Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
> - Conservatively reject CXL Reset where function scope cannot be assumed.
> 
> Patch 9: cxl: Restore CXL HDM state after PCI reset
> - Restore cached global and per-decoder HDM state after reset while the
>   target IOMMU reset block remains active.
> 
> Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
> - Add "cxl_reset" to the PCI reset-method table ahead of FLR.
> 
> Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
> - Document the new reset_method value and reset behavior.
> 
> Patch 12: PCI/CXL: Restore HDM state after CXL bus reset
> - Restore cached CXL HDM decoder state after cxl_bus reset.
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
> - Built every intermediate patch, plus the v7.3-rc1 baseline, with
>   CONFIG_CXL_BUS=m. All 12 patches passed a full kernel build and
>   `make M=tools/testing/cxl/` independently.
> - Built and booted the series on an arm64 NVIDIA NVL72 system and
>   successfully exercised CXL Reset through the PCI reset sysfs ABI.
> - Earlier revision testing ran 100 iterations of cxl_reset and exercised
>   cxl_bus separately with HDM state restoration.
> 
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [2] https://lore.kernel.org/linux-cxl/20260804192958.1823952-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
> [4] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
> [5] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
> 
> Srirangan Madhavan (12):
>   cxl: Move HDM decoder programming helpers
>   cxl: Make HDM commit helpers available to reset code
>   cxl: Share HDM decoder decode logic
>   cxl: Cache decoder settings on PCI devices
>   cxl: Cache endpoint decoder settings during PCI enumeration
>   cxl: Add CXL Device Reset helper
>   cxl: Validate HDM ranges before CXL reset
>   PCI/CXL: Reject CXL Reset on multifunction devices
>   cxl: Restore CXL HDM state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   Documentation/ABI: Document CXL Reset PCI reset method
>   PCI/CXL: Restore HDM state after CXL bus reset
> 
>  Documentation/ABI/testing/sysfs-bus-pci |   15 +
>  drivers/cxl/Kconfig                     |    4 +
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/core.h                 |    8 +
>  drivers/cxl/core/hdm.c                  |  324 +++---
>  drivers/cxl/core/pci.c                  |    7 +-
>  drivers/cxl/core/port.c                 |   19 +
>  drivers/cxl/core/regs.c                 |    4 +
>  drivers/cxl/core/resource.c             | 1351 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   41 -
>  drivers/pci/bus.c                       |    2 +
>  drivers/pci/pci.c                       |    8 +
>  drivers/pci/probe.c                     |    2 +
>  include/cxl/cxl.h                       |  116 +-
>  include/linux/pci.h                     |    8 +-
>  include/uapi/linux/pci_regs.h           |   14 +
>  tools/testing/cxl/Kbuild                |    1 -
>  17 files changed, 1715 insertions(+), 211 deletions(-)
>  create mode 100644 drivers/cxl/core/resource.c
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.43.0
