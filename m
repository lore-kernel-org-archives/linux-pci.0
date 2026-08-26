Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC913B6C15
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732290; cv=none; b=NW0JjwGn58/L5bDXXIgxEvt80GJmZ27u/qb/us929gzsX+mnbi1+ClLbvwRwga6n4Cj5rDNgbFvH53t8705vudLKwMnKRbICTEoWFqR++1aYy3TDHpvjHocnoFcJOUx8m8cvb4kSElH4CKL8WkUVaRv/vWsbkAj5vqKytL9zljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732290; c=relaxed/simple;
	bh=bvwXbHRjC19Ie4IbfzQ3wCAJQe92cD5GTk9gek5VOf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CoDPtrrfua5QeuRh+yS/WfDW9WWSb5e/OUY/hJSCc+WcOqKBJPVWxMbUyoMHT69sSWLGDm+TsKUol8TTYIQasLZpngnuGfAi+HxqUEj9qTCvhJzX9x42G3IzhiTJD8QzeTeNOuS1bat9do+oR4DbIdhHa5GaLjugFgp8gWyn56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M2tp4doL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M2tp4doL"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260826081803epoutp017ef88c0b1da1324e69db99096fbf1ef8~PTQorDyc80683206832epoutp01V
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260826081803epoutp017ef88c0b1da1324e69db99096fbf1ef8~PTQorDyc80683206832epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732283;
	bh=2qTWcOZK/nSLc9QZo8LUDBQDy43N+D8g2PEZ1/Pg0k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2tp4doLSjMV5e+yvnn5RXBPTaxTj+xbdSZG9uGaOMVa8QkplFRWSDPoW8mJpw6dD
	 rDf/V1GAoy6lXBSOHxoDIDF9wThjqNjz6ZwJnrgJj/HKK+L7HF07daMaY3u9xgZla7
	 YbS+PsE5yEKNGV1uWFb3xreaDMOD8jzBfa+wX2cU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260826081802epcas5p34aa7943ad4c64629c0dfdf58509a9f76~PTQoAuUT91604416044epcas5p3A;
	Wed, 26 Aug 2026 08:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hVHZy2t1gz3hhTZ; Wed, 26 Aug
	2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052041epcas5p294f738886c71751fd9cf7c6483b85f7d~PQ1xifrgZ3053730537epcas5p28;
	Wed, 26 Aug 2026 05:20:41 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052039epsmtip2212477fd67877ea5f3901394955d3a20~PQ1voRl1_1150511505epsmtip2H;
	Wed, 26 Aug 2026 05:20:38 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 06/10] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Date: Wed, 26 Aug 2026 11:04:06 +0530
