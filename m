Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB34C33FD;
	Thu,  1 Oct 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846560; cv=fail; b=toUHsHhicnsghFCbqQl9es8TTClkzEKfb30jM0sSOupnyiJTzjyDZkvd6z1tNj4NytRHVs+DoYbVrWGii97mb8ze4fCfbVDq6TK/xrjut+3GqQUh9B9IMLF4cLLN6z1v5fojDQnwR2XPLiavFnPJwPFoVtDELXFO3Ga96avCW+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846560; c=relaxed/simple;
	bh=dcVvxVKBotABaw/kJL/ibqDGvW4yACuZ2FIh6IPVwrU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U/ZkJKpi6mld59wnKHOa7oOW19FQL4ErDyB/9rEZytFJ7YDreX5H/jl8Adia22kQQE2IhZdkzxP0BLBe7Vp/4hPl0ZCCyqEJW5zoEek8kZ0reUaDwN0L4wELjK8ePqcUf/qfs2v+SxCcDjLzYtFrmF26Sssg0uChLm+opXJ/qyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WdpMix7L; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WdpMix7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRpY7izsh5n4ecY5W23mr0b0d61gjf4Y0Fy6f7tuQ1DJ5OE5d6KAfUgsP746TnUY/XQEIUvmF7HwUrkkBDmxIz57RjtKhfR8Cpjn113hfkFFlrc3VEm0SrDWAvGQ7j+gb+WeR/smF5FGK+Y4C5GYTlh5durYVEQwKH1NJxOwUuxTvTivNsv+3gw2IZ8GSdwXXV5hb/DaX5ctHN83AfXhxKRPTYfk3C3KrH/LqtKGWCxzAkzk+oxf0IvZKqX89+UlNDSpVT1+YDtVqtd98ijJMd8Y/6uG4HkVpik+M9oQjCMmGcnCIZcVxsFYataxTjitlACGknd+YcojeA61znLvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvQjL2y7DhGKZtMlS/nSbcC7snOd/XAIs0BH5LfSXPo=;
 b=P1GopnZ7vviA5kqyLbV+eZKP4VOnrXyLuaHqzyn35WIEWv7vqdU+9qVwm1EV2CAliyLAixBlWC3XyJQSLPP/YUPw90CAIBfQ06jm03jeug9xwBCBQ740nzO4wpnwT0zgbBLfKzj4T0Ne7NmcI0UfsYtLbCiktmQrwB5aRVi94GL/CawE7KmD0vQo5FJhav7ecqvBa89l60w9XlVOJxWdUoH0EKIzH999wsiVFOwinisyFhR0jJXM3E2UPsJfcmzbeeFp17sHEAwoO3coJ2AMiQQYibtedKgtinzbEnwocoKj7QDm46ECbnl+csqg92nqf6+Yfu2wELC3PRqy3FupRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvQjL2y7DhGKZtMlS/nSbcC7snOd/XAIs0BH5LfSXPo=;
 b=WdpMix7LUQDTIWYCeC0OD/tRe8efv9kgyhTiyNUetqS9a/1EpVMTuY82H5H59/5vrTFdHFmBnGkXSO2+dn26k3tP3ESTBAIEvjlgF5yRRcoLn3l2y9EneudBTnXIcIqykz0a1zyJLM/ZtMCAKWc+YUL22waXWugarns1vcUZa142e1yZ4DPgftE8FGrc7N+XEI47Cfrs2TywYPXAwANi4T+pBz72Owx8fXKmTDs1PexulW1n/JmaKw8BP3oXDnxKpr78VoIOnfJgVw6+Dc38TnKiPC4XqVSd9rS+M+IqDu0eGpAstqHOd10Vd7spPePiKUTHusmNMSrrC1CNEdKw3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:31 +0000
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
Subject: [PATCH v14 00/16] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Thu,  1 Oct 2026 09:22:11 +0000
Message-ID: <20261001092227.3004747-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: ae54fce1-3dda-46af-c6dd-08df1f9d84ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|3023799007|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	79ovdel44eh3ZIVkfMfhiH7znZSl5y24T4ae0vN0tpMRfn9mh4pGG+Q3PYPf+R0V4NB6wdGwNFjmf4Kp1VjkuSD2AcreyxzWs8ElSlZjMJ/EmWT6h8lMiCom6CIKWzrIZKSChdoLfetTrpVpT4rQ3EyGOfsoBnoffhsaJeEnHn2Us26/svpFiPzqY5fUU9RHX3DExa4BdeT2micqp9/1Ma08ME05OaHAJV80DFYowIUKNFezPsCZ44S9Z6CwAuMrp9bpYBTe1yeoW1IcZwx+0B5cuXA5yxcSLAx8a4ZESULyRqHA1xTG1vDAOXqhXoyyXrdt6YV4ZZlhxm84vLQZZ7DCL0DM/aQEKXH0AlSYlFKmd/eaeUj0UvB8x+8CUK2/qMB1inabOTPrhUuYaAGW/infNgnEZwEKUt281SVJsrmDAFifrr3OhqMA/bSx6gWWjY5xw7yGg4wjbCRDF+BTPV2f9Lf7yVpNL+5ZZiA5YzXYNVATqr4pDTzPbH8LbtJ2MGnZX7qch38lBFldaelctYirafoeXpTe6YlyvxWbHqX6Gs9oeBQaaZ9QTtYmKDshUgHdN8xTgyEd+ZVTrUSxYq0DCW2s1QwAf5rRgd30wcHLxt/gEZftjrPEVQTyMx7sjp1ekB/Gu46wae2bQXk3mOUhpHRxRmWaIsO9AaFnVvPrjTWMIjC6mEAF2A9YxA+LBYNQmp4+RQD61G0uh7e90A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(3023799007)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQf8DynDiWR2OkI5vNzvLpk1RgZuAO8KXPvLkm5xPWDz5RnBLESUjnA+VZH5?=
 =?us-ascii?Q?ys3AbhRYRZy6XZBwMPDluqK0ED/z0l3vWc+cy1VrW5XFjm5bIBeqYpZHe9Ci?=
 =?us-ascii?Q?3IOidoJMWRDWPEWH8MwINGRs2vzyIzBMrIbFlUlz50UFb0XImZA3RWoAGb4K?=
 =?us-ascii?Q?ZvKmV4z00UNz2uQNEsvyqGFapNHzLNhmEBBFsFFz6DSPdANRSs2WJEJxfrcN?=
 =?us-ascii?Q?V5ohRq3V+0x3uTqM1b3H0DWK9aMgul32f+m9S7Qd26V8so/7ZhTDZbgVMXK8?=
 =?us-ascii?Q?U8cEHR9uNHOIUyYOdmavG6bPv5XTm2+B8UB6Boo5h0teVSuAYmv8qH79jmz7?=
 =?us-ascii?Q?+xe0QQS8bv2NOOlAcXCRfAMXQtU488Z5GRU2kL0eV9zNLIosL0CuXgk2BKoe?=
 =?us-ascii?Q?JoUKuFXY+AWX2RVZr9s7guK7j9hwyPuCC+OoRiy/pO9vOq/9i7W6w20BtjKt?=
 =?us-ascii?Q?DyjZyqB/OxdIxY0WCLJMKPryP6KWgzsN1dgaBQFOsKAxUvA+j5UId+7yMNc1?=
 =?us-ascii?Q?pdK8ZFkUdO8NnDrhacfXnmAtlYdxxppsZQgxI1ij/nuN4eZMpQk8OkS0IwYX?=
 =?us-ascii?Q?24eCcTQRbKioS0SEfzbNjisWDFzP6V9c0EtDo+xmKLbivwH+1NNBv+zNC7cn?=
 =?us-ascii?Q?R5JUF+fITGCtoEXgP3tVQ0Oc7o3pmJPGc2nQsLO/xnZMT6NbkUj4E8+pmW8h?=
 =?us-ascii?Q?gzV+6jW/2aA0NdQJgruaDR+lNQdAwj7DzUDpZYJb329hgCOjqdSClFns2zJ+?=
 =?us-ascii?Q?7HUtJFhlmIrB/UR6kGBGR3aalLr1uCzk78oqdybjOPVG1fZHe+4hiZYSlPyk?=
 =?us-ascii?Q?/MpUOEVIeXq/T0j3kWAZAkE8r1URrc0KnwofBiJaDeZRCLbd7t8pPmHsGTjA?=
 =?us-ascii?Q?bQ9IqA/eU3r4o7BU8l7HEad6f1Ve+VMV7klCwbg9NSeV583AleThr5UXryiV?=
 =?us-ascii?Q?Udr2Tjjxle2ilwweUrDVw3nFIR2OYdiGoNKYwdsXyp+gpBVPUUwKDdUjVxQl?=
 =?us-ascii?Q?GdG6pdkmqRL7qYvPn5kAqM11ge423HgpKINeuaoZ/suxwRfCAFH6JzLANzBx?=
 =?us-ascii?Q?7MKDUe7JNeUyRjtvADCkmofBPPphvzyJqooJQc22svTtWMjoFm2zNqFN4N8S?=
 =?us-ascii?Q?uJSyCuLE4II94Cb9vS/AlKTRL4BODPeQszbahWrFheHn1rRxurvxZ3znNKao?=
 =?us-ascii?Q?Wj3HTz4FqKVTkH2q2nrK7wHN01KwWFTP+RbqWZ7r0+TWAxBI8F7mATvrhTxo?=
 =?us-ascii?Q?t4ln7nHO5by73bSJGI43LhwK7gBfEv5uNx/UbsaIytlPo+1oWqHUYx0AFN6e?=
 =?us-ascii?Q?y7kkEC958zMp62yyNilL3dJpM2y81sAvXG/VyQ4RzcI4CpaI5h7dA7KIYnTb?=
 =?us-ascii?Q?PY9+EXMtDSLRajW+XZ4fxJuQDUY5IRKBOKOanGLXo3jPwdYKKbu9h7WmZihz?=
 =?us-ascii?Q?1+vHVVk9vljX0GKdrh32cP5yjJvbKHMMSiiq1FLZez2JM89HGZFkamJv1tDz?=
 =?us-ascii?Q?0bFsL4XRWcxmZdWGjfsBMGj8hIdAhDyT+bmOR/rX2+eOAIh2paWg62SiRKhi?=
 =?us-ascii?Q?yq2UmjWKJZCEYCQ6u7hmqgF1piMEHBnIxES2wHonHSLK0J41fmkwdpoQ9ZYe?=
 =?us-ascii?Q?PnACIE+p4ScSLz3CXEr4uyrUdpyezpp5S2FqEzwFnEGbds6PZzU9fCN4wpGX?=
 =?us-ascii?Q?D2I/dGNJbP38zOi2SFeiVhSCoaKtoWM/2mgT403iiwwS08Ef+MwLAUqeljLC?=
 =?us-ascii?Q?4tdjdgmt5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54fce1-3dda-46af-c6dd-08df1f9d84ec
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:31.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2P+2XwYZ2MDfQlCrQiobPGFAZmE+rbE3JdZ4ihtj4+v7mN/Q02ZZg7aDzEUMv0nkviPfwDzpocFOEh9600+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

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
The kernel must also have cached HDM state sufficient to validate
affected ranges and restore decoder programming.

