Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3953F8EB2
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001938; cv=none; b=uYo7aLdLrgMGZoTr4bnQnXvYk4h93gGPAhkm4jGp+SuZJp/F+AbwKOqbf35WX+oYMWUcF7+HuZfIRnskVXJyiflyBN+A9CjoqX8x+PjJuiXCQxzhfDXJ5nTvuMl2O5EF5dycvqKidd8/DGrMD1BzyvHOFOEhB/xkgiGGhuyxPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001938; c=relaxed/simple;
	bh=jbT4TeIu5qLYRlUa6VwPmhNjxvOAClqnJbxP67TxUz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Kg8jHslg5P/XfXEdaBhTla7/2S0JCMW699Z4eiMHlfiECzoRPYyucN6772hMXHau/LzTMdwGAywOLH5NO23SJxrQJHP6jXNqf7F0oRIPAwoUyVmYA6BjP23y2/iwWwCA8Yv6SgOgFpr90ZYKqSG6jqY+0eIt6ItNHbNVKaymyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P8wvDtyo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P8wvDtyo"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260609104535epoutp04f0f6d7ad6f83996b68ae63b13bde3929~3Y9LsBA9F0041900419epoutp04H
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260609104535epoutp04f0f6d7ad6f83996b68ae63b13bde3929~3Y9LsBA9F0041900419epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001935;
	bh=jIahGxVrHix7BsYtz5UoC9vsS7ivK+HEKtPzcVjyb0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8wvDtyoVTVifaa0peeZc3a2YbUZyI1UoU0okqfQdKAYBSdu4fCvKJQVpF5cC54Rj
	 Zl4cgm79GoQZY0wVVNb1MaOicc9g7ufurIOl1+HbLAuHH+JcL96oa5FkWqbNOawkGn
	 uDjGBkPhhKaj2sq+9MpM/tAqIGfAnUVNXcazUlKQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260609104534epcas5p3030dfc01d01081fc1a4863f303080048~3Y9LVaxB_1375213752epcas5p3o;
	Tue,  9 Jun 2026 10:45:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQYB13wbz6B9m7; Tue,  9 Jun
	2026 10:45:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a~3Y9KNcdAB0412104121epcas5p2h;
	Tue,  9 Jun 2026 10:45:33 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104531epsmtip128242981e16a2a3d2eb67e16690c8c80~3Y9IqBKnV2355923559epsmtip1o;
	Tue,  9 Jun 2026 10:45:31 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 8/8] cxl: Add documentation for UIO-enabled CXL devices
Date: Tue,  9 Jun 2026 16:28:36 +0530
Message-Id: <20260609105836.3702787-9-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a@epcas5p2.samsung.com>

Add a command-line example demonstrating a topology with three CXL Type-3
devices connected via a switch. This example enables Unordered I/O (UIO) on
all ports and endpoints to illustrate the correct usage of UIO-related
properties.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 docs/system/devices/cxl.rst | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..c39721b3f9 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -407,6 +407,56 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Unordered I/O (UIO) Support
+---------------------------
+
+CXL 3.2 and PCIe 6.1 introduce Unordered I/O (UIO), which allows memory
+transactions to bypass strict ordering requirements, potentially improving
+performance for certain workloads. UIO support requires:
+
+1. **256-byte Flit Mode**: Enabled via ``x-256b-flit=on`` on all ports and devices
+2. **Streamlined Virtual Channel (SVC)**: A PCIe 6.1 extended capability that
+   provides dedicated virtual channels for UIO traffic
+
+The SVC capability defines two paths for UIO traffic:
+
+- **SVC3 (Mandatory)**: Dedicated VC for UIO traffic only (``x-uio-svc=on``)
+- **SVC4 (Optional)**: Shared VC for both UIO and non-UIO traffic
+  (``x-uio-svc-opt=on``)
+
+Both paths require 256B flit mode. The CXL Type 3 device uses the ``x-uio=on``
+property to advertise UIO capability, which is then reflected in the HDM decoder
+capability registers.
+
+**Note**: Per the CXL specification, downstream switch ports do not track UIO
+capability separately; only root ports and upstream ports maintain the UIO
+capability.
+
+An example of 3 type3 devices with volatile memory below a switch. All the devices
+and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel
+(SVC) capability and Flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=rp13,chassis=0,slot=2,x-uio-svc=on,
+   x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-upstream,port=2,sn=1234,bus=rp13,id=us0,x-uio-svc=on,
+   x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32  \
+  -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32  \
+  -object memory-backend-ram,id=target-mem1,size=512M \
+  -object memory-backend-ram,id=target-mem2,size=512M \
+  -object memory-backend-ram,id=target-mem3,size=512M \
+  -device cxl-type3,id=mem1,bus=swport0,volatile-memdev=target-mem1,x-uio=on,x-256b-flit=on,sn=1233 \
+  -device cxl-type3,id=mem2,bus=swport1,volatile-memdev=target-mem2,x-uio=on,x-256b-flit=on,sn=1234 \
+  -device cxl-type3,id=mem3,bus=swport2,volatile-memdev=target-mem3,x-uio=on,x-256b-flit=on,sn=1235 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
-- 
2.34.1

