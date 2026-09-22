Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F9515880;
	Tue, 22 Sep 2026 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066374; cv=fail; b=hMLEnB0rhhYuTwokecK/yqcWgzMOJCdrmo4emXv6H3g/s6CkpFCaycYpypGQVo5Qtw1PBmnP9sARpsLw8C+YxuCWw/XJqCoNUJq1y9XXGSxhlGf+JiqtTQ1oKNngYkaSFY5JR/tWUw478VTfopY1/mgBFWt6Fw86Ck4Mpw0rHN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066374; c=relaxed/simple;
	bh=ZKHl9Pm3Jr8fQFrNqdW7dEY4eGLENayTm11P9cZAs/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FL4kM6ufaScPANchKcYp6nw5nz+PkM/ajcy4iuYkJG4lld50qrmLXenUR4k4VWFPexOwjGUJ/Y2cBNwRKZuNOrzMvLbfX6S0f7cbJKjwsQwGE+ugxbDM0IWcyph4E+jE2qIqtjmAOr+MnhO2Wp9PWboMTh/9gfasEA0wsQnCx/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cG0Z1TFp; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cG0Z1TFp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogIfn5iTHP7xR5uhSIspMDXFRuQfKh6uaF9ceFC2qkjaze22b341Mb/fytyC/KvCmRJBoM3sycXPJHmld/y97twFrMd6B76UWgbgzCZKeF7Ctnnzbo+ED2wcHxZIluWIA/9NiLABQIpIyBQdqlQuyicnwwJdFZlavYgJvRAI+xzGda/Yrc2AciGS/07ER1d2trfPQMgb4r9/SY3LU9sXIwyshiKEjnAb3ogH3Ar1PH9WFbHewAtlzQjbbA7R3KlvOBvFwyEwfrNDsEMom6+KPIIHaC16ee6TIxSH+IQQU3ILlVopeinia+gwm8xNC3xjJUsAZpmnFhl+6TDCylhUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um02vgMqkQd0VfAVrIY/8xBd3827KMppc9XvVhYh0d4=;
 b=yTGMBjd+N6ZJY8C7+EY8Mj8kA5FOU2cFX2RkgSEVh/V0qpxuFVNKmm91oawiGSrzXCyvnBCoNZg8iHTC+s4LIdmZPRLtVLHUAmndrMX6QhQJNt3pcoHrbq5haj07QEn+ULNf2gmKzymZEojRp5KbbTeQUvwxOX2fpd2M39hhPYGwcg3uxbr/gVFaSJJgcJvw9jc395eRE356ILJ5xYs5bEIq0JuGkTO8oqVET8HLm1Ubhg8pRpz+oxMfZ8OjkFrczSV3M8n+Cdv9zVS2w85Rik9q5P5S0gXcowprutVqN8sCwEQIXD/63Bec/ugZkEt2qs4Lv0bjeUpw5mM5Ai/dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um02vgMqkQd0VfAVrIY/8xBd3827KMppc9XvVhYh0d4=;
 b=cG0Z1TFplfJ38DjT60HArhZNKl7SK9XwpngvuFzfyLqcBmRseQ90rJ9XDQO4CkNRXO+RO3ThFxtombuFnY9PbXQ+C2+6U8V8Y2Az5G2Wm60RUxEcAICbmePdekKse1BoCOHzr0ZMV3n3f1lvNLAU0EFEaXR2NU8bm1U0hPtgA9hqD/ufUdtG6iMlBRsbqgkk394x9Zw1C8glGzphKQbLqOkUxTi/EtiMS1f+tAG2oyAKnfPNlTJXX/PNP09e67ePvJ1lpe/ikUUt6w1DvMu4lmjTQz/R3wqml4ZrE37cZGxWD+bSfec20rLI/F1SmgJsy5x9vpwwdSL7HWJ5nKJ2Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:28 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:28 +0000
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
Subject: [PATCH v13 00/15] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Tue, 22 Sep 2026 08:39:09 +0000
Message-ID: <20260922083924.2451158-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: b0be7a15-ff6d-4735-f55c-08df188503af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	J4WLvMdBsk/rzOR+tDv+RYHxKMykJ6F8kXaZXOBdeFMTgo38JiloQsVa1rk76PyzJMJakyNfQSBxLnMhOOAUVIR9fJPjEsvRsgfTcqI6VsqbOp6Z7JD4jcy+2EtplTUAshX5pUZjCy/DElmcn53SvZ494eaxUDS/btBVTxNsl6OjBm1VA5TKEvlQjC7OqFYEd2/cZRbqfJDgYOgq5fvsakwJykWrobJcjHXOF+rRUEfDs0DidVnKzz7ETq+yJtGozkQZaR1fc4UixUloYzbb0seEf3gyejHNmgbczc5RyC3JeWEDJhogXZ/j+IRdKzpR/HOUoHJyFX5cRCD3t1iCm/JbC2cclSgcgfaoSuVa3ZTrEwx/wc4tIBwAcn/5FFq8Y0tBta5AjVTTSyjKhLIdG4vT0lGR5zEF+dNp9rYLL4X1d2PtK5v/wPNqESldKI4ypflRiv9PooR/Htb4tfaWqecWJg7UQA908jpMS6d7o8Kfq0L0RI5MUhDe0pvaYHZZ+y9FVQuHLuhYpyUObm8dcJTtNh0xOg2P2NJgPJiwyr6Ljp/Q/8JUcBE7olojCU+upVVUrjN3iw3RJfsRZJs7NQ7aFk49V4Mhom3WUSqUMwkqXC3h6j2OQ/d6x3qqdHUeOwHRCNaFzJ73EEdY780m1awUY+EE5peWZh6VGtC0GIZMM0wzQq9L4UuT7MRwvAIWdrlhYCunagPJRmc/scojvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywVSeQ7EhxO9T7YxxyjNX7jgU6VnRaYRYX5yRk2zlyLOB6jFdqTKnPD8lgBe?=
 =?us-ascii?Q?6kkSvvyPwWBKMu4Zm2hxQrf5iXdkAe5Pz9BZ1HiX08PDUoOE6I9D2i+TlKt4?=
 =?us-ascii?Q?4iNRGzjPz1XgchAhMj0whxupftCV4p3bVvDRx3AQaafdrFWtc2Yd7MhHkM+I?=
 =?us-ascii?Q?jHj0h8g9Iorm1a+66HyvRNU5TCflH54ny4sq6tJob8cgY0klI2HRKKCIZmhs?=
 =?us-ascii?Q?bzGq0Mmo8PHK2b4BjlCnUfZdYbfEb0kbnuuLQkqKj2JZvDVtok/vr6muZmjY?=
 =?us-ascii?Q?uDoi2VUqh+Nwmpi6S3pqj2eWyhM3i22b3QVvYlXOpriI8cAna5z1i6x18OSQ?=
 =?us-ascii?Q?LYSXhWCEaoRzPdpKVbxy7p4I4AwG249LCFURh1YTyS0JlvIZXhbb65L7+q7r?=
 =?us-ascii?Q?PkKKYx+oZMgTr84BlaeINUPQJ84eYinszNVLCy7TkXB4L9XgSKbSLY1G+azF?=
 =?us-ascii?Q?8BcNowT7LcalEUAwHU9tIsHz4fJ6IoDYSUd4gRwonkXUlo6oo0sPVBHG2ydv?=
 =?us-ascii?Q?B5yUhjN6WqX3akKs62N6BebRCLFJqi5MDWUesDQ23iaLsPWlgJJL90OImIXT?=
 =?us-ascii?Q?Q4LWOQ6kMF8mA9uvG+27GhHhKJEB6cys2q54rVEpqwygAKBiIldRL1LL7jRH?=
 =?us-ascii?Q?WeoezeE1oTAj9WPkIb+i1Ij+DZQx14ak1bYFXPsKqxB6sjvxxs3PAHebQVO/?=
 =?us-ascii?Q?n3qkTRInWi18WRcuM99gM12Kd8TK6NIMSz1c/BaEzne7S9vXK1MCDQGH9zij?=
 =?us-ascii?Q?vz6LkioeCG+WJUquyLhq3+ynUJerj7amB/laJWUtxUOQtPryKxo7XZetR7Gv?=
 =?us-ascii?Q?84Xe8BIVRqjQDm9f20wL6GrleuCATeSiRsJi5oXORdp/dliHNOAyYTraJW7D?=
 =?us-ascii?Q?YtfoATgUss8BB6TiJJr5jffZI49XRbIdxKZJuCIA3462HLXlOp/KrIXmIRjE?=
 =?us-ascii?Q?6VLkwIB1Uep3aLY9Gy1CV/nHYoZgXtq61hwp8Q5HDIcFxOFBml4W0HD8Tf9b?=
 =?us-ascii?Q?+rACg7tvbVBYolygLzjYIBWU8kwXbbBvKucHYxw/SBdD8Xwye1Nct8Cl6oON?=
 =?us-ascii?Q?x+609BRxL+tVsISkU+SqleECBRCjE9YVwTqLOOsSyu/XY3dywdyI3sTPyHhI?=
 =?us-ascii?Q?ke01y9WS5CiBaNYAZ5pFadgOqkQ85K/BfU/ccmR27sycXhufLzfFEuMEnVyZ?=
 =?us-ascii?Q?yTmb6Vl1Er6D51EzHLTYvRCDqxFJafLk9ddpHKa5CL1zlpaD127zUjQbSgj9?=
 =?us-ascii?Q?TtiA3qMchiYSqCmy/NhbZjrT13gewJlZi7OmuLeEAbUaZXAkoETeObeBFcVo?=
 =?us-ascii?Q?eLtRs+d7MO5FTEfAhHtMaoAKmXhgoSC6FZLJV8a3e1pbrJWYomhWFUIwrZdN?=
 =?us-ascii?Q?T5cMqixGQAOG7fxZVipBx2NGZDQ+DqBCM+HZAejmtyuyl1XOfkua8OurfO3x?=
 =?us-ascii?Q?6zj+ah0tvumP8P/C/vH+TnorXQCgGv2AHTfeg81ZydKy3YHcf7FghOw4Fxo0?=
 =?us-ascii?Q?tf3mMmTSBY5KLQbXRVNfFUlVW8SEZu3Sm+CkqYlwGm0JqYdkc5dzCp+LYmu7?=
 =?us-ascii?Q?8liliyOsU73/tO1FvYN+2O12XdbNUY5NQ5j4wnLZUtHpADUWO/ErpUrTobNn?=
 =?us-ascii?Q?YS6TJJtDkrvnJCSvvVu5zfExXCJupPhb2ySV7R6lcEXP0MqDd1wF8NFNvK/0?=
 =?us-ascii?Q?nfcZYD9qsE0fKSxDLdM5skFiAMVhzbJJRcdFtB9bFfGACI64Q/YU42ouYppP?=
 =?us-ascii?Q?cMqzY1s5MA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0be7a15-ff6d-4735-f55c-08df188503af
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:28.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4++xEdZPeC0kZwrI8sf/brJWTj5B4s4zdJ2OXXfCM1oC3Fk5rlH1p+EEUG7p0xqiNfMaDrFD1kg6qkcYlsIyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

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

