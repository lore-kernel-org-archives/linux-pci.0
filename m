Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8950EC1D;
	Fri, 16 Oct 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167861; cv=fail; b=ThdH5sBV3uOOP0TTJVocUyjW3zybDe3SICtQwjws/6TK2xxzVWyuiXJeLlmzH6R3kCAMSi3eCibZs/RnOtVBWKg99VBha15mzT8zjlZyFfZKv97VDClG84FGbfzce3DHn2La30EDvo6DYZABuRLU9snII05uUYjqqRQ6vLrlM2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167861; c=relaxed/simple;
	bh=/P7cuSpIewZcBiHFGUoy8WqGEA0x0eVdYwn7TSqo3qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS/j2ux/TqwMnXc02K0Rl/xa1e+VZfInlBj0lX9ujP+ufWatZiY1u8Sp7Oacs3dedunvk6QB9EnNcrvMHdZyKhzoCibRrYdF/D2uwXUwdh4EKtIRanICCeqPZVQqJ0sXLNh3Sb9uIfa6VfxQMSVGXSTiwFNOYke/FgnBh1RpDiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQzV5HhK; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQzV5HhK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq0sF2QIO8pFfRzE7KfHBj4hglan5bC2Wc4zjx90qaCw7eQGXf5xc+8NeyWaXChDFMX0kbvLVjXyZGGxTpsxo19Fd6yqt229gP0MD8liyPa0SLJbutwPJON4ceZppp62PaK/QXSWuKqBizLaTsIEetljco2WEaKREFTOe4Zd6RrO4jSMmjMtugXFrXHaKlxcbjlatn9T6I8Uku+QPg5zYlbro5XPpro9+IhHkOWnzdsktoNIQIEk9r0uFMbdiBQbZXg+MSEByO4C0+QlkbTb0fSzYbMPhMhY7MMKK2DSKbFXHQIF77Uob/pkc2/JlAtWXq/9ydWnVaYlnQjqDrZJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF3ktF54ndAfmhIB575khmVQQ1n0tnSbHWMTtx9ForA=;
 b=oZ6I3ZFoartOwt//xAC4grRuo9EgcRPUg3Yv/Wo+ntMfzJiFYiUTV6EqISRCV9Jl32OcW+B5A1+Gbh/6iDOp8RCeZ/iIx/aVYyruelNf+qH1dQO4OhlWTOHl/IQYFAMQhgcwYGloU50HW7GS3VafRaB2XhwlXPV9EPpmcsGUCWcoiV8Aq36+q5Hws2xGzvMI4erYdnRoBgFmVV353jb6Uddgv31C00+vGGxRIBQmExA3s3WbUELHHZ6gsoExr4dz8GWtrDKLYb7J/3XMAWZCwExKkE7F1k2lZp5PhjmdY4P65M6x7NbwVf49USgK6Y3Hf5iDHoQFS+NASEoJ0ZzD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF3ktF54ndAfmhIB575khmVQQ1n0tnSbHWMTtx9ForA=;
 b=eQzV5HhKCvBg6a84FBQtfOZ/vAx2uJtjmh42MNbru4QD0DZr2dd70P5ENH6HdmC6VLf+g1GHj1KITFRLwKNebY2eSoMb5ottkcYtxio/V/zKV7DjiTnixPaJYLH5O7rHSqPie+tjlah0J2RSVGPg+bYQioL0YquM4EX0CemfVjz+vhvjinA6vGaUmUPBWMNmVdSqkZLAayfEK1h9mY+5U5sfwpWpkzn7pGAmfkAoHYQY3hkl70jrOFvv1DQxiqatTZ4IWm7m8u3qjVJx5cl1EiTWYEuBc+muZdCo3mJEFWSKpjw9znZCiwslC/dQmqMfWBTUZ7VsaLUZ6jblxQ3UvA==
Received: from CH0PR03CA0400.namprd03.prod.outlook.com (2603:10b6:610:11b::20)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:24:00 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::55) by CH0PR03CA0400.outlook.office365.com
 (2603:10b6:610:11b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:24:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:24:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:23:35 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:23:22 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 30/31] Documentation: vfio-pci: Document CXL Type-2 device passthrough