For reset through the sysfs reset attribute, the generic PCI path calls
the driver's reset_prepare() callback when provided and disables PCI I/O,
memory decoding, and bus mastering. The CXL reset path then temporarily
reserves each affected HDM range exclusively for the duration of the
reset, synchronizes CPU and device caches, and blocks IOMMU translations
where applicable. It restores HDM decoder state and the CXL Device DVSEC
Control register before PCI operation resumes. The path does not offline
memory or revoke mappings; it relies on CXL.mem users retaining
conflicting iomem resources while access remains active.

Following Dan's v6 feedback, this uses the existing PCI reset_method
interface instead of adding a memdev-specific sysfs ABI.

v14 changes from v13 [2]:
- Rework the decoder preparation into smaller reviewable patches. Move
  shared declarations first, embed the programming fields in a standalone
  configuration structure, introduce reusable settings, and then move the
  resulting helpers to built-in resource code.
- Simplify the referenced upstream PCI-device lookup and document the
  changed decoder field path.
- Add a separate check for overflowing HDM decoder ranges.
- Keep the early PCI HDM cache synchronized as decoders are enumerated,
  committed, or reset, and keep cache initialization failures from
  blocking PCI enumeration.
- Build and export only the helpers needed when CXL_BUS is modular, and
  preserve the tools/testing/cxl module build.
