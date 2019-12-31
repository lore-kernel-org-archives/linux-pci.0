Return-Path: <SRS0=lwCQ=2V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97762C2D0C2
	for <linux-pci@archiver.kernel.org>; Tue, 31 Dec 2019 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B220409
	for <linux-pci@archiver.kernel.org>; Tue, 31 Dec 2019 11:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XJ5Q0pZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfLaLeI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:34:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42318 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfLaLeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXooJ117381;
        Tue, 31 Dec 2019 05:33:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792030;
        bh=pyb5BGFKhI/g5TGZ5x/+8IE+fcZyupjTjB03k+gnDLA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XJ5Q0pZPrYgV582tAST8auFK4EOd1zfU2SbRWQKBbUbjArFGs9Rmgw7FtuQrdroj7
         wDte2FwBAcDLzQIgfQqLiCQhhyv92wA9EgZqqxjdb1cG6qoJRV0Aia02sZJe3Jyr7A
         0OwlOXHcKzHhabFAOjxIqV6ANL9hD1BYb7wrRHfY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXoKp089470;
        Tue, 31 Dec 2019 05:33:50 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:33:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:33:49 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX33024759;
        Tue, 31 Dec 2019 05:33:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/7] dt-bindings: PCI: cadence: Add binding to specify max virtual functions
Date:   Tue, 31 Dec 2019 17:05:29 +0530
Message-ID: <20191231113534.30405-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add binding to specify maximum number of virtual functions that can be
associated with each physical function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt         | 2 ++
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 4a0475e2ba7e..432578202733 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,8 @@ Required properties:
 
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (default 1).
+- max-virtual-functions: Maximum number of virtual functions that can be
+    associated with each physical function.
 - phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
   than one in the list.  If only one PHY listed it must manage all lanes. 
 - phy-names:  List of names to identify the PHY.
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 4621c62016c7..1d4964ba494f 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -61,6 +61,12 @@ properties:
     minimum: 1
     maximum: 6
 
+  max-virtual-functions:
+    minItems: 1
+    maxItems: 6
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+
   dma-coherent:
     description: Indicates that the PCIe IP block can ensure the coherency
 
@@ -85,6 +91,7 @@ required:
   - cdns,max-outbound-regions
   - dma-coherent
   - max-functions
+  - max-virtual-functions
   - phys
   - phy-names
 
@@ -107,6 +114,7 @@ examples:
             clock-names = "fck";
             cdns,max-outbound-regions = <16>;
             max-functions = /bits/ 8 <6>;
+            max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
             dma-coherent;
             phys = <&serdes0_pcie_link>;
             phy-names = "pcie_phy";
-- 
2.17.1

