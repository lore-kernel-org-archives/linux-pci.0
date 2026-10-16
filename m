Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C24E06E4;
	Fri, 16 Oct 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167590; cv=fail; b=AbQiP2pCmEzbS0WMFebU1mkAH96RKbwFSs9ibBum295Dg1i7GVo2N8vtYp97NncQF+2Mjy53wJVbbBR+4BLrf6ZesdGVnE5N70gfSAMNj41N9CtAI3vcCQt08a9vPvu3to2uVhaXhX4jYR91Ki9aO20ohz/vT438/vMgdmlrBWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167590; c=relaxed/simple;
	bh=+sZafyrJwiX1h0f69aklWQ7FHbx84jkN9xEUsfAJauY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oM0G8CRms4ml11fH37p994PakB1IO3iCZ3cWNS8R/rmtqx3W76olQisp2MWFrHVD9vN9oBCbvOPqQfjjTSO7CyhLrwE8WMkZcMsHmiaAUN4XqT2Nv8kuGPucJJfJLJmFBP6/wDjpMyCxM/xx2fk+7G6giz1HqYOE9us7TMFKKs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=InuFxEmD; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InuFxEmD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T80pBKjmPBOzsmlIwQAcRJ4sVCmcNJXrWyaiAp4vW7388mpx1zb3Y7j6XJg9h+8aBq7VnkCUC34E7KyYFnXYl/jFK2Qh/dz2lrspNLzURF9IJTEWKRQCpv+pMYmbQFdfLAXDtMsea0VZpEoRmxssot6s5Py5NvaEX2SeBCNYDpyZak4VoqfkqR2i1KQf+0zlzognjHmq5Rk3S2nGGDH/w68Y/9db93Q+GBjUAYIuZ+C9fUmEa7KR3ym8ZhaN40+82x/j7Rli/Hs9UWv85kPGPtRR9QCeLECdpIik8MbXWsrHjsK4LT4St7HkmUcdh2soJo+I1PorEBB7jAcMZw9TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3l7aSHoxwNFRZnpa24voWyeDs+5PTlOTtvuHF1WRn8=;
 b=esQ2gcsGM7OxheDcf1bAvjr8JvwRgCoMWashF4wVOQByeOXgPK4LgL89o5pCa1MyJgUqdFW52dxuOoq/KGes9uaDUINSzSeQ4fE+/axTQCppMIHRlgF78xDfbZY4CZlTyUrbKFUfKdkylwz3h6AofHioVlz+WMdn+3kCjOMR6UCvlZwtzzm0E46aDoLbksTopT8hLY8eyrbPtJt/ToSO0BkJsNpSw1dfQ4wTrZKW86ji+1rdAtgr386AvstlmDBQrZT5rTz2wTL0zZMR51GZbt2WnDJNbdMLs2HRL+taNCkAdm5ERGPhuTUV2A60rRFOA+96ZviO6qpN3tu+pI9rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3l7aSHoxwNFRZnpa24voWyeDs+5PTlOTtvuHF1WRn8=;
 b=InuFxEmDQ0Rpt1OMGNC6NqBBqtRXIy7VugZwYDATiM50dYmevhy1If/zylRhgRAmkbdgbFSnNEq/+yn93NDLDHkpMmq7VmnH966dINtPlQ/H4x647HDGLzYQ8sK0Z3RZDf1YjPas6amnqLFT7+HPZMPYutI/oCTJVyOTwq7i6wfXtNq1mjTWFl0hc+V8spK7lyj0YHG3edDKgc4g6yEUpLv0MHtZZIpe0hEQQTpDWiOLuSgvhr1gTkyQar7oo6Q5/qFrBXnR/NCXVjoPd4lVVVANWm8EoPVwgd62CNkjWbLT3tIec9aGt+6C9wvE6lKDi89KtrulWx7ooGDbi6yJ3A==
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 16 Oct
 2026 16:19:30 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::69) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 16:19:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:19:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:05 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:18:55 -0700
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
Subject: [PATCH v6 00/31] vfio/pci: Add CXL Type-2 device passthrough support
Date: Fri, 16 Oct 2026 21:48:07 +0530
Message-ID: <20261016161839.2765592-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b796d0-7289-44d4-4005-08df2ba141a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|10067099003|6133799003|18002099003|921020|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mlGGqvvPIBP+tP3N1zAacRvtaaSPDr/lef2Wngec5900GO2Vkzy5G9zosHGGZxiZ9TgoRGH0hDGSfn/Bf6fXDk10mpW3GeLHrBcf+L+21nt8f1pJbRJ0L3m2H2NZWGReRR09M/XWAxT1XxFDTp1HOm1KtkS8MGKFIsBAYQdkJ/Gp8LpRD5DWu6uSR6bChWjKR357hWRzyQa/g6v6U/3LvmCXtdmTmAWOpV1ZqPR8tsMgClkg67nk99mPf8rd5CIXcNWUNMaK9NkMWxggk5hvgRk5owP13p+V7scXHumHh6FCbtcBtxE409G641D0w7f3vOcXcU0jXW1CH3envzfOsbIJOgLfrag4QCfDuSl6hUx8DnRP0W0C2NVKeO7GplkGAhucXoAo0gOr+XXlyGU5LlwuIxTpPqwnMIqgzEwbNjfcpOGinKBCZgSxBZVFEBOeQK9acWugqkk5HUbDZlxdArMeAlNiFW4lDM6Mh0nA6Xv/d6jm4R1HPdAOn/b4ga2wVhXVN6M+SykpkOSttqIyDfJb3R7S7afm5MMCCfBsuV+RLKLR1n4eTR1hvPuL9gh/xwq3NwaH0l78OfzL+2TQjAO0wrPsxQIKdI01Grk44tzGBR4NkATKayM0ksLv7/G4DooAtVK906JtxFLk6CnOurjMp3ZM4vCtcUZgIVVO2uiLGVircLSCAyvouAQL61k7XGFXAf7ZhtOvPqcS+bjygcSwis9ng1guIbhPrB5ca8gHyZmf5Wnl8cEfum+g/sRa
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(921020)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zw35rbS+rSUboXb7sqXbhaD+VUTCYawh7bAvxkhK3w2g0fY27CBYHJ7/xhCuuUpqmdP9OdOHMqpMqa/4Zv/bR7feLeU8LMz5SJ56G3EQiso+DZMWGDmloRw90bC26mVXWoEA/8cODMh+f2GqGZfFd8gMiUof1/u7QFStgfaS685bL1vqbxdsos6HZh2HLH3uCAUuf4Mvq5g2BoQKU3XNAE/6MENjWIkcEATFFMiW++opjDFK2WeLAeWKQ6fVp5OuU3LGNC4/biqMjv7ZbwWa3+XGKZK/6GGZbj7h/U05zTXOWkjUqCqAsxzXMKMLe0dY3NUm8vdjIZ/ynX5n+vSPlpm1z3HL1MyrJPWXRyFRlCdyxDCaLvqNwp4AIb377gTReh6Ss2td+ySiUez1YvO68wwiQJVYe/+bs6+Dln+Zo4i2SdcdTBeT65ecyVxHLGOm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:19:29.8967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b796d0-7289-44d4-4005-08df2ba141a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