- Split the reset sequence into cache handling, Memory Clear, completion
  polling, range synchronization, and state restoration steps. Preserve
  the original cache-disable policy across reset.
- Keep range reservations, IOMMU exclusion, and the post-restore CPU-cache
  invalidation in the reset critical section.
- Preserve the pre-reset PCI snapshot on failures before PCI state has
  been restored, so the outer PCI restore cannot replay post-reset state.
- Carry Reviewed-by tags for patches unchanged after review.

Patch overview:

Patch 1 removes the stale interleave-limit comment in isolation.

Patch 2 factors the referenced upstream PCI-device lookup out of the
existing CDAT path before the HDM cache becomes its second user.

Patch 3 moves shared decoder declarations to include/cxl/.

Patch 4 embeds decoder programming fields in a standalone configuration
structure.

Patch 5 introduces reusable decoder settings and separates programming
from commit completion polling.

Patch 6 moves the HDM programming helpers to built-in resource code for
use when cxl_core is modular.

Patch 7 shares HDM register unpacking between normal CXL enumeration and
early PCI discovery.

Patch 8 rejects HDM ranges that overflow the address space.

Patch 9 refreshes cached PCI HDM settings as decoder state changes.

Patch 10 caches endpoint HDM and DVSEC state during PCI enumeration using
direct BAR-relative Register Locator metadata.

