Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4433090FF;
	Mon,  9 Feb 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625494; cv=fail; b=tVLMRzeAeVDNzn5Gbqdgrcn04ptbP+Ol+wjvKTJ3CuucwhHuo6xsEYenA68vWOH98Y9O/EsHb+3o8kNRYByQKeb++8rbqnOrT6FEKpDL3lujVqtEMQkNdgJ7eRvSspzM31rMEClAIisDpKLI8wh6amhvoTKtTo1ussJzWSBtvK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625494; c=relaxed/simple;
	bh=JzAh4R/6Uc+iZaymM5PvLQQ9CaVnvghTAw3BGlqR0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYHEjjTtLpc7L5be4Y34Fvp3zNKhZSpQdlvqQUVZdM1HqgaZUm/EYr6sfwzch+5Nri21JkzxMdsEUiJv7X19d0V183Rb5nFzQk4zlpXvp99AfooOgrOzLbb/vv/m2HikC29e4wWaFDwfEn3mySOxKpn8rXQsqApcF9GddKYsnb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7kE+nCY; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7kE+nCY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf5UGTVR33XDGCgPVIhU9VU74sWG1iuRGjiwOw+ANq9DGmM4qLifvt2kMhu3xJd6hz2jsRIzOfYgUYYRMoNUBaLaYwD1uDjbfCCWelPZlXM+Qoy+Tergtdm+MxQBr7z0h8Q8EfYlwaqcsOHt/eLp5OaGzsoYMc0P+VqQFsu0sMXsifydPkptzuBlTxO2Vk71lrOEUP8ve5HMgeWH497NFeKIsUZC158fe6iJZoy95bT8YyOr0a4nqxxz/qKYbZhrcNZlJjH2MjZMkaaqKF1SaPf4IuaZT7WMu5xlMmLutepAPeSeEd7L9bWROJwXZepYem2QuIxPhyabCMzY6MDqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=Qnts2HigqQMyM1lfoRZsPOwjfx97Jfh8Tes5WYKP+/Q3y8bw/+i9q8P+1IhcDxR4gR/cscIlu5i4UeVsSmu1MsVUvfDyyyLWKC4NI55o8taHhK2hVMSpymxY8sMFmO9MQsVJdJN4I+tILRDbmhVP0JvYW/xJiSpIyPHAnqK+VwASeKYHu9jFKn5V+xZLovCEFjNFC3JAlJSrgG+DwEFQA1pKXWZmiY0JncEIFXfsVOynZku55lMrEFld/5G1zOP2pXA9UK6CJQkpQVkeW4ombdeUJZDlsDxxKPLQ03YnsHVFs3iyruVgc1DNAVSWCFFA1dKVn2RnuqdBrbwfWVtHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=i7kE+nCYGNBAJGgnxZ9gqKWJNPXsk8jIdJx5JzNy4ZwO0t+h0FJv6TNcVoccbtbUtq96m5avJJQFvBAUeGVQ5w8PvlTwpzXzq4aJ/CNYFVDRth7Ftlffei5rHN8hqlCWzLpwrkVCpZ3+bHXle+3lGoKg5WSoAN5qS1hhxH6lSsTiN26TH4Jva2UAd1Sp8Bmc+gKq3QJSi2js32RxukUEc0BCwxhBu+HYzNFHmYlHHxpLMghCIP9xE8jB5Wq7hvgYXa88RgB5Ea7Q+3whSKpCdA+Exme8HW+FFjOD2pyemKxNBEZlduVR3P/Q7+zsX7rhZ6GS2jha7/HXY/qgMfZSDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7180.eurprd04.prod.outlook.com
 (2603:10a6:10:12c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:52 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:52 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/11] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:53 +0800
