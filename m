Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792288;
	b=OOXfHfBYoe3PMPqpS1jZBKnfnVH2HOrCof1MQjC/XGP0tNHqWSSCS8Oi51K1Acfd2aJz
	 6YPwGCZgiu2g9v5ET0IpUOtkoH12OD7M0b/7MVNKfWpMP66qtMo4CCmMKGpC3zKx9tGm8
	 K60K1lzyF1niszpd02w1EeipSB/KMrAmjKtGo+++DxAY/D25YPyY83/1bcChg/xMqKGNi
	 ynG3l+Z39eCRAok/GUG2bzaM5DpO8YVHUxrabrUR77WDm4tdm6mvMWawZ6SG7/3ZXjZrN
	 OvzohzDSic31ci9Cc8Ti5d7+wJXECIM248kTTLswVf1a4glxZRSikC8oinIZ+8XBX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792288;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=zMRYwjo0X/qwb12AaABRJljD34IxFgc+zPdctLsCiBA=;
	b=vQoh0gPhpIF9rat3yjQ4IHu422MNb87ZClrNTYUW5/Ez3UGDE/Ih2ElawpiJqGa2y6g4
	 u2lTa1fWD5rmKn0nCzDfZXpONjCVbGXVgT0jFb+tM6KLm5TRvHeB4lFSojuefv6noitGH
	 6cceSOj8boJ5C5UgGMqEwvhiiWGOSXV2LjkjG+oVUIFF/ot6NNpz+8c6QEV6605tVGZdr
	 4zaBAdM8FB7KV7lISaWilRsq4Wzs/W9dVmrzMj6jKbrL0RNsderlLH2xbiKhnuCCrL3Xw
	 Ii1kflskXcYuDfpYAN2mC9KARPKMpR9zHBCL+wJ6ckjeDJVN8IL19ZZUzOZ6pRFD+Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HIvMw3x5;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2A606D824
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE2A606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HIvMw3x5
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp022d87b32f207e72fefb46db3cebfbd087~k1JQ-1qXW1883318833epoutp02C
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261104113804epoutp022d87b32f207e72fefb46db3cebfbd087~k1JQ-1qXW1883318833epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=zMRYwjo0X/qwb12AaABRJljD34IxFgc+zPdctLsCiBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIvMw3x5U9xA37avuErv7SfMkGVbvAjcv+36GoPDOKU/0aA5eKz2T3kod5Rko4pqz
	 thlOxv/eGqW9IApoQMVRwSpcivcefLezOkHJkunkNHtOw06jhEPSywgF70hQ31KAhx
	 DQdOtKlfX14lMi4CK3Tk/eyXCzUJGeQB8yry2LZ0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261104113804epcas5p142b60024c39f0f39e61bbdd129782404~k1JQrFsHl0140001400epcas5p1B;
	Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jKNjS2jRgz3hhT3; Wed,  4 Nov
	2026 11:38:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261104113039epcas5p4cd54cce1d9c2de4f1c1f2101623dd783~k1CyZEvhQ2809328093epcas5p4b;
	Wed,  4 Nov 2026 11:30:39 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113037epsmtip114cedcb66d95ce7a3d0fa236e5ec38ac~k1CwC-6dY2364123641epsmtip1a;
	Wed,  4 Nov 2026 11:30:36 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 6/8] hw/pci: Add PCIe Device3 capability support
Date: Wed,  4 Nov 2026 17:22:40 +0530
Message-Id: <932285561.201793792284372.JavaMail.epsvc@epcpadp2new>
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
X-CMS-MailID: 20261104113039epcas5p4cd54cce1d9c2de4f1c1f2101623dd783
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113039epcas5p4cd54cce1d9c2de4f1c1f2101623dd783
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113039epcas5p4cd54cce1d9c2de4f1c1f2101623dd783@epcas5p4.samsung.com>

Add the PCIe Device 3 Extended Capability (PCIe 6.4 section 7.7.9),
with which an endpoint exposes its UIO requester and completer
support and the related control bits.

The capability tracks the link's flit state: the requester-enable
bits stay clear while the link is not in flit mode, and the Segment
Captured status bit follows the flit state.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci/meson.build         |   2 +-
 hw/pci/pci.c               |   2 +
 hw/pci/pcie.c              |  29 ++++++++++
 hw/pci/pcie_dev3.c         | 111 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |   5 ++
 include/hw/pci/pcie_dev3.h |  26 +++++++++
 include/hw/pci/pcie_regs.h |  26 +++++++++
 7 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci/pcie_dev3.c
 create mode 100644 include/hw/pci/pcie_dev3.h

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
index 50472cab88..cc5e40ac5c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -571,6 +571,7 @@ static void pci_do_device_reset(PCIDevice *dev)
     pcie_sriov_pf_reset(dev);
     pcie_cap_flit_reset(dev);
     pcie_svc_cap_reset(dev);
