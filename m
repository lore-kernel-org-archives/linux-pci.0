Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAC376A0E;
	Tue,  2 Jun 2026 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432480; cv=fail; b=WnfEEZQos7oPCaaIIZcc0q/tcpHMGCq7AdZU5sLtOAL+CX208BElAJ8Px4kEh8SZAdB17l9H+xFLDRr4ZGTEpk5R6Lr4ZuCB6uIOSrqDc7WjWw+Xg80USs4of4QWUkgvXUuHqVwRv8OG0FTgnZEAHohjWM+ySoEYKA4mPigxllU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432480; c=relaxed/simple;
	bh=VD7mhuAqLNgyzpCnGzdNve7n/YDRrK+GdgggtsqsgK4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Kr01x+qyl7SPw4ZcGbkijb7zNX8mpte+V1NT5EFCevQH/BSDkSsFRuV0Zywqscde8h7VDjp6C/FXCgBsgDyGwBatoFRJHrnvFuQzw6ey2J8/1ZgJpIIShQ3ZFoTrqmCKG2kEkSylJfUtqNJl06vBYoCRLY276dIP8LgB3lo3UNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8tcBs/s; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8tcBs/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/piFltLnIlYOvXMZXdMCysmtEmEIcplNelZtPnZlIwPsFsNmBcvwAnmR/saeH3MV+Wy/h9hAMxQamUGfyrEaNYMeGvm6/Q4Ype68w0OyYHSNFrwCfXQ6VMw4xsMUYWddDBZJTfZJZPXkNpLsa8CN5BTnU6GbeuYqQXolqymyQ7AwPvmsu+q9hkb+Erp8E+5pL7qcqpCd7qfgaVmgcesvF/swcNxVnb/3MkT9c3l2UjTE9sysf0f7RPz3fSYsg/VL5enXRomDLPXVhiqQtbjvTqZfE5C1XtGcBOnPetoa05rC1gu7rdvvnxtWoq/nudfW8otkF7f8G+AGYl9CgzYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wCCYfBduaPvdJu1NsnUqgtZKcc9wwJbswhlKjcNgiU=;
 b=peXrLqyvRNI5aMaYhme68D0tuQjRPHw3kVO5d5DD3uZpKV6uWDHyEIHwaUQwbtbasH2XMvq4O0z6b8WnTA18fMPhfmbmwPgUI6J0VAC2/fkn2Y29vkT8flkEq7WuXEy0GarlV7suUuL2Q4sKrAWoBeN1k0VigxzwHcu901FOdHSdmIjdFF1rZUwLWaQZudTMqVUcx+qrPFmqHd4YcgrjrPSH3+CaMCBMkVc72H/GiHGplsXZGz46FxKl0hkzrY/I/37ELY31kvUhc1iLl+AkQWF2/aaI9C+lXDDIbmRhquo9ZSQKqxVgsNjbEmYZammV5lC+rAu3tV9B+LDrMgVC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wCCYfBduaPvdJu1NsnUqgtZKcc9wwJbswhlKjcNgiU=;
 b=r8tcBs/sKv0L26SU31MT6q/C3VXLB0bvNmwO4qJT7hSacHt3CWxFGSlkHcPn2j4PzcGvY/Ip2CqW2VVU+23rhgSMYL8VU6WCV7SyanGqIgF6rKpO90SvbPi4k/sLY5+Y/SZDkEiod1Fzj+dzioZLduGR5WK3LYalXu72leq8H7g=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 20:34:33 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::93) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 20:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:31 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:29 -0500
