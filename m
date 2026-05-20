Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C6375AAB;
	Wed, 20 May 2026 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266888; cv=fail; b=aR1/Higl6tKvkdy72zL8qFL8+jK24ifhVzgRFbC1SP2cIosUu+gdFkczqflcbgiDf0tU7V6TE/gkVFoYTNkBwRRtZmVCBXshomNohDCvm5TqJ0vv7miI5YWm+Dx2WGDZtTvOLjMTtzb8LPntxS0ooJtakWWMO2dPKvw+XzapFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266888; c=relaxed/simple;
	bh=TlOKaEGUV8JZaP+/V5HBThJcjMJUwZ1RbNPHEWzep+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caeinOb35MGriUKpl7o4h+kdu6AttktMPen8Fv6lcwEmVqgQV45zwuP/3uRTLBhFSDCQZXCnjaSdPbRp7zgvKED2stcJmwJsqbT5nHtaWhprYy9QxNbfMZL/lZ/aaLPEe044l1okSFcEnNreiSpDqMYS7ihFCNtjjMDNv1Muf2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UBgKZmDN; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UBgKZmDN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1x2mXYUrJZnCUQLfrf1S3/ie9oTeJmdBTqYICulFcQ4ltR7e+ckSAwbMWnu8ntk/b+ttkJI3UFgAH9ZyR7nwwyksvKUF9BRuLg765onrE/n7m3bysf4yQP0uOMrX7lGRwQoy2W5a/ISubLcNZEA1vj7SnTlzDN4cUgqiHUtuzdvRSsZpJ1htr63kYGMMc3wmDbzkQfmBMjmhWaJkZAw9wjIjSeHm5ro3bmQnxzWODd8bWMNh+hQ9FXajwixpkQbK8Ajm6+TYtBghgCoY8HKfwuVkPHPPt7WO5/RE6zBS+eo9OKUSJZoKJKDQctR97yg6fxX1AOgKlA7pl+pq7Q6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnwW3DGV6qiigyi/mQkiWr4HbGAkXh/lN/VfVE22kOQ=;
 b=Y8zL9fS+T5CHw31jHPuueynoAyCZPRddhYHj864L1+bieLOn1VuCUoCI4MagSxNs0LTGcpR6DVc9LopEGUFgAmNOeN3pSzOg7BgN9Gh+rJdf3TGRzD4ZOlT2bPRXVzgUh4wePyxq5dCH45+k25NUyd+RKEtYu6JvwUzeusGsCZSvraR01JalxhQoyMrlSbDKt9HxwWFM/ZZNrWgZRFNncrN//M1pZYbaQjTMwSQP+BLIxlTAZV4HwBV5CeVpxRp7EKPc+CpwMpwgl7NHIbvMwA5fMg1i+J70lGs4D0TkOeysEC4qpwQlWlQJDdZ3BUgbUOc3xwnNe38jM8fq+YlhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnwW3DGV6qiigyi/mQkiWr4HbGAkXh/lN/VfVE22kOQ=;
 b=UBgKZmDNdRrfq/nfOW+ZhhonR7gp4ZIAfF4lRXi7corSnGX+4in20lcweAkmxZ04KuxQc6kMlXktAb3+ZZpKDTVPHN3r51Mmd2IrGTcyw8Gf9Agsc2FXGhbVLUF6Zlmlp8kQzO46jgWBorI9HofLaRdXxWjd0CCQ6mKQeQqBldS6texsS+s6Bqkd4LhqoZCeqsnk7x5tvr/B4g3qcy31eRr9fFNGflfyxZnRR8BmnLJ6PZsBQC8Ly/T6qH3TQi+BgJN9iTLsmnWx06weDHQkEaSZ7GA31pntKJQ22KHHzedvv/4wPdnFP9b56GaSbIJj1DMdkH6Ts88bL4K2IE0cgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 08:48:03 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:48:03 +0000
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
Subject: [PATCH V3 6/8] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
Date: Wed, 20 May 2026 16:49:02 +0800
Message-Id: <20260520084904.2424253-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 323479b5-10d4-4387-8b94-08deb64c8110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Y53gNB0TKt8xckxFEF0Iy5Zm0UEnVKVSTIDGRWV4S57mvpiMRaRn7XFF36AaYI4LDCs8Zak7oND3ubaCfVGq247N3p79X50KnzAyFPQWAdPAzlXJK8gN9ez2Dqz/cQqbhzyZrZTxSAjc5OYIvXDqjnOMPnoGeWvAspIXn5VAN4+HnPM8Rp0us+KPIPlaSI/8Sc57YRbdABWE/Xdjilh2+FmAV0XLeoFBX4CRpPiQtbuXNJrWFJbimygiLwKTf2xJU97MoXqZi/gtPHiO4j6gp4X1bvQUQ+NRkyDKPmfCqsYa+cHxWObocW3StWaDXN0Hj0YiU79rKWrQNAbK2jeZ8arqsvYwoEVkiWsrMozU+8m1MzzHuZOO4jNw/nuhv0j6YR0bAM2rjxJpLCWLMs4w7mh0JD7jFXBWK4DKWU2wHr2toZjsgVmTQFji81gvXtt8rsqwyqKG0xcUmNsoI1umHp34yVllGwtPyPa8R73CFTvKdwQnPCG7QE0y/3xnogtCZBSeij8lketI7X7Lr65Ywt5WGkLO0hjm+Ynv5oaR9l9OEw4ee5yDbp/jSqjsP2a7R3A7jLv1bjG3/mgFxH3eFdADqxLCd0g7Vw54BsdwaN9dCHhQ3eAFxy7wsobLAzbmyYHqRLfIJ2Jzzx3DpugtlmsxQ6fG8rGk2dQT5OXHqssJfwJW/J+Z+E3CenYdfOsu44YP7z2dfAcy8eGVhitebDVjH5pnggjY97QMR2/K8Zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2W+exLJWww3ZoAYUAWpGQGG5EAxAIicMDagR+VXQIa4E/PPxZRiaTTHIgvbi?=
 =?us-ascii?Q?5D/BZzPTHSjCWzRsU2xwZZJiZKLsQ0xjsEwRevyrz9qbFzNcPXCfFZm0ziFC?=
 =?us-ascii?Q?97AS1WFDLPhzk7tSF9a4xdNShdhD53AppvXhTrhS8B6DFjcX7VRCo+PDAOuV?=
 =?us-ascii?Q?t4yFJhQSLUxpDn3RVOPMF7FUxMVzI50FkA+vIYnp4+/Vs46n5akU7l0QvCpc?=
 =?us-ascii?Q?7BlMdGjLifyjdl18Hn4wXy9TD2iBDirh14MhzzCFiGkSGjWeRnqOchJlz411?=
 =?us-ascii?Q?A+tFSKCi2jE1hMdK7GO+RPzp2ZWNGZFmOSvobkYlFmspy5+jvlIZIAoI+9JY?=
 =?us-ascii?Q?i1o/S1cZr5BmMZMd7OyQ/hROBaNOLQe4niaR6CkOtGI3D4uHtMhtFQobTJBU?=
 =?us-ascii?Q?rphWR348fwo2o4o8KgTa4beJsbTsAsslwHt/NH/M0NNp2v9TEERhjrfLxX4F?=
 =?us-ascii?Q?JVO6KYVrtMv1p39FtC56W/WLgSB1578frWv60Y+X9+iuTEn8ijcgfY2IxoCC?=
 =?us-ascii?Q?T8/pxuR9IEoSAm72iRnKhkWeeOpd9zNYDueFGOjRIixFOYNfuieeK3Fa/HdL?=
 =?us-ascii?Q?MoEafvEXT+dZflf8Xv7FB9Xok6TgLwtxpdb7Qap6qFx7Jwsa7+kq9cj/LkVh?=
 =?us-ascii?Q?xb9LNgWjjeXLWDfG08ITip3zEtzrrc2/oHsxuqM1jBhQZ2EEhaqBi4OvvfF1?=
 =?us-ascii?Q?kuiPA5ia5ybqE7Y3KNpzt6KB/a7YfHCXZKD/Smb/T1wvnO+PnSGm2EhwosOz?=
 =?us-ascii?Q?ftv99+9twhzehaqUeTyGEXJIy9gBSU1+12T4NpiVrS2Co7eh//2+e41ksfMt?=
 =?us-ascii?Q?Eyu1M8YDwTKsp/skz9EogHWVkATug0olRSIqgsdZ76BpQmEGgmNFG7ViJb1Z?=
 =?us-ascii?Q?Ow/CUuzgMpIvfeDFcmKYH419PooXH9Ag4lHKvhC5yL1MQKrwcaXmfWw2BbxF?=
 =?us-ascii?Q?NbVST9+/hwZDCVl9Rfej+vok6dwE5fL8AKjoVqpfxwVO3XghkVFWt3+J8dut?=
 =?us-ascii?Q?ns4WvckC8biurGyAt9RrLZ3bQ+hjgwpKm1u3yqQ3+VBTVUyBsAdocs9ZTutn?=
 =?us-ascii?Q?CnyUGI4yiOFTVby3vTTcE0v2u/uGNiPRdr7zl/kW00W5SemAx97Q/OplTee4?=
 =?us-ascii?Q?ah/oE2wxOqQarzVyDqE0hF1vUa+1vB3cYxewjAy7QjF6t5lacJYHC6Me5scB?=
 =?us-ascii?Q?u2Glklx/t++bTP4vIrYICwFto9XD82UvNztOYIRj/4S9FBd7LXLGM3tn7k86?=
 =?us-ascii?Q?9AhUAxmHUhVTHHyJY4Z3yMYPuF1rVPBcU/+MJ0Pjrfpn4hXWzrFA7rHobint?=
 =?us-ascii?Q?uIzqH4nfD6Zma53SZaLyrsrZAx9dBaGSLIBa3vizMTHjHIQ0s9bRWx4x7ls6?=
 =?us-ascii?Q?IAtB4F2KsbePQgo6RASinkq2uc7mKUZiByEcOJRRRFyEulsew96MGDGn4tkx?=
 =?us-ascii?Q?bpW6VDWmKXomXwvXAWXOfCjeSfnNxWA840bVCzygvCaesvAuMluhIHHcHrUT?=
 =?us-ascii?Q?Wf2UG9oAG6YPNW0aSUtfD1LZesLKu3iOu3SnOfCG35f925UxzqHvn1KSjcEd?=
 =?us-ascii?Q?EgeSzZHwNYBCGt4c9Wteqsjl7j68mZNi83BXMzgnUROPKgALkKxvjfytBw2E?=
 =?us-ascii?Q?qwHM6ojKgRGWZP4A2snB+xenhK2rmL2SfkP5TONCkwgJUkF4syQA3HwuJBle?=
 =?us-ascii?Q?qPMlHwElRBkGYyxxvdXrnfr3x/t3VUQCbp2RadGVz9P+/RqqiYDOjUQ5JlQ9?=
 =?us-ascii?Q?dTqPKVke2FxTB2xUowhB0VhX8RWL35z1G/pFjb0XwFvmmwGGleNi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323479b5-10d4-4387-8b94-08deb64c8110
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:48:03.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veR/xqljXOAJtQZqLzN0Ae8SGILUGdimKZuWC8UCkn0Hv+77csn1zjRsYRBxtv5qQUU2GZbjbP8WngRrKNeV+9c4DkRIMqcx0MZt5ZXPXKT87nXGSzdX7yQcC4SxQWaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

From: Sherry Sun <sherry.sun@nxp.com>

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

