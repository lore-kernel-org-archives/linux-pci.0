Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42393F8EB2
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001935; cv=none; b=XGhxNDEoJGkaZNdcggV/cys32REx04u+0hGnWRbxFMJ0HeBVO1YiwqUSRVkOyly4usCVkzWEW9DzPyMm54baCEjiIacxyqvUJffURzY2NshnOmtsW3tHsKu9+rZZLU54jBRsRWszW+/A0Rhkkco+z9eZ90SyytC8iGG8PEawSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001935; c=relaxed/simple;
	bh=P+VcXUyb+w0C1/D6tw6kL44bvzJnKp5hRPvF3xm1jGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AMzNayAQ4+jTzJCKu7wqVOBY3nORi9Ac+7gHhKEjc2g0bJn8J8X+Sa5TCAqmmnc79NU2dpAjYhJK4oH7bUsV6X8m8EkQWKwUtwkXJrGn4ZieQt3Jj7KXP9eo/qn5rYWU+3lEXH0Zl1e1CbcVugOsSNfhrqitRo39cL+TqqTVq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZoaK+X2v; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZoaK+X2v"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260609104529epoutp02670f1efbcb07cbc555f7adfccfc7aafc~3Y9GfE-yi2725327253epoutp02A
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260609104529epoutp02670f1efbcb07cbc555f7adfccfc7aafc~3Y9GfE-yi2725327253epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001929;
	bh=T3oLqm2ktWU5/ab7VMykgacrbATWfIOyJxRsX55XZDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoaK+X2vlD7oCNFhN4CJ0AzLAKjcg+UmCp38vkxLtyL6YTz+u/MXVE0Pw+P6kRqgm
	 sOrtVy8Wx+NNo6MacoD1+hocAJTKGwO/3kpUwQSpdOBnyMtOnLPhx8+pX9nhvGXbYY
	 xEJZExwq0zQy9+UzdWVD4GMtTVA9LIHPaciEdbG0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260609104529epcas5p497b1312947ef611cc454ac0df4c2ada1~3Y9GM51nW3211032110epcas5p4T;
	Tue,  9 Jun 2026 10:45:29 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gZQY44R0Mz2SSKb; Tue,  9 Jun
	2026 10:45:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637~3Y9FBHaeE2265622656epcas5p4G;
	Tue,  9 Jun 2026 10:45:28 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104526epsmtip13319bcd779781f7a72955366cc5108f6~3Y9DZhOhk2381023810epsmtip1W;
	Tue,  9 Jun 2026 10:45:26 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Date: Tue,  9 Jun 2026 16:28:34 +0530
Message-Id: <20260609105836.3702787-7-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637@epcas5p4.samsung.com>

From: Dongjoo Seo <dongjoo.seo1@samsung.com>

Implement the PCIe Streamlined Virtual Channel (SVC) Extended
Capability by adding support of capability, control and status
registers per PCIe 6.4 section 7.9.29. This capability is one
of the main requisites for UIO support in both PCIe and CXL ports.

Key changes include:
    - New pcie_svc.c file for SVC capability management.
    - Updated pcie_cap_fill_lnk() to handle flitmode signaling.
    - Implement Lifecycle hooks (reset and config_write) to manage
      SVC state.

Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci/meson.build         |   2 +-
 hw/pci/pci.c               |   4 +
 hw/pci/pcie.c              |  53 ++++++++++--
 hw/pci/pcie_svc.c          | 164 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |   7 ++
 include/hw/pci/pcie_regs.h |   1 +
 include/hw/pci/pcie_svc.h  |  91 ++++++++++++++++++++
 7 files changed, 316 insertions(+), 6 deletions(-)
 create mode 100644 hw/pci/pcie_svc.c
 create mode 100644 include/hw/pci/pcie_svc.h

diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index b9c34b2acf..d55882a0c9 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -14,7 +14,7 @@ pci_ss.add(files(
 # The functions in these modules can be used by devices too.  Since we
 # allow plugging PCIe devices into PCI buses, include them even if
 # CONFIG_PCI_EXPRESS=n.
-pci_ss.add(files('pcie.c', 'pcie_aer.c'))
+pci_ss.add(files('pcie.c', 'pcie_aer.c', 'pcie_svc.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5996229c81..0469250f42 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_svc.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "migration/cpr.h"
@@ -568,6 +569,7 @@ static void pci_do_device_reset(PCIDevice *dev)
     msi_reset(dev);
     msix_reset(dev);
     pcie_sriov_pf_reset(dev);
+    pcie_svc_cap_reset(dev);
 }
 
 /*
@@ -1814,6 +1816,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     msi_write_config(d, addr, val_in, l);
     msix_write_config(d, addr, val_in, l);
     pcie_sriov_config_write(d, addr, val_in, l);
+    pcie_cap_flit_write_config(d, addr, val_in, l);
+    pcie_svc_cap_write_config(d, addr, val_in, l);
 }
 
 /***********************************************************/
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index d452199d85..7c7d948e00 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -112,8 +112,9 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
 }
 
 /* Includes setting the target speed default */
-static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
-                              PCIExpLinkSpeed speed, bool flitmode)
+static void pcie_cap_fill_lnk(PCIDevice *dev, uint8_t *exp_cap,
+                              PCIExpLinkWidth width, PCIExpLinkSpeed speed,
+                              bool flitmode)
 {
     /* Clear and fill LNKCAP from what was configured above */
     pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
@@ -160,8 +161,14 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
     }
 
     if (flitmode) {
-        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
+        uint32_t pos = dev->exp.exp_cap;
+
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
                                    PCI_EXP_LNKSTA2_FLIT);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
+                                   PCI_EXP_FLAGS_FLIT);
+        pci_word_test_and_set_mask(dev->wmask + pos + PCI_EXP_LNKCTL,
+                                   PCI_EXP_LNKCTL_FLIT_DIS);
     }
 }
 
@@ -180,9 +187,44 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));
 
-    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
+    pcie_cap_fill_lnk(dev, exp_cap, width, speed, flitmode);
 }
 
