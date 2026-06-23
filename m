Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AC274652;
	Tue, 23 Jun 2026 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185103; cv=fail; b=afL2X7e462FWvfTPHNGyYAHMGGu6tuqVn9ZzxML2YdC3x79dGTe6zKXnH0vPlM21kB1OIRXlSnYwn2SYgtRQJee9F9ufhxCUho9dSP62ofP1kLzhkUf2RdYRgEZXAJ9QSmegFBi9Ft8YlvNN/FSHocBqU3EuE0dayf6BLcJmC/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185103; c=relaxed/simple;
	bh=CaP2Jy9Wzw2pJbG5unfrQqvOEVAkiadlRqYe+bKPdcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P6y9ZXSR6ujvorGzGRIaICeInK7pD98hXPJrfoDC0XA79kv88+WRgoYLKTcr4LwpDceYGLfLZdQ2esFnMWoktVkjo6bVN9ke1jwRWZ/ESSdlu4gJPvh77bdlAHNlRJGDuMYuyNiuiimEiCK+TWu0gBrbYiKsQHvLvlvqMR5OmBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxujR1Zg; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxujR1Zg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZABghkWxPOUfBabCyO9iNqiV3lo97dehMQ/ZqtJhU8XeuxLHcWPsn2zTOKYo55lmLmYBBeMumkJVjywWGf9pW8P3xuia4/3nbUmdwnoM3t8J4QOqL89yGxZ+H+O+kmsg3FkLqddyU64PNQeJqOvmwiINhA5Dn1JGCRj1B42EoPqB2pI9D81WaojtV/I55jlrCegh23AbbfORHp43ytKmlDHpClr0yTCzME6Q/TRpxM5d5dTUw0H++WK6v3mnl7NqEwEsR2CyBhoVkmgcbabmBTTwv7v/IoCn+VOhgok6jKp727IlKXmq9R6j67EI9pNXrOEXke7sPBeJPudwb9zqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/xpQXECU3lO2YkrppVIIiwzN2BMFBUUtZynBeg4zTE=;
 b=ZjBUFb7N8LyJX0VAPVWcd1LI0rgSBXnUipCmwP8AZ7VIfpqtkLQ2aIbMN+ZnnjbeFrMRZ1DS8AGgO7ydKRkhKBf9CeKx5z/Xu6kdinGPW3D4B4tems/k4XUUtrUTiiHrssBMMvYpEtzlKAgDc4Ho9yBkSegTA2ZbOBX/uDDyVteBvLTJpra2Q0r0VYTTCGRRDxiWCA6gOdTwpaoyur1i79Qs1EMWFp4HIaX1zEiMKf1DMh6BHxTQP7Bn/TFt+oCZZTpOi+CsbE6aV/4iSxC5IdwyooDcYEkxucqIAHDGRv6vGDf9/HxP357RvtorcifKl2Xv52TpF+GML22PB2xoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/xpQXECU3lO2YkrppVIIiwzN2BMFBUUtZynBeg4zTE=;
 b=jxujR1ZgrpUZyH6Gb8e/i55CIQtm9PBtnWFUiP196qHEBXoXCQXmWd/D25MZb/3/ZtK7Q+68nQ2H9/Vikyee5YuOosbxJyf06dyBFzB+IYg8ZCuJOQ2dtb7DSVkyIU/Ct5IpjwHTtAODsVUQIYRoAsIrR8Ig3kj7GmXVDzN/1HRZkwb+BEmTXhNDA0ACkR64u8j3BN/ui1ZmWLkRDiUoT0M9fdfsRA8VaArcK893odlAUbNXvShuLBoKXo1qzbBrTksnAkKzqkFJ77iYIyxwlj2FrFv45wpqq2YBMpWJWH7yvHvA8qPRNP5BYSHeh2A5aPzE9N5RD9Fl5gMJLf+Zvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:24:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:24:57 +0000
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
Subject: [PATCH v7 00/11] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Tue, 23 Jun 2026 03:24:42 +0000
Message-ID: <20260623032453.3404772-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fae22d1-5886-40bc-f531-08ded0d7002e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|3023799007|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	aNUDJeNJdOEIq6pvZkgNTuWbgEDIic1wwUqHXvoyUZzR/qA37CLaqnWAAXuTqsJm3HoaAwc5wRwK7M++ZcT+lbUZfXa+t+YnwYbhIFfoNEtTrMyIZwrZ36KBvyw9rxVNcVNWKztZKInkNDiuJA+YotDPfjdArSiyyFJseQmowGgoWp4eKt9SjO5LjBS1/AJ2WerRyOgC15zDCqxwRd2Y7lYm9o6DgC6+djTB4KaYo3rsSOcQGCFCarSTIXrUp+HcYneT3+0w3i4mP/DCL33J/91vY3YVFZmNu2pDWdPBBmH/GDRFSFlsF3tbB8tz/JlB6AGaxABVRUCtCQcDe7xPuyv+b3VsNovRu5J+ZxFCe4p/Q+D8DqIzIKA2nr4lmSjc0KAYDwbxbyAvAWCVGTYeT4Mp7ppmN9IamnKQ3JJ4ETVsvm0J+pvUZZXLR4rGASg5hr3piDMwIo0H46aekMLM5rZkUopwzB1wtoV58B2Dh+TWBu7IGiWmhGOm3N5IF0RPj1eCoDkIaBCs8zHDEthopdgD9aMtlpdaXyZY4KT+FkE0xPrpV05guVdDkx0vz8YqofLKWPjBHtcjRFX/Y+P0A9jHt5CxG2RwIYkgZtjrFr/AmctSQBvlP91Dd6zw6RKbO9K5/xiokrad9vB/rca2eR9bf7B+EarX9voH+l9gBH7IdHhq42D8XEa7HKEnLDfwdgfOGdOeIBaVAvliGkmAqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(3023799007)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTQeQQLiAXPf13ylIiw41olTaUW0fRceCg13Es1AfSfx+Q5187u4sdiDNrJ0?=
 =?us-ascii?Q?nTnnO6agslfHQZsi01k9MnEcMaK097FbKRNfYr2N2BUvAMUpJUyQzJzQXoOY?=
 =?us-ascii?Q?Fm1YbTTnUbpTo2gpT+78itnoMRJaQkW4cxVwx7H3DULUdSyORdz24SYExkG1?=
 =?us-ascii?Q?kKLp8C5Kdy4d5/Nfn9iBmxQTzYaiDZd5a2rv4hLcgTxFwfRkllboysGv0rbW?=
 =?us-ascii?Q?Nenn8Xv3lyyaaIDW3WiHPNRsXrpVIWAl11RXYfCxC467rry1wACuvhvN1jQm?=
 =?us-ascii?Q?c4NxLV1u8QkLE0hTyOZBV+f+uCV4oXC/8+nY6u1CAAA/pSNpTvy0aQRnau80?=
 =?us-ascii?Q?velAczvtALfpYMgelhxeviGMBVn/BpaxI6M2FFXgZ5XTat46bYnpbI5NrlWn?=
 =?us-ascii?Q?pQ4FDzL5ayBBNIWaErg7Mjv/mayjKuO78etaGjcegetUaUeVzTtwLNASls9P?=
 =?us-ascii?Q?QnRXIiecLCgKlvWjzAqylf5fqtfSbNT8ccEh2vwlN+uhHxyJhu888Qgv9r05?=
 =?us-ascii?Q?KWb9SRvIUj6nyuE5TUVELo2AOJU6tnr09CbDITV1fANsKshaeXBmnZhMumR5?=
 =?us-ascii?Q?1olhxSwIJyXayN9J5DBHVnh+ML73q9Xvxzqb2FP7yEwZxoOjhsdRNHLfQ0qR?=
 =?us-ascii?Q?kVdvFR+zu9SoI8SY3S5M6AbqA9XHnDMNiR4/e/puctKhwo57QaMzf80DWJvV?=
 =?us-ascii?Q?cuTnSpKLOVWRt+Gp+m26DFlYMlBU0w7dwGgYoTskeHLIguD83um/atdJBBko?=
 =?us-ascii?Q?lf87iRqxdIHxeiqlUSbEyIm+CsNcmN04GrAaAt/6WRXHAKWTquOr2Jax/gi9?=
 =?us-ascii?Q?yhNe5FzlJQkTKEQ4jOhHTfGE/cJoprlqxlxIkaY/3uOTWzdWRigEfwIEyt4G?=
 =?us-ascii?Q?w0jDMjM8pJpjhHosBn75iy2uGd2w5QKxZ9x0IW8dtqOfxAq1LH/gI9bzvODB?=
 =?us-ascii?Q?UX/3Mct0z0+CJ04BUabirliPVr2vXh5pDF3IOzuUtPKhljZ1XuQTklYQqViQ?=
 =?us-ascii?Q?KMDjxNiUXeRrkRtUITFMb+FM0jcmvbd9HDDsqRSFKjT52KPh/GmhZ969RBc1?=
 =?us-ascii?Q?NQCrkAl/hjpOOV3gzB4QoU5rUOCLx8VzhKwPgYDtd/9Ng86C3QESJ4uMFpL/?=
 =?us-ascii?Q?N5IjxCYwyqqtwOfqsIIyRMA01RoEsR0YngHxXcAlujAwqDbSnE+juBhR2aoz?=
 =?us-ascii?Q?jBFh7Cs5T7W3m3gyQ9AmIq/XwQ48gTpGDEbe4HWJQjouzL1fghWQe/VMOZA+?=
 =?us-ascii?Q?wJByxb1suQ+a8Yw3yhF8ohFMoOoF4dTIKJGDdw2N7fx1/0pT47zPJp/HiOWV?=
 =?us-ascii?Q?aYJ+IXE0iu2VOlfaChNUAxlq5U9ZkDvDLHaV4nAOxNxPhazjH75o9fzcCUXT?=
 =?us-ascii?Q?tZQq8OhRns5BMG6lDojYWcI70C+oGhyH5D/NvSx06WtjZuWkVjQWWWlol8Jl?=
 =?us-ascii?Q?JBhdJJcRMGD2modEdl34nNEg9qJBxohU2UWKbfwEC2TNq8iyGulQ7dSRPWXf?=
 =?us-ascii?Q?1//Q2XDQcllbpCiI8stc5qcSuBEGrpbDHci9FlLm+YK2CpJ9we87G3JOp40t?=
 =?us-ascii?Q?BUJnD7gVhC3chv/aD0aZ8C3FfUAMkxHX2oIFhvca/uPv4cWQSpusUeOalEHD?=
 =?us-ascii?Q?am6dyCqZQXoG4tUz6UV5qFYqAfxnmIkqZp6FyjI5kJTTNYyyooXU92JDndlI?=
 =?us-ascii?Q?h1fFHrNMgHFUJMTQyEN01g7J+jaN5PsrTsOFDTzUWZwOxnGKD0oLUmGsdnGq?=
 =?us-ascii?Q?9/3+JevPMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae22d1-5886-40bc-f531-08ded0d7002e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:24:57.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaj332dhfg8u7uqLUIyF09DbemfJ0ijiGLbJBxZFSxGTsK8Ijli+nIhq2JSq+ixcDApbwU3vAVDunEz1BNiw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

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

