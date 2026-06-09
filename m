Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9050383C70
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001924; cv=none; b=CYFjeoFvT+TNEMpnY+2qCpWZQdthij61fyoPHCpZUQBD8lsoapE4OHLvBEI/UzYbvJ+JADLDtbeRzFVGvCTvWXQVniwAe7Jt5H8e+PV0UkqgPvQItkGGxYrpTl9+4dEqHxml8+XSa/lMJ0Z1eMe16uOglBOJeLaGbK5sQs0al6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001924; c=relaxed/simple;
	bh=r7vRCD5BrE3hq1XgkFXIYlT6R+lcoTjik5XuFRp/gPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=LLgT4TD0seeVf0Hb8O/FxBWQLsRwTn6YhagWH03urQoNkbJAMQnvM/hIKS/FIkIVTsYzgGUojP/rmxFYfcP+A81UgymHZxVXfrq7wd8PttdeGqS/ULjcCsOfiZszxWMw8b58vb+FTk5i2QuhsXbm58ANU2h6joTG/ezIiXT0+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IOQHSk/Z; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IOQHSk/Z"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260609104520epoutp02735247e8080d7cd188a1bd71aab65a06~3Y89677dg2777227772epoutp02i
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260609104520epoutp02735247e8080d7cd188a1bd71aab65a06~3Y89677dg2777227772epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001920;
	bh=M8e5GeRyE2solHQvA/awHxp2b9XtLDzcTwdIMuL5KRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOQHSk/ZyEUynAhmSzfBfQ94MK1JqprLcd+s9Pd/cX8iSPCl/5xWEmdl4fKO24Alx
	 EXw7YhXoMOpPewuH7vloGwB4TSXOOdgNLu1KGhYHEdUUOg0HkoeavdUZII55iB16X4
	 mDVu/THWrtxt0Piz1gKIDwOGl0rib7dJPtfdAYMg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260609104519epcas5p2bb1ac165dd8d43b9a0b6a25c3457682e~3Y89RFwVO0416704167epcas5p2l;
	Tue,  9 Jun 2026 10:45:19 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4gZQXv09MVz2SSKX; Tue,  9 Jun
	2026 10:45:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422~3Y87oRiZ20640806408epcas5p2M;
	Tue,  9 Jun 2026 10:45:17 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104516epsmtip1abf28bdeb0bf288700c9cbb4bcc6b96d~3Y85-fTyV2367023670epsmtip1q;
	Tue,  9 Jun 2026 10:45:16 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 3/8] hw/pci: Add SVC capability and UIO properties to PCIe
 ports
Date: Tue,  9 Jun 2026 16:28:31 +0530
Message-Id: <20260609105836.3702787-4-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422@epcas5p2.samsung.com>

From: Dongjoo Seo <dongjoo.seo1@samsung.com>

Implement the Streamlined Virtual Channel (SVC) extended capability
for PCIe ports (Root, Upstream, and Downstream). This capability is
mandatory for enabling Unordered IO (UIO) traffic as per PCIe 6.4
specification [1].

UIO functionality depends on two key prerequisites:
  1. SVC support (SVC3 mandatory, SVC4 optional)
  2. 256-byte Flit mode support

This patch adds the following experimental properties to PCIe ports:
  - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
  - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
  - x-256b-flit: Enable 256B flit mode required for UIO

Helper functions are included to manage UIO traffic gating and SVC
configuration. This change lays the groundwork for UIO emulation in
QEMU.

[1]: PCIe 6.4 Specification, Table 2-46 (Streamlined Virtual Channel)

Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/pcie_root_port.c     |  2 ++
 hw/pci-bridge/xio3130_downstream.c |  3 +++
 hw/pci-bridge/xio3130_upstream.c   |  8 ++++++++
 include/hw/pci/pcie_port.h         | 21 +++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index eeee24e042..20554bd854 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -153,6 +153,8 @@ static const Property rp_props[] = {
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053..b0b297bb53 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -137,6 +137,9 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749b..925df5add3 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
@@ -123,6 +124,12 @@ static const VMStateDescription vmstate_xio3130_upstream = {
     }
 };
 
+static const Property xio3130_upstream_props[] = {
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+};
+
 static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -138,6 +145,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
     device_class_set_legacy_reset(dc, xio3130_upstream_reset);
     dc->vmsd = &vmstate_xio3130_upstream;
+    device_class_set_props(dc, xio3130_upstream_props);
 }
 
 static const TypeInfo xio3130_upstream_info = {
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1bcc734649..a6b1b8a6cf 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -37,8 +37,29 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+
+    /*
+     * This field declares Streamlined Virtual Channel (SVC) capability.
+     * Per PCIe 6.4 specification section 7.9.29, a pcie port supports
+     * upto 8 SVCs, in that SVC0 is a default one, SVC3 is for UIO traffic
+     * and SVC 4 is shared by both UIO and non-UIO traffic.
+     */
+    uint32_t    svc;
 };
 
+#define UIO_MANDATORY_SVC 3
+#define UIO_OPTIONAL_SVC 4
+
+static inline bool get_uio_mandatory_svc(PCIEPort *port)
+{
+    return (port->svc >> UIO_MANDATORY_SVC) & 1;
+}
+
+static inline bool get_uio_optional_svc(PCIEPort *port)
+{
+    return (port->svc >> UIO_OPTIONAL_SVC) & 1;
+}
+
 void pcie_port_init_reg(PCIDevice *d);
 
 PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn);
-- 
2.34.1

