Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38019E839;
	Sun, 23 Aug 2026 04:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458061; cv=fail; b=T4e2x1xT0kC/fAAQstPrOlTIXKp2Fjdr64kCm/j20AzTQKehJuVqDtK4UttXkOjFBUwwRMxvW/PC1bQC3potY7L+wy8HMHiI9zLb2cTd5H4q0bLbPrWDGwYQc8d2osotiwCAReaai6R1p19IaLo+XRhipiW4M7vkksd8vnwLd8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458061; c=relaxed/simple;
	bh=jH7GowXKfZSEwK2DgU+68vRQE3snJNqBagL+UU9T8iI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSJTV2sYnvhxUfNjcyzDMCfkT+fw9EHoTgKJXIKnJToPscg2TtLsKnhT4SQOkmqD5eKSLo9eYmdYv32qp31BYO9Xi4QRSmWFqpomLCXmcuINzJvtHGsonQLxpTGvftycYJCMO0eLcpe0FbjF8Wv2zCh6TB1v+IYYbVDXLU6aHIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ud02kNxH; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ud02kNxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv+WLRldMVSMEqopyVwDYyuibn01mCTxSOt1TrkhMyGFx9KNfMnfyJ5UrqkYZ2igEbFuN8pbFeTuybzbUo+XJT/vlXA16Q7vtyEgeq3UjEnnBId8JzMeF8wZxVZZOwEbHg8GFtScJPttaDl2NG4WPnfJTaAjgwQ0THbf2/ch5t/Lt2WqwIjOsIxn9SiqI34AYN4N3JOpQRm9Z2XIuSrXgpSu95SR7W4d237qojnS0Ygk0hLBHQplxYMMT68hkAIcKNyzT9/T6J5qc0VU28zEw+c+UC6THZOOtHk3zPJjHAfBxzrVvWGEtWHIy3OxxYwWqhnDFsMqPUVGE1Vb8n1EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st0TM1Qwg5Tf741oy69W92lJGyUo/r311+3M+uEQ0/o=;
 b=Bre3guK/cXuO2OsrEYNx382+WK1tn1oqd9Ii1o3aWBuIxo+54uTBQSEhkBJAWrsCn/WcMAYuygsI40RE7cLLHO3Wyhlm9Tgik7Fw1FQHuVJvhFYanrn+m2z1ejJYjUaDQAtEXR+0nyRgEJxnDle1zMpI598/OYhRM51EzLOv98a8nuVDA7cZvb4MV2CML5BxYK1m+ceH9lZ/1jNZ+4EXFv7/j+Tquz1Vzq323Xp4lKrK2Bygp8L5r6SVrRODGIkU5g4aZEzMNQ+Ugu4LmdDk8wla8aGGkIKdbZhleMa+2RdKldm2MyXT8PeY6hzhMa7rG2zKu+YJY+H+AA/JDMXLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st0TM1Qwg5Tf741oy69W92lJGyUo/r311+3M+uEQ0/o=;
 b=Ud02kNxH9udEB4vT7FEsgiBqrU9gTTh797LVGFm/jtPrd0vVDDwzKNWBMOpvJ5oH1A+QsP6CN8saGUMAIeaKQhg07OHSmZHpKtiFqEtiSkZGtYtWq/HIZ5Se6GN4qtREP71UtKLjct4QXUz//jXTEUI0mzenJ4oORe4YdNEDUtQ=
Received: from PH7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:510:339::32)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 04:07:33 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:510:339:cafe::90) by PH7PR03CA0017.outlook.office365.com
 (2603:10b6:510:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sun,
 23 Aug 2026 04:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 04:07:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 23:07:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 23:07:31 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sat, 22 Aug 2026 23:07:27 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Date: Sun, 23 Aug 2026 09:37:14 +0530
Message-ID: <20260823040715.204096-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260823040715.204096-1-sai.krishna.musham@amd.com>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: f04a359f-9181-4607-1dbe-08df00cc0e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|6133799003|13003099007|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cjQevwijIxPDlCJILa6bxyLbbZEZ6+n5aoFG7w9bfzwnQP/qPkL8h55Sh0Fx90xxzFYWJgZ4EEqgkV7POohdXR0UqmxNdU1SWtePv1u00FhYVKOpJJRZRvAxNs2w7JeKxsUXQj5QKDmq+RwjwoBCQCvMsLSoZapiTo5s7C4z1FBy57YMOD3NjHzGmIZXr0sEiPkoIcZP7xCqPfKpUd5y0tsPUCy8efq7Ye45zs84d0omZ9s1YiCug32+lj94cJmsGim8driUYIVlSBiKuAQUXrHGGPmQ6sbiyqZQVnuOUVdHzVgifnwQQys6z4cynVF8v0apvOleVXoww/V/7IGXsICTzwbgFQz/Pkbgkk8q08berYerUZQS3rvGnT5E57LDnIesAdRFtTQRp9/7e0Tfwc8zCzYPJs7+GmvfevsejXcEHbefuUhxLTXhL3F2v46F1Dkv7QKsVi01S9vg3CceebwDnhHn0ntAe0eSW/8TkTD+8LMeUQ/Om+evIxeqeGMhAysRosf6nB5VVD2TNFRYoFEfdS7qQK68mBNFxllLUAGz2Z2/1wRPTUkd4PXZzch4bRKLHXQeARDrLq8vqvnYIdNceX0upJtqGIPcR7fthHYi4xqQGsDDUZA65TvSgH8jPz+f50JhffbF5IgvBbUqqyZMa10wp+dRaGg01yxDMvfzFzJXRzem3gJx88ajqdCyrPMKgfZOO5aRkJ8UWfkheA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(6133799003)(13003099007)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ec+v3THWTubUvBKp+FW5nEca6EVUYq2slpuxLthiagDjC55B5LVSFg7/Yp5Wisq8DKm9WH31SIu2ZlhmCB2mvaJTLpGQLfUKuvNVI9SQm3paT5+jkH3y2ReFFaUfVtAU1rcfneR5XGrUgl/IXpO97nsKlTOEOawBi7BYkV5Bn+AT+fJGVd/wr7zkuAWKMk/UFsWxJpZfQH2MXqz7cSxsTtSOuHO32cOchKgswCFPDj/30Jx8M3AuVxPwR9UaYT0J3ZE3xPmidLeiyZfEnN7364YD6XoOFBhPmOO/23c6PbhZFchsbPlM2GhZY+kPNQQWjfJiqZ95Gi3fE5foybi3IJ/OLcRXuLzm/zHOc5xjA+KZj6cZVETN+smV3OulaBlGeRBA4KF45erGDK5TC+UE4XMUZCiPFcgM7Efq38Z4cqH2OXApNop4HIzGul0l01kE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 04:07:32.3312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04a359f-9181-4607-1dbe-08df00cc0e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

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
Changes in v6, v7:
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
v6 https://lore.kernel.org/all/20260819172057.3636214-2-sai.krishna.musham@amd.com/
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

