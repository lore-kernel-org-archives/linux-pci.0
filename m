Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B853B774D
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732294; cv=none; b=MG1jEcs18l3tI/yKUoqZEwGbe1JK2UsjWeRx571euiMI6z+orSmmTLkx9TZvXB4VGfWkzfq6OZnCcMXRL4pBRYxnxSGo5ajYcWQrfjyZbLvheafSZZ/bqu7LnRX8QOD0gvQY8xh/L+ZLLOrNlHZxMxz18RwiC2JqTisdgcorKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732294; c=relaxed/simple;
	bh=ZFJ5HuGwEF2aKqbHDrrMM4Wb/hdOQPnFGNemhUHVxuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=E5/6RKjIVT8XOtJSH1Ss8xMk5buJIqzg56M6nvd1qDjGrJySu3D+6UY0kPZYVV6cLfpvF+GD/LHw2xPVx/zbGON7+8wvzYaZfuwnDSkunhTNUVlyNpVnGG+fRRtq5KtaiWI5nUOjGKFcbV5ZrRdqLf3kSd12IBBAfMARS2GIwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z4BW9wQi; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z4BW9wQi"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260826081803epoutp0389e936a9da32547121cb39ba5a488b28~PTQo6eDsF2189121891epoutp03G
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260826081803epoutp0389e936a9da32547121cb39ba5a488b28~PTQo6eDsF2189121891epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732283;
	bh=5kslehkSYQQJNBS8XWxJXetHXlzoZPOct6pcbzD15eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4BW9wQi8z4bdneEDiwZSLzFG9u+QzVA7ANhAesomcGQM/EPp2oeBtgid2l6wFriU
	 0aqMWi/LyG151JBoRKaZKH79AsYVtAKS2rsgx2Y18us9x48s1K/Sb8GvNZSjnhkte1
	 OUkMYVtlU/Ktk1e5A9ZS7ZQkVq6uC7Gz+e6IxSAY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260826081802epcas5p3f2006a1c5855d921de4f612365435511~PTQoYKbKs1603216032epcas5p3C;
	Wed, 26 Aug 2026 08:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hVHZy5kx0z2SSKp; Wed, 26 Aug
	2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260826052048epcas5p4abd91ab8d33794807359613bdb709d2d~PQ14CsV1w1804318043epcas5p40;
	Wed, 26 Aug 2026 05:20:48 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052046epsmtip213a6feab2cdc5350a1b655652fc35bbb~PQ12YvSQl1126911269epsmtip2R;
	Wed, 26 Aug 2026 05:20:46 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 07/10] hw/pci: hw/cxl: Wire SVC initialization into port
 realize functions.
Date: Wed, 26 Aug 2026 11:04:07 +0530
Message-Id: <111374580.41787732282793.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052048epcas5p4abd91ab8d33794807359613bdb709d2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052048epcas5p4abd91ab8d33794807359613bdb709d2d
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052048epcas5p4abd91ab8d33794807359613bdb709d2d@epcas5p4.samsung.com>

Integrate Streamlined Virtual Channel (SVC) capability initialization into the
realize() functions of both PCIe and CXL ports. This change ensures that the
'uio_capable' flag is correctly populated in CXL ports during the initialization
sequence.

