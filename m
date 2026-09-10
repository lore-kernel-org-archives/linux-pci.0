Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48D392C48;
	Thu, 10 Sep 2026 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024106; cv=fail; b=qa5jzI2kJSoEZbvYdEQ++gj11kJuBcEh6FmmG10KQNWj/JxSx13nygfLr1MtkJakRKyztcIPDixaqqk5437Ll21HVjZcLf+GqEiJrPCcKXny0ZQ24I5gIMZYpf7ERXaelKaqu2yyreShp9JQnuNdNi8cUuB5uRVKC4P5D7hOkjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024106; c=relaxed/simple;
	bh=kb7pz2r/nF3S7sLDNWVt3hq6f5GTrRLJnTU9P+wcmvo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=md7YzDIvZIfHk2lM/gNqqkFBwmZQS9wN3FkYa0FMAmrvdf5mniAvf8lWCLoZlRijtTsGOFohucMWCXCQK84TqQBxO///p+H4Y2VQW14XZU6XNJIELVCrwAxvqbYfWuIGw9eMolp4Msfc58924FqQgml28jPh6Ju1ogEgp0eWDmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kB25nwgc; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kB25nwgc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpfyeSuw2565qouCROYATcQ7F62w9mNC9kZXappNRo9Pa8NCXDQB5iI6MCv5s6qwpdEp4MMvROIyIaozuUYVkQ1QOaQFuDKZJ8myR+2vA3oKDF17aH/JcLiKK0MGFMue8WFcnuHgiX0lbNBYyM83r0d4wHC/zpW+IAN71CoZqOTSEnn6ghRomuewmY2WQIx2Jlh2S7cKxhxjAf92rO2/dHJBfZFlQP376MMFsjaJBT1FeIi4sC5mDlJE+m3S4sCICv6Qc89JCzbmCwoCpUkhwQJd1yXr4t83Uf6C+q7uk9b+1VvWyU5y63hC2KudnelH/igM7VnMzntwpAIJWEs/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze2gRTDgMYdqMBtYwCnn3BfxN/iQsZoCRUhYeE/fyKw=;
 b=AZfy7QQ1WovhOp+pP03fqtKnUCF1Th62k2aoinLdwn0Zv+R+AYR3eQ4i0Jx8m8JhDt879Y/kaJTjAD7ftkRJIeHkcuA7RQrQLZEumM/RYUbqo9ue12UpA3om7TR4IqGOgQOOTW3KQz5K/6aR09QClrvkmHPrENwE/N7+qoi9UsPZ2ZLZbDMuybmTrbsp0wEDKcRBiMc/dVpV4IuUtJNKPtlnDGlHY/TNs4LmraVH79peh4lVT67/ysaVQf4S8tO3dherITh/y9bKxJlTNdqGHLd1ZhTXnZKy5RIs8Fmo3+FwFtw87p6TcdoDTW9DHmaccRFoayKCegcGPCJfVVsIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze2gRTDgMYdqMBtYwCnn3BfxN/iQsZoCRUhYeE/fyKw=;
 b=kB25nwgc2hTAQfwmjWOw96HGwQXeppXz1CoOf/7J7aAfjo1cikwfOqEfTZz2+hEbdq8aTIP8x10axdz0OyqXKFS9JCnZ5J9LyyEClwbQXsOVMfCqUG7pqhmML+rzdek37Oex9tIuyWykLtW/owkiwr+sByDlYw2Sy6WH3g43PpSpf8kV4CBcyEJNbywuRtwFNwFqzwt7MuppWHzC/ad6rRA/9ZlAuVIL5C+RN0ZGtujB1/w6AhLFKN0oN/ovzcJ6DDQPA0wzvDb73/SChRN7VZGYg13ZNu+3VP1eztk9FIPSK0mAzTwqMZumIUgPz8/sYR7OEiAVGLEKHecShbYf/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:14 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:14 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v12 00/12] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Thu, 10 Sep 2026 07:07:56 +0000
