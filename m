Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C3B71DF
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732114; cv=none; b=ds/h9oM2wErpFTcByE5jxOAIxFLpHpWbjV6FzOz8qqCr3BXZEhOs5RSP+DU2FIuiQa4ineN0xh09IjbeOTSZlYXAAmf98TjWzkfWWrBpSAk3CDuDq1i0fuEKbnGSeG0YCyNIJDx+Hom+09NBWFsQvWVTEsJKee+vGSOYlbk4w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732114; c=relaxed/simple;
	bh=XUS0WCwQCANhq74bTtR7ipXUkpVzRae0nvhbzCe7t84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kZRGX1j8uMFzGyb8kJ0TcNLPX/4J+RWDsNDOarvR4RRbgTInOIq0UsnE/0p2mhkkkg/MwjWYjxIBZFQYUH6NG9WkVdXd5PC59DIenwswqGkbbN/1/Ko20JbJNDI3BaDnrPE1f7UYeapILWU1no3hPoI7SAqs09waP0R1oKjqJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Hz3/zw8c; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hz3/zw8c"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260826081504epoutp04b9d01fb7279147811ce73240823e287b~PTOCWVvLp2885928859epoutp04G
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:15:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260826081504epoutp04b9d01fb7279147811ce73240823e287b~PTOCWVvLp2885928859epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732104;
	bh=Ya82nNtSEL/OD8UZxS1mJIc7NJaKSwiOS6KRNMG/Tx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz3/zw8cZuOvOimkBwGAFpwyK8s8S7X2xt/WWi25nPDggHQ5UqFw1RPl067+mlA2Z
	 c1AxRJdDrtDbpX0uKsHbcGZnaZl1RKFyql8qx1SSlvDiZsbtU4u6uKFcDawY49Dwia
	 egadkCyhMRdtpNBOOQhMoRbiQcFlB1YwUGd7uUws=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260826081503epcas5p4d79d497c8bdb356206468d2ebccc6058~PTOBxss2M1503715037epcas5p4d;
	Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hVHWW6Qvqz6B9mS; Wed, 26 Aug
	2026 08:15:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052037epcas5p2a0eaaa537d20851123181472026a6b1b~PQ1ujSGG61272312723epcas5p2K;
	Wed, 26 Aug 2026 05:20:37 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052036epsmtip2f89ed8b8ce5097a66b83af6656172418~PQ1s7PUbS1126611266epsmtip2s;
	Wed, 26 Aug 2026 05:20:36 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 05/10] hw/cxl: Wire UIO capability into HDM decoder and
 DVSEC registers
Date: Wed, 26 Aug 2026 11:04:05 +0530
Message-Id: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052037epcas5p2a0eaaa537d20851123181472026a6b1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052037epcas5p2a0eaaa537d20851123181472026a6b1b
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052037epcas5p2a0eaaa537d20851123181472026a6b1b@epcas5p2.samsung.com>

Plumb the 'uio_capable' flag to CXL HDM decoder capability and
control register interfaces. The UIO bit in the capability register
is now set for CXL Type3 devices and ports when UIO support is
enabled in them.

Per CXL 4.0 specification Section 8.2.4.20.7, the decoder control
UIO bit is validated against the advertised capability during
HDM decoder commit operations.

Also for DSP, enabled write mask to "UIO to HDM" bit in CXL DVSEC
Port Control Extension register.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/cxl/cxl-component-utils.c              | 23 +++++++++++++++++------
 hw/mem/cxl_type3.c                        | 10 +++++++++-
 hw/pci-bridge/cxl_downstream.c            |  2 +-
 hw/pci-bridge/cxl_root_port.c             |  3 ++-
 hw/pci-bridge/cxl_upstream.c              |  3 ++-
 hw/pci-bridge/pci_expander_bridge.c       |  3 ++-
 include/hw/cxl/cxl_component.h            |  2 +-
 include/hw/cxl/cxl_device.h               |  2 ++
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 9 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 31bbedb502..0c92c41266 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -305,7 +305,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 }
 
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
-                            enum reg_type type, bool bi)
+                            enum reg_type type, bool bi, bool uio)
 {
     int decoder_count = CXL_HDM_DECODER_COUNT;
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -325,9 +325,13 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
     }
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
+                     (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT
+                     || type == CXL2_ROOT_PORT) && uio);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
-                     UIO_DECODER_COUNT, 0);
+                     UIO_DECODER_COUNT,
+                     (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT
+                     || type == CXL2_ROOT_PORT) && uio ? decoder_count : 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      SUPPORTED_COHERENCY_MODEL,
@@ -342,6 +346,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
+        if (uio) {
+            write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] |=
+                R_CXL_HDM_DECODER0_CTRL_UIO_MASK |
+                R_CXL_HDM_DECODER0_CTRL_UIG_MASK |
+                R_CXL_HDM_DECODER0_CTRL_UIW_MASK;
+        }
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
@@ -391,7 +401,7 @@ static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
                                         enum reg_type type,
-                                        bool bi)
+                                        bool bi, bool uio)
 {
     int caps = 0;
 
@@ -431,7 +441,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
-        hdm_init_common(reg_state, write_msk, type, bi);
+        hdm_init_common(reg_state, write_msk, type, bi, uio);
         /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
     case CXL2_DEVICE:
@@ -523,7 +533,8 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     case NON_CXL_FUNCTION_MAP_DVSEC:
         break; /* Not yet implemented */
     case EXTENSIONS_PORT_DVSEC:
-        wmask[offset + offsetof(CXLDVSECPortExt, control)] = 0x0F;
+        wmask[offset + offsetof(CXLDVSECPortExt, control)] =
+            cxl_dev_type == CXL2_DOWNSTREAM_PORT ? 0x1F : 0x0F;
         wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] = 0x40;
         wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] = 0xFF;
         wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] = 0xFF;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b7ad437cbc..24bf4f8309 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -590,6 +590,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    if (ct3d->uio_comp_capable) {
+        ct3d->uio_enabled = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, UIO);
+    } else {
+        ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, UIO, 0);
+    }
 
     /* Get interleave details for chmu */
     ig = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
@@ -657,6 +662,7 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+    ct3d->uio_enabled = false;
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
@@ -1512,7 +1518,8 @@ void ct3d_reset(DeviceState *dev)
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb,
+                                       ct3d->uio_comp_capable);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
@@ -1552,6 +1559,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_comp_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1c8c3b4636..8f034991d8 100644
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
index e82685d1ab..4be2b400f9 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -53,6 +53,7 @@ typedef struct CXLRootPort {
     CPMUState cpmu;
     MemoryRegion cpmu_registers;
     PCIResReserve res_reserve;
+    bool uio_capable;
 } CXLRootPort;
 
 #define TYPE_CXL_ROOT_PORT "cxl-rp"
@@ -107,7 +108,7 @@ static void latch_registers(CXLRootPort *crp)
     uint32_t *write_msk = crp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT,
-                                       true);
+                                       true, crp->uio_capable);
 }
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 999ee0b56b..e8f2e57819 100644
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
index 3b5dcb5aec..3d92d3f46c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -883,6 +883,8 @@ struct CXLType3Dev {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
     bool flitmode;
+    bool uio_comp_capable;
+    bool uio_enabled;
 
     /* DOE */
     DOECap doe_cdat;
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


