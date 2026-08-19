Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E51494836;
	Wed, 19 Aug 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160106; cv=fail; b=uHUI4NJqHENY8Lo9ORgm5qrSMRga8XzSN4e8iae/UWx5IirAIWI0Fp+MpfLjJQp+mQI40o2MjVPjV0v1xG8NZ/WOVvv1wws3sGeMaLSVsA17gpNe3ZJ7dF6iC0Nwk8lZolfxnLq8kdZlQ6M7+GMlU/QXB7JvtPxjqiUyRZacZO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160106; c=relaxed/simple;
	bh=AOKAWtT+X7+l4mOa/laq423zkojmk2B8N5SGSMg3VAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZSADA1sHNv/8YGg3rLShLpsEiH2avxLPYhS7JNCb76weR5oQDGgPnXRoVDsLyW5Kc8uyDq5zMw4pclebft7TfA66jxdI14IkILK3FCTu7/DWIEoGe50FS6td+YemXdkf8IxIZq7sbhS6PLKNYCPhp1SMU2TEjvx5EfcQyXgK3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o+nl4ZH4; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o+nl4ZH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojxTElYaDKrw7gnBF+iJCUNZyqQq46Iq69EtAhCzwTljquhsQNRyLQfZjec1F0siSAw5lZtUa1YhK/y3ABbh7Zr/4uSphykrqTsp+gBW4NOQ7fcQzJMbItn/Ep5YDDYd1naxzGEh/yCFoRiv9+KOJLg3oskvNpSgz3wGZAkUW766HUDSlHqsBt8vx8dhm8cuDYUQKBZ97nYE1JymMaGyT2QGCb+EkdVuYVC1EWO3XWQyzNuOeCxcWtxaEWxmo6fjIoIkEgkaudTgwQu1B6enHArOV23JBt/ES5UiwoSZAZ5KarCVLvVjyn280CeB3SUgkZMaSBS3UiVX7bTQvBOIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6+g1TpqDwJcvbxYobZD+Up0f2IY7b9Ru5c9K/L0nO0=;
 b=gYmqe3+heUNOmVCVMD87rw8/sfGVhR7ufSZ+jS/Ln9wiqEMTVMyyiNGR1dZ6jh+FPde78NURXePSfCjvHp6U+KApDDCe7CqG7l1ZONw+qVHGX00Rh0umoX1eD5Bu6/WEH1ovk7UdKE/Z7T4kID0iRz33IT7jZklUHHVqEmctXgbs++C/L/8aqNcbWgqVlfMf36foQ9SVQeW0eT0suQXoVqo5ELaHJoyo0TE+S1Mp56vEpaTLOe6atQeJRz+HOChtWzA/oiyaLB9O6EiIKpSXWsFbgwvuHuCAlceCeC00LG3EPoSD3+bb1FbIz/I4A+bAZhhI6FhxCYL/wXiAuF0guA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6+g1TpqDwJcvbxYobZD+Up0f2IY7b9Ru5c9K/L0nO0=;
 b=o+nl4ZH4YVWEBTUYT5KHNgDfc+lPbXAZJfuXxYLJFn/6RWw2tqw29vgf8uJ9G8klW+JqnGAv84re8JdnYOmzYmqLF8imc5Jb0b5cYt7JbgGotAjtjKgVagEYRWu9R7e9ZlUQBC/REiYkR9Mk3aa7PRs6cqHYIS551t8NyXcAAyc=