Message-ID: <3c9badfa-7a8f-4177-89d6-85f6c78f519c@amd.com>
Date: Tue, 2 Jun 2026 15:34:29 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 0/9] cxl: Add cxl_reset sysfs attribute for memdevs
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fb56c1-81ae-423e-2206-08dec0e6598f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|56012099006|11063799006|3023799007|5023799004|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	LZE/Yivld8rmE1jUAEWQClHSJaYjdi8kAlP+8xuN5E24p6NfPIuveebmKjB7xM7yTsTv1OgIbdATa+Aq7FBoxeSUmoryKvXysrH7Iy16rlw+uc7Y8kq4fQK8AhaLyCQLjtfpGEIpe3ZxN5lKGRf7aa5HWGvl4K645IiVhZ85ccaRS7xedFtMx4fn4Jt3TWLPFR9rs8tQOwR/y2O5MfulbTvO6ESP8LmbXMiBM9XpnUrwNcilRKVDFYsJxzApEzRfXjvho/mSUt/jTG4S6Vh8jpIoIYRh4ZEF5CcEVxc/or7mUVfUOKxthkF72PMIHXZZt3EWO0dwBdmduCiEijMXA1ujD6zM8JzhT44guW2pv93qX7MI/uFYPpgrSRrIngrFMGacEvycXC9OaibKmz+WbfyrGhj9yH3BM271EqoQHKIUIYC5He/FQ/+4l3ekd+ROvQSc74QK6jom6vJeMD85+7D7cbfl8PI9lnvmdHHYyD4aRkwonAJtNccdpRF4Pj3nH8ckb5aSfao8iT32Me6cMKORRBPXJ7VhhIuHWtiXMOH7CMRH0b9fTuwRPBafmpbz0vWo5AQc0JPyPN0/jKxXVI6Z1vWnw3hD/SATx7GqO4Qgg/2Ix7sr40f0rkZ9N/Q06ZAPYhVRDZ6FP+Ew76qjGHGWrzH6VAnAyQ6BN/DStsxeAo4LrBuuBl16ltEqu3An
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(5023799004)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pAhMP7F/XBZ3sHI2VJlQoN4tRNWOP5JoQXQm7qlOb9V6KGJYF63V+OvQiCHUwAH5h6pQaCDabQ3/F+le7Zxj5FxdVjfkEvA3F1eGc1fPA1Jt3o5dKA5DAWnmz/eC/sLd8MWFSQBWDh6LNKqsHmTrth6U0wQ+CY2zZKq0xIYU+rT3lwUkd9gy06dVXh6YuapeIueUu4LxT4lG7TXdk5AyhSDvtnCrObJVqFDIphtGfPHre4jrLii9IVNHg7YY3Wtey41GAWZYdMVPiJG7FSLFV0xYTcBwIlwSc/kC5WjuRqELwQhDqFfWvULVVxSJ2Ovho3W28YZPYrIaiq3rZwvc5Qfagl5mRLXY+KusLUn2eGqBHUT5aozEyoLRMdrPpsUR1EhLfrtEhCmrP2JW3HcF6/Zi8Cq2+5hiRAC+brlnzs6ARP2rZYmreFXgZbPUK0KV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:31.0085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fb56c1-81ae-423e-2206-08dec0e6598f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Hi folks!
> 
> This patch series introduces support for the CXL Reset method for CXL
> Type 2 devices, implementing the reset procedure outlined in the CXL
> Specification r3.2 [1], Sections 8.1.3, 9.6, and 9.7.
> 
> The userspace ABI is a write-only cxl_reset attribute under the CXL
> memdev device:
> 
>     /sys/bus/cxl/devices/memX/cxl_reset
> 
> The memdev is the userspace handle, while the implementation coordinates
> the target PCI function, affected sibling PCI functions, active CXL
> memdevs, and any CXL regions reachable through those memdevs.
> 

This may be a dumb question, but where do type 2 driver slot into this?
I think it's expected that they'll implement the ->reset_XXX callbacks for
their own handling? If not, you may want to look at where type 2 drivers
outside of drivers/cxl/ can have a hook to do any reset related clean up
or prep.