v13 changes from v12 [2]:
- Split HDM helper movement from semantic changes. Patches 1--7 now
  separate the stale-comment cleanup, shared port lookup, pure code
  movement, declaration movement, settings abstraction, build changes,
  and register unpacking.
- Make cxl_commit_start() and the low-level settings writer void, and
  keep fallible commit polling separate.
- Rename the shared register parser to cxl_hdm_unpack_decoder(), build
  all values in locals, and publish a complete settings object only
  after validation succeeds. Committed and locked state are represented
  with the other decoder flags.
- Store exactly the detected number of decoder settings in a flexible
  array. Discover and validate the Register Locator BAR and offset
  directly, avoiding the resource-to-BAR round trip.
- Move CXL_RESET out of the CXL_BUS dependency block so built-in PCI
  reset support remains valid when cxl_core is modular.
- Simplify DVSEC Control2 command handling, clear Memory Clear on every
  post-programming exit, and perform a final WBI status read at the
  timeout boundary.
- Abort when IOMMU reset preparation fails. Require CPU cache
  invalidation for active HDM ranges and invalidate both before reset
  and after state restoration while the ranges remain reserved.
- Make restoration fail fast. Stop at the first mapping, decoder,
  DVSEC, PCI command, or state-save failure and retain a disabled PCI
  command state on post-reset failure.
