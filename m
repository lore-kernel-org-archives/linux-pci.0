Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71D3B6C16
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732290; cv=none; b=uba0oDjwNG5B7/LQimPwJZPebNLZtp/GMeuirwTq8usKVnDySzdxo29MgzN3lAGADxx515Mrpzqwf2lNugkfsr1oGYA3swtpb+69akqxpEreboPp0jv8abnkrRiVZp3L8v7I8O6UsMgURj2lMep9RapPttrRluHXGT8lcc9O+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732290; c=relaxed/simple;
	bh=eK2MW8WdGYjtgvVzpeo+bTVIE4dYtE/yicBkraoAZKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DYazuYUms4GgNrmphj29JGcCQ39/LwQ0pf6V1a2o9d8vRI3YW7CMXIdeByKJxGAqNVLXZoVuh7iC9aG9KZSy4jyWFw6/PGIlfYrkedkGWTm6BY6NIkWGZq4ilsBqZDGKT/a9jcDmZBx1eUG3hhczs4XZyr7tATTQ4o/yWmgnmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rSzDSm3c; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rSzDSm3c"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260826081803epoutp03d5090ba317f32b838460f0596902659e~PTQo0neHp2124021240epoutp03q
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260826081803epoutp03d5090ba317f32b838460f0596902659e~PTQo0neHp2124021240epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732283;
	bh=XrfOd5I7yYuwIENwq0UACxZdyXsSMFVFj/pme2+Sch0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSzDSm3cM8SYgbXZjIt4n9Qa/7hguBYwEeECfH6H04YhvLTQyQFGpXXzNS/IeTsjw
	 6Lo+BdR7kRVFD62vLoVq3vZltGRSf6LazlY2kc10fOxnB1n4U69SXjyTJVioyTyMkI
	 RQ4aFYDEv0FJbQ8kO+IS86PMkHRG8G3feS2Ry/Tg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260826081803epcas5p457ed91f467aaf7b7d456d970e0346e54~PTQoiHH181534315343epcas5p4Y;
	Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hVHZy6vwpz2SSKX; Wed, 26 Aug
	2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052057epcas5p258d55156d7a23470f3b03941d90c5784~PQ2Aoai3T1272412724epcas5p2D;
	Wed, 26 Aug 2026 05:20:57 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052055epsmtip2b9df838429493c35d5759eeca1368ee7~PQ1-BAa5X1196711967epsmtip2D;
	Wed, 26 Aug 2026 05:20:55 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 10/10] cxl: Add documentation for CXL UIO support.
Date: Wed, 26 Aug 2026 11:04:10 +0530
Message-Id: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052057epcas5p258d55156d7a23470f3b03941d90c5784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052057epcas5p258d55156d7a23470f3b03941d90c5784
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052057epcas5p258d55156d7a23470f3b03941d90c5784@epcas5p2.samsung.com>

Add a command-line example demonstrating a topology with three CXL Type-3
devices connected via a switch. This example enables Unordered I/O (UIO) on
all ports and endpoints to illustrate the correct usage of UIO-related
properties.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 docs/system/devices/cxl.rst | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..378fb5b2c1 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -407,6 +407,53 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Unordered I/O (UIO) Support
+---------------------------
+CXL 3.2 and PCIe 6.1 introduce Unordered I/O (UIO), which allows memory
+transactions to bypass strict ordering requirements, potentially improving
+performance for certain workloads. UIO support requires three coordinated
+features:
+
+1. **256-byte Flit Mode**: Enabled via ``x-256b-flit=on`` on all ports
+   and devices in the UIO path
+2. **Streamlined Virtual Channel (SVC)**: Enabled via ``x-svc`` on all ports
+   and CXL type3 device. SVC is a PCIe 6.1 extended capability
+   (PCIe 6.4 section 7.9.29) that provides dedicated virtual channels for
+   UIO traffic.
+3. **Device 3 Extended Capability**: Enabled via ``x-uio`` on CXL type3
+   device. Device3 is a PCIe 6.4 extended capability (PCIe 6.4 section 7.7.9)
+   that advertises a device's UIO requester/completer support.
+
+An example of 3 type3 devices with volatile memory below a switch. All the devices
+and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel
+(SVC) capability, Device3 capability and requires operating in Flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=target-mem1,size=512M \
+  -object memory-backend-ram,id=target-mem2,size=512M \
+  -object memory-backend-ram,id=target-mem3,size=512M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=rp13,chassis=0,slot=0,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-upstream,port=2,sn=1234,bus=rp13,id=us0,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-type3,id=mem1,bus=swport0,volatile-memdev=target-mem1,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1233 \
+  -device cxl-type3,id=mem2,bus=swport1,volatile-memdev=target-mem2,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1234 \
+  -device cxl-type3,id=mem3,bus=swport2,volatile-memdev=target-mem3,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1235 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
-- 
2.34.1