v7 changes from v6 [2]:
- Move the ABI from a CXL memdev attribute to PCI reset_method.
- Drop the memdev dependency from reset entry; advertise cxl_reset for
  Type 2 functions that report CXL Reset support in the CXL Device DVSEC.
- Incorporate Dan's HDM reset refactor: shared decoder settings,
  pci_dev->hdm cached state, and built-in CONFIG_CXL_HDM helpers.
- Cache endpoint HDM settings during PCI enumeration when MMIO decoding
  is already enabled, and let CXL core refresh the same cache later.
- Reduce the earlier PCI/CXL save/restore series [3] to the HDM state
  cache and restore infrastructure needed by this reset flow.
- Use cached HDM ranges to reject reset while affected ranges are busy
  and to invalidate CPU caches before reset.
- Discover the CXL reset scope with the Non-CXL Function Map and CXL
  cache/mem capability bits.
- Quiesce affected sibling functions with PCI save/disable and IOMMU
  reset prepare/done before executing reset.
- Restore cached HDM decoder state after reset before completing PCI
  reset recovery.
- Keep CXL Reset Memory Clear disabled.

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

Patch 3: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
- Snapshot endpoint HDM state during PCI capability initialization when
  memory decoding is already enabled.
- Reuse the same cache when CXL core later enumerates the device.

