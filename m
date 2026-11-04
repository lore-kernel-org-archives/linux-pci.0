Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792294;
	b=khrJt0oFAkQ8MzQqWlMqUthCb2OZcfc5PugRRwQAa+wpF4dyeuHliAyHrsh+S45Jyhfy
	 WnWYlh/7YzjHgigFm6reiY/+9cmvifvwxrRVMt8fv32Kai4xg/DaPbbzchatqZx9YR5QX
	 y4oYETEflbOCACVaYicD0Wmj3jkySc1xBR/h8+5vUaF0Ch6ArySoHU0PjFgr+IDiEgtrA
	 yvxR8AXBxjptWor/9baahZzop048UlmWPZyx4VPaKC+vDO6TsJLWDMZnclcnf01eQicpr
	 4QN0Z1G86qZToFuBb379chNv8SecWSj4XbCPQZd6CmvzCQaK0tBrAYWSM/G63Eiyk+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792294;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=KuzFpHCFvUmiQb+Ax0Z+FfwPrcALldvleMJws1Z8LEQ=;
	b=umkyJHRrhwZ2dJx0aCgINbpfl/hYNJlhWrqgJ1mYWUOHHB54e4ho5q+uMmtidwu4kjVJ
	 AwhAjVA8BSp9KHz+K96ThjZS2E5DXSRJcY4XfKJqVqNdaITnI5l2/K+0O/v6PKnBC1RRs
	 DppY0bc73FoS+aQbqJ50rltuNSlQIYC+0GucK2D5AO054Wlsk03HYHGZyjKWEYFAFYfo1
	 B6GRSwZudG0CWQC3RXF9QLzPLwRmQZBo96vm+2JmBiyLzgeLhB+X1E99fmmRkzQnye4kW
	 Ik0nDYD/EjHhXC/knycAdvk+9zvblDkmC76jx7CSF4EFhHHXQXIlqYcZezfjxpjcnNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=cYB43TXN;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D15606D82D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D15606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=cYB43TXN
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp019ddc0a91815ac0d71031501db4dc6731~k1JRCFNBS2950729507epoutp01k
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261104113804epoutp019ddc0a91815ac0d71031501db4dc6731~k1JRCFNBS2950729507epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=KuzFpHCFvUmiQb+Ax0Z+FfwPrcALldvleMJws1Z8LEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYB43TXN+okLZ3yNboIA9UYbTYj00mTm/1EYKdNg1Ol8svZr7o4E7fmieLsTllK+i
	 ycEuKmjrq5c4NbqQu2d2jbZykdhmYe8rx+hIWyq75/QohDDI67jsiVWUfRqeje/SK9
	 dckxcVvQ6MsrHwkpI/FId3uM6gDz8QN7jHrCYvig=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261104113804epcas5p1ffba63a24925fbc35da610a67cda0965~k1JQYWYyS3116031160epcas5p1O;
	Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jKNjS0g4Sz2SSKY; Wed,  4 Nov
	2026 11:38:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113032epcas5p18ac5d856594b31b8cd7cde2f36b1aa88~k1CrWD-CT0210802108epcas5p1p;
	Wed,  4 Nov 2026 11:30:32 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113029epsmtip1e2f2f20dcc500cae5ef6291c143de947~k1CokIZ3_2364123641epsmtip1X;
	Wed,  4 Nov 2026 11:30:28 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 4/8] hw/pci: Add PCIe Streamlined Virtual Channel
 (SVC) capability
Date: Wed,  4 Nov 2026 17:22:38 +0530
Message-Id: <603443293.161793792284076.JavaMail.epsvc@epcpadp2new>
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
X-CMS-MailID: 20261104113032epcas5p18ac5d856594b31b8cd7cde2f36b1aa88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113032epcas5p18ac5d856594b31b8cd7cde2f36b1aa88
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113032epcas5p18ac5d856594b31b8cd7cde2f36b1aa88@epcas5p1.samsung.com>

From: Dongjoo Seo <dongjoo.seo1@samsung.com>

Implement the PCIe Streamlined Virtual Channel (SVC) Extended
Capability (PCIe 6.4 section 7.9.29), one of the main prerequisites
for UIO support, with the port capability, control and status
registers and a set of SVC resources.

