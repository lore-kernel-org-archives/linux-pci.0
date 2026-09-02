Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E2380FD4;
	Wed,  2 Sep 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334093; cv=fail; b=rloplakFIAmK+ohgxKXUtBd2JLHO2sKdSKRDr5TS4Hbs+fszjBxV+uYFRqt3caDfKgd3BbbyWy2dI+76rYuz1kFMb3w4CqTojTp9gcXlvmKzlop9Ikg1we9A/UP2Pig0D6mMLvIZ2t9r7fESEU6pz2dAX1q4j4rhI2xffhj4RsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334093; c=relaxed/simple;
	bh=jcnJOrfCpPe/3TAj2811NH9ZhLp6Uo/CgXkpOcdVsiI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BjPl3IzFrQSI3YYJzUhTH9N3z83E9D3OfcPRqPuIY4GiNGpmr7mlbPU5/THl0KwpM1mJWC6l7zRDJVKPrGiH5Xn8TWwt86tP4FI6u8yM4rA8KrPJPlT2GZ+EeIScJ+8UUN9zLHf+XNtyezvvvSwTDIwhRJ3paLRPvleZl6vmn/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryoeOFBy; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryoeOFBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfgThxqRa8N9MC/LfHrDP/SmYuWlOf5a2FjQbmKoh46CcAYOH+D1tKGXnHAitJHLt2WB1UQfSs9bl84eL+TRCpgV4+xRhSuyJ1s8214+vc5YBi5w5yOou+r+U+3PVJhCCnbQOF6VoxWfSTBlP8lNMBfsgvNgG6Q9T30b8FgBBvfGxbzC9YS6aYHS0leTpvPV6dKK5ADfGJVYHCUSpU0DJ3MbFjtWbQ3RTGlbOyS/XmYsXNjEH4LohzzRt1n3TGHIDhsLimkYqtQFRHrWpp+Js8AOidv+5klhIg09PTiwltNd+cpxXBTAbORxjHvf5N8DEHCk0YoygvWdr9kDdIP+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYacXFHOqcGTTtdBa46A8gkY9tCRRXk2gfWlXUO04Cw=;
 b=PhrTiN46EI2jBvUiEfj2zBMRiR7m+JlTwacTR0greISL5idoaWZG3+WY0SzpYzrk2JoRqEaNFXVduW+90c1KHEu5k3g/lGkM7ikw3ae73G4AsxPxqweqypUoWE/4sgqwMW9bqITZvPXvSJE+qe3elZCFHOcGmAiJhdEhFFGIP0+oTaNtpvERxSgrXqnzA7ZlMS1ZaZQ2mY0MKOWZcizE3saTgTdpWhmW6yaRKShrzZfpImC1XIjukQvoF0z9UKUGrYoPeVC+nk+VdkpmHPDA6d+nLpur9LtjezQuk90hze01AsYzu4j4N9mXTqmtk7GpryZhAAZ/RZRTcxSF6hOTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYacXFHOqcGTTtdBa46A8gkY9tCRRXk2gfWlXUO04Cw=;
 b=ryoeOFByLmae4UkFafUCemkc944qPbdpLYxUWx1i/YoFs5cZ/1jn80mYSzQOMv8hMd8urUk3uu5/HC8bwNX/CXkcnIgeEBSM9AaQm/zvag92rU4a85Wum+418gYlELrSXcMKcoFlLNnca2GKC40MhyPuKx1xOvFgMOnrO4bOdUyFYt2lAmGCLwwR9s0mq1HodhQb4PGz/UR9/LogU8KXu2lAUeGmdVby92MkvoSvleqBFLxY4dUW3h1FCw4VVbuuQteusgoPKGzinDb/X9A13lg8OerM6JwybGfyV+442iQ/KOLXqKSINeGdZ8lhKiMVefJuSSgMTtGZWOt/6Tlhew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:07 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:07 +0000
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 00/12] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Wed,  2 Sep 2026 07:27:52 +0000
Message-ID: <20260902072804.665639-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eef7460-1f7a-415a-d7a6-08df08c3bc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6RiQRF+kUHD1KHdRTco7m7pEqaqOAoV2QPqrADhiYLhnrJ4jT6TQ8P7UVzXLVXzIgWweb6xZJFN/C1c6C18zw3VZ5VA3/yfzWXDP3sYNW0o0HbVKj4S0vrRF768S8R4wHYBdo8RENLEI0oXDKoR7LhsR5vocoQnvalFiJuxiY79de4bx8/kwcIF7tSh3xnI1ZN8SbXt2m20DgW4M2hNqjEOHJAnF6QtfDosWq+KvGbloD5p7t5QKFCEOb2wPQrBVA6n6ySV1t0ZnyE580fUGKXT7aNVcHtOPB7dslC5V92bJb0fzI2LqThRp6CKjLOOEU6CZGgp/MbNBEzIPkfTeQExa3eYmcujza40NKnudg362MdKGsF9zdImdkCVsKIbKTs4zMFovhqjQlLT6Wz59nBxa8YeXHJqOlg2Im+2X2ByTGM9uSVUbEhOSruf63E2gT3h7InrEhXa3WyYtrdfr6pFT8WlNJcnOVTvdCl6xhu7WcWasJtx/4LakFxzlJbu2QzBEof/sCB0yMuRkoXTBqNERLGolHmU+ANGXtiDsuT3FzKlhC/GltWcFOH4wF2gsPKeYniHWaeTAc+Ptgr+z9BKWG/3H2grU77nCf+f2sOnD2a7tCNmnD5PNtQ2g5b5/eHEi/u+g2/xOq4M2kHk+oIKufyJ7lNixaBAak+LvTrnnd5rR4gRfKNXJtMLw+VPSnO/RsxAins1BpD0kMi+cIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCfwNrL5BAVEYEA73AyBTeagoOecQxf7VBrOPy/PdzMN5C/nk3N9ssx1YIa1?=
 =?us-ascii?Q?FZRB0nMrJb19wzPWr1Isc/wpdg3iT9Mk+sbfbBn0F+wsW/2pvKVPWzvya7LX?=
 =?us-ascii?Q?ywTsTM/eYkubkPdep78lSs43syPiFHVewTv2E9XgX25UZzkvwjNxcwr4FW+h?=
 =?us-ascii?Q?ckJBSh69sUarAhie+BgOgGPsUrRtOIUXlhG/tpzWYyarjlrvqq6dbiwVVJVL?=
 =?us-ascii?Q?d3IRVg50vU+sYWUc45YbvtCexbuesKEtspoI69+og/ZOyCISCt9qeKiFHhQV?=
 =?us-ascii?Q?fGGQjtK7GC3SaL4xLVJDC9Jje9hqCDDKmBsn3Cq9Zw66KD0C0+qE88gC3t+9?=
 =?us-ascii?Q?5wUeaaetxkBn/n0CxdNIv6a2Y5ZC8bl5cizpwurlbfwnFaXZBcPG1Lxq/s0m?=
 =?us-ascii?Q?9+Relq/jmQVf9iJJeLp0fYugQfASUYn7K+U+IlY9Ujv+JQP/bxYw6cnRLbZe?=
 =?us-ascii?Q?G8cyenm+u3KAmlo+rrE+Q3t6kJnBeL6IkJ5ccoDsTwjPG902QgR/cU7ABoq+?=
 =?us-ascii?Q?OKIC01dSPoyYhasTqPiT6QX9Wl9qERVKMk+aSM7eFHXkwxIoKH1CWK7UAQ0e?=
 =?us-ascii?Q?Zdzw6yft/q+Fmb2xg5lrTKCezrFOqmCEwNzpKJFCma0cUA1e8iURQ8t4crW+?=
 =?us-ascii?Q?/ZNBhSZuV24a+nsnXYzGeUBLjlZD6hquSsbolzEJaWxwlagymZQKL7ePZNJ1?=
 =?us-ascii?Q?CVfyfyvFZQzbGFA/LgFDBcx3tZF/q7WoUsvo1+ib5/tGKNLzgYq0PJ1t+aLR?=
 =?us-ascii?Q?8l+Oc1kvRQRSs+FYkQj168kpRlA9UmuIMDm+w+6tFEO3uvitwNVfTzyfF9Zm?=
 =?us-ascii?Q?A4QP4PRSJFOh/Y0LP0HfXSfpjoEpaujUVt9kE2+V/SQ8St09JFPys11IKIcu?=
 =?us-ascii?Q?ks29RYBN7IeIi/fjYfWPbl0NaP+Qz14kyS1hxrSBQZ+J98bGJDa59vEFn1fs?=
 =?us-ascii?Q?H5GEZKpEMF6V1f8LxfrkgSVjoenWNFiVobSQu07Izpt4ET+WEQCaHCd6FUiu?=
 =?us-ascii?Q?RYydssV+0KDg7oP6PSAXwHm7zhTO43hycGFWXK0lBVIRtb5hhVyTT9JXLbZf?=
 =?us-ascii?Q?Gid+aKTtZ2CtBJk8uiPcNEeNsYQTVawGu28T41dcLXnyAHVEMac6kmbj4Ix0?=
 =?us-ascii?Q?JLG3sX7Nz47rp0LNtbKZ9CM4+q22svWCYwUdxeMMFWib0KINwTMd3XO7Cdqc?=
 =?us-ascii?Q?48ORR2M41SIXwwJQon/9O1N48wyVbPIpNpgXnxusJZunc3l3uSM9WUdlxv3Z?=
 =?us-ascii?Q?fS8LVz7FUR36p2LzFDZNS4Xa2ZazhZdCcVWYP6K4J0qqVJBdKRAeGj5sA1xL?=
 =?us-ascii?Q?HuCmhRBpLuJSAXQo8o+EASDZcLP9NvEs/ui1RlaNyKe2YYS++ugmvMSk6dFf?=
 =?us-ascii?Q?fga69MYv3L01/ilO+Rv8EW9RP5hZa/iedI3g/vBvFfGmLLMmfixMAQMM7j5k?=
 =?us-ascii?Q?sUITWpvdSRrsZa9PzfMhEWvU5a+7s+2GEjTjFytWauXzEVGr8fxk+MFXySQd?=
 =?us-ascii?Q?d6OVt7o/musX2/AWiaotGZ9QoMZwDxb3B1Q5U4ZwFEpIGnMoNHvNzTjigl+1?=
 =?us-ascii?Q?eNuyl3h2C6leVyrfgGFM3H1FigFnP0pFIxbLbMqOdBMlL/E3z5hO8uWFjBcP?=
 =?us-ascii?Q?B8PMVVGGLF92U29DFHd9jIE7l8pwSylQCvVSpy1GjEwCaGaHnUACLqVYtQtx?=
 =?us-ascii?Q?sWowO5hchuuHvS8loIMhVQRUcDZ2QeNP20bIl69eNaAjNtaXe0frN60dpHVM?=
 =?us-ascii?Q?X6XSIJU84g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eef7460-1f7a-415a-d7a6-08df08c3bc05
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:07.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVHI/TRGta4U4c+RGi3HLzenXhdxU1SbcdkIFqUiIFXIbslEhTg8plsRMGWJsuSlaxQYZpxim6u17oJm1MNwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

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