'uio_capable' in CXL ports is responsible for enabling UIO capability in
HDM decoder registers.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c     |  7 ++++++-
 hw/pci-bridge/cxl_root_port.c      | 11 ++++++++++-
 hw/pci-bridge/cxl_upstream.c       | 10 +++++++++-
 hw/pci-bridge/gen_pcie_root_port.c |  3 +++
 hw/pci-bridge/pcie_root_port.c     |  4 ++++
 hw/pci-bridge/xio3130_downstream.c |  3 +++
 hw/pci-bridge/xio3130_upstream.c   |  3 +++
 include/hw/pci/pcie_port.h         |  1 +
 8 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 8f034991d8..de6d2f7306 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -33,8 +33,10 @@ typedef struct CXLDownstreamPort {
 #define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 2
 #define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
 #define CXL_DOWNSTREAM_PORT_AER_OFFSET 0x100
-#define CXL_DOWNSTREAM_PORT_DVSEC_OFFSET        \
+#define CXL_DOWNSTREAM_PORT_SVC_OFFSET          \
     (CXL_DOWNSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_DOWNSTREAM_PORT_DVSEC_OFFSET        \
+    (CXL_DOWNSTREAM_PORT_SVC_OFFSET + PCI_SVC_SIZEOF)
 
 static void latch_registers(CXLDownstreamPort *dsp)
 {
@@ -229,6 +231,9 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &dsp->bar);
+    if (p->svc) {
+        pcie_svc_cap_init(d, CXL_DOWNSTREAM_PORT_SVC_OFFSET, errp);
+    }
 
     return;
 
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 4be2b400f9..19dd75b79f 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -40,8 +40,10 @@
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET 0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
     (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
-#define CXL_ROOT_PORT_DVSEC_OFFSET \
+#define GEN_PCIE_ROOT_PORT_SVC_OFFSET \
     (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
+#define CXL_ROOT_PORT_DVSEC_OFFSET \
+    (GEN_PCIE_ROOT_PORT_SVC_OFFSET + PCI_SVC_SIZEOF)
 
 typedef struct CXLRootPort {
     /*< private >*/
@@ -164,6 +166,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_dev     = PCI_DEVICE(dev);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    PCIEPort *p            = PCIE_PORT(dev);
     CXLRootPort *crp       = CXL_ROOT_PORT(dev);
     CXLComponentState *cxl_cstate = &crp->cxl_cstate;
     ComponentRegisters *cregs = &cxl_cstate->crb;
@@ -212,6 +215,12 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &crp->bar);
+    if (p->svc) {
+        rc = pcie_svc_cap_init(pci_dev, GEN_PCIE_ROOT_PORT_SVC_OFFSET, errp);
+        if (p->flitmode && rc >= 0) {
+            crp->uio_capable = true;
+        }
+    }
 }
 
 static void cxl_rp_reset_hold(Object *obj, ResetType type)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index e8f2e57819..3ed6a89bf3 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -27,8 +27,10 @@
 #define CXL_UPSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET 0x90
 #define CXL_UPSTREAM_PORT_AER_OFFSET 0x100
+#define CXL_UPSTREAM_PORT_SVC_OFFSET \
+     (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
 #define CXL_UPSTREAM_PORT_SN_OFFSET \
-    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+    (CXL_UPSTREAM_PORT_SVC_OFFSET + PCI_SVC_SIZEOF)
 #define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
     (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
@@ -411,6 +413,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
         goto err_cap;
     }
 
+    if (p->svc) {
+        rc = pcie_svc_cap_init(d, CXL_UPSTREAM_PORT_SVC_OFFSET, errp);
+        if (p->flitmode && rc >= 0) {
+            usp->uio_capable = true;
+        }
+    }
     return;
 
 err_cap:
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 2f7257d166..d4df4a7c16 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -26,6 +26,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
         (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define GEN_PCIE_ROOT_PORT_SVC_OFFSET \
+        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
 
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
@@ -166,6 +168,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
     rpc->interrupts_uninit = gen_rp_interrupts_uninit;
     rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
     rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
+    rpc->svc_offset = GEN_PCIE_ROOT_PORT_SVC_OFFSET;
 }
 
 static const TypeInfo gen_rp_dev_info = {
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 0ae7b10fbd..9c325aa5f4 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -120,6 +120,10 @@ static void rp_realize(PCIDevice *d, Error **errp)
     if (rpc->acs_offset && !s->disable_acs) {
         pcie_acs_init(d, rpc->acs_offset);
     }
+    if (!pci_is_cxl(d) && p->svc) {
+        pcie_svc_cap_init(d, rpc->svc_offset, errp);
+    }
+
     return;
 
 err:
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 090a3fdfc9..a2546d5060 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -110,6 +110,9 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err;
     }
+    if (p->svc) {
+        pcie_svc_cap_init(d, XIO3130_AER_OFFSET + PCI_ERR_SIZEOF, errp);
+    }
 
     return;
 
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 767b7d17f2..fd15e8c943 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -92,6 +92,9 @@ static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err;
     }
+    if (p->svc) {
+        pcie_svc_cap_init(d, XIO3130_AER_OFFSET + PCI_ERR_SIZEOF, errp);
+    }
 
     return;
 
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 0b3e0efb8c..8de95d71ef 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -97,6 +97,7 @@ struct PCIERootPortClass {
     int aer_offset;
     int ssvid_offset;
     int acs_offset;    /* If nonzero, optional ACS capability offset */
+    int svc_offset;    /* optional SVC capability */
     int ssid;
 };
 
-- 
2.34.1


