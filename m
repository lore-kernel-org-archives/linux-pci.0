Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE912D321B;
	Tue,  3 Feb 2026 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083769; cv=fail; b=B5njROc4aViICtribXUrBNaBh/atgpuKCxJD2ESW13ftHVbjcr/XIAH3UQMtQcUxAZdBZpYJmMgNBfZZhjH501eZBONYFPwse6KhQAkXIpk9W4WyDQqz1bUBkWBkK9hHvFuOZkcP0OVwV0YHkBiAb1/4CX9p0csE0fHGyllUPRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083769; c=relaxed/simple;
	bh=c/gn1HlkPHMkjtsuvTDG57XBRjv8qGy/sdk4nwL5qho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4kyD/glenhU2SGzvDhjl8KupcI2zI/mNLJBYSd+YWT8ZSQJHzyclm1yUMu4uWmm5WgMjXZnDwi4wXaueIOhwcVLugt1jEFvLC/aFjtACcg3wvPE9kVUKPyKUWYzssgxV0GtBiE9AIH9LZy6eS3M9Kte6BENZUKJznvsVPmxzZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HSwGDE6y; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSwGDE6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1EOF+mpuzLX/kwKZOoEzDk2uMl1bqyfxde6w06efh0MD82nj5gA7fgiey4ma3PUjkgda9koB5lcXzvU6X+7sXiWQxOWFhHkBvrBpZ6jscnydfGMMzepX5JUlxFNKUZHk/+18eGvOa1EBCudthrTg8da+RWTZ659dtxe0l2bdAWnZYN6GWAEHO41zwfywg2wAZ+UkkoC2oiOb7T1qojpuRM6z+jUsVDhJ5qlY/jH8J9TAvtIBaW220oBtfJDDY5Apqrxyur8bck33+un/Qb3nBWwsd9GRGmq5MTDTeUlmCedty9kxB+FON5BGqYNbeYnrWeqG62hOroqA0Kk56Rqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=sAFp7wiNiPTmi/U3Dn+mwf1veNQjI4qA0sf1l4X1lmhlkt/6DxTFvADKNTDCQbwQQkmFbl76Kj462L2iTJ1Na1xIhcxkmQIMOKIFbsKb5c6hHS3bEpNd0tMvekPqKjIzSgbPz9cxSeNntSEJtIQN919qAEdypxAmFzD0VD0CfRTmr+fRsh0kXSpN273IA4wE5JR0FAO9vK0pBuxetbraJAh6CRKjY+KoYsEztZkt7CX8yrmdzOD5ZELtd6r4N+PbWjMUrUqXylaBdYrqNhpg3XNQfJK71q4/LI6uIzZS6xu3s+e89ADcs3zvRZPr78t7QoT80J/pD9+SJ/2MH6sP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=HSwGDE6yBFjPaf5lilidO7pqd1rk328VBNC0sooGlaAS703BOtsgWD5/w1dZQT6jgFpjHNSRcslCq1GuY1q5I2dEUQl8WNPeO4UDIfMeA8/r4aiDqt6JYihKc7VSR6wnkUsd2cciFxiGMW7TQql10WerQ/mbvwvktCwhAXPC+0IGcFWu/S7DT0jhXGwQmCcdK7NxKoOBNLc4egsk6iSp4E2WSp+PbM7cS6ehWz1JGvG/yeZ22k7pds06aemIXcquDCbDLLgX1zXJD15ZoyIwYBXPeIvgjO97VOoRiqPw9EGtBAvZ7qL+JLtEoEBJLiXgDpR1Di8E/F3djZk+GnVtTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:56:04 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:56:04 +0000
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
Subject: [PATCH V3 08/10] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:12 +0800
Message-Id: <20260203015614.2957479-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 429f5685-1601-40c0-71c8-08de62c763ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3AJQZ1U3XU4xd9eyw6DDEuwV/F0iPdUwzGa1VzcSjPioYc0jSgEtZMVnq2O?=
 =?us-ascii?Q?shsSuUIChiwdWNLUEksQUL8sLFqFF2qyDbWmXtnE71f6B2+aEfu/e5x83EYS?=
 =?us-ascii?Q?I3ZITn1zMdTI+1losCwUj9N8ck3kiEPUGmFd0B/xvyO2LA4qhg4Zmvh/vrJb?=
 =?us-ascii?Q?d6KABo4c7mKQRAYbEb7Ekuuqgcffjd/guZ8scviLvh5OtndjaW5PA4T61fPK?=
 =?us-ascii?Q?EyNR6RXCFT5oY951lrbAYViLjsBVZCaWlEUg6laOAcaKMaphP/c+oB5EJqhN?=
 =?us-ascii?Q?l37Ww6tLQD5QZVrakFx3umwrMCdG5I1+III7jkmhJjSdozhIu19aZ6OonscV?=
 =?us-ascii?Q?S1kRol7M2hhoe7pFq4QODGcYcf1geSINQHJn8mTPLjzFlJVuurT3mVAuvsq4?=
 =?us-ascii?Q?M1cMNgyNsDxtrul7JJEJ4XVn+rIuCbnobOzZItfnlKOdQjTNTbGhSuhT7AoH?=
 =?us-ascii?Q?ITnvjAjca1+6TY595xm0k+Dww49FNgYOAyOM1Nv9dl+CPQ7527bS0nMwVGtg?=
 =?us-ascii?Q?IoHKtx5pMJCRo5iVUR2kv0w/YA4MciDvUGsZpINFsRX16mNctTbptas2HC6U?=
 =?us-ascii?Q?uonUAyv6VN720HnoiWVjbtR7XR7UPQao030u40I++hNJteqCTRVnc2b4fznb?=
 =?us-ascii?Q?ahBLoEesV1c9vCQVqWtudjICJXqukp3t41NEHRah42i5maXJclmHJ4Ocec5x?=
 =?us-ascii?Q?aGyMENvr5XpX9w6pzMsQfmBtzz/UztGJtE0VUj/4iSOmEMM1WnOQY8zIjEDY?=
 =?us-ascii?Q?cJS8Xjq0a2I9AKG0ed6Ru7UV1unqob/OvyWtpZ7mAlmDn3TRXvo/9Dtxd8VW?=
 =?us-ascii?Q?3181Rz2yaOLtQ2198+x1syn42/N3zuapq/9MgzO5b1JJy9yt9LF/NCXRCaxu?=
 =?us-ascii?Q?YK7iglmIwFthXDv780zka68RomTDfAosSiA6TZ7OZFSKqWAf4/JlQ3eU4VZt?=
 =?us-ascii?Q?jknJGfMkwSouQFF3ROXBOfZirdeip8fQK11DUL1WMkJebuZfDSedOCieAMJx?=
 =?us-ascii?Q?PYR+TFZseYbOmJu/On7FVmRfiqO3YzNGRptNuIiHvaat1R/iZTxNt0C5M3t6?=
 =?us-ascii?Q?swM3n5NVo65DxAcRAOwF1MP5usKOWNYd6KbWjcyUuX+LaoJMFi7ZbaAE9TSt?=
 =?us-ascii?Q?h55C3uXoGdtWiQM/Uizzbkbcwh2sgmfzg10x8apY4GyqYERRy9dH0UrdSA3y?=
 =?us-ascii?Q?z75JyRxvpFAZnHYSnVAWNLRwEv2GilP6jdIn/93QxovychVTj9Wwx6/XjzfR?=
 =?us-ascii?Q?lKUNhN7e2w4cowiqDocfALqb4N/xa6UeJBOj5n+/0Yhtcaah3VlNb3CTICKd?=
 =?us-ascii?Q?T7vUcHCL9Q/2QwXUBrEOyL21DJPzMvitq9ig2TL5HWA+l9BA8EHFPoNOCf3z?=
 =?us-ascii?Q?xb2wsCqVd9aEE+WRrqSnS98VoF6EO6/vEfr4P9dpPW23dG4e5ycBp85hyMvi?=
 =?us-ascii?Q?Q8883icP/xwV7CokPMQ2+32TS4Xv3L9g2bqyHdGkkkuGDCLSG5p/9Csq3zz7?=
 =?us-ascii?Q?lPlAiAC9ccJkFkAnINeq2cSqF/sxdFGahKlkgYTyvkMseL2XDhgSeL8LsL2Z?=
 =?us-ascii?Q?Npc/lWypi0Hq9k7loEnvk51dPVL+E7V2SiK08VeRoR+9xud777KbZl5mkU4X?=
 =?us-ascii?Q?DdmpjKHoHdbsxg4rV+CYBC6Qp4x979dq4n7e80GjqUxl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g75P+bWWdF8C3IvsEKvFvzHtAXR6RRK6RV8J+XLJTfLPBeFts13T3IGfkn7i?=
 =?us-ascii?Q?sv8PFIVAZ/hUZ5vfpk8NAv9+mMeiYtTKQOSwyc1iOJdXn+H+av0BL332QjGC?=
 =?us-ascii?Q?K/2D09aj4Kkf0c29PFfyEfItAPhF4aDv5VMx/xwRaCiBW1ASf+Ad+Emid0hf?=
 =?us-ascii?Q?Z7uYft8LzYkzNytU97NAS3T4LQMJDW09kOd3CgD7itjMC9vgU8keEUpP1JOe?=
 =?us-ascii?Q?uoiqI/51RzstQ3aC17HN8LFF8Vqf7IH1E8oJ2XLiSHVXTN9Zg0YAiztnJEOO?=
 =?us-ascii?Q?2n99gDIg5BaEobLVFTd+HxZ7lTGDs45U12cqhYgmdP4vu0Kk3kR2BQeBs8X6?=
 =?us-ascii?Q?VJkt4QTxVlsHeVg8hoF7odsxEBx/cjxo04dGFpn1vMRPS2dkl2/xM/cIPCm8?=
 =?us-ascii?Q?gXX9WFrc9bG6xWlHm0P7PABWOQ5VIwynyKGi4GspGGbkTVkSr31UnD6PsaNR?=
 =?us-ascii?Q?Ih/rEnH2MR6neyotnT1q1mQb7tZL+2yrR+7BHYu+DfGiMIrBh+UqUEalOfw0?=
 =?us-ascii?Q?c35Mo2ULgQKKQhWj7lr3GhFJtPUc7G8opHhPv91Zq7OnsQwKynpplZIKGZNp?=
 =?us-ascii?Q?HaiSiRHh8p5vXAJxxkhtZZJ9kJwxF1MnlAwaQo1gmS536tcLipLij89rzBDp?=
 =?us-ascii?Q?dXpYR8mIRj2rvU5ggo8zqMUheRW6WN453C38XHpqVL5wTDsDpRzRLOtxXmxC?=
 =?us-ascii?Q?v41bwQLccCWS037d4HE4WRLKziwo0KQOH1UjtV6TXx/NoRMYdZ/1s/SJR55s?=
 =?us-ascii?Q?ndb6K5YRPm/zqQmoCJU738qL23e28dqFvs5hfcJZkSgk056Oc/5u2eReJLra?=
 =?us-ascii?Q?rFFS+j+IjMIFN1+KbI3+tf3VmF3PxBVISz4kAgRk/iGyued4DZGhxrd/Scr7?=
 =?us-ascii?Q?ecqXXW8KoVxLMIFTSXHgCTD+UZAutAhYkp6/qoP2C2gGvQ2leNYPc1RV49fu?=
 =?us-ascii?Q?j5LFP8BiBFuzk3hTU+oy09cQRGWlrR1RZ1tMrN2uPVpU9madKMRuBm4RGXaB?=
 =?us-ascii?Q?popRvEZ0tFHnKDSk3e0nKVorWwbVLSpQ3NcpeTY37slqKsVoLPXgaFWaXdcz?=
 =?us-ascii?Q?onSZ8pWiFaQ0aZov3QcySnP/TqevtGjOaFbJlFQZhLnjkmjz1qKZg+dx/Sek?=
 =?us-ascii?Q?G3+CvoppmGLZA/+BZb7Znl6EpxRuKXAPMG/13rH7cCU9Iwnst7EtSaQ5dCIZ?=
 =?us-ascii?Q?KN2ZTPyhxwBYYa1H0WcCHpJcrdK9PZ0XsA+jkt3o5lWgLo5VnzX7cN2xGac+?=
 =?us-ascii?Q?Fh+VaC1OUxbW1C5f5Q+/5EIiT5QWeajgybCKflWlN9zF1tssBkzUNhhZ9LM+?=
 =?us-ascii?Q?U0GVLRDqGctPz34r988ADThiLkC18Z0NO61HjCkJaDFWuNNIAAmAueQYY2O9?=
 =?us-ascii?Q?1JMFLnGBDqmk1m7JkGnL/pqVKlxBlQ8YyqduJxEKbWy5lfSIoR8/fq44ttWB?=
 =?us-ascii?Q?Mye7iTxZps+fZJVuF1ttEUnvK7qJ0bPmfLqfgCIbNM24YwCyugisH2oLSmDs?=
 =?us-ascii?Q?tLboXYJiXxZ/OE01O+CqWFZf9ONkMl0IpPWknfVpUlGN5A5oYSUTxq29bTIF?=
 =?us-ascii?Q?9yojLhMlQEDcFvgLgMLD0ZPcB2BgCDl6F7iednkgmecwRkHJmQeb41/DpKqI?=
 =?us-ascii?Q?KyazEwvtx+iXRGhsBQoPnJUA1cVtY3h1snc2Gl2o0ax15nq56SQji9Fv5VbT?=
 =?us-ascii?Q?D/nxqqArZ7E3Nu4BSIADFAwgZy1OQLZPef9gXp6wbLg8Yc0fOCG4ng7/Iayo?=
 =?us-ascii?Q?Ru+JmExIIw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429f5685-1601-40c0-71c8-08de62c763ba
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:56:04.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3x1eEZ2qx6wfzu6r/2GTYJhr7/Ace857/URGj7oiPoTOLcYLdNgRm8p9GIs7yz0YlY33OkajgvWKWRRah2Wgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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

