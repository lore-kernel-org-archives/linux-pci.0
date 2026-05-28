Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88135379C3B;
	Thu, 28 May 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957129; cv=fail; b=ZMAzscCf9eZIVTJT2yGr1xXgY5udgeCQeDDd3z46f1IluXR67+6vaRAz/Cp4K8Rh8QLeqwf26oF1/nZfp8U6iQDI/dwQayKQn1eHTO3xXHKf72+BDwHK3W6jBGDYWPICWpLD+1Vi12Wchd/xyoAwZbe0ktkduV0J4oqc8305rfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957129; c=relaxed/simple;
	bh=VX+E+Rpn6Yeh5pirr5RTRs835GzNgiBVLAvnwlwlpVo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AiLTAYved9+rCIRcsVu7DcAqrXkNUis7c9bYBbcHG778k88bcMjyBz2VOrC/BsUImprb+ybe5oJqKWv2G8CuGuQFJCKsvBjvMt+vdClIbxwdmT1cOld0cTLNuEBcfOl01T7J6S0mNK3Qbb0W9I6P8zWXnqB7bTP5/xkAD9HDqKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUs0poww; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUs0poww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQfHOOEoiVZNWPA9FctrXMSTBVoAkKGOvAaDv9tbAVmcxDB4bPhOIcEMAZQnbRvPf+3xxTX+ZpYtsoVr8xNz21MYN7cDvMfNq+iSDdxCSaQY/OM+OajSr7FUz01Kv6Fbdt/txwJaFUEsT724dHDt2fuZjpyn72yknr3DghTCx5VYAPfH2Gbc3d4dfPktmkJQRU+pePn07zby+v+r0H56FIt/TZezn2TRkgnF4ugnlub4xbgS3xn49N9e0WFAvNsxiKWAPYmJCXQYkA1K1bGOjuFTVbM7jC86yF9kUE51fONNW92jawjJWAxyqUMRSnHAq17r/583KTEQd4k4fXYS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFwPngbnTuXT0w8gbeK2pE5Xtqk7UN+pOKOoUtxcnD0=;
 b=BjqJto2XkqRYEQRIaxyN1vYeM6Yz84YDyvQlv9AU/T+6sPVbsJE6UodtddaRLgo6bGiDGQqALUa/aj3JFCbsMV1ahB/20xYLJTyHKazzBrpfOQSicPJPE94WTiQ1TVfGsh8DUU80RxkgjQMjG+ZswzQoRLxzFbWEu5MTRBXgg365y3absX3hKr6GrWOGkWg1sBF9swkl6YNFnJgTcqaF6X3lwxzuMwrbIbDEgbYwlD2GzfngKdTHcWxc3wUmKDF4LMWgqDGiGSwekALrxYy7wH1H+WbFM/BQx9aF1yivZYxuruzgY3/Y0Ja5XhRzToHjKIN/qK738R3fiR8OnKtznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFwPngbnTuXT0w8gbeK2pE5Xtqk7UN+pOKOoUtxcnD0=;
 b=dUs0powwTzPeuTXdMFaO3lTkXnuRivYYe6Ls1Q5osb78myfTnFa7Q1JWO7uMWKjdo5txyOyfv5L56174o+LTVGnDnFHdbATM1Sxp01G10GpSzK4pYCSseUzXNPA7+m1KaIA8PW6r60giqIDQtM2tpmoeIzncsbJXSO+OFBqg2MQY+uqkmh1rNw5D94HYsTHuFRYwb+NKXLacVhA0wRKuXtRyqcopAhnqMSjXuYW+yWcUXqwWFHu/itPXyWxDtqpeBJH9ex16LeFXYWeQf2nEmHOnRlcra/6GYLnujiviq9Jj1QIw0BU9hVvaliPdKHw5dmF4pw8O9eaE569nYr2vzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:31:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:31:57 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 0/9] cxl: Add cxl_reset sysfs attribute for memdevs
