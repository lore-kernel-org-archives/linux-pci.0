Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792293;
	b=dEPiphq2ulzzwjlGs/kP9Y9qPWICtEUuKcciE8Rf4C9F1wrWGFt031+sQYjAVWE5SwKN
	 c4KLqoO1bNbMWO/IhTbePiV5nN6QKT5gQNj5AncpAzJhkzGzE7y1v1NEvWjXmJ8VvG70W
	 E5tRihogBP+2Vt+Cmoq9WH2F5u4CS2bF/YOFmUDVz24qy18UEhVRmp7399wxA7dk+0vMA
	 LuQugNLSIBXzW/c9kEba229awezNKqsyvGFszYyxSf5J6ovHmRA0m7pdSE4RQnr97BylV
	 nZOYZSiHHsob+IqkeHSnYVcWQMWhDy09oQLbpxi3rG7pXCyRwxwZfIVjKp1TWXAhHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792293;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:X-Hop-Count:
	 X-CMS-RootMailID:References;
	bh=zmRKQpwya0WeDnkSLxH41WMnOGAOdo1z/9sxMtTqa8s=;
	b=29uB0PWxxN6BXMOAifleVqbSj9CdPlKh3odfFcrH4w/oJCIzdk+b2AnJzY6LU5MHIFIg
	 abkZ4k2GKZgSrhBt/DU4QjEmOUlM+z394LsQD2FE9jCcWM++sUs7E6XsFUxUmwi5HTidS
	 krwq0bu7n7ON7BFJUTHExNpmfJ7S3ZJBbVu0ML4DKqKao/J01WdrC5l6md5VDzSZzhFkY
	 SsCuDpnZeYk678pfWKuRvZ54RZUxhkipyIZnjk7Q8tgeU0idhP7sficWrjXCP0dsvKIp1
	 Z+mMQsFm42G0Ql5BgtC2UzxD7A/hts66csGORPJYm8ZJPt+GQhBtPM2FhNZwY9FCnig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OAPrPy3U;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE8606D81E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57CE8606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OAPrPy3U
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp046afbda9f07857b7de69fa303c680af54~k1JQanXG62603026030epoutp04F
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261104113804epoutp046afbda9f07857b7de69fa303c680af54~k1JQanXG62603026030epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=zmRKQpwya0WeDnkSLxH41WMnOGAOdo1z/9sxMtTqa8s=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OAPrPy3U9DD/q4Zmn4QgcYU0ya99z9eegJ3uA442BIQaMIf1yIvyr/cnMFz2Lseho
	 7ioRjNf5FeUerelLsFgO8uLm0+jzoO5Jy9on0tnUcgGFnljuNQT9vQs3dN9nfnZU5+
	 n53yUJrbSHtGenjYqLcfxgrxk4Q4xP6YX7SARNh8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261104113803epcas5p2341017fcd80d69eead253b606b64cbb0~k1JPqDB111368413684epcas5p2e;
	Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jKNjR2Ftdz3hhT3; Wed,  4 Nov
	2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5~k1CQXdYBE1209212092epcas5p4P;
	Wed,  4 Nov 2026 11:30:03 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113000epsmtip1897ed5d551fbd717aefacc52fc6e28b6~k1CODHj-72358823588epsmtip14;
	Wed,  4 Nov 2026 11:30:00 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 0/8] hw/pci: hw/cxl: Add UIO support in CXL and PCIe
 stack.
Date: Wed,  4 Nov 2026 17:22:34 +0530
Message-Id: <1582071873.61793792283310.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5
References: <CGME20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5@epcas5p4.samsung.com>

Hi All,

This is the v1 of the "UIO feature enablement in Qemu" series, a
follow up of RFC V2 [1] with the review comments addressed. The
series adds enumeration and configuration support
for the PCIe Unordered I/O (UIO) feature across the standard PCIe
and the CXL stack of QEMU, and establishes the foundation for the
OS to discover, negotiate and configure UIO capabilities on CXL
ports and devices.

UIO is a transaction layer enhancement that relaxes the strict
transaction ordering rules of PCIe and moves the ordering control
from the fabric to the requester. UIO, introduced from PCIe 6.1,
in CXL follows the CXL.io protocol, where a device sends read and
write requests directly to the HDM decoder of a peer .mem device
at the switch level and the host is bypassed in the data path. For
that, the requester, the completer and the intermediate ports of
the topology carry the UIO dependent capabilities:

    - 256-byte flit mode
    - Streamlined Virtual Channel (SVC) Extended Capability
    - PCIe Device 3 Extended Capability

In the example topology below, Dev A is the requester, Dev B and
Dev C are the completers, and the root port and the switch ports
sit in the data path as the intermediate ports:

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

With all the dependent capabilities enabled on Dev A and Dev B and
on the ports of the path between them, Dev A issues its CXL.io
read and write requests to the HDM decoder of Dev B on the UIO
virtual channel: the switch routes the requests from the
downstream port of Dev A to the downstream port of Dev B, and the
root port and the host bridge are bypassed in the data path.

