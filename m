Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C8472547;
	Tue, 18 Aug 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067705; cv=fail; b=SEGh0c6mkQnrYTlPVy592vvHeLGMkQDDXW1ZpPGYoIY/3K9osrIKlWCr0uUtpFrilO0STPs7BGqTVbxB9vA0PBIwQCTJYfjrl1xO9xx0+B+4zWBaFmlZi+QObsN9IX1gHB5eMdGbdZ/BDMOEtqS/Qv7C2VkMeWS7vyo2upFevSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067705; c=relaxed/simple;
	bh=yZNF8WIX12mBFd0O8GvjYRtRmitKPLBKKV8kum9Uqe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elZDtemsLOqM5GNw7AuP+6+mKSyGa0OIR7+9WZfwogH7+WvdtGOzAmAYXjPAEu7Xf1f1rcKV9Qr2XXESuPwlIJ5HK/QxFrFF8No0mUZ9idLA8SYxLKkdb8C+FfKKiOxwTVgeyVoN97coWfAQvQrZ8ExxW+kJXObP5obUMyOWjLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xH9MjOLD; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xH9MjOLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv47WF/0ZmkJxEIeUN6StpF6CPr//zFipChip3vx49l2bbZqWhFUGNP09tmVQRHEDIAug694ZDHg+UtJaiqSUtTfxVtSlj/HaHSL51G1SCXxxZsmvemDEfCs2zKW1sPb3ExE7ctekCbrbksfwfSMy9x+3ATdPPp16mK2BupIqSNrDllUmgrlBaP+8rXn1Xe1F6vrf3I+A9uG+vmuKOKeO6FIQ87QWP4YUrvfev+dlrffvmpIAa82FK9xxtRUmQvVPU8yHWfHuf5EC017JV6FZyxmTZQiPjQE/RyRq6dfi7/1eLqxdF3xmEoY6EajNbH0HdJSg9zunje2ZMdmOCWhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkmmxMecrktGUqdWHVTWHwJ+2E1Nz6WqiWzm2tzM5bw=;
 b=Mnrj6kFH88gQZXTlfbk63gbyosdRJSDQ0qj0AliOipakM0LPWheLsx34QDhsGx+2lJS0xWNv8qiks/FFbgXWI0iMascvPG0Oj7CbAA3MWtTCVTQkzgzUbybKNL+5auKkMWhxMtWYTlrRSKPMEuqNBUKhHGsP1LErGfuoFYdSjPe6aDI2OsEq+WM4aa/ue1GsxJfMZWSstt77+ic3GeDZMNNO7qkGIRjuqqKcAH9/lIz1qkbHc+S3U2HSesv2xpIvVxfY1A+aYPHsHrfzH3QUvweGmK7nXzmb9lgnBjvIvwo3wtTvmZR3oMyHyKtUrJJPqyaREly5kADi4S2h7rpSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkmmxMecrktGUqdWHVTWHwJ+2E1Nz6WqiWzm2tzM5bw=;
 b=xH9MjOLDB97Ce2H58cxsvDGFHSjuu3LDq3eHKJ0RjgGUsoDMC3MRHY/Dnvg/UBsMJ56xSllplVdgPO18rpePLfXfz2AmZ6+KgmW1O0NKe8XvG90iKeOPHc3RXrVE4bKoMLITJ1QHRe0t3kasRlcsEaN+7QVXT3DPB/5vyhwdXlU=