Message-ID: <20260910070808.1444264-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4faa77e4-744b-4ee2-96d5-08df0f0a4833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Srvxo+WC+RqIRGhZCmVCKQ832wPOwfW+pwh6JhZpWyoqCYUxwg2RQYXnHH7Bb6oXGMNhNpc8xBpySNI4LUP2b6ErUY82lHaOqVnVStxKhQn8MmeSsxhyqLHAaktyhxhW7zFspjTv65Wg5R0nV2BMsJqGN0cYcoTJtPyappFQq69ZVsVzCSbUcYsnHJmEsXQbUYrwgQAGQ17uW8GkCGoAYokSAglsFHs2DjgaDbV0KeHsNV0wxK4k1foIUHyMV8VLKD2NmT9y8d5RiD3N0ZKhdT4hiFVact0FgzwPCmjv0oHFjQe+unFyCUH08TElvxJK5i6aMlI/fm0wSjthPdPWAYn1zWlpO6lbmPZn3setUpUYjsLgXUvSiAqGP2tIi5AZ1QZQtPkqHSzXKavnq6IOQqLrqluCYTWbLkAQy9Z/6SZyDCpYLT5POHgKvbEOcPSTl+jd1Gp9ROr3zkKzPQLFF+H3q/QV3zniucPu/mgp7LVy8MVTh5/sbjBJasb6bzZ5VZagPidEzBtAB7aoPy5YqocL5JzQGgca9US8eyEjMxddGFvQZfb6eb0HfshkfNZCHZ/W0Ui9C17xYI0VASGgguEdMdVQV58MMUwdeoz7F1f/z9REf7srkbALE97Xcn1ef2KwknKtAlMFBnc9xfaqxOQF9Eg0D2OjxLI14CJLy6YYEdGtdzm4IAdMYqtfoAxtSX7VVnpVaw0Ni3S4DDr8+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTNZxHQ/57Z/Cf73oFC9tbOCO8NxCCCi7ClUBSbSUDgJvkhBShJFSstzvrBQ?=
 =?us-ascii?Q?YSdjT8zEH13uoMmcAS+hTIQbetakfR3oaQQYcZSQxMzBG+h1M+GZs1i/z9rA?=
 =?us-ascii?Q?gQC0VHPrlLbc7mbz09O8iwXlv63stO00JI/r2IzjwJRlyicbY5AEPTWjMZnk?=
 =?us-ascii?Q?rMC3Lt8gT2+gXfK7KCDk0LX8i1rrilDCcweaEB99F7zuncjA9Ayut8sjVdd9?=
 =?us-ascii?Q?lB51OaXuBImir6X0PezXLQb9DYa5nF/XjQD315QZvWJKZtyGdi12UZmXDwRp?=
 =?us-ascii?Q?RFdnBcc/nmH7iSn0/eqmuhv7VdEDIRj/D8lJ0+10LACKn+2ZdDeLOb45AgbR?=
 =?us-ascii?Q?JX5if0eRcBCi5qULxu3Rg2Hvx3DUjbhafCv2z3BUHjqNaIWOQe4y3bLbJcRK?=
 =?us-ascii?Q?OUIoiyTKmBVXXqzpBZu5d4rxHr6eLfrivwCOPYOVsNMByRG7tTa/lu4OEZ/g?=
 =?us-ascii?Q?GSA58f/j49Kqynesj49MU6ruUCHZMFFooUDQ77WHydeYlxGh0ezuape6xeH6?=
 =?us-ascii?Q?y8DBs8sfYs5p4LTX4QdOKmcuhpJbWy+8AhwTnl3O2vKNZNtJBohMUiP+bm46?=
 =?us-ascii?Q?Zn+mDOT6sCh3HjWfcg63nqAPeStyymgg7cbFsgm5p2jkvQia9gfp8MdBC8vC?=
 =?us-ascii?Q?lkd69z2VmpXgmdDkiZZ+VkY4j0nj0pexfnBI8+VEGM/nOK3KrTRT9NVhOGuk?=
 =?us-ascii?Q?zzxeowAwc3H9oWGp0j6wcbtUGLSqdWxQ2QzKpZxlO9Ps7bUodc0kUSL60wz+?=
 =?us-ascii?Q?EqdSEbvf8q3uxs04M++bZkHGzogKthVWxBkVd4Y4c7eyqYLDKmA9Z9HdDWQm?=
 =?us-ascii?Q?QWE1rcPi+bUhRlCleQpRTR2YZ1CNzKq25RpJKa3OzX9ncsYuVIrXWHck/rTL?=
 =?us-ascii?Q?bD5cVU+e/3W7Cx/071zr7Ue6S+ko+2h5aWGNqA5p8HAg5hXCmczvPLpuPAeg?=
 =?us-ascii?Q?kpWwUzI3Dh0Aklo6a3SNWKrm8mjDx7I+10D36OvFdVdkRAgvamOd54zWON5i?=
 =?us-ascii?Q?JlFC/b7nfLTVqsJtiORe3CiVmfdax9sbcavUveCS6XUMFn8uOiV1eev1Sf3p?=
 =?us-ascii?Q?+iUV43DE1LnQFazzo2PnW2PsrikhqlmTqPkp+ZbRsgY3yK3nV9AdObqGwFJ5?=
 =?us-ascii?Q?PadulC24wabuEdww0xYBZKe37eJws9V6in+rJJb1VB8EnQ8MHiUvHo5Q2Rep?=
 =?us-ascii?Q?T3a+oK720RY/rJ4ubABxpyvRLZHZ9f2kd55BYMPSRqYxRoADuoZielzdkCiX?=
 =?us-ascii?Q?EtG1EPbLrQQBW6c964pP470PsTBhdczY/WO+Bb9zr+XfN13yz0gbmN7jpPF+?=
 =?us-ascii?Q?rDbdl7QCD8QIZ66f/9ifZzxZyTCFH5WoicBrAoP4Ko3ePg/MYeHTDJ682jE1?=
 =?us-ascii?Q?mrGkcpGjKlggUEVLRu4oJUW7g/EuUeC2h5XdgAQ5g9v8EZPWrpjTeiPCzKsG?=
 =?us-ascii?Q?4NT6mEDLvhtmvYb8lKzo9lz5BmN2oIOYpjmg47NgvOYJPW3H3AHj09CUEIan?=
 =?us-ascii?Q?orFzU2uaCLnVbSd6Hb7dNm6+C5gNnvkUXu1W/tpmk6SeY+QTTGa0H9HanxY8?=
 =?us-ascii?Q?8c4gtdfUBHzZGH6rkgyvKJomPgk4JnUj5WXhbH2MA9gJmxtUC7l+dKIa1YWe?=
 =?us-ascii?Q?N4EGPqgDIRo3EmNCLRLB5PLH4aV4ML/uTQ2Xp8UXlP/3wAJtq0suVCiamBEO?=
 =?us-ascii?Q?ChvHS7tQWN24MOAvxtKokZCk2KyNneDyXaLGlLv1/DVdYRfdiUYPCymJNqLY?=
 =?us-ascii?Q?SSw8acXBow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4faa77e4-744b-4ee2-96d5-08df0f0a4833
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:14.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bey0pQH/7JfjLNbin+gpLIcOgq/lSfSws/0WjQx3l9adXWmnU7CmeCQGOnkttRWvVqAwTAsCcgRO8iRTCi4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Hi folks!