V1:

    - x-256b-flit defaults to off on all port types, keeping the
      config space and migration state compatible.
    - x-uio is moved to the pxb-cxl host bridge; the CXL type 3
      device warns and leaves UIO disabled at realize time when
      x-uio is set without x-svc and x-256b-flit.
    - SVC validates the Protocol Selected field of a guest's
      Resource Control writes against the resource capability.
    - The Flit Status bit of the Link Status 2 register is derived
      again after a device reset, so it stays consistent with the
      Flit Disable bit of the Link Control register.
    - Series reduced from 10 to 8 patches; properties are defined
       in the patches that use them.

RFC V2:

    - The Device 3 capability is added to the PCIe stack and wired
      to the CXL type 3 device.
    - The UIO related DVSEC registers are added to the CXL stack.
    - UIO becomes a generic capability instead of being tied to the
      type 3 device.
    - The SVC capability is extended to the CXL type 3 device, and
      the x-svc and x-uio properties are added.

Contents
--------

New properties:

    - x-256b-flit: enables 256-byte flit mode signaling (Flit
                   Mode Supported, Flit Status), as an extension
                   of the implementation from Davidlohr Bueso's
                   patch series [2]. Accepted by all the ports
                   derived from PCIEPort and by the CXL type 3
                   device. Defaults to off.
    - x-svc: adds the SVC capability to a port or to the CXL
             type 3 device.
    - x-uio: carries the UIO capability. On the pxb-cxl host
             bridge it marks the root ports within the host
             bridge as UIO capable; a CXL root port advertises
             UIO when its parent host bridge carries x-uio and
             its own x-svc and x-256b-flit are set; the CXL
             type 3 device carries the UIO capability, with the
             Device 3 capability, when x-uio, x-svc and
             x-256b-flit are all set.

Patches:

1) Refactor the flitmode field from PCIESlot to PCIEPort and
   default the x-256b-flit property to off.
2) Move the x-256b-flit property from cxl_root_port to
   pcie_root_port.
3) Wire the UIO capability into the HDM decoder and DVSEC
   registers, and add the x-uio property to the pxb-cxl host
   bridge.
4) Add the PCIe Streamlined Virtual Channel (SVC) extended
   capability.
5) Wire the SVC initialization into the port realize functions.
6) Add the PCIe Device 3 extended capability.
7) Wire the SVC and Device 3 capabilities to the CXL Type 3
   device.
8) Add documentation for the UIO options with an example
   topology.

Testing:

Linux kernel enumeration on a q35 topology with a CXL switch and
three type 3 devices: SVC and Dev3 capability discovery, HDM
decoder UIO bits, flit mode status and the per-VC state of the
UIO enablement path.

Linux kernel series for this work is maintained separately and
follows later.

This series has been written on top of:

Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
Repository: https://gitlab.com/jic23/qemu
Branch: cxl-2026-01-09-draft

Future work:

Provide UIO requester capability to the CXL Type 2 device for E2E testing.

Thanks!

References
[1] https://lore.kernel.org/qemu-devel/1212772528.01787732102473.JavaMail.epsvc@epcpadp1new/
[2] https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/

Shrihari E S and Dongjoo Seo (8):
      hw/pci: Refactor flitmode from PCIESlot to PCIEPort
      hw/pci: Move 'x-256b-flit' property from cxl_root_port to pcie_root_port
      hw/cxl: Wire UIO capability into HDM decoder and DVSEC registers
      hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability
      hw/pci: Wire SVC initialization into port realize functions
      hw/pci: Add PCIe Device3 capability support
      hw/cxl: Wire SVC and Dev3 capabilities to CXL Type 3 device
      cxl: Add documentation for CXL UIO support


 docs/system/devices/cxl.rst               |  54 +++++++-
 hw/cxl/cxl-component-utils.c              |  55 ++++++++-
 hw/mem/cxl_type3.c                        |  36 +++++-
 hw/pci-bridge/cxl_downstream.c            |  18 ++-
 hw/pci-bridge/cxl_root_port.c             |  37 +++++-
 hw/pci-bridge/cxl_upstream.c              |  26 ++++-
 hw/pci-bridge/gen_pcie_root_port.c        |   3 +
 hw/pci-bridge/pci_expander_bridge.c       |  17 ++-
 hw/pci-bridge/pcie_root_port.c            |  15 +++
 hw/pci-bridge/xio3130_downstream.c        |   6 +
 hw/pci-bridge/xio3130_upstream.c          |  19 +++
 hw/pci/meson.build                        |   2 +-
 hw/pci/pci.c                              |   7 ++
 hw/pci/pcie.c                             | 105 ++++++++++++++++-
 hw/pci/pcie_dev3.c                        | 111 ++++++++++++++++++
 hw/pci/pcie_svc.c                         | 185 ++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_component.h            |   2 +-
 include/hw/cxl/cxl_device.h               |   2 +
 include/hw/pci-bridge/cxl_upstream_port.h |   2 +-
 include/hw/pci/pci_bridge.h               |   1 +
 include/hw/pci/pcie.h                     |  11 ++
 include/hw/pci/pcie_dev3.h                |  26 +++++
 include/hw/pci/pcie_port.h                |   6 +-
 include/hw/pci/pcie_regs.h                | 100 ++++++++++++++++
 include/hw/pci/pcie_svc.h                 |  20 ++++
 25 files changed, 832 insertions(+), 34 deletions(-)
-- 
2.34.1