From: Manish Honap <mhonap@nvidia.com>

Hello CXL Community,

This series adds VFIO passthrough for CXL Type-2 accelerators. The guest
drives its own virtual HDM decoder and can reset the device. The host
owns the physical decoder and the host physical address the memory lands
at. The guest only picks a guest physical address. This series targets a
single, non-interleaved, firmware-committed endpoint decoder.


Base and dependencies
---------------------

  Base: Linux 7.3-rc5 (72d3fcf802c4), plus:
  - Richard's zero-sized HDM decoder series (v10) [1].
  - Srirangan's cxl_reset series (v15) [2]. It caches the endpoint
    decoder settings in pdev->hdm at enumeration and implements CXL Reset
    as a PCI reset method in drivers/pci/cxl.c.

  Patch 4 of this series changes drivers/pci/cxl.c from [2]. v15 exports
  no reset entry that a module can call, and its reset method falls
  through to FLR when it cannot run, so patch 4 adds an entry for a
  driver that holds the HDM range and exports the helpers vfio-cxl needs.

  Runtime requirement on arm64: CXL Reset invalidates the CPU caches for
  the HDM range, which needs a registered cache maintenance driver. The
  series was tested with the SMCCC cache clean/invalidate provider (v3)
  [3] and firmware that implements the SMCCC cache operations; v4 [4] has
  since been posted. This is not a build dependency. Without a provider
  the device binds as plain vfio-pci, without the CXL extensions.


Changes since v5
----------------

v5 [5] kept the v4 provider model. v6 keeps it too and folds the v5
review, the rebase onto cxl_reset v15, and fixes found by testing on
hardware.

