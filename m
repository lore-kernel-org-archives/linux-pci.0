Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44B13B7A3;
	Fri, 10 Apr 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788222; cv=fail; b=fBwztzrzTWdmz//dIE46yrsDbVP6zBwBEWlQWHsfmaN42rDFYfgsbSEVmmmOMkteqgUtZw+DlS/kqYP8O7d5Onb2bo3WlB4JdIO91ajiLzsUrWICuW/Yht3Dw3No6yAdXDAnKEeVHuVEeYvoMEDy+wrY1Drs8yRG0kkKP/PWzoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788222; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5KC9xa+U4tDVse89Y/+09mZt2Bu/xdLlB0Dvvqm7MBLGrJXpyt5kKIy3DN5XRysTuFPuRXISl+WkYD31CNMYO6aJMGW+4tvzjIKPaIligP6mvmLUIduVjyVUExnFe8xp16EMQh67ScEWA2df5jJrncXuEjIXbO8hpiobeG7g4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hec43Z1b; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hec43Z1b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMSPfGEtI9pImfOr2kQvmnb7evslvrY6tLioDotpgCxeMPq9Uo+cE8aNS/SR4wCGu+eHfqygwhdxBkHU7Ba4OI+pWP3LYlCYT9G0y4uvvd06rOsnwJrGbbhOfsPx4qxTXclcMuosThU52T+1WGl/bCAh+dUoFGslglXTdVHdLDM9bs48kP1tXNPSk7DO6yF9LhmyIAvlPBxcsjvMcCbp2gwZnQ5GQrwybajf+yJ2NXKk+MK8s/ynUbg6o3UhcxaK5tVZq7TiS8W8T6AxHcsjOlniXfivTcb3MYIF2nb7tLypFCoJMBJZYR8JkKsf7EybO40rpiYkt9g8waPPXqr2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=HXFxtc43M1AsxKhNuAtqxDknNIEJQ4GGQjAMc/ZxaVNmS3tDK0K+1sKnAmUoELa6UD5JBs49zR7/sC9O/LBwGLYPBuobL8BS+Tj3h+QDi9xVVYYl7Onos2OMoib1gAE6T8lG4obeqIYPq5pSF0DNziI15hrHmi0XRh0QqykP7Lou/lMIuLp42SKQQQFKFhkAIC7oORcv/q9N4USZu+3mMpHUercnLnJuZCPcJ+uXmxpB+SIKCr6nvOQOU9kwWoClrvXEgKhD/NGCXU4C9EFvKgR1qTIUkV5gxcwX6s/CBOzzHuzE4kb5envTQGfhe3YqW5YtxUAz/atPVG4BxnpgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=Hec43Z1blow10iZbu9C6B1wx/c33n955x3wEsbI41Oi7v01HEBhmYT7GmX4dUxrrKHpuA30Cfce/wKJJQdqnluulZU8m819OKrOBJ1PgrFfcGoGJ9cZSmIoN801OBlGnYzAzqfaIVc7bE6Yop1BxrTyVu6sEW+Tc3ZZkXUqUBFwopyxx9wJTJrn/Cw24Czo6XkrYy+OICs3JjZrS6BuNRhi6Kx+EHa2XeIFVToBuZ+B0VG5/+OTmKKEbP+oRPjoly1VLJIwNCvhqZUNw0Hgl3BvcGIk7p9yy4s7Mf7vmXlS8k1YsFyI2IAUR3z/OL27INe+3ukztYy16Eu1bin0dYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:18 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:17 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 07/12] arm: dts: imx7d: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:50 +0800
