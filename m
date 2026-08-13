Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EC439321;
	Thu, 13 Aug 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613868; cv=fail; b=o5st1W/9gOaiFhlmBtAhU+KfR3FpVzN/c1j1csWFm7285OsIxLKzMEzDxhFrhWN7rXcjxo5iIqp8cK2210kZ5HMRs4u40kXFkN4O057kK0P1RllhsXrBndnQZFvTQJ7za0Y3g6zCu5qPeKSoI0w/afeguLp03995sKMN5LLAVOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613868; c=relaxed/simple;
	bh=9i1v49atsleShmqc/DXwvQi5HWIvXM0yiK8/oEnCcfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FvjVfO+Es6yQu9TA0wiQIDgphwv1qVy3/VTkc8HtqLzDHLUCS/rGjbFRLP4tvOHyReAMGFnT+d0y2GXKiUozHAsP6ELAzPHIS51NL05o5xft5CpFESQwmpL/FlddmSS7aZvqQCxPPR2JoN3csYOrhC7+/kSbWp7A/OHvuK9XrhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lmtmI54d; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lmtmI54d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP/Q+u50uVeXlqHqHxHw5sJZwlgDXvLZPMHD88UnJP2Ii6PYFDbsV8Ej6HM+EGOpWT9knyI+4+XxUWwGeRKERLpbBRbDtcLWmIECeoRiZviv7UilNEGDbcRcLoKIE/IcZAy340KUI0cl7Szxv/SleD7AR5XHruY8R0ORclw/63+DGvsQ4PqPdWVtV9Jc35duTiBiesVLQWQF+nodOIws91VeUQ5ssn5gXeccZ7hCLJ8GXTPJR6i0xC81MP5eUG4iXpgYygxZJ0ewK52oZVVdTr3TFb0GKEeydf9M1jsrgvZwRyG9DlUvoB3jslosOUkmxkPoNCMxUl2D6RYZOtdjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y444qa+MWzEy87JGO9a4gBf2PTGdGgOFQZ1w3jMC1eg=;
 b=K7paw3DdW2piW+A9yh1A1jQ0r4HXMRsnls6KwiOUkVIfhqiV9Iej9IMO3gxgxjnQAZl7gLnIMynErxvVyaDDAQyoiZ4M1VMypIrkaK7jlyW+IpbO1etu39E5AF8sQ7PT+LSL5z7ir8b1u8cwCdlu6j+wWtPrTYf2K55Ka9mOaNWtauMlgXTQvBWeMXAkDClTLoZUWmW1xb4spOZs1xTFJ6lIpjol45ZazYbBtQSptB7GMFks8ti/CpfgeWQ1jh22WPnJ1GZZ+w+oapmI8H/w3+d5TcMH8l5uhFJ9wPR7jD1EmHPLiWaOnCxaGpfaeLcPhkZuzx+lOE62friw8rBkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y444qa+MWzEy87JGO9a4gBf2PTGdGgOFQZ1w3jMC1eg=;
 b=lmtmI54dNmYq1m/F9bWICTttSZdX11NdT9GSIhzbn2vCudRcDxyaua7lz3fXZEknq42UaUcA82GwfB9YGVESI3hM3QmOj828x5JtpAkHXOmtwy44LXYOoewDXb6dBdzPqEZtmJ0Ni9mML+xhN9GA2hQvE4on+ahPOj69YimFUvjVaQFViCppo10ntgD1mh7/+PzdyV4QWsIzGgmA4GEWsr+pnTzd4h0lUL91t4QM9zeWFq8zO/h7zCqZZoM0W/MJ3DOiBOlFqC+kszUVxXTKaQNSEU6bxatvfQwxp3GbKfqkS3M6fWp5dxnH02H/P33Vi16MLJj7dI3lozd4AN+1gQ==
