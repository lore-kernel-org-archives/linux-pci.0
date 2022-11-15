Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52ABC4332F
	for <linux-pci@archiver.kernel.org>; Tue, 15 Nov 2022 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKOPIx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKOPIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:08:52 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBB21A1
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:08:51 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF8jYf058336;
        Tue, 15 Nov 2022 09:08:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668524925;
        bh=foihmSDBMxvRrlKwiBMwUCVMtA3VI3m7Jsbt5057sAM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CLkYaH1u+FaHnX/3Wh743L6e/rXeVTOCqWLof1pFdzWlPpbUCZsQAngqQsR21OIY+
         /XHiriPOXyJQYS6IxJeLty4KMntjpImjCN8G9fi3YMQIu1d7VOpqEZchQBIcJ4iiKO
         B2ZN7U+clYluFf32pz5GauP2s2ScIJw9Nw5Z06yM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFF3jgc004201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 09:03:45 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 09:03:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 09:03:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF3g8B049411;
        Tue, 15 Nov 2022 09:03:43 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v6 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
Date:   Tue, 15 Nov 2022 07:03:31 -0800
Message-ID: <20221115150335.501502-2-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221115150335.501502-1-mranostay@ti.com>
References: <20221115150335.501502-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add num-lanes schema checks based on compatible string on available
lanes for that platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 10e6eabdff53..1aeea168d3d0 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI EP (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: "cdns-pcie-ep.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -65,6 +62,31 @@ properties:
     items:
       - const: link_state
 
+allOf:
+  - $ref: "cdns-pcie-ep.yaml#"
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-ep
+            - ti,j721e-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b0513b197d08..8eca0d08303f 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI Host (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: "cdns-pcie-host.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -98,6 +95,31 @@ properties:
       interrupts:
         maxItems: 1
 
+allOf:
+  - $ref: "cdns-pcie-host.yaml#"
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-host
+            - ti,j721e-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
-- 
2.38.GIT

