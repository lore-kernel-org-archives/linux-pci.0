Return-Path: <SRS0=Xta/=UD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F033C282CE
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89462484F
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iaiOtqAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfFDNRF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:17:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50132 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDNRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:17:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DGpJd082098;
        Tue, 4 Jun 2019 08:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654211;
        bh=d2Yf+EQVOcYUuyjIFqI4vpy6C4J9oA56z6GDwCfgJM8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iaiOtqAjtJS2HCgRXBQr6amfGQkZab5la+Ef6/+Mxb+hSysRwNv/YSakSIZHLRinx
         +lq6IMHEDkb3/c5MieuIpFPFEr+GeFsb6p//7yJc5Ize7dQcwEbLNKzlZ4did1rQXi
         F01rGo6KV+VKey27VdHrJN+6apLZ9zgEUa1aWIEc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DGpbm041920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:16:51 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:16:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:16:50 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGH098972;
        Tue, 4 Jun 2019 08:16:45 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 01/30] dt-bindings: PCI: cadence: Add DT binding to use PCIe with IOMMU
Date:   Tue, 4 Jun 2019 18:44:47 +0530
Message-ID: <20190604131516.13596-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT binding to map a Requester ID to an IOMMU and associated IOMMU
specifier.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 91de69c713a9..f02cccd1e0c5 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -27,6 +27,7 @@ Optional properties:
 - phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
   than one in the list.  If only one PHY listed it must manage all lanes. 
 - phy-names:  List of names to identify the PHY.
+- iommu-map: As specified in Documentation/devicetree/bindings/pci/pci-iommu.txt
 
 Example:
 
-- 
2.17.1