Received: from DS7P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::13) by
 SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Tue, 18 Aug
 2026 15:41:40 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:25b:cafe::7e) by DS7P221CA0002.outlook.office365.com
 (2603:10b6:8:25b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 15:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 15:41:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 10:41:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 10:38:10 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 10:38:07 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v10 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
Date: Tue, 18 Aug 2026 21:07:54 +0530
Message-ID: <20260818153755.3801111-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
References: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0560516e-4148-4866-92bb-08defd3f3278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jYYJukjNvTtGA7vZ0IeT88Ooi2ezTjlf2EBC6l71qFE00dqqkEXbOeRptY2kvCldU4KHl/g6nBxjL3Wp71iv8Oe/Pe+vbv/vxTartjR+6R+GNefzizY5VI6/BnvCnnVdsISs8LR6Exh7V5wQY3yijs21qwDtzVQyzbvfajyB2Bar3TjfcREI5iWKwh5564qiJJnsF4Q6MV67pfdXW+vF6t4GBKfseH/G0nkNClTuV+gh/nWH8SGegU6CrZILeQNpa9zQK0AJG6e09MGqsvtvl1C1jxLhrSdNawhZC9ZrctLbGV5quVIMWsCY2Aj3zr1WfHcwcLI7gcGKCKNeg+UOX1NZmmxFTB3ORzIBnxW5S2XelyWq+1X8cFq8wBrxctjY3dOrkQMxRkZAKyW6jNfSgaM5aF6FMKyau3BDLbJ87ovGbIRzqsayVktPfJZyshAyKlaDRJYx4Hir18O/dYpUI6d1C6+2BcHUCZbLP4sg3oDQEvx1VM1QtYJQGotUix6rrmYZPRQtVpPBdQwYcocSv0YKkVhKJDVbERS0A3ZzPuQZeWVLL7DlLzHrGW3gsoEl1SzD40/LAhrlu5mPT6U/uDQnp84zhD824xIUND1h3w+J8DwDs4d8drUhtvWvD3EUlyt+wQ2qSNJ03RQUaFROFNIx4EFO1Np3COgQtXziKyD4gFNxsCAOvazndgWEHqCMnuDgLggjJPu69ClG6hbSXA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JeFJpmWoCDGmYjxtlZpMJJW58FNdqpuQnWWEj52Ce1+u5GPTZ2TmIepDmKhUuKj90NBZXJkxqASGekqipkYGz8nYJCQ4o/rfF7m+yY9LTnFogoCs/qJNhI95m5+z1kUe2fpghaG45fq8FWy97PugLE5mdeQjGO4z2WiqMYHiFonqBUi58AWo3KDCbeCuI6xWEVaAd4S5gx2/7wMJge9McbhZXQxkb3agsF/X1AgZv4d4l2PhLKM4I5+HXUs2z9k4GUeiOl2ML1NGj3tF8a7CrzrE6L+Lai55B16yPKTfS+NZ5Vq8UEDRUKczbz9x8Z7g9e5ZjPlkMG1BJpNiHfayVcqvhM8taGVa2lM3fdRgXwSdwnNm1KeQWn3fth912zyRcVbu4NXjsGAxNRRNeXJPSvh80Hp/Pax8lwfC5mSP5m96vCcr1toMPN2YP+fBhAxM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:41:40.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0560516e-4148-4866-92bb-08defd3f3278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108

Add the optional 'resets' property to manage the PCIe IP reset, and the
'reset-gpios' property on the Root Port child node for GPIO-based control
of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
backward compatibility with existing device trees.

Update the examples to show the reset controller and PERST# GPIO wiring.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v10:
- Add Reviewed-by tag.

Changes in v9:
- None

Changes in v8:
- Add resets property.
- Move reset-gpios property to child node and update the example.

v1: https://lore.kernel.org/all/20250224063046.1438006-2-sai.krishna.musham@amd.com/
v2: https://lore.kernel.org/all/20250226124358.88227-2-sai.krishna.musham@amd.com/
v3: https://lore.kernel.org/all/20250227042454.907182-2-sai.krishna.musham@amd.com/
v4: https://lore.kernel.org/all/20250318092648.2298280-2-sai.krishna.musham@amd.com/
v5: https://lore.kernel.org/all/20250321114211.2185782-2-sai.krishna.musham@amd.com/
v6: https://lore.kernel.org/all/20250326022811.3090688-2-sai.krishna.musham@amd.com/
v7: https://lore.kernel.org/all/20250414032304.862779-2-sai.krishna.musham@amd.com/
v8: https://lore.kernel.org/all/20260807123507.3418671-2-sai.krishna.musham@amd.com/
v9: https://lore.kernel.org/all/20260807140205.1070367-2-sai.krishna.musham@amd.com/
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 9823456addea..a28a88dc8e88 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -41,6 +41,10 @@ properties:
     description:
       Maps a Requester ID to an MSI controller and associated MSI sideband data.
 
+  resets:
+    description: Reset for the PCIe controller.
+    maxItems: 1
+
   ranges:
     maxItems: 2
 
@@ -61,6 +65,17 @@ properties:
 
       interrupt-controller: true
 
+patternProperties:
+  '^pcie@[0-2],0$':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
@@ -76,6 +91,9 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/reset/xlnx-versal-resets.h>
+
     versal {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -99,6 +117,16 @@ examples:
             reg = <0x0 0xfca10000 0x0 0x1000>,
                   <0x6 0x00000000 0x0 0x10000000>;
             reg-names = "cpm_slcr", "cfg";
+            resets = <&versal_reset VERSAL_RST_PCIE_CORE0>;
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
             pcie_intc_0: interrupt-controller {
                     #address-cells = <0>;
                     #interrupt-cells = <1>;
@@ -127,6 +155,16 @@ examples:
                   <0x06 0x00000000 0x00 0x1000000>,
                   <0x00 0xfce20000 0x00 0x1000000>;
             reg-names = "cpm_slcr", "cfg", "cpm_csr";
+            resets = <&versal_reset VERSAL_RST_PCIE_CORE0>;
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
 
             pcie_intc_1: interrupt-controller {
                 #address-cells = <0>;
-- 
2.44.4