The capability carries three SVC resources: the default VC0, a
mandatory UIO VC and an optional UIO VC. The write-config path
validates a guest's Resource Control writes against the resource
capability and rejects an invalid configuration by clearing the VC
Enable bit, and the reset path clears the software written state.

Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci/meson.build         |   2 +-
 hw/pci/pci.c               |   5 +
 hw/pci/pcie.c              |  76 ++++++++++++++-
 hw/pci/pcie_svc.c          | 185 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |   6 ++
 include/hw/pci/pcie_regs.h |  74 +++++++++++++++
 include/hw/pci/pcie_svc.h  |  20 ++++
 7 files changed, 362 insertions(+), 6 deletions(-)
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
index 5996229c81..50472cab88 100644
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
@@ -568,6 +569,8 @@ static void pci_do_device_reset(PCIDevice *dev)
     msi_reset(dev);
     msix_reset(dev);
     pcie_sriov_pf_reset(dev);
+    pcie_cap_flit_reset(dev);
+    pcie_svc_cap_reset(dev);
 }
 
 /*
@@ -1814,6 +1817,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     msi_write_config(d, addr, val_in, l);
     msix_write_config(d, addr, val_in, l);
     pcie_sriov_config_write(d, addr, val_in, l);
+    pcie_cap_flit_write_config(d, addr, l);
+    pcie_svc_cap_write_config(d, addr, val_in, l);
 }
 
 /***********************************************************/
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4f6fc9db61..b05f70022a 100644
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
 
@@ -180,7 +187,65 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));
 