- Restore the complete cached CXL Device DVSEC Control register rather
  than only Cache_Enable and Mem_Enable.
- Drop the method-specific reset_method ABI text; the existing ABI file
  does not document individual PCI reset methods.
- Retain the v12 Type 2 eligibility policy. The questions about
  CXL.mem-only devices and Type 2 devices with CXL.cache disabled are
  left for follow-up discussion rather than expanding this series.
- Retain the existing bus/cxl_bus method priority and carry forward the
  v12 CXL state restoration after cxl_bus reset.

Patch overview:

Patch 1 removes the stale interleave-limit comment in isolation.

Patch 2 factors the referenced upstream PCI-device lookup out of the
existing CDAT path before the HDM cache becomes its second user.

Patch 3 mechanically moves HDM programming helpers to resource.c.

Patch 4 mechanically moves shared decoder declarations to include/cxl/.

Patch 5 introduces the reusable decoder-settings snapshot and separates
infallible programming from fallible commit polling.

Patch 6 makes reset helpers available to built-in PCI code with modular
cxl_core configurations.

Patch 7 shares transactional HDM register unpacking between normal CXL
enumeration and early PCI discovery.

Patch 8 refreshes cached PCI HDM settings as CXL decoder state changes.

Patch 9 caches endpoint HDM and DVSEC state during PCI enumeration using
direct BAR-relative Register Locator metadata.

