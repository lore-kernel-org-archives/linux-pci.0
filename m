Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49883B810D
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732115; cv=none; b=CNZ8N1b5ieF6Y1u8TMFYfT60VJpKiIwO1YsE44AyHOQePloZEow2qw+YNPpUEuFJcJodRJ392MikugCd3+1stdZR7xh3FlZOagt0SCExKgdKDvonrgW9DNX/jU8LNcDvszQ5fN0h9xtI0hpSdzNUvvLmyItspF894/kqIz1J6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732115; c=relaxed/simple;
	bh=g1Q45ddDeNhUZkbiAsNNfdSxPR65I2ME3iqMkhKNZng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YmNfnKD5n3+D+r0jhBhsiq1ODLfaMgMVsfUXwCAdCchYZ8KlndJGvV883jTzxiUnSqhsTBDR1lL7kd/qQwa0L3TKG5X35kL+xAAW7Afz+wjTQ2wh3h58zcmXHbZqDgRfPX2QcUUy67Ry5J/Du7Nb54CVWn93b9l4I37FYE3daXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GMa5v5a9; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GMa5v5a9"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260826081504epoutp01617133af7eaff3f19a88c5b8f5e3cb3f~PTOCWu5JC0680206802epoutp01N
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:15:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260826081504epoutp01617133af7eaff3f19a88c5b8f5e3cb3f~PTOCWu5JC0680206802epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732104;
	bh=Wv6UPx85/ZnMqlppmnqTJxVYrPvDVQZx5wcynwVXSFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMa5v5a96VxgQNSyNx9QudnI2B2UPhO9lNSxTPJDZKNpTu1s/BTeWt6/28NH8rJ1I
	 WwsyMkA4HVCe1ioVFh3CElKQzJ/Ork44ZuooqETlBhkgFkdO4oKz4vPfuwTMpJwPUN
	 6IbJEnZ6vo8hF9HXgxl//VALxvMiUQbRxmY4ACEQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260826081504epcas5p1fb575937bd5b558ff0f74dd00f26e578~PTOB9ENH82310023100epcas5p1J;
	Wed, 26 Aug 2026 08:15:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hVHWX0nPhz2SSKh; Wed, 26 Aug
	2026 08:15:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260826052051epcas5p38346ca5980b1e3dd93046eae6376c06e~PQ17Jilrw0827908279epcas5p3Q;
	Wed, 26 Aug 2026 05:20:51 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052049epsmtip25273e22ffa98551a919dfc4f3271247e~PQ15RqPej1150511505epsmtip2e;
	Wed, 26 Aug 2026 05:20:49 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 08/10] hw/pci: Add PCIe Device3 capability support
Date: Wed, 26 Aug 2026 11:04:08 +0530
Message-Id: <2044366277.121787732104098.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052051epcas5p38346ca5980b1e3dd93046eae6376c06e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052051epcas5p38346ca5980b1e3dd93046eae6376c06e
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052051epcas5p38346ca5980b1e3dd93046eae6376c06e@epcas5p3.samsung.com>

