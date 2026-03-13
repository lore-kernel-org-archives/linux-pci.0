Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555B36C0DC;
	Fri, 13 Mar 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390828; cv=fail; b=ZOptQdZGrxgGYS3Diwn+G1Pa35+HcN8l5i8i7WPlfElR5A2fStBWnQg2Vpcx0m+F+I4YFdzJiitr0tNSGgEvFxzrmyluk4ai+ugDCx8E9Ebby8+NJNSXikXavTB4SE2n8FEeUuYY5ynjz0EqNTh9+1uxMnkEvuZfNVpNRiBSoTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390828; c=relaxed/simple;
	bh=uOFf8lFjzgHydBAlJMmPZMLPbZu0F+kjeeTlAgsORfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfGiolXySxd4UGw+qBShzxX/jaCnuhfGDIT8IvSHpOE+WhcqzdiQT5LqRat43uVLgxrMOlmc1ixKIVjPeKZyoUhvl08JLMrnjWzOlycQPj6AB2HHao4xBr1WAAMDyg+TMJY+wKlJ4BlfH3Dll1P8VLVFUfA6HJ4pXGYETt+6PB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CLhajgFs; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLhajgFs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chnNwRLJ2ouJGCklsNt8epq7sJmf834UfVgTDlT1BeI+QboGYcWUWKGKoBkkdp3Tgcilj1zvfGKm2nizRfvQm/wd0l5G2Fu2yNrtz/J5gIIbhGvcReIuArT0Sl14U22Qj1dBCxJrr/aG9qFPe+b5Rjsgz4SgRWuYX/kdN9JdyfPctIMYKKh8rA8nBzAafmu4IJmOvjDDlRoxlYJwc0dvu8JNMRIV+z9PEAgl+yItU49RzekI4GFrmy1F2I7OxCAiXyjjiK2hGcwrEMHWyEOPJz+LNqdfzlCNmdtro2oXB5t3siy8x5uAfvRceiggBs37Q9mqNYrLOCtEmUiLJp3M2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FyNVDT1i2toV5G+AkwDNTp/wvujDSgOLEKOBLYlqCk=;
 b=llR98kWexnyDRBjNL4Q0FqTIMAac5BBDzgVEpcugQmXC9p/UoBx/0JYknu9Ck+Nr2107OwNcb6+a08TvyiYVe1qYIBGcOBLeIwVyySZCiVzyOzJP26xQ0AUvkygghX5NTXA41kBcZBnKHC0joCysJ/YN5UI2WeqM3B1r4y9B3tA0Qm7fsJ0dwiduc23Py6iq4T/8n5huPc6Z1v4ZtcIa0kEYzTisa1i52Z1DF+WKVmxrVNAEt/SzKOHJU3dxrvUEK57yczJ3OF1jwMthej46kTvD24zjYQ6z00P8tBGcIWTOTQ6zO+nGVp08wYr07iyEe7vRJ4Ttx+/MC+AyROADFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FyNVDT1i2toV5G+AkwDNTp/wvujDSgOLEKOBLYlqCk=;
 b=CLhajgFst3PVNTKDBCXz01IVvn2tP1gA3udpFOyUHVvqDwUxyfrd019j81qJinm+U/yuAjTOqo8LjrY7n+/9K8lZB4oCIS7IG95xsx/8hmtaGAERAp5/IM4qJttltLPD0Tlx6bZyCRF+9xbS/bbR1CWj7TGeJHrffnP9kxOSPuX2IHg8yAgqt+v0tE8YMt1aZDP0atNq1PWrUqJhc/ie9NOq+fZVSjCMgM06L0G0iB5tRJOiVv9OFJIDh4gY3tihYKdkTkXALKwr7eO+y8JpFrhNV+jt15pdZiBKnx6GPEjgGfP2Z9wVbWNci/m6GZO8UrYWsKRBtKTrcqSzHI4jqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:33:35 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:33:32 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v7 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Fri, 13 Mar 2026 16:34:41 +0800