Date: Thu, 28 May 2026 08:31:45 +0000
Message-ID: <20260528083154.137979-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3709fc85-6909-4b1d-13e7-08debc9394b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|56012099006|11063799006|5023799004|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	YJ4edTrv1f1BoTs5ulCdKgTwO8CR60637sG+m5zP+DfnVRrE8J7Aeue87wySKJa0hkYVNg4BGdUz5zrV0GEX6lTMLQ1UMdX6bZzY4fSF/dtEmpyFjR/WSwpeWWJfWjSwS/Gl5XK3BXY6KloOX3gY3M9eecADL/NBwIo0YlAULSZtXK4vmnFKdqSzSr8lEpQjrK/cder+WyDQwtOFKBFSc/5xH+TWcCpYza5SzZ2TqRRYOOJgUWthH3fIvlc75VxDwHfkD80aQUmcq7XgKMBnwVZNYozDX1VzVNKlW0ZDk7eNS9XS8RgrdCUJfTdVGorHWHMLCdyTNuCn2E7HAUcY7W40qm35hMPt0Z2E5Ammq9jLiJFGdaHyPwcxH32Rpx55UkTKcVo8oCqghIsipXuDh1vQTJZNHL5p4q6CMrRr/QT0BPviyfpbSIonsojq1xwmw4uPR3oui6CCtC3/0XXH1UVtZCNHkHwDLwCOd5UY/Gc5Aw9NieW4m4MoJsUglLHIHr/QhiPb6yNyOfJKtQlLkA6ql8hMDQg1zPWBIOo+n4pDqJqq00nX8W7K4fhiX7yFAlYEeiTguV66erECLGmxLFDxWNiMeCYPKRJXQiYvcTVI+iZgIDx5B3EME6/KlhK3FrQZhdJARCDYTYH/Qv9HV+2OMfQ/xsLYpuIJC+eU0LvnoEoo42dvsqmUG3omm25KagCFktN6JqywgePsIcPA7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(56012099006)(11063799006)(5023799004)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1M0EttIIaGat/Rza8oM1B0KgRthNQ60OJjYfLg/UhqQm1cTmfujiwYzmssYM?=
 =?us-ascii?Q?oWX4xxqVlukBya1ha6ORrqQJwYUYCxLfcPpEhMbS11UMAQYdJpI3xb5GCz1l?=
 =?us-ascii?Q?dEq+fqq3tH+AAN6+4eG5gWBVGiY2o68P3NvY+z7RAI4t+WV8ZK9ecyQoGv4+?=
 =?us-ascii?Q?dctqqh6P+/Mb4Bs5qK61rzozeLqODOVrF6BotnGg57hC1Xe0xisX27HJ6sA6?=
 =?us-ascii?Q?Hnh/fKYZ8WjSmTqsZflZVm7KhWLgCf555nrjC2EKJd4LW8RbA/yP3d3a9AIc?=
 =?us-ascii?Q?CTJRAH8C/bZy9x/yjUsdVvgSakhgMjbNLmP4yluAnI4iDMeb332uXbQ2jGnK?=
 =?us-ascii?Q?xixx7nlksRzGl+SyIeyv6VqKutTTR0gGjuRL5fHh7tyCmAzOLPuRcmSt6M1Q?=
 =?us-ascii?Q?7U7pH9q4Um1U9w6Nc6JnavAdiGUvwDJpuuCKk0TPM5IzPchYFVxu+t890ryi?=
 =?us-ascii?Q?eH5cRt/+/tyqVAsNRJAqKHI2Jd9Ms4+7ltL2NGW1zGtcq4x992mzuE/8hJBa?=
 =?us-ascii?Q?asSh7iVVptXCCJkaQDkMh5fT9jZ7KxGovW2ftAaNL1Tmi3v8+IGIdAEUpcUx?=
 =?us-ascii?Q?naXp1tntHzcYJT5h+bqXUYvAHJ1/U4ZiDHtzhduPJdi0yNzlCwwjsdjyXSXJ?=
 =?us-ascii?Q?zpadrI1Nkbk4Ni9uAQGWVCyNFo+czsHwjXiZKIoGxxncomjwBvbIEWb9EChe?=
 =?us-ascii?Q?yi2VXZdOZeCJLK/uCWDoYVAjOqX2UnBsiw1cPLSIXMrA3WQufQkAZD9etNEL?=
 =?us-ascii?Q?2o1URFprIn6IYs3Y1V4hf3qqlCDpCPpoThuYkKBFr5MKY2zfE3lBvtnJ27Xg?=
 =?us-ascii?Q?ZGFzCQKgM+4MntZX8BnkaYY4wiOUBntTkv+3fissLkqlvDUg3UoVIBUQ7vSu?=
 =?us-ascii?Q?RBWyhK4rT2xutDPoop/tD529wSELfpeb6Ke0QMBOKb04/az5BHQ8/kNCBwbD?=
 =?us-ascii?Q?6XgJQCY0pOqp2TWcEyYkMgXKjafSi8GqFb5LjWWJmLeNK5x8vyHqwoOcUD4f?=
 =?us-ascii?Q?xfNrsE/enoXiecao2MrX5CNHX9PNwYcs8kRVLIDwI/gdke0t1VNZjP0iI48G?=
 =?us-ascii?Q?+ozi5xv9+uUjUxaadGlT9eDmeiiQY2KZUA//iMxv22lgU7d5wD5tt6n1wMJs?=
 =?us-ascii?Q?hRjpT3oOwI1h5Zl2rdpXfkUNryibLt7CVovuOMMGhiSNYG1jSOjtv+5nEQ9s?=
 =?us-ascii?Q?XfD8Q/tsrjXlxhTUc6zPYkuF3PA/7ea+nK7RUL1hf3Tfoc/1y3TGqDgCj7C+?=
 =?us-ascii?Q?NPfPf2AhxDHc6fh/pLyAItBxxUKdqjUiAgawVEYAefwGConLLZq6B2IdNIGn?=
 =?us-ascii?Q?p1jg0jIbaVs6cQDgVscDvnuDiMBnFBftg0Z73uI+T4hfVhZp/Zv6zr0a3XF1?=
 =?us-ascii?Q?JYGUYVavaBc2XzxfSZZyoYAR8Q2wYpe5dnP5C9+qI/uj8sDEqoi7Rsjd3iUL?=
 =?us-ascii?Q?MFpCkTeO4Xc96du34Qzo+18Ot9DYqG6B94KR0mDieTkG/69qdHPX1826TqIW?=
 =?us-ascii?Q?1PSOeimm9nwUbJ6andX42dTB6V3OchC7Y3FZ2Z7y5RYAkVDkOCgjE/bmC3tG?=
 =?us-ascii?Q?JPUUu8AL3HP3ur8nqfys0xzwPfeNn3xempcKS/1S2IxP+eg7YeDQM9E3TqLM?=
 =?us-ascii?Q?bwlPrE+dvcpcd1bdZKY5s1q69Cul4KioDFrsRsgsuYup4Q50+98as5qlFW0m?=
 =?us-ascii?Q?cfBJiheguKBcgRHs0PCaVCIiyQRIUQ1SVbbcYt/C9Vpgk5HTM1ZyVjckSMVx?=
 =?us-ascii?Q?dxn7qQz6tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3709fc85-6909-4b1d-13e7-08debc9394b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:31:57.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+bBQmPxOxM/YZ91pPoXxPebeu5/TGRml834yFFVOghyn6zPf350ncfz44GuZPvtaWv2jk6sx9bMfXbmG4lI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Hi folks!

