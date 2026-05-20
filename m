Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9F319601;
	Wed, 20 May 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266857; cv=fail; b=QKE4SM2+7Pkf+vb4whFRinhI1JGNXedVpvZF04fHoKDjqFd3Q5i8y0DmONFCJA9lXW4QMeJH6ODFhR8N3zKWOLTKEMIUbVb83g0g4rc1SVumEMqkfFvZWQSfhFV6fDb06twd8rbeDWYDKfP2fGhvQc0Y+xMjJhwfyPn+5bjcLZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266857; c=relaxed/simple;
	bh=EtCQDVx5hUMtkNQ4qxQM8q5Tfg9mYX94dbFOiWWws0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMVkH8C6oxDzbvo28ehtdP/UvxFGR9Godrvivh5PiCTOHwvHSSqSGNj2uE5sFCdEVgjY+1nhga8luIAjQsxSTn+tT4IyprUC20As8uWH3gh5M3Dec/G54PgJ8qDGXjq4HCamGPN6TB4GMfZC0ux6ZHGu++UwnWiwFaMmXScomr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sSCTGsAG; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sSCTGsAG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7KgAWRtkNmi4sjVKaf9yPzr7x92QGR4cRFsUwu9cZW29Z/jEtbdmQo01ADHndE3kFlosqZ3L1ty/QzczkW6RcSyorCXUKYq6g/mhfi0i3TCCobZ4LI3KW23ED1x4HTnBPKtMI2XTguDfSAUeHzb3YBaSr+PC1WaouC6knV+Z78lxReY65voAbuYUGPtUk7laavEh52FiKOZd9INduOTbctv07SG+QTjqa0qSPKQ6RdJMMcBgTT9Oq0GRqpXW4739u4Z1ngpXLj7Ysso/58olq7It8K+lY96uaA+KD8c8W0cxkW5Xhc3fZmkhWSEx3lLkNeHVdaY8VGO1IT5N5AlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1z1izB21tocdD/qg5NnIesdOGmUyRktkIWzxvhl770=;
 b=RHMp/qOrOZAoHwkz67cZee48rihOacpUOPv2DT3Zto3bZZAuyOpEnhYqDbZrA4rhy3JwiLxKPaGSEA/3Wag3JsoOC91/BVBovy+aa5H2EYKOIkPqktOle9P0pOZc+7Ap66DNW1Egg+abmiA0rkxBSBtyjSWRU8mQO+8A1RHXLs7r4GwwzVVCeaSfw55/FamcycSqz1zhT5F1T2AtYAKd4NKgnAQkDoXP76GTesyn0ZKPAM1sXEv7/Jdfbc72VEMgtdm6pFRXiZSNl8QmveoYY2H5IGvv7hBW71c7xJYA6wFfAdQdEzL01QpZy0ylJQEtAQVKXCR3JLRnpzgja9Vebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1z1izB21tocdD/qg5NnIesdOGmUyRktkIWzxvhl770=;
 b=sSCTGsAGl/g/zm/uDyedsWrZCB8RUaXQqPNPIdjjEgX/OrYyZSnPeDCpBdxoX6mdRS/iyFk3PeGvk1TDJ4bSSs2G9PtxIZtY36RZo71BPJ+J7sfeBZru6yKwzPejumtwBlIn3P+jFHOspNRXFosvuOZrF1wyLu1tnYRIoAl+AZU65SjydQJP43gbxZk0wN5gLEFr7NVLDPmAQcOHpsJtRuQ1vccS1YcPYmVt4buJIz/MHIrOEGsXTeBydCANSHJFUIuL4/FYHw0MNansQ4mex5sNGOqXJqr98RVYIMc4nvqsrFvCV4TUxoHhEoUqZ4dnXs3U9V9ciOzG4y/hd9yC5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:47:30 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:47:30 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 2/8] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