Patch 10 implements the CXL Device Reset sequence and its Control2
cleanup and timeout handling.

Patch 11 reserves active HDM ranges and performs mandatory pre-reset and
post-restore CPU cache invalidation.

Patch 12 rejects reset where function scope is unsafe, including
multifunction devices and PFs with enabled VFs.

Patch 13 restores cached global and per-decoder HDM state, decoder locks,
and the complete CXL Device DVSEC Control register with fail-closed error
handling.

Patch 14 exposes cxl_reset through the PCI reset-method table ahead of
FLR.

Patch 15 restores cached CXL state after cxl_bus reset while its existing
IOMMU exclusion remains active.

The CXL.cache/CXL.mem eligibility requirements are intentionally
unchanged from v12. I would appreciate clarification on whether support
for CXL.mem-only devices, or Type 2 devices whose CXL.cache protocol is
disabled by platform policy, should be handled as a separate follow-up.

Testing:
- Built `vmlinux` and modules with `W=1` on the
  for-7.4/cxl-zero-size-decoder topic tip.
- The corresponding v13 reset paths were built and boot-tested on an
  arm64 NVIDIA system, including CXL Reset and cxl_bus restoration.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260910070808.1444264-1-smadhavan@nvidia.com/

Srirangan Madhavan (15):
  cxl: Drop stale decoder interleave limit comment
  cxl: Share CXL port upstream PCI device lookup
  cxl: Move HDM decoder programming helpers
  cxl: Move decoder declarations to shared header
  cxl: Introduce reusable HDM decoder settings
  cxl: Make HDM reset helpers available to built-in PCI code
  cxl: Share HDM decoder register unpacking
  cxl: Refresh cached PCI HDM decoder settings
  cxl: Cache endpoint HDM state during PCI enumeration
  cxl: Add CXL Device Reset sequencing
  cxl: Validate and synchronize HDM ranges around reset
  PCI/CXL: Reject reset with unsafe function scope
  cxl: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset

 drivers/cxl/Kconfig           |    4 +
 drivers/cxl/core/Makefile     |    2 +-
 drivers/cxl/core/core.h       |    8 +
 drivers/cxl/core/hdm.c        |  241 ++++----
 drivers/cxl/core/pci.c        |   38 +-
 drivers/cxl/core/port.c       |   26 +
 drivers/cxl/core/regs.c       |    9 +
 drivers/cxl/core/resource.c   | 1280 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h             |   41 --
 drivers/pci/bus.c             |    2 +
 drivers/pci/pci.c             |   13 +
 drivers/pci/probe.c           |    2 +
 include/cxl/cxl.h             |  121 +++-
 include/linux/pci.h           |    8 +-
 include/uapi/linux/pci_regs.h |   14 +
 tools/testing/cxl/Kbuild      |    1 -
 16 files changed, 1614 insertions(+), 196 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c


base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0
