Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43643BB40;
	Sun, 11 Oct 2026 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684874; cv=fail; b=fkAmrTRB0PWeequvgVG/T7/MnBNlYfJXahulSJI1Fw7CvGhNGNAeD+wtVm6LA3vHyvAxl94RnC8Laya593NuirclRZ+Zk0/8v/GWyXSGmmpStPrGm5WXVWMFKuQdII3YJRgvynrW1O88C+I/z5YePstP1vJY3UdGyKK6D7R+mpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684874; c=relaxed/simple;
	bh=nlS+aGcu+CCuVpLgA/4T0DN2dmEM5o8hpDPfBFFPulU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JQdQWuq7ZwHNmZnvxYJLc+7SkYHSrQGk2tz5/yW6c5OSlJP2MEYZkNRGkR+UDBDW99fWJU90GEO+9X7GT5wDqQMRCa+IRHS6qPGr1EJOdUjw9xTCmeEIoFRw3LBnd7IaAs0KVWuvqExRO39q4LPoOCdmUHZ8M9dAOBOIj2QYuds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UkG95TSu; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkG95TSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApLNCKRbcIrTeBPymRkl28vf+jx7vnixSjKZkJTSwSPVg+ZuXBzYz/ADO9XCSZ25GkgJ37jEIaZJA8w3MVa25XuTO5h3yNe0G8t1xvh+FSJHwzYzrU41pfmjt3SVyTOKWT/P5VULbosf4wGdk5umY2jvqHE15GEkCNPZg9nT49lipZGh5k6jLaCIaOAxFroMxAgAcI+oacJSYu4A26PBowdwC+WnQhdODN8Xk3N83e/vje/dDS0KzQzeguIB7sJZ5Y2XoKPdBnM5eorsjPliJiJcA4T2adbV/E+ThFBDmNjxe9HwDMrJxMpIinFy/g4GYyiFY5uJHDb9ANYeubDN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPIJ0wcd7Df7izEwpnWbUoBhGWD0ba7X5QSYCcvupyo=;
 b=uUvqc/0qUUk6VVy5OquaJNEtp2cDQb66wmI+LfEXRmAfVCexHqvKwktC2O1doK1X7BObp9CfI0KnwqWSWqbBczcnZ7r19Yfk34PqIWWrhlazohtrC3jJN8dWjQdQbOvPSohvt0khohJXVERfHbkVE7F/Me2+UaAlbUpBwzDt3vBwgHbesVdOXMifZm0XF3hGbsRXGeqZ4N75dyP4EOZK7hMP4LmKEzfq/mM83yQNa+STi+WcSvuIwtknsI6iFRlACjO4Q+CpsKNXyrwO0ilXiwda+JbWSgxpxLIv8VLBts0kVfPfDa9+kqUH7+59HheAcPxfyuf3Kz09zoCaWILsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPIJ0wcd7Df7izEwpnWbUoBhGWD0ba7X5QSYCcvupyo=;
 b=UkG95TSu81gFDQGfSJfWqE/sOtuI0WXPRxvdZ0QLxfIyjXGtsFW+gv/7WOXmTH8NBuKfWY76dPoxFXzcv3Y4oTUVF+gry43StlpHWJd0i5B6G4XN5EXgL5XZmrCWVcfriWakRjAwwT3LV+jBv76KR0t+6RrTI+avV4G2eW6d2l8VajS8YgbKU1VSTuHC3XjRHzbwwNQOau8AUkuTRBTL/f+UUdIOYcxO/kbfJxaP9D7P0wMRavSDxOnO8/Yb4JbuEllWdM6/QA+tn/L1HqUKlB6gbboFtQIW1EI488oxdMklABIc7ZWWuC3QPxGCnN/ue1Rd6u/TSQJRGREPXsOwtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:29 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:29 +0000
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
Subject: [PATCH v15 00/16] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Sun, 11 Oct 2026 02:14:06 +0000
Message-ID: <20261011021422.3428136-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f27611-3600-49fa-76cd-08df273d6164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|261009223027099003|921020|11063799006|5023799004|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Yt+6W7y7jlCKkFujNNIuSVyboby3KICle3q8CNQ2fIZt3VPjReUeD9vgCihKspog9e8asxJMYpkcakF3aXEt0BrUAs9wrBwkd/1puSJ3dyGmtlUsOvSZFoR2srzlYi3tEFyCqgBq7nR92IHgYUsW5uMuFJdNpMHqX++tFHjGEP6mr0hB+lwD8ivowiPlcvFmml5VOryMClVrcZmBZHn0o4fGuErbexoyBazj5Q/ZAXz9H6nUqXtpKSmJ52djdbz1gQvgqwWd4ZZKUkuwsyPOy/XcdV5qSAXponVOJWCQpOaIGFyS6abQCtU2e5jIQdJ7HL3skmk4LtTz/HdZKpaUTuym3oniTJA4AIqo7/qoGK9v+xSZj9E6RQPHJO05iLtfolwBJCZYGczFEEpYl+tByD6ab0DGpHGHNKm0zX7zQK6kCRyzTZfdCiM4U9aWsH1CgGWOd1xe8ekHHbjow+LMDBHUZtO3TGpm+Xhg1DxZsY47OxlsGpNRQ56aaYfSIy6tl8Aux98mCs6AB30YVB9dF9Dl5FmCmsAlsP1JjDjk448vLKYJj6aIJ5+dOyN2Ey2bSKpKHU2AV6B5EtVHpmAx5+TqumI80aYTCkEALeTEyxwPDoSD9wgCPRDzneqhfySWwh/vicSKQoVZBKRUXvJuKDU4atdsO5WYqEKJesMtnT744SCs3lfqWaKm9bk0oWgyAxW1j5kIOQBlf+t69Y8uzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(5023799004)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yb0CB+8MKwAlCcASiUn3eVn6fpZj2pFWi9v2eBZ/w3K8IWNgA26ggQwsme5E?=
 =?us-ascii?Q?XQSR9fJJfde9KYP1JVPCDz66Fqqi0o+XQD4+UL71WNmNbqEDRWdrgtcZZbUI?=
 =?us-ascii?Q?AR7ZPLFwUKrMYdS/bGmQvjIAixqWh0w0U6UuwB0CTAJ0zGwJmXCrif6I4svE?=
 =?us-ascii?Q?mdL1NUNjTkUPSDbjcohBMubpu8NW4TM13VWVOee8ec10ke/u8nr69XPxqUkf?=
 =?us-ascii?Q?HVNNRqecNkAskAri5ipvONhKhEpeJOgWwzlv2VFlINK/JbeC3CME3l2DXa3t?=
 =?us-ascii?Q?O73IJnk2rdSvJf8rg0KlzVYgI2e4vr4Tj6wn4UqK+Z68tdAieniyWld63lPi?=
 =?us-ascii?Q?XHnJ/4LcnxDJR+j2revZlcrnG2jBtYAWtlBu48z2jC3xuiRl+1U3gkDJcQwV?=
 =?us-ascii?Q?E0FgZZR0YKGykaB5lA7MWzkDK+RP8d0Hu8Kdq8CLqY5ElKywt0qXE9gQpcbJ?=
 =?us-ascii?Q?/QxXBNubpnanXh24k6IcEDm7xSyJfoXt0mEuoLw2nNnRJUrcT4OXJZ3mC/lk?=
 =?us-ascii?Q?oZ6ojv4O6+vB8XS4ViVCwPKxbcJmt1C0h/pQo+xyCO2wt2ySsUOIghNMvJEH?=
 =?us-ascii?Q?ZHNHjL3SCL8Kszec1gkaHjGC75z5fnrSu+egAmj2S9GeGJ9p1jm1u9p+kdox?=
 =?us-ascii?Q?4iayfHIaHqY2Wu+MK+5L94/CaWBiYEp3TIMusWqEYl55IoF3TsShkau/HO5w?=
 =?us-ascii?Q?q+n95A06wTYq58KbE9ENDqytYwUQ3WBNKoYmVNxCSmJx9SB10NST7RUdng5g?=
 =?us-ascii?Q?Fqdl87dcATEIDiZZ5crdaRmHTieukMEl1PIyB2Iv3baDW8xPIalhi/6MEMo+?=
 =?us-ascii?Q?rVa9VLN7MEUNTF7pmsJbBA0Ghz9M472n42jLCMwEzQ7FJOtvEzcqJkK4+Ap/?=
 =?us-ascii?Q?ass+urRfLfX8xfRlJ0NdQh53ximF8ukL5Q7kqOZj4xZKjttyuoq93znprc/6?=
 =?us-ascii?Q?DhBKJUk+F3dg5R70ZGZEPJVPjg5WWPZmgeAok13HwszCQJ/P3iQe1RR4YQJ1?=
 =?us-ascii?Q?b6Mud45VJa7Zg8OlUS8lCjn1rFoSOGrhyn11Y5kHyPaQwrVQPrO/ScInKnlb?=
 =?us-ascii?Q?4K1dSM3DWpT4UrjTJrBBtHJx7/2Sfj9ofxHC9kN3GGRwKmU7ux6iaaf2il0c?=
 =?us-ascii?Q?mV+9s+DOiTaUbwt9PLRa8oWWGJD8n0OLfKS4eLGf/bvlfVbMkAcBB1/WaC+z?=
 =?us-ascii?Q?ebmUkSzR+RQlBjspEoHK6vXeXCIMJjSrwhGFgyY+xzFFFkkxz3oNc72cMtLk?=
 =?us-ascii?Q?uHNj++8oKm47IkO3Ogbh281ZxTZ7XIbSCfoVbIrZIgl+CIK4YcP+XBAhJ5lI?=
 =?us-ascii?Q?vB7IjGBUz4wnaGGfX21G7rLxS6sfdDaA52XS07ukIxFpQELSXy1QlPBRR98m?=
 =?us-ascii?Q?tah50CcPkkfhZtbC63arYuDqVsSc8C/rkydo+UCd+1Ig5J8bK4RKwk/RBC+w?=
 =?us-ascii?Q?Yod3n1xF1pwmnpOK/m969KlilYtILPBBxKhzFyiyU7ADqN0/WsOxmUFrLaD7?=
 =?us-ascii?Q?lOW3eyKszeAXoyqXUgrnU/kVVG1zcvwKBY7LQ/X0T8JUJs+fB3X0locQwSVU?=
 =?us-ascii?Q?+CmIf79LrGc1ZrJuGIN2l98oyAtC48yrZbFNyT4wz9UcDwrMeluPhsUlJozI?=
 =?us-ascii?Q?pgurOPOhomWq9+wYh1Kjdx2Tn6v9QdejL+Pm5rjTPJWyi7jNIHkywPk59XJM?=
 =?us-ascii?Q?/M1ntJzQRFfyz2mT7pSkgbALGQ1e0/cDwBs3WyiCA8S3YESQlxS6J2hrbs+p?=
 =?us-ascii?Q?xDfUzAPdAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f27611-3600-49fa-76cd-08df273d6164
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:29.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbuRpOdOR2+TSRaoPZhD8tfRtmx90QZGmTrg+0ZJt+su5+t+dF95/CVn7QbWjrUunvhk72Tu8kAxxH3oXudTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Hi folks,