+    pcie_dev3_cap_reset(dev);
 }
 
 /*
@@ -1819,6 +1820,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     pcie_sriov_config_write(d, addr, val_in, l);
     pcie_cap_flit_write_config(d, addr, l);
     pcie_svc_cap_write_config(d, addr, val_in, l);
+    pcie_dev3_cap_write_config(d, addr, val_in, l);
 }
 
 /***********************************************************/
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b05f70022a..9f16cc8d1b 100644
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
 /*
  * Derive the read-only Flit Status bit of the Link Status 2
  * register from the Flit Disable bit of the Link Control register.
@@ -226,6 +252,9 @@ void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, int len)
     }
 
     pcie_cap_flit_update_sta(dev);
+    if (dev->exp.dev3_cap) {
+        pcie_dev3_cap_flit_update(dev);
+    }
 }
 
 /*
diff --git a/hw/pci/pcie_dev3.c b/hw/pci/pcie_dev3.c
new file mode 100644
index 0000000000..8ca7c74b8c
--- /dev/null
+++ b/hw/pci/pcie_dev3.c
@@ -0,0 +1,111 @@
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
+    }
+
+    pci_set_long(dev->config + offset + PCI_DEV3_CAP_OFFSET, devcap3);
+    pci_set_long(dev->wmask + offset + PCI_DEV3_CTL_OFFSET, wmask);
+
+    return 0;
+}
+
+/*
+ * Track the link's flit state in the Device 3 capability: the
+ * requester-enable bits of the Device Control 3 register are cleared
+ * while the link is not in flit mode, and the Segment Captured
+ * status bit follows the link's flit state.
+ */
+void pcie_dev3_cap_flit_update(PCIDevice *dev)
+{
+    uint32_t off = dev->exp.dev3_cap;
+    uint32_t devctl3;
+    uint32_t devsta3;
+    bool flit;
+
+    if (!off) {
+        return;
+    }
+
+    flit = pcie_link_flit_active(dev);
+    if (!dev->exp.dev3.uio_req || !flit) {
+        devctl3 = pci_get_long(dev->config + off + PCI_DEV3_CTL_OFFSET);
+        devctl3 &= ~(PCI_DEV3_CTL_TAG_REQ_EN |
+                     PCI_DEV3_CTL_UIO_REQ_EN |
+                     PCI_DEV3_CTL_UIO_256B_DIS);
+        pci_set_long(dev->config + off + PCI_DEV3_CTL_OFFSET, devctl3);
+    }
+
+    devsta3 = pci_get_long(dev->config + off + PCI_DEV3_STA_OFFSET);
+    if (flit) {
+        devsta3 |= PCI_DEV3_STA_SEGMENT_CAP;
+    } else {
+        devsta3 &= ~PCI_DEV3_STA_SEGMENT_CAP;
+    }
+    pci_set_long(dev->config + off + PCI_DEV3_STA_OFFSET, devsta3);
+}
+
+void pcie_dev3_cap_reset(PCIDevice *dev)
+{
+    uint32_t off = dev->exp.dev3_cap;
+
+    if (!off) {
+        return;
+    }
+
+    pci_set_long(dev->config + off + PCI_DEV3_CTL_OFFSET, 0);
+    pci_set_long(dev->config + off + PCI_DEV3_STA_OFFSET, 0);
+    pcie_dev3_cap_flit_update(dev);
+}
+
+void pcie_dev3_cap_write_config(PCIDevice *dev,
+                                uint32_t addr, uint32_t val, int len)
+{
+    if (!dev->exp.dev3_cap) {
+        return;
+    }
+
+    if (ranges_overlap(addr, len,
+                       dev->exp.dev3_cap + PCI_DEV3_CTL_OFFSET, 4)) {
+        pcie_dev3_cap_flit_update(dev);
+    }
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3d092e8871..95f670c830 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -26,6 +26,7 @@
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
 #include "hw/pci/pcie_svc.h"
+#include "hw/pci/pcie_dev3.h"
 #include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
@@ -86,6 +87,9 @@ struct PCIExpressDevice {
 
     /* Streamlined Virtual Channel (SVC) introduced from PCIe 6.1 */
     uint32_t svc_cap;
+    /* PCIe Device 3 Capability */
+    uint32_t dev3_cap;
+    struct PCIEDev3Cap dev3;
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
@@ -149,6 +153,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode);
 void pcie_cap_flit_write_config(PCIDevice *dev, uint32_t addr, int len);
 void pcie_cap_flit_reset(PCIDevice *dev);
+bool pcie_link_flit_active(PCIDevice *dev);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_dev3.h b/include/hw/pci/pcie_dev3.h
new file mode 100644
index 0000000000..4cfa07fe32
--- /dev/null
+++ b/include/hw/pci/pcie_dev3.h
@@ -0,0 +1,26 @@
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
+
+#endif /* HW_PCIE_DEV3_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 044b3caae4..484178adb3 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -256,4 +256,30 @@ typedef enum PCIExpLinkWidth {
 #define PCI_SVC_RES_STATUS(n)           (PCI_SVC_RES_STATUS_BASE + ((n) * 0x0c))
 #define PCI_SVC_VC_NEGO                 BIT(1)
 
+/* PCIe Device 3 capability structure. PCIe 6.4 Specification Section 7.7.9 */
+#ifndef PCI_EXT_CAP_ID_DEV3
+#define PCI_EXT_CAP_ID_DEV3 0x2f
+#endif
+
+#define PCI_DEV3_CAP_OFFSET            0x04
+#define PCI_DEV3_CTL_OFFSET            0x08
+#define PCI_DEV3_STA_OFFSET            0x0c
+#define PCI_DEV3_SIZEOF                0x10
+
+/* Section 7.7.9.2 Device Capabilities 3 Register */
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