Date: Fri, 16 Oct 2026 21:48:37 +0530
Message-ID: <20261016161839.2765592-31-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: e76bd1bb-c66e-449e-51de-08df2ba1e2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|6133799003|18002099003|10067099003|22082099003|11063799006|921020|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	V6O9u/nguxQu8Jnf4fca9b39vEM9ZSaJdr5M1emx0lDtRt3dpZjp3+tkfeXuS7MnqX4vNy8PgDPX2EDaaw/IoLnMmdoyBOCF4nHuCWSN9DGif71Er89cuoJyvXWkBqqUNfs56OI8Qpxkfa8EiM9SGc/5iM534+9GxPszRemsO70cVZmy4ScWUmnbzDMU0ZUqhDRrTJi/hhCysPSQSIn8pt6EZ68P2BzmZ/GL6geczQbNLXSXqbRDZO+iEf6RFKkKZqm85crIf7jNq9PvEQnmW8pQes/kX3gcUrMecm03kZiVy2QfqWzUhBKviOtQFINCCLsqMn0U/EPZAinxJ3DSwH6vx2USymN6W9cMlLHeTlC8/gRUpDzQ/mHzkPZGCCxGyct1muW/Ly6IOv9wRpvvqzkHd1ScYqMjpGbTOszyFwuD1SM/hpRJUwjPOPsgvMVkURhPuPwfn2Z6WqIehAW+DH+aG/E1l/sZ2iIQ9VUS0CZWADbV/KiO64M8YRv3cLeGjCdQNuna5N++fmIEBUgVXyy9Q3OmyEWxnQ/duquerT0/LAstOovcALeebi1R8Vm/27y6QyhG3KLGdj7qC+FEDcIDHxU16pqgwhuanL6gg4onkH/1sbuRiiwXacR3GE9MrQt6WJzeOt86hCAXlKMCcDAVtvD+FAStvmHsJL2tVea4OArlEKJD8SKrdPEpbPP4PfWavPrbdlFb+B2Gs0hKBTZMFyrtVo2ws0wIrNub74RZBxWUZvMheN+77FGk4z/1
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(921020)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MQt/9coe6j5WJOOCGvG6AdH7KtOJlSpZQqbBCO0X++eTXaeJPlJK38oNRZMqCSeQQBQ5l4bHogQ1nneQDfI69KRNVldg+5Eu5erkARRFct9DqMy/pE6/Zo1xhNN3VKox5YhzQRVL2nUA1H4l7CeI0n+CJ/qMfdUCvrIsw4YSdmVH6oFfstLVRYZl30aeuG+59RRM/x4HXNUayhKMDhbvmwLvfRg2Ul74zuJpsiRxUA2wb98hmOLYZX0Afl/53tatDjQPMREmT5NVJdz4EPD3YlbyoebTV0HtUKNGA/3OOALIxMjFxbfil7nRBn1a/lNB27Skon/ZtRdXNhQB9lFu0baTt70EoAyuMOsa0+nvyLhHzW+NGhkhx7X/zBGsGUR6QM2epzRHpFwQs+5mwQWPIMQ7uTUz8Jajsconya19N/1nOxbxTN1L01Yv18DVtbmU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:24:00.3128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76bd1bb-c66e-449e-51de-08df2ba1e2cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

From: Manish Honap <mhonap@nvidia.com>

Describe the vfio-cxl provider module:
- Address model,
- Two regions,
- Live decoder region and the guest commit,
- DVSEC virtualization,
- The dma-buf export for iommufd stage-2 mapping,
- The reset contract, including the hot reset,
- Low power

so the supported topology and the kernel/VMM split are on record.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 312 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 3 files changed, 314 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6601a258690f..733ea1b64c72 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -46,6 +46,7 @@ of interest to most developers working on device drivers.
    uio-howto
    vfio-mediated-device
    vfio
+   vfio-pci-cxl
    vfio-pci-device-specific-driver-acceptance
 
 Bus-level documentation
diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
new file mode 100644
index 000000000000..fc47a8015f1f
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,312 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+VFIO-PCI: CXL Type-2 device passthrough
+=======================================
+
+Overview
+--------
+
+A CXL Type-2 device is an accelerator (for example a GPU) that exposes
+host-managed device memory through an HDM decoder. vfio-pci alone passes
+the HDM decoder registers through as part of a BAR, only guards the CXL
+Device DVSEC against writes that outlive the user, and does not place the
+device memory at a guest-chosen address.
+
+The optional ``vfio-cxl`` module traps the decoder registers and exposes
+the device memory as a region that a virtual machine monitor (VMM) can
+place in guest memory. It is a provider for vfio-pci-core, not a separate
+PCI driver. vfio-pci-core keeps generic hooks and the CXL DVSEC
+virtualization, calls no CXL core function, and loads ``vfio-cxl`` when
+it binds a CXL device.
+
+Address model
+-------------
+
+The HDM memory is a coherent range of host physical addresses (HPA).
+Firmware commits the endpoint decoder for that range before the guest sees
+the device. vfio-cxl takes the range from the committed decoder and holds it
+for the bind lifetime. vfio-cxl does not know where the memory appears in
+guest physical address space (GPA).
+
+The VMM picks the GPA. It builds the guest's CXL Fixed Memory Window
+(CFMWS), so it decides the guest physical window the device can occupy. The
+guest then programs a virtual endpoint HDM decoder inside that window (see
+"Virtual decoders"). It never programs the physical decoder.
+
+There are two ways to back a guest decoder with device memory. With fixed
+placement, each guest address maps to one host address at a fixed offset.
+A host window at HPA [0x10000, 0x20000] presented to the guest at GPA
+[0x50000, 0x60000] resolves a guest decoder at GPA [0x58000, 0x60000] to
+HPA [0x18000, 0x20000]::
+
+  +-----------+------------------------+----------------------------------+
+  | host      | HPA [0x10000, 0x20000] | decoder committed by firmware    |
+  | CFMWS     | GPA [0x50000, 0x60000] | built by the VMM                 |
+  | vdecoder0 | GPA [0x58000, 0x60000] | backed by HPA [0x18000, 0x20000] |
+  +-----------+------------------------+----------------------------------+
+
+Without fixed placement, the host kernel would back each guest page with
+any free page of device memory when the guest first touches it. That suits
+memory whose position does not matter to the device, for example compressed
+memory::
+
+  +-----------+------------------------+---------------------+
+  | CFMWS     | GPA [0x50000, 0x60000] | built by the VMM    |
+  | vdecoder0 | GPA [0x58000, 0x60000] | no fixed host range |
+  +-----------+------------------------+---------------------+
+
+vfio-cxl implements fixed placement only. Firmware commits the physical
+decoder and vfio-cxl never moves it, so the device memory sits at one host
+range, and the VMM maps the whole range at one guest offset. Placement
+without a fixed offset is not implemented.
+
+Driver model
+------------
+
+vfio-pci binds the device. During bind,
+vfio-pci-core detects a CXL device (``pcie_is_cxl()``), loads ``vfio-cxl``
+with ``request_module()``, and calls the registered ``struct
+vfio_cxl_ops``. The module reference is pinned for the bind lifetime so
+``vfio-cxl`` cannot unload while a device is bound.
+
+At bind the provider creates the CXL memory device and takes ownership of
+the whole component-register BAR. A Type-2 function has no mailbox, so the
+provider marks the media ready directly. A non-CXL device, or a CXL device
+whose CXL setup fails, falls back to the ordinary vfio-pci paths. The
+failure is not fatal to the bind.
+
+A CXL Type-2 device bound without the provider (``vfio-cxl`` not built or
+not loadable, its setup failed, or ``disable_cxl`` is set) gets none of the
+protections described below. The HDM decoder registers in the component
+register BAR are directly accessible to the user, and a function reset uses
+the PCI core reset methods, which can fall back to a Function Level Reset
+(FLR). An FLR is not a CXL Reset and does not clear device memory. vfio-pci
+still guards the CXL DVSEC of such a device: writes to the Lock and Range
+registers are dropped, and Initiate CXL Reset runs as a vfio reset instead
+of reaching the device.
+
+The provider also requires that the host can reset the device with CXL Reset
+with Memory Clear, including the CPU cache invalidation for the HDM range
+that the reset performs before and after the reset. On arm64 that
+invalidation needs a registered cache maintenance driver, for example the
+SMCCC cache clean/invalidate provider with matching firmware. Without it the
+device is bound without the CXL extensions, so no guest receives device
+memory that the host could not clear on the next reset.
+
+Regions
+-------
+
+``vfio-cxl`` adds two regions under the PCI vendor-type region
+``VFIO_REGION_TYPE_PCI_VENDOR_TYPE`` for the CXL vendor (0x1e98):
+
+``VFIO_REGION_SUBTYPE_CXL_MEM``
+    The HDM memory region, backed by the fixed host physical range. It can
+    be mapped with mmap. The fault handler inserts the host PFNs, including
+    PMD-sized mappings when the mapping is aligned, but only while a host
+    CPU access to the range is safe: the committed decoder is in place and
+    the media is ready. Otherwise the fault takes ``SIGBUS``. CXL.mem
+    decode follows the committed decoder, not the PCI Memory Space Enable
+    bit, so this region does not follow the Command register. It is taken
+    out of use across reset, bus reset and low power instead: vfio-cxl zaps
+    its mmaps and revokes its dma-bufs, and a fault takes ``SIGBUS``. The
+    range has no struct page and is registered with the memory-failure
+    machinery, so a memory error is contained to a ``SIGBUS``. The VMM maps
+    this region into guest memory at a fixed guest offset (see
+    "Address model"), and can also export it as a dma-buf (see "DMA and
+    iommufd").
+
+``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+    The HDM decoder registers. Access is read/write only (no mmap) and
+    must be dword aligned. A misaligned or out-of-range access returns
+    ``-EINVAL``. Reads are served live from the committed decoder, and fail
+    with ``-EIO`` while Memory Space is disabled, as BAR reads do. The
+    decoder was committed before bind, and firmware may also have locked
+    it, so the register block is read-only to the user and writes are
+    dropped. The region carries a ``VFIO_REGION_INFO_CAP_CXL_COMP_REGS``
+    capability that reports the component BAR and the offset of the decoder
+    block within it, so the VMM can place the trapped window where the guest
+    expects it.
+
+The decoder register range is also excluded from the direct component-BAR
+mmap and from BAR reads and writes through the device fd. A user write
+there could uncommit or move a decoder the host relies on, so reads return
+ones and writes are dropped. The rest of the component BAR is a normal
+vfio-pci BAR.
+
+Virtual decoders
+----------------
+
+The guest sees virtual endpoint HDM decoders. The VMM emulates them, and
+reads the physical decoder through the decoder-register region::
+
+  +-------------------+---------------------------------+-------------------+
+  | guest             | VMM                             | vfio-cxl          |
+  +-------------------+---------------------------------+-------------------+
+  | writes base, size | keeps them (a GPA)              |                   |
+  +-------------------+---------------------------------+-------------------+
+  | writes COMMIT     | reads the physical decoder      | live read returns |
+  |                   | from the region                 | COMMITTED         |
+  |                   | maps the HDM region into        |                   |
+  |                   | guest memory, reports COMMITTED |                   |
+  +-------------------+---------------------------------+-------------------+
+  | reads base        | returns the GPA                 |                   |
+  +-------------------+---------------------------------+-------------------+
+
+Writes to the region are dropped, so neither the guest nor the VMM can
+decommit or move the physical decoder. vfio-cxl commits it again only when
+a reset or low power has cleared it, with the settings taken at bind. Reads
+of the region come from the hardware.
+
+CXL Device DVSEC
+----------------
+
+vfio-pci-core virtualizes the CXL Device DVSEC body through its config-space
+permission hooks. Reads and writes inside the DVSEC body use a per-open
+shadow. A guest write stays in the shadow and does not reach hardware.
+Accesses outside the DVSEC body go to the device as usual.
+
+The self-clearing Control2 doorbells (Initiate CXL Reset and Initiate
+Cache Write-Back and Invalidate) are never forwarded to hardware. Initiate
+Cache Write-Back and Invalidate completes in the shadow at once. The host
+writes back and invalidates the device cache as part of CXL Reset.
+Initiate CXL Reset runs the real reset (see "Reset") and reports the result
+in the shadow Status2: Reset Complete on success, Reset Error on failure.
+
+DMA and iommufd
+---------------
+
+Some accelerators, for example a GPU, read and write their own HDM memory
+with DMA translated through Address Translation Services (ATS), using the
+same guest physical addresses as the vCPUs. For such a device the HDM range
+must be in the guest IOAS: the iommufd I/O address space that the VMM builds
+for the device, which translates the guest physical addresses the device uses
+to host physical addresses. A device that does not send DMA for its own
+memory through the IOMMU does not need the range in the IOAS.
+
+vfio-cxl claims the whole HDM range at bind with
+``request_mem_region_exclusive()``, and the host never onlines it as system
+RAM, so the range has no struct page. ``IOMMU_IOAS_MAP`` takes a VMM
+virtual address and pins the pages behind it, so it cannot map this range.
+Instead, ``VFIO_DEVICE_FEATURE_DMA_BUF`` on the HDM memory region returns a
+dma-buf fd, and ``IOMMU_IOAS_MAP_FILE`` maps that fd into the IOAS without
+a virtual address or a page pin.
+
+Two second-stage translations point at the HDM range. KVM's stage-2 maps
+guest physical addresses to it for the vCPUs, through the VMM's mmap of the
+HDM memory region. The IOAS maps the same guest physical addresses for the
+device's DMA, through the dma-buf. Across a reset or a low power transition
+the decoder that routes the range to the device goes away, so vfio-cxl
+removes both translations first: it zaps the mmap and revokes the dma-buf.
+Otherwise a CPU access or a DMA could target a range that nothing decodes.
+
+When the region is usable again, the CPU side comes back through the
+region's fault handler. The device side does not. iommufd unmaps the IOAS
+range when the dma-buf is revoked and does not map it again, so the VMM
+has to unmap that IOVA range and map the same dma-buf again with
+``IOMMU_IOAS_MAP_FILE``.
+
+Reset
+-----
+
+An FLR does not reset CXL.cache or CXL.mem state and does not clear device
+memory (CXL r4.0 sec 9.5), so it cannot isolate one user of the device from
+the next. FLR is therefore virtualized rather than passed to the device.
+vfio-cxl resets the device with CXL Reset through ``pci_cxl_reset_owned()``.
+The host invalidates the CPU caches for the HDM range, resets the function
+with Memory Clear, restores the HDM decoder and the PCI config state, and
+invalidates the CPU caches again. A failure is returned to the caller. The
+reset never falls back to FLR.
+
+A guest reset request, either Initiate CXL Reset in the DVSEC or a guest FLR
+through config space, is trapped and not forwarded. The real reset runs at
+the vfio reset points: the reset ioctl, the virtualized FLR and the Initiate
+CXL Reset doorbell. vfio-cxl zaps the HDM mapping, revokes the dma-buf and
+runs CXL Reset with Memory Clear, which clears or randomizes volatile device
+memory (CXL r4.0 sec 9.7). vfio-cxl then restores the decoder. If the reset
+fails, the ioctl returns the error and the HDM region stays out of use until
+a later CXL Reset through a vfio reset point succeeds. A hot reset or a
+return from low power in between does not reopen it.
+
+A CXL port masks Secondary Bus Reset by default (CXL r4.0 sec 8.1.5.2), and
+a masked SBR does not reach the endpoint. The PCI core refuses a bus or slot
+reset below such a port, so ``VFIO_DEVICE_GET_PCI_HOT_RESET_INFO`` and
+``VFIO_DEVICE_PCI_HOT_RESET`` fail for the device, and a VMM uses
+``VFIO_DEVICE_RESET`` instead. If the port has SBR unmasked, the hot reset
+decommits the decoder. vfio-cxl takes the HDM region out of use before the
+reset and restores the decoder afterwards with
+``cxl_restore_state_after_pci_reset()``, the helper the PCI core's
+``cxl_bus`` reset method uses, unless the decoder is still committed. If the
+restore fails, the hot reset ioctl returns the error. A reset that the host
+starts outside vfio, for example through the ``reset`` attribute in sysfs,
+is handled the same way. Its result is only logged, and on failure the HDM
+region stays out of use until a later reset succeeds.
+
+PCIe error recovery (AER and DPC) can reset the link without those
+callbacks. vfio-cxl takes the HDM region out of use when the error is
+reported. It puts the region back when recovery resumes the device only if
+the region was in use before the error, no CXL Reset failed meanwhile, and
+the decoder is still committed. Otherwise the region stays out of use until
+the user resets the device.
+
+Device memory can stay unavailable for a while after the decoder is back.
+The device clears Memory_Active in DVSEC CXL Range 1 Size Low until the
+memory is usable again (CXL r4.0 sec 8.1.3.8.2). At bind, vfio-cxl waits up
+to the Memory_Active_Timeout the device reports for Memory_Active, since a
+reset just before the bind also clears it. On a device whose memory then
+reads active, vfio-cxl keeps the HDM region out of use after a CXL Reset, a
+hot reset, AER or DPC recovery and a return from low power until
+Memory_Active is set, waiting up to the same timeout. A wait that times out
+leaves the region out of use, as a failed reset does. A device whose memory
+stays inactive at bind relies on its driver to bring it up and is not
+waited for.
+
+After a reset vfio-cxl restores the firmware-committed decoder from the
+settings taken at bind, so the geometry the VMM reads back is unchanged.
+CPU access comes back through the region's fault handler. Device DMA to
+HDM needs the VMM to map the dma-buf into the IOAS again (see "DMA and
+iommufd").
+
+Low power
+---------
+
+The device may enter D3hot or runtime low power while it is assigned. Low
+power loses the committed HDM decoder, so vfio-cxl takes the HDM region out
+of use before it enters low power. It restores the decoder configuration
+when the device returns to D0, after vfio-pci-core has restored its config
+space. If a low power request left the device in D0 and the decoder is
+still committed, the region is put back without a restore. vfio-cxl does
+not save or restore device memory across low power.
+
+UAPI
+----
+
+``VFIO_DEVICE_FLAGS_CXL``
+    Set in ``VFIO_DEVICE_GET_INFO`` flags for a CXL Type-2 device.
+
+``VFIO_REGION_TYPE_PCI_VENDOR_TYPE | 0x1e98``
+    With ``VFIO_REGION_SUBTYPE_CXL_MEM`` or
+    ``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``. Reported through the region-info
+    ``VFIO_REGION_INFO_CAP_TYPE`` capability. Userspace finds each region by
+    scanning for the type and subtype.
+
+``VFIO_REGION_INFO_CAP_CXL_COMP_REGS``
+    On the component-register region, reports the component BAR index and
+    the decoder-block offset within it.
+
+``VFIO_DEVICE_FEATURE_DMA_BUF``
+    On the HDM memory region, returns a dma-buf fd for
+    ``IOMMU_IOAS_MAP_FILE``.
+
+The HDM decoder register layout is available to a VMM without a private
+kernel header via ``uapi/cxl/cxl_regs.h``.
+
+Scope
+-----
+
+This support covers a single, non-interleaved endpoint decoder on a
+directly attached device. Multi-decoder devices, interleave, and
+switch-attached topologies are not supported.
+
+A selftest, ``tools/testing/selftests/vfio/vfio_cxl_type2_test.c``,
+exercises the interfaces above on a bound device.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8ac0a91ce647..9fc94cdf021c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28641,6 +28641,7 @@ M:	Manish Honap <mhonap@nvidia.com>
 L:	kvm@vger.kernel.org
 L:	linux-cxl@vger.kernel.org
 S:	Supported
+F:	Documentation/driver-api/vfio-pci-cxl.rst
 F:	drivers/vfio/pci/cxl/
 
 VFIO DRIVER
-- 
2.53.0

