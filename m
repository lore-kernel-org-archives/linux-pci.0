Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9825F994;
	Fri,  3 Jul 2026 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116318; cv=fail; b=V4bP8qtGzqwvDh8IWsUnKM2lFUYgw3+iCf+qioVUgGM9XR5HX6WPgfWfqvOgDU4A56Ozh9G76+03c7JxpDEEXcAGaEDN9DTfqZFkj/QRDTu4W+CSMZ+8EZnlCky2vqZC/Uysrl8cUF/MSdhz8PY+BLL9eDrzae5mBxki7+ZgfOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116318; c=relaxed/simple;
	bh=LjlsXC8CeVmdf3tOYtiVjuCy1ocvtueVaQk645JcDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cywfeWxdwJ+fFecPOyy6RNhZyeg7L8S+j9B2J/t5uqlL3NGfrGhE4ywWjsBjT7axnLP8rq4SbiCJJ94OKxdAamcs90nx64Nks034K/ddtnv72t5WYvkYU4wrrdi1JAFuN1oqzRh8xEayAYrQEd3JrVuyjzk5TG1MnivxWP4gLas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOW79cHX; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOW79cHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbhSakUCucyAarUXTU88z6Jn90ZS5OSiCyuTPAAVxqtoJrWCPj1AjO3SaKj2Jtnoxppfle0CW574jOu3Xx7UYQdt+PrJP7H66QCgXf36/a1yYpjA10NuEpq0fl0DmL0OIiJwje4nJXdjjxFNvrJqzxDGkiEFlhA+nT94CQL0SjmCWxE51Aas//nK42k5PIxh2MweIClzAll6vcAzkg4PqUdI2SuFrpjC9fhbM4P18SM70fx4suwtU1qEhkIhmTvDpuUIQGlMOgoJ8vPaQVgYRZXRVeaMZ+DhIYrJeTe7O1wTaPwuZ0lZNicMehOSuuuVFD/rjDtuhFSyfWnYOo1i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y8trtOsWf88XjtsZ9h3b7u0CSejVffMdi21yqU4bmo=;
 b=FzPSDtw3BFkpkMMBA9nuz2uAlkNTYN9S81hxpOxkzBcr+DZcy3wdeJRNaqjrKtcW1kG4IJJzSiWJTfDMNgc2B4ClL39CNH2CLmpra1bNGfAOhlL3ow2oabXHA3aYvgDIhteTvv+sbiR70NHYW/sk8unhbBZDIyixv41FRIFP0bVLxizBGbpKFDzGEHMI6x3yB8EZJaIMBZkIN1JPwUihIByjGtF+KTiVJqjFNCXrRUihJqXkyNVYOi78K5glBYk/5vwHgLJsESzE/2BdEi2xQwbwopbl1FIpeybezwWWgivZ1BecKL8400TNB9DozjQ5ye8WPDNaSheG0iFvIAtwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y8trtOsWf88XjtsZ9h3b7u0CSejVffMdi21yqU4bmo=;
 b=EOW79cHX5h3H6Q/LWHW39wswgNcTzvB40V8aFS01z2SABqfq+TiVrIvMZN6KGdIvrNURByezCrKkFMbLpbrUGJNWzphz7JpSfsv2W75U6e9fBSLJR+xCNFn3IUzCIdBwqPPbFQySpzjBKNqDVzjhQzBPGQ/1JSLTEHfFV+xlb8wprLn1TRZfvLB9zybam5CiB/HTpnLVWBIrc69VJGVEPxdVKv6UQY51cOUD7zGxN9PGcny08/JsSwOkW6kq8D6zLfAMPLh5wCBS3feq/BJiPh47d0KVajiHOCu4PuwM764hrx80V70yc7nifv25PdawhcpikFd42euX/EEuRy9CpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:11 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:11 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Fri,  3 Jul 2026 22:04:58 +0000
