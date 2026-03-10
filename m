Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25017310785;
	Tue, 10 Mar 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107656; cv=fail; b=GVBdIK6dIZ1YYZ+g7jKPHL56IScPzgBxn5wOjPF5rI3sMp+EutvDNCcK5/qInpRwqSG8KX06XlMH6wPqbjJgB40UHHTtWTMH5dM5OztofFz+DKRUm+q8rwbZdpDzonw9f5geT5aJv6GUGu+vyJKjZKfQLMFT13bLpymrT7EP5xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107656; c=relaxed/simple;
	bh=JFM0W56xpsazqyVZ7LaCHxqR38MWxGJijkOLJtpkbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RefXCni1ZzaSkeOS139M3AzH7B1G60+AgbuppFxZyGWxijpND0aKv9NCd7WC9UqIJnyvfk8VMJNmJcWZmjXS8CZp5Gwb4SiZ2ggiWkZEP5BEisIgGgjGpRkpEN/TKVuj7V+GrKAAQeeHu5W1wjjxVha1d0bDIDcq40M0pzeCJHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G53gn4KG; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G53gn4KG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFMfh00N9Wi7Nsbvlo1yROGvCcK5BBs7PWxes0wxfOa35kmorWHghqHy/MlZEiAe53KT2LmxKKAJM0OLlyTo43+gYTDeQ/2tX76w9c/teIGOFNL1bHtwsG9lVK8wZD2MRF8pX/Qu7Sz7Wl1JOcF8k42U03ashKyPpWgaM8AGxWb8kC7OnNBnFYEYQ+hC7zM1CuOpuoMXiCXGXUjL/+eyO+k/yef7LOHV+t3AZnKaHi+kxHopmoLFnuGaljCzJNnirg8ElRehXXIfp9cY6nx5NfZAO8I3J8yB2fDxPyY2dMNzjGcqaRihXj7jkLlt1SWjWwnt2KJ3BXt3SwUoIQrxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=tNA7i8YTktJvl6OXZrDwmow3LOojoUWrD9UGc8/MKqls7qGvxQFrJNCfaORJk3p0XXKHTWappRrLuFWm0mw+BpN00a8g8k+sM42q0SJpbiTdwoN2wM5Er43IgCL5MoSXEJ0afO2pXtEjHU3fXO6ItRFxHAwJiqKMC6N+1HZbcvakDFf4Bbux9WCmMiLgxkQQq3RmQ9+no5360hJdudNgPfUb/MpRyI0FrWzb0xWyOyoFgfuUjPs94nTgPsSvrklzGbsTNbXPHB29KvgoUsrb+udEa36DqC2neuHaKYDThj/FFc1fdAq04OcfzDz3SmxGi4InVNN91UR7GEFIztdSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=G53gn4KGNsM4cqsKM0EVbS+n7YAQute76f30GXggQbHeie0uRx947jZs56KIOT4hJCfSntUaqLOCa0OjzXG+uoIhMK5DMo+cPN8lnzaYZQo3UMPhH3KaUBVRRA14vaUWA+h4tKT6OWsSg6TPLaWowYH6cCcdAPj9qKU8nBL+eJIY1t5YPoQf4HdbRbBkCDOjl2lCTldkrs4CQrP6XjalH+uVnOCeKW/mrn8Y1YLcJPEk70rjzjFj8toBIBllpCN72gXMYUctSNVfRYnbPMD5ajcM6c/ZaPItUyeTkdQ3fjqp1yMdgwQ8aAOEPxnGCUfNjrk3i4fd6HPN+4VJKBkYxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:54:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:54:02 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 09/13] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:22 +0800