Message-Id: <20260313083443.2391254-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8b48ff-c696-44bc-f3af-08de80db358f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	15zMIKQR4jy6dtZvXF9EeK8BHRDEHP01KGm0HW/4X5m9ZnU3VSSWa+VpYDJyVBAR3IxWWBlPe1xinvi0feB+VeNNOtSHT78NZ96rrKLjTXv3dp4VbnU4etrSh0pz71M5e2UfWQDp5lkFOtTXSU7ZkF0vSQV3ECz+xC5YGw+aw9rhRZ8i+ZGmKTIv+lfGp+zXLKirlWc/2KCUw3TF8CrZxyp18uCYOq8rhnxltopvtWVzdFqDDyQXiGW7/6TOD1JSiij//EftsIjQxQBeAWzwbNUFa1oFCNa+vxsaPyDtKAk8vAqEDJ9ssAgOfslukWGk1Zxd25TyvFelqDRn0tQ7l1NA8hhsEPcbKrEmzdqfOsjvmADXobR9J8lmlSKXUyarNjgXqWk7LVOerVEL/+VcCEC7BJl57bxMdEdhHwFo0ppaKlw5WdwzC5MtFk1HeR/18WTtsc9rW/Wi7kgLgn4fIpgKSeC46ExL0HI/s7kN9x1JVTL+LRvyBprqj6QJfGQa+rDG5AeIapkOH3oe0oRpVC6f3De82XfWgIDw6tu1rlg84EIwYYlwn2zxzWKcUZCPXpAuIxbF18S8RPaOFuvxT6Mkr2tIxwM6RZYTZ3FZQr8Q1rGOlweP+R45kBoMq9z9/L7avV0dix5P1NVpw3Ea2/Gw/RYtMX9FnT3ap1YZ9oEXMS1DlT4prmPHtrPnxRfpiYA70taiTuHtEk/FlNswPbE8yT/CHISAj43AAmo9j9eg1dVW4xqipsFlW0felOh8F+Rypc6NB+KNnUa6mnzrQj/6iGVohdzZjRD8y1TebGgSCk2VxGczML0iws/IBkm2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5YHcDIhULjzWurvyjIBQGayR9KyKFNqQjaB2Mp68k0DPme9tqWkGr1bFKFYY?=
 =?us-ascii?Q?TixT9ePkmLzbQaUEb8eCejL8TrZhqlsLZrhDJhXumPWsNReiGlBZSMAdzC9z?=
 =?us-ascii?Q?NGv52TOs+tj0ryGma7iHXFIh8cpnPzwhWoLOsnkoZPnvWT4yVCnsQIVySGIN?=
 =?us-ascii?Q?vvmzVOJRuTAti2iwDA+1uYKv3rk+vqo7vuh5jmbD3zuk3Ufxm70rYc67nH3d?=
 =?us-ascii?Q?qWlwpJewBNr22LEa93At8iJmTr2oOCs3WI/ilOmzaYKQFdFJGM5lAMxtygot?=
 =?us-ascii?Q?qp/F/8B8jHiE7nxj3/FaHeUvDXjm2VJQ0llh/aXnHWXTaXz5GYjSpuei5Pyl?=
 =?us-ascii?Q?G5dOplg0hWkBl3yvejlJTkvAv8WjafT3k2R+yhpb8EH4lhwfKC1ICe2dzzXB?=
 =?us-ascii?Q?4AalJFcLylLHRjZyS6P30QIunhQng/7lVNCGgabYod+NXg34NKtfvUvQ5y64?=
 =?us-ascii?Q?x9kF+QvRm6S6QlvbU1jabwtzd9c5A51Gekn91/e2NmQ8TMZ5XqqhF5zB/Jh9?=
 =?us-ascii?Q?vYmuHQIa/V/VoXR5Hk3tkj2LtdHCRp6zoQ6aDJMFrZoK3mY7Ow8UDIbqTdmm?=
 =?us-ascii?Q?KLuvbizhOXqDFgccylYrl1ZSTTizuY2eBBh9TgMtPB4nG03To5iAtQsxOlvL?=
 =?us-ascii?Q?piEoOX+fJnxgUMb61kDFgMMtC6/Dm06VDwmlHVKDdez3bjFgTZK+LVb7z1ER?=
 =?us-ascii?Q?uo9JUDHLdNhsCVVfZsbco8+9HYxvm3fv7pdZRxuZANMxAG7Hk/6d5PZnXDtC?=
 =?us-ascii?Q?vrsGBAckAqieh12W2Jp9I0Xv3sdURgJrRnjzvh5J/rTY2d/tJ0EbbSZOsoY/?=
 =?us-ascii?Q?H4zIwiPiBUwySBFcPy/5R+nVsG97r109WNtkkJfLTjNvU/uUehMYempVGEsV?=
 =?us-ascii?Q?xTThg1zBjeQT3lygFDyPLjQ1Qfngn4Bv1hZnEIL5ds/DC6/KHcMMLqAVyruu?=
 =?us-ascii?Q?11cW2uZFBMwhrG/pr8OKyS3KdzCnv4unmAQEweWH1/kjyH40/o95iXg+58y9?=
 =?us-ascii?Q?tqSeu9igbhFKBmIV+9j3Mhlguhw9oY9+QOhUuG+FPBWs68DiHLV/uzHEQk1u?=
 =?us-ascii?Q?Q4MxfGjyvqCynU9ZmVi+Z6RJrViIE2f8z68Whm56JVVm0VLyZHvx6ChKqgOm?=
 =?us-ascii?Q?J/JX61+pVLjrGZkilkl7vAdAQ3UBE2OZW9n7IEcJSVeTMZ6qOsO4C86HB4eP?=
 =?us-ascii?Q?DpFT+e1QSMPRsZScqdXlRsOH+Ts/IrVAgEUBZwBBkBsVoeDx71SDhve2wXRL?=
 =?us-ascii?Q?pSO/dsOZyjifR2+0vf6uac4X6Kr+QHKCkxKnqxNiHdJ+zuElaEfMGv5pm4Ce?=
 =?us-ascii?Q?y1sKkNsvi29tD1L7ec6k9biDZwG9iFQkEGNwxqZ6KYpIjx16dqnGTZ3yKjyb?=
 =?us-ascii?Q?UOEyQRD2Z+oIf5rOtaaABCrpkpOSeCfXcy+9TLn9xCyx+wwr+cYx0ML9F6AQ?=
 =?us-ascii?Q?i6Uvh7aH7V8zOyuQ3n4jj9EDD/Nea1QGoRokD+DniM2v9tP0tQ6XsFw0YDnS?=
 =?us-ascii?Q?ium8eRaDRlDwQHgRf0f7aeEnh1YxDq5BkZcqlfhtwCkqDW7Oto1YBSNbQlsm?=
 =?us-ascii?Q?cawv3hY4NLM6FbQ2MXnqzXMOuIUh5L95ocdMWdnhlKXUXKJGcu0Zz0Q0TmtO?=
 =?us-ascii?Q?O+RemlS79u6c3d2IBSER37WDPLrCn0gChbtyJoq6fRUTKGpFPyoadhmr26+r?=
 =?us-ascii?Q?SoRhGEIiLiripFrmcywisaoklwDUyOPCjhliX5NR7brNLzRgQ9cmFE7F0WOX?=
 =?us-ascii?Q?mwqLlV8oqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b48ff-c696-44bc-f3af-08de80db358f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:33:32.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MhdjGCHGykidiTluFI5lQbvuKVebnDGvOEIZJRXU77RdEWNBH5sdV6d+7tze3j3wwIBT9WlT19sAMJZUb8yJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Add pcie0 and pcie0-ep supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d2f31c8caf6e..2d8b870554bf 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -66,6 +66,13 @@ sai4_mclk: clock-sai4-mclk1 {
 		clock-output-names = "sai4_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	firmware {
 		scmi {
 			compatible = "arm,scmi";
@@ -1223,6 +1230,87 @@ wdog3: watchdog@49220000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		};
+
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx94-pcie", "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x4000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x80000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <2>;
+			msi-map = <0x0 &its 0x10 0x1>,
+				  <0x100 &its 0x11 0x7>;
+			msi-map-mask = <0x1ff>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx94-pcie-ep", "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x4000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL>,
+				 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks = <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+					  <&scmi_clk IMX94_CLK_HSIOPLL>,
+					  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x10 0x1>;
+			power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
 		netc_blk_ctrl: system-controller@4ceb0000 {
 			compatible = "nxp,imx94-netc-blk-ctrl";
 			reg = <0x0 0x4ceb0000 0x0 0x10000>,
-- 
2.37.1

