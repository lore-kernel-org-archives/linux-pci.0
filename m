Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023091.outbound.protection.outlook.com [52.101.127.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4034889F;
	Tue, 10 Mar 2026 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125628; cv=fail; b=vDaUr39xED9wW6uVu+ufR2b+0kGrQrwzXK1d1/Swm92ltBEGR1n/YLUZIxSQfA6T6xsoWgzIroPRDsR5pZVeav3rhlqoEW+mro4glJULhX+L0kPlXKNx8ZXqQ/7VHL10WM7/01GTclN6iMc4hj3OTSzDUcsJZlgjhY8xFh+v2kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125628; c=relaxed/simple;
	bh=xVRxH1t5zh/ur5d/NfXjAeApe31eLEAONY6oQmw9NI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnxNP7H8mit9HAZZUJYQdol+kuhfaxyQjusrWXiJL2Lp5zjuEsXwG8eaYJ0PYIKwBD1aXzMLu3NgxkIk2qSZD+m6w/2INxnCbp+RZiI+Eqn8E8cs9Oowy0zQBCZVsdoW1IGg9C8EB5gGbPahBv+Ffx9riLgN3iAlHpN7aY+OhI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7oq7NjnKdJrRWcE7CKlk3lJtIz8OjsJEARltVPswtnyhMcHwGPTnPZBCxwI6IT8b2mLZzIMLnpFkRMHr/Nxzjtlv80ir0T5u/FnLCQ3q4IYAW4NyBnByeewsVpRFaYjDXgNxxnfIuhiiciRt+xfOoC4XNue6Mb07lBA+AipofnpjYYzmNX7XSkfDGm0i9U05wYwVs4q/vJ5CxPjqT3kBG+IvFRLzmtAxcKJ9jBEanWEAqVc85/2Ucq+31jlcYy/z2soa32aY8STZN1zv4XHCmT0HpavqSNu0JG2stUb2N21cKxB5IKC+VkYTGB4c2U1d1T8VgYJG8ldtHHOE0/0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHqpExwiN2zW6Tp6ZkcZSUEg9mJ/ytbtNEiyPLvknxo=;
 b=mrh1YdSNu4SWkgRcW4b32GELtN+5XJu836/6MbqmtOxmEUSgvJLo6KMh6SQDIhe1FvzVTgBlLwuxVz6cmpsfk6Ce5EOIym29TT4OlqPMLFlgmIYRXIrhPerHZtq6bB9POX/l2R/fBM3IS3S6EfnF+8I88sndUHoa5SUVzugrjSrIAnaw0a4Pu0LxPhD01GEFCCoehZP2Zu+oAoC6YyrE0rY2muSePTx5MuXeFH3augjcyyZMb9Dr64PGjazjw6lnXBrb0WvmghugNYW7lLOA2W5ttPL3wEsWTbZ67CluozMuCsI8j1RpoYLjzuUzGYZac36uc+7QW71HLrBISq4ZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0034.apcprd02.prod.outlook.com (2603:1096:4:195::9) by
 SE1PPF54561D20A.apcprd06.prod.outlook.com (2603:1096:108:1::416) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Tue, 10 Mar
 2026 06:53:40 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::90) by SI2PR02CA0034.outlook.office365.com
 (2603:1096:4:195::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:53:39 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A27D141604ED;
	Tue, 10 Mar 2026 14:53:38 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@cixtech.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v2 2/2] arm64: dts: cix: Add scmi powerdomain nodes for sky1
