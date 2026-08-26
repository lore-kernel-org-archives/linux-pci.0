Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE3331ECC
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732432; cv=none; b=gd9JNphLXENB3bzXT0JKkpIoh6yB1dgLn+1kgXDDrXdzbOwrBIMX6zt1REc1zCOsJyBnqq10LvI5knzMi8G1F06qMnuDNNQ5Ct7bqgBKDR57sM0ElN94ppZB00mRcyBLTLo/Jt2YbBTg28T0rRq93Rqs4E3sP6iajgWHb88rdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732432; c=relaxed/simple;
	bh=T3FTcojiPIBomOQlvS+euF2sZ6W3unWMwLGtPcelSNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=f46SFxESCLDVSO4F5YWxLignAulWhK9iNXDCTzZLBpF0JnHscgTy/WGXzXtmkS7ZCzYW9Bt42Tt6tH/joamrRWAMsNncZkcIYVZxx1r7Gxk9KG3j0FHXYaSHT+h5jZwSzvOgmjsaWCPBmxUiRaVqRWBD7FHNnuwkdja9w0CAbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I5WdMq3a; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I5WdMq3a"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260826081503epoutp01d3c9a703130fc40295d3a60d34f22a05~PTOBLaYdp0629106291epoutp01T
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260826081503epoutp01d3c9a703130fc40295d3a60d34f22a05~PTOBLaYdp0629106291epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787732103;
	bh=SQXj/9l+rMnTTINxJGJSqKcLnI0ozzZ6odUUtMvj6p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5WdMq3azXXkLv+jxSYz0vz2RHhrTiQm0wDH2xw/KanZe7g6Ps2gUvJZ4tl2yHxcQ
	 OTrID+x2h3a3ae6t+l0IiJfxmgA8K8CPSed37plwSVdLcmmWUPce8nebU6pR1kc2WB
	 4H2QZOrL9JzdGdf5J4Pbw5WWVdgErJ08Z/nfgTeE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260826081502epcas5p1d625b17183fd73fff7774bfe5582e8fb~PTOA4kgfg2310023100epcas5p1E;
	Wed, 26 Aug 2026 08:15:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hVHWV6q8Gz6B9mN; Wed, 26 Aug
	2026 08:15:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d~PQ1mOQfKc3052030520epcas5p2n;
	Wed, 26 Aug 2026 05:20:29 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260826052027epsmtip28d5be75a0fded45a17fa2cabe0260588~PQ1knCxqA1126911269epsmtip2A;
	Wed, 26 Aug 2026 05:20:27 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 02/10] hw/pci: Move 'x-256b-flit' property from
 cxl_root_port to pcie_root_port.
Date: Wed, 26 Aug 2026 11:04:02 +0530
Message-Id: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<CGME20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d@epcas5p2.samsung.com>

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