Received: from BN9PR03CA0548.namprd03.prod.outlook.com (2603:10b6:408:138::13)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:37:29 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::6a) by BN9PR03CA0548.outlook.office365.com
 (2603:10b6:408:138::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Thu,
 13 Aug 2026 09:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:37:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:12 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:02 -0700
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
Subject: [PATCH v4 00/27] vfio/pci: Add CXL Type-2 device passthrough support
Date: Thu, 13 Aug 2026 15:06:04 +0530
Message-ID: <20260813093631.2288172-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a299afb-0ffa-4c06-ba3b-08def91e7e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|18002099003|56012099006|11063799006|5023799004|13003099007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	sty9GVl8U88Y7syOEGHXEvBVpbmuN6VMCfnYa3Uinm2JQTtJTcsnPvrCAXs0CfmJ2BUmhOnsMQcTsYYbtF76I42IraNO/rEYc0pfRUK4mtU+e6J+w4AwB+YWv3nln6b8G/uyOqkO69xnqkpBySVxr8HJARP4CghP/pTsN13GNEEdDxYqZKC2VN9Lrsx2qJKSAnYzocIwSTJwSTOvtI/yEHSbW1JCENBpM/4TD363/q+dkx/HeOYPr8O4ysVCFIlOiS9DX4Nt37r53tplDSu6rEDtxsvONUzYcurHZ9g1kzGfDFNoi28Td4kctqy8zv01Kx+JYPpYQRVzW/+wecF1zsUy7l8hl0kCubxcpsAgDXRBYMspGUnWKS5ggr544sttlYQlPbvG77NUDyL4vAD42FlF6WlUP+3cz7kl7zsoJwjMizUGOFnXeqxo8h19/9YNxq2yG/4LUDjFzUbUDyCQc1Q1lr77mvnpvNIOTmlfR842sulw7XYAyiyfNHv32oOkQzWz3RHFYJVVPZxFHnMhm3fFKzUdEV2jVrLGiXDdp2HdIIGm6fGE81+3ji1ltHTf0FOPXARPySieH5o7MGCK9GzlVTR5jlaXbMIlQ47uS806DAgqvjIMB7ShC2VAHYbBjPn2XURoPgCtXWlQPLy6hO8PvB/JDbcqJy3KAzPHCE0jHQtu3LLP8xL3bPsYqiIlkdzi2haikr5SiWBBUuCxgaObSkg3vO/wRGR5uiO5bzaQ73s5AM6ujwq9Pcz5/dNG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(5023799004)(13003099007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R72/cOaA9fDMeo7NiOSAmBwTak36HdByUmeQHKbjR2W8y58Glr0dIVHwBaSsOdsy7T9VaYKO0wjqsII4oYBPK75D+w986ZHWJ/wqIcBQ7c8UdUip4Ur7q+95MPEb4X3CSQ8TA9PEVBgU7qH7f0w1q7NqIOtZyv+5xb/nh6XZIkcK6Ta++YwVC5po1WUB2wxFNb9CXT8/ql5Umd0aW03Q+zTY2UFQlMa/UBL4+6CnYUqoMFF7MC6PGSZO77I1vU/Nv9etQSkbQPQ2GA22n9o/wOqRRkJ87JPSqQECxX8rflpAzbgjL4pW793l9zj/t9O83v5PiVLHQmKoOBfmpznIslDXV4FL9sEBYMffS33rxnF0IH94LTdEntgpBk2PYfB+m0hbRrjtkgrSyOcKCr6fs8Y8dxsbv7ziKiguBxpHv6stesuikGX7psGFQAMMQi57
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:37:29.1559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a299afb-0ffa-4c06-ba3b-08def91e7e1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

From: Manish Honap <mhonap@nvidia.com>

This series adds VFIO passthrough for CXL Type-2 accelerators. The guest
drives its own virtual HDM decoder and can reset the device. The host
owns the physical decoder and the host physical address the memory
lands at. The guest only picks a guest physical address. This series is targeted
towards a single, non-interleaved endpoint decoder.


Base and dependencies
---------------------

  Base: Linux Stable 7.2-rc6, plus the two dependencies below

  Depends-on:
    - cxl_set_capacity() and include/cxl/pci.h from Alejandro's
      "Type2 device basic support" v30 [1]
    - CXL reset core from Srirangan's cxl_reset series (v10) [2],
      which caches the decoder programming in pdev->hdm and keeps the HDM
      decoder and reset helpers in drivers/cxl/core/resource.c. Part 1 adds
      a function-scoped reset entry (cxl_reset_dvsec_sequence) on top, and
      Part 4 builds on it.


Changes since v3
----------------

v3 [3] kept the register virtualization in cxl-core, behind an opaque
cxl_passthrough handle that exported four helpers, with vfio-pci as a thin
transport. v4 turns that around. The register emulation lives in vfio-cxl, a
separate module vfio-pci-core loads on demand, and cxl-core keeps only the
reset entry and a few enabling helpers. The patch count grew from 11 to 27,
most of it the reset handling v3 left out of scope.


Reviewer feedback addressed
---------------------------

The v3 [3] thread has the full discussion; this is where each objection landed.

Dan Williams
  - Register emulation moved from cxl-core into vfio-cxl; the opaque
    cxl_passthrough handle and drivers/cxl/core/passthrough.c are gone.
  - The lock-on-commit FSM is fixed: a committed and locked decoder ignores
    further control writes until a reset, and the commit bit is not cleared
    while locked.
  - HDM mmap handles huge pages; the fault handler inserts the HPA pfn at the
    largest aligned order.
  - The BAR sub-block request is skipped through a flag on the cxl-core
    register map (a BAR-owning driver leaves the sub-blocks unclaimed), not a
    workaround on the vfio side.
  - HOST_FIRMWARE_COMMITTED is dropped; a present cap already implies a
    committed decoder, since bind fails without an active one.
  - cxl_get_hdm_info() is dropped in favour of reading pdev->hdm.
  - Style items are applied: the module lives under drivers/vfio/pci/cxl/, it
    reuses the register defines from pci_regs.h and cxl.h, and it cleans up
    with devm_add_action_or_reset().

Alex Williamson
  - vfio-pci does not statically depend on CXL; it loads vfio-cxl on demand
    and pins it per bound device.
  - The CXL state is sampled at open_device, not at bind, so a low-power
    transition cannot leave it stale.
  - The device info cap drops the region indices; regions are found by VFIO
    subtype, and the component-register geometry is on the comp-reg region
    info cap.
  - The DVSEC clip shim is replaced by a DVSEC readfn/writefn in ecap_perms
    that range-checks the offset against the stored DVSEC body.
  - vdev->cxl is a typed struct vfio_cxl_state pointer, not void *.
  - cxl_await_range_active() stays in cxl-core; vfio does not call or export
    it, and the cover no longer claims otherwise.

Dave Jiang
  - The base moved to Linux 7.2-rc6 (plus the two named dependencies), so the
    series applies cleanly with b4 (v3 failed on its stated base).

Richard Cheng
  - The host hang on real hardware is fixed. The HDM region is reached through
    an mmap fault that inserts the HPA pfn rather than a memremap(WB) kva, and
    the CXL state is acquired at open rather than at bind.


Patch order
-----------

The patches are ordered so the tree builds at every commit and each
change sits next to the code it depends on. Six groups:

  Part 1  CXL core (patches 1-5)
    - Register-map plumbing so a BAR-owning driver can leave the HDM/RAS
      sub-blocks unclaimed.
    - Component register defines moved to include/uapi/cxl/cxl_regs.h so a VMM
      can consume them.
    - Media readiness established in cxl_mem_probe() so a mailbox-less Type-2
      memdev created through devm_cxl_probe_mem() is not rejected.
    - A function-scoped reset entry for vfio-pci.

  Part 2  VFIO-CXL bring-up (patches 6-13)
    - The vfio-cxl module and its ops-provider hook into vfio-pci-core.
    - The CXL memory device created at bind.
    - A bind-time gate that rejects decoder topologies the emulation does not
      model.
    - Ownership of the whole component BAR.
    - A vfio-pci-core helper for a provider to exclude a BAR sub-range from
      mmap, read/write, and DMA-BUF export.

  Part 3  HDM region and register regions (patches 14-21)
    - The CXL region type, the open/close hooks, the DVSEC shadow and its
      virtualization.
    - The HDM region as an mmap-able region mapped write-back cacheable
      (CXL.mem is coherent) together with the trapped HDM decoder register
      snapshot.
    - The decoder block is kept off the direct BAR mapping.
    - Lock-on-commit decoder emulation, and the UAPI that describes a CXL device
      to userspace.
    - DVSEC virtualization and decoder emulation apply the CXL r4.0 write
      class field by field:
        - Control is programmable
        - Status is write-1-to-clear
        - Capability, Lock and the Range/Base/Size fields keep their firmware
          snapshot or their commit-gated state.
    - The CXL.mem-enable bit in the DVSEC control register is pinned on.
    - A guest store to the decoded window with CXL.mem disabled would fault the
      device and raise a host SError, so a guest request to clear the bit is
      ignored.

  Part 4  VFIO-CXL reset (patches 22-24)
    - HDM mapping revoke across reset and power transitions
    - Decoder snapshot refresh after reset
    - A guest-triggered CXL reset driven from the DVSEC.

  Part 5  CXL opt-out (patch 25)
    - A vfio_pci.disable_cxl module parameter and a per-device
      vdev->disable_cxl bit a variant driver sets in its own .init before
      it calls vfio_pci_core_init_dev().
    - Setting it later, in probe, is too late: the core .init has already
      attached the CXL provider. An admin or a variant driver can keep the CXL
      extensions out of the path and drive the device as plain vfio-pci.
    - Mirrors the disable_denylist opt-out.

  Part 6  Documentation and selftests (patches 26-27)


Subsystem boundary
------------------

vfio-pci-core does not implement CXL registers. vfio-cxl is a separate
module that registers a struct vfio_cxl_ops at init. vfio-pci-core loads
it on demand for a CXL device (request_module plus pcie_is_cxl) and pins
it per bound device. If a modular provider is missing or fails to load,
the device is driven as plain vfio-pci. The bind only defers for the
built-in initcall-order case, where request_module cannot help.

The core exposes only the primitives that have to live in core
(memory_lock, mapping revoke, dma-buf quiesce, and the BAR sub-range
exclusion). CXL-specific work stays behind the ops.


Memory ownership
----------------

The host resolves the host physical address once, at bind, through
devm_cxl_probe_mem(). The memdev is owned for the bind lifetime and torn
down at unbind. The HPA range is claimed IORESOURCE_EXCLUSIVE so no
mismatched cacheable alias can form, including one mapped through
/dev/mem.

The guest programs a guest physical address into a trapped virtual
decoder and polls a shadow for commit. It never reaches the physical
decoder registers. Those are served only through the trap and are
excluded from the direct BAR mapping, so the guest cannot move the host
physical window.


HDM region access
-----------------

The HDM region carries the coherent device memory. A VMM mmaps it and
maps it into the guest through stage-2; that is the access path. The
region advertises READ and WRITE so a VMM can derive an accessible (non
PROT_NONE) mmap protection from those flags, but fd read/write on the
region is rejected with -EIO.

The guest-facing mmap fault maps the pfn directly and does not hit that path.
The flags describe the mmap protection; they are not a promise of fd I/O.

The fault path only inserts the pfn while the decoder is in a known-good
restored state and the device has PCI Memory-Space enabled, so a host
access cannot reach a revoked or disabled decoder.


Reset
-----

A CXL Type-2 device is reset through its DVSEC sequence at every path
that can reset it, not through an FLR. A guest write of
Initiate_CXL_Reset in the CXL DVSEC is trapped, not forwarded. Under
memory_lock, with the HDM mapping revoked and the IOMMU mapping already
blocked, the host saves config, drops Bus Master, runs
cxl_reset_dvsec_sequence(), and restores config with Bus Master still
dropped until the outcome is known. Bus Master is re-enabled only after
a clean reset, so the function cannot DMA over decoders that were not
restored. The guest owns Mem_Clr_Enable. The outcome comes back through
DVSEC STATUS2 for the guest to poll.

The same DVSEC reset is the primary reset method at every vfio-pci-core
site. VM power-on (enable), power-off (close), the VFIO_DEVICE_RESET
ioctl, and a guest FLR emulated through config space all go through a
shared helper.

A bus hot reset rejects a multifunction CXL device. A single-function
one is quiesced through its DVSEC sequence before the secondary bus
reset. Every path revokes the HDM mapping first. The secondary bus reset
clears the physical decoder, so the decoder is restored and the snapshot
is re-sampled afterward, with Bus Master held dropped across the restore
so nothing can DMA over cleared decode. A restore failure is reported
through the reset ioctl; the bus reset's success is not returned in that
case.

A bound CXL Type-2 device is also kept out of idle D3. It is NoSoftRst-,
so a D3hot->D0 transition soft-resets the function and clears the
accelerator memory controller. That can corrupt the coherent CXL.mem the
decoder exposes, and only the accelerator's own driver re-initializes
it. vfio-cxl sets disable_idle_d3 so the host keeps the device in D0
while it is bound, rather than powering it down between opens.


Validation
----------

  - Each patch builds (drivers/cxl and drivers/vfio) and passes
    scripts/checkpatch.pl --codespell --strict with no errors, warnings, or
    checks.
  - The series applies in sequence on the stated base on top of stated
    dependencies.
  - Ran couple of rounds of masoncl/review-prompts on this series before posting.
  - Testing workaround (not part of this series):
     - The HDM region is a VM_PFNMAP RAM-device region, and mapping it into a
       guest IOMMU address space for device-side ATS currently returns
       -EOPNOTSUPP. The in-tree iommufd/VFIO map path does not follow a
       VM_PFNMAP range, so a DMA map of the CXL.mem range is refused (QEMU logs
       it as a non-fatal vfio_container_dma_map ... = -95 warning and continues).
     - To exercise the ATS path on hardware, an out-of-tree workaround that
       bypasses the PFNMAP restriction on the iommufd map path was applied so
       the CXL.mem range could be mapped into the stage-2 IOAS.
     - The selftests and the CPU/coherent guest access paths do not need it;
       only device-side ATS to CXL.mem does.
     - The intended upstream fix is a dma-buf based import of the CXL.mem range
       into iommufd. That will be a separate series.


Follow-on UAPI
--------------

- The trapped component-register region spans the whole HDM decoder block, not
  just decoder 0, so a multi-decoder device needs no new region or cap: a VMM
  reads the decoder count and each committed base from the block itself.
- The COMP_REGS geometry cap keeps a reserved field as a versioning anchor.
- Further trapped surfaces such as CXL RAS are planned as new CXL region
  subtypes (3+) rather than by extending this cap.
- The single committed, non-interleaved decoder is a bind-time policy in one
  place, not an ABI assumption, so in future multi-decoder and switched
  topologies relax only at that place.


Deferred
--------

  - Topology reach. Switched, multi-decoder, and interleaved decoders
    stay rejected at bind.
  - Non Firmware committed decoder system support.


References
----------

[1] [PATCH v30 0/2] Type2 device basic support
https://lore.kernel.org/all/20260629183727.51502-1-alejandro.lucero-palau@amd.com/

[2] [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2 devices
https://lore.kernel.org/linux-cxl/20260804192958.1823952-1-smadhavan@nvidia.com/

[3] Previous version of this patch series
[PATCH v3 00/11] vfio/pci: Add CXL Type-2 device passthrough support
https://lore.kernel.org/linux-cxl/20260625165407.1769572-1-mhonap@nvidia.com/


Manish Honap (27):
  cxl: Fix resource.c include path and export cxl_restore_hdm_after_pci_reset
  cxl/regs: Skip sub-block region request for BAR-owning drivers
  cxl: Move component register defines to uapi/cxl/cxl_regs.h
  cxl: Establish media readiness in cxl_mem_probe()
  cxl: Add a function-scoped reset entry for vfio-pci
  vfio/pci: Add CXL ops registration interface
  vfio/pci: Detect CXL devices and load vfio-cxl on demand
  vfio/cxl: Add the vfio-cxl module skeleton
  vfio/cxl: Create the CXL memory device at bind
  vfio/cxl: Reject unsupported decoder topologies at bind
  vfio/cxl: Own the whole component register BAR
  vfio/pci: Let a provider exclude a BAR sub-range from mmap
  vfio/pci: Refuse read/write to an excluded BAR sub-range
  vfio: Add CXL region type for the HDM region
  vfio/pci: Call CXL open and close hooks around device use
  vfio/cxl: Shadow the CXL DVSEC body at open
  vfio/cxl: Virtualize the CXL DVSEC
  vfio/cxl: Expose the HDM memory and trap the decoder registers
  vfio/cxl: Keep the HDM decoder block off the direct BAR mapping
  vfio/cxl: Emulate the HDM decoder commit handshake
  vfio/cxl: Describe the CXL device and decoder geometry to userspace
  vfio/cxl: Revoke the HDM mapping on reset and power transitions
  vfio/cxl: Refresh the decoder snapshot after a device reset
  vfio/cxl: Service a guest-triggered CXL reset
  vfio/pci: Provide an opt-out for the CXL Type-2 extensions
  Documentation: vfio-pci: Document CXL Type-2 device passthrough
  selftests/vfio: Add CXL Type-2 passthrough corner-case tests

 Documentation/driver-api/index.rst            |    1 +
 Documentation/driver-api/vfio-pci-cxl.rst     |  141 +++
 MAINTAINERS                                   |   10 +
 drivers/cxl/core/pci.c                        |   24 +-
 drivers/cxl/core/regs.c                       |   32 +-
 drivers/cxl/core/resource.c                   |   72 +-
 drivers/cxl/cxl.h                             |   47 +-
 drivers/cxl/mem.c                             |    9 +-
 drivers/cxl/pci.c                             |    4 +-
 drivers/vfio/pci/Kconfig                      |    2 +
 drivers/vfio/pci/Makefile                     |    2 +
 drivers/vfio/pci/cxl/Kconfig                  |   11 +
 drivers/vfio/pci/cxl/Makefile                 |    3 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c          | 1036 +++++++++++++++++
 drivers/vfio/pci/vfio_pci.c                   |    9 +
 drivers/vfio/pci/vfio_pci_config.c            |   42 +-
 drivers/vfio/pci/vfio_pci_core.c              |  478 +++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |   13 +
 drivers/vfio/pci/vfio_pci_priv.h              |   35 +
 drivers/vfio/pci/vfio_pci_rdwr.c              |    8 +
 include/cxl/cxl.h                             |   15 +
 include/cxl/pci.h                             |    2 +-
 include/linux/vfio_pci_core.h                 |   37 +
 include/uapi/cxl/cxl_regs.h                   |   58 +
 include/uapi/linux/pci_regs.h                 |    1 +
 include/uapi/linux/vfio.h                     |   26 +
 tools/testing/selftests/vfio/Makefile         |    1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |   57 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      |  799 +++++++++++++
 29 files changed, 2877 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 include/uapi/cxl/cxl_regs.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.25.1