Date: Tue, 10 Mar 2026 14:53:38 +0800
Message-ID: <20260310065338.2337761-3-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260310065338.2337761-1-gary.yang@cixtech.com>
References: <20260310065338.2337761-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|SE1PPF54561D20A:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a034db0d-3597-4064-0afa-08de7e71c2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	2Wk9YEY9BeUSATBjiS9ZKOF0bIR9jA76dXYGeWM4BGlwfSj+oIRhk3wEFzVoGLK0mHg5BSH4wrypoy3+HwEGT4LkazTAtG0lnQxuCNNeQuT3qcdlpghw+OZ3TZOlI94/e4w+OpEKdCdhFlAcBHaLBNSeN6jbU/AvFihjESiPxAGS//26/e6AMsQdsGHeQhl+AnTFX/caQLB9zgWDz7TKWQlC2mzofC38cz/QBKbseI6rP6Hm+jB4y3qptNSp5jDQ6v73EaCl8TSMHRxAJZliNWtRt3XlHIOlh6JwhYUFhcRCsyYRTU98o0xRA4s2SBE1ZJKLFI/3+cAk7cpyDLzWfqmhnk+h6Z0KM5xpOscDIHwdH+vlK5S5pUhb0z/5zPph7PbScuvuXSDJXXASsaD91s9Rw6rePpZIVzjOV+iAyjwwQuxccAD/6MUp/+zx/pibHEaWTSXloAUPx4FydOk/t/r2qghQ44let7H1RY2ONdiFs1pHFMFNaxIR4wP8Uw0QElL7tjxDoEiWjEXkDlS2KqO1LlTyyWGjnewTF5Vbx7uv6/V8/xIuBwEZX8eQRL21dKJfPgw2DhVWUfrid/q9rC4zGlJN/TkPJFRxyLGqqw0sFoJxwGzXTclhqJqt/CCo8O+8KjQE8FYWyfyJvYSUcTCH51foxMPkLG2kL1ZQeBwrlWARG+PrR5RnNqFCe3LNZG+7F+tnbLYXUPlmQF92rvrSZSuC/n0vcbIQLOQ9JO+5L1BIsA8p1rQFdgzp+F6nPDbvxDtT2r8zf2TSzE1wIQ==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ba4d/OwilhdSAmlMi1XQ3fQ1vJv//vlpCoFyJAygnO1DXat7y7bwB5aYuIvT+FYZr8DAwlSlFdQw9qu+7v4yb+mL4aAUcqccovI8hYzxgx1eOas2E4yJgeIaU0ws/8QtiPQrj88MDk9QfbMA3NIrbpyLzFMIsXExy9BRVj/rRnMyt9kgmPXRG7yCJ6yAtseiQH8euZBta2ZBGn5cr3Z2VTgIpBVFme/JjNFyznllRJrdPl0MeD5QolKYxtwwcFl63KRuYawiJ8SUK4jq/XsmPJSdZNa9jwPfgbxdFd5TOtrmmTICOlhabH/bRJPv2i2WnK81t382YMSB9A3YFqBllfmKmCqpmvbxgKyGisvXtzoLl8sz63geU1ji5o614Ad2SAqlfHokYkDQStYa2MzgJrsKnceyNWoNblrkqILqq4V314z+po31pznU/oBqkXIM
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:53:39.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a034db0d-3597-4064-0afa-08de7e71c2e6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF54561D20A

Add a second SCMI channel using SMC transport to communicate with TF-A
for power domain management on the Sky1 SoC.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1-power.h | 34 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/cix/sky1.dtsi    | 22 ++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/sky1-power.h

diff --git a/arch/arm64/boot/dts/cix/sky1-power.h b/arch/arm64/boot/dts/cix/sky1-power.h
new file mode 100644
index 000000000000..743c0e5558ee
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-power.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef __SKY1_POWER_H__
+#define __SKY1_POWER_H__
+
+/* The Rich OS need flow the macro */
+#define SKY1_PD_AUDIO		0
+#define SKY1_PD_PCIE_CTRL0	1
+#define SKY1_PD_PCIE_DUMMY	2
+#define SKY1_PD_PCIEHUB		3
+#define SKY1_PD_MMHUB		4
+#define SKY1_PD_MMHUB_SMMU	5
+#define SKY1_PD_DPU0		6
+#define SKY1_PD_DPU1		7
+#define SKY1_PD_DPU2		8
+#define SKY1_PD_DPU3		9
+#define SKY1_PD_DPU4		10
+#define SKY1_PD_VPU_TOP		11
+#define SKY1_PD_VPU_CORE0	12
+#define SKY1_PD_VPU_CORE1	13
+#define SKY1_PD_VPU_CORE2	14
+#define SKY1_PD_VPU_CORE3	15
+#define SKY1_PD_NPU_CORE0	16
+#define SKY1_PD_NPU_CORE1	17
+#define SKY1_PD_NPU_CORE2	18
+#define SKY1_PD_NPU_TOP		19
+#define SKY1_PD_ISP0		20
+#define SKY1_PD_GPU		21
+#define SKY1_PD_MAX		22
+
+#endif
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 64b76905cbff..1c8419ba886e 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/cix,sky1.h>
+#include "sky1-power.h"
 
 / {
 	interrupt-parent = <&gic>;
@@ -168,6 +169,19 @@ scmi_clk: protocol@14 {
 				#clock-cells = <1>;
 			};
 		};
+
+		ap_to_tfa_scmi: scmi-1 {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0xc2000001>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&ap_tfa_scmi_mem>;
+
+			smc_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	pmu-a520 {
@@ -428,6 +442,8 @@ pcie_x8_rc: pcie@a010000 {
 			#size-cells = <2>;
 			bus-range = <0xc0 0xff>;
 			device_type = "pci";
+			power-domains = <&smc_devpd SKY1_PD_PCIE_CTRL0>;
+			power-domain-names = "pcie_pd";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
@@ -572,6 +588,12 @@ iomuxc_s5: pinctrl@16007000 {
 			compatible = "cix,sky1-pinctrl-s5";
 			reg = <0x0 0x16007000 0x0 0x1000>;
 		};
+
+		ap_tfa_scmi_mem: shmem@84380000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x84380000 0x0 0x80>;
+			reg-io-width = <4>;
+		};
 	};
 
 	timer {
-- 
2.49.0

