Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76897296BCB
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001932; cv=none; b=PZf3FP6EHycDXao6XRkz8gzs8480Y+mdJH1yWe9Quty20eU48Fjv/JtxjRq+kDNM6k/qO6nP2chmN7thUVoaEmNy/R68z2le54B5hunJp0yVvT+w1LLQ8vGSGswlSzPkYq/NBmMMULVuZkCpZYS9zAZJYKC5IasLvVm4e/lYDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001932; c=relaxed/simple;
	bh=BMKYO+5lI4bclvln6h1lFZmZj5qwBgGTXcPi2yU+1y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Lyt4IyTz72YmCRbAlfyI5esWrr8lrWg8a49oijMVdJ0kycuwHwTiRgrlbDGFXSIbDqfJtjZWaBIOSRGlyoELnYMAlbgB5QKEOXdVdAaWfAvoztKiDN+kzZ5yN5MBBhBoo/8bDWo+63/eREftWWvHHD0AHoc3+AY+uhAF+hUi8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pkqvXNQT; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pkqvXNQT"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260609104526epoutp031c3741ac3c9be94d0afe0f880a0dbb46~3Y9DzhKds0098100981epoutp03E
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260609104526epoutp031c3741ac3c9be94d0afe0f880a0dbb46~3Y9DzhKds0098100981epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001926;
	bh=Uxe8siGpeBw5SZONkkYNgM/0xKYIi23/sklb1yT+pj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkqvXNQT/X4M3QJ6ekadT4738oNSD4VOnMvDDdvzwq9XPGS+cJ6pjNpe6tGA3r4BD
	 5PdpuEMAldm7ga4GhKykY8ZchSjjMUV7kuSvukS35I8Ht050csiNIsVxitwQL+9ilX
	 7VFzznH3FQxIm3BMnGf7HSGNqDtaG9b7jN3IOfaw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260609104526epcas5p45f5c777149e46322a4b50b4fad6dc0d4~3Y9DjH1J03211032110epcas5p4K;
	Tue,  9 Jun 2026 10:45:26 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gZQY15PjJz2SSKY; Tue,  9 Jun
	2026 10:45:25 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7~3Y9CORnbY1025210252epcas5p1g;
	Tue,  9 Jun 2026 10:45:25 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104523epsmtip1c14a135ce5ac2255ceb339b0299225c1~3Y9ArC0xG2221922219epsmtip1m;
	Tue,  9 Jun 2026 10:45:23 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder registers
Date: Tue,  9 Jun 2026 16:28:33 +0530
Message-Id: <20260609105836.3702787-6-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7@epcas5p1.samsung.com>

Plumb the 'uio_capable' flag to CXL HDM decoder capability and
control register interfaces. The UIO bit in the capability register
is now set for CXL Type3 devices and ports when UIO support is
advertised via 'x-uio-svc' property.

Per CXL 4.0 specification Section 8.2.4.20.7, the decoder control
UIO bit is validated against the advertised capability during
HDM decoder commit operations.

Additionally, replace hardcoded HDM decoder control write masks
with spec-aligned 'WRMASK' definitions.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/cxl/cxl-component-utils.c        | 29 +++++++++++++++++++++++------
 hw/mem/cxl_type3.c                  |  9 ++++++++-
 hw/pci-bridge/cxl_downstream.c      |  2 +-
 hw/pci-bridge/cxl_root_port.c       |  2 +-
 hw/pci-bridge/cxl_upstream.c        |  3 ++-
 hw/pci-bridge/pci_expander_bridge.c |  3 ++-
 include/hw/cxl/cxl_component.h      |  2 +-
 include/hw/cxl/cxl_device.h         |  2 ++
 8 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 31bbedb502..9a5b382272 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,6 +13,19 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+/* CXL 4.0 specification 8.4.2.20.7 */
+#define CXL_HDM_DECODER_CTRL_WRMASK (    \
+    (0xfu << 0)   | /* IG */             \
+    (0xfu << 4)   | /* IW */             \
+    BIT(8)        | /* LOCK_ON_COMMIT */ \
+    BIT(9)        | /* COMMIT */         \
+    BIT(12)       | /* TYPE */           \
+    BIT(13)       | /* BI */             \
+    BIT(14)       | /* UIO */            \
+    (0xfu << 16)  | /* UIG */            \
+    (0xfu << 20)  | /* UIW */            \
+    (0xfu << 24))   /* ISP */
+
 /* CXL r3.1 Section 8.2.4.20.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
 {
@@ -305,7 +318,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 }
 
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
-                            enum reg_type type, bool bi)
+                            enum reg_type type, bool bi, bool uio)
 {
     int decoder_count = CXL_HDM_DECODER_COUNT;
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -325,9 +338,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
     }
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
+                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
-                     UIO_DECODER_COUNT, 0);
+                     UIO_DECODER_COUNT,
+                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
+                     decoder_count : 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      SUPPORTED_COHERENCY_MODEL,
@@ -341,7 +357,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
+        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =
+                                             CXL_HDM_DECODER_CTRL_WRMASK;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
@@ -391,7 +408,7 @@ static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
                                         enum reg_type type,
-                                        bool bi)
+                                        bool bi, bool uio)
 {
     int caps = 0;
 
@@ -431,7 +448,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
-        hdm_init_common(reg_state, write_msk, type, bi);
+        hdm_init_common(reg_state, write_msk, type, bi, uio);
         /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
     case CXL2_DEVICE:
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b7ad437cbc..4cdadc3e10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -590,6 +590,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    if (ct3d->uio_capable) {
+        ct3d->uio_enabled = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, UIO);
+    } else {
+        ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, UIO, 0);
+    }
 
     /* Get interleave details for chmu */
     ig = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
@@ -1512,7 +1517,8 @@ void ct3d_reset(DeviceState *dev)
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb,
+                                       ct3d->uio_capable);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
@@ -1552,6 +1558,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 6f6f332c07..e0fa6cfdc4 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -42,7 +42,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
     uint32_t *write_msk = dsp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_DOWNSTREAM_PORT, true);
+                                       CXL2_DOWNSTREAM_PORT, true, false);
 }
 
 /* TODO: Look at sharing this code across all CXL port types */
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 83fb5968b8..4be2b400f9 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -108,7 +108,7 @@ static void latch_registers(CXLRootPort *crp)
     uint32_t *write_msk = crp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT,
-                                       true);
+                                       true, crp->uio_capable);
 }
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index dadad3e15c..a75d10e7b4 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -136,7 +136,8 @@ static void latch_registers(CXLUpstreamPort *usp)
     uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_UPSTREAM_PORT, usp->flitmode);
+                                       CXL2_UPSTREAM_PORT, usp->flitmode,
+                                       usp->uio_capable);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
 }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 25dfee6a9b..18b61eca20 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -301,7 +301,8 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false,
+                                       false);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index d734f88d2c..662fdb0833 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -315,7 +315,7 @@ void cxl_component_register_block_init(Object *obj,
                                        const char *type);
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
-                                        enum reg_type type, bool bi);
+                                        enum reg_type type, bool bi, bool uio);
 
 void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3b5dcb5aec..20a1a90014 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -883,6 +883,8 @@ struct CXLType3Dev {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
     bool flitmode;
+    bool uio_capable;
+    bool uio_enabled;
 
     /* DOE */
     DOECap doe_cdat;
-- 
2.34.1

