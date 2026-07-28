Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10784746BB;
	Tue, 28 Jul 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270080; cv=fail; b=hpN2U7g7/bDIkRm2J6wjABCmo0yBKU6SNox5xBvKmYNr/kJHWSZRSwXMJMeUuRPg3nab/yiOVemdgJJVZZvPzA18e6qeNk5CG9vwIIx7838uEw3knA47SSi0qgBa/PDFgmwW1gICArhHUPRLQMc5TlQe4FPh3YcK+ygQ+2c8+/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270080; c=relaxed/simple;
	bh=wgq0+p7BI3lC1xOMT0lhzJ2MHWVWrnrXoekcVvfZAx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fe6OHLdR5HNM6aJbGnqql4/6ebazyn8IpwaTyNmUZ3JLIHj4Sk0XDzk+XbUah2zaaNtXNKWCrbKJLtOs6x1uWnTg31PZ9/ftOokbdKdMiQp9znrWbM0Pbr9Ofag+RgCRLqhuBsv/ehZD9jCxkhAIhpnP9gnlOrlttU2CrBbVihQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oijr0tOW; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oijr0tOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5Uwi3+clpN3vM6KWDj55mNYYc7vicBROIFwcpm5LkcjEMD5MiGEaD7yu0+M1KB9dznu54oqT+1k26tBeHDThxgUaqncYW/4TVx0nRej7x6aQ1eEQ4ZhCypZRtkOr7LgfX3dRYB444lNB9xoii36wtS1WOoLTG/XVXo7gc9imJrmtCKgSL7UwEREF3RSRzRuPJ+Sz++57NFnGJJxOVKg061W+KtBbYQb5WHTiPL25dZ3CchWPwE2sdCPYiBrE8W7XaD74aOFLfThJy1Vc9BXxKvQ9Hl4ubYK8rSWaecmZdf/nsXfaTPZrezruPHZUUMEcj2uCvV3xp9QVc2eAehnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMdarG9oX32JsE+3GrKQhQMdOjREf+TjdDS3GFFIQZA=;
 b=amd0Bl3iqeH2ZvPz4AcboRbzm0R2uMqv3ehHicnQFAgIfyr7Bkkm/2uuygEfFiQsTdj2UKtdY/uP4Zs4qYt3OVCj0E9J4rhRFkAoJEGzFw9jDRrAgh7kSABziXqxzdFAEHfQz17nWimO7qfHdbAeiJtuePG43jPbNt+XJ4M36tjU+yV4Rn4m7tvfiVIb6hOm6DqLaDSHwF0zEts0UGuzvPrs7n3/kK/1LTiD/gKQt9X9Mn4wCZRcKIALUczURbRAw2AWXiYqwiAAdJFmcSCNSsAHcou5j+7/AGRbKzzeawFKUcB78S9YOIuaAMyvb2FXvfHOjaDDgp+RJuQ02k7wbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMdarG9oX32JsE+3GrKQhQMdOjREf+TjdDS3GFFIQZA=;
 b=oijr0tOWvNlbOdyfjDHiUEvQOBO2SFXuR5x0aBJvSvqdY54TEadmNebsOSwmrVEWBug6nAke1mUWv92aphysT3OZy93wgDxAf1TnGaeg+IkAb2HIPgE8p+gP73C02n1ljys6dWpPnvhtKePtBipFlF4hkF6WYwOa86cpp3hNTRE=
