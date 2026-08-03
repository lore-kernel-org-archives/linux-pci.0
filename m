Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CF411FA5;
	Mon,  3 Aug 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768278; cv=fail; b=jNPTAXl5e8SqCLeRb6e24tB9WN13qs+WCniqNKZHmm15zo5tEdz+HJctyzJ5M5VV+bRSFNGoj288LZaIb85g3v/Ar3PkWPS2GBhg6qum0S+cTyIVP39Qm2ITk9s2EnYmJyUg09yaZAQOJGOh4W5+DEVhRVdKX+Qc2Yi/YONpTko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768278; c=relaxed/simple;
	bh=7rrf0mDJ3Jo1xV9MwuIgbS1sxikFkAIN9zNrMuaitfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvJhBLfPC86witRhB5w8naDhvm5wJeTqC+UXzO8eyxZHjOpGrysOGDBJWCDPm/gcXBfFN/awZY1toK8yGVHLrsyl02RXr9u1T92UHIpgI+h3x4YNDktVBfK59L5x80Kj+II2oI7vZtujC+zSKV5+kHH7ZckNOVkq8FQJC2QxWsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X5G+hPIJ; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X5G+hPIJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJfaPgHKJg7wryBcdC942yC3ooNu0haXuxKP9pZMWMqGf6H4OgnwgF+1a7o7kNE7bRG1ad3eS4UcqRzD/pHdU55N+MezZlQgRUvs088pKjx1PF2EAkDe0SDlj3YBPByNIJ8u/I7+gW/R0dtI5jLx5ikI3DLWhzW+Pqnpds1ioTWlYEd62Rf4EsufczpH999F7lPwnGgJj86G5jrEATlcnhKRzT7WptctXDWVXwXCwcBTDUYqJNjjygmQwaKDUXlDFhi8XD7Oe8GJXFVVFO2Mn2BcBQR7G4aP+YIDuQBAIdsDXpKgBHFcCxiVjrOYiOd3PyGBvvVSt2ADLbxYQJQBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyWoqIHSNeLL1goqoPi70WCwT2lDqugV9U4JvTdZNkI=;
 b=LOiT9BErzzO530zRWc3c0CQDHCJp0CUZSnmq680fwg5XRDhPRl+FYvbf3t3GhHbspY1vwDu/GGrszrpTMlZtc6BUACu5uYQa8d6Y5GjUZYRNgZkTKGmc5TgN7Ywm/GddwQTKyMcAkkXD0VhhdX4nkbm+Fhn0HFrHCbgfeTfQVZBp+OuDTJ012b/G3lUcNdB7/D+JLWo1Rpa3PmqjKDIh/mbyDl9KwCya4MWuDBWK2NpPP3C59xrPZ3hUu8lTAQdMZZucceNovAAgcDd7MCO3GzGLo910e4tvV8tH2WmCPBlMllOA1f5hZkadUb1yv9lvVWtIBJT+1bCxNWgtOMGfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyWoqIHSNeLL1goqoPi70WCwT2lDqugV9U4JvTdZNkI=;
 b=X5G+hPIJIPYE76VZKrAgozhXKRwTKjLQASHR72yW32g29Nha3vNoOPD+vh7mR2qd/16B82bzP4GyvGgSqh/L2bILSwjOJqg9LbUr3viRbJ/4mHWJU8SzXqa1hQoBxkn/5p/bYlNgo8Z2zmUlWwnKKeROFDgxiPlubRsi5A/7SS4=
Received: from SA9PR03CA0030.namprd03.prod.outlook.com (2603:10b6:806:20::35)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:44:29 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::97) by SA9PR03CA0030.outlook.office365.com
 (2603:10b6:806:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:44:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:44:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:44:27 -0500
Received: from xhdlc250058.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 09:44:23 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>, <pranav.sanwal@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Date: Mon, 3 Aug 2026 20:14:11 +0530
Message-ID: <20260803144412.713639-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260803144412.713639-1-sai.krishna.musham@amd.com>
References: <20260803144412.713639-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: a2225ab5-cca0-4080-db87-08def16db8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|13003099007|56012099006|11063799006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dwxIno17wT53InLIovmbplbIMntCrqzs4K3nE9vTP/o6s6kO5utJPgzn4xO+tc2SQSotOwxElYMdd+8D9GEzBXfjJ/JZ56o5gpL6BAHJsVgHa67OPQzJqiuGLua3Qk3d1KGLQF6LOId/6iQLQOwMPFIbypKddUIgjzYqvTgz1kbjROo0OfidHxCdVjmyf4b9re0dUFahC9wuHqXn9jLB+BN2BVUsqUyTPC4hBE8KYKQI1Ck9A8+nkN8oq8+TMEIN5A6IV9Rozrz/QGkZ9zpvP/SJp4RPRuFHhA8j+hJU/osIGYt4Uu4Upt4VTIcEuh1JV/a7rWw12Mke3tVc/WYkn7zEPXd5VIKXupuVOclRj0dekEA+zwEJBP3DJDLOrPJg764HDhL03cn2pfZMTZAM3dxL5Jx00ulmx1HKJELkX/wDrpCD/g9D1+GOgh4hxp5bmHEbk5qsgmVqERsymgh2+BLwGX9A13cgX585jraXSZgHfxFYohN+JHud7zsp+prnqvJR0l7a6Aq8xnEF7S5rzARewMOgjQLbvC8tFlMzEknVbUs0gILlGhtIoqwe2PDp0a3wSgwhpVjprVwISXhBB2+Nhy/HuyvP3SFP5Lu5/Qm4pDxBs1rAxrPx24Au+EqvL+crv/jtLj2e7jf+ddhKBlF7d8Aa0XpBQekwLLS2+FsPdDVBmodFE6vTQ3iVnd3CRO68jehy15Zlw8vjK+MzMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(13003099007)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M4497ipJhwspVZVNYxr3skvkkfBOa1E7SC7i3GsT8AASmAlWSejrAltkXogBuiUttbZJ7i1r32uMmfAOuzrBeIsGUpnH+gk4gjpL8pVlqY9huQKH9xVgXr13X6t8PdglUqITJ8pm0mM2ekAlx9lTxc4li7KAVUhRxTCrxfUlKbkgMKvrZ7GMTEEHMKl1wQQbY3V0+WtB/+Ns4qJ5i6lty6svuzCkTll+kksxkDgcYmzhCcyGn2NYUrKel/2z2fHM9aMCdSBufoRLksqtDBf+q+pI6FMAdaXl+Nvi2rO5k7g6l037gck8miGNZ+4lBWMIkiAC88FFI/DeFZaPOvoOhByU7d18Mvi8HMY98gkPR3Vrk8Uqhlwooak5e1xM1Kj7pLvJ0EMXWmlnpxb9owPZm4veDVYPx1pZdcS0KALKbILCabZn1qBmIlX1/coC0ktx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:44:28.9013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2225ab5-cca0-4080-db87-08def16db8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
per-controller interrupt register region used by CPM6.

Update amd,versal2-mdb-host.yaml with separate register definitions:
- MDB5: 4 regions (slcr, config, dbi, atu)
- CPM6: 5 regions (slcr, config, dbi, atu, intr)

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes in v3:
- Update subject to match history.
- Move allOf to the end, after required block.
- Drop the CPM6 example.

Changes in v2:
- Update the CPM6 device tree binding and example.

v1 https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/all/20260728202044.1785986-2-sai.krishna.musham@amd.com/
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

