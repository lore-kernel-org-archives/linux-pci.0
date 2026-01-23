Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF02F60D1;
	Fri, 23 Jan 2026 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134644; cv=fail; b=nA/YNmdsCCbrYqSXUp29OG2fT8VCUPMBcqtlZYCyaKw7/EMARGEXpD0SBgbO8b0JctcxXh7mZJc3HiWLklaf3xjKN+EmjwoQlhDAOUVIBC3n+vrqTCEtY3dFVDsEPXE/+47H39LKcd1lUG+9tb1VD4KjXe+v0h2IuXvi5YbOusY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134644; c=relaxed/simple;
	bh=c/gn1HlkPHMkjtsuvTDG57XBRjv8qGy/sdk4nwL5qho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CaJDpdujtJGZxsrCXyhn0xDZrdKaU7ioMjF7E8qCDYes7178JUYBKHoZpdALDnl3Gz/px1GOVwV6AwT1Oagew1T2MAp/iSPloX+bzyqBMBeAyhjQkD+QAIiyJmAHPjG/MsJCsGfjS1K4/up27h5SY3nG4qIBzuGInMUpUcITlHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JZ1njNvK; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JZ1njNvK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTEJp09jNhWD/W64FxtRXbFs9cbhcncJoRunDaWq3Ru2EAF3TC/RFcbB21ZD+QiKS/MaQZYt8locmHdwLnaiDYn6EOO8Lzjgy8gULztpw3Xsa6IjuzPFHXQjheKnUTs3fdXVIOsQR48hz0AjYWQDj1EVuAG6bojhIGMsGDCF/ZLdlJhQXgoKHeu3+uU0P1Vg6z7WCPS2a8JgtZPjJbD1+i7ucFx+9LhegLr3Gj9hd1glNN3AVmACUrKFJZ9YacBZl2DqsLO9wdfmHLO3Q2NZxvwouhoPzJa06sEkjiva6V3yJ8mHvk2JpCj+curOZaHuKildmReGUTzsObIe6dXNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=huP2qp5EPSeXA2+Gfg4RTyZQVYVx+LkUbFQMq93yrWfPMq+48LNOpmzteURvJqUSQ9iX1OZroFmYWW9PCFHEk+0qCKmX9vdXpEVYg+ewlrCxTAIpWJpA+jcYfpTxb05XwdvroU50ZO3CYLw2QkEw6Ad80NvCx4Bnb2sXU+CoUgAReASnWfoc2r+XiBZ4r5l42b/xdSbImdL3m5FjPBWWYrLX3Lb0bHtGZMGQy7eCVIgYpNUbhTmEUxgE8CgC0nFzMBslc7bO+mQiMAmJGJ1Nn1HwNNbBlqQSmyiaRovQyAWWvhN/HLujhjQ7RbbxRl3wmqUy10z/JoYzN5EgCFZMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=JZ1njNvKXF4xCLfWIXG5RfHIKRdolahqvNn2HPeWWHbD8mFAzl8VnFO/3mcnJbwTAvtW4DR+rawAUGTYotcVygzOVS4KN2Xp00LRLkmjfXDdfxxwxvCma09WoGvOz1K58GvTsDyqgTDBCet5/teW4XFLYE+gyHoWHXU69l/R8JDnUHB6pFWxVq2jm5LNT4vnd/AgARxGG/bYkyLHvyo8JmV02iBaNvamoqs+pgui1hsAiuLnJ/xUWDel1mC+uVFupaBpIhO7gMkKV3inUfisNtG2O5pcWKd3RP5I5Q3qSsM2yb9c38DD+Z9jbldXG1hQK5jeLGEx8+iUZrxP++Voqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI2PR04MB10716.eurprd04.prod.outlook.com
 (2603:10a6:800:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:16:06 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:16:06 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/10] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:43 +0800