This patch series introduces support for the CXL Reset method for CXL
Type 2 devices, implementing the reset procedure outlined in the CXL
Specification r3.2 [1], Sections 8.1.3, 9.6, and 9.7.

The userspace ABI is a write-only cxl_reset attribute under the CXL
memdev device:

    /sys/bus/cxl/devices/memX/cxl_reset

The memdev is the userspace handle, while the implementation coordinates
the target PCI function, affected sibling PCI functions, active CXL
memdevs, and any CXL regions reachable through those memdevs.

v6 changes (from v5 [2]):
- Rebased on the current CXL tree used for v7.1-rc4 development.
- Move the ABI from /sys/bus/pci/devices/.../cxl_reset to
  /sys/bus/cxl/devices/memX/cxl_reset.
- Use the memdev as the userspace handle while keeping the reset
  orchestration scoped to the CXL device reset scope.
- Reduce the earlier PCI/CXL save/restore series [3] to a single CXL HDM
  decoder restore/commit helper patch, included here as patch 1.
- Do not offline or hot-remove memory as part of reset. Return -EBUSY
  if an affected CXL region is online as System RAM or has an active
  region driver bound.
- Add reset-idle validation and CPU cache invalidation for affected CXL
  regions.
- Add CXL sibling PCI function discovery using the Non-CXL Function Map
  DVSEC and CXL.cache/CXL.mem capability bits.
- Coordinate PCI save/disable/restore and IOMMU reset prepare/done for
  the target and affected sibling functions.
- Add CXL DVSEC reset sequencing, including CXL.cache disable,
  writeback-invalidate, a minimum 100ms quiet period, reset-complete
  polling, and Reset Error reporting.
- Track affected memdevs, lock active memdevs across reset, restore and
  commit decoder state, re-enable CXL.mem, and wait for media ready
  after reset.
- Cache reset capability at memdev registration time for sysfs
  visibility.
