Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C4348C56
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001916; cv=none; b=pD4S5x/i/tvgcBcu+6JALtWmxxjoIIxwG6liqDzLWunovnp+UwH9+iMcH8YnGSBQEGJ84jvdnfoJgXu1nN3ftyt6j/wkMrXgPUnEaz0ke7/nEUMn2JHsaHZLtctLcUm5Kx11BFyn14MKWnbeoNlqOqw+QdMAAnYE/mA1U7p57vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001916; c=relaxed/simple;
	bh=Tght1ycO2jvAvC1Iv7YOBj7MKPCtqVc0UwPZMDX2AWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QLY4Z0v+hbanZNj9FCTLbfXYYaEynPeZJztef5sK7u+5lgeIKRA+igrDGC4N/3Alb2eS0sHnwdQic5LIugAbLCZa7vdW9ZbTQiWPewQUzO9UHjlGiP5yJKa3t5P959s8hl+XU7xpcG7RHCfkNLyOpVEECKDmP86xVGuiILgjz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q8rynW1K; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q8rynW1K"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260609104506epoutp04949a40269e44099f49a45d2f3828b623~3Y8wlRNho3274732747epoutp042
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260609104506epoutp04949a40269e44099f49a45d2f3828b623~3Y8wlRNho3274732747epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001906;
	bh=TVQhRc8dDekoMA1OaYDeOudEU0aw2a7ljZsV7Lahev0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8rynW1K25DYDtd5HTDNkCDh6nEAdnvYnmY4Rj54EwGJlc77aeERtFctxPOooW8sD
	 3s/ENHjsZUhWTVkB/uCPpkVxSGKu61pseun1ktgc/w4aSHfQIdhZ0TYv9S9j4200Le
	 YAPvbmGSi0P++CxbJRblmmdAFyBHzQIWO5MULDZA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260609104504epcas5p1308772014546eb7371d7b142a4326203~3Y8vhycwn0554305543epcas5p16;
	Tue,  9 Jun 2026 10:45:04 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQXc241xz6B9m6; Tue,  9 Jun
	2026 10:45:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb~3Y8uSH2Fc0554305543epcas5p1k;
	Tue,  9 Jun 2026 10:45:03 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104501epsmtip12bdcceb0bf7d0b7fce7b04526feba867~3Y8sscY8B2355923559epsmtip1G;
	Tue,  9 Jun 2026 10:45:01 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Date: Tue,  9 Jun 2026 16:28:29 +0530
Message-Id: <20260609105836.3702787-2-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>

Move the 'flitmode' property from PCIESlot to PCIEPort. This change
allows all the derived ports (PCIe ports or CXL ports) to use this
property.

This is a structural refactor only. There is no functional change in
existing behavior.

Note: This property was added from Davidlohr's BI patch series[1].

[1]: https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c | 6 +++---
 hw/pci-bridge/cxl_root_port.c  | 6 +++---
 hw/pci/pcie.c                  | 2 +-
 include/hw/pci/pcie_port.h     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index d1e27994a3..7c7a1d1221 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -118,7 +118,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -132,7 +132,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -259,7 +259,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 0ee18ef5c3..df69c5200f 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -112,7 +112,7 @@ static void latch_registers(CXLRootPort *crp)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -135,7 +135,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* IO, Mem, non-MLD */
         .ctrl                    = 0x2,
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -237,7 +237,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1de0b1e4fd..d452199d85 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5ed..1bcc734649 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -33,6 +33,7 @@ struct PCIEPort {
     /*< private >*/
     PCIBridge   parent_obj;
     /*< public >*/
+    bool flitmode;
 
     /* pci express switch port */
     uint8_t     port;
@@ -58,7 +59,6 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-    bool flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
-- 
2.34.1