Received: from CH0PR03CA0446.namprd03.prod.outlook.com (2603:10b6:610:10e::35)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:21:16 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::7a) by CH0PR03CA0446.outlook.office365.com
 (2603:10b6:610:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 17:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 17:21:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 12:21:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 12:21:12 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 12:21:09 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Date: Wed, 19 Aug 2026 22:50:56 +0530
Message-ID: <20260819172057.3636214-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
References: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: f37e74f0-2fc6-4f4b-f557-08defe164538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|36860700016|1800799024|13003099007|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LuMt9L4q1MteHiZI+vkBYSlXjmMZiDMD0LHykl14Gl0pFvyJDDMZUTkUq1/FXYdVeUstjKSvdAV3YFPekJQkYD7fZ1iVz5yr3xYXvr7UPfeictKIpOzlLHSDq1DJ4SLAZSK2i/7NP8ultU92ILa+w8HqqJISFOf4xlD7ZHwMJ//yOFrVH7OIsYTePPnZSiDgFn9cBwLDhTTtzrpFMCjTNLheIH6NA65i0/mC1XjO9ZPL0ODsegOer5xJAwYHrje2kQRTEYhmr9dYwnkHOIIMRtskeMMZRwjL4ftPAtlV87n3CjxqXjNG6mGagvHml3xnDDPZsi60+Xld742vuZUJvnjt+PV/M/GtQPp14QVsF2IpIVHO+Sa6QQ8CHirHzCW8cbMHCYuiw8bg2WjqMs2tCsGkq3UEhncxiV95P8LWAc02evS8hkw3PTnJ1+GKIDZPd/PevWQGJTEwGYm+Wt1KyJDKDInBquECU0AeokL0ysAadCZ8g7tnXgA1Zrm7ARoj72+xx9Nql7ysuUfGy3B5vKko/yyvloCrWSNt8dLyfvR3/3N5ECSfULaXV4qvq6vSlOSvQcOTVfc5ma0on5+Z1wyGaDH3pTAIyKpdMwhtJdUJKbed9YD4bxTxDsA3XSofHLQmeM0X4XcUzHGJ3whj0cogLv4gQrnu0dfwHN/9S4u2O7pAITihfeYT3NxwbfbWTY2kbR/8TffAV48lRFBYEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(36860700016)(1800799024)(13003099007)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4VyE6XbogIec33up7rQmMChmsxL87FhCYbnlHskOJ0C1o/MKlK8buBz+TB3F08sDCCz6SEmoyWwjM2feeqB3gv6TEz19AXPtGLrbFvlkaegRVSIMwTD1mHAs3Y0ITZpCwxfSWsxgnaO4UrXwx3vureTW7Nr8oEYZ1zX3+EPWjpqdG69HcSiJzTSz0oJ1Z4/dRD63d78ZnWonPeTqwDWm+UxsEJt4A2BFGivoAhdtm636gk0O2x/8s5RkjMU2fb2FpW2AycZ5/Wn0mh0oG2R1st86VdKehh524qcMDFKKY9TAQcoL9wXQo2lIMg80saT5IR5DqhW0C4+wyI9S9bFWVAAilEHL+vtWAxdAvcJcl4rY5B3Iz2g5/jraz2Ja2aGFJX8gunE/HIeNEzE8r3QghH0QkRMrX+ctBr1QKwU5Pq8MPPfXuhvdv3YZUUxWBg47
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:21:13.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37e74f0-2fc6-4f4b-f557-08defe164538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
IP and integrates two PCIe host controller instances. Add the
"amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
to describe the HOST0 and HOST1 controller instances.

Add "intr" to the vendor-specific reg-names in snps,dw-pcie.yaml for
the per-controller interrupt register region used by CPM6.

Update amd,versal2-mdb-host.yaml with separate register definitions:
- MDB5: 4 regions (slcr, config, dbi, atu)
- CPM6: 5 regions (slcr, config, dbi, atu, intr)

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v6:
- None

Changes in v5:
- Explain host vs host1 in the commit message.
- Drop redundant minItems for MDB5 (4 is already min).
- Drop redundant maxItems for CPM6 (5 is already max).

Changes in v4:
- None

Changes in v3:
- Update subject to match history.
- Move allOf to the end, after required block.
- Drop the CPM6 example.

Changes in v2:
- Update the CPM6 device tree binding and example.

v1 https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/all/20260728202044.1785986-2-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/all/20260803144412.713639-2-sai.krishna.musham@amd.com/
v4 https://lore.kernel.org/all/20260808105256.3705889-2-sai.krishna.musham@amd.com/
v5 https://lore.kernel.org/all/20260817023932.1743100-2-sai.krishna.musham@amd.com/
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 41 ++++++++++++++++---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 406c15e1dee1..cd207b346313 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -9,27 +9,30 @@ title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
 maintainers:
   - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
 
-allOf:
-  - $ref: /schemas/pci/pci-host-bridge.yaml#
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-
 properties:
   compatible:
-    const: amd,versal2-mdb-host
+    enum:
+      - amd,versal2-mdb-host
+      - amd,versal2-cpm6-host
+      - amd,versal2-cpm6-host1
 
   reg:
+    minItems: 4
     items:
       - description: MDB System Level Control and Status Register (SLCR) Base
       - description: configuration region
       - description: data bus interface
       - description: address translation unit register
+      - description: CPM6 PCIe error and event interrupt registers
 
   reg-names:
+    minItems: 4
     items:
       - const: slcr
       - const: config
       - const: dbi
       - const: atu
+      - const: intr
 
   ranges:
     maxItems: 2
@@ -92,6 +95,34 @@ required:
   - "#interrupt-cells"
   - interrupt-controller
 
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,versal2-mdb-host
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          maxItems: 4
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
+          minItems: 5
+        reg-names:
+          minItems: 5
+
 unevaluatedProperties: false
 
 examples:
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

