Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B219005E;
	Thu,  3 Sep 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442446; cv=fail; b=ksEwaZ5Q3WxN8HNDW8SVSZV4SdVoQCLWxxEhKrzbW2zu6+wIlL11g82QeQWiBwJNqz4kKROWdo1PNprTd/d2l0zqv0kRW6aBA614BlnX7Bm75Xp7LVnmZ/A0gqtv5mXdflYd8/h/f4QJ899WKF3nCWBUSbSbFnlTXDwQa3uyy+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442446; c=relaxed/simple;
	bh=2D3GtMxoDZf/r78T/6pcPukcKf1GndLRWX1Qh71D+38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwEIVH/agx9esPuEDwDRqO+wZq+v2sPAuHmoIJXskLgegj9RjVo0+vmHBcgcQ9Il8/+ANQIR+pquoqVDA07FV0dgXM5Ft0g7GmbKpIGtLDln5tZBYbwWW3Frb7y40KU7vjmaukCSgOEQTaRfM3IJQMBb8KzwgnLwD7IGOqlCzlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=E4jvSbNB; arc=fail smtp.client-ip=52.101.229.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="E4jvSbNB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXccFez+1uDQnp45wgHrTkGb+aMIZlB6s/+WcI97PRovcP94pio0T7DSoSM0LAXhBv3J3fBSpldR2mijCOl8YP9gPdkqotFYS0WZR7cRXEfr4SJW2h3NKbR18iss7Jdbgx1sGzakdiua47GHMNPr4K/6IR5bPebCfdPTdQZR9GstlvVNMfcWDgC6zRncIYmVq5RrZIhAQSLGe+HZgPtHEydJBbclxVxwzs76VVt3CerNzHjfHntF+6/iRcfz6rNmnI8eJGtC8VS/g148JzLCUpc+jWRFvRPzsbFzkVtjyy85u0td9NxNlIFwgENBRNQOi0pCW0bMMF0bJxogD603nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxKM4g2cnhRS4BJ3rwkAUVEyt7MouuQgM8CShcAiPiE=;
 b=MLoVSUp9TWy+hHqCoCLsweLUQtio2gLemOizLLBVaWNC2XU4lGc5zBEGSz7GMnQoSNY95o1cj04BTxCIpoGvpY6lqtuJ6pnQ6xlbq3AN2vSiNZkn/nQiK1FCU8tE+4W3/WcauhPr4KDpcJDzDYfzKmyAXBjJsG194BJoeXMLomanFaKlIkDVj/bqE8/0wuv40V6Z3UO0k/0io9zViFMbmED/HglnQOYWojRIL3bL3qUku9QPOVvoQkfYRWusUFL83nkA+J4gOwfgJE0aDTimRiw/Xq5KAS76iPV0JuP8SEUINF2lSZ4cc2pUbt7BE6e32PU+OmUvSnpN4TY2Zhgo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxKM4g2cnhRS4BJ3rwkAUVEyt7MouuQgM8CShcAiPiE=;
 b=E4jvSbNBH6nlgXFUKKll+lMUFU3Yrdcdsesyh2d+NvPXs1t9VPK9/LrB5875f/uM4yNRSkBH5YzlhFqGo7jUQezKH+S3FrxuSKXq8n4vlguIIHUVIwe5fz7Epa9a0KaBNgzEoA9wBhwPa117BtJ4IasWM11w7f8TZjXFIk1P3EA=
Received: from TY4PR01CA0036.jpnprd01.prod.outlook.com (2603:1096:405:2bd::6)
 by TYYPR01MB10480.jpnprd01.prod.outlook.com (2603:1096:400:2f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:33:45 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::73) by TY4PR01CA0036.outlook.office365.com
 (2603:1096:405:2bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 13:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 13:33:45 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.2])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 06EA2300020C;
	Thu,  3 Sep 2026 22:33:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3L SoC