+void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
+                                int len)
+{
+    uint8_t *exp_cap;
+    uint16_t lnksta2;
+    uint16_t lnkctl;
+    uint16_t flags;
+
+    if (!pci_is_express(dev) || !dev->exp.exp_cap) {
+        return;
+    }
+
+    if (!ranges_overlap(addr, len,
+                        dev->exp.exp_cap + PCI_EXP_LNKCTL, 2)) {
+        return;
+    }
+
+    exp_cap = dev->config + dev->exp.exp_cap;
+    flags = pci_get_word(exp_cap + PCI_EXP_FLAGS);
+    if (!(flags & PCI_EXP_FLAGS_FLIT)) {
+        return;
+    }
+
+    lnkctl = pci_get_word(exp_cap + PCI_EXP_LNKCTL);
+    lnksta2 = pci_get_word(exp_cap + PCI_EXP_LNKSTA2);
+
+    if (lnkctl & PCI_EXP_LNKCTL_FLIT_DIS) {
+        lnksta2 &= ~PCI_EXP_LNKSTA2_FLIT;
+    } else {
+        lnksta2 |= PCI_EXP_LNKSTA2_FLIT;
+    }
+
+    pci_set_word(exp_cap + PCI_EXP_LNKSTA2, lnksta2);
+ }
+
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
 {
     PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
@@ -217,7 +259,8 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
+    pcie_cap_fill_lnk(dev, exp_cap, s->width, s->speed,
+                      s->parent_obj.flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/hw/pci/pcie_svc.c b/hw/pci/pcie_svc.c
new file mode 100644
index 0000000000..84db73de58
--- /dev/null
+++ b/hw/pci/pcie_svc.c
@@ -0,0 +1,164 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Streamlined Virtual Channel (SVC) Extended Capability
+ *
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_svc.h"
+#include "hw/pci/pcie_port.h"
+
+static void pcie_svc_update_map(PCIDevice *dev)
+{
+    uint32_t non_uio_ctrl = SVC_VC0_PROTOCOL | SVC_VC_ENABLE;
+    uint32_t uio_ctrl = SVC_UIO_PROTOCOL_SELECTED | SVC_VC_ENABLE;
+    int offset;
+
+    if (!pci_is_express(dev) || !dev->exp.svc_cap) {
+        return;
+    }
+
+    offset = pcie_find_capability(dev, PCI_EXT_CAP_ID_SVC);
+
+    /* SVC VC0 & VC3 initialization */
+    pci_set_long(dev->config + offset + SVC_RES_CTRL(0), BIT(0) | non_uio_ctrl);
+    pci_set_long(dev->config + offset + SVC_RES_CTRL(3), BIT(3) | uio_ctrl);
+
+    /* SVC VC4 initialization - optional */
+    if (dev->exp.svc.uio_opt_svc) {
+        pci_set_long(dev->config + offset + SVC_RES_CTRL(4), BIT(4) | uio_ctrl);
+    }
+}
+
+int pcie_config_uio_svc(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+
+    if (!get_uio_mandatory_svc(p)
+        || pcie_svc_cap_init(d, PCI_EXT_CAP_BASE_OFFSET, errp) < 0) {
+        return -1;
+    }
+
+    if (get_uio_optional_svc(p)) {
+        pcie_svc_set_vc4(d, true);
+    }
+
+    return 0;
+}
+
+int pcie_svc_cap_init(PCIDevice *dev, uint16_t offset, Error **errp)
+{
+    uint32_t hdr;
+
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "SVC ECAP requires PCIe");
+        return -EINVAL;
+    }
+
+    /*
+     * If no other ECAPs are present, make SVC the first at 0x100.
+     * This avoids pcie_add_capability() asserting on a non-0x100 offset.
+     */
+    hdr = pci_get_long(dev->config + PCI_CONFIG_SPACE_SIZE);
+    if (hdr == 0) {
+        offset = PCI_CONFIG_SPACE_SIZE;
+    }
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_SVC, 1, offset,
+                        PCI_EXT_CAP_SVC_SIZE);
+    dev->exp.svc_cap = offset;
+    dev->exp.svc.ctrl = 0;
+    dev->exp.svc.status = 0;
+    dev->exp.svc.uio_mand_svc = true;
+    dev->exp.svc.uio_opt_svc = false;
+
+    pci_set_long(dev->config + offset + PCIE_SVC_CAP_HEAD_OFFSET,
+                 (NEXT_CAP_OFF | PCIE_SVC_CAP_VER | PCI_EXT_CAP_ID_SVC));
+    pci_set_long(dev->wmask + offset + PCIE_SVC_CTL_OFFSET,
+                 PCIE_SVC_CTL_ENABLE);
+    pci_set_long(dev->config + offset + PCIE_SVC_CAP_OFFSET,
+                 PCIE_SVC_CAP1_EVCC);
+
+    for (int i = 0; i <= PCIE_SVC_CAP1_EVCC; i++) {
+        uint32_t res_cap_value = (1U << 8) | SVC_VC_ID(i);
+        uint32_t res_ctrl_value = SVC_TC_VC_MAP_ENABLE
+                                  | SVC_VC_PROTOCOL_SELECTED
+                                  | SHARED_FLOW_CONTROL_USAGE_LIMIT_ENABLE
+                                  | SHARED_FLOW_CONTROL_USAGE_LIMIT
+                                  | SVC_VC_ENABLE;
+
+        if (i == 0) {
+            res_cap_value = SVC_VC0_PROTOCOL | SVC_VC_ID(i);
+        } else if (i == 3) {
+            res_cap_value = SVC_VC3_PROTOCOL | SVC_VC_ID(i);
+        } else if (i == 4) {
+            res_cap_value = SVC_VC4_PROTOCOL | SVC_VC_ID(i);
+        }
+
+        pci_set_long(dev->config + offset + SVC_RES_CAP(i), res_cap_value);
+        pci_set_long(dev->wmask + offset + SVC_RES_CTRL(i), res_ctrl_value);
+        pci_set_long(dev->config + offset + SVC_RES_STATUS(i), 0);
+    }
+    pcie_svc_update_map(dev);
+    return 0;
+}
+
+void pcie_svc_cap_reset(PCIDevice *dev)
+{
+    uint32_t offset;
+
+    if (!pci_is_express(dev) || !dev->exp.svc_cap) {
+        return;
+    }
+
+    offset = dev->exp.svc_cap;
+    dev->exp.svc.ctrl = 0;
+    dev->exp.svc.status = 0;
+    pcie_svc_update_map(dev);
+    pci_set_long(dev->config + offset + PCIE_SVC_CTL_OFFSET, 0);
+    pci_set_long(dev->config + offset + PCIE_SVC_STA_OFFSET, 0);
+}
+
+void pcie_svc_set_vc4(PCIDevice *dev, bool enable)
+{
+    if (!pci_is_express(dev) || !dev->exp.svc_cap) {
+        return;
+    }
+
+    dev->exp.svc.uio_opt_svc = enable;
+    pcie_svc_update_map(dev);
+}
+
+static void pcie_svc_apply_gating(PCIDevice *dev)
+{
+    uint16_t offset = dev->exp.svc_cap;
+    uint32_t ctrl, status;
+
+    if (!offset) {
+        return;
+    }
+
+    ctrl = pci_get_long(dev->config + offset + PCIE_SVC_CTL_OFFSET);
+    status = pci_get_long(dev->config + offset + PCIE_SVC_STA_OFFSET);
+    dev->exp.svc.ctrl = ctrl;
+    dev->exp.svc.status = status;
+}
+
+void pcie_svc_cap_write_config(PCIDevice *dev,
+                               uint32_t addr, uint32_t val, int len)
+{
+    uint16_t offset = dev->exp.svc_cap;
+
+    if (!offset) {
+        return;
+    }
+
+    if (ranges_overlap(addr, len, offset + PCIE_SVC_CTL_OFFSET, 4)) {
+        pcie_svc_apply_gating(dev);
+    }
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 79808126dc..35db0f0c5e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -25,6 +25,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
+#include "hw/pci/pcie_svc.h"
 #include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
@@ -82,6 +83,10 @@ struct PCIExpressDevice {
     uint16_t sriov_cap;
     PCIESriovPF sriov_pf;
     PCIESriovVF sriov_vf;
+
+    /* Streamlined Virtual Channel (SVC) introduced from PCIe 6.1 */
+    uint16_t svc_cap;
+    PCIESvcCap svc;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -143,6 +148,8 @@ void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode);
+void pcie_cap_flit_write_config(PCIDevice *dev,
+                                uint32_t addr, uint32_t val, int len);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 33a22229fe..644da744b2 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -81,6 +81,7 @@ typedef enum PCIExpLinkWidth {
 #define PCI_EXP_DEVCAP2_EETLPP          0x200000
 
 #define PCI_EXP_DEVCTL2_EETLPPB         0x8000
+#define  PCI_EXP_LNKCTL_FLIT_DIS        0x2000
 
 /* ARI */
 #define PCI_ARI_VER                     1
diff --git a/include/hw/pci/pcie_svc.h b/include/hw/pci/pcie_svc.h
new file mode 100644
index 0000000000..4872905501
--- /dev/null
+++ b/include/hw/pci/pcie_svc.h
@@ -0,0 +1,91 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Streamlined Virtual Channel (SVC) Extended Capability
+ *
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef HW_PCIE_SVC_H
+#define HW_PCIE_SVC_H
+
+#include "hw/pci/pci.h"
+#include "qemu/bitops.h"
+
+/*
+ * The PCIe config space starts from 0x00 till 0xFF. In that
+ * extended capability starts from 0x100 and each extended capability
+ * is of dword size (32 bit). So we have to give a proper base offset
+ * value which should be >= 0x100 and <= 0xFF and in between other
+ * capability will also be registerd. We might not know where exactly
+ * SVC extended capability will sit, so to avoid the overlapping we have
+ * to give a very high offset.
+ */
+#define PCI_EXT_CAP_BASE_OFFSET                0x200
+#define PCI_EXT_CAP_ID_SVC                     0x35
+#define PCI_EXT_CAP_SVC_SIZE                   0x74
+
+/* PCIe 6.4 section 7.9.29 */
+#define PCIE_SVC_CAP_HEAD_OFFSET               0x00
+#define PCIE_SVC_CAP_OFFSET                    0x04
+#define PCIE_SVC_CTL_OFFSET                    0x0c
+#define PCIE_SVC_STA_OFFSET                    0x10
+#define PCIE_SVC_CTL_ENABLE                    BIT(0)
+#define PCIE_SVC_CAP1_EVCC                     (0x7 << 0)
+
+/* 7.9.29.1 SVC extended capability header  */
+#define PCIE_SVC_CAP_VER                       (1 << 16)
+#define NEXT_CAP_OFF                           (0 << 20)
+
+/* 7.9.29.6 SVC Resource capability Register */
+#define SVC_RES_CAP_BASE                       0x14
+#define SVC_RES_CAP(n)                         (SVC_RES_CAP_BASE + (n) * 0x0c)
+
+/*
+ * As per Specification SVC VC3 is dedicated to UIO and non-UIO traffic cannot
+ * use that, so for SVC VC3 the value would be 0010. SVC VC4 is an optional VC
+ * for UIO and VC4 can be used by non-UIO traffic as well. So the protocol for
+ * VC4 would be 0011. For SVC VC0, the protocol is 0000. Rest are all reserved
+ * asper table 2-46 in PCIe 6.4 specification.
+ */
+#define SVC_VC0_PROTOCOL                       (0x0 << 8)
+#define SVC_VC3_PROTOCOL                       (0x2 << 8)
+#define SVC_VC4_PROTOCOL                       (0x3 << 8)
+#define SVC_VC_ID(n)                           ((n & 0x7) << 12)
+
+/* 7.9.27.7 SVC Resource Control Register */
+#define SVC_RES_CTRL_BASE                      0x18
+#define SVC_RES_CTRL(n)                        (SVC_RES_CTRL_BASE + (n) * 0x0c)
+#define SVC_VC_ENABLE                          BIT(31)
+#define SHARED_FLOW_CONTROL_USAGE_LIMIT_ENABLE BIT(30)
+#define SVC_VC_PROTOCOL_SELECTED               (0xf << 8)
+#define SVC_UIO_PROTOCOL_SELECTED              (0x2 << 8)
+/*
+ * As per Table 7-350 in 7.9.29.7 in PCIe 6.4 Specification, the protocol
+ * selected should be 0010 for UIO enabled VCs
+ */
+#define SHARED_FLOW_CONTROL_USAGE_LIMIT        (0x7 << 27)
+#define SVC_TC_VC_MAP_ENABLE                   (0xff << 0)
+#define SVC_TC_VC_MAP(n)                       ((n & 0xff) << 0)
+
+/* 7.9.27.8 SVC Resource Status Register */
+#define SVC_RES_STATUS_BASE                    0x1c
+#define SVC_RES_STATUS(n)                      (SVC_RES_STATUS_BASE + \
+                                                (n) * 0x0c)
+#define SVC_VC_NEGO                            BIT(1)
+
+typedef struct PCIESvcCap {
+    uint32_t ctrl;
+    uint32_t status;
+    bool uio_mand_svc;
+    bool uio_opt_svc;
+} PCIESvcCap;
+
+int pcie_config_uio_svc(PCIDevice *d, Error **errp);
+int  pcie_svc_cap_init(PCIDevice *dev, uint16_t offset, Error **errp);
+void pcie_svc_cap_reset(PCIDevice *dev);
+void pcie_svc_set_vc4(PCIDevice *dev, bool enable);
+void pcie_svc_cap_write_config(PCIDevice *dev,
+                               uint32_t addr, uint32_t val, int len);
+
+#endif /* HW_PCIE_SVC_H */
-- 
2.34.1