Date: Wed, 20 May 2026 16:48:58 +0800
Message-Id: <20260520084904.2424253-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: c383eea7-ad92-4013-494f-08deb64c6d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	pCh0b6yNRet4gREvPHxh9qTz6xslnlyXG5jTdbAWIzrP2q6c1EmlcbsF3sIHp+kKRM7dEQv8+XIuhvfYqd8tUqWVt5jdAdPAaoIah17bv7gIQGoXl1qKBAdjbcU6cdW1Pe6yJasewIITPR6dyNL02tGF09a2Mb7V6dAUyVAGa8KGfnXfVHRk8+7lV7tvicZXLI1x2wAGG+W6+IwN1Q0QsRDqiK3l4Ozvg3a4d7uvLfb6x61RllVRvrTc/A/TkxVwivsNpTMb33wkuz+b0jXTwUiwJuEtiHsZGzlelFdyiUWeeWSxkLFiJxFgNqxhQEnfOaVHNJG/8I15ezmwPZn6jsZp26/MFuIM9o8pF8fsiL4Ho9UsxeAYZO6/L5VrMe6n6sP1NNKwoo9fYV5swYdPfHdIpmKcmQueeEgRf6xyQOeLrT+ZPKq+tnVMJpoQCujqcHY+qyRlWbKoSeN0ZlWuKuJNvoiwdIj5DVTTwoeqTQSW4YJzFX9xh492H5FBiFa0UGwldmNqOud7RHeQXdDM9MuHQmQi39mMQzNgpVQq2pB2RiRt92WMgDEjZPlpRWUtf4wbxY/Pe+OAGd+msBwvErJAeGWE0lnbL+pDQHqYu+vgrtIu07tL0VT6xVVvZlH9RRqt3MwCbZMSydGmFKK9jb2Tk9ulnya2pSzQ7/pEzhJADu9J9ufAOGHg8tPMMTDn/y/SdOtbFj9nsGt596Y7Pjq05zSIOtTz+ISjNhhObGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slLUEd4XSAMDR93pCW17PjnbnQ2bvNbTJT+EEBnDgM9DOwjdizfpGFmZI8aE?=
 =?us-ascii?Q?63l8iS8WKCBz5n07FULbIro+TOOQP1XGMAOXUeTB3LUhN3VWPUcPdWk/jc/w?=
 =?us-ascii?Q?Qa4kb1T+TUS015Z576SM0wiuU0i/mqIzEDoQC1VWZxDd/YSfexl7hLMUsJrO?=
 =?us-ascii?Q?NaHJl4xXMfwtt47ZEVZMsAWwno0eRT0YR8VvtaHuhRijQ02yCbWX1wVnGlAB?=
 =?us-ascii?Q?HfKRjd84CCAKxYjyfDGZDbUoH96qgN/otC1Cc4xa+6CgM8XM//BD5RUAx3yV?=
 =?us-ascii?Q?iOsRkgrlRIsAbIZZcAin/xV6ZUZmX73efLQ9kLb3jL/g93TCffN6krtJ8GSt?=
 =?us-ascii?Q?d2VLkDLZTQQKyutBpbRved7hXItjHJ2OieEkzlWka+YpU6bQt3TFdfDK9qTo?=
 =?us-ascii?Q?8sq/lr3DdlqRXYPgsp0/rhJu9R23nNWZdVZhEhwzoCHm/buOv6RbjuRskkak?=
 =?us-ascii?Q?/r/XMcgKBK6B9JVerhjTE1diySAmPVdmJm9MycuzS68x6MgyEW5q9XAZkU1G?=
 =?us-ascii?Q?r6DF56+NRoh+B1ewWX7ya07B/pSl5yS63rkUKa/fO+G5YB77+gL3dEC1yATx?=
 =?us-ascii?Q?MsXTXTjjiEzG55V/BVU7u5j6EGgjbEvwJwvO7zNbrNQqJil9muVuQPOPLldt?=
 =?us-ascii?Q?h3I8QCHk9Cp9HaEpxVJJeBU+bo4VaSX2uVqe0WUompwejIhcGWmx0PiiawuC?=
 =?us-ascii?Q?6pZ1kJEA7iXvxAMwLR1P4rke8ezlvqsKem341WaD81HdzeMs3ZWTX8UK09es?=
 =?us-ascii?Q?x8T+XLejukLnQnDXyoJHc609lIsrxHKgSVBNgTirtXXl4K/Pp6+tPj+1YHM3?=
 =?us-ascii?Q?N0UGat/1mIRKsD44SGVf2jxWN2DL7Vg2gvstZadJTT/dTqLAgEyq/ldGaP24?=
 =?us-ascii?Q?OPhN+sbuuF2et2t3iI9JbVKDmwB2+JbzcMW+CCuNDNVFYcfSRXMn4uTXSUkJ?=
 =?us-ascii?Q?w9mzecFyLPEo7sfD3jumkPc9z4Idcj9c+Gr7ca7DyyhcQ/DDGfkK0boEAu/i?=
 =?us-ascii?Q?mL980ZvmgTQmfVoviNjCrtt8pl+B+Aba4YwAINu63SSwVH2rSnrzoG6BN7Hq?=
 =?us-ascii?Q?QYLRdOh4i1py2m+IRMtHBMlzAqpMjhQTc+i4J5Z+7MhXc3C3Pgx8CggWW2cc?=
 =?us-ascii?Q?BIaLp903YEXCDZvh9oMbvDtFe0yK9r1mR9iqroQaRIJwFbhm7mhwtRq7XBWh?=
 =?us-ascii?Q?cdtHDI56sWbFF/P2N1GuVy5uA/6HW4c+oPQ0C42z+IQi63rsrRljCLEwASqm?=
 =?us-ascii?Q?wjWB2I4gLAys9/428Rv77qYAFyJcIOTRQ6EkYGXYxIXFt0l72uKZbdy7W0o2?=
 =?us-ascii?Q?ozJMdDaV+MzPB/+uSOsDS3lCjlnYiRIUXqGwqobxoxMrm4CRb4qLXBiwiAi+?=
 =?us-ascii?Q?Fk4oVreAS39cdFtKrOEmQcC8Z7ZP3lV7L1rHIuboaowgmqCLYzMRKkopA6wj?=
 =?us-ascii?Q?mMZMovzCtNPT0VDNSYZsCp9KwavhqoFB77mdvH+KDQp8skCwXmkVmy71pNiM?=
 =?us-ascii?Q?rgxU1rC51r2rVmqBjy/7hoq458hxYNWkUtyJa8TxrZYoFBGPkzhIDkKyvhZ4?=
 =?us-ascii?Q?SNQfNXC5S/KR6tL2YVc30zUX6VRkygHatxf2pRVychKxGM0iYoQ7QzZQxwFE?=
 =?us-ascii?Q?N9cw3SsBdLMvm/oRsR8LC+yluFRx94v7f/OttrPe65x4mgQpn33yjvZFWSfO?=
 =?us-ascii?Q?Hth/kP1Cw5/M9EP7GgC8qX4RZFYuHXxnlkNoCIX4gmcTj486BQpCc3re6vdr?=
 =?us-ascii?Q?wqVsQMF7q6+0VklFSd7VSZ6SMvjNvSoAmVKZH57EvL9/qAl/XfZL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c383eea7-ad92-4013-494f-08deb64c6d04
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:29.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP4FjXnjXNN3rVmPFc+3UH78VcYrx99GEQHVDbMmX0ox3Dd125l8my+K792GWI6OabMoIYEm42F+xuQElrQbaOD1YMSvd7f+vHHEOpTS0q8S3MNUYl7hvGvBsVFD5HPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796

From: Sherry Sun <sherry.sun@nxp.com>

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index fe9046c03ddd..e52205d7c487 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -756,12 +756,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie>;
 };
 
 &pwm1 {
-- 
2.37.1