Base and dependency
  - Rebased from cxl_reset v12 onto v15. v15 moved the reset into
    drivers/pci/cxl.c, so the v5 patch that added
    cxl_reset_dvsec_sequence() in drivers/cxl/core/resource.c is replaced
    by patch 4: pci_cxl_reset_owned() runs the reset for the driver that
    holds the HDM range and returns its failure to that driver. A reset
    that cannot run fails instead of falling through to FLR.
  - Bind requires that the host can run CXL Reset for the device,
    including the CPU cache invalidation. Otherwise the device binds
    without CXL support, so no guest gets device memory that the host
    cannot clear on the next reset.

Structural
  - Patches 07 and 08 are folded into 06 (now patch 7).
  - The excluded-range patches 09 and 10 are now three: per-BAR sorted
    lists with the read/write path and MSI-X moved onto them, the sparse
    mmap capability, and refusing ioeventfds and dma-buf exports over an
    excluded range.
  - The HDM region patch is split into read/write (21) and mmap (22).
  - New vfio-pci-core patches: one try-reset helper for every reset point
    (15), revoke and re-arm of one device-specific region with its
    dma-bufs (16), and provider hooks across low power (17).
  - New PCI patch: bus and slot reset are refused below a CXL port with
    Secondary Bus Reset (SBR) masked (5).

Behavioral
  - Low power is supported and the D0 pin is gone. vfio-cxl takes the
    HDM region out of use before the device leaves D0 and restores the
    decoder when it returns.
  - The HDM region and its dma-bufs follow the committed decoder, not
    Memory Space Enable. vfio-pci-core no longer knows about HDM: each
    dma-buf records the region it was exported from, and vfio-cxl revokes
    and re-arms its own region around reset, hot reset and low power.
  - With SBR masked, VFIO_DEVICE_PCI_HOT_RESET fails instead of reporting
    a reset that never reached the device. With SBR unmasked, reset_done
    restores the decoder and the ioctl fails if the restore fails.
  - A failed CXL Reset returns its error and leaves the HDM region out of
    use until a later CXL Reset succeeds. A hot reset or a return from
    low power in between does not reopen it. The first reset at open
    fails the open only on -EAGAIN.
  - AER and DPC recovery take the HDM region out of use, and put it back
    only if it was in use before the error and the decoder is still
    committed.
  - Reads of the decoder register region fail with -EIO while Memory
    Space is disabled, as BAR reads do.
  - HDM region read and write copy through a page-sized kernel buffer, so
    memory_lock is not held across a user copy.
  - The guest's Initiate CXL Reset doorbell runs the real reset and
    reports Reset Complete or Reset Error in the shadow Status2.
  - Without a provider, vfio-pci still guards the CXL DVSEC of a Type-2
    function: Lock and Range writes are dropped, and Initiate CXL Reset
    runs as a vfio reset.
  - The CXL DVSEC is matched by offset range, so a DVSEC right before or
    after it in config space no longer bypasses the virtualization or
    indexes past the permission map.
  - CXL specification references are updated to CXL r4.0.

Found in hardware testing
    vfio-cxl now waits for Memory_Active, up to the Memory_Active_Timeout
    the device reports, before it puts the HDM region back. It also waits
    at bind, since a reset just before the bind clears it too.
  - The bind-time copy of the HDM state used a helper that asserts the
    device lock. The PCI core can run probe in a worker on the device's
    NUMA node, so lockdep warned at every bind. Patch 4 adds
    pci_cxl_hdm_snapshot(), which needs no device lock.
  - The disable_cxl module parameter was never read. It now takes effect.


Reviewer feedback addressed
---------------------------

The v5 [5] thread has the full discussion. This is where each comment
landed.

Alex Williamson
  - Provider load and its failure handling are one patch (7), and the
    messages say "continuing without CXL support".
  - The excluded-range list is per BAR, sorted, and rejects overlaps; the
    ROM is left alone; ioeventfds and dma-buf exports over an excluded
    range are refused (8 to 10).
  - cxl_dvsec_len had no user in v5 (11). It now has one: the CXL DVSEC
    is matched by offset range.
  - vfio-pci exports vfio_pci_core_reset_prepare() and
    vfio_pci_core_reset_done(), and calls them from its own error
    handlers instead of reaching into drvdata (13).
  - Low power is supported instead of pinning D0 (17, 21).
  - vfio_pci_core_unregister_dev_region() is gone. vfio-pci-core frees
    every dynamic region on a failed open as well as on close (12), so
    vfio-cxl has nothing to unwind.
  - hdm_valid is set at bind and changed only by reset, hot reset and
    low power.
  - vfio_pci_zap_bars() covers only the BARs again; a device-specific
    region is revoked by its provider (16).
  - The decoder register read takes memory_lock and checks Memory Space
    (24).
  - Hot reset with SBR masked and unmasked (5, 26).
  - Reset is a mandatory provider op behind one try-reset helper (15),
    with a success-oriented flow in vfio-cxl (29). .hdm_active is gone.