Message-Id: <20260123021445.3782170-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b40c0b-e07a-41a0-da9c-08de5a255d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHIwz/C4YrYGqufBM9Zj/wIGJs2y6uwScREYv4+QP8lVGCq7z8z6NwDfCt0z?=
 =?us-ascii?Q?O3qAkW/35+oAQrJb9DBnaz+x6LEQNRXiPykRXyjRiDeH4k9SL5v5hrwJAhOi?=
 =?us-ascii?Q?PJ9jtmvGje7YKE+8aX0zqmEO3mCiyc8ok1ZsmP3yUeYAccQBvzrFrf4PzykT?=
 =?us-ascii?Q?AELoSoaeWriYxXOaBUFlYEV8KSwgFpaE2NI8vvqPKoqjDTLk3pIDT8nVF4gr?=
 =?us-ascii?Q?P2Pen0WFWSFhEVlgjiETObty1HzlSdMeQTtrlTeTWoKLYHTeRpUkDX+8QiIx?=
 =?us-ascii?Q?3+Xt+yv9ILavRJC9GL0MBjKqkw7MojvfCdiiXFavJ3aAcp0scFozphWPcbNV?=
 =?us-ascii?Q?Lb+z0tbOCHOF5xtbIMhSPQfDXgPkteo+h8MwTbPwRuTnItjYghkU31x5/lFu?=
 =?us-ascii?Q?bVp+rAP/CWN8g2V08mY2TPDFzhjIuktrU9d22ktuolIVcskX09YiWr6+a6QF?=
 =?us-ascii?Q?oZUfg50nEOWsIfe1Ck8ttDJBKxiZ40pT49ypFW6c3E+jktpVyfQypy31B1hS?=
 =?us-ascii?Q?+yIJ8t7hJ0eFl3vU80QplTqn6IWlT44/PUu04cp3WvhPoNNi6FPCYm3y2fz2?=
 =?us-ascii?Q?gEmrM03AkPiKy7wVl2k/WIRvets+eMV6HnXqHuXgji/YvWzTm9+rghynNj/c?=
 =?us-ascii?Q?Xxg6pxkqZgmgS8FyQxZs9Km25Rrp6CuWf9Cy/OteruOvsDx0LQ+Qd8fHG+ms?=
 =?us-ascii?Q?JDmom9aYkuyFBz99Bc4sTYIkeyBI4YdxOQGqqNoE13UUU+G2hnQ4fk5rjb2t?=
 =?us-ascii?Q?fl8UAlr/mkbrMifUL5K3aorQbM1vUwPZG1GFCyAO4rQ89fyY+51YRSAI9rJZ?=
 =?us-ascii?Q?VIe4IIWNiM8LJSY8amdNF3YDqwCrRsWEgtmznlCquU+Rs0vMjlqdtaJV6BOF?=
 =?us-ascii?Q?SlS0/2bi7BYRfIqx0Tvu0F+FcftCZ7+d319N9Isu+3LpIXu5L4NdAWN1GMQr?=
 =?us-ascii?Q?zohGT/x9Kl6xq9SsuhmSzqtRxQMRvNXCobQugM3GnD0ZBXh+F1+rAQ+0WiWp?=
 =?us-ascii?Q?FvmKdl7D2TrxquDLLH1VWApSfTThzO7rq34FtU9ati9o0OZTj+N6ZV8RfI7j?=
 =?us-ascii?Q?kV+gPQSul3bL94TqXQOaJg3Nkfs8/c4/5eVE2IAq4R4MwjZGC1vf9tZmZqQJ?=
 =?us-ascii?Q?n2LVmEoXSq6q68D9xLPt4Qj6x8FlX82rBfEwZ5sLiDEvYUGPMhJz0TmKpZse?=
 =?us-ascii?Q?nWa3fyiSWXEJwcarJKgjbIhA7/2H/WhJi+YcZ4pGGlUtK0jrUbAvfHGtFOvc?=
 =?us-ascii?Q?MpaA13fv2kuy5rz4oeBAsa9eVUXdA0VxTjU3FaoQ+dFDRi3Q+Wl4lYdZWWts?=
 =?us-ascii?Q?z3TyjPMpGePJyue4m5bzqAAKTsH7K6RYSNhVGaBdppES50mg5DzfUE3AmO2R?=
 =?us-ascii?Q?vIJhMCcqn+/YFGF1UaH3NAnimzJRnXt9Ey8cWNpaPmUA7xedxYNCv8q0UM41?=
 =?us-ascii?Q?FObpxllcAgcnVHL/thoOO529U58TReADy+mvyWaMbehkLr/qZcvNVAFURwab?=
 =?us-ascii?Q?9sDaA7kbNQc9CPykhbvNatjZjCiRLf7E99PSHERPjc9wScNevyhr2m9qokkL?=
 =?us-ascii?Q?3hcyFuJlmSg9ZOzkGO4TtwVpME3bJqYBRDN+DjpcuP9qc9bj0goYlwtfXlXo?=
 =?us-ascii?Q?748ngocj3lLnPSG+jRvuRzt1tA5978+N1/+W29mUiw1L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUkS6fUPuIFougKVwSy8wQHUzzuTOQigDQ5tI73zcIYaSZmLBn2P/PD373W2?=
 =?us-ascii?Q?2BfEdpcosKa8aw+fk4h2MxvqnY/mHVQfigtUa77SnMnKNBuYyki9nTSolVsK?=
 =?us-ascii?Q?tVBJY2F7Ijg4mZsHIYmv3Ihb1SB5WyBXjsc1ZQPgJr4c4ZenxQmAEzfYOtEg?=
 =?us-ascii?Q?gkL7rUe+S2ktuK/ZMEsxVl4Lze+QStmXM4ulcBcl9tOVLd9mdTc8a65YlSe7?=
 =?us-ascii?Q?c3jas0BJ6XVtAlDwJRE1cn3S+EqCNmpv+J6Wm6dEIAK7dNUROIlM102UsNZK?=
 =?us-ascii?Q?PTlENEeo8t0kZwB6FBzwbf0pbpLbN8zwYutDzPzMexHNH98eWiAD8rqwrKlP?=
 =?us-ascii?Q?cZVNXywve/UoOLWVA8v20ppKmvln43hhAMHMe8dG+WrypX+xqKVFDVbRh4zP?=
 =?us-ascii?Q?ix+XnsdLM78AKr7cAIskMjklSQVVmtu79St7gVBc49GLmUyv67A76+yE+vXA?=
 =?us-ascii?Q?sNYj8olhqvWVNTJ32SD5Y1qhvsxj4PaDyg1I8VI69EuN0dgUZTN1UrCRkoe2?=
 =?us-ascii?Q?xep4eSgOaIYfeqK5lXFuFTj2b0q6PLUcp/1JwM+B+NeNAR6wHjCbL5csImUI?=
 =?us-ascii?Q?d7WeS51C/DHMmEj6plH7CPrxEKYbMgtZ3YhJkW9aVhEi8RM6i3UfKJ9cu033?=
 =?us-ascii?Q?arRCIwzJ/ztcNd8pwy+H3LChWaL9AudVuqgeMTH/AN8Hr5m2a8ePDmuq5tN5?=
 =?us-ascii?Q?s69bNbfZKoqsN06+UcYaOEG83i7gn6q2tun6puKkUGQEioLb/VsAIGb44JWZ?=
 =?us-ascii?Q?1tq3NV1LZyITeurBVV0jeJCuIXWvw6zGO09JLHsNq/n1vIl6+boBXrWhjSkn?=
 =?us-ascii?Q?4JEhcAhfAHvDe1jHnL0fnrNzLO+uMEgNzErJOlzBIjsOdVIBCOrhP48r6xFE?=
 =?us-ascii?Q?sH0U2L7FQ3dxdLet+ZIJXNM2+DZBLuk2SEZtkL3jauPC7TcUof0XHCVyqiJh?=
 =?us-ascii?Q?ylbPhXW/0Lf+vX6a7nm46MPj9YnQLKQkLgIgBR+XDtWwNF4+iYWry5/T0fZh?=
 =?us-ascii?Q?0P6iSYHQJ1zMSCha0ktbzTT0g+mZQOZDU00I316jV2Cii+tWEpDkZfruqYLy?=
 =?us-ascii?Q?1OM4HzlxopV5RGf+0aE5frRd2zMUOIr8doVIUZ+JHXNVkYed17QfStptwb24?=
 =?us-ascii?Q?seiTkdXJX8T+U4VaRZO+dvpiaoxeb/xq67KZ2bE+NusM7tCzPPHElLDIhu0w?=
 =?us-ascii?Q?nyhI/KWTz1IX5tcvGAcuy2pZALHSgZdlUFLtj3d4NX32goP4jRUysZkZjSE+?=
 =?us-ascii?Q?A/bl4lfzu7QS15DtalqGDWu8UtyuqK/4x8bC11gabciLqKutIv+KUdEvUp/K?=
 =?us-ascii?Q?gCbUBsabMW1aoBC3j7i7Tcs9drC4g7greXmJtn1ETk6dyxRR2gVwTqfTje9I?=
 =?us-ascii?Q?iZruyy0dq/GjnefLj5+5ImLNL7uS4jZzcAvi0xQGOcC6VDhea03/mwKD0H5L?=
 =?us-ascii?Q?Wqb3gc5Ya4bMhjCl4pYQdFTFWHno6EylGFEkvit9Cg5f8BDFL2k2fem/4ngD?=
 =?us-ascii?Q?rgOYkwIaLpc6xsLfjaVZmVhSgsF0LU8XTP+oW4lSXuIP2xwGdaa7RiR3f1mY?=
 =?us-ascii?Q?0c5+RSJeoanoZEyLHUlNKP2AL5NrTAa7QPyArZ6Zy+F93yIPj+IyF40yg5lS?=
 =?us-ascii?Q?6R38uNjSksq9c3BO+S+D94obRUTaPFZ8xM34iovD0UM+9tR5kudia8Eaaf+J?=
 =?us-ascii?Q?rXoEmYNorPi1WQKyOxHWrZrQPllmni3zyZRQZ9wAWLAnYAPu0iReDLu3wYsU?=
 =?us-ascii?Q?hv6unKEghQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b40c0b-e07a-41a0-da9c-08de5a255d78
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:16:06.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80UztuAOq/dhrRcKJrkeGlRr56JQT/dIyiiZ+UjNhYIltW9jPUvZCweG67ubp2NlYiStmd0tNM9ELuASfgMt0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..de2ba4ee9da6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

