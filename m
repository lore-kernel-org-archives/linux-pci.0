Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B53C6603;
	Wed, 25 Mar 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436539; cv=fail; b=QtjfO0w++e+jUhiDGGgwMElUbLBuQTCU2dYUpnMRUo27fHcR+vcvdGi92IqfHUPF3fHitCdQLJIWt9uQwQ1CEcL/eTbYxnuN2H/ny1lu3sLgEkadGafqT+bL2O6gefliZQxdrFf1ugm7cXO8safMXOist3uFKb+r90gOTsxcQr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436539; c=relaxed/simple;
	bh=tJAZnqb1iMX9FH7eFTU8zDtAQmJc8w6CJsz1WOBux+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SHaIM3nqjaHIsphG5KMHsP9G2F42AeX9tZBc5J+dkmdq8QJseyV9/sdGlV3YBqxbNK0vWgp6hzRLbxq4UkNgXhwk7gwBtsxF9NhBT68Ci8p/4cERbhRmeS76yB57FMPURCDemAP6fCiymX5+9np6D51ockwKj6Xt8zJF/KWY4A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fE+LojHy; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fE+LojHy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgNvAZLnVkUaYQHYi5yJtKD+LcUugmWXSYlRsJ7nij+Kzgo2J0Vp4D4w46jo/Ee19eOVbHk4pnd6RJR8jH46hvz4utNvwS/LM8CTi1YcDnvuultuJZ3KSQF1+uy29IWLBk29Goc7Q1EkzAL8HBuwQrzozcRr4IG9Z03rmaeVtEujUKXX6KK+gk6cg5lQYbynMBoNIAZPoeiDrD7+SGamiGm6ca5c/ezsrXl6WEQjKssvku0baxmCNMQS+OHzSmJdhfcS7/mZw7doNwJwl4dFsNRaXeVJReBt1Jo5BBl+fTGnCHwOKEyXRStlkK8HKPQ4FHahOBJ0602hUBcEtHJGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIYxK79Gz9Yw7+AcA+dTTO6SOYoEIIynXvlZnkrZOCw=;
 b=huQHGKBOt+A9DjgRgc1900lfIStXSUEjm6jAIRgd9FIuZ6UIA3/2fumCz8ufQatNIirynFN8tf6lHa0C7zQDvxOgzNv7odY+BFesdPwqGhls7sgSMZ7+5u3z7jABhpDGmD5kiJtZyjYyXy+tGry7n8sKmVYux2NQNtidwi1S0wFNwbkCLwAPmOyzlxdsjfv5Ejjhkh6F9mf2ySHT0Vuk1Ox8Z7clOSc6fpYs+VNbEeWUXq5CF2BgCZpdV6+EDI2d2aeedv3+yrAqrI++NqGSSlDR4QbW5wW+FkJJD22btYxGRXJ6G33rZg055quCJ7KNTD7kNWvGL3+q6tEPobx5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIYxK79Gz9Yw7+AcA+dTTO6SOYoEIIynXvlZnkrZOCw=;
 b=fE+LojHyxoE/1BIW5AeQerHIIl4tay+vAOh/Cn+T/8k+huav6eUz7wUibMRl9zbuvmJI7vol0QbIEaEK7W4hZ6Pcy06X7qwcytsIZY/UnM7RYSbN/CtfmPuUjkMHuRf9zMpcSH7O17utG86boEhUPbVb2JUGWSq+NjckwLf0MfuwNi40Dg+Cr1vtu7Rpjj/npIHdQLnFB3RdQ5qZ5BkvdWQD7djzX+xi5KN5Kl3rzsIqrW++9fyw1H7T/QjO8Gl+Rg4m50LtQkvzSF74FacFTBkNBSmSwE7h8amQL1lwFjj77f7UpO8+o8+MWIRVwz2SjCwOHwp2GK1/WkwZ8zEfiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB10398.eurprd04.prod.outlook.com
 (2603:10a6:102:44d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:02:14 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:02:14 +0000
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
Subject: [PATCH 6/8] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
Date: Wed, 25 Mar 2026 19:00:56 +0800
Message-Id: <20260325110058.2854742-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: a648f6e0-b3bb-4de8-f01c-08de8a5df88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|19092799006|376014|7416014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aMrGMgLonAlTBADIKG3z+O+SPqZLVrGR5e6eOVigcAjLvPq9jcbvYQ86Cerb4j+ThXyQHGxH8b6t/hQIWh6ErUEcN34XxsZAQaH8DMfg6IntR4gd2jbwxO88RwGGF3cKX9zJBeKzQKfhr2kx08IzIyGGfoMFLXPXWcmIW+UE4Q254wU/7YOtOuLWa7VtSJo9vhIx57fDu2SP4Qwz9HWSI3hyh5Bj9UzdZpWY6CGnKXJdSVFNIvTP4zFTqQNE5wCjZpcf3FmV/uCUdlUlfKqsIrwTSQmtloNsDAgttjQXFya+Py0rDkd9Jo5Amjbamcw0ooi/XPZitMSECoDbimUf6FsZKEXaZABRLMAhLW9jTnmvQJqQuiMNuXrMWCKq3XuVelK/izZmO4ARFtyUJmmXfLsGQ7U+xJrlGbojxEehWkuy+4vfwqzdhveCSAn1ClgW3JfeEIx1FD3lfp2pzn/tF+NZRENdWNiyh0VC0MnaDFY9gxf9BpiY8eFkmZFEkTQy97aJZugWburbT2cJXDAcT6oq62S5HwdeBYg6nUwq4W0TRS3O/dXM9LexEZMN9UseUni5EsIYsGsOPBcM52jtMFxKbKXf8diErYpKY/Ltha65db5/+YAKmaQuvcf+820uMk/LxDgWlgxRyenytu7Xje0GqM33684TURflPEbl0Le72JDQbC3g4O1yQQfTG2BZYs4m7J2ih8/ifNl4NMTXGGgPpzcsMtZFg3q8Tl3fJFfdQ9ZUsrVF+SL95I//bAqPNj8H3eo76AqM4r6Zy1d/2nOB6+ApJRvZ0NsS4qUQA0W7RnTvXMmVm/+vbcpgNNB0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebyZS20Hs98n+icg9nB2MqZ/LJV3q0pZGCZSAlBuh3Avgs8ShPBxjS40Pbsr?=
 =?us-ascii?Q?6rQFPrI8nmK6aX3TP9t5/da47BjHFwWyNL12M710OvRLWlWxME2WbAkEIPb4?=
 =?us-ascii?Q?MhAnN0arrdBVtBSorI0SFjqu3dNzt2XO9gh/T+8fm2CfGlVPie6qqv3zwLIG?=
 =?us-ascii?Q?JcmxGZPVTTcP7yLwyFFgXHLi4j5VrkNsPrnoecm5HgNg7PwMd2mhoiK3KSsJ?=
 =?us-ascii?Q?aKbV6841clmm4xERbRiQeKgln4B/USqh4hkzs+dwUSHNKDUo7lr/af4EXZmv?=
 =?us-ascii?Q?NH8nLUaCWiC0/BI26UjDyr0tjkk7mEPE2aL+0bZ7voeNCOziY55+TWo6m2MN?=
 =?us-ascii?Q?wcko4PnPzOsQdij0663F3zgaDxTxi5++1pE9SUuTDfflyjqplhjYjFOoxQ08?=
 =?us-ascii?Q?dtN4T1B5YgAhY5vrTfED8SEullo6IRLoxqJZP62NHShWrBFQF4T3qbEBoO1K?=
 =?us-ascii?Q?jPjOFjEfGG2DMLA20RAwZaxGo90TfIQ1EiXWqbo64N0qAYbBiZYdsfJcx7AQ?=
 =?us-ascii?Q?e3nLCE2Dw/WxklS6KAymJuUOIfDlPsI0KRuwzeXTn5Rl8mWIXqSlSgQM7Hv9?=
 =?us-ascii?Q?ZzTN0/RZBlq3QIThn2BokekotX7CwfgHdN8VxDpCJdgpLkTd0Lqc41NoR2Lt?=
 =?us-ascii?Q?RFeV6Wo22xx9FeHlqpp6SN8nstpCb+S03Hym8Wms5Kzci8nnpIzRZ0gvbzwG?=
 =?us-ascii?Q?q2cYsPB7rmb9N0lNf9sqrI8bWyC4r73gVPQd+n5BF5LtxEIUOjJdwi6mFUS4?=
 =?us-ascii?Q?zGqA+90JcyII6a6zSB0eSz1B+lXZg0mp5/y9on9Ttnv/xD1Ua8jUl8zJ8mAA?=
 =?us-ascii?Q?1NR439+fp5aewrHEYi1eT8aHblr0DjSaVelVrYDubXaHVfAYde8qTY9f2QNN?=
 =?us-ascii?Q?PcVB9jQSNa0+5LeUED7FuRBoXcGzgE5k9LkdLa79wgRgiWfXK6Epq2AdIQXm?=
 =?us-ascii?Q?1KHKDJ2pzuI0CbKgojdDz2OiSaZz9GFvitKEMqEUw6ir7qqitVBF2zAUEPkn?=
 =?us-ascii?Q?9YqARkOJ5U15ILzWRk70hmRV4nikaEQ/PH+FHZqu9fA7Qo/ueTt+HBLe8TGL?=
 =?us-ascii?Q?IbKEbFU9wraqK3QPsT8KfHM1aw9kvRw30oQ5TvIYiMVDh5Daq6Xc8Kocx5uO?=
 =?us-ascii?Q?8qm2Z0KMME5uBbFOcTT5WwZ/8bt/qmnmz0aWLLfp36AJRaikmPNwqHcx14Mx?=
 =?us-ascii?Q?r7xdmgefdmk7Bz4AnPeKpFcMbBmdpK7nAN8pRC4efJEgbaQD3KO1i6gUygU6?=
 =?us-ascii?Q?eKaLbFtozfYw3XzpVwE/Z1LAvW4Hcmn20U7utT21jqV1TzJYCtd+kXJs+dqk?=
 =?us-ascii?Q?52rw0Lez4qQXzzsqzS2MJdWLpU605dQsA2BES/40DcXJn/j5NzNm1mlTaJub?=
 =?us-ascii?Q?VB/4oxTQJYWAnSzn8ACwC/xCqgmWMq++zvQl7xctxpu8pUqYs9Rgdo1cX3o/?=
 =?us-ascii?Q?03yQqlA3n3r+UdLxJ2TlzzeafHDnJZTOZ0G6o3kh/Ul6lmBlrShrpTrvpfVi?=
 =?us-ascii?Q?Q5EQ37osu9pe5TfOCQx3AgQUlXnQyqVFxB20jhAVkQxVrCCC5tEaqzrwLM53?=
 =?us-ascii?Q?YexN2gJXn892UHWmOilyKadOBtuNqBiK0ht1n2H+0KgwQ3Wi0vei4x/WVUa1?=
 =?us-ascii?Q?bb5PQr3l8c+8IVGjENKw/8GJpDHVOwsKzA+uqsr7n3V6kS5YDK1NNAy81eyy?=
 =?us-ascii?Q?VfcJ9pNCQz7oWNfj3scHABzPwR9T+HHPEqPQVjXJkLfxNb8Bo8Kl8Ct2Mb+3?=
 =?us-ascii?Q?wtq5lvPB7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a648f6e0-b3bb-4de8-f01c-08de8a5df88f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:02:14.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTM2s1RBCuuw+dmWyF+psj8kxP5ZCAjdUcGyytE+OgAocFfohmZtuAQMINASorFUiXMeYgSTrox5jRn/ridcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller node to the Root Port child node to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index e7d87ea81b69..75d9b25d1f0e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -403,8 +403,6 @@ &pcie1 {
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
 		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
-	vpcie-supply = <&reg_pcie1>;
-	vpcie3v3aux-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
 	supports-clkreq;
 	status = "okay";
@@ -422,6 +420,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie1>;
+	vpcie3v3aux-supply = <&reg_pcie1>;
 };
 
 &pgc_gpu {
-- 
2.37.1