Message-ID: <20260703220508.546528-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4e044f-35f9-407d-65e9-08ded94f26f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|18002099003|5023799004|11063799006|56012099006|6133799003|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	sPZkqDEYNCA8J5PUGK3yTPh7v7Ch/Jd3vsukqzPiyAV6y5T/HcQ8K9NHXQUeG16QFIxHAIXGeYffZIuAmSvPwvHyfJYn8m9iFHojS2I7IDPNao/KIn9o2vu011/k1sEGk5xqE9SyrnhqV2Tuy7okAT9lzWFKKti8+t2ki2drCQvMc6CqYWqyKV8L2gCekVuC3/tOGPvEsHIsxqu7y3YCl+nssNXJiFL4S5J4j0O3ANJ7W3LPRpgjwut6xVXbPt0XmOIp36bjb2LWou46E1QUrzi2ANl08RF8whQ+okmmibsK4J/nCc7gH50jGv5zlT7CQltrXXKHEv4iAFb9We0iwAoFKCx0rih9a6zGywA35FUVUroxnZFuDgSH53viqdnQSmyDSaNrwd4Ojt8eNLP8MD3KKcUAwimMkfhtF+ngujzerYbRLMIFfBU9/tKSJ32GefnCEhQZK6UX3mL2E1aJ8hWndu0HhIQdPAR4RJPuIIGmlLVN7J84vZ5U8/bykgVkMOzSBg4D+PDCP8VzVZa4oq5y17sdiG6tcYjwCMX2/sbyECMmbXJb6lJI5xpImehe0wSG2VpXDmRVAyMD04cyTL+DssCSBZRlADbcYHpDRR7b3tYZdRb+fZSFDdeJFsHbW8fXf8ioH/n0kGsABv6+sj6CEl4HisaJKg8UmIVgj7jSpBY7XAB4TmQNcUuIZyU+0U977XE1oLKumBMGJQI1PQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(921020)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFc6XPRNv4WEUMh01Qn+Q6MixTQH/dQ8fb8ih/XVzEIXsu1xnUE5CxUc4IFN?=
 =?us-ascii?Q?Qm+bHsZpGd+A8cZNyD71An94ceq5iE7AT+pUj2l7Q0oEA6PYGJ3QHOCHK5OA?=
 =?us-ascii?Q?Q/uXZrlWlrFMVRAKPV5Kl7uISb3etn7g87NlbX9yVWdEv69yO+1kXjifSOYT?=
 =?us-ascii?Q?Z5yGxUhTKcEubob0G3ZAN+wBNMPxf2yj68MGLW7oIKwn4Io8KjJFHTSEC/VT?=
 =?us-ascii?Q?nE/OVoBmzOc9MvmcNqlyWbaJ6+ZiSt/kpmWfoWNYqAdh7wqguRYVT0igu3bl?=
 =?us-ascii?Q?qi2OAynyUPVVLgddYFs4ii92DCgGxSMRcYFVYA6Id00qqHlDw0MvAAgMH5ro?=
 =?us-ascii?Q?8hZ2gvaUEp2YGo+qaXgM4BDjppk1+riwYwGqlO/gRoEHRzOGV0yvlQZXpy8z?=
 =?us-ascii?Q?98un8VfeEsijMBw7lCDX1o4XdMS9iujoCOF9nKCWSvza6jlohXULFnsMHZNE?=
 =?us-ascii?Q?mI0qS+Ur3RUPIyxenL4/thH5woa3Bt5PdrUbbxnY3PrBJwiMj73jw6zuipky?=
 =?us-ascii?Q?FVIeA8vRWILJoJpLnKdVOPX6XF2DgLUs6KR5oBJfpzz8XmUqndqA40WyvRd0?=
 =?us-ascii?Q?rHgSWx5voTbrkw7MZKSDB6ho1MehmTR+olnGM3qHYJ9qnDbZgWV6ZhFQGDBX?=
 =?us-ascii?Q?6d+XKYamEQr9JcQSRWI/K6R1ppKdNT6Q46lX9satlrtHvJqkRCfxEXVUvVg+?=
 =?us-ascii?Q?9kd7b3BUlwAJAiDfjgYLBVyApYAYg0tNfGfy6e7xxB1PzXMI39E63Ze/v8WS?=
 =?us-ascii?Q?9/KbyDs4diFv85XX/0PTjCXBXDBF9mm2ZGowLgd0hz93l7pg/+QFi2URLKNJ?=
 =?us-ascii?Q?VgEWm4ZQK5zm41ddSzqwOSp383NAWoshEx8FbWe3Afv2nJI2Cru4/BlOBRPS?=
 =?us-ascii?Q?pLEk+g19EsVNNz6RXrkMlOaoCBNlshZciOImGAL7OB7AzaEAvtHqs2d5VtGQ?=
 =?us-ascii?Q?MqFpuOP4ODm4fu8GFR8r33hr3X5EC3dpkvYdmn5JSpYQBwXPFsa/vPxtH1pA?=
 =?us-ascii?Q?CSoI/pAQXdNVkewMJS8H0xD3rD+1GMfN/CBCiCLuI+/rBeSUMvotTcO+d4Hh?=
 =?us-ascii?Q?lb3AvTkalsYSrKOJiT/k6qBKpXeCXauVav6v0haRAZVA0jO9R/4N3vmt1wr+?=
 =?us-ascii?Q?UW9T4f+AulazoOW2I+IwruHB/eGPPFt5G7fO6zfRRr2DyAOFfgno7/dOaZOs?=
 =?us-ascii?Q?yncUtv+qRM6ZjfR66+dc2PPI96NUEtWwcRWPj8X+2C1WPmPq5HejSPC6TcQw?=
 =?us-ascii?Q?DoXQB37j5m/lpoh9w6+b50CMNQBlRPLS9rakKNZDAzQk7sBFKwcRJlpmNtop?=
 =?us-ascii?Q?VSxLv71Z4WqGcDA4yfEj5VYj+2VO8kGX3q5imRK8tjoXYsII3Cy8KeAPPcVO?=
 =?us-ascii?Q?iN354dQ22xE6R/Onq+BELktND+ikGsqfOCcgFkzNk3btit9Nv9tc7cT6cldu?=
 =?us-ascii?Q?IXJ4YR6G6D7r7uIzkFpw5MopFiFksCphs20KiZTnhxCQvSTRUobH6K5zVkcG?=
 =?us-ascii?Q?yz6UMw0f0wt6iXk+qpqtjBxeFQ15g7t2hSYzhdp+0Fa7AgFnA0kql20VP+QI?=
 =?us-ascii?Q?axFrbby79Ho5LkXxPT1R5re1fLg+9khoLhLp2mYOKpJG42Weq9PlLicBVllr?=
 =?us-ascii?Q?2lUrDYwuAJrMtbir7LfklUZ9vFKX/QbvNk+oo/UUTnoB21wC6lu9IMf/7mMr?=
 =?us-ascii?Q?4tnAPtl8Xpl5Wig+YRvq8Wy0DLjIZwJ0ACmm/884iDRDemAYJKNwsopE3YwV?=
 =?us-ascii?Q?FVEA+lAeqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4e044f-35f9-407d-65e9-08ded94f26f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:11.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuFvPGNo4aGH2bH+nX8cWx9lQoyVN5736rISXNecfNoIsnwStZ3yzz9SdQ2+c9FP0PfCFQ4mm0bFzWjPrs8fkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Hi folks!

