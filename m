Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E636B92A;
	Fri,  7 Aug 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111386; cv=fail; b=HmXIip4X6RoTDFAInRex3AumVo+Dyjxvw14fvM6LhjrVweWTW/5ncIXWZITcEOJQlI+LHCcr8XiUHOvMV0tH5FtSTqQNjKD37WOX2XKRaCrswrZkC/sGCMd6B0Mxnop3b56kSivdi2dU0RCUazw0g1rVh2QlMJ8JURN3piFMKQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111386; c=relaxed/simple;
	bh=u0Z2/xn2aapVzM20fYZZhEOPXGwE3RU7Lg2mGbv98u4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3ll5hNP/N/iT17z09bY5gEK1KaBfWSWZDLu39STQ5tf/XOi8efScMc4vImpTSHDbBHXPXoywuYoPMRW+aVVShTLpjvvt5GUg4YEVr/0sOhZAIlAs1sGsicEaDHp8Bs7zj7rpXslu8O2FmTPyADsqfu8Dc6eFxi5yIsZEzKmX5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HKNvIg0o; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HKNvIg0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSt0Z4XiRFVJYnUvTVDU9Bxv6O5yjEkW967bqWJK/fxVd2TCQImh5T6DmnMxzwkz6AWOwC95xjo1OKogNOmEDGtwAy9wd5aYIQcXBVIaxocHkssmHoqnmF063fZZwWtOJMsI9ir+WZTYBGtAx8TXyALtTGJi3H09CR3QdYwjPfMMNYjrwv8J8c/jRhT4bh1E+mI+/+phkk4j1/uWgDX9gzpMZFz4XRi0fosm+EgoIkmI+uLKji8W5DI798iGWvZexVSMTio3ZbCum394diX1SespZJlRD4B6EJtVgIt0t6z6raRWeMLyDELjPS/VVtBF5tJqx+jANBmTZWFjAWkfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXUy2EQEK5H8VaPwpCXqxogEH0BeUCEkgSx4SacTc3I=;
 b=Rdn2yl2RJ4qoO8tNY3k9p2l7utaOlU4omwgFP3tKcbpvKW2u5LLiGBLIUgmPG5lQt9lNsHUC5nkaDUxAiFOt/dtJgiNynyJW+eP3Sq1Em1b5+PA2BVdg/9dFIN31PE3ItIprm/eRYBWn4YsTWsCQp+u1xCQMCQq/YyYD1N9iI8JyIfIqmhG/WLwk/AiIiZ+mkdNtebf5jpSpzQwcJXo06xvAJUBAisKJuIHojdkyWWXfiUbgAgXYQNvZn4UUSWVxGpb8GE2pmmkrEbwHGD1iF8fpmOlYi00y4qS2yugV+ucqPUNiS6duV+NY4OTu+3kSCqAzjrmiOXxtrXSZPVEAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXUy2EQEK5H8VaPwpCXqxogEH0BeUCEkgSx4SacTc3I=;
 b=HKNvIg0orXGJrspLZHSLuECjyMfQuc42L/i15IpwOW5dER9v3+P8FfnEg4Si/qn9KkAO9HQNxGuQ8Pm9OP5Qvl098HxS6rzUHT1EZZCLbYASGWh+hgISb48573Tz0mkqkcp6rUtRqwEGD5/URoMfXv1ZYSgQTpVcFHAmbjl6afA=
Received: from SA0PR11CA0120.namprd11.prod.outlook.com (2603:10b6:806:d1::35)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:02:50 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::96) by SA0PR11CA0120.outlook.office365.com
 (2603:10b6:806:d1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 14:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 14:02:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 09:02:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 09:02:17 -0500
Received: from xhdlc250064.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 09:02:13 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v9 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
Date: Fri, 7 Aug 2026 19:32:04 +0530
Message-ID: <20260807140205.1070367-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
References: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: cc627fc5-3973-4cbb-d041-08def48c9135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	MPgELmpX87FeQln80FQOtKWC44W33MFwLLKnhPfIKScdFl/wh89IEGf6qrDmuIcTwvNWtf1Qckh5UoVUuKVJDVqiQevRXRZeSTTYcjsutJc6qICPhOC3fUzq3Xz0qSMJPKRrrmnoMdp7ozTZZifwYzcwHmbBP7g4bnGUXezN8fZKylPU/8t5hXlSFfeUzlrTxgZlHBNtI0wYqRD8tf+FUsKGoEsHSuU6cS3VdMdcQi46d7iMTz7EgSUj8lGm/iFfiTtRtVRcczMBMAL/FF5ycKzbMha76HiO8a4OxWg5QHpi9ymsEWfpZATy8ZtEoUYC6WGXSGuUIuibPAv2D3GQffQIWT2iLD5I8A4ksM6hWDyA2A/Dtvi6X/Hwf9pIeWSM0JqThXJtq+DcgBWvsx3CtoIhPGEoDK6jwtdwufCDB2J6GwIPdBcDc0iU1gMAs/8KAQZFCcAdlFGvYO5XN/phgVip1tzD1CazcAzZJ0RNemAq/P6OuhT9MKyBLHIxC8zmNScFcRqIsioMAz+efchTHirxGcHzgjjczR7LqegpaCE3FOLdOesb5H7BPsoy53Z1JE5t6BeH24Zcqa2adnn0l5Og+Jdf61DZLFqu1ZN2rISbmP1YEuxf1do7lTyYLcaG4cyxH6o8+wttA0Ner0A+Mrra5kz+dQ2wqd84Ruwhby4Kk3WVQ+EahpFTLwstfZ8sLh9EMFu7fqImDFYuBhrmjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iFDb3KyJ5MNr+yww0yZpyq/sOq8V6ixB+G4ZY9+U35GQDW38VLYyjq2PTzS0JoF2So70iIcr1t+3H+PQISfD8E1W5NzVo5uORC0V3aomITMnKi5FkQ4WUHzT5cBPLepe9J9b+0pP0CbhPfXlPsTy6jTSBh9VCeq3VOB+RN1Sobr8pp2WV8GQTE2YsG9nWsAVA7Om5QlkNulo+yrkSMOex1/3ULicocar7U/ghsTTxcf43nt1t66CsYyKXN6nmZVzSYNBRwj9SkUqktHVoIhLt7RlAcvlAscb9Q6lPELCWa6cpn8oyIYmHf5to2c+Ti/5E8xBH+nLMeZRvYnhR9nyZSCvEuUkLXP5OCWfrGDpOjxe8VeigNnWAbBx1O0OTRD2j7oWZLZy8ZtznHjlCljc/q/QACLdhjMRU1Ai3aWaI+c9uszhhRRH1m7QJ1/c+rFV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:02:50.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc627fc5-3973-4cbb-d041-08def48c9135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

Add the optional 'resets' property to manage the PCIe IP reset, and the
'reset-gpios' property on the Root Port child node for GPIO-based control
of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
backward compatibility with existing device trees.

Update the examples to show the reset controller and PERST# GPIO wiring.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
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