-    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
+    pcie_cap_fill_lnk(dev, exp_cap, width, speed, flitmode);
+}
+
+/*
+ * Derive the read-only Flit Status bit of the Link Status 2
+ * register from the Flit Disable bit of the Link Control register.
+ */
+static void pcie_cap_flit_update_sta(PCIDevice *dev)
+{
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+    uint16_t lnkctl = pci_get_word(exp_cap + PCI_EXP_LNKCTL);
+    uint16_t lnksta2 = pci_get_word(exp_cap + PCI_EXP_LNKSTA2);
+
+    if (lnkctl & PCI_EXP_LNKCTL_FLIT_DIS) {
+        lnksta2 &= ~PCI_EXP_LNKSTA2_FLIT;
+    } else {
+        lnksta2 |= PCI_EXP_LNKSTA2_FLIT;
+    }
+
+    pci_set_word(exp_cap + PCI_EXP_LNKSTA2, lnksta2);
+}
+
+void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, int len)
+{
+    if (!pci_is_express(dev) || !dev->exp.exp_cap) {
+        return;
+    }
+
+    if (!ranges_overlap(addr, len,
+                        dev->exp.exp_cap + PCI_EXP_LNKCTL, 2)) {
+        return;
+    }
+
+    if (!(pci_get_word(dev->config + dev->exp.exp_cap + PCI_EXP_FLAGS) &
+          PCI_EXP_FLAGS_FLIT)) {
+        return;
+    }
+
+    pcie_cap_flit_update_sta(dev);
+}
+
+/*
+ * The Flit Disable bit of the Link Control register keeps its value
+ * across a device reset. Derive the Flit Status bit again from the
+ * current Flit Disable value so the two fields stay consistent after
+ * the reset.
+ */
+void pcie_cap_flit_reset(PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.exp_cap) {
+        return;
+    }
+
+    if (!(pci_get_word(dev->config + dev->exp.exp_cap + PCI_EXP_FLAGS) &
+          PCI_EXP_FLAGS_FLIT)) {
+        return;
+    }
+
+    pcie_cap_flit_update_sta(dev);
 }
 
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
@@ -217,7 +282,8 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, PCIE_PORT(s)->flitmode);
+    pcie_cap_fill_lnk(dev, exp_cap, s->width, s->speed,
+                      PCIE_PORT(s)->flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/hw/pci/pcie_svc.c b/hw/pci/pcie_svc.c
new file mode 100644
index 0000000000..38d2c732a6
--- /dev/null
+++ b/hw/pci/pcie_svc.c
@@ -0,0 +1,185 @@
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
+int pcie_svc_cap_init(PCIDevice *dev, uint32_t offset, bool flitmode,
+                      Error **errp)
+{
+    uint32_t res_ctrl_wmask;
+
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "SVC ECAP requires PCIe");
+        return -EINVAL;
+    }
+
+    pcie_add_capability(dev, PCI_SVC_CAP_ID, 1, offset,
+                        PCI_SVC_SIZEOF);
+    dev->exp.svc_cap = offset;
+
+    pci_set_long(dev->wmask + offset + PCI_SVC_CTL_OFFSET,
+                 PCI_SVC_CTL_VC_EN_CMP);
+
+    /*
+     * Per PCIe 6.4 Section 7.9.29.5, the SVC Status register resets to
+     * 0: Use VC/MFVC is 0b, meaning the port permanently uses SVC. If
+     * legacy VC/MFVC capabilities are ever implemented, the default
+     * value would need to be 1b and writing 1 to the field would
+     * enable SVC.
+     */
+    pci_set_long(dev->config + offset + PCI_SVC_STA_OFFSET, 0);
+
+    /*
+     * Per PCIe 6.4 Specification Section 7.9.29 all the register
+     * fields of set 0 are hardwired: it carries the default VC0
+     * (VC ID 000b) with the protocols of VC0 (0000b) and TC0 mapped
+     * to it.
+     */
+    pci_set_long(dev->config + offset + PCI_SVC_RES_CAP(0), 0);
+    pci_set_long(dev->config + offset + PCI_SVC_RES_CTRL(0),
+                 PCI_SVC_TC_VC_MAP(0) | PCI_SVC_VC_ENABLE);
+    pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(0), 0);
+
+    /*
+     * Bit 0 of the TC/VC map is read-only and Clear on the extended
+     * sets, and the Shared Flow Control fields are RsvdP on a port
+     * without 256-byte flit mode (7.9.29.7).
+     */
+    res_ctrl_wmask = PCI_SVC_TC_VC_MAP_RW |
+                     PCI_SVC_VC_PROTOCOL_SELECTED |
+                     PCI_SVC_VC_ENABLE;
+    if (flitmode) {
+        res_ctrl_wmask |= PCI_SVC_SHARED_FLOW_CONTROL_ENABLE |
+                          PCI_SVC_SHARED_FLOW_CONTROL_LIMIT;
+    }
+
+    /*
+     * Set 1 carries VC3 (UIO only, protocols supported 0010b) and
+     * set 2 carries VC4 (UIO or non-UIO, protocols supported 0011b),
+     * per Table 2-46 in the PCIe 6.4 specification.
+     */
+    pci_set_long(dev->config + offset + PCI_SVC_CAP_OFFSET,
+                 PCI_SVC_CAP1_EVCC);
+
+    pci_set_long(dev->config + offset + PCI_SVC_RES_CAP(1),
+                 PCI_SVC_VC_PROTOCOL_UIO |
+                 (3 << PCI_SVC_VC_ID_SHIFT));
+    pci_set_long(dev->wmask + offset + PCI_SVC_RES_CTRL(1),
+                 res_ctrl_wmask);
+    pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(1), 0);
+
+    pci_set_long(dev->config + offset + PCI_SVC_RES_CAP(2),
+                 PCI_SVC_VC_PROTOCOL_UIO_NONUIO |
+                 (4 << PCI_SVC_VC_ID_SHIFT));
+    pci_set_long(dev->wmask + offset + PCI_SVC_RES_CTRL(2),
+                 res_ctrl_wmask);
+    pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(2), 0);
+
+    return 0;
+}
+
+void pcie_svc_cap_reset(PCIDevice *dev)
+{
+    uint32_t offset;
+    int i;
+
+    if (!pci_is_express(dev) || !dev->exp.svc_cap) {
+        return;
+    }
+
+    offset = dev->exp.svc_cap;
+    pci_set_long(dev->config + offset + PCI_SVC_CTL_OFFSET, 0);
+    pci_set_long(dev->config + offset + PCI_SVC_STA_OFFSET, 0);
+
+    /*
+     * Clear the writable Resource Control registers back to their
+     * reset value as well: a guest-enabled VC would otherwise survive
+     * a system reset while the Control and Status registers are
+     * cleared.
+     */
+    for (i = 1; i <= PCI_SVC_EVCC; i++) {
+        pci_set_long(dev->config + offset + PCI_SVC_RES_CTRL(i), 0);
+        pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), 0);
+    }
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
+    int i;
+
+    if (!offset) {
+        return;
+    }
+
+    /*
+     * Validate the SVC Resource Control registers of the software
+     * enabled resource sets (set 1 carries VC3 and set 2 carries
+     * VC4) per 7.9.29.7 in the PCIe 6.4 Specification. Set 0 carries
+     * the default VC0 and all its registers are hardwired.
+     */
+    for (i = 1; i <= PCI_SVC_EVCC; i++) {
+        uint32_t res_ctrl, res_cap, res_sta, proto, vc;
+        bool valid;
+
+        if (!ranges_overlap(addr, len, offset + PCI_SVC_RES_CTRL(i), 4)) {
+            continue;
+        }
+
+        res_cap = pci_get_long(dev->config + offset +
+                                PCI_SVC_RES_CAP(i));
+        res_ctrl = pci_get_long(dev->config + offset +
+                                PCI_SVC_RES_CTRL(i));
+        res_sta = pci_get_long(dev->config + offset +
+                                PCI_SVC_RES_STATUS(i));
+
+        /* The VC carried by the set, from the SVC VC ID field */
+        vc = (res_cap & PCI_SVC_VC_ID_MASK) >> PCI_SVC_VC_ID_SHIFT;
+
+        /* Started SVC VC negotiation */
+        res_sta |= PCI_SVC_VC_NEGO;
+        pci_set_long(dev->config + offset + PCI_SVC_RES_STATUS(i), res_sta);
+
+        /*
+         * Software maps TC<vc> to the VC, per the SVC TC/VC default
+         * assignments (Table 2-46), and selects the use of the VC:
+         * 0010b selects the UIO protocols and 0001b the non-UIO
+         * protocols. The set carries the selection when its
+         * Protocols Supported field permits the use: 0010b permits
+         * the UIO protocols only and 0011b permits either use.
+         */
+        proto = res_ctrl & PCI_SVC_VC_PROTOCOL_SELECTED;
+        valid = (res_ctrl & PCI_SVC_TC_VC_MAP(vc)) &&
+                ((proto == PCI_SVC_VC_PROTOCOL_UIO &&
+                  (res_cap & PCI_SVC_VC_PROTOCOL_UIO)) ||
+                 (proto == PCI_SVC_VC_PROTOCOL_NONUIO &&
+                  (res_cap & PCI_SVC_VC_PROTOCOL_NONUIO)));
+
+        if (!valid) {
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
index 79808126dc..3d092e8871 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -25,6 +25,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
+#include "hw/pci/pcie_svc.h"
 #include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
@@ -82,6 +83,9 @@ struct PCIExpressDevice {
     uint16_t sriov_cap;
     PCIESriovPF sriov_pf;
     PCIESriovVF sriov_vf;
+
+    /* Streamlined Virtual Channel (SVC) introduced from PCIe 6.1 */
+    uint32_t svc_cap;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -143,6 +147,8 @@ void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode);
+void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, int len);
+void pcie_cap_flit_reset(PCIDevice *dev);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 33a22229fe..044b3caae4 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -81,6 +81,7 @@ typedef enum PCIExpLinkWidth {
 #define PCI_EXP_DEVCAP2_EETLPP          0x200000
 
 #define PCI_EXP_DEVCTL2_EETLPPB         0x8000
+#define PCI_EXP_LNKCTL_FLIT_DIS         0x2000
 
 /* ARI */
 #define PCI_ARI_VER                     1
@@ -182,4 +183,77 @@ typedef enum PCIExpLinkWidth {
 #define PCI_DOE_VER                     0x1
 #define PCI_DOE_SIZEOF                  24
 
+/* Streamlined Virtual Channel (SVC) PCIe 6.4 section 7.9.29 */
+#define PCI_SVC_CAP_ID                  0x35
+
+/*
+ * The capability structure is sized for the maximum SVC Extended VC
+ * Count of 7 (7.9.29.2): 0x14 bytes of port registers followed by
+ * eight resource sets of 0x0c bytes each. With EVCC 2 the register
+ * space of the resource sets beyond the enabled EVCC is reserved.
+ */
+#define PCI_SVC_SIZEOF                  0x74
+
+#define PCI_SVC_CAP_OFFSET              0x04
+#define PCI_SVC_CTL_OFFSET              0x0c
+#define PCI_SVC_STA_OFFSET              0x10
+
+/* VC Enablement Completed (7.9.29.4) */
+#define PCI_SVC_CTL_VC_EN_CMP          BIT(0)
+
+/*
+ * Two SVC resource sets beyond set 0: set 1 carries VC3 and set 2
+ * carries VC4, per Table 2-46 in the PCIe 6.4 specification. Set 0
+ * carries the default VC0 and all its registers are hardwired.
+ */
+#define PCI_SVC_EVCC                    2
+#define PCI_SVC_CAP1_EVCC               (PCI_SVC_EVCC << 0)
+
+/* 7.9.29.6 SVC Resource capability Register */
+#define PCI_SVC_RES_CAP_BASE            0x14
+#define PCI_SVC_RES_CAP(n)              (PCI_SVC_RES_CAP_BASE + ((n) * 0x0c))
+
+/*
+ * SVC VC Protocols Supported encodings (11:8), per 7.9.29.6 in the
+ * PCIe 6.4 specification: 0010b permits the UIO protocols on the VC,
+ * 0011b permits the UIO protocols or the non-UIO protocols, and
+ * 0001b permits the non-UIO protocols. Bit 9 of the field carries
+ * the UIO permission and bit 8 the non-UIO permission.
+ */
+#define PCI_SVC_VC_PROTOCOL_NONUIO      (0x1 << 8)
+#define PCI_SVC_VC_PROTOCOL_UIO         (0x2 << 8)
+#define PCI_SVC_VC_PROTOCOL_UIO_NONUIO  (0x3 << 8)
+#define PCI_SVC_VC_ID_SHIFT             12
+#define PCI_SVC_VC_ID_MASK              (0x7 << PCI_SVC_VC_ID_SHIFT)
+
+/* 7.9.29.7 SVC Resource Control Register */
+#define PCI_SVC_RES_CTRL_BASE           0x18
+#define PCI_SVC_RES_CTRL(n)             (PCI_SVC_RES_CTRL_BASE + ((n) * 0x0c))
+#define PCI_SVC_VC_ENABLE               BIT(31)
+#define PCI_SVC_SHARED_FLOW_CONTROL_ENABLE  BIT(30)
+
+/*
+ * SVC VC Protocol Selected field (11:8): software selects 0010b to
+ * use the UIO protocols on the VC and 0001b to use the non-UIO
+ * protocols, per 7.9.29.7 in the PCIe 6.4 specification. The other
+ * encodings of the field are reserved.
+ */
+#define PCI_SVC_VC_PROTOCOL_SELECTED    (0xf << 8)
+#define PCI_SVC_SHARED_FLOW_CONTROL_LIMIT   (0x7 << 27)
+#define PCI_SVC_TC_VC_MAP_ENABLE        (0xff << 0)
+
+/*
+ * Bit 0 of the TC/VC map is read-only: Set for the default VC0 and
+ * Clear for the other VCs (7.9.29.7).
+ */
+#define PCI_SVC_TC_VC_MAP_RW            (0xfe << 0)
+
+/* Bit n of the field carries the mapping of TCn (7.9.29.7) */
+#define PCI_SVC_TC_VC_MAP(n)            (BIT(n) & PCI_SVC_TC_VC_MAP_ENABLE)
+
+/* 7.9.29.8 SVC Resource Status Register */
+#define PCI_SVC_RES_STATUS_BASE         0x1c
+#define PCI_SVC_RES_STATUS(n)           (PCI_SVC_RES_STATUS_BASE + ((n) * 0x0c))
+#define PCI_SVC_VC_NEGO                 BIT(1)
+
 #endif /* QEMU_PCIE_REGS_H */
diff --git a/include/hw/pci/pcie_svc.h b/include/hw/pci/pcie_svc.h
new file mode 100644
index 0000000000..6f52dc0a1c
--- /dev/null
+++ b/include/hw/pci/pcie_svc.h
@@ -0,0 +1,20 @@
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
+int  pcie_svc_cap_init(PCIDevice *dev, uint32_t offset, bool flitmode,
+                       Error **errp);
+void pcie_svc_cap_reset(PCIDevice *dev);
+void pcie_svc_cap_write_config(PCIDevice *dev,
+                               uint32_t addr, uint32_t val, int len);
+
+#endif /* HW_PCIE_SVC_H */
-- 
2.34.1