This series adds CXL Reset support for CXL Type 2 devices through the
existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
specification [1], including CXL.cache disable, optional cache
writeback, CXL Reset Memory Clear, ResetComplete polling, and ResetError
reporting.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace can select "cxl_reset" in reset_method and then trigger reset
through the existing reset attribute.

CXL Reset is exposed conservatively. The target must be a
single-function CXL Type 2 device with no enabled VFs, CXL.cache and
CXL.mem must be enabled, and CXL Reset Memory Clear must be supported.
The kernel must also have cached HDM state sufficient to validate affected
ranges and restore decoder programming.

For reset through the sysfs reset attribute, the generic PCI path calls
the driver's reset_prepare() callback when provided and disables PCI I/O,
memory decoding, and bus mastering. The CXL reset path then temporarily
reserves each affected HDM range exclusively for the duration of the
reset, synchronizes CPU and device caches, and blocks IOMMU translations
where applicable. It restores HDM decoder state and CXL Device DVSEC
Cache and Mem Enable controls before PCI operation resumes. The path does
not offline memory or revoke mappings; it relies on CXL.mem users retaining
conflicting iomem resources while access remains active.

Following Dan's v6 feedback, this uses the existing PCI reset_method
interface instead of adding a memdev-specific sysfs ABI.

v12 changes from v11 [2]:
- Reject cxl_reset and cxl_bus reset when the PF has enabled VFs,
  including VFs enabled after reset-method probing.
- Require CXL Reset Memory Clear support and request memory clearing so
  the generic PCI reset does not preserve tenant memory.
- Cache the CXL Device DVSEC control register during early PCI discovery
  and restore its CXL.cache and CXL.mem enable bits after CXL Reset and
  CXL bus reset.
- Initialize the early PCI HDM cache only from pci_bus_add_device(),
  removing the later CXL core retry and its lifecycle locking.
- Reapply and verify a cached HDM decoder lock after decoder restoration
  and commit, while leaving surviving locked committed state unchanged.
