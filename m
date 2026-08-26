Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1E3B71DF
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732289; cv=none; b=s8vzHEChHb6A2GgpiBhyxtuQsj21TOAA72lFumREhjRUeK02vJDZXBtFu3Nl7vVNNt13pakpZ6eF2svQFavbcDwPD4aAeodHOhrQZ+PxwWc2Yr4AFkpwVC/T4eicNL2XPem7rM+XxDHeOrFYlxoLIYdJDZmcJcSoFMzQCQ1ww6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732289; c=relaxed/simple;
	bh=FP1RQgROVAAGjDxUlvmP+alu4Et+dHsAwrSwnlCqLy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Kz/pFAVv4SHYxRM7TH4+BFAjemt/S/zIYE5a5yrphj9lIzcNVFOWVbRoRdCvCZvDSUVzLlLWY/QwrtIFg2dcDeXPDAsGnCMnRPdclHOQpufcZ2PWRMXYaC2h26LMF3UaOVt/Lp/gF7xzk/9hb+Q1exWF/68xQiVbBQDsRGA9IOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HdBCloQk; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HdBCloQk"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260826081803epoutp038c612287ab85d9fd04fc6eee2a287b02~PTQoyBtt52123221232epoutp03z
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260826081803epoutp038c612287ab85d9fd04fc6eee2a287b02~PTQoyBtt52123221232epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732283;
	bh=Vtbd2n0Q60hLv5lgLLEXETA9TtHgTBHeXPmUSvh+e28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdBCloQkopl7/XBGsA4RjL3Ypu3339n+453YW8Sge7vJ5FVswSdlO9508Sy7O6My0
	 WlD8Ofuh2CU7EoGukt50wXR3M/u1vi/5ZnNyOi7aTR8hYxbHIOIABDIbbctTU2WVSx
	 WJ/E6C229p4vBKGJtNVSZoNS8xEflyzqEolhzRFU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260826081802epcas5p456e877443ef3ad49bfacdd58f1c9a738~PTQoOcAWk1534715347epcas5p4W;
	Wed, 26 Aug 2026 08:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hVHZy4Yr9z3hhT7; Wed, 26 Aug
	2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260826052054epcas5p465329951e4377c63c450fd60aa2258b3~PQ19z-Mbx3144831448epcas5p4D;
	Wed, 26 Aug 2026 05:20:54 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052052epsmtip237c411953b7b1552d4c6e9367759e0e7~PQ18NKU0g1001010010epsmtip2V;
	Wed, 26 Aug 2026 05:20:52 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 09/10] hw/cxl: Wire SVC and Dev3 capability to CXL Type 3
 device
Date: Wed, 26 Aug 2026 11:04:09 +0530
Message-Id: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052054epcas5p465329951e4377c63c450fd60aa2258b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052054epcas5p465329951e4377c63c450fd60aa2258b3
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052054epcas5p465329951e4377c63c450fd60aa2258b3@epcas5p4.samsung.com>

Adds SVC and Dev3 capability to CXL type 3 device to make
it work as a UIO completer.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 +++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0adf2e8b3e..74ddcf6e58 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1195,6 +1195,20 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pcie_doe_init(pci_dev, &ct3d->doe_comp, 0x1b0, doe_comp_prot, true,
                   CXL_T3_MSIX_PCIE_DOE_COMPLIANCE);
 
+    if (ct3d->svc) {
+        /* SVC capability of the type3 device */
+        rc = pcie_svc_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF, errp);
+        if ((rc >= 0) && ct3d->flitmode && ct3d->uio_comp_capable) {
+
+            /*
+             * The Dev3 Capability is initialized  after AER in the PCIe config
+             * space. Also initializing CXL type3 device as a UIO completer.
+             */
+            pcie_dev3_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF + PCI_SVC_SIZEOF,
+                               false, true, errp);
+        }
+    }
+
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
                            CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
@@ -1560,6 +1574,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-svc", CXLType3Dev, svc, false),
     DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_comp_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3d92d3f46c..5505aefe37 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -885,6 +885,7 @@ struct CXLType3Dev {
     bool flitmode;
     bool uio_comp_capable;
     bool uio_enabled;
+    bool svc;
 
     /* DOE */
     DOECap doe_cdat;
-- 
2.34.1


