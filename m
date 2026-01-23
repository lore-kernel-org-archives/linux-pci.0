Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AC1E8342;
	Fri, 23 Jan 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134568; cv=fail; b=GmQKVuFSRJR9d3mDTa8Z4iaSmiC9gZEkbJ6WTuHG/SYmm8rFQ89MwL6zQ43kctbFzcuL8i1riQyMG5TUM0lmUKGiSbvkMlwNI0Tm0gAhgAwCybyaF5QX2sYKE7oTeJR3C7W9PUIAFvx7W6vre1Z2pYvwWhRbU+bvydZjbsKiKKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134568; c=relaxed/simple;
	bh=NJLIuhtKkxq6qsQOxtKT6+mzMLD2NWoYY0qcvHn+o+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUijI/GwWUFXa2XQBMx6yHn328WBeuhYDHwWZCoiTpeRyYYDUnaGTzUgdls1plIzPtagBIzMkaSk9qWcFfNooZKzbdDbDaIP0qm0uxl/grJBo1wIGgOGXvYd05g2WhINTYHiBozQoHHHPcVtCp+uerhIp5kk1jCZDixgkrr8h84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UTyP5MPp; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTyP5MPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuSWP1UVbeKcYT5FE8pT/OA5xEnujfAnxvtddZ7/f0bA0SDwtNaPCOPbJo7VkFrE4Y/+JVNcmRxFEPJMiho7A1BnxxgDD9MY21UvdkrL9/FfT7VTpyYi6nWIKjAwcXvEw46NTVadHckttYEL9XCTzXR3wmkdHAclNR5SSt7hrIwWAccx+7i6fWT6ugHf1bIbUiIrcAyWWfpTsVXPZ2oegtxX8heqr3MEBaiy9xK2T63L9F/R5wfuuOZMvrIgzqK/8Z40SHvDnehsQdY8kEfeoGGL08FWgQWLj+GeE5w/2MRc9E+fl5dhtbp8WYicS0fhJqRpIh1oPHZyppDH99X8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81jS17UlkUv6hYNct8UfJ0If5yj1bdGLUY+kS7SlRhc=;
 b=nxCS3Btv+1xDnh0ODouf8VgTLosB4yyJhjx19o6x5cntu4jXjcyYX417+5sPnHO8a5+lp5uss5kuZw58D8dqPmO2aygGDtry3aMF8WlTxvRycf92+jDrctHdk0rpM+rJ3GxndX6XT06pVKrr2p2pEKfA8Uzz8eo+h+2Kafj5QNS7xX8g0T1WUrDazZ4ue5kvJ61mXscFvlJz4/Do7Su0btZ25+y0+oyRrPOP20aDibrzXYvWcX7ApSDxks/xDWfEbYr2RxTaABybJ7HqKUOqusC+VMmxcX76y4hkMVM2tVU0kfw18lAR1F6KZZ2cJtHY2iUX/DbyICdAWf6tDs41DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81jS17UlkUv6hYNct8UfJ0If5yj1bdGLUY+kS7SlRhc=;
 b=UTyP5MPpfo9Yao0csfueFnUHsezCuvEfnhO1HLEQOMs6Hmf0NZucDHlVmdq/3z6tX892l6aQG2uoFKxbjZsl0X21rjsvdaqS/unu6e6xR9qtGOY++MzgPo8v5lYVUdKpAPmQa4BociQ7nmjUycnPDdere/8+p2vBzN0pzXRLyxfLEnT+VWaz/VrYWn5+agU6J4W1xjAGM0qoDdz0uhHRCKWyeSkS9oyU9kCDMhgFDojuAU11xXWh+hOsiFG5INXmLER0xoCV6knD9dUGlHLUGo10RROQbkHGX85gNxaamr3SseFHaYyMDIqTyFSzREL7Dm4pUk/CXhB6vLW6uXSFzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10332.eurprd04.prod.outlook.com
 (2603:10a6:150:1ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:15:30 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:30 +0000
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
Subject: [PATCH V2 02/10] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 23 Jan 2026 10:14:37 +0800
Message-Id: <20260123021445.3782170-3-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: d710570e-1e0c-4735-70a3-08de5a254834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jvu/1nqjgSae58R+zJ3W/a9kyyud1M63yzCw1x466kAza4q9Af75sZQI63WH?=
 =?us-ascii?Q?FGcqalHsI4hPQGxQph0UrGaHXeWxnnSt+2xbb6BfF/RG97TtxEZsk8c7MnbL?=
 =?us-ascii?Q?DWsjBCl7eBT5bTZGmiidFiwznH0KKQbT0iN3ZlLP9D1K1ercBOxdnTn+sLFR?=
 =?us-ascii?Q?nWgeg9ZysFLN5r1z1BMXVsCvHpkvTR5CguG6zNDAN7EyNPxPf+rh7N2mADiq?=
 =?us-ascii?Q?sRPa/mTBel5eiOiatEgA45QScbkM7olC8BBGHP1pX31XZpHh3UD0oqLJPGaL?=
 =?us-ascii?Q?LsuliknnHIbKlTRJdXjrrpDzES0juoHpuWF9BaZ5GWFWyPnaK8TaKO/qDq62?=
 =?us-ascii?Q?9iYrI4f9fW3s/hlpP3W63/2uxyB0xaPD5FQn8ZUXqIgeVNpw1ef666bOTbT9?=
 =?us-ascii?Q?w8ssbgDQlNf9odhzrObRzlm4zzMBaeKZTPzIke8y0tKjZWfXlZ1u0LD0oYZD?=
 =?us-ascii?Q?ZZvaPNSg0wZuSl+rVaAAIfzTru4PQUbBfiHJVX5GJ8hMXl6RtxdGXmt0SD/T?=
 =?us-ascii?Q?6mqiK/MfrRQZ/EFqiAzLl/3Ipex+baThSS3Q2BCaUm+xPtJLcjR3mGZwnwbq?=
 =?us-ascii?Q?XuFPoeOSOu8MKfnHBgoiewuFcdGVBqMee5VAiUZi7JvzYoVvJXwQzTbI2GZt?=
 =?us-ascii?Q?Wfc93mJn1UKXQo3JqvLsKn0DHlOxyysaCH+cR4gGhWwdcl79/usble8wrmY/?=
 =?us-ascii?Q?2lLFBTy7Z+3Vt51BST2OLpi0lyO66gs5F27l+IPmxJC4cMutnMSN1z9vgP/H?=
 =?us-ascii?Q?7kqf8ETf9lcM+IimrN2hEJLhHzud95Qy8FtWDT2XheF7rn0WOSwhSom1SD87?=
 =?us-ascii?Q?UTm3uCBNe2QI+ZBqpuqoLPYsIElPaUhvOLm2cqVaduqp1x/te9yDcidtyO+V?=
 =?us-ascii?Q?pbLZ8ImUNIg0k+oAwxrb7GbN3HNKgGjP5OqBIq5QrsItLFkxVY9HWgzYbbop?=
 =?us-ascii?Q?QmcsteVVnTuDWq6yob+E8AUuOJipxr9xih9fWwCGCHWUEzj8Iyyw9A2gahNM?=
 =?us-ascii?Q?ElQWpKiHjwmbrTRMG+i1W33+rxdkOHuFPtEAHOLWR84PEvKQpXnXOAE1pdmK?=
 =?us-ascii?Q?UpHRbKQzArmrzVQyKwVouPDuILRuypfNzQUI29qaJ27985XPExbnrkZ4DWmE?=
 =?us-ascii?Q?NhPXd5zRZj81lOla1jJdxSVrZXds8qEg2JhP4Q0uKrPA64aqoWd3pKKApBoR?=
 =?us-ascii?Q?0OFH0M1tRf6Fpf41TcJ25260rN06qRpP1rTnTOWhsImOdCiGAhj7nIw+e3fQ?=
 =?us-ascii?Q?jNTMm+F7vNzE7xmT0zABMN+q/L8lTol9nhYSJ+ekuxDWkRDofMw04HnoXc5+?=
 =?us-ascii?Q?KwSqd4iF8D4og5LCTjWR7/65YgJZiWLWUmhhcS4RadhLMQx3yil44IVTB+ZL?=
 =?us-ascii?Q?2EUwLyoOAyF2MVX4DC3r+diwT1WyxpUHkCSF4alw9YooJiVbFOoLn+b87p7/?=
 =?us-ascii?Q?iTRm0SExapUW2p+U8T/rQcnamafyHbeR4+jngpduqR9u7/t7quK3OoU45ODJ?=
 =?us-ascii?Q?P84ax9Ir+vyUGdmb42w58SgDDXKFDiyRmfzzE9amch6choAQDF2M6dWDLXY7?=
 =?us-ascii?Q?RQYmxfmaHf+KOkx8dy3wi3LpG7NizgI83pbYYiZ0e7j77kzea6RAx9woJj6t?=
 =?us-ascii?Q?JdJ8OLxjdnOC1KLd2GsbyAUGkURLBLA1X6PdJdv2Ilje?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7J94IR7bS4aylD5HC7RIzWTQyVek14Gsex49jAByOScbamqGq6HfE0AiUi9c?=
 =?us-ascii?Q?PYCnR3679T9RqMrivyDLm3Zz7iBrPEeMu/OSZzF7KxyuCwIaSM8YrAVZs9vD?=
 =?us-ascii?Q?YvqD6gZ8BLp3aqYWS+JZ+sQLm3zIygS7i3sCj3br5iDbmbk6ejHJ6ZXnnEMo?=
 =?us-ascii?Q?uwhyUovReVTVfq5mh/ul7IgR0rfiHc/YB7EkJ+qQ05qJSv3mnnsFwAO6aZ6o?=
 =?us-ascii?Q?SLmK/IkWTy+cjBc3sSjC//LkWJQGMNkS1UhuHinSL66QN/0wB8jhsw3MVArv?=
 =?us-ascii?Q?Dea+qCgbk5yLgcsAiCCbWYUGpMeWyTd5fbt3xYtPtKktPkAmFpE9wZ6liO4j?=
 =?us-ascii?Q?0XKu9JaAdCup5hRmYFItq6PEEHNj6XnfuBSF1hy+NNWuVgKwC4pAcs3HLiwW?=
 =?us-ascii?Q?F6MxsAz60JyguKdsM5+IBGWsU2WAduj/hD7OwU8oVG24/lSbKPlB4pWv82NB?=
 =?us-ascii?Q?62XHAR8kSs582faYFlnJrovEK1rfyC9Ud7Myf+yfKv8EyxPXMv6dAmWDLLRG?=
 =?us-ascii?Q?odCyNXnAANqHDAErjQTDP2KDfp5UVbe2DZROqdeHzE+q/GiNmqE1JOSs8R3H?=
 =?us-ascii?Q?lKWotPjyyf+GwxZqNV0rMyGqZwCMQz42X3xZkeeRjcR+J09Q0nUtV3+D0xNa?=
 =?us-ascii?Q?aw31P26I+0QmaT7+uT4i4R92BVzdC/rnVEvcU8e/muuaYJ1X5+QPeMHdP3Fx?=
 =?us-ascii?Q?/hRVS6f3CuF/xie5BI6KYCph25zrKvEy7gBQ0OqLooqMp69yZ0c7gSqOgWpb?=
 =?us-ascii?Q?prWmft4frqIg3X9hVo2pok4NZPX+Xf+5iI4fUAFRvfhFeEndYGj5Burq3h0z?=
 =?us-ascii?Q?IOzEL5v8zA93kmyoMudsih7+nQxhs2gnXg3+e5Ew6o5syLbG1XG/OnGUbRD2?=
 =?us-ascii?Q?IGc2kXWq+2BTnzqwLjDH9kMHF9xwY9Pi9/2j+7Axu3p9RSUVYoKeTChpz4Xq?=
 =?us-ascii?Q?Me4t/V2YwNZ9v2I0ZH+jPbJ7OcTZyHDOL8/nCuVsBJtwF2rcG8GB5zMhExOa?=
 =?us-ascii?Q?uH4jPXXY0fEcsEsJSCoDBkPjXbCRACMhsp9C5HN08ee2S4/E1ObOzu06FrCC?=
 =?us-ascii?Q?p2q/96fBgvEigrkfMjqJzVOmbGZjJPPTwdCJE5U5/g6pa1qq84z9mLd6fs7S?=
 =?us-ascii?Q?EuRsAteHOd5hTrxuSpbIsi8qiq+UlA3IQrtN1NF9yVjiPgPoXTh1YQBiH+db?=
 =?us-ascii?Q?sztNA0qFPh7jy3j6H28SyONF58a4HFBCOU8B8Zs3ia1vUXkbiIFYKgM+SlvM?=
 =?us-ascii?Q?DEU2lIDVM3xJe3VBLXY8daffpXFYIX8yHKEOcAxHRNEy2nygjMrGEh/rUK8j?=
 =?us-ascii?Q?EDb6CIiDzRbMG598n5S33ubIvP/u8oOz8ylNILkFEFlsmEitv2YXkpEASM4N?=
 =?us-ascii?Q?UH4JTxw0PrBwweoMqiZAFeWUpthooLXzWniDK6m5BYeurMow7d9ODomiThrQ?=
 =?us-ascii?Q?40DnfQWZW4rxzEdleeopdYUSycVy9LdKY1DZwIura3EoMkvih9t+GM7OzuWh?=
 =?us-ascii?Q?e+TnNzPhNn3yGOlJ9FcwCfC8YdAkewospS5TN8egNPm9WlCb9C7yWhit1sb1?=
 =?us-ascii?Q?HDCHwIO1oO8W7GPNKlfTY0ZgovKrLgJR1puHJqykPnifQ5ijepzg7ZxDHpQU?=
 =?us-ascii?Q?FnjU7tO8Lp7KGJytTpxjgZNBD01DC0uCt5ydLgkpn6l2c8OCycyzX8gEkiN1?=
 =?us-ascii?Q?eGJ98AUVEHKCf/xp8xhruTnGTGy9SVEZwnThsuFmTTjsJ9DCXLxY7Zc/+Ngc?=
 =?us-ascii?Q?CpoEIKPsPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d710570e-1e0c-4735-70a3-08de5a254834
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:30.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZbpPplUgZ/1kXSKWyK1BH6+CC6m+Op2I9GmJ4ToZ8azSK/u+N326HSmoyZpj/Y6dz4f1zpk1t3p2XmZuMVJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

DT binding allows specifying 'reset' property in both host bridge and
Root Port nodes, but specifying in the host bridge node is marked as
deprecated. So add support for parsing the new binding that uses
'reset-gpios' property for PERST#.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the reset property is not present in the
Root Port node.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1d8677d7de04..4b3377a48b17 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -147,10 +147,15 @@ struct imx_lut_data {
 	u32 data2;
 };
 
+struct imx_pcie_port {
+	struct list_head	list;
+	struct gpio_desc	*reset;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
+	struct list_head	ports;
 	int			num_clks;
 	bool			supports_clkreq;
 	bool			enable_ext_refclk;
@@ -896,29 +901,35 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
+
 	reset_control_assert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		gpiod_set_value_cansleep(port->reset, 1);
 }
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	struct imx_pcie_port *port;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
+	list_for_each_entry(port, &imx_pcie->ports, list)
+		if (port->reset) {
+			msleep(100);
+			gpiod_set_value_cansleep(port->reset, 0);
+			/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+			msleep(100);
+		}
 
 	return 0;
 }
@@ -1638,6 +1649,76 @@ static const struct dev_pm_ops imx_pcie_pm_ops = {
 				  imx_pcie_resume_noirq)
 };
 
+static void imx_pcie_delete_ports(void *data)
+{
+	struct imx_pcie *pcie = data;
+	struct imx_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
+}
+
+static int imx_pcie_parse_port(struct imx_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PCIe reset");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
+static int imx_pcie_parse_ports(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = imx_pcie_parse_port(pcie, of_port);
+		if (ret) {
+			imx_pcie_delete_ports(pcie);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct imx_pcie_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
 static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1656,6 +1737,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&imx_pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
@@ -1684,12 +1767,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
+	ret = imx_pcie_parse_ports(imx_pcie);
+	if (ret) {
+		if (ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
+
+		/*
+		 * In the case of properties not populated in Root Port node,
+		 * fallback to the legacy method of parsing the Host Bridge
+		 * node. This is to maintain DT backwards compatibility.
+		 */
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
+	if (ret)
+		return ret;
 
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
-- 
2.37.1