Jonathan Cameron
  - Patch 1 keeps the Reviewed-by tag.
  - A BAR-owning driver records one owned resource; a second call warns
    and fails with -EBUSY (2).
  - The uapi header uses __GENMASK() and _BITUL() (3).
  - CXL Reset writes back and invalidates the CPU caches for the HDM
    range before and after the reset (4).
  - Allocator and style changes in 9, 11 and 12, and the devres group
    factored into a helper (19).

Richard Cheng
  - The provider module reference is pinned per bound device (7).
  - ioeventfds and dma-buf exports over an excluded range are refused
    (10).
  - A dma-buf of the HDM region is exported with no_peer2peer set (28).
  - The PCI state is saved before the reset at open (15).

Gregory Price
  - The documentation is reworked (30) as per review comments.


Patch order
-----------

The tree builds at every commit. Five groups:

  Part 1  CXL core and PCI (patches 1 to 5)
    - Split the BAR block request and ioremap helpers, and let a
      BAR-owning driver own the component register block, so the HDM
      and RAS sub-blocks are left for vfio-cxl.
    - Move the component register defines to include/uapi/cxl/cxl_regs.h
      so a VMM and the selftest can use them.
    - Let the driver that owns the HDM range run CXL Reset.
    - Refuse bus and slot reset below a CXL port with SBR masked.

  Part 2  vfio-pci-core (patches 6 to 17)
    - The CXL provider ops registration and on-demand provider load.
    - The generic excluded-range list, its sparse mmap capability, and
      the ioeventfd and dma-buf checks.
    - The CXL DVSEC virtualization, the open and close hooks, the reset
      hooks, and the disable_cxl opt-out.
    - The try-reset helper, per-region revoke and re-arm, and the low
      power hooks.

  Part 3  vfio-cxl provider and HDM regions (patches 18 to 28)
    - The vfio-cxl module, the CXL memdev created at bind, and ownership
      of the whole component BAR.
    - The HDM memory region (read/write, then mmap), memory-failure
      containment for it, and the read-only decoder register region.
    - Excluding the decoder block from the direct BAR, the decoder
      restore after a hot reset, the device and decoder geometry
      capability, and the dma-buf export.

  Part 4  vfio-cxl reset (patch 29)
    - Run CXL Reset at every vfio reset point.

  Part 5  Documentation and selftests (patches 30 and 31)


Subsystem boundary
------------------

vfio-pci-core does not implement CXL registers. vfio-cxl is a separate
module that registers a struct vfio_cxl_ops at init. vfio-pci-core loads
it on demand for a CXL device (request_module() after pcie_is_cxl()) and
pins it per bound device. If a modular provider is missing or fails to
load, the device is driven as plain vfio-pci. The bind only defers for a
built-in provider whose initcall has not run yet.

vfio-pci-core provides generic pieces that a provider calls: the
excluded-range list, revoke and re-arm of one device-specific region,
the try-reset helper and the low power hooks. The CXL-specific work stays
behind the ops. The CXL DVSEC virtualization is the one CXL piece in
vfio-pci-core, because it lives in the config space permission hooks.


Memory ownership
----------------

The host resolves the host physical address once, at bind, from the
committed decoder. vfio-cxl creates the memdev at bind and tears it down
at unbind. It claims the HPA range with request_mem_region_exclusive(),
so nothing, /dev/mem included, can map a conflicting cacheable alias.

The guest programs a guest physical address into a virtual decoder that
the VMM emulates. It never reaches the physical decoder registers: those
are read through a read-only region and are excluded from the direct BAR
mapping, so the guest cannot move the host physical window.


HDM region access
-----------------

The HDM region carries the coherent device memory. A VMM mmaps it and
maps it into the guest through stage-2. The fault handler inserts the
host PFNs, including PMD-sized mappings when the mapping is aligned, only
while the committed decoder is in place and the media is ready.
Otherwise the fault gets SIGBUS. Region read and write check the same
state and return -EIO while the region is out of use. The range has no
struct page and is registered with the memory-failure machinery, so a
memory error is contained to a SIGBUS.