This series adds CXL Reset support for CXL Type 2 devices through the
existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
specification [1], including CXL.cache disable, optional cache
writeback, CXL Reset initiation, ResetComplete polling, and ResetError
reporting.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace can select "cxl_reset" in reset_method and then trigger reset
through the existing reset attribute.

Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
with the existing PCI reset_method interface.

v8 changes from v7 [2]:
- Drop the PCI helper export patch.
- Drop the multi-function sibling coordination patch. cxl_reset is only
  exposed as a function-scoped reset method when the CXL reset scope is
  limited to the target function.
- Keep the reset-scope discovery needed to reject non-function-scoped
  CXL resets.
- Cache HDM location as BAR-relative metadata instead of keeping an
  enum-time MMIO mapping.
- Restore HDM through a temporary mapping based on the current BAR
  assignment after PCI config state is restored.
- Cache raw HDM decoder register state so uncommitted decoders can be
  restored as uncommitted, while committed decoders are recommitted
  through the normal HDM commit flow.
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM caching.
- Put cxl_reset ahead of FLR in reset_method priority because FLR does
  not reset CXL.cache or CXL.mem protocol state.

Motivation:
-----------
- Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
  reset methods.

- FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
  the architectural reset mechanism for those protocols.

- The PCI reset_method ABI lets userspace select this narrower CXL reset
  before falling back to broader bus reset methods.

