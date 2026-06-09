Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23B3F86F2
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001908; cv=none; b=KazPaXBBpuIL81xEzmJluiMmmbs4a9GBx4GXCNAeSZXetv3S0PNJzrsrFSIj8lFLpwjimwrUtyT5Mdj1bB6/zRsj+NZNveHEObbaad3ejSbt4n53qZMeselPTAPZfLU2PdUFmfPptVzYoMVxxO+IxftsTaxNPVt4cTYrqA39LyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001908; c=relaxed/simple;
	bh=Dk/Oy8PzO6WqaSH/b3savAbPbko7yk/VY5Jl6lUJCuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QcAiMHREbFjS3onk8DZKtuZMnwb971qobqPPOhQQ//OrFb4kIzK/lnyCeY3R3eJHXk/Es7KXnL9zzR2hu9i3XNY3jYj/Ivr8VtcIE1vWyzT6rX0Qmww0QWnBRmVPX+3zcIvjYW9zRFN/z6Hr0WQAeam+eya86BO1bVtU+dpGNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UEowRL/I; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UEowRL/I"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260609104456epoutp033358aa28108bb67b8eacd2e13b6c6e3a~3Y8nOcKQK3082530825epoutp03S
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260609104456epoutp033358aa28108bb67b8eacd2e13b6c6e3a~3Y8nOcKQK3082530825epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001896;
	bh=LD8d5vmHP5Tmxkon0tBgZOgyWGJtg9xPIXNJ9p4pfUU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UEowRL/IO1mb1NFv6qonmwWKW7RD82awJOQ/5kXMBMwi5r+Mx2LHE/jnsmes3hRUI
	 IVUZqND9Fjq8rAJJJAaijCI0js6Qrq3currFXyMjtAt1eXA7sB6grujJcN4SnSc9yz
	 4Q4oCJVqmUGnW9x+EFfvd5t1eIfDwKJ/yfwoL9fM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260609104454epcas5p1be3e2032128ca29ed7051659822a91bd~3Y8mI0_uf2102621026epcas5p1E;
	Tue,  9 Jun 2026 10:44:54 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gZQXQ0xqfz6B9m6; Tue,  9 Jun
	2026 10:44:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260609104453epcas5p327a974e978790e693c0660f27f9b43ef~3Y8kh5-iA0141601416epcas5p3R;
	Tue,  9 Jun 2026 10:44:53 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104451epsmtip192722d3df57cbe3b1616dcc4e762275c~3Y8i1PTG32095220952epsmtip1l;
	Tue,  9 Jun 2026 10:44:51 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 0/8] pci: cxl: Add enumeration support for Unordered I/O (UIO)
 feature.
Date: Tue,  9 Jun 2026 16:28:28 +0530
Message-Id: <20260609105836.3702787-1-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104453epcas5p327a974e978790e693c0660f27f9b43ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104453epcas5p327a974e978790e693c0660f27f9b43ef
References: <CGME20260609104453epcas5p327a974e978790e693c0660f27f9b43ef@epcas5p3.samsung.com>

This series introduces enumeration and configuration support for the
PCIe Unordered I/O (UIO) feature across standard PCIe and CXL ports.
UIO, introduced in PCIe 6.1, relaxes strict transaction ordering rules. UIO is
a PCIe transaction layer enhancement which shifts the ordering control from
fabric to the requester device.

This implementation establishes the essential architectural foundation
required for the OS to discover, negotiate, and configure UIO
capabilities.

UIO in CXL follows CXL.io protocol, where a CXL device can send read/write
request to peer .mem device's HDM decoder at fabric level.

      __________________________________________
     |                                          |
     |              CXL Host Bridge             |
     |              (Root Port/RC)              |
     |__________________________________________|
                         |
      ___________________|______________________
     |                                          |
     |               CXL Switch                 |
     |__________________________________________|
        |                  |                 |
     ___|____           ___|_____         ___|____
    |        |         |         |       |        |
    | Dev A  |         | Dev B   |       | Dev C  |
    | (Req)  |         |(Target) |       |(Target)|
    |________|         |_________|       |________|