- Convert temporary early HDM-cache ownership to scoped cleanup.
- Document the reset-safety contract, including the iomem ownership
  requirement and the limits around memory offlining and mapping
  revocation.

Motivation:
-----------
- Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
  reset methods.

- FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
  the architectural reset mechanism for those protocols.

- The PCI reset_method ABI lets userspace select CXL Reset before
  falling back to broader bus reset methods.

Change Description:
-------------------

Patch 1: cxl: Move HDM decoder programming helpers
- Introduce a decoder settings snapshot collected under the DPA lock.
- Move low-level settings-based HDM programming into resource.c.

Patch 2: cxl: Make HDM commit helpers available to reset code
- Build generic HDM resource helpers under CONFIG_CXL_RESET.
- Export the lock and commit helpers needed when cxl_core is modular.

Patch 3: cxl: Share HDM decoder decode logic
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM cache setup.
- Decode zero-size committed decoder state without imposing caller policy.

Patch 4: cxl: Cache decoder settings on PCI devices
- Cache CXL core HDM decoder settings in pci_dev->hdm.
- Refresh the cache as decoders are enumerated, committed, or reset.

Patch 5: cxl: Cache endpoint decoder settings during PCI enumeration
- Snapshot endpoint HDM and CXL Device DVSEC control state during PCI
  enumeration.
- Cache the HDM register locator as BAR-relative metadata and preserve raw
  decoder state for reset restore.
- Keep early cache initialization in the PCI bus-add path only.

Patch 6: cxl: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset with Memory Clear, and wait for completion.

Patch 7: cxl: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges, reject busy ranges, and perform CPU
  cache invalidation when a runtime backend is available.

Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
- Conservatively reject CXL Reset for multifunction devices and PFs with
  enabled VFs.

Patch 9: cxl: Restore CXL state after PCI reset
- Restore cached global and per-decoder HDM state, decoder locks, and CXL
  Device DVSEC protocol enables while the target IOMMU block is active.

Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset-method table ahead of FLR.

Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
- Document the reset method and its safety contract.

Patch 12: PCI/CXL: Restore CXL state after CXL bus reset
- Restore cached CXL HDM and Device DVSEC state after cxl_bus reset.
- Reject multifunction devices and PFs with enabled VFs.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no runtime provider is available, the kernel emits a warning and
continues after the affected HDM ranges have been reserved.

Example:

    echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
    echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset

Testing:
- Applied all 12 patches sequentially to a fresh v7.3-rc1 source tree
  with CONFIG_CXL_BUS=m and CONFIG_CXL_RESET=y. Every intermediate patch
  passed `make vmlinux modules` and `make M=tools/testing/cxl/`.
- Built and booted the series on an arm64 NVIDIA NVL72 system and
  successfully exercised CXL Reset through the PCI reset sysfs ABI.
- Exercised cxl_bus reset with CXL state restoration on all four GPUs in
  an NVL72 system; all four resets completed successfully.
- Earlier revision testing ran 100 iterations of cxl_reset.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260902072804.665639-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260804192958.1823952-1-smadhavan@nvidia.com/
[4] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
[5] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/

Srirangan Madhavan (12):
  cxl: Move HDM decoder programming helpers
  cxl: Make HDM commit helpers available to reset code
  cxl: Share HDM decoder decode logic
  cxl: Cache decoder settings on PCI devices
  cxl: Cache endpoint decoder settings during PCI enumeration
  cxl: Add CXL Device Reset helper
  cxl: Validate HDM ranges before CXL reset
  PCI/CXL: Reject CXL Reset on multifunction devices
  cxl: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset

 Documentation/ABI/testing/sysfs-bus-pci |   25 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/core.h                 |    8 +
 drivers/cxl/core/hdm.c                  |  301 +++----
 drivers/cxl/core/pci.c                  |   22 +-
 drivers/cxl/core/port.c                 |   19 +
 drivers/cxl/core/regs.c                 |    4 +
 drivers/cxl/core/resource.c             | 1400 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   41 -
 drivers/pci/bus.c                       |    2 +
 drivers/pci/pci.c                       |    8 +
 drivers/pci/probe.c                     |    2 +
 include/cxl/cxl.h                       |  120 +-
 include/linux/pci.h                     |    8 +-
 include/uapi/linux/pci_regs.h           |   14 +
 tools/testing/cxl/Kbuild                |    1 -
 17 files changed, 1769 insertions(+), 212 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0