Message-Id: <20260209082454.2097628-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b3bbdb-8eac-4d1d-6275-08de67b4b26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJo6u0cW3enDGmU2v11zQKOMJsHnG8BKmf0OJQ1Ad3qUUWxoZxCdZFjoUQ4Y?=
 =?us-ascii?Q?uAO8675S4AIhyThFarzOvyavfoXe1tnH82i0uhwZTu8673TTUzY+nuffVww3?=
 =?us-ascii?Q?fBda/vyDoiTCmjhqSyf0tn6+L6F54Jxr4iwMLojqUCrIYUqtIejnVjNGlu7e?=
 =?us-ascii?Q?4HUjcBDOfWd/sWbY3HFyytN7TvsvlmNXC8YFP6P0FnnFaSZ3nNeXDVkk/zNp?=
 =?us-ascii?Q?xY1NDPMa75psAXOgq4CADks56c3YEFtfLsmN/RtHL2ziWkvCB+bnYkyxqOgK?=
 =?us-ascii?Q?8jaagbD+fDDsiOP5J3IB8jCl0jiFRCm+mWGFqO+msvDuN+D9f/FVQIi1HHpQ?=
 =?us-ascii?Q?LtmqBSWet7iWKdBY+OittrXkE9TTGwvPTo2+RozyAXxuripwf4jo2D0vX8uE?=
 =?us-ascii?Q?dle0yCbPGiwwRq94Z33S2+Luvo+TfCiqba3UMRrxxBDGWaNw3qsdeen00JM1?=
 =?us-ascii?Q?5jX6b20fIjjJMzmIgyqbGUH7P4R5U5QDdWrblKRbwG73NjVSWW/1WJnn6rLn?=
 =?us-ascii?Q?rWajP6/UQUXkBrekly6LBVGKRzdRn1UmdOmFb0nBbpJcasxd9Vfk8ZvUPWK4?=
 =?us-ascii?Q?jPc2PmatrCEpp/dPLIDAenwI/oi5u/z+4smrmHCShaUsfoQVqLSuzjdrKPq4?=
 =?us-ascii?Q?p6p/ryj2YQxvTYhp9D1oo5qer8dG2yXtsFZNZhXXSYQdc5PYN6VTcdpCJSv6?=
 =?us-ascii?Q?LkUAyDpV7HrIZF4Zx5MNN7BWGgem+iXiFpt7mKOhnKQQAPI8jHLRhhhLLcAg?=
 =?us-ascii?Q?inEny+Z/4kse5PAI8dDB4Q4SjijSBh9EQKbrzvqvxV6j3ZM1osJoAwb06Dg5?=
 =?us-ascii?Q?j6UPVwLiVZgLJeqy/s9li2AMn+XE0mo81U2m9nUZ+4q93PhutZ0Toh51Bxzw?=
 =?us-ascii?Q?aTw7hNjIhWi0cx3834UD4LVUGWic9VZ/JU09mU+7DxyWlCVdo5ej/Fs7Y9Ra?=
 =?us-ascii?Q?aIfBzIFtd6uzQ88vGe/lUXgOpq9ZCgew10x8t03n3MpB+IJJfdTmq/Rmh5RE?=
 =?us-ascii?Q?n2vuVkVjx+4Q/OAbHqY246CpXbuzl94FmTeFD5YoaGfzy3+yb/taor0HRRVt?=
 =?us-ascii?Q?s4ApfrYNX1ykVlAezLBQPU47icEjcK31LkFtydlLqizPkaxVfrd6H2xQvHQe?=
 =?us-ascii?Q?6lOfgpV0BTiEQk1G8gsgcDw06a3DlPxlAr+8eYXZ7O8b+c9nsMxVJ+N1lbtx?=
 =?us-ascii?Q?+43mz2SFLnRbGAv9B4h8pPYrkT1fYP2k0z2z1q2N033UYXSJtxJSH1blCmAV?=
 =?us-ascii?Q?WQqg1fhEmFS3ihjK4nWu1xqhMNjHn6xzKEjZuwoPSLPFvqitekbhS1OtbGFX?=
 =?us-ascii?Q?qgvRDKBaM7isj7AMIGwuGsBAdgXQQA9QAcwbyxBaTaU8mdVZkvZMXiefxZrB?=
 =?us-ascii?Q?AtXWoa+euOdZwAx+piqR88Ps/a+Murw2tYl4FvplYl7FZPO1CiV9Vjl/tl5I?=
 =?us-ascii?Q?iONiHZy3ieh1FNBZvVyVgbpylFRfl9Hgnd5hoOAr2IOn10k3YJHUzgL6Mr1Z?=
 =?us-ascii?Q?0wtIpnIp10lqJqNfdDipkyuAhoxRHzeQeEsobeC0wYe1XyaVJ39JoHnLcnqX?=
 =?us-ascii?Q?bclGHtmkSBl8Uo/hTzjbTSpWI94Vnzn08XU6rVR61ymJVLZ4S98Z3/NyabEx?=
 =?us-ascii?Q?At0ZHAH+2OPhGk07Qgh9SXMg3LvIPLBY3bxKeRDvkFWI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+cJkY+Ue1/T8N/zn5BqLFnRiThfbqh/WNvqNhd6BgiHXfmGEVy26/ZPhBBc?=
 =?us-ascii?Q?8b5TmBOgv/D5Ogf8fkOjrPPXBHZmbCiVJOmaKLvt0y/OzQT2oq4VCEx7WOR3?=
 =?us-ascii?Q?iiq0oD69L4XBq3G+F9avStoz1ExOi27DvZFhI8PBQTAtys/M+Upfmr0QA+Uk?=
 =?us-ascii?Q?HwfiRQ/Air4FEsd1CFK8GEZwQeFCkjU/vmG0D7cyeo3Mh1vDaOOQ4LDGn+Bs?=
 =?us-ascii?Q?VQaZ0RRk/dG/BgItdQkI/7uKR9DoZ/rHlr0KZdKs4S+XiHcUV2Od7gzlJx5H?=
 =?us-ascii?Q?tk5Clsj9PLmwht4MDLgeAhM/mBuPpodR/dS+EY9JZyIbe0jWBS8OcBt/B8ln?=
 =?us-ascii?Q?1lkGlgBwTmbXoHbdQfcjsIospo1UVM3EVFJQs8vexm/nTeN0m5DV8h9NFybR?=
 =?us-ascii?Q?kAEMkJjsiTlifC2tfy34was7gAYB3YFtTth5pAVTYk3j3qNgLyyrVp/TFJTg?=
 =?us-ascii?Q?yXsougC/l3ZCHGL7yU3ufVTr0OQsod+nJjvoHqNFAFz0t1vWDX+66dSHCUb+?=
 =?us-ascii?Q?JDWBVcASN2rK3x3zyZYCXVKYelLYsk2H7rdA6+4TuFMIS5Q9W4hEPJkjrCJv?=
 =?us-ascii?Q?w9VCdaI2l3hu9UZnhndHQMnUfNZsHzv1T2IQziojqTHU9RW0Wvghm1A8etBf?=
 =?us-ascii?Q?B7EmfowOiSRmXQWkCO/Q7p/HA9r9YIsq0pWn/gzlBa1tjaOAKj4pibDWulwv?=
 =?us-ascii?Q?hZ42jaoX62acZy/aKbN9b2ukkt2VxSaobtFln3IhMp0u90ULS0r22EB63IwS?=
 =?us-ascii?Q?aodOw2qGCxHnTSZjx8ak7vpL4nb0kauBg9tcz8mXBb1cj1byKmY1atkTKbZH?=
 =?us-ascii?Q?u0cCKrIHNZeddNsmJcFZv4nh0/grm3WR1FIeTLkCx7sGNoSUBeUMQC/VX+Cc?=
 =?us-ascii?Q?YQv5/+rTf6P4foGILCAhwVvCDxNbAwzIuWLa3rYsqYx7xgaA0Mx4iWR+BQTD?=
 =?us-ascii?Q?5rwJq0pju3jG/+zPGUOle4uwRoD/agV1eYD5GrF7McQ1yZ8ywgYUvsPMcwIH?=
 =?us-ascii?Q?EqrTEgzUBP8yh0h55IcFUr/Y4ZIpRaj1S5bhiFNEmi6DzenSp4+O7C0se5qG?=
 =?us-ascii?Q?Hj5muvL02cVmU8FyXj+cDd596jbsCMyPi6Y1AzfFk5vNyETchgQ67/h7d1OB?=
 =?us-ascii?Q?7+NOgVI80NCAelnyHR1X+mg9t8LppeQtcD1SSoeMFvng/N/RhpCOhJOh3Vau?=
 =?us-ascii?Q?+kNcbyZqNSvMZNjP5jhqcCOAl3x9k3FSlgfljka2KLW8WLUenftBPNfQyznb?=
 =?us-ascii?Q?t/fyKS7UdvQofXOVVaSpOiz+GHNLLugd4zqLh7D+J1tFwNtPinRNBs4QArVc?=
 =?us-ascii?Q?FGmGg/fYAEdK4bjZ9pRmx0GBumng/bhigQLR9l8Bp+ryGT3pIIz4ptIG2tki?=
 =?us-ascii?Q?ZzK2mxpv88bTraCIWJvHEm+Qw+3RfbKp5jPV+iUVXiRyKszSJjo2ZnirOuWd?=
 =?us-ascii?Q?MyFxZs/QqFZAo4ZIUHOBPKZU+SA4YbETRA8H6Ua4HGuKP2FXTBz65jvU4POs?=
 =?us-ascii?Q?1nQzC3vDGM9VDeiRhOnfYaf8j/LUWB+saUfZXxPVxS56NtQUmDj+yFLQXVMb?=
 =?us-ascii?Q?jb9wcWDp2LeCBKPsOQrvzhFW/6mF2UqtV29vWv+SQFrvQXIa0Y22sseiHuAC?=
 =?us-ascii?Q?EYNzEFmq6+H5RTNciRhOdUXoanAgs8h9LcNREJLVTUbIRfY5xmFIsy0jWe1b?=
 =?us-ascii?Q?RPCd0A2XtHKAlMYwYDvj2l9mep04wJ+QxXBVwADG6dIx41XO8WbxBlxtupfk?=
 =?us-ascii?Q?smXSX0v+VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b3bbdb-8eac-4d1d-6275-08de67b4b26e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:51.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO5U4V8kxBuaHQHWDhqx++VVSyp8nlvT1L46QN1TaBkIM/ZCMPABKqd9saUmn1/4n4YYhVFOAkBg0OtwL3Y56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index bd6e0aa27efe..48c29c2cfe8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -40,6 +40,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -90,6 +101,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

