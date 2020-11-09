Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59857C2D0A3
	for <linux-pci@archiver.kernel.org>; Mon,  9 Nov 2020 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A8D21D93
	for <linux-pci@archiver.kernel.org>; Mon,  9 Nov 2020 17:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wAvAQE03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgKIRE0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:04:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIREY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:04:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4JB4001539;
        Mon, 9 Nov 2020 11:04:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604941459;
        bh=rez2nNITrchwUV9a5zJYzK2/jqQ1anb/jEJKp6emraU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wAvAQE03fagBZdOGkqc3piNGnac0dMPgukPrSG7LG6ifYns6SuhgrXy6WbXVzGBJH
         b4W0NPesHDeCAQNy+Th+XZNf2KRzJV768XDn/AnbLPx28mG2vktl5p2zBLfwCiSM90
         wJO/mYdWPHP6xYe4ayFWoUbOyoAssQPjtV4Wz7BM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9H4J5f096259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:04:19 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:04:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:04:18 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4AwU036684;
        Mon, 9 Nov 2020 11:04:15 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/7] dt-bindings: mfd: ti,j721e-system-controller.yaml: Document "syscon"
Date:   Mon, 9 Nov 2020 22:34:03 +0530
Message-ID: <20201109170409.4498-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109170409.4498-1-kishon@ti.com>
References: <20201109170409.4498-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add binding documentation for "syscon" which should be a subnode of
the system controller (scm-conf).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../mfd/ti,j721e-system-controller.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 19fcf59fd2fe..0b115b707ab2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -50,6 +50,38 @@ patternProperties:
       specified in
       Documentation/devicetree/bindings/mux/reg-mux.txt
 
+  "^syscon@[0-9a-f]+$":
+    type: object
+    description: |
+      This is the system controller configuration required to configure PCIe
+      mode, lane width and speed.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - ti,j721e-system-controller
+          - const: syscon
+          - const: simple-mfd
+
+      reg:
+        maxItems: 1
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+      ranges: true
+
+    required:
+      - compatible
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+      - ranges
+
 required:
   - compatible
   - reg
@@ -72,5 +104,13 @@ examples:
             compatible = "mmio-mux";
             reg = <0x00004080 0x50>;
         };
+
+        pcie1_ctrl: syscon@4074 {
+            compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+            reg = <0x00004074 0x4>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0x4074 0x4074 0x4>;
+        };
     };
 ...
-- 
2.17.1