CXL Reset is exposed conservatively. The target must be a
single-function CXL Type 2 device with CXL.cache and CXL.mem enabled,
and the kernel must have cached HDM state sufficient to validate affected
ranges and restore decoder programming. The reset preserves device
memory; it does not request CXL Reset Memory Clear.

Following Dan's v6 feedback, this uses the existing PCI reset_method
interface instead of adding a memdev-specific sysfs ABI.

v11 changes from v10 [2]:
- Rebase onto v7.3-rc1, which includes the CXL Type 2 enabling work, and
  use the merged public CXL PCI header.
- Rename the built-in support symbol to CONFIG_CXL_RESET and fix
  built-in/module linkage for CONFIG_CXL_BUS=m.
- Fix tools/testing/cxl linkage without compiling production helper
  objects twice in the mock cxl_core module.
- Simplify decoder snapshot handling and preserve endpoint DPA skip
  ownership under the existing DPA lock.
- Keep policy out of shared decoder parsing by accepting spec-legal
  zero-size decoder state, while skipping zero-size ranges during reset
  validation.
- Tighten early HDM cache setup, capability checks, BAR bounds, MSE
  enable/restore handling, and cache publication locking.
- Keep the conservative multifunction-device rejection requested in
  earlier review.
- Harden post-reset failure handling so MSE and BME remain disabled when
  HDM state cannot be safely restored.
