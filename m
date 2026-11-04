Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792295;
	b=jqdMbvQOEfhdIUBdJtJxV3b2sSHbz0xL4GO4WfYnFeA2ZDJq1BdyJEN2ZDCda4OEvcqF
	 1HOeFUZmzKjvihb/fTWGeJhAxSlBchMjl1kSEaKRZ6+4UFHnlKXFuqdWO6aRJZu/Ofjeo
	 8daqJkMVgFEPdEo43yW7T8Jm7ccacO2YU4FiAYUXhOQO8XuYgFEvb7aEK7VdA6zvo4Xc8
	 2Y/CSybCutoC0gkarLkwigzj9/uqvxiDo3RRt0PNW9LeKi3Wvjh14WhIR2cc0tbpdZgky
	 RmdH8jT37cG/gu9iLUdJawrpT/HIlWRjPK4irlVvyXhRYijdWeuVJU+h//I36OyTYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792295;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=2ZWbsnim8ct5iST3zoIF8xVVhvb7T6+is3l00ig6Qkc=;
	b=EEZrlpih/veL79EoRcEB2oAZ0F+CI7xfH2UZ7ORRiMInqY5aCJ1EFBRAYR76j8RikDC2
	 EYPgjCMuuAcy7fJj8arIfiGoKxpD3DFg9nm6zGh61Zw5hDXOdAn+kylA8CzwfQpKY52E4
	 aVzEdomzOIDkAxsraMhOpLKXKCUZojF16l5G/+wu9DGfcRJjRsZfew5h31TGUDMEof9hG
	 S7J1FReZ46ew6TLfaTj8scb8NCcX1nziPo/MFgbLzzDC89etjns/Lp8bGHa+UxYSon3Dm
	 lH5wvVIOZIfSXcl9vhBOwyFTs+IpYWuwru63jFvNYGQZ2Ye+Qi1u0CEYBg6CKCzfNAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=chwJ9e6v;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09C606EEBB
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B09C606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=chwJ9e6v
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261104113806epoutp01419ffcd2bea505decc3e224c412c876b~k1JSXIks23065030650epoutp01C
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261104113806epoutp01419ffcd2bea505decc3e224c412c876b~k1JSXIks23065030650epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792286;
	bh=2ZWbsnim8ct5iST3zoIF8xVVhvb7T6+is3l00ig6Qkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chwJ9e6vnln9Grul5MwDkxQ3cOVuOQDzvnYRuOVaVKxUTZC+Cd3Zzb7ikw9YeTGMd
	 VAmgBd22QyYsdfFtfQWhn1wRvDSx4JbILBmwewvNF0lsm6P3pVUKL5grvPYmx6whOs
	 FGqBVuiUjukTGrfs+zxnqqW7gSMM7GeLRbXd8UPM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261104113803epcas5p114c685a28c31b1c260d5c91327a6daca~k1JP9OhA12444724447epcas5p1r;
	Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jKNjR4Xn3z6B9m5; Wed,  4 Nov
	2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113027epcas5p18d84e794ac256e47192248716959f3b6~k1Cmtv4XY0207202072epcas5p1R;
	Wed,  4 Nov 2026 11:30:27 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113023epsmtip128666137e738c5cd9d898a0c7ff0e881~k1CjWNVdD2131921319epsmtip1v;
	Wed,  4 Nov 2026 11:30:23 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 3/8] hw/cxl: Wire UIO capability into HDM decoder
 and DVSEC registers
Date: Wed,  4 Nov 2026 17:22:37 +0530
Message-Id: <1384010761.101793792283622.JavaMail.epsvc@epcpadp2new>
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
X-CMS-MailID: 20261104113027epcas5p18d84e794ac256e47192248716959f3b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113027epcas5p18d84e794ac256e47192248716959f3b6
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113027epcas5p18d84e794ac256e47192248716959f3b6@epcas5p1.samsung.com>

Add the UIO Capable bit and the UIO Capable Decoder Count field to
the HDM decoder capability register of the CXL components, and open
the UIO To HDM Enable bit of the Port Extensions DVSEC for the CXL
downstream ports.