Date: Thu,  3 Sep 2026 14:33:10 +0100
Message-ID: <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TYYPR01MB10480:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 875c10e6-7a10-4864-02c1-08df09bffa4b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	26RPPSKpv58nrB8xRnSl+ADRt+yNtw2A3NwTpG+FAoWufaYKAYZo7YkQbJNVOhSHfj16fT7Gv3lrpHvYo5bNGWiLm18OTZDaa+LVZ0KReBXV7NA4Q7Xkv7YGeLcqN8qt3CHoCD6ecrjLqkEt2qHwlJMFRSAtiuB8mCRZjcZjLIZ83hE6gs+HnKoDS3AwLcL1vitjxWwK4GY47ayOaUdM+65Bo7clOIEw0jaVjbqTrcG1DzhqllnJ7sCtSKiYkqMAwvXIdzkFhmFi2B0zvIRfRQbT59jDQubo8mtY7QXY8qUZBPx1+727vD3zjagJxIvkoLt9k/5KlFQZrTPlZ9EyGmoBBV7kNmkcBJ6YNqpDEAlSa7FUgCVHiJc77SS4j5ME6IAq9C9YPj1yng5sJWAJqtWMM0/fzfQVZo7nMZjrA3OQrlZtbVNInUIycQkdsZZ87cbhOUy+FNPMExEy8Sv4KXQa4PDdjLRXNIpGwrAzQipQxnhi2eATDq6BssLAtLy/xr/pFyOCoF6N+KEtkIhfLxZNB6Tt0lO6m6/yixnX+IBDRYU4HEbLSO2NVbVLu40havJSw6xIzgts4MPX0h6cetUhqxV2Z1zV073gzjH16B27ORyFND2BuAUexGjqvMdAc5EHu4AHNSGEYJeyrG3ooWWtme6m8d+wUs8HTENX5IS/xPtGYe+lTN7fpvcVRKj0PrYes/DFz6Pek48kLqwZMA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BUbrt7BjCXPqDymKf/9swWHfpY54wEG1zloZUccso+9CH8p7NunWtAwh21cn5aPhMrSz8BvO6UfJVBl92gz4w3DpIZbJ54KfrJ5iQQ5mC1Z/0R/9Z1ioNkLGDECQfmOxGpKdpgdkpCTKM22fATYgo0nNlX8OH/f9Cx+GcnBmZ2WHgyo4iJtYXwGFh9vz92toRWT0ySzp7112A2HFZUw+5uun/s6ZU9GpeQyacYy7SBV6qg+fENHBr0iobRiMRBy5jPmSjPGmMVDI9glGNXa1ELarwLxt+Aqo/taC7Rs8h+AQrf2DkGKMaW+zu5SvTP2X3LMwd4cWCgfWXUzlVN3aJ3Ji2Wg7ML9CyStY8Q/twmnwB4vGspc1IYteInTSsB1D+2zf/le3u5mXzsjrFOmqcjh8PnmTo9SIN56DgdO1ryWroQpJ54PRZpRY17n3dCh2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:33:45.2029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875c10e6-7a10-4864-02c1-08df09bffa4b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10480

Extend the existing device tree bindings for Renesas RZ/G3S PCIe
controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
some key differences:
     - Has 3 clocks compared to 2 on other SoCs.
     - Has a different set of reset signals

Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped "or clock for L1 substate handling" from the description of pmu
   clock
 * Replaced enum->const for pmu clock
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index 09d78bd1a577..7827d81680fe 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -13,7 +13,7 @@ description: |
   PCIe host controller found in Renesas RZ/G3S and similar SoCs complies
   with PCIe Base Specification 4.0 and supports different link speeds
   depending on the SoC variant:
-    - Gen2 (5 GT/s): RZ/G3S
+    - Gen2 (5 GT/s): RZ/G3{L,S}
     - Gen3 (8 GT/s): RZ/G3E, RZ/V2H(P), RZ/V2N
 
 properties:
@@ -21,6 +21,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-pcie # RZ/G3S
+          - renesas,r9a08g046-pcie # RZ/G3L
           - renesas,r9a09g047-pcie # RZ/G3E
           - renesas,r9a09g057-pcie # RZ/V2H(P)
       - items:
@@ -87,14 +88,18 @@ properties:
   interrupt-controller: true
 
   clocks:
+    minItems: 2
     items:
       - description: System clock
       - description: PM control clock or clock for L1 substate handling
+      - description: PM control clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - enum: [pm, pmu]
+      - const: pmu
 
   resets:
     minItems: 1
@@ -215,6 +220,8 @@ allOf:
           maxItems: 16
         interrupt-names:
           maxItems: 16
+        clocks:
+          maxItems: 2
         clock-names:
           items:
             - const: aclk
@@ -223,6 +230,28 @@ allOf:
           minItems: 7
         reset-names:
           minItems: 7
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 16
+        interrupt-names:
+          maxItems: 16
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: aclk
+            - const: pm
+            - const: pmu
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
   - if:
       properties:
         compatible:
@@ -236,6 +265,8 @@ allOf:
           minItems: 23
         interrupt-names:
           minItems: 23
+        clocks:
+          maxItems: 2
         clock-names:
           items:
             - const: aclk
-- 
2.43.0

