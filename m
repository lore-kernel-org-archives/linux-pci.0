Return-Path: <SRS0=jBgi=IG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDCBC433E0
	for <linux-pci@archiver.kernel.org>; Mon,  8 Mar 2021 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B66651F8
	for <linux-pci@archiver.kernel.org>; Mon,  8 Mar 2021 06:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhCHGgu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Mar 2021 01:36:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57774 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhCHGgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 01:36:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286a6vf056792;
        Mon, 8 Mar 2021 00:36:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615185366;
        bh=WEmR5Z/eVfZg1yoS3V+mkU0/CGlAmAnWGl/eIMdtlyU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TWdRvvncEDQEuTt4nQV4vhTr1LWnzpU4FaD7A0aa8y2MgGUWRWPf0KFp7JKGsVzBJ
         sFlkJ3K8gqnWnmE7kg29GrNYdOTCHkhy9HYmgptfhNrGeilJnse2NVEggCRrWzLySZ
         oilkPhfMqUlJkbBoa0X+fcQzERYMhPhx7UJC+/v4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286a6GP017507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:36:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:36:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:36:06 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286ZuTT117458;
        Mon, 8 Mar 2021 00:36:02 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 1/4] dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the connector
Date:   Mon, 8 Mar 2021 12:05:47 +0530
Message-ID: <20210308063550.6227-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308063550.6227-1-kishon@ti.com>
References: <20210308063550.6227-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add binding to represent refclk to the PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 0880a613ece6..963f90816645 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -46,12 +46,17 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description: clock-specifier to represent input to the PCIe
+    minItems: 1
+    maxItems: 2
+    description: |+
+      clock-specifier to represent input to the PCIe for 1 item.
+      2nd item if present represents reference clock to the connector.
 
   clock-names:
+    minItems: 1
     items:
       - const: fck
+      - const: pcie_refclk
 
   vendor-id:
     const: 0x104c
-- 
2.17.1

