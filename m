Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022096.outbound.protection.outlook.com [40.107.75.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71432A3FF;
	Fri, 13 Mar 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381800; cv=fail; b=dSnrNYPL941RKghLtsWbK4CvbwPrz6fPZc7K+0yEYwD7k4yZz02gh7MsRksZ06ZEk3cqAKVaZdRgJFJfsL2Ms6q5F66svaqi6Ht0AXGSg7A7g2Y88UJh/cMT3oZ2j4WEVU8ODpOI6teesVTmmcDGLtfskaxzWbeK6nusqScxKTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381800; c=relaxed/simple;
	bh=AJGeKVURK+KxdtH8iKybqsmBB1PLc8pDzKGvUa6X3Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKOw3uVr24MQxMoT3JezzFgPehvgHlAIBdQ2wyc2WmLfNsK2WgqQN+EToidqZNizcmwnEKR2r9lTqfCDPdf01IUGJGeLIU/bpvAQM/rP2CXP3Pl/5ucS7x9syuZXWI5UwCVT51OKq+TUHXYur7YL1T8U275Rv8emQ9nEFxOfT4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRnxHpug1E2gxkZVtiSTlV9+UExeuBz0lJ09VKF/5Ru7V8aAkt0RGHkaDBv1EaCWaUW3tdMUlJtr+taATxyAjBiLpMnqbWC4C4+0iHU9bVYUpbLB3Mnw14yC7is2X9+HtKl3L8O2pMdWiLRhtAnNs0tqZoZNNP1nl494asZh2SJg+7oiI71QWdKoJRlvh8c/aDlYfCoc7wjcu0LCNAV/hJnZZsL6linZ30sdNYJArLz4vQ6a8dRYXH5f+dLXCGUG0sdMpTxd0n8OfsUNWkWURzizc+X+MHgkLsF56SIzI2xvAuWTdk0j4HP3h24zi0uOvp8M7zzx70h6pLpy4fieLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjnM6mDqyGjIaQ7XC5r+U2o9/AO9Lp7H/2OOEflfrxY=;
 b=SbWH+iPInh/8qfp0gSSXaE1XIqcArD83GA4pM6myqiEPqSzEq/015j4Bd2saG4/B/kOoxungkZGhx6GeTPWmqmJkrrb7fcmRlImcq/e8jKnxjkTSmLukGBD/wxXJLsdf309Q06oFUiJ6lQDorkbvuwCuropBj9KCJVHnf+1W6l0vAF8cmSu6xWFov9ei9+BWvNYYMkUMwMf05FQbTjrX9M4lPAnBIGNihb3RQwwfznT2nuMkMbUUc56u4Y5YadZ3hpLDEYgxzkj99L/d478zVa9Gs1Cbrrf59fD9NUIma4r+QIX+ZIKxTxzb2NagXZpPe3A0+KwCxeLsgIzP7TnOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c5::15)
 by JH0PR06MB6833.apcprd06.prod.outlook.com (2603:1096:990:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 06:03:12 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:400:3c5:cafe::d9) by TYCP286CA0219.outlook.office365.com
 (2603:1096:400:3c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 06:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 06:03:10 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B0D594126F8D;
	Fri, 13 Mar 2026 14:03:08 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@cixtech.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v3 2/2] arm64: dts: cix: Add scmi powerdomain nodes for sky1
Date: Fri, 13 Mar 2026 14:03:08 +0800
Message-ID: <20260313060308.1300518-3-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260313060308.1300518-1-gary.yang@cixtech.com>
References: <20260313060308.1300518-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|JH0PR06MB6833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 41143f72-f1ec-4b47-e760-08de80c63502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Elk+QqOuiIaFCjvX4JEpyRmky+9hlLd3im0yPKOmuGeLnmsO1R3q/fc16ueGoK6aWvihYdhJH71HAkqbFAn4uXBgokFXp5TZ4nk/0+n93D5gKSIGy8VvKw5i01z20vGoQzg8/qMEPO7poJds22uACHjnUrBXJ1jbIjXzr/neUIqMZUwKX58cGBC/sqGmTl0AFnTgcqExZEz/uYZqLRXlH8/K/A+8M1ePmkUc2a2HtH/W/Tc2gfvEk7ExjELciI+s/99oZ+9gdtgzxwb6b8tLWmeTQWiaGF4MfeuSNGyyd4145woGg+28jVoRfJ0Ji9P8J+XUvuIeUjg/PNAiY3Tkxd7ALdxTJkVou/n6MGfmRqu/lyx/8qQm3ODwni+rYiwc2yqNixysqtljnaIkw3UiE/42vRJNaC5ZpZts95uWp7aA8x83mOYWnrZs/+eFWUVhqaXJkSJFGBoz+sbjV6hTY5rFDEnzXta5/CTiWMicqOzfzQi1tp9s5uw80s0m9zrsahnG12qvUy+iUWgCN8spscuwQdUifJBYaB1vB2r4cs2P7Fux/16uNtM0+wny+gXJp5nbXsk7aLGftgKHi0N64MS2wt+Nq3nUE0UO7FqSVWtouWmW8S50GsWqcfEvd/Qbv8fGPBYP23vQHR7V+iiYyvZ1AZlXT2/dt3hgbWNwQ9z2ZYAGE3EFjCFVjVg9uEBGJd0JHIueFs0WuIW1iqs7A5Raic37Mt8g6ak8L0nfcmqTyooe6dqFfq7Z9ejwD3qrRiTaoeO6uuoGPjynuR9BQw==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tnwE60wqsTRQGAf0rz5v9L10fjKz0jE4kS6NOLViv/GpUVZB2icVzwdgpYVBypgNELwztQIG8FzfffgdW2Oo+BtdgvZu/uodSrAvMpuONA1lfzsDgTjnqvPxS1/fi4FL3pEWujlz6fahK25/Us02V9LI2DiFDhTAfxvbI27cPxVB1pCQ4/Tm55LGJWSGwsPBGWmaMOFNrkOzKQxUkFL1lVHBOnuR2MaGNuyv69+vfRHueJdjyVNb57/LWgGyt+1pfaVl49UCGDNUvcXhqO8itw7+JfnnpUhI7mpxUTMbwaY0z3O3h0++p9WoSZ6P14/S/oraUpeR3BpDb1Dc4T4d0jwbVtUc+AygO6hwI5IjY+JiBkSM9a4vr2sGJB29FlfkAOChnFU/DhIu0+PevGnX3mc0s+SjaT1k5hNQxNczgs0J95cTfyf5LOtTAiBpyXkl
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:03:10.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41143f72-f1ec-4b47-e760-08de80c63502
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6833

Add a second SCMI channel using SMC transport to communicate with TF-A
for power domain management on the Sky1 SoC.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1-power.h | 34 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/cix/sky1.dtsi    | 21 +++++++++++++++++
 2 files changed, 55 insertions(+)
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
index 64b76905cbff..495ea91a63f5 100644
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
@@ -428,6 +442,7 @@ pcie_x8_rc: pcie@a010000 {
 			#size-cells = <2>;
 			bus-range = <0xc0 0xff>;
 			device_type = "pci";
+			power-domains = <&smc_devpd SKY1_PD_PCIE_CTRL0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
@@ -572,6 +587,12 @@ iomuxc_s5: pinctrl@16007000 {
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