This series adds CXL Reset for Type 2 devices through the existing PCI
reset_method and reset sysfs attributes. It disables CXL.cache, performs
supported cache writeback, initiates CXL Reset with Memory Clear, and
restores cached HDM decoder and CXL Device DVSEC state before PCI use
resumes. Active HDM ranges are reserved and CPU caches invalidated before
and after reset. The method remains limited to eligible single-function
devices with both CXL.cache and CXL.mem enabled.

The reset sequence follows the CXL 4.0 specification [3], including
CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
define the completion timeout encodings and reset access restrictions.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace selects "cxl_reset" in reset_method and triggers the reset
through reset. Following Dan's v6 feedback, this uses the PCI interface
instead of adding a memdev-specific sysfs ABI.

For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
callback when provided and disables PCI I/O, memory decoding, and bus
mastering. The CXL path reserves affected HDM ranges exclusively and
blocks IOMMU translations where applicable. It does not offline memory
or revoke mappings; it relies on CXL.mem users retaining conflicting
iomem resources while access remains active.

Changes from v14 [1]:
- Build HDM register helpers directly from CXL_BUS and move cxl_rwsem
  with the first built-in cache/state users, following Dave's reference.
- Split PCI-facing reset and discovery code from the generic HDM register
  and state helpers, following review of the CXL/PCI boundary.