Message-Id: <20260310015426.365675-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 4171cbb4-b744-40a7-e086-08de7e47e72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	wgohHnq+y0T5/cMOeC6HqINOSO1TLKc+PPY3oZ8uRSPfl9LMq4T9OkPUCyXMijWv/vOpoFBOEl93o3lnRHCVrNd0eqbeZd/mtwo5J0+G1nxAsyvbKgnxLptkio0FVPNk2J81Ml6BYklBEHdrn8Rzar3JBPakfkVhYcZZmrIRUNzRqjYx71NSuT9lNLurPS2JlnfqV6BHbrOXeNbv6CbNLJY1N2d4n7kgnUatOtU8fN3lSPM7/4i2yB/MCIamgtQEDtJoOTktHEIQUbZR4+GwMNWMU22HALH3jJGM5ZyIz5mvz6JFkYx8tQO7veYJLnBpN8ycEzjsdnGdYzU6KFGqtabHqJ390r4d45+QGF8SfPNcz0jIQUDeyhpkcOKKLMdQwbzEqCRpntg7AGiSK+2HLep8JxMRZoalv72rbRTKPBL8BaZbpq6hCWqZJCqJa6H38qOht1otS+ywJ1iFJ3+20z9oVMBkF139gcFfcl7Gbl1vlSQatJBj/vJA+CP4JBwCSP19Re0l27d5ScOWfSwBEqKs/qQyToBA/+AfEEgiLTKSk5t0Tlze9pIHOH74S64zP74jyozsOUxHtmIlCyjR3VihaQVEIfOaEs9kTMNWSvpW88jK/yc5onlp7NLfjUX88x97Jvo2cR5ml1ZzW7FZP7tGrG6Ph6MU1qRCqYFyMsjR5R+fvySyFLDq9jqKI6XfHUtVkHVJPTwjcly9gvRY+vrPW6YQzOmxQOgMjdcqW4gyZ/iQUtpW0SOyogS6Rh8eHgeIfg6Aos8GvBRTAMv/LTUS5TznAfJLttWwFaMbQVyZM8n4E2rsVi0VUJPTIN93
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3kYRCubHgv14DRKud+7HYLSHnUIZuh3oFWfT1E50yFmTpy5hAEBO9Q6ehbG?=
 =?us-ascii?Q?qFiOqC9CY1M8B3NWyG/mF9M1QuhuoRvWKBxy9rRrfXCJjpoGMTnctxWrl6KN?=
 =?us-ascii?Q?CdC3E8Sfu4yxnXcSSsKDuvqjjqOlw1F1kEW8ioQgURDTMb99fHt7dUffgCFS?=
 =?us-ascii?Q?F4QBLDChXu/RT1lUzF70R9z8lW1D0O+jDw8TC0Smzp8rNPnWW4y8t589is4U?=
 =?us-ascii?Q?op7p4aOlipFyf5lRoum+6Hw08lijoWCl8BiNJ4PZkc5Apcmpt51VNS98u5nk?=
 =?us-ascii?Q?61RpKn8x7tz8XFr06+mp0e7eICae5RoCbnSg7SqOQ04fFAzjWgaN1MVbnfGx?=
 =?us-ascii?Q?y9jEXyJzhPfFj+8/d5XvBFfCTef6XWsaT8xcnfx50o7PwrevsoOl4l/mcF64?=
 =?us-ascii?Q?n+vakc0LfSfmc1KJ2gFyUY90OUnbYu8Z4QvBIeIbm9nR6wHh68F6YzmCZU0u?=
 =?us-ascii?Q?pPUmyaYsPCDAlLCPRZq4eMkLA4ZBBcAfD2TWS+4VPei6ii49hhq3YoIoLhTa?=
 =?us-ascii?Q?aqVt+j7cdzSJgXkRgmKPW1CnN+GQVeQUZHnSeGGHmtOv3563YKsrsHf+0TAu?=
 =?us-ascii?Q?YEbyMxBX+qpfmbISoi65jqf7kdHJKoA4LRdJdWKRrVwZsJqSjHmepkVT10Ve?=
 =?us-ascii?Q?Lmh68mfk9AJ+a/j+pGlU6yfDDaahn+a+2sWn9QbewzUMBOIl/dlTsQ2AKR40?=
 =?us-ascii?Q?qk4VrVHpibeCJSQ51fGpe+jR0L5FCGzkLERuZomnCaBc1x4jUdbuzfoSLb6W?=
 =?us-ascii?Q?ZKA/D6MSGPqHwU/s9QrNmaLQ+S8znHSPYaNsEt4gZTwooFCATNrbj9WfzOdJ?=
 =?us-ascii?Q?wQEtWZPYUDPjSw0qd6SqJJs+bRNamlBD9dgd3hsA1BMgFhn2XOOpgIPvHhJF?=
 =?us-ascii?Q?pUcR138qGQ/+/QpvmXsLrhN2i+PoGhoZ8slFNBeCsSDQmL3Z+r1Rk2b9ahX6?=
 =?us-ascii?Q?qE/y1qZKfyjaIFKi266H2N5SpLQWNoaNIbn2UPQRru9XFL3p82ool2brP8q/?=
 =?us-ascii?Q?CTkECB0YvyPjB/f4yuE7FpEUITN+YWkcnnfffo96jsTQ684Sm/JKUR1nxQbi?=
 =?us-ascii?Q?h3I04hthFCKEG/YWqQaTGdsjtJoq1tCSjkzZF65706gGMlKlUMBgYeT6+gg6?=
 =?us-ascii?Q?xFfjMlggib8b7fKyRv5We5xhSYs18NIiXkmXqdLluYPHeDVIf+tgtmUg4XyH?=
 =?us-ascii?Q?RKIZHT36DuBrpSA1cPdicNtNXfOVfqNQqRazw5lqFWsOkRVj0eRx9Px82425?=
 =?us-ascii?Q?Bj45FaA88z0H2bsOv5VeOgmGMyILNkDeh9jIcez0fwSqI6lZOz5vM45Ubdpf?=
 =?us-ascii?Q?fwb66U0rpJfw3F38b9pAo/FX42p/WEIltYgYsibglIfEdItNe/klz6rDaIqi?=
 =?us-ascii?Q?MUsN2XqY12JI3anxvxHLtBY6dXezD9FiFwk3ltolXj/kXQvSulA2IpOgrtL8?=
 =?us-ascii?Q?8asenaJ+1C55y6zW6TcglgOpz7DshWlwQOZK/uD9xvN3Urg41PucZmk0yHnj?=
 =?us-ascii?Q?81pXA2eAlnyDf2V7H/BfYOZVlSC4qcFVYRGxGjykP/qGHGo2KcFbIIIMHGmu?=
 =?us-ascii?Q?MmQ7nEelrJK3/G6OmCkskTD4LBevxLs9w+Va8lDWzxmsuw0n+nkwTRCmIPDR?=
 =?us-ascii?Q?2DVE9BBlGShRlL4l1JPogTkd1UebzUr9Zgqoul6Vdo34W2vBwPXtb/omFWxZ?=
 =?us-ascii?Q?KZJLrxHFf8OHjQTpiqt7WCnZ2j06sFiSdN9rIZx1CyCybO6zh3bfLvuz5JFO?=
 =?us-ascii?Q?Q+HHuPSMcw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4171cbb4-b744-40a7-e086-08de7e47e72d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:54:02.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nGnaiy7xvKTXBMIfEHx5zJr5MuwtkTLh+VLbuImAOAOOcxicG9wmTfHqidNQSgxhSDBjUQXUieVsuPTVuwHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f2e1854f38a0..fa96432697ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1369,6 +1369,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1

