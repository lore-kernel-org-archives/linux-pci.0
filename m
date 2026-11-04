Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792293;
	b=IZJ+p8WKNwnBeORg6rc9PKZyi1odLKEnteIEw+8uMzUjm/4OLabRocwtur1hqQ+eJ/WE
	 k/lgitAXlTBJfWB2td+0glQnybuIS/cWocYhSVij53PoD0ZRyHDU/cmn4J+PEzWPRf6bG
	 z0WZgh6ksSAYCKT7/uKV8CEAsVb3W5JX+p7AO8LzplRk1o7KmeVLdxAGQeCXWLZS2BBze
	 vBTgVoEo+JFDondkwqslq/9fHxhxh9AtBZYSvYvCTb4JAuvohCfLxCD1LlzhrYbO81BGU
	 iEz2eIg0cq39TCFFbG1j4SiLJET/U5k8vkWzuA/9jP+M/hahpgsASQUZCSWRCFUpVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792293;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=NyVcsNz9BaNleVG9D4YiuDu9Ylsm4+TjGS9bJaxP2hE=;
	b=RFc5fyN1vWnun9VIDRSGzMFU2ICl1VnyztXo2uCFl5+a5GIs+1Jh6T61jcj9m0h3tyJc
	 dVcznNsOBfOCYhT+Z/Jua65F7IuSoBNOXgQe/q3XU3EdGH5/fzzd0a0taYy+Z+LlQrYaV
	 Qr6tkMG06jcpaaDcwCIc31WSX2vVDoeJ+HNOZ8wdd62j4ELAGEneO/neaGdCGG/Rqpv07
	 kaMmhDSVirIQn3qRFn6LEpKtWRcWr/PvmoaQJzTodx24MXqIKV5DJwoFELUTID0DacxnO
	 wjEV7pKM3iwHVCNBc/dUjFIO7vrlDdCpKCb4LX7s2QuobXWxC4bGh9K0UiIQjAQsPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=YykrjfjU;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B393606EEB3
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B393606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=YykrjfjU
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp01e3c7e1e82626ced661555986c1107963~k1JRJDD9m3066930669epoutp01E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261104113804epoutp01e3c7e1e82626ced661555986c1107963~k1JRJDD9m3066930669epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=NyVcsNz9BaNleVG9D4YiuDu9Ylsm4+TjGS9bJaxP2hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YykrjfjUxS2MguhK96wcZjK2ULQfOuMXuEnuC+InTa1VwSW3FSWZos/iKa2DRaq6M
	 Fciyt0DdLGgtmWpz27d+ffEs1BYpNEB81Tpoyg0Vyjhiw7uUodyN+af8P4VudGAuTP
	 tOFPv77UFWwS2JyKQi8W28JpUBN61CLi9Mp711Jg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261104113804epcas5p3e3b56be9356817670e4492a50ab6a978~k1JQgfzv90585005850epcas5p3M;
	Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jKNjS1f38z6B9m6; Wed,  4 Nov
	2026 11:38:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261104113048epcas5p2e168c5644f42c7b29fa5995b0ec0aeb4~k1C7GJkIU1645616456epcas5p2Q;
	Wed,  4 Nov 2026 11:30:48 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113046epsmtip16d168c9ed39e5d2caa855ba612230a5a~k1C41MbE92318723187epsmtip1E;
	Wed,  4 Nov 2026 11:30:46 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 8/8] cxl: Add documentation for CXL UIO support
Date: Wed,  4 Nov 2026 17:22:42 +0530
Message-Id: <1139700454.181793792284216.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104115242.2035807-1-shrihari.s@samsung.com>
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
X-CMS-MailID: 20261104113048epcas5p2e168c5644f42c7b29fa5995b0ec0aeb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113048epcas5p2e168c5644f42c7b29fa5995b0ec0aeb4
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113048epcas5p2e168c5644f42c7b29fa5995b0ec0aeb4@epcas5p2.samsung.com>

Add a section for the UIO related device options, and a
command-line example demonstrating a topology with three CXL Type-3
devices connected via a switch, with Unordered I/O (UIO) enabled on
all ports and endpoints. The example shows the correct usage of
the x-svc, x-256b-flit and x-uio options, including the x-uio option
of the pxb-cxl host bridge, which marks all the root ports within
the host bridge as capable of routing UIO requests.

The x-uio option of the CXL type3 device works together with x-svc
and x-256b-flit: the device carries the UIO capability when all
three are set.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 docs/system/devices/cxl.rst | 54 ++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..e2d66b0e4e 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -394,12 +394,12 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
   -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0,x-256b-flit=on \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0,x-256b-flit=on \
-  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,x-256b-flit=on \
   -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
-  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,x-256b-flit=on \
   -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
   -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
@@ -407,6 +407,54 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Unordered I/O (UIO) Support
+---------------------------
+CXL 3.2 and PCIe 6.1 introduce Unordered I/O (UIO), which allows memory
+transactions to bypass strict ordering requirements, potentially improving
+performance for certain workloads. UIO support builds on three
+coordinated features:
+
+1. **256-byte Flit Mode**: Enabled via ``x-256b-flit=on`` on all ports
+   and devices in the UIO path
+2. **Streamlined Virtual Channel (SVC)**: Enabled via ``x-svc`` on all ports
+   and CXL type3 device. SVC is a PCIe extended capability
+   (PCIe 6.4 section 7.9.29) that provides dedicated virtual channels for
+   UIO traffic.
+3. **Device 3 Extended Capability**: Enabled via ``x-uio`` on the CXL type3
+   device. Device 3 is a PCIe extended capability (PCIe 6.4 section 7.7.9)
+   that advertises a device's UIO requester/completer support. ``x-uio``
+   works together with the ``x-svc`` and ``x-256b-flit`` options: the
+   device carries the UIO capability when all three are set.
+
+``x-uio`` is also accepted by the ``pxb-cxl`` host bridge: it sets the
+UIO Capable bit of the host bridge HDM decoder capability. Each root
+port within the host bridge completes the advertisement, reporting the
+UIO Capable bit of its own HDM decoder capability when the host bridge
+carries ``x-uio`` and its own ``x-svc`` and ``x-256b-flit`` options
+are set.
+
+An example of 3 type3 devices with volatile memory below a switch. All the
+devices and ports support the Unordered IO (UIO) feature, which builds on
+the Streamlined Virtual Channel (SVC) capability, the Device 3 capability
+and 256-byte flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=target-mem1,size=512M \
+  -object memory-backend-ram,id=target-mem2,size=512M \
+  -object memory-backend-ram,id=target-mem3,size=512M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,x-uio=on \
+  -device cxl-rp,port=0,bus=cxl.1,id=rp13,chassis=0,slot=0,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-upstream,port=2,sn=1234,bus=rp13,id=us0,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6,x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-type3,id=mem1,bus=swport0,volatile-memdev=target-mem1,x-uio=on,x-svc=on,x-256b-flit=on,sn=1233 \
+  -device cxl-type3,id=mem2,bus=swport1,volatile-memdev=target-mem2,x-uio=on,x-svc=on,x-256b-flit=on,sn=1234 \
+  -device cxl-type3,id=mem3,bus=swport2,volatile-memdev=target-mem3,x-uio=on,x-svc=on,x-256b-flit=on,sn=1235 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
-- 
2.34.1