- Serialize CXL bus-reset HDM restore against region updates and flush
  posted HDM writes before PCI_COMMAND can restore bus mastering.
- Address the remaining reviewability and naming feedback from v10.

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
- Snapshot endpoint HDM state during PCI enumeration.
- Cache the HDM register locator as BAR-relative metadata and preserve raw
  decoder state for reset restore.

Patch 6: cxl: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset, and wait for completion.

Patch 7: cxl: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges, reject busy ranges, and perform CPU
  cache invalidation when a runtime backend is available.

Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
- Conservatively reject CXL Reset where function scope cannot be assumed.

Patch 9: cxl: Restore CXL HDM state after PCI reset
- Restore cached global and per-decoder HDM state after reset while the
  target IOMMU reset block remains active.

Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset-method table ahead of FLR.

Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
- Document the new reset_method value and reset behavior.

Patch 12: PCI/CXL: Restore HDM state after CXL bus reset
- Restore cached CXL HDM decoder state after cxl_bus reset.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no runtime provider is available, the kernel emits a warning and
continues after the affected HDM ranges have been reserved.

Example:

    echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
    echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset

Testing:
- Built every intermediate patch, plus the v7.3-rc1 baseline, with
  CONFIG_CXL_BUS=m. All 12 patches passed a full kernel build and
  `make M=tools/testing/cxl/` independently.