DMA and iommufd
---------------

Some accelerators, for example a GPU, send ATS-translated DMA to their
own HDM, so that range must be in the guest IOAS. IOMMU_IOAS_MAP cannot
pin a range with no struct page. VFIO_DEVICE_FEATURE_DMA_BUF on the HDM
region returns a dma-buf fd that iommufd maps with IOMMU_IOAS_MAP_FILE.
vfio-cxl revokes the dma-buf whenever it takes the region out of use.
iommufd then unmaps the range, and the VMM maps the same dma-buf again
once the region is back.


Reset
-----

An FLR does not reset CXL.cache or CXL.mem state and does not clear
device memory (CXL r4.0 sec 9.5), so it cannot separate one user of the
device from the next. vfio-cxl runs CXL Reset with Memory Clear at every
vfio reset point: open and close, VFIO_DEVICE_RESET, a guest FLR through
config space, and the guest's Initiate CXL Reset doorbell. Under
memory_lock, with the HDM mmap zapped and the dma-buf revoked, the host
invalidates the CPU caches for the HDM range, resets the function,
restores the decoder and the PCI config state, and invalidates the
caches again. vfio-cxl then waits for Memory_Active before it puts the
region back.

A CXL port masks SBR by default (CXL r4.0 sec 8.1.5.2). The PCI core now
refuses a bus or slot reset below such a port, so the vfio hot reset
ioctls fail and a VMM uses VFIO_DEVICE_RESET. If the port has SBR
unmasked, the hot reset decommits the decoder, and vfio-cxl restores it
in reset_done with cxl_restore_state_after_pci_reset(), the helper the
PCI core's cxl_bus reset method uses.


Low power
---------

The device may enter D3hot or runtime low power while it is assigned.
Low power loses the committed decoder, so vfio-cxl takes the HDM region
out of use first and restores the decoder when the device is back in D0.
Device memory is not saved or restored across low power.


Deferred
--------

  - Switched, multi-decoder and interleaved topologies stay rejected at
    bind.
  - Decoders that firmware did not commit are not supported.


Validation
----------

  - Each patch builds with W=1 (drivers/cxl, drivers/pci and
    drivers/vfio/pci, x86_64, VFIO_CXL=m).
  - scripts/checkpatch.pl --strict --codespell reports no errors or
    warnings. Patch 16 has one CHECK, a missing blank line between two
    inline stubs, kept to match the other stubs in vfio_pci_priv.h.
  - The selftest, tools/testing/selftests/vfio/vfio_cxl_type2_test.c, has
    27 tests: the device flag and regions, the HDM mmap and huge fault,
    the decoder register region and its -EIO gate, the dma-buf map with
    IOMMU_IOAS_MAP_FILE, region read and write across pages, the DVSEC
    reset doorbell, and the decoder after a D3hot cycle. All 27 pass on
    an arm64 host with 64K pages and lockdep (PROVE_LOCKING) enabled.
  - A guest with the device assigned booted, ran CUDA and unified memory
    workloads, and reset the device twice through guest CXL Reset through
    guest sysfs reset file and by using the CTRL2_INIT_CXL_RST in the
    guest. (used with QEMU vfio-cxl support v2 [6]).


AI assistance disclosure
------------------------

This series was developed with substantial AI assistance (Anthropic
Claude, through the Claude Code CLI). It was used for design trade-offs,
multi-agent regression and adversarial review of the v5 feedback using
review-core.md, the port to cxl_reset v15, analysis of the hardware
failures, and drafting the selftests and the documentation.
Following Documentation/process/coding-assistants.rst, each patch
carries an Assisted-by: LLM tag. I ran the tests on hardware, have
reviewed every change, and take full DCO responsibility for the series.


References
----------

[1] [PATCH v10 0/3] Support zero-sized HDM decoders
https://lore.kernel.org/all/20260914090858.19181-1-icheng@nvidia.com/

[2] [PATCH v15 00/16] PCI/CXL: Add CXL reset support for Type 2 devices
https://lore.kernel.org/all/20261011021422.3428136-1-smadhavan@nvidia.com/

[3] [PATCH v3 0/2] Add SMCCC cache clean/invalidate provider
https://lore.kernel.org/all/20260910082142.1522865-1-smadhavan@nvidia.com/

[4] [PATCH v4 0/2] Add SMCCC cache clean/invalidate provider
https://lore.kernel.org/all/20261013070205.3566865-1-smadhavan@nvidia.com/