- Document reset scope, Memory Clear not being requested, and -EBUSY
  behavior for active CXL regions.

Motivation:
-----------
- As support for Type 2 devices is being introduced, more devices need a
  CXL-specific reset mechanism beyond bus-wide PCI reset methods.

- FLR does not affect CXL.cache or CXL.mem protocol state, making CXL
  Reset the appropriate mechanism for cases where those protocols must
  be reset.

- The CXL specification highlights use cases such as function rebinding
  and error recovery where CXL Reset is explicitly required.

Change Description:
-------------------

Patch 1: cxl/hdm: Add helpers to restore and commit memdev decoders
- Restore endpoint decoder programming from CXL core's cached decoder
  objects while keeping CXL.mem disabled.
- Commit restored HDM decoders as a separate step so reset orchestration
  can re-enable CXL.mem only after safety checks complete.

Patch 2: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
- Export PCI reset lifecycle helpers so CXL reset orchestration can save,
  disable, restore, and invoke reset callbacks for affected functions.

Patch 3: cxl: Add reset-idle and cache flush helpers
- Collect CXL regions affected by a memdev reset.
- Fail reset if affected regions are not idle.
- Invalidate CPU caches for each affected region once.

Patch 4: PCI/CXL: Add sibling function coordination for reset
- Identify CXL.cache/CXL.mem sibling functions in the reset scope.
- Use the Non-CXL Function Map DVSEC to exclude non-CXL functions.
- Save, disable, restore, and unlock affected PCI sibling functions.

Patch 5: cxl/pci: Add CXL DVSEC reset helper
- Execute CXL Reset through the CXL Device DVSEC.
- Disable CXL.cache and request writeback-invalidate where supported.
- Enforce the post-reset quiet period and poll for reset completion.
- Block and restore IOMMU traffic while reset is active.

Patch 6: cxl/pci: Track memdevs affected by CXL reset
- Track the target memdev and any sibling-function memdevs affected by
  reset.
- Revalidate and lock active memdevs before reset proceeds.

Patch 7: cxl/pci: Orchestrate CXL reset for affected memdevs
- Coordinate region validation, CPU cache invalidation, PCI function
  preparation, DVSEC reset, decoder restore and commit, CXL.mem enable,
  and media-ready wait.

Patch 8: cxl/memdev: Add cxl_reset sysfs attribute
- Expose /sys/bus/cxl/devices/memX/cxl_reset.
- Only make the attribute visible when the underlying PCI function is
  Type 2 and reset capable.
- Write a boolean true value, such as "1" or "true", to trigger reset.

Patch 9: Documentation/ABI: Document CXL memdev cxl_reset
- Document the new memdev sysfs ABI, reset scope, Memory Clear behavior,
  and idle-region requirement.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no provider is available, reset fails before hardware reset is
requested.

Command line to test CXL reset on a capable memdev:

    echo 1 > /sys/bus/cxl/devices/memX/cxl_reset

Basic CXL DVSEC reset testing was done on a CXL Type 2 device. The reset
sequence completed successfully and ResetComplete was observed. Full
memdev/region integration testing is still in progress.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2024/12/CXL_3.2-Spec-Announcement_FINAL-1.pdf
[2] https://lore.kernel.org/linux-cxl/20260306092322.148765-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/

Srirangan Madhavan (9):
  cxl/hdm: Add helpers to restore and commit memdev decoders
  PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
  cxl: Add reset-idle and cache flush helpers
  PCI/CXL: Add sibling function coordination for reset
  cxl/pci: Add CXL DVSEC reset helper
  cxl/pci: Track memdevs affected by CXL reset
  cxl/pci: Orchestrate CXL reset for affected memdevs
  cxl/memdev: Add cxl_reset sysfs attribute
  Documentation/ABI: Document CXL memdev cxl_reset

 Documentation/ABI/testing/sysfs-bus-cxl |   28 +
 drivers/cxl/core/hdm.c                  |  318 ++++++-
 drivers/cxl/core/memdev.c               |   30 +
 drivers/cxl/core/pci.c                  | 1140 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |    5 +
 drivers/cxl/cxlmem.h                    |    2 +
 drivers/pci/pci.c                       |   22 +-
 include/linux/pci.h                     |    2 +
 include/uapi/linux/pci_regs.h           |   15 +
 9 files changed, 1557 insertions(+), 5 deletions(-)

base-commit: abb3c0de119032f4c0c81177884a3bb0a133e6ca
-- 
2.43.0
