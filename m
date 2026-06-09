Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FF30DD11
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001918; cv=none; b=jQcerl7jeEeomRRiIpJf5xse+nutxnJww/WlKVTMkyz9boY7ntRsR/XLOg7GQfKPz0CNi54wfGZ39AKOlCDMVTny4aha3reF0pZaS1XoDkjvu2qMcQUAHprxuK1yvUKVGpFKslyLqOhhI/eKd1OU3smV85W73LpBffxWM9hX9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001918; c=relaxed/simple;
	bh=T3FTcojiPIBomOQlvS+euF2sZ6W3unWMwLGtPcelSNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=l8h2Gltcdso9zcQkI/WH5d7RIAWb+k2BZmP9kz2mAgVYTgmpsPwCJ+uRMTDc8QJX+TBM/yeEXwYdacLdmtMDSdvXfEXRHyxkHHAUdLSKDoFkBenuqL+Ekyi+7JznaejmQKOmo84HCFmq/zgZLW5bqaHPkmBgWJamE8yOv2IzWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eNuBI1Eg; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eNuBI1Eg"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260609104514epoutp0238c14058b5530f478f18c03ac885bac0~3Y84V9nHQ2804728047epoutp02c
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:45:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260609104514epoutp0238c14058b5530f478f18c03ac885bac0~3Y84V9nHQ2804728047epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001914;
	bh=SQXj/9l+rMnTTINxJGJSqKcLnI0ozzZ6odUUtMvj6p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNuBI1EgznepIqPaV2U1I3Nkz8DQ4/AsV9jE8ZgpMNIL5qJnkFlCRLyoUkkKENgZ8
	 kYRGWdzuYHaiwbiBi4PL1bke/a1myLGhiXYxZ1mAVrE5RIIeGRswcMKLR8R2wBsAL4
	 xXc2D9Gf6TJYORAEq17oMZ4u/IRqTKoz6Fm6EUl0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260609104514epcas5p29e026fbda4c91c8ad0f28faee4321cf7~3Y84ABFH12641426414epcas5p2L;
	Tue,  9 Jun 2026 10:45:14 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gZQXn0m60z6B9mH; Tue,  9 Jun
	2026 10:45:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454~3Y82snguL0826308263epcas5p3i;
	Tue,  9 Jun 2026 10:45:12 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609104510epsmtip1ef1e7c0a14ad2159e301bcc1daba8e5a~3Y81HtHiv2354323543epsmtip1Z;
	Tue,  9 Jun 2026 10:45:10 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
	shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com
Subject: [RFC 2/8] hw/pci: Move 'x-256b-flit' property from cxl_root_port to
 pcie_root_port.
Date: Tue,  9 Jun 2026 16:28:30 +0530
Message-Id: <20260609105836.3702787-3-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454@epcas5p3.samsung.com>

Relocate 'x-256b-flit' property from cxl_root_port to its parent
pcie_root_port so that both can utilize this property.

This is a pure refactor and does not impact any existing behavior.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c  | 1 -
 hw/pci-bridge/pcie_root_port.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index df69c5200f..e82685d1ab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -237,7 +237,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced5685..eeee24e042 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,6 +152,7 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.34.1