Add the x-uio property to the pxb-cxl host bridge. The host bridge
is not a PCIe device in QEMU, so it carries neither the SVC nor the
256-byte flit mode capability itself: the bit gates whether the
root ports within the host bridge advertise UIO, and each root port
validates its own UIO dependent configuration.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/cxl/cxl-component-utils.c              | 55 ++++++++++++++++++++---
 hw/mem/cxl_type3.c                        |  7 ++-
 hw/pci-bridge/cxl_downstream.c            |  2 +-
 hw/pci-bridge/cxl_root_port.c             |  3 +-
 hw/pci-bridge/cxl_upstream.c              |  3 +-
 hw/pci-bridge/pci_expander_bridge.c       | 17 +++++--
 include/hw/cxl/cxl_component.h            |  2 +-
 include/hw/cxl/cxl_device.h               |  1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 include/hw/pci/pci_bridge.h               |  1 +
 10 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 31bbedb502..01458104be 100644
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
@@ -325,9 +325,30 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
     }
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    /*
+     * UIO Capable is enumerated for CXL.mem devices, USPs, CXL root
+     * ports and CXL Host Bridges (CXL 3.2 8.2.4.20.1, Table 8-27).
+     * A root port is the ingress routing point of the Host Bridge
+     * for UIO requests (CXL 3.2 9.16, Table 9-18); CXL downstream
+     * ports do not report the bit. In a Host Bridge the bit means
+     * that all the root ports within the Host Bridge are capable
+     * of routing UIO requests, and each root port signals UIO here
+     * when its own SVC and 256-byte flit mode configuration carries
+     * it.
+     */
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
+                     (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT
+                     || type == CXL2_ROOT_PORT || type == CXL2_RC) && uio);
+    /*
+     * UIO Capable Decoder Count uses the same encoding as Decoder
+     * Count (CXL 3.2 8.2.4.20.1) and is reserved for CXL.mem devices,
+     * which carry no limit on the number of UIO-capable HDM decoders.
+     */
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
-                     UIO_DECODER_COUNT, 0);
+                     UIO_DECODER_COUNT,
+                     (type == CXL2_UPSTREAM_PORT || type == CXL2_ROOT_PORT
+                     || type == CXL2_RC)
+                     && uio ? cxl_decoder_count_enc(decoder_count) : 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      SUPPORTED_COHERENCY_MODEL,
@@ -342,6 +363,21 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
+        if (uio) {
+            write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] |=
+                R_CXL_HDM_DECODER0_CTRL_UIO_MASK;
+            /*
+             * UIG and UIW are RWL for a switch and a Host Bridge if the
+             * UIO Capable bit is set, and reserved for CXL.mem devices
+             * (CXL 3.2 8.2.4.20.7).
+             */
+            if (type == CXL2_UPSTREAM_PORT || type == CXL2_ROOT_PORT ||
+                type == CXL2_RC) {
+                write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] |=
+                    R_CXL_HDM_DECODER0_CTRL_UIG_MASK |
+                    R_CXL_HDM_DECODER0_CTRL_UIW_MASK;
+            }
+        }
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
@@ -391,7 +427,7 @@ static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
                                         enum reg_type type,
-                                        bool bi)
+                                        bool bi, bool uio)
 {
     int caps = 0;
 
@@ -431,7 +467,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
-        hdm_init_common(reg_state, write_msk, type, bi);
+        hdm_init_common(reg_state, write_msk, type, bi, uio);
         /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
     case CXL2_DEVICE:
@@ -523,7 +559,14 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     case NON_CXL_FUNCTION_MAP_DVSEC:
         break; /* Not yet implemented */
     case EXTENSIONS_PORT_DVSEC:
-        wmask[offset + offsetof(CXLDVSECPortExt, control)] = 0x0F;
+        /*
+         * Bit 4 of the control register is the UIO To HDM Enable
+         * bit, RW for a downstream port capable of UIO Direct P2P
+         * accesses to HDM and RsvdP for the other port types
+         * (CXL 3.2 8.1.5.2).
+         */
+        wmask[offset + offsetof(CXLDVSECPortExt, control)] =
+            cxl_dev_type == CXL2_DOWNSTREAM_PORT ? 0x1F : 0x0F;
         wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] = 0x40;
         wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] = 0xFF;
         wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] = 0xFF;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b7ad437cbc..778a18ddea 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -590,6 +590,9 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+    if (!ct3d->uio_comp_capable) {
+        ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, UIO, 0);
+    }
 
     /* Get interleave details for chmu */
     ig = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
@@ -1512,7 +1515,8 @@ void ct3d_reset(DeviceState *dev)
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb,
+                                       ct3d->uio_comp_capable);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
@@ -1552,6 +1556,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_comp_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 134b91220a..bc1e65bc89 100644
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
index 0b1fa9594b..63d2fd54d4 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -137,7 +137,8 @@ static void latch_registers(CXLUpstreamPort *usp)
 
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_UPSTREAM_PORT,
-                                       PCIE_PORT(usp)->flitmode);
+                                       PCIE_PORT(usp)->flitmode,
+                                       usp->uio_capable);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
 }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 25dfee6a9b..8161470172 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -294,19 +294,21 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
 
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
-    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    PXBCXLDev *pxb = PXB_CXL_DEV(dev);
+    CXLHost *cxl = pxb->cxl_host_bridge;
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
     PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
     uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false,
+                                       pxb->uio_capable);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
      */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+    if (!pxb->hdm_for_passthrough) {
         dsp_count = pcie_count_ds_ports(hb->bus);
     }
     /* Initial reset will have 0 dsp so wait until > 0 */
@@ -507,6 +509,15 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
 
 static const Property pxb_cxl_dev_properties[] = {
     DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
+    /*
+     * The host bridge is not a PCIe device in QEMU, so it carries
+     * neither the SVC nor the 256-byte flit mode capability itself;
+     * each root port within the host bridge reports the UIO Capable
+     * bit of its own HDM decoder capability when this property is
+     * set together with its own SVC and 256-byte flit mode
+     * configuration.
+     */
+    DEFINE_PROP_BOOL("x-uio", PXBCXLDev, uio_capable, false),
 };
 
 static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
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
index 3b5dcb5aec..e8480026c3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -883,6 +883,7 @@ struct CXLType3Dev {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
     bool flitmode;
+    bool uio_comp_capable;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index e8f5e43faf..db417b6c03 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -21,6 +21,7 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool uio_capable;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a055fd8d32..09ea8e193f 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -115,6 +115,7 @@ typedef struct PXBCXLDev {
     /*< public >*/
 
     bool hdm_for_passthrough;
+    bool uio_capable;
     CXLHost *cxl_host_bridge; /* Pointer to a CXLHost */
 } PXBCXLDev;
 
-- 
2.34.1


