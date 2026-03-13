Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023074.outbound.protection.outlook.com [52.101.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5238366575;
	Fri, 13 Mar 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402562; cv=fail; b=APwd86EWb0KFDHDChv14UcuxoudalSSysSTr8FCSx9R7k1zycKMQgrNmQ3WbmzrVZ9GxnS0L7JEbrK+qoMuJYBe7j5nAnl597C3kSkySeRWDTtMTP1LKqvyi0Z0xk6/aL+gttYcOhVtsfKiAJ5ZGHTxh9/xmreeUbLs1DhJDEdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402562; c=relaxed/simple;
	bh=g5QEFfCYeJIyOTbcNDGO6GDG1Y8Vewzj3CMciW3X8lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZEMBRr1FGJjOaL4CMU4noTGh8As0VdXBgVJPPHHeuRoAP/yQjuduWLf8V/hrMi6Wkq3oIOjvbfkvUbl/wAxgMouaMKxeYJq3ihDFPuiWKpGk3TaF+PPbk4S8oj1iwTzEECWLfNGUxvfbNnVMY6W9LSqILQzinIQeB6EwFNMW3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9mrkQ9o6p4951vHHRuEQ0zDMC5GybxkCSTP4CWN4T4oKlILSZbY1WMFNdoF5YlnPoo4odUUS5IMmYT620iUSBBhuyAzeswOXgaveHaYkFBy0aCUqn9SAfVr78jL6vB+SHMXMGahhCA1lawuGc4PYSVJD0VLW45ElNwrzAJ8KsFclwaYpMG7Jnn+alDuLJQKYln3cAOXHL5/fuHDZgaBJuZpyUX0jVSzSv3Umhg9O4vdRc8o76C5S1WBuausVBlkdQDen3D0co9aFIdJ6AyyZtAau0SzFaJsaCwEVho2a4MmNwxHGhySZhsQb66RJvuCb43WaLkGx16zVXAii2dX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LMRVIDJvFleD8CgS35G+B9Sbt0o19PlcIhsFypxh2Q=;
 b=pVeddSxccMkZRIgqPv3bQ2MaUNi7io+w5v9MepjjNllhPtbhyQew5FOlKu5uTfPsZIuNf7/hYW2Nt+KsHOpE51MBr3yARfRwvA1Bj7GR0DRNHkkQBVG3kI37hjbSgBtvfeHcde436gE5CQVIX1XUgqaitPw3IHZYMw2eqY/PR6nruKBmnQ/SGmUd9NyUMyXNrb0Z2CVZSw1J7JsqQljqi+/MuNe5oSb9w3ECu+zj+Cuf5R6AN3plxdVVaqmquCDrtwg5qxv+kjco2sgrC0xNwO7+snMo0ETuDaeoxtejxDGHMrgxcR0dUeMTVdtxWA/iST6+PPH+PjX0PjlEbaYQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0076.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b3::13)
 by JH0PR06MB6776.apcprd06.prod.outlook.com (2603:1096:990:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 11:49:17 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:2b3:cafe::cc) by TYCP286CA0076.outlook.office365.com
 (2603:1096:400:2b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.30 via Frontend Transport; Fri,
 13 Mar 2026 11:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 11:49:16 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1906D40A5BDA;
	Fri, 13 Mar 2026 19:49:15 +0800 (CST)
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
Subject: [PATCH v4 2/2] arm64: dts: cix: Add scmi powerdomain nodes for sky1
Date: Fri, 13 Mar 2026 19:49:14 +0800
Message-ID: <20260313114914.1564115-3-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260313114914.1564115-1-gary.yang@cixtech.com>
References: <20260313114914.1564115-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|JH0PR06MB6776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0743d0e6-e564-442e-7e16-08de80f68dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7NzhdXmf/gZ9eyWz2TfhM7Zt/2FrfYbow5JaAiqVFp1m1x1irev64PuvnSl5UPXC4sBnH5u2e5vQ1dZiyBGmzliYTKx6Wurph/woHChdaSGvXrfXfbHEmeJfo2oZqoIcqtd9+pRf4ObJUnX88AVbLyr4QxAoBFymFqSFSHBXaRktDO/66jOZKmg9EPElxunEfduZzMHilupIwuEz3ZXne3ovacyi5q/Ahf2HBBtAxhdFqszGGw7704X8FL8zP3Rox6TeW0+J3LSOhKVESq2rnDxa1lkwoH35pjbg6GoIU+vufVbWnxTk3POtAWZiDXSG8LJlMRscT84Z18TQBdyRwQIR/Z106Q4IUGlvM1ld8vfuttX4tuJVpdhnwnxNg5qSQ+HFnKYATv1WIra5Qo1aVuzLBDvYpokxfzejjnDOj/qbhPv8jdM/qJEHOZgOEXmumN5XiM7Zj6e1JhB33ygyghDSvPa7Js5G3a7hj9hu50eohwMm2ls0SoyJXxLuWkvFdvMxS1Bawx54c7S570WwMOEBGi4fRKpUcjqyUDZmxlcIEu9M4inWK1EDIGjd45of0NJwOA++sixj3YNaL8/88IaJ2VCNo5UFDNSzUAuwfPSWwNcVk9L75p9S4Q+BmIbRSRntYGWZ0qEvmaqUiNeaUt85sqUGdTZI17X0PF9jVz/CY/rMZkNsFVD9EZHmq7cUhq8Ed+5rVU0Cuic1utgzJqbbNicOoRmXzayWIKXojS5YA7FGuW+Bof2J8DSaO99O5VyWCOvTrdpTf2uKI+WcXQ==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XXO3tX1BAHw4hOLNTJP4XvuRlM9hef1P72Cq0XzGiRVFyqMX9WnkCmFxaZPSdcALZ4CNIad2FAkgKSuR3JOMY214Qxh1jq4DXR8lBfkPPrveNoVaZ+L/YLDJN/3iFSp193YMQF7FfT/F468BuQtumThTWxnKocG+raQJf2M8Rl7OP923de1Yr5q0mIWDvs2IEQVfPPsncXzghAi5oprFh2Z9L+gUUlf3Cmywg3+oBEpEoNfTbruW2FG6Czkci5IhuvvESZHi1sbCSQQ9Qwfruk1q4+vvtWwdJqZVD6LjgMqX2Wpg2TUNDO6GyhnSBBRNvKN9v1euIztsWRou4PiCc8MWQitdB+Mtqut3a067YB41/AmvBnpGzwg1J0FXqqTR6zyWPqQz300zBbVsnX8V8PfjUhVjHufh6dw8pHFEfwgTC4SW9ec5QSl0lH6oQS20
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:49:16.3530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0743d0e6-e564-442e-7e16-08de80f68dfc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6776

Add a second SCMI channel using SMC transport to communicate with TF-A
for power domain management on the Sky1 SoC.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1-power.h | 33 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/cix/sky1.dtsi    | 21 ++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/sky1-power.h

diff --git a/arch/arm64/boot/dts/cix/sky1-power.h b/arch/arm64/boot/dts/cix/sky1-power.h
new file mode 100644
index 000000000000..53f4a3af36b3
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-power.h
@@ -0,0 +1,33 @@
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

