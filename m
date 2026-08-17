Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623E2DA749;
	Mon, 17 Aug 2026 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934390; cv=fail; b=YW8EB7+31vwtwToUNSHXhN5vJgG4xb4mWMSu64aiPysInqc6KYDhuJqtDSzm6qNOPu/cmY6UEFQTekicIaqpx/5vgjsVbolUcNdODG9gRnks8pVNp5HCH6qYBf29W2Vh4Oq3K4eHf+dErqVc/eHOLHnpECsaXfwRoE1DOlJQ/bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934390; c=relaxed/simple;
	bh=oASKZmhSYMtTc3A0hJKhqhZHMjGkOVxY+o0uh3Uar0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZO6KdiHg6FFctsIxQ3L9S0AyA77VcseFhGa85nO8OCfBRePOwoeUEMM+6iC9EbT78d97ONq9u2XSO2rcYO13OS0WOzDSRrNA1f34toTDTSx4o47Cnew2hNmtexL2M48yeNaMj4gHjO06DqIW++RjhLXg/mVBz9pGdlq/m6rQew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Md8wtKx4; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Md8wtKx4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw7yZDz+EFKTrMKyBvbDACGQ2pV9XuVhcjX08ewxgQKGge9S+VpQvfmD0S6N8jl+IXYBXHkboyP6gRPSmvdGpy3XRXE5Ev9z+itGFfbp7yZI9/BH3QXoI84ygO7zmOl2M07E6CW9a8He5rTB8MrsODi5uKdqJOxFAerbXIar56o1BdEK/NcUnVtoCDy5v9B2zDKzixPNztr+25j/n+VBOuHeOZOx0AxPdqiKlKjbz1RGYkeZmsH1ozXGajGOfYkG5Eu6ewr2GO6bryp6gWY43102yPiy2W/I4MdbswndsiPZVRzHMTr1gMNFB1N61fK6YUy0L9dpTtc4iD15Y+AnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upjzfDERurtc+01dDJJCGXKd/ktTZ9H0tsfH61qzpcI=;
 b=yY80Wjbc09v3VSd1ue6uoKMPtxtEqqmejlvCs5IWfs/0ukE4H7yFro/n2rQv2gblXRJcCLf65S4f+EUdF3DM8GKhNS65tgpMT2nYDQG8CNTNN1wHmWoOm9GPqJM2IAx6kCYQu43z6ULcBSC1eyFTd4k1axBCoQCmJTFuC9qEfC2HX13g+vQW3Rhfffx30xQnhQpTRU9XFQTp2MvTmzpESHeUs3xx3bj0H/WhPxz6GLcKO0IyNMDfqUIjShhCZ2pIp6b0PIFRYPwCxKxoHPuMe2DttdHyO5w29eO/fdUnvzOgwW0gB6Ap05E/aF3QLAo4U+y+GuT5PBqI2hiQJ6uYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upjzfDERurtc+01dDJJCGXKd/ktTZ9H0tsfH61qzpcI=;
 b=Md8wtKx4p6zY+fGUXA14qljNfHttzCrvo53bK5ABeTHo+hXZkJDL4KpY8I9sY4sLTJ4W6jYKNjVMTY8oaQAwOuDFHTbNQSmshfoHdy+lLuSduEyJTuTFw/KcdLt4lzcSmUfboXRXguZXoDPC9Fu8EklkPgwgqnpIi6p5uYsoU9o=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:39:45 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::93) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 02:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 02:39:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 21:39:42 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 21:39:39 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Date: Mon, 17 Aug 2026 08:09:31 +0530
Message-ID: <20260817023932.1743100-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
References: <20260817023932.1743100-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: f8989ad8-ac8a-4c91-0c6f-08defc08cc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|22082099003|18002099003|56012099006|3023799007|13003099007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	MD05kmyjSe0hODnMUJP2waCHJamYGfSbvOfVSBfMPFRvAWfNytt8u4KPtoesRKiPFWRlnwp12DmbRzQrtDBxOCcadOrZmxCpvC92Nc94KnmQC/wOnsS9VKIduu6ie35VHFoiBqm0CzM6Nix1u1Uvs+peJdKeq5DNQ8Ba3ou52MbcVvvEYday0shFkyQyZV3G4j5DUKy7gFr5Y7A/kHCnejkiDtAllBVUp9QfLXuiQrhoRuaq+X0CJaDqQ245eiuLj2/7DMvlJ8eWnGjbL6zuvYg1g7mWAD3mamlIjX2rpwL4sPcpiv67yHRnqu+GLq4hEdZPOXLwGheBW8bEFF2pjegqsUElePuR/e+ejbt4FNR+a7Ioud1JKZpnIdD9KomL34EDDanPFeAspXA0x2EhfQW4gXIJz1dhtWRnDXjzBNqZlKGnjVpx7WGI2AdcJ+Po3z7XwuUw/7KWfyhSSsJLHMiZ5A+3ed+FrGPCRP41LKUlykjBfxk7ryGkBeimrmqsw/EPITo6yj2noT8Iah8pmTV/ZanER5tbpC9LELUBL49rFJljgqHHxIpTlX/OgmErRvMHXRKdaEzrs4x/HPUTLXuxfiAPBR9gRjUvUcUJGyibRtKwx7vAGW3t0ue69u6qBY5E/whyrKF0ItFQ5Ju9T7ltLkokeZc8mD4X1z/JVKfMc/65l48rCEmPKrRE8bkpBqZWWK9dDfz90sf8V0HAvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(3023799007)(13003099007)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gglUGg1lXUQ4R42DWEe8snYcyp+Md7C9VzZCoqlemdbyPem8+4M+yS4dT/M1321poYkGIK1HWrPEMxVw0QRN54YMqJgOaZmcwqjTXBXJLsKTc3uNOipByAoc1+OXl+ETzhT3oKabaTi03tuek3QSaVT+eHDRZL8kRSfR+asHglzfwQMS+ARMA3H9v6sP6XMZLqamK+nLl5AaWVabZxfe96fgIBkNUyzijEYC75FJvI+fSOhFP3zTC4bofZ5DzsqhGDfZFGshq8fYB22m0gqpCiRdWPC2J4kgJbQYqhVdM7Xbhzxk/gQieafa92rdVRNMZwYmMdsBSN3elQFHXBeEPACJlgOc/UuGS3Y+IK4JRReYpzIi6gayMvLbSJNQ8bVNN8eOQ+WECiS/DdGqKdbhvATkVMd//TkGpRkymcTP52qWAWSvEbe148EPACchmDDM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 02:39:44.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8989ad8-ac8a-4c91-0c6f-08defc08cc40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

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