- Rework decoder settings and cache refresh so the HDM layer does not
  depend on PCI devices, while retaining the tools/testing/cxl build.
- Skip PCI HDM cache checks and refresh for DVSEC-emulated decoders,
  and retain cached global control when register reads return all ones.
- Share DVSEC HDM-count validation, cache the Device DVSEC offset for
  restoration, and report every PCI_COMMAND restore failure during cache init.
- Reject DVSEC-only memory decode, whose ranges are not in the HDM cache.
- Use the documented region-quiesce API with explicit lock annotations.
- Capture the private HDM snapshot with range preparation and use that
  same snapshot for restoration.
- Reject CXL reset and CXL bus reset requiring state restoration when no
  PCI state has been saved, before changing the device.
- Fold the separate HDM range-overflow check into register unpacking and
  reduce the production changes to 15 patches. A separate final patch adds
  seven HDM decoder checks run separately from the watermark hooks under
  tools/testing/cxl/.

The CXL.cache/CXL.mem eligibility policy is unchanged from v14.

CXL Reset requires a registered CPU cache clean/invalidate provider
and matching firmware, such as the separate SMCCC provider series [2].
Without that provider, cxl_reset can be advertised while execution returns
-ENOTTY. The mock regression suite uses its test-only invalidation bypass.