For example, consider the topology shown above, in that if the requester device
(Dev A) wants to read data from the target device (Dev C), then Dev A can
prepare UIO command with the targeted HPA of Dev C and can send directly to the
Dev C's HDM decoder at switch level. Here host gets bypassed in the data path.
For this to happen, both the devices and the intermediate fabrics should support
UIO and its dependencies.

The implementation relies on two key dependencies:
    - 256B Flit Mode 
    - Streamlined Virtual Channel (SVC) Extended Capability (from PCIe 6.1)

Key changes include:

SVC Capability: Introduced a new hw/pci/pcie_svc.c module to manage the SVC
                extended capability. It handles the mapping of UIO traffic to
                dedicated virtual channels-VC3 (mandatory) and VC4 (optional).

Port Configuration: Added properties (x-uio-svc, x-uio-svc-opt, x-256b-flit) to
                    PCIe and CXL ports to control UIO states.

CXL Integration: Established a dependency chain in CXL root and upstream ports,
                 where UIO is enabled only if both Flit Mode and SVC initialization
                 succeed. The CXL HDM decoders now advertise UIO support per CXL 4.0
                 specifications.

Patch Layout:

Patch 1 and 2: Refactoring: Move Flit mode handling from PCIe slot to PCIe port
               and extend it to all port types.
Patch 3: Properties: Add SVC capability fields and UIO-related properties
         (x-uio-svc, x-uio-svc-opt) to the PCIe port hierarchy.
Patch 4: CXL Properties: Extend SVC properties to CXL ports and add uio_capable
         logic to root/upstream ports.
Patch 5: CXL HDM Decoder: Integrate UIO capability advertising into CXL HDM 
         decoders.
Patch 6: SVC Module: Implement the core PCIe SVC Extended Capability logic
         in pcie_svc.c.
Patch 7: Integration: Hook SVC initialization into the realize functions
         for all PCIe and CXL ports.
Patch 8: Documentation: Add usage examples for UIO-enabled CXL topologies.

Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
Repository: https://gitlab.com/jic23/qemu
Branch: cxl-2026-01-09-draft

Testing: Verified through Linux kernel based enumeration and configuration.

Future work: While the current series establishes the configuration
infrastructure, the upcoming series focuses on UIO data transfer support.
A subsequent patch series to be built on top of this series to add support for
UIO data plane.

Shrihari E S (8):
  Refactor flitmode from PCIESlot to PCIEPort.
  Move 'x-256b-flit' property from cxl_root_port to pcie_root_port.
  Add SVC capability and UIO properties to PCIe ports
  Add Streamlined Virtual Channel (SVC) property to CXL ports
  Wire UIO capability into HDM decoder registers
  Add PCIe Streamlined Virtual Channel (SVC) capability.
  Wire SVC initialization into port realize functions.
  Add documentation for UIO-enabled CXL devices

 docs/system/devices/cxl.rst               |  50 +++++++
 hw/cxl/cxl-component-utils.c              |  29 +++-
 hw/mem/cxl_type3.c                        |   9 +-
 hw/pci-bridge/cxl_downstream.c            |  11 +-
 hw/pci-bridge/cxl_root_port.c             |  13 +-
 hw/pci-bridge/cxl_upstream.c              |   9 +-
 hw/pci-bridge/pci_expander_bridge.c       |   3 +-
 hw/pci-bridge/pcie_root_port.c            |   4 +
 hw/pci-bridge/xio3130_downstream.c        |   4 +
 hw/pci-bridge/xio3130_upstream.c          |   9 ++
 hw/pci/meson.build                        |   2 +-
 hw/pci/pci.c                              |   4 +
 hw/pci/pcie.c                             |  53 ++++++-
 hw/pci/pcie_svc.c                         | 164 ++++++++++++++++++++++
 include/hw/cxl/cxl_component.h            |   2 +-
 include/hw/cxl/cxl_device.h               |   2 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   7 +
 include/hw/pci/pcie_port.h                |  23 ++-
 include/hw/pci/pcie_regs.h                |   1 +
 include/hw/pci/pcie_svc.h                 |  91 ++++++++++++
 21 files changed, 466 insertions(+), 25 deletions(-)
 create mode 100644 hw/pci/pcie_svc.c
 create mode 100644 include/hw/pci/pcie_svc.h

-- 
2.34.1

