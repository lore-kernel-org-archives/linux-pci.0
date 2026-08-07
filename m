Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FD47798E;
	Fri,  7 Aug 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106140; cv=fail; b=ctlKj89R6UbvkXm74j1QKe5hsVk8mJM+hsii/9CTI8HcqwHzl5y0A4Atx8+BT/D5iHkKWuNrJTsswf7kV0WizUltrxmJqlkdVAIA82zABj6jlHri7gi8Zhao8++mOk8idm9nO8ew5kCpiWGJ5nAFL0Yg3aOfVBOiWtpn9eT2Mhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106140; c=relaxed/simple;
	bh=Eh4ZgZDtX4/fgbGIammnAYySrhKAWP495/TBPNy16l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+mep6bB9qA53zu7sMGu+JQvUuSbMmPxyUPd/EizhhsJK4sZaY6vN1XnzsZh8p3Q5r5fgQFnnUwdGaZWQS0tqj11nQc52UvS/lLylVJ+T/Vdsc+gp/7x82fwLVcqhpeFvCFS40xrJw/bZJW2J5+FEvApcHAeyAPyeFa6UNbAiAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rb9X3/Ez; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rb9X3/Ez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNQj2zUwK+TuzY2sku8NE/C/uB8/dfajQa3qCRRmxSSqCiifHalc7/4/Aw7GuGXQ6Mc7WeQrZQYlSX3UDX2TXSor8mqnCB86KDqE43iMAnl0Qs6nP4I+YNj1tu5DzRTOMdb0765ovFgVOWPqG4GNUKR6ctAawTOu5pfHCzTUHmLdA8rbgGnmPWhD+EfSRrbi8RXb9pb72Wov9B42HtynqyxJbeq6IXJcMPpcNJ1QPaerqxqE6PTtd+8dSTjr7aoFJEsKQzJeYrNwanP/74vKR944ikcN1EDjpwecWwJFUbHEsOJCVJEnczGDkLKGT1CnA7cMNNzUjEYeMLURDp/RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2wr+RxdM+gTzGKDcdqAyKhz6gsiShysbW+RLeYZChg=;
 b=Xunb88ES0Cb8eHQJVjlfUibsK8HocyYZdVM8zx9t7O8lOS7fhWXNQc7Suh2VgzPocM33YiLLHrKCVJUdgP8L8I2EQQslYlqBa5GNtXlPmdkH0gc83NPQ5TfWTQAcHIWPQhrWnKRM5IGLQwa9fkRYmy3WXMdHiU6bKNsvLbB1cNcG2tdKoFwnS57kfGbO4kr5qA1WSWsDdraV8oS82mJQF85iV64rWdveZW9vGp+6Oiii9mls4rLwVgo0s+2BgYj74mN68L8h7TXntYN6DLGGm4x8xjpDqPs57CnFPjoufGSUB858qKq8zVNuVCDpmZXuyUR1dLdcxlF0FGmgfYGPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2wr+RxdM+gTzGKDcdqAyKhz6gsiShysbW+RLeYZChg=;
 b=Rb9X3/EzGFdrJw7x0bkUvGN+ukS4mFUMiKS7lMEXC6SE1OPhFEL2qnEo9QYzDYo5wwaT23JG11Gwf7DV3C0+rRuIpPqSPrmnr6PEKIwpnREenR58rrY1uPSMrDOyFckyQyVdGjYQVMG0bRP4Sfkg6kjgTthhVac9cBh6bdYyPg0=
Received: from SN7PR04CA0066.namprd04.prod.outlook.com (2603:10b6:806:121::11)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Fri, 7 Aug
 2026 12:35:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::2f) by SN7PR04CA0066.outlook.office365.com
 (2603:10b6:806:121::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 12:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:35:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 07:35:22 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 07:35:18 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v8 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
Date: Fri, 7 Aug 2026 18:05:06 +0530
Message-ID: <20260807123507.3418671-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
References: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e38f52-2cb0-4f4c-36e6-08def48059b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	5L3ACvnKaiNda20VUekfOPlNc6M66ELTxiSwtNL/gYLYVzDt4dzCc/JbqslGLeeY1unHhdqrOhCF2QfE6OuD4uWPBJ/CTvDlwmFWFUrkS7v5IZNNd/TVnyfVskIM1FfwmAushYRCpsoaaYoZ77aEFurIng9iQ1q8icQCogq+w17Hu9dguCw5ym+knpQSylawj77LPQG7BdPy6F1Sdb8oogymwLLW14vfRk9xQFLrJMEDUfDquOpvpHRShB4CFd0UzArxkX1d/qWtDRLZNxKyK3uKFClIB/6/EzZfuqNEUWJVcP/wJ6uwSzjy/++DQRuuCVHvIYWA8cg/aZgkVJTtB9ELfjg1es0uZ5kSCzav/f+uL3MTtgf8yq5ipc8UiNRmfTPHomuf5zGYJaFjjBstPpws1W4fwxkGlIgrX3T2CK0mLCD4Brcc96IlJ4pgNW2EE6jamvtjzCjw+udaPAoRpQa0ltvIRcVSNBabbbm2BMovK2bcd/W9CRm/2gMyb5nDoZpc3zLyRNpUeKIu4L+sou3IQ4ms5JnLz2x7+JTvsTggL7yyUcnEWJuIC0EHEbksBOd1RDvkKrLegk9tdeJE8qwiCgSQfZrtV2Bd8FnVmhVYbnKHhwq2aTw/AWYL/eOpkVD90wIFaw1PMVKzWCadVX3nGLgVd45lxu58LHqVCf0I0uuURmtrTP5LC8s7O94eV8Vcxdp9/eyvqBuT5ibYeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(13003099007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hIuBh/CNgbYVHaBSe6krSnnqZCYZSULDN9Zoj3rsDsLQxk+S3RS8ZXFyNS2X7wSDmV0iaEj9cv/k7KCiO9RAOaF+2NUHyk9QQ2HLDVo3hT5DGeMF0nMuLSWZYmPc5X6GjiNlxMUg+57jEXIPf6P8ileOAkT0XD2Bm241hnmsZkUyBY2zfOzQi4Oa1tIHHE2pUO6mv5eoRwtixOu5UUz2cSaPvcdDV1DHo2XDdtQuJj3E7+Xlhi9dDPw3kWLmSjZFkS2qpR9V5/YpsYvRujzjGzUghgU0VozwNMNhq8SuycATzkwQSDuScgjQsYhmivn84C1Yaz5IS9b54M/3Z+YAEi2w5PlWuV1k0O58qjk/OzYcGsSQexLZxMnYbOEUcnPqbTStZcZZeYc8NeOn5pCtZrm317QELq0LxHt40W1eeU7lAkD/3uEHeFmTNZW283V+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:35:23.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e38f52-2cb0-4f4c-36e6-08def48059b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

Add the optional 'resets' property to manage the PCIe IP reset, and the
'reset-gpios' property on the Root Port child node for GPIO-based control
of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
backward compatibility with existing device trees.

Update the examples to show the reset controller and PERST# GPIO wiring.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
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