The cxl_test module checks HDM range boundaries, zero-size and
uncommitted state, lock and target-type decoding, and 12-way interleave.
All seven checks and all 16 ndctl CXL regression tests passed on an ARM64
target with 4 KiB pages, with a separate ndctl test log-collection race
fix.

[1] https://lore.kernel.org/linux-cxl/20261001092227.3004747-1-smadhavan@nvidia.com/
[2] https://lore.kernel.org/all/20260910082142.1522865-1-smadhavan@nvidia.com/T/
[3] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf

Srirangan Madhavan (16):
  cxl: Drop stale decoder interleave limit comment
  cxl: Share CXL port upstream PCI device lookup
  cxl: Move decoder declarations to shared header
  cxl: Embed decoder configuration in a standalone structure
  cxl: Introduce endpoint HDM decoder settings
  cxl: Move HDM decoder helpers to built-in code
  cxl: Share HDM decoder register unpacking
  cxl: Refresh cached PCI HDM decoder settings
  PCI/CXL: Cache endpoint HDM state during PCI enumeration
  PCI/CXL: Add CXL Device Reset sequencing
  cxl: Validate and synchronize HDM ranges around reset
  PCI/CXL: Reject reset with unsafe function scope
  PCI/CXL: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset
  tools/testing/cxl: Add HDM decoder range checks

 MAINTAINERS                       |   1 +
 drivers/cxl/Kconfig               |   5 +
 drivers/cxl/acpi.c                |  26 +-
 drivers/cxl/core/Makefile         |   2 +-
 drivers/cxl/core/atl.c            |   4 +-
 drivers/cxl/core/core.h           |  15 +
 drivers/cxl/core/hdm.c            | 282 +++++------
 drivers/cxl/core/hdm_regs.c       | 455 ++++++++++++++++++
 drivers/cxl/core/hdm_state.c      | 367 +++++++++++++++
 drivers/cxl/core/pci.c            | 111 ++++-
 drivers/cxl/core/port.c           |  68 ++-
 drivers/cxl/core/region.c         | 102 ++--
 drivers/cxl/core/regs.c           |   9 +
 drivers/cxl/cxl.h                 |  46 +-
 drivers/cxl/pci.c                 |   2 +-
 drivers/cxl/port.c                |   4 +-
 drivers/pci/Makefile              |   1 +
 drivers/pci/bus.c                 |   1 +
 drivers/pci/cxl.c                 | 747 ++++++++++++++++++++++++++++++
 drivers/pci/pci.c                 |  18 +
 drivers/pci/pci.h                 |  29 ++
 drivers/pci/probe.c               |   1 +
 include/cxl/cxl.h                 |  59 ++-
 include/cxl/hdm.h                 | 105 +++++
 include/cxl/pci.h                 |  13 +
 include/linux/pci.h               |   8 +-
 include/uapi/linux/pci_regs.h     |  14 +
 tools/testing/cxl/Kbuild          |   1 -
 tools/testing/cxl/cxl_core_test.c |  78 ++++
 tools/testing/cxl/cxl_core_test.h |   8 +
 tools/testing/cxl/test/cxl.c      | 163 +++----
 31 files changed, 2343 insertions(+), 402 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_regs.c
 create mode 100644 drivers/cxl/core/hdm_state.c
 create mode 100644 drivers/pci/cxl.c
 create mode 100644 include/cxl/hdm.h
 create mode 100644 tools/testing/cxl/cxl_core_test.h


base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0