Message-Id: <20260410023055.2439146-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: ff76b7c3-87e9-4cf4-d47e-08de96a91a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	22+g75vt/Jk2HFirnqSyOfB+WO/+fy88T1aJixlbKb67HvQn8qs4Mywl0atRjHPbIngE3TdqD0hw0IwueaGrG0rEpyJY2B1eZfykUu3lhWafwUDB6OB5NZQZRXH/pUQH74kc9F0rAJ8NW9+h45sc1BTCZzjsN517syZWkQPhiO0XWudlwbzGHEFK73fQzMQOPUrebv6yyonwiioli0z1nWEzbTi7UX+u5+czyuIYhD42VLM2u4jAyGPc5BsStWw5ipRhVmlW0yrxlyP9ICBXSiSferrFFmpN0McBN2RKRODEYglUfUoAJYxwa/jPran3w1QiwFJJgYKolFJHgFDhgYUmwjjcsGxYGpFNvCqPJ3Pdqab+xKBWH3WtEEDXeplHoimb8PeRxHVJGo5HExqykR8ue7CFwHYm3pTIKdwgMUabD3qb+Y2tX7oGw/+UQcgtjnzCaH70NDvO9NWKQ9rbSjiwC1OmLNikajIPb8on7PL6jNlSeuKEbTT8oiCUWH5Oa9IrZZ1vD7v5YPiGk8DgIccr6Lk0wSJv+AMBR4WnPfzfgpjl2VGdhNlt9BfIfk8nUfpUR7cl5CAc15n1AjP9w1rMViCKXtWWRhj7Tn4GdkMLhxpItZwpYUnXKJwfPV616VI1CH0uMpEAsJDy6q3uPbUMaH5tTJ2BpMBnWmaFqzja0J2ai0wcIYj3fFbR9OhoMsdw+jl4rM+2JqtOAnNY7iTMyw5jicCL4Z3YsiVTBDjU+4CL3kuklXI+SmblPlcaT+SUJimbKDELBdyw6Khk6qcQQZgU0H13lCkemnCigXCZBmyTVdSOs7ZdwG0LrM6s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5mqUMP1TzLwDoTSO47z8ZC+WtY4ACovVXn/LsXu7AaoGLamsjpiSqZtFaXR?=
 =?us-ascii?Q?KhWib+HnFUF0+ozdfPU3FxNEMMeKrbkiL7bP2/05yym7BD6lwV2lz2IHWfRV?=
 =?us-ascii?Q?bgrcRAFjBABKtqpdATKC8O17D02pMYtlxz8Q9TmXgaBe94NhS+W1jziOeYS5?=
 =?us-ascii?Q?hYZJQZU3UJGio54TrvOyaZDpda9CCBZXx5B77ZtP+712+uBQq1FLDuTOb2ep?=
 =?us-ascii?Q?8LYDgqXS7iuoFzU9FJT18Hg6M2VL82PF+7caGSO4jziOg/K9CE2ze7lUA3g9?=
 =?us-ascii?Q?plNNebsAVxYgm33oJ6amkY1O2LxVlua5AgOCTB/eKgA5pco+TAlhfX0i1Qgb?=
 =?us-ascii?Q?BnHPVmk3ardbkOLwkRH74dn8d3iBKsCBjlucjWsU9BAjKdS3Y+ejnxATbqUu?=
 =?us-ascii?Q?ekwIP6WM5kGK7kXdV4Deo6TCX3LD1rjywGKSYhju4wlIEvBjjpWHWb2guaB/?=
 =?us-ascii?Q?Cck/t2OT/YgQIu7LUMYSlRzQwqY+Jy57kuwwD4cafLKgFcor3NAn0hkBR25w?=
 =?us-ascii?Q?3hIgovT0/E0hRvjCDfWqC1hlcVXYScSgwpqjbHp3GpEQcfg4Cnf8/f3Pdc3z?=
 =?us-ascii?Q?kxWqf24hP6JJXsBThn4WGmzxJwzFoXfUZWqlKNJVECnaoDMJmkvSRU0FyI1U?=
 =?us-ascii?Q?ysJXKwOiufXRKiW5uczdbDv4zPvBeWyatRLhLItqKkivau3+UpsjoD/c+YFs?=
 =?us-ascii?Q?+VkPyiKBx9bi3hT2bHZ/AqV2Ioti8+UtPpCsqFWVr3dKymb9L31A/n/3zhdO?=
 =?us-ascii?Q?dkO41Ku7A19t7EfdZpoL1Fg+KkZyA3+h06XfK//kc4Xo6MjeSBXnejU9NdCA?=
 =?us-ascii?Q?1BoWgRXOv3do23daWyPWFdF/AeAHi3cEh7E3DfCNJJt7P0cNG7De/VR/5qp4?=
 =?us-ascii?Q?GszfNx7mm0u274g3+OFKmddEkcgMjs2VPQ5rms3rTtjY10khkfvyB8vyclH0?=
 =?us-ascii?Q?JVL11lD9Q18sthetLhGxBtTRZNbJTRiqzvVBDOl9g9Q/Rc/IEMyYwihIHvas?=
 =?us-ascii?Q?/37DDdaKQrgTFTLB4UsiIRhB5WHm+AdBQ2tqPfslkcyvlCy4lPpjWY7Laokg?=
 =?us-ascii?Q?OmmcZM9mP7cEa+12zdAdYuIQh0//+F0hdJdpR6j2fMkcagjHq3PS+YJODyne?=
 =?us-ascii?Q?Nt/wZrVoXlZr9CfQGgX2Hb65EJkjd6Ah7zVWlC48PWYECGmvc2zn6A55qtGJ?=
 =?us-ascii?Q?6AGjzbrf9PjYYM+C3aFWYarlqdLV+SfkjgmsfUf5/5fRZHiCYwaPGGQWX02p?=
 =?us-ascii?Q?gSsz2ADGd634VtAsg0f0fr48/W1RJe41kT5qhzvdeH1dduo2gy8OSWuBQSXF?=
 =?us-ascii?Q?I/xNHY/PB/YmcWhjws69uTN3uf352PxLacWaX+4uklsbVO20Cb/yffGtPJzz?=
 =?us-ascii?Q?YxBU3Srkair0dn2lnx7B0U8hFkC41WFVuqB/14j5bMbQ2N+Ory6B5BHLDE+O?=
 =?us-ascii?Q?UZCQ/7LqdeZ0tzxMpmvYXZtmTOVrMP0bSAroEng0nok10kJh0SzaKOrCQ2ys?=
 =?us-ascii?Q?AdcYxPCrJNy7aDwHd44bFA4usf83mtt8jwZaE5j+ZEfMbkcMYYWwtkflS/GD?=
 =?us-ascii?Q?oFag3X83mGsMhow3BhDX4hxYT7NCzKW410i9IJ7GVf5OEc58jytjz7q5tGyQ?=
 =?us-ascii?Q?7hp0Wx3QilyOYGDLFEac4w7w3Min34CbETdk5h8ec6xqf4DngobXn73rX43l?=
 =?us-ascii?Q?QzvqNW/ZgqmnKfa2/x4YMly3cSzcCNcfeYcZLXYoKkrCFGaKJqbw6YMuUWWL?=
 =?us-ascii?Q?1J/JZ0YHnA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff76b7c3-87e9-4cf4-d47e-08de96a91a89
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:17.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osbmeQ5X4EAHBuEJfTG9b4CsUAYGuILmqQd6zTZluN7RWnWmd+qpTffxH+Qbq0H0bNQ79AwkXxvi7SfnfJMCpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index a370e868cafe..0046b276b8b9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -456,10 +456,15 @@ display_out: endpoint {
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&extended_io 1 GPIO_ACTIVE_LOW>;
+};
+
 &reg_1p0d {
 	vin-supply = <&sw2_reg>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index d961c61a93af..3c5c1f2c1460 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -155,6 +155,17 @@ pcie: pcie@33800000 {
 			reset-names = "pciephy", "apps", "turnoff";
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 	};
 };
-- 
2.37.1