Change Description:
-------------------

Patch 1: cxl/hdm: Split decoder programming into a reusable helper
- Move shared decoder settings to include/cxl/cxl.h.
- Factor low-level HDM register programming into cxl_commit().

Patch 2: cxl/hdm: Cache decoder settings on PCI devices
- Cache CXL core HDM decoder settings in pci_dev->hdm.
- Refresh the cache as decoders are enumerated, committed, or reset.

Patch 3: cxl/hdm: Share HDM decoder decode logic
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM cache setup.

Patch 4: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
- Snapshot endpoint HDM state during PCI capability initialization.
- Cache the HDM register locator as BAR-relative metadata.
- Cache raw decoder register state in addition to committed decoder
  settings.

Patch 5: PCI/CXL: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset, and wait for completion.

Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges.
- Reject reset if affected ranges are busy.
- Invalidate CPU caches when runtime cache-invalidation support is
  available, otherwise continue after warning.

Patch 7: PCI/CXL: Discover the CXL reset scope
- Discover whether CXL Reset is function-scoped using the Non-CXL
  Function Map and CXL cache/mem capability bits.

Patch 8: cxl/pci: Restore CXL HDM state after PCI reset
- Restore cached global and per-decoder HDM state after reset.
- Re-map HDM registers from the current BAR assignment during restore.
- Replay raw decoder state for uncommitted decoders and recommit
  decoders that were committed before reset.

Patch 9: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
  CXL devices.
- Prioritize cxl_reset ahead of FLR.

Patch 10: Documentation/ABI: Document CXL Reset PCI reset method
- Document the new reset_method value and reset behavior.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no runtime provider is available, the kernel emits a warning and
continues after the affected HDM ranges have been reserved.

Example:

    echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
    echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset

Testing:
- Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
  CXL Type 2 device. All iterations completed successfully and
  ResetComplete was observed.
- Exercised cxl_bus reset separately with an add-on HDM restore patch.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/

Srirangan Madhavan (10):
  cxl/hdm: Split decoder programming into a reusable helper
  cxl/hdm: Cache decoder settings on PCI devices
  cxl/hdm: Share HDM decoder decode logic
  cxl/hdm: Cache endpoint decoder settings during PCI enumeration
  PCI/CXL: Add CXL Device Reset helper
  PCI/CXL: Validate HDM ranges before CXL reset
  PCI/CXL: Discover the CXL reset scope
  cxl/pci: Restore CXL HDM state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method

 Documentation/ABI/testing/sysfs-bus-pci |   14 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/hdm.c                  |  257 ++---
 drivers/cxl/core/region.c               |    6 +-
 drivers/cxl/core/regs.c                 |    4 +
 drivers/cxl/core/reset.c                | 1354 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   43 -
 drivers/pci/pci.c                       |    2 +
 drivers/pci/probe.c                     |    3 +
 include/cxl/cxl.h                       |  102 +-
 include/linux/pci.h                     |    8 +-
 include/uapi/linux/pci_regs.h           |   15 +
 tools/testing/cxl/test/cxl.c            |   10 +-
 14 files changed, 1615 insertions(+), 209 deletions(-)
 create mode 100644 drivers/cxl/core/reset.c

base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
-- 
2.43.0