Received: from CYXPR02CA0078.namprd02.prod.outlook.com (2603:10b6:930:ce::16)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 20:21:11 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::49) by CYXPR02CA0078.outlook.office365.com
 (2603:10b6:930:ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 20:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 20:21:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 15:21:10 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 15:21:06 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB PCIe binding
Date: Wed, 29 Jul 2026 01:50:43 +0530
Message-ID: <20260728202044.1785986-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1ef94c-e2dc-4c47-a657-08deece5c447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|56012099006|11063799006|3023799007|6133799003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	aijP6DkKdh2Iap0Eh95ysApOu+pFRv+nCVi0KOOD1AfpsPzC+9fPC+OBFEwNLnRpyXfdhM+4U+U/uFthsGacUbKC8oUD38sSJgSc19yotoj7K6FMCTBym7cIrFm+N9mdxCPG4UCfLWZ5kWkRryXVzijgE23yFECUaB170hy/Eak4JE41puuYnT4sVqI/ZJWz+c18JyFDFNxmI393d/jhVgwwh7CH00XeISPAbF8TBvOHkTnJmwX4NkgZW0fWkoNH3nnADIKblN8VL5LVOah8zn+NAgnAKpqWycFznNSSBJMuTamkJwAiEOpd/493pY/I6gdqykFJRWL5JGvJKHzC6u6s6pcm6+wyXaeKeDw5+t3uG+V4ADs88UVKyByYupBlCLBh3waUtoMmU2q8dhDf6vhPoDyajYWmSX/+7vrUO3ar1mJjrkdZT0nGAb9PR8wBUX3YiQYVeFJtqlCy413oj5JOYzHQ6vpEwQgJIN5hB/fzPcfpfLcCzYXH6cZ0HCdcQL+Bm020IHOzZXKgJhzX8eDQHHluThij3sBO/Hn7kxb1WkbOfu6oyrxsKRbtzAw3etLUSPKiCm3r/3xBvOHJObnbIT1c3GTcVQxHfaMu9zFXMTO+ZCBmnFgLNsM/EXa1wJbSGAojhtTc6BVNMcNGZp33wGwBF9TtVULF4vo0sMZOwZw1DuLVK315NZnnAlMe1pJ8uzJBaIyYIFk8Y8DXkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/rfuyVofpclPjrtGztCNfVhaPbEAuRViMMOLMRwc3vkLODXOXe4AkZHYOeBAHYZA//lEVI2UXCzsxD5udii6+ZgwrvsjODAUSH3BSwxuH08cTU6QtFaTHLiZgIPlUC9PmfoK7C2L5Q0tE/uvViCaRmD1zvjXM1DugAR5F4IC8zUn/jRLl1Vfk2wRVVboXrCiDgTQAVXCY4UiRCtudhUOJAQv4r+gzA0mr9gllMOXaV+j7Y2qXlOfchQkrtNIZEY/uwA5U4C223cdBRLhJB8Xg+1cgHYNFptIChFBdbgxZafWGczfS0ww2rg9U/elxRsudwC1aaPd/ZzoKfQ4eTVSLVEoGoeSLE7R1+d19kO3KCSVT/bDAm6VgcskLyfe+LhGWgLYW6BEw7glq2gFadQJeJTH5IVnO7aW7sXPUqSoKSRKYlbNuJbCI9O7O1lpfzOP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:21:11.6980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1ef94c-e2dc-4c47-a657-08deece5c447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
per-controller interrupt register region used by CPM6.

Update amd,versal2-mdb-host.yaml with separate register definitions:
- MDB5: 4 regions (slcr, config, dbi, atu)
- CPM6: 5 regions (slcr, config, dbi, atu, intr)

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v2:
- Update the CPM6 device tree binding and example.

v1 https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musham@amd.com/
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 111 ++++++++++++++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 2 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 406c15e1dee1..d22de24b41ca 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -12,24 +12,65 @@ maintainers:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,versal2-mdb-host
+    then:
+      properties:
+        reg:
+          items:
+            - description: MDB System Level Control and Status Register (SLCR) Base
+            - description: configuration region
+            - description: data bus interface
+            - description: address translation unit register
+        reg-names:
+          items:
+            - const: slcr
+            - const: config
+            - const: dbi
+            - const: atu
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amd,versal2-cpm6-host
+              - amd,versal2-cpm6-host1
+    then:
+      properties:
+        reg:
+          minItems: 4
+          items:
+            - description: MDB System Level Control and Status Register (SLCR) Base
+            - description: configuration region
+            - description: data bus interface
+            - description: address translation unit register
+            - description: CPM6 PCIe error and event interrupt registers
+        reg-names:
+          minItems: 4
+          items:
+            - const: slcr
+            - const: config
+            - const: dbi
+            - const: atu
+            - const: intr
 
 properties:
   compatible:
-    const: amd,versal2-mdb-host
+    enum:
+      - amd,versal2-mdb-host
+      - amd,versal2-cpm6-host
+      - amd,versal2-cpm6-host1
 
   reg:
-    items:
-      - description: MDB System Level Control and Status Register (SLCR) Base
-      - description: configuration region
-      - description: data bus interface
-      - description: address translation unit register
+    minItems: 4
+    maxItems: 5
 
   reg-names:
-    items:
-      - const: slcr
-      - const: config
-      - const: dbi
-      - const: atu
+    minItems: 4
+    maxItems: 5
 
   ranges:
     maxItems: 2
@@ -141,3 +182,51 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@fcdd0000 {
+            compatible = "amd,versal2-cpm6-host";
+            reg = <0x0 0xfcdd0000 0x0 0x1000>,
+                  <0x6 0x100000 0x0 0xff00000>,
+                  <0x6 0x0 0x0 0x100000>,
+                  <0x0 0xfc280000 0x0 0x4000>,
+                  <0x0 0xfc840000 0x0 0x1000>;
+            reg-names = "slcr", "config", "dbi", "atu", "intr";
+            ranges = <0x2000000 0x00 0xe0000000 0x00 0xe0000000 0x00 0x8000000>,
+                     <0x43000000 0x80 0x00 0x80 0x00 0x20 0x00>;
+            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gic>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
+                            <0 0 0 2 &pcie_intc_1 1>,
+                            <0 0 0 3 &pcie_intc_1 2>,
+                            <0 0 0 4 &pcie_intc_1 3>;
+            msi-map = <0x0 &gic_its 0x00 0x10000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&gpio1 40 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
+
+            pcie_intc_1: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index b3216141881c..21f86609ddb6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -117,6 +117,8 @@ properties:
               enum: [ ecam ]
             - description: AMD MDB PCIe SLCR region
               const: slcr
+            - description: AMD CPM6 PCIe error and event interrupt registers
+              const: intr
     allOf:
       - contains:
           enum: [ dbi, ctrl ]
-- 
2.44.4