Patch 4: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
- Export PCI reset lifecycle helpers for CXL reset orchestration.

Patch 5: PCI/CXL: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset, and wait for completion.

Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges.
- Reject reset if affected ranges are busy and invalidate CPU caches.

Patch 7: PCI/CXL: Discover the CXL reset scope
- Discover same-scope CXL functions with the Non-CXL Function Map and
  CXL cache/mem capability bits.

Patch 8: PCI/CXL: Coordinate sibling functions for CXL reset
- Lock, save, disable, and IOMMU-block affected sibling functions.
- Include mem-capable siblings in HDM range validation and cache flush.

Patch 9: cxl/pci: Restore CXL HDM state after PCI reset
- Restore cached global and per-decoder HDM state after reset.
- Keep IOMMU reset blocks active until HDM restore completes.

Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
  CXL devices.

Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
- Document the new reset_method value and reset behavior.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no provider is available, reset fails before hardware reset is
requested.

Example:

    echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
    echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset

Basic CXL DVSEC reset testing was done on a CXL Type 2 device. The reset
sequence completed successfully and ResetComplete was observed.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260528083154.137979-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/

Srirangan Madhavan (11):
  cxl/hdm: Split decoder programming into a reusable helper
  cxl/hdm: Cache decoder settings on PCI devices
  cxl/hdm: Cache endpoint decoder settings during PCI enumeration
  PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
  PCI/CXL: Add CXL Device Reset helper
  PCI/CXL: Validate HDM ranges before CXL reset
  PCI/CXL: Discover the CXL reset scope
  PCI/CXL: Coordinate sibling functions for CXL reset
  cxl/pci: Restore CXL HDM state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method

 Documentation/ABI/testing/sysfs-bus-pci |   14 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/hdm.c                  |  234 ++---
 drivers/cxl/core/region.c               |    6 +-
 drivers/cxl/core/reset.c                | 1276 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   43 -
 drivers/pci/pci.c                       |   25 +-
 drivers/pci/probe.c                     |    2 +
 include/cxl/cxl.h                       |   85 +-
 include/linux/pci.h                     |   10 +-
 include/uapi/linux/pci_regs.h           |   15 +
 tools/testing/cxl/test/cxl.c            |   10 +-
 13 files changed, 1554 insertions(+), 172 deletions(-)
 create mode 100644 drivers/cxl/core/reset.c

base-commit: 72afdd8181219f459142e571999b3b44ef7b85fb
-- 
2.43.0
