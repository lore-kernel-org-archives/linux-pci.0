Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D893F7887
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001926; cv=none; b=GvpP7FReCmdmGvJa+604x2szBq31QAjhnx3RGspM1ybHj62Ut1OX8Jh2yoELdMh8cY4yVijenHtAEfAnk9i7ASZASFCUeVGhp6umisIU+AIKEWvYSuIJBnEJCwYfAhTiTgiRqSP5tZQCzqTey3zRJLJCFPk0OsKukx/JA+XVVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001926; c=relaxed/simple;
	bh=J7TgcS7/3af3/hA1Cs94wUWwSFBIj9WsH+K7ZAQalDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oCvKhqubyRX3kgF64xioYRaC7xD5dgL92RfjCVPX7/5aBm/CF6Lzn6sJQWZcKG8oomBa/RPL8gHz2FibayRLcp7ngN0+b4AEYgEqspwqlsMxkrZbu2I4J9pWPqe25qvYPDnPmrJVWl2RO6pDrBUGdw+qPaQG/1bxsJqFNjsiXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Kzg8/WpO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kzg8/WpO"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260609104523epoutp029cd6e632055add49db31b60241398ed9~3Y9As-DGR2768727687epoutp02k
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260609104523epoutp029cd6e632055add49db31b60241398ed9~3Y9As-DGR2768727687epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001923;
	bh=kMkgTZuJ/C4L91nSM6PkENeTgSP9+Fl1hfo4foCfyvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kzg8/WpO6518c/xezrBVBNN/zjxo6/epyhT23+3oYX7jF8AJSqxCTRkfZO90NbCKD
	 AfFoQCrbmJyIpZE6CBRK4OgJMarpEGkQ10Z3jOUJ/K+BbN/WDxQMw0U9M0MOIsvyQ/
	 rcabtg0T/woV+zPbFWLo/LeTQS2nP2OXSRIw3aig=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260609104522epcas5p439cb0cb8a4b0ff8ac258f238a87373ac~3Y9AUVs6j2655926559epcas5p4T;
	Tue,  9 Jun 2026 10:45:22 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQXy216Lz6B9m7; Tue,  9 Jun
	2026 10:45:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7~3Y8-RXvoE1025210252epcas5p1V;
	Tue,  9 Jun 2026 10:45:21 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104520epsmtip111075b924d06186a6f24d55bfc9e6f84~3Y89s12ed2381023810epsmtip1U;
	Tue,  9 Jun 2026 10:45:20 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC) property to
 CXL ports
Date: Tue,  9 Jun 2026 16:28:32 +0530
Message-Id: <20260609105836.3702787-5-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>

Add Unordered IO (UIO) dependent property SVC to CXL ports
(Root, Upstream and Downstream).

The following properties are added to CXL ports:
    - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
    - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)

Note: 256B flit mode property was already added in CXL ports, so reused it.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c            | 2 ++
 hw/pci-bridge/cxl_root_port.c             | 1 +
 hw/pci-bridge/cxl_upstream.c              | 2 ++
 include/hw/pci-bridge/cxl_upstream_port.h | 1 +
 4 files changed, 6 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 7c7a1d1221..6f6f332c07 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -260,6 +260,8 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e82685d1ab..83fb5968b8 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -53,6 +53,7 @@ typedef struct CXLRootPort {
     CPMUState cpmu;
     MemoryRegion cpmu_registers;
     PCIResReserve res_reserve;
+    bool uio_capable;
 } CXLRootPort;
 
 #define TYPE_CXL_ROOT_PORT "cxl-rp"
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef5480b116..dadad3e15c 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -437,6 +437,8 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index d4186234c8..d23541e23a 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -22,6 +22,7 @@ typedef struct CXLUpstreamPort {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
     bool flitmode;
+    bool uio_capable;
 
     DOECap doe_cdat;
     uint64_t sn;
-- 
2.34.1