- Built and booted the series on an arm64 NVIDIA NVL72 system and
  successfully exercised CXL Reset through the PCI reset sysfs ABI.
- Earlier revision testing ran 100 iterations of cxl_reset and exercised
  cxl_bus separately with HDM state restoration.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260804192958.1823952-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
[4] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
[5] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/

Srirangan Madhavan (12):
  cxl: Move HDM decoder programming helpers
  cxl: Make HDM commit helpers available to reset code
  cxl: Share HDM decoder decode logic
  cxl: Cache decoder settings on PCI devices
  cxl: Cache endpoint decoder settings during PCI enumeration
  cxl: Add CXL Device Reset helper
  cxl: Validate HDM ranges before CXL reset
  PCI/CXL: Reject CXL Reset on multifunction devices
  cxl: Restore CXL HDM state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method
  PCI/CXL: Restore HDM state after CXL bus reset

 Documentation/ABI/testing/sysfs-bus-pci |   15 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/core.h                 |    8 +
 drivers/cxl/core/hdm.c                  |  324 +++---
 drivers/cxl/core/pci.c                  |    7 +-
 drivers/cxl/core/port.c                 |   19 +
 drivers/cxl/core/regs.c                 |    4 +
 drivers/cxl/core/resource.c             | 1351 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   41 -
 drivers/pci/bus.c                       |    2 +
 drivers/pci/pci.c                       |    8 +
 drivers/pci/probe.c                     |    2 +
 include/cxl/cxl.h                       |  116 +-
 include/linux/pci.h                     |    8 +-
 include/uapi/linux/pci_regs.h           |   14 +
 tools/testing/cxl/Kbuild                |    1 -
 17 files changed, 1715 insertions(+), 211 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0