Thanks,
Ben
> v6 changes (from v5 [2]):
> - Rebased on the current CXL tree used for v7.1-rc4 development.
> - Move the ABI from /sys/bus/pci/devices/.../cxl_reset to
>   /sys/bus/cxl/devices/memX/cxl_reset.
> - Use the memdev as the userspace handle while keeping the reset
>   orchestration scoped to the CXL device reset scope.
> - Reduce the earlier PCI/CXL save/restore series [3] to a single CXL HDM
>   decoder restore/commit helper patch, included here as patch 1.
> - Do not offline or hot-remove memory as part of reset. Return -EBUSY
>   if an affected CXL region is online as System RAM or has an active
>   region driver bound.
> - Add reset-idle validation and CPU cache invalidation for affected CXL
>   regions.
> - Add CXL sibling PCI function discovery using the Non-CXL Function Map
>   DVSEC and CXL.cache/CXL.mem capability bits.
> - Coordinate PCI save/disable/restore and IOMMU reset prepare/done for
>   the target and affected sibling functions.
> - Add CXL DVSEC reset sequencing, including CXL.cache disable,
>   writeback-invalidate, a minimum 100ms quiet period, reset-complete
>   polling, and Reset Error reporting.
> - Track affected memdevs, lock active memdevs across reset, restore and
>   commit decoder state, re-enable CXL.mem, and wait for media ready
>   after reset.
> - Cache reset capability at memdev registration time for sysfs
>   visibility.
> - Document reset scope, Memory Clear not being requested, and -EBUSY
>   behavior for active CXL regions.
> 
> Motivation:
> -----------
> - As support for Type 2 devices is being introduced, more devices need a
>   CXL-specific reset mechanism beyond bus-wide PCI reset methods.
> 
> - FLR does not affect CXL.cache or CXL.mem protocol state, making CXL
>   Reset the appropriate mechanism for cases where those protocols must
>   be reset.
> 
> - The CXL specification highlights use cases such as function rebinding
>   and error recovery where CXL Reset is explicitly required.
> 
> Change Description:
> -------------------
> 
> Patch 1: cxl/hdm: Add helpers to restore and commit memdev decoders
> - Restore endpoint decoder programming from CXL core's cached decoder
>   objects while keeping CXL.mem disabled.
> - Commit restored HDM decoders as a separate step so reset orchestration
>   can re-enable CXL.mem only after safety checks complete.
> 
> Patch 2: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
> - Export PCI reset lifecycle helpers so CXL reset orchestration can save,
>   disable, restore, and invoke reset callbacks for affected functions.
> 
> Patch 3: cxl: Add reset-idle and cache flush helpers
> - Collect CXL regions affected by a memdev reset.
> - Fail reset if affected regions are not idle.
> - Invalidate CPU caches for each affected region once.
> 
> Patch 4: PCI/CXL: Add sibling function coordination for reset
> - Identify CXL.cache/CXL.mem sibling functions in the reset scope.
> - Use the Non-CXL Function Map DVSEC to exclude non-CXL functions.
> - Save, disable, restore, and unlock affected PCI sibling functions.
> 
> Patch 5: cxl/pci: Add CXL DVSEC reset helper
> - Execute CXL Reset through the CXL Device DVSEC.
> - Disable CXL.cache and request writeback-invalidate where supported.
> - Enforce the post-reset quiet period and poll for reset completion.
> - Block and restore IOMMU traffic while reset is active.
> 
> Patch 6: cxl/pci: Track memdevs affected by CXL reset
> - Track the target memdev and any sibling-function memdevs affected by
>   reset.
> - Revalidate and lock active memdevs before reset proceeds.
> 
> Patch 7: cxl/pci: Orchestrate CXL reset for affected memdevs
> - Coordinate region validation, CPU cache invalidation, PCI function
>   preparation, DVSEC reset, decoder restore and commit, CXL.mem enable,
>   and media-ready wait.
> 
> Patch 8: cxl/memdev: Add cxl_reset sysfs attribute
> - Expose /sys/bus/cxl/devices/memX/cxl_reset.
> - Only make the attribute visible when the underlying PCI function is
>   Type 2 and reset capable.
> - Write a boolean true value, such as "1" or "true", to trigger reset.
> 
> Patch 9: Documentation/ABI: Document CXL memdev cxl_reset
> - Document the new memdev sysfs ABI, reset scope, Memory Clear behavior,
>   and idle-region requirement.
> 
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no provider is available, reset fails before hardware reset is
> requested.
> 
> Command line to test CXL reset on a capable memdev:
> 
>     echo 1 > /sys/bus/cxl/devices/memX/cxl_reset
> 
> Basic CXL DVSEC reset testing was done on a CXL Type 2 device. The reset
> sequence completed successfully and ResetComplete was observed. Full
> memdev/region integration testing is still in progress.
> 
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2024/12/CXL_3.2-Spec-Announcement_FINAL-1.pdf
> [2] https://lore.kernel.org/linux-cxl/20260306092322.148765-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/
> 
> Srirangan Madhavan (9):
>   cxl/hdm: Add helpers to restore and commit memdev decoders
>   PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
>   cxl: Add reset-idle and cache flush helpers
>   PCI/CXL: Add sibling function coordination for reset
>   cxl/pci: Add CXL DVSEC reset helper
>   cxl/pci: Track memdevs affected by CXL reset
>   cxl/pci: Orchestrate CXL reset for affected memdevs
>   cxl/memdev: Add cxl_reset sysfs attribute
>   Documentation/ABI: Document CXL memdev cxl_reset
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |   28 +
>  drivers/cxl/core/hdm.c                  |  318 ++++++-
>  drivers/cxl/core/memdev.c               |   30 +
>  drivers/cxl/core/pci.c                  | 1140 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |    5 +
>  drivers/cxl/cxlmem.h                    |    2 +
>  drivers/pci/pci.c                       |   22 +-
>  include/linux/pci.h                     |    2 +
>  include/uapi/linux/pci_regs.h           |   15 +
>  9 files changed, 1557 insertions(+), 5 deletions(-)
> 
> base-commit: abb3c0de119032f4c0c81177884a3bb0a133e6ca