[5] [PATCH v5 0/27] vfio/pci: Add CXL Type-2 device passthrough support
https://lore.kernel.org/all/20260916183540.3813685-1-mhonap@nvidia.com/

[6] [PATCH v2 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
https://lore.kernel.org/linux-cxl/20260916184412.3825713-1-mhonap@nvidia.com/

Manish Honap (31):
  cxl/regs: Split the BAR block request and ioremap helpers
  cxl/regs: Let a BAR-owning driver own the component register block
  cxl: Move component register defines to uapi/cxl/cxl_regs.h
  PCI/CXL: Let the driver that owns the HDM range run CXL Reset
  PCI: Refuse bus and slot reset below a CXL port with SBR masked
  vfio/pci: Add the CXL provider ops registration interface
  vfio/pci: Detect CXL devices and load the CXL provider on demand
  vfio/pci: Add a generic excluded-range list
  vfio/pci: Advertise the mmap areas around excluded ranges
  vfio/pci: Refuse ioeventfds and dma-buf exports over excluded ranges
  vfio/pci: Virtualize the CXL DVSEC in vfio_pci_config.c
  vfio/pci: Call the CXL open and close hooks around device use
  vfio/pci: Bracket PCI resets with the CXL reset hooks
  vfio/pci: Provide an opt-out for the CXL Type-2 extensions
  vfio/pci: Route every reset point through a try-reset helper
  vfio/pci: Revoke and re-arm one device-specific region
  vfio/pci: Call the device provider across low-power transitions
  vfio/cxl: Add the vfio-cxl provider module skeleton
  vfio/cxl: Create the CXL memdev and set media ready at bind
  vfio/cxl: Own the whole component register BAR
  vfio/cxl: Expose the HDM memory region to the guest
  vfio/cxl: Allow mmap of the HDM memory region
  vfio/cxl: Contain HDM memory errors with memory_failure()
  vfio/cxl: Expose the HDM decoder registers read-only to the guest
  vfio/cxl: Exclude the HDM decoder registers from direct BAR access
  vfio/cxl: Restore the HDM decoder after a hot reset
  vfio/cxl: Describe the CXL device and decoder geometry to userspace
  vfio/cxl: Export the HDM memory region as a dma-buf
  vfio/cxl: Run the CXL reset at the vfio reset points
  Documentation: vfio-pci: Document CXL Type-2 device passthrough
  selftests/vfio: Add CXL Type-2 passthrough tests

 Documentation/driver-api/index.rst            |    1 +
 Documentation/driver-api/vfio-pci-cxl.rst     |  312 +++++
 MAINTAINERS                                   |   10 +
 drivers/cxl/core/hdm_state.c                  |   22 +-
 drivers/cxl/core/regs.c                       |   64 +-
 drivers/cxl/cxl.h                             |   47 +-
 drivers/pci/cxl.c                             |  136 +-
 drivers/pci/pci.c                             |   31 +-
 drivers/pci/pci.h                             |   18 +-
 drivers/vfio/pci/Kconfig                      |    2 +
 drivers/vfio/pci/Makefile                     |    2 +
 drivers/vfio/pci/cxl/Kconfig                  |   11 +
 drivers/vfio/pci/cxl/Makefile                 |    3 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c          | 1124 +++++++++++++++++
 drivers/vfio/pci/vfio_pci.c                   |   52 +-
 drivers/vfio/pci/vfio_pci_config.c            |  225 +++-
 drivers/vfio/pci/vfio_pci_core.c              |  747 ++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  183 ++-
 drivers/vfio/pci/vfio_pci_priv.h              |   20 +
 drivers/vfio/pci/vfio_pci_rdwr.c              |   76 +-
 include/cxl/cxl.h                             |    2 +
 include/cxl/hdm.h                             |    3 +-
 include/cxl/pci.h                             |   42 +
 include/linux/vfio_pci_core.h                 |   92 ++
 include/uapi/cxl/cxl_regs.h                   |   56 +
 include/uapi/linux/vfio.h                     |   24 +
 tools/testing/selftests/vfio/Makefile         |    1 +
 .../vfio/lib/include/libvfio/iommu.h          |    3 +
 tools/testing/selftests/vfio/lib/iommu.c      |   29 +
 .../selftests/vfio/lib/vfio_pci_device.c      |   57 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 1095 ++++++++++++++++
 31 files changed, 4306 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 include/uapi/cxl/cxl_regs.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

-- 
2.53.0