This commit adds Device3 support to the PCIe devices, with which
an endpoint can be exposed as a UIO requester or completer, based
on its configuration.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/mem/cxl_type3.c         |   1 +
 hw/pci/meson.build         |   2 +-
 hw/pci/pci.c               |   2 +
 hw/pci/pcie.c              |  30 +++++++
 hw/pci/pcie_dev3.c         | 165 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |   6 ++
 include/hw/pci/pcie_dev3.h |  29 +++++++
 include/hw/pci/pcie_regs.h |  30 +++++++
 8 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci/pcie_dev3.c
 create mode 100644 include/hw/pci/pcie_dev3.h

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 24bf4f8309..0adf2e8b3e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,6 +17,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pcie_dev3.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index d55882a0c9..0a7f3b162a 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -14,7 +14,7 @@ pci_ss.add(files(
 # The functions in these modules can be used by devices too.  Since we
 # allow plugging PCIe devices into PCI buses, include them even if
 # CONFIG_PCI_EXPRESS=n.
-pci_ss.add(files('pcie.c', 'pcie_aer.c', 'pcie_svc.c'))
+pci_ss.add(files('pcie.c', 'pcie_aer.c', 'pcie_svc.c', 'pcie_dev3.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0469250f42..600f41fc95 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -570,6 +570,7 @@ static void pci_do_device_reset(PCIDevice *dev)
     msix_reset(dev);
     pcie_sriov_pf_reset(dev);
     pcie_svc_cap_reset(dev);
+    pcie_dev3_cap_reset(dev);
 }
 
 /*
@@ -1818,6 +1819,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     pcie_sriov_config_write(d, addr, val_in, l);
     pcie_cap_flit_write_config(d, addr, val_in, l);
     pcie_svc_cap_write_config(d, addr, val_in, l);
+    pcie_dev3_cap_write_config(d, addr, val_in, l);
 }
 
 /***********************************************************/
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index cc1cc500ab..6b8cc0f948 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -190,6 +190,32 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
     pcie_cap_fill_lnk(dev, exp_cap, width, speed, flitmode);
 }
 
+bool pcie_link_flit_active(PCIDevice *dev)
+{
+    uint8_t *exp_cap;
+    uint16_t lnksta2;
+    uint16_t lnkctl;
+    uint16_t flags;
+
+    if (!pci_is_express(dev) || !dev->exp.exp_cap) {
+        return false;
+    }
+
+    exp_cap = dev->config + dev->exp.exp_cap;
+    flags = pci_get_word(exp_cap + PCI_EXP_FLAGS);
+    if (!(flags & PCI_EXP_FLAGS_FLIT)) {
+        return false;
+    }
+    lnkctl = pci_get_word(exp_cap + PCI_EXP_LNKCTL);
+    lnksta2 = pci_get_word(exp_cap + PCI_EXP_LNKSTA2);
+
+    if (lnkctl & PCI_EXP_LNKCTL_FLIT_DIS) {
+        return false;
+    }
+
+    return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
 void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
                                 int len)
 {
@@ -223,6 +249,10 @@ void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
     }
 
     pci_set_word(exp_cap + PCI_EXP_LNKSTA2, lnksta2);
+    if (dev->exp.dev3_cap) {
+        pcie_dev3_cap_flit_update(dev);
+    }
+
  }
 
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
diff --git a/hw/pci/pcie_dev3.c b/hw/pci/pcie_dev3.c
new file mode 100644
index 0000000000..d6794bd3fe
--- /dev/null
+++ b/hw/pci/pcie_dev3.c
@@ -0,0 +1,165 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Device3 Extended Capability
+ *
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/pci/pcie_dev3.h"
+
+static uint32_t pcie_dev3_cap_offset(PCIDevice *dev)
+{
+    return dev->exp.dev3_cap;
+}
+
+int pcie_dev3_cap_init(PCIDevice *dev, uint32_t offset,
+                       bool uio_req, bool uio_comp, Error **errp)
+{
+    uint32_t devcap3 = 0;
+    uint32_t wmask = 0;
+
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "Device 3 ECAP requires PCIe");
+        return -EINVAL;
+    }
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_DEV3, 1, offset, PCI_DEV3_SIZEOF);
+    pci_set_long(dev->config + offset + PCI_DEV3_CAP_HEAD,
+                 (PCI_DEV3_CAP_ID | PCI_DEV3_CAP_VER |
+                  PCI_DEV3_NEXT_CAP_OFF));
+    dev->exp.dev3_cap = offset;
+    dev->exp.dev3.uio_req = uio_req;
+    dev->exp.dev3.uio_comp = uio_comp;
+
+    /*
+     * In this implementation, 14-bit tag support is only advertised
+     * when UIO is enabled. A real device may support 14-bit tags
+     * independently of UIO.
+     */
+    if (uio_comp) {
+        devcap3 |= PCI_DEV3_CAP_TAG_COMP | PCI_DEV3_CAP_UIO_COMP;
+    }
+    if (uio_req) {
+        devcap3 |= PCI_DEV3_CAP_TAG_REQ | PCI_DEV3_CAP_UIO_REQ;
+        wmask |= PCI_DEV3_CTL_TAG_REQ_EN |
+                 PCI_DEV3_CTL_UIO_REQ_EN |
+                 PCI_DEV3_CTL_UIO_256B_DIS;
+        /*
+         * A UIO requester must be able to issue DMA transactions.
+         * Enable PCI_COMMAND_MASTER in the PCI command register so the
+         * device's bus master bit is set when the requester capability
+         * is advertised.
+         */
+        pci_set_word(dev->config + PCI_COMMAND,
+                     pci_get_word(dev->config + PCI_COMMAND) |
+                     PCI_COMMAND_MASTER);
+    }
+
+    pci_set_long(dev->config + offset + PCI_DEV3_CAP_OFFSET, devcap3);
+    pci_set_long(dev->wmask + offset + PCI_DEV3_CTL_OFFSET, wmask);
+
+    return 0;
+}
+
+void pcie_dev3_cap_reset(PCIDevice *dev)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+
+    if (!off) {
+        return;
+    }
+
+    pci_set_long(dev->config + off + PCI_DEV3_CTL_OFFSET, 0);
+    pci_set_long(dev->config + off + PCI_DEV3_STA_OFFSET, 0);
+    pcie_dev3_apply_gating(dev);
+}
+
+void pcie_dev3_apply_gating(PCIDevice *dev)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+    uint32_t devctl3;
+    uint32_t devsta3;
+    bool flit;
+
+    if (!off) {
+        return;
+    }
+
+    flit = pcie_link_flit_active(dev);
+    devctl3 = pci_get_long(dev->config + off + PCI_DEV3_CTL_OFFSET);
+    devsta3 = pci_get_long(dev->config + off + PCI_DEV3_STA_OFFSET);
+    if (!dev->exp.dev3.uio_req || !flit) {
+        devctl3 &= ~(PCI_DEV3_CTL_TAG_REQ_EN |
+                     PCI_DEV3_CTL_UIO_REQ_EN |
+                     PCI_DEV3_CTL_UIO_256B_DIS);
+        pci_set_long(dev->config + off + PCI_DEV3_CTL_OFFSET, devctl3);
+    }
+
+    if (flit) {
+        devsta3 |= PCI_DEV3_STA_SEGMENT_CAP;
+    } else {
+        devsta3 &= ~PCI_DEV3_STA_SEGMENT_CAP;
+    }
+    pci_set_long(dev->config + off + PCI_DEV3_STA_OFFSET, devsta3);
+}
+
+void pcie_dev3_cap_write_config(PCIDevice *dev,
+                                uint32_t addr, uint32_t val, int len)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+
+    if (!off) {
+        return;
+    }
+
+    if (ranges_overlap(addr, len, off + PCI_DEV3_CTL_OFFSET, 4)) {
+        pcie_dev3_apply_gating(dev);
+    }
+}
+
+void pcie_dev3_cap_flit_update(PCIDevice *dev)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+    if (!off) {
+        return;
+    }
+
+    uint32_t devsta3 = pci_get_long(dev->config + off + PCI_DEV3_STA_OFFSET);
+    if (pcie_link_flit_active(dev)) {
+        devsta3 |= PCI_DEV3_STA_SEGMENT_CAP;
+    } else {
+        devsta3 &= ~PCI_DEV3_STA_SEGMENT_CAP;
+    }
+    pci_set_long(dev->config + off + PCI_DEV3_STA_OFFSET, devsta3);
+}
+
+bool pcie_dev3_uio_enabled(PCIDevice *dev)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+    uint32_t devctl3;
+
+    if (!off || !dev->exp.dev3.uio_req || !pcie_link_flit_active(dev)) {
+        return false;
+    }
+
+    devctl3 = pci_get_long(dev->config + off + PCI_DEV3_CTL_OFFSET);
+    return devctl3 & PCI_DEV3_CTL_UIO_REQ_EN;
+}
+
+bool pcie_dev3_tag_req_enabled(PCIDevice *dev)
+{
+    uint32_t off = pcie_dev3_cap_offset(dev);
+    uint32_t devctl3;
+
+    if (!off || !dev->exp.dev3.uio_req || !pcie_link_flit_active(dev)) {
+        return false;
+    }
+
+    devctl3 = pci_get_long(dev->config + off + PCI_DEV3_CTL_OFFSET);
+    return devctl3 & PCI_DEV3_CTL_TAG_REQ_EN;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 2feeb022f0..e997f3a456 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -26,6 +26,7 @@
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
 #include "hw/pci/pcie_svc.h"
+#include "hw/pci/pcie_dev3.h"
 #include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
@@ -87,6 +88,10 @@ struct PCIExpressDevice {
     /* Streamlined Virtual Channel (SVC) introduced from PCIe 6.1 */
     uint32_t svc_cap;
     PCIESvcCap svc;
+
+    /* PCIe Device 3 Capability */
+    uint32_t dev3_cap;
+    struct PCIEDev3Cap dev3;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -150,6 +155,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode);
 void pcie_cap_flit_write_config(PCIDevice *dev,
                                 uint32_t addr, uint32_t val, int len);
+bool pcie_link_flit_active(PCIDevice *dev);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_dev3.h b/include/hw/pci/pcie_dev3.h
new file mode 100644
index 0000000000..0a49835ab4
--- /dev/null
+++ b/include/hw/pci/pcie_dev3.h
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Device3 Extended Capability
+ *
+ * Copyright (c) 2026 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef HW_PCIE_DEV3_H
+#define HW_PCIE_DEV3_H
+
+#include "hw/pci/pci.h"
+
+typedef struct PCIEDev3Cap {
+    bool uio_req;
+    bool uio_comp;
+} PCIEDev3Cap;
+
+int pcie_dev3_cap_init(PCIDevice *dev, uint32_t offset,
+                       bool uio_req, bool uio_comp, Error **errp);
+void pcie_dev3_cap_reset(PCIDevice *dev);
+void pcie_dev3_cap_write_config(PCIDevice *dev,
+                                uint32_t addr, uint32_t val, int len);
+void pcie_dev3_cap_flit_update(PCIDevice *dev);
+bool pcie_dev3_uio_enabled(PCIDevice *dev);
+bool pcie_dev3_tag_req_enabled(PCIDevice *dev);
+void pcie_dev3_apply_gating(PCIDevice *dev);
+
+#endif /* HW_PCIE_DEV3_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 566754646c..326195a199 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -237,4 +237,34 @@ typedef enum PCIExpLinkWidth {
 #define PCI_SVC_RES_STATUS(n)           (PCI_SVC_RES_STATUS_BASE + ((n) * 0x0c))
 #define PCI_SVC_VC_NEGO                 BIT(1)
 
+/* PCIe Device 3 capability structure. PCIe 6.4 Specification Section 7.7.9 */
+#define PCI_EXT_CAP_ID_DEV3 0x2f
+
+#define PCI_DEV3_CAP_HEAD              0x00
+#define PCI_DEV3_CAP_OFFSET            0x04
+#define PCI_DEV3_CTL_OFFSET            0x08
+#define PCI_DEV3_STA_OFFSET            0x0c
+#define PCI_DEV3_SIZEOF                0x10
+
+/* Section 7.7.9.1 Device 3 Extended Capability Header. */
+#define PCI_DEV3_CAP_ID                (0x2f << 0)
+#define PCI_DEV3_CAP_VER               (0x1 << 16)
+#define PCI_DEV3_NEXT_CAP_OFF          (0x0 << 20)
+
+/* Section 7.7.9.3 Device 3 capability register */
+#define PCI_DMWR_REQ_SUPPORTED         BIT(0)
+#define PCI_DEV3_CAP_TAG_COMP          BIT(1)
+#define PCI_DEV3_CAP_TAG_REQ           BIT(2)
+#define PCI_L0P_SUPPORTED              BIT(3)
+#define PCI_DEV3_CAP_UIO_COMP          BIT(10)
+#define PCI_DEV3_CAP_UIO_REQ           BIT(11)
+
+/* Section 7.7.9.3 Device Control 3 Register */
+#define PCI_DEV3_CTL_TAG_REQ_EN        BIT(2)
+#define PCI_DEV3_CTL_UIO_REQ_EN        BIT(7)
+#define PCI_DEV3_CTL_UIO_256B_DIS      BIT(8)
+
+/* Section 7.7.9.4 Device Status 3 Register */
+#define PCI_DEV3_STA_SEGMENT_CAP       BIT(3)
+
 #endif /* QEMU_PCIE_REGS_H */
-- 
2.34.1