Patch 11 implements the CXL Device Reset sequence and its Control2
cleanup and timeout handling.

Patch 12 reserves active HDM ranges and performs mandatory pre-reset and
post-restore CPU-cache invalidation.

Patch 13 rejects reset where function scope is unsafe, including
multifunction devices and PFs with enabled VFs.

Patch 14 restores cached global and per-decoder HDM state, decoder locks,
and the complete CXL Device DVSEC Control register with fail-closed error
handling.

Patch 15 exposes cxl_reset through the PCI reset-method table ahead of
FLR.

Patch 16 restores cached CXL state after cxl_bus reset while its existing
IOMMU exclusion remains active.

The CXL.cache/CXL.mem eligibility requirements remain intentionally
unchanged. Whether CXL.mem-only devices should use this reset method is
left for follow-up discussion rather than expanding this series.

Testing:
- Built the base and every patch incrementally with `W=1 vmlinux modules`
  on the for-7.4/cxl-zero-size-decoder topic tip.
- Built the tools/testing/cxl modules at every step with
  CONFIG_CXL_REGION_INVALIDATION_TEST enabled for the build check.
- The reset and cxl_bus restoration paths from the previous revision were
  boot-tested on arm64 hardware.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260922083924.2451158-1-smadhavan@nvidia.com/

Srirangan Madhavan (16):
  cxl: Drop stale decoder interleave limit comment
  cxl: Share CXL port upstream PCI device lookup
  cxl: Move decoder declarations to shared header
  cxl: Embed decoder configuration in a standalone structure
  cxl: Introduce reusable HDM decoder settings
  cxl: Move HDM decoder helpers to built-in resource code
  cxl: Share HDM decoder register unpacking
  cxl: Reject overflowing HDM decoder ranges
  cxl: Refresh cached PCI HDM decoder settings
  cxl: Cache endpoint HDM state during PCI enumeration
  cxl: Add CXL Device Reset sequencing
  cxl: Validate and synchronize HDM ranges around reset
  PCI/CXL: Reject reset with unsafe function scope
  cxl: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset

 drivers/cxl/Kconfig           |    4 +
 drivers/cxl/acpi.c            |   26 +-
 drivers/cxl/core/Makefile     |    2 +-
 drivers/cxl/core/atl.c        |    4 +-
 drivers/cxl/core/core.h       |    8 +
 drivers/cxl/core/hdm.c        |  301 ++++----
 drivers/cxl/core/pci.c        |   42 +-
 drivers/cxl/core/port.c       |   68 +-
 drivers/cxl/core/region.c     |  102 +--
 drivers/cxl/core/regs.c       |    9 +
 drivers/cxl/core/resource.c   | 1320 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h             |   43 +-
 drivers/cxl/pci.c             |    2 +-
 drivers/cxl/port.c            |    4 +-
 drivers/pci/bus.c             |    2 +
 drivers/pci/pci.c             |   13 +
 drivers/pci/probe.c           |    2 +
 include/cxl/cxl.h             |  126 +++-
 include/linux/pci.h           |    8 +-
 include/uapi/linux/pci_regs.h |   14 +
 tools/testing/cxl/Kbuild      |    1 -
 tools/testing/cxl/test/cxl.c  |  158 ++--
 22 files changed, 1853 insertions(+), 406 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c


base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0
