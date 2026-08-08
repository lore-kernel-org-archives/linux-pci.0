Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B33B7760;
	Sat,  8 Aug 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186397; cv=fail; b=nCOGMb1WkXthBHKOryz23zWN4SbYfZi4ISIiz22h6tKIpmf57MU3LGTrLweoCFr6Z0wiqDjwmgeQERWFRPEeOQp0OImQJO3TH6X853Kaxz+h3Ix1G2i2vU/NYkpZksQU3n9NOyduMWHtSlCL2EY0sI+Gmfo3ehMvinxoLk4mi2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186397; c=relaxed/simple;
	bh=gZpipfpaVu7cCW/VyXAjRSHjaGjZYwayET4Yt4cX7qI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hB83Pz6ptl2RXgE5yIkIuili6T8RaInqnpo66TY1NxFkusgZ5WgEUP2Mbrvdrbe1IGdt3BUyyejcHWdjcKyFKkeEc0UU6DsCvR3iXKpy4HLzmpVJ1wDvsEOXObHSx8yJGqQ9H+1QT7SV8URb2ySDYdMg0Yx7fW0kJx3XJqpCqFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eRXNBZ4T; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eRXNBZ4T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwV6tcmgTFw3rTD6vowhK6uvwnzbSdN60vDTCo6G1deFrC9TgcCE/9EULHdE8V+hZXd1lvKcahT+QG6ydH7bhqcgUE3GGp4vrFqFR2rr3YDHDiOd6ekx/WZSmzubBM+ddzoWFJEAjOJ0057Fj0q+YaPAMliNSiztOIgwOBW3pJmx43hG3i71jHKmakBWEPb/uZoRv81EWMJvqVcZHPT/Iv+ywAINutMoixPDjBhkoot2kWAd92GycRft6minJkADSwEZa8GVAJsYviq/us9XyFQeaz0oGZHfABeNfC6+4E1u9lkK2mpTT+n0XNMjtpFNJSb/EnaUtGzIbf/f3m60mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y4Q1owlllyg5OADgsE9L9gqaj1R4cqsxg7jhf25Zu8=;
 b=O9dyq7awxnIdoEqR4+1avHHgRrCY3eSc+UI8Inxx68Yb/+N7lyeiqQ+mfcfpzwnkEntiPvqpiczNaTVqJu+FhiErscED23xjVKIc+TxhSItySnoSxNz6cTX3Lb9W0xkxgDuee89xCPVeL/oMWTkRJelbhXwmsO1NrhrLFiWPyr4MaWdKcvqoWo3cQUQ0KsdeQVwOuEzfIReI6cKMMGQZXoE+ENuyhBOrwgyCaw0L1HH5ytEVZ35CsQUAT9f90/BMqRrayo1UQcvCJc4yQ1OwbayTjtFxZAT9UIuDJiYiJlA1YFnZhJQg3Oc8Kzc1pw6lG1VkIBNXyf/8BgQILQS7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y4Q1owlllyg5OADgsE9L9gqaj1R4cqsxg7jhf25Zu8=;
 b=eRXNBZ4TF0jhNCmQw9RRcSdKSFdfauF+Mcf7kAiCJhAiVMPdbJklWzGfMDWYkw8lzoR/fJLDaha8VoggZE6A6Phh/fNS25zH5e1TkVWYdCmStuzMnTiRl5hBC45h6pAD16TeaudMNi1ofXmPsg+RgM9ZnckpGxCNg9Z2oKeRxaw=
Received: from SA1PR02CA0016.namprd02.prod.outlook.com (2603:10b6:806:2cf::22)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 10:53:09 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::90) by SA1PR02CA0016.outlook.office365.com
 (2603:10b6:806:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Sat, 8
 Aug 2026 10:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Sat, 8 Aug 2026 10:53:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 8 Aug
 2026 05:53:09 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 8 Aug 2026 05:53:05 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Date: Sat, 8 Aug 2026 16:22:55 +0530
Message-ID: <20260808105256.3705889-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
References: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f70eb9-e376-4812-67db-08def53b3c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|13003099007|18002099003|22082099003|56012099006|10067099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9DUhN8wjYwMbuZmupReLgj1RRMSsQrX8te8saEFbM3fqe75jIfzYdQPELSZsok/JPV71QL0YBY3iLYyGXks61x5foMXjE5vTWXinbnlOZmFZRoyyRFngrqvuqvuG/sUSDNzoij+pCrPPz3jndVVxJy8grBX3+6EF/WAuVFHiqWq/YGArAz0GnMvO7gxO749XTmeh8mClMAYf+Q9s/ntw3RM5CqViPx0pl8L6CSSxgrm0jtS671dNaFruzOMS+fiUsAuD3GT0j3SfaJL4dAV6XdC/EydsErpizxo6lACMOgkLdbMZN4UQk2GQJHC+d0h5Zv4MVYhv57U1qPKj1Usl0HKFRPrspmE1jXdkh4JhnnxUu09mBQLOkP/UzgkdbrBErNctBSnHQJ/C3aYpd5N9kD+aAUxufjZFtSiMAmN1jyBdIebsHSlkMTnBATKS/a2bNRWTp5csApOXGG+nJt7bQYNDMgX7DcJMI0UdyAki+Pu90Y4mWYJn+wGd5Nfv65X0sK1xztGct4p/nAI3iUDBpA/mls0hc/buUspqIQILkVHoZXTC81JdhH2sPcxDiklDFipqI9KHuh7qrMijSLsYG29Hh8Bpdps3EQ03UiXnadKI+obwMVD+okmM3ZumF/jFd7v7ua2getR74Qr81KgT5Ot+qgfoe/uYavUKii8Ou85tjBBX/3XNcArPg6iX+9Ja1zQKOyZbREMnR7LpKo4VQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(13003099007)(18002099003)(22082099003)(56012099006)(10067099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMqk+ggPgg6hpoy/LQnpD12B/hGenxVVTQLsC8a/U8bxywhAezSkuksKZcJ0BJaCEwoB3p6kziIk6KU+RmUVxA9A5s0iWRn7CX7VaNFBFTci+PSlBrrdlPpkV1WcRCaVKDIyzyNGjAZmiUeXJuzSkeKmyVAzvuVzjTpr8mV52UnneD/aGFwTspRP+k92IBKgvKCdRsFrX+ad2QPhDYAf6Vj3qoveO218xfqTxBPwGC6UzgkeLFLy5a11/EL66yiEmulj2HzDZ9s7aU9j85gG18+xdmr50u6vDbkb5wnd0OCXJqJonqYW9lK//tzhjZikqlgPZtVdIcfjfpfu1MrDZVBkqd0Ft5lOBTqjOH9zlGVvhmvyGDRleZbtpchLK4tBUSCs0DMupvWgCL/SWo2TScIC6AUf5+CrcuAyy6GMnt/jig6PDO5UjJpMvvp8DwrJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 10:53:09.7100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f70eb9-e376-4812-67db-08def53b3c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
per-controller interrupt register region used by CPM6.

Update amd,versal2-mdb-host.yaml with separate register definitions:
- MDB5: 4 regions (slcr, config, dbi, atu)
- CPM6: 5 regions (slcr, config, dbi, atu, intr)

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
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
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 45 ++++++++++++++++---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 406c15e1dee1..672589066854 100644
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
@@ -92,6 +95,38 @@ required:
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
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          minItems: 4
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
+          maxItems: 5
+        reg-names:
+          minItems: 5
+          maxItems: 5
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