Message-Id: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052041epcas5p294f738886c71751fd9cf7c6483b85f7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052041epcas5p294f738886c71751fd9cf7c6483b85f7d
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052041epcas5p294f738886c71751fd9cf7c6483b85f7d@epcas5p2.samsung.com>

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
 hw/pci/pcie.c              |  53 +++++++++-
 hw/pci/pcie_svc.c          | 192 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |   7 ++
 include/hw/pci/pcie_regs.h |  55 +++++++++++
 include/hw/pci/pcie_svc.h  |  26 +++++
 7 files changed, 333 insertions(+), 6 deletions(-)
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
index 4f6fc9db61..cc1cc500ab 100644
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
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
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
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, PCIE_PORT(s)->flitmode);
+    pcie_cap_fill_lnk(dev, exp_cap, s->width, s->speed,
+                      PCIE_PORT(s)->flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/hw/pci/pcie_svc.c b/hw/pci/pcie_svc.c
new file mode 100644
index 0000000000..65958ef202
--- /dev/null
+++ b/hw/pci/pcie_svc.c
@@ -0,0 +1,192 @@
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
+static void pcie_svc_update_map(PCIDevice *dev, int tc)
+{
+    dev->exp.svc.tc_vc_map[tc] = true;
+    if (tc == 3) {
+        dev->exp.svc.uio_mand_svc = true;
+    } else if (tc == 4) {
+        dev->exp.svc.uio_opt_svc = true;
+    }
+}
+
+int pcie_svc_cap_init(PCIDevice *dev, uint32_t offset, Error **errp)
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
+    pcie_add_capability(dev, PCI_SVC_CAP_ID, 1, offset,
+                        PCI_SVC_SIZEOF);
+    dev->exp.svc_cap = offset;
+
+    pci_set_long(dev->config + offset + PCI_SVC_HEAD_OFFSET,
+                 (PCI_SVC_NEXT_CAP_OFF | PCI_SVC_VER | PCI_SVC_CAP_ID));
+    pci_set_long(dev->wmask + offset + PCI_SVC_CTL_OFFSET,
+                 PCI_SVC_CTL_ENABLE);
+    pci_set_long(dev->config + offset + PCI_SVC_CAP_OFFSET,
+                 PCI_SVC_CAP1_EVCC);
+
+    /*
+     * Per PCIe 6.4 Section 7.9.29.5, writing 1 to the field Use VC/MFVC clears
+     * it and enables SVC. As of now there is no legacy VC/MFVC capabilities
+     * are implemented, so hardwiring it to 0 to use SVC permanently. In future
+     * if legacy VC/MFVCs are implemented then the default value should be 1b
+     * and writing 1 to it will enable SVC.
+     */
+    pci_long_test_and_set_mask(dev->config + offset + PCI_SVC_STA_OFFSET,
+                               PCI_SVC_USE_VC_MFVC);
+    dev->exp.svc.svc_evcc = PCI_SVC_CAP1_EVCC;
+
+    /*
+     * Per Table 2-46 in PCIe 6.4 specification, SVCs 0, 3 and 4 are
+     * initialized, rest are all maintained reserved.
+     */
+    for (int i = 0; i <= PCI_SVC_CAP1_EVCC; i++) {
+        uint32_t res_cap_value = (1U << 8) | PCI_SVC_VC_ID(i);
+        uint32_t res_ctrl_value = PCI_SVC_TC_VC_MAP_ENABLE
+                                  | PCI_SVC_VC_PROTOCOL_SELECTED
+                                  | PCI_SHARED_FLOW_CONTROL_ENABLE
+                                  | PCI_SHARED_FLOW_CONTROL_LIMIT
+                                  | PCI_SVC_VC_ENABLE;
+        /*
+         * Per PCIe 6.4 Specification Section 7.9.29 all the register fields
+         * of SVC 0 are hardwired.
+         */
+        if (i == 0) {
+            res_cap_value = PCI_SVC_VC0_PROTOCOL | PCI_SVC_VC_ID(i);
+            res_ctrl_value = BIT(0) | PCI_SVC_VC0_PROTOCOL | PCI_SVC_VC_ENABLE;
+            pci_set_long(dev->config + offset + PCI_SVC_RES_CTRL(i),
+                         res_ctrl_value);
+            pci_set_long(dev->config + offset + PCI_SVC_RES_CAP(i),
+                         res_cap_value);
+            pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), 0);
+            pci_long_test_and_clear_mask(dev->config + offset +
+                                         PCI_SVC_RES_STATUS(i),
+                                         PCI_SVC_VC_NEGO);
+            continue;
+        } else if (i == 3) {
+            res_cap_value = PCI_SVC_VC3_PROTOCOL | PCI_SVC_VC_ID(i);
+        } else if (i == 4) {
+            res_cap_value = PCI_SVC_VC4_PROTOCOL | PCI_SVC_VC_ID(i);
+        } else {
+            continue;
+        }
+
+        pci_set_long(dev->config + offset + PCI_SVC_RES_CAP(i), res_cap_value);
+        pci_set_long(dev->wmask + offset + PCI_SVC_RES_CTRL(i), res_ctrl_value);
+        pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), 0);
+    }
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
+    pci_set_long(dev->config + offset + PCI_SVC_CTL_OFFSET, 0);
+    pci_set_long(dev->config + offset + PCI_SVC_STA_OFFSET, 0);
+}
+
+/*
+ * Since QEMU doesn't emulate the Flow control states, this function verifies
+ * the SVC VC enablement done by the software and once done, it clears the
+ * "SVC VC Negotiation pending" bit of SVC Resource status Register. Ideally
+ * The hardware should clear this while exiting from FC_INIT2 state.
+ */
+void pcie_svc_cap_write_config(PCIDevice *dev,
+                               uint32_t addr, uint32_t val, int len)
+{
+    uint32_t offset = dev->exp.svc_cap;
+
+    if (!offset) {
+        return;
+    }
+
+    /*
+     * SVC control register validation per Table 2-46 in PCIe 6.4
+     * Specification.
+     */
+    for (int i = 3; i <= 4; i++) {
+        if (!ranges_overlap(addr, len, offset + PCI_SVC_RES_CTRL(i), 4)) {
+            continue;
+        }
+
+        uint32_t res_ctrl = pci_get_long(dev->config + offset +
+                                         PCI_SVC_RES_CTRL(i));
+        uint32_t res_cap = pci_get_long(dev->config + offset +
+                                        PCI_SVC_RES_CAP(i));
+        uint32_t res_sta = pci_get_long(dev->config + offset +
+                                        PCI_SVC_RES_STATUS(i));
+
+        /* Started SVC VC negotiation */
+        res_sta |= PCI_SVC_VC_NEGO;
+        pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), res_sta);
+
+        bool valid = true;
+        if (res_ctrl & SVC_UIO_PROTOCOL_SELECTED) {
+
+            /*
+             * Checking if the selected protocol is supported in the SVC and
+             * Checking TC-VC maping set by the software, per table
+             * 2-46 in PCIe 6.4 specification, where it mentions the
+             * mappings, TC3-VC3 and TC4-VC4.
+             */
+            if (!(res_cap & PCI_SVC_VC_PROTOCOL_UIO) || !(res_ctrl & BIT(i))) {
+                valid = false;
+            }
+        } else {
+
+            /*
+             * SVC3 is only meant for UIO TLPs and The non-UIO protocol 0000
+             * should be for VC0 only. Also checking the TC-VC mapping.
+             */
+            if ((i == 3) || (res_ctrl & PCI_SVC_VC0_PROTOCOL) ||
+                 !(res_ctrl & BIT(i))) {
+                valid = false;
+            }
+        }
+
+        if (valid) {
+            pcie_svc_update_map(dev, i);
+        } else {
+            pci_long_test_and_clear_mask(dev->config + offset +
+                                         PCI_SVC_RES_CTRL(i),
+                                         PCI_SVC_VC_ENABLE);
+        }
+
+        /* SVC Negotiation completed */
+        res_sta &= ~PCI_SVC_VC_NEGO;
+        pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), res_sta);
+    }
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 79808126dc..2feeb022f0 100644
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
+    uint32_t svc_cap;
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
index 33a22229fe..566754646c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -81,6 +81,7 @@ typedef enum PCIExpLinkWidth {
 #define PCI_EXP_DEVCAP2_EETLPP          0x200000
 
 #define PCI_EXP_DEVCTL2_EETLPPB         0x8000
+#define  PCI_EXP_LNKCTL_FLIT_DIS        0x2000
 
 /* ARI */
 #define PCI_ARI_VER                     1
@@ -182,4 +183,58 @@ typedef enum PCIExpLinkWidth {
 #define PCI_DOE_VER                     0x1
 #define PCI_DOE_SIZEOF                  24
 
+/* Streamlined Virtual Channel (SVC) PCIe 6.4 section 7.9.29 */
+#define PCI_SVC_CAP_ID                  0x35
+#define PCI_SVC_SIZEOF                  0x74
+
+#define PCI_SVC_HEAD_OFFSET             0x00
+#define PCI_SVC_CAP_OFFSET              0x04
+#define PCI_SVC_CTL_OFFSET              0x0c
+#define PCI_SVC_STA_OFFSET              0x10
+#define PCI_SVC_CTL_ENABLE              BIT(0)
+#define PCI_SVC_USE_VC_MFVC             BIT(0)
+#define PCI_SVC_CAP1_EVCC               (0x7 << 0)
+
+/* 7.9.29.1 SVC extended capability header  */
+#define PCI_SVC_VER                     (1 << 16)
+#define PCI_SVC_NEXT_CAP_OFF            (0 << 20)
+
+/* 7.9.29.6 SVC Resource capability Register */
+#define PCI_SVC_RES_CAP_BASE            0x14
+#define PCI_SVC_RES_CAP(n)              (PCI_SVC_RES_CAP_BASE + ((n) * 0x0c))
+#define PCI_SVC_VC_PROTOCOL_UIO         BIT(9)
+
+/*
+ * As per Specification SVC VC3 is dedicated to UIO and non-UIO traffic cannot
+ * use that, so for SVC VC3 the value would be 0010. SVC VC4 is an optional VC
+ * for UIO and VC4 can be used by non-UIO traffic as well. So the protocol for
+ * VC4 would be 0011. For SVC VC0, the protocol is 0000. Rest are all reserved
+ * asper table 2-46 in PCIe 6.4 specification.
+ */
+#define PCI_SVC_VC0_PROTOCOL            (0x0 << 8)
+#define PCI_SVC_VC3_PROTOCOL            (0x2 << 8)
+#define PCI_SVC_VC4_PROTOCOL            (0x3 << 8)
+#define PCI_SVC_VC_ID(n)                ((n & 0x7) << 12)
+
+/* 7.9.27.7 SVC Resource Control Register */
+#define PCI_SVC_RES_CTRL_BASE           0x18
+#define PCI_SVC_RES_CTRL(n)             (PCI_SVC_RES_CTRL_BASE + ((n) * 0x0c))
+#define PCI_SVC_VC_ENABLE               BIT(31)
+#define PCI_SHARED_FLOW_CONTROL_ENABLE  BIT(30)
+#define PCI_SVC_VC_PROTOCOL_SELECTED    (0xf << 8)
+#define SVC_UIO_PROTOCOL_SELECTED       (0x2 << 8)
+#define SVC_NON_UIO_PROTOCOL_SELECTED   (0x1 << 8)
+/*
+ * As per Table 7-350 in 7.9.29.7 in PCIe 6.4 Specification, the protocol
+ * selected should be 0010 for UIO enabled VCs
+ */
+#define PCI_SHARED_FLOW_CONTROL_LIMIT   (0x7 << 27)
+#define PCI_SVC_TC_VC_MAP_ENABLE        (0xff << 0)
+#define PCI_SVC_TC_VC_MAP(n)            ((n & 0xff) << 0)
+
+/* 7.9.27.8 SVC Resource Status Register */
+#define PCI_SVC_RES_STATUS_BASE         0x1c
+#define PCI_SVC_RES_STATUS(n)           (PCI_SVC_RES_STATUS_BASE + ((n) * 0x0c))
+#define PCI_SVC_VC_NEGO                 BIT(1)
+
 #endif /* QEMU_PCIE_REGS_H */
diff --git a/include/hw/pci/pcie_svc.h b/include/hw/pci/pcie_svc.h
new file mode 100644
index 0000000000..23957752c9
--- /dev/null
+++ b/include/hw/pci/pcie_svc.h
@@ -0,0 +1,26 @@
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
+
+typedef struct PCIESvcCap {
+    uint8_t svc_evcc;
+    bool uio_mand_svc;
+    bool uio_opt_svc;
+    bool tc_vc_map[8];
+} PCIESvcCap;
+
+int  pcie_svc_cap_init(PCIDevice *dev, uint32_t offset, Error **errp);
+void pcie_svc_cap_reset(PCIDevice *dev);
+void pcie_svc_cap_write_config(PCIDevice *dev,
+                               uint32_t addr, uint32_t val, int len);
+
+#endif /* HW_PCIE_SVC_H */
-- 
2.34.1


