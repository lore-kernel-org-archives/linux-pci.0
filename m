Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADF2E717B;
	Tue, 28 Apr 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362577; cv=fail; b=JcHlS/Ph7LUd8Icw+OMjyL4GpyU0h4Xy/c63Nw9gZCSHOOM5ZdLfpIJY8ZZBaMR8wE0iBU0daH2daR+Nt8Eb8Fx1/pg+09NTYekYznFCk3oDK7BorI6xR26Zb0ip4wFC7ozvjtma6bPtaLZot7lnG1yWZne2pYnH0tzIZwlpdGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362577; c=relaxed/simple;
	bh=O7LFK+BKr4t/orZi5sMS5shIINOzgdVUzSp7IfRunpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2ezf+fcRsgoLOyqgs6IOBub/dgog8mmYA2vbWc1fcgewrBrItP+Cf75iWwlNg8Ft1j/xRGbrpd2XJ8/6G5+jABbKBy+DU/0B1V0bdGTspgEOIgars2fPunCtZeuAJrJLv1fo+ECubgMKhnjSUqH14AUiyc8TB/YCrwefoHHFcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zt5Ytwk6; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zt5Ytwk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJt8Uc9KNH9luvp8ykpSWQAJD/ZWhvlpHQxTthp5MviW0sacQ1q4/Om0ZXFIbjyoQEAINnLrCaBpEhOqoNm4uSbL2Q7Chdxth4gk3qHF/gemyOfHbgKvidAL58ILIS7hK0Th8cnl8hKWx9WFHRK/uVHLAkJR/89Ta1nBmcIIyo6lpmofHULevPstXEYlsPiQg5YPGQqMa2ToDXlb+TuvlQ42cOyYQr6HLjKZ02n3A1ncso962MatOVQtUFrNvL+t/B4MGP2L0XvTOH/c/Czu1goDTKUsy6fgp8JOVzXbFuWNiUiKqsd27xlgolAtou992JuwBgoGEWlzGhGVK6+qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WwsmxDqHp3X70CxbWq7rq/H2AVd/J7nCgKyzFOVg/0=;
 b=T71zMXrOOdRrlSoKyRb1NR6E9NV7eepLRFOSgb7Oo2F+0ymaHvpBjXxA6eRjSxxI8h2qmTmVtPtgbVFpLvjQoj4+yg3wCc2Y7qSTdYjnJzf9BNk7r1ydEJR7N6z0onX3Ub0aGeQc997cYvT/Ps3T7wdMgmXipq+jMsqfhwJw3NSGi/Ri4FSc3BWbcu/FZrNnmHI8s93hfGQAOBQMWFRry9K9zZiOUyDEXk5OEvnPOGd46NWX1bAo0V83zgy1bsNLgQbtkjGV2zqckyg8p23+bA55EQxcmDOnVfpwDlqAk3Cx6AAN/47zWo0VSFiM0XuR5M0TlQlKr9jZE7UrBWk09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WwsmxDqHp3X70CxbWq7rq/H2AVd/J7nCgKyzFOVg/0=;
 b=Zt5Ytwk6M8h5rGPvwIEVC7V15g9UM0qVK8MYNSpreHxu5eUfsPP7TNhVqegNHQYFaRJ1LKDISVb5+b/yAYK9cQUoS4GbO6uEnmSTtGZ1v/CXMQmPOeRDPQwMJ5Kvlpwf8m+G5z4wdWW+vd2BMwOoz1qF8pX7UqZKC4Hm1v6TrLbMabMvmCjFQ5PDO7SwTksGszYBM4rtXK7iBhjlEbOk0LnOhwHMr+NtzBd2j72MOFC3HHIJs2QI1yIwoQJpOGCRS7Q9KMWO1T2dkzSAKBFr/677f92bOAGyQAPk1vl6UpGjbnTj5FhxU3/aDPF4Fy+jhgsHpwTUqGZhNTff70ebyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by AMBPR04MB11720.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:49:31 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:49:31 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupters for pcie{0,1}
Date: Tue, 28 Apr 2026 15:50:29 +0800
Message-Id: <20260428075030.1626440-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
References: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AM0PR04MB5220.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|AMBPR04MB11720:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a8956f-ffb8-4f12-085c-08dea4faae81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Lt3rwQqLQ/amGCZZ+PmArSgIyNLLFxbspgktgw4DA5m5yxfQ/biUhWf8TRkMKUewSHdL0gKpKM3k0vOCr/g22V2VATsv19N2/gPX3e9q16NF2z1/4len/MbUJvGEPMxKsv5rr3jQfoX5gN644MuFvQKqfM8+kmCr0b4FZXToh4IhTygL8//lmBzNytVKWm5V7kMt61dmDChH0xJjW3epc4G3TLycAjGhUHesubsoZiDwvaQjFNCjpgH+E78Mi8kj1+qeaKqxJglEIQ9vbmxot73nSnQwJH0Us+1KymFmneh72EKgKLWOZZmhg0Ha1gUsNgwW+jzutJwTi2e2+IcYto6FEaqMs1kqrvftgHkc0AU+MCL6C1+IVxv+0sBbQeDTNgHwL5T3rhpykfHco9JiDrFjExnqPf6a0E7Uyhnzr6XSY6l6tInQnZGFT3g+1uy7Dzvwiv3pPqEFbvjyuW0QHsORXXTfGaPVcQvOZ0L7oiKB8R/OAR1w4hNV/0fwWAvUs4XuUnuJwYGO4qC1OFvZLo62rmjkHncgWaU1aBWKaZzX4UScuGYdYduEbGR0lAlc4XckciLWlxB7dKhJRZJAPEZXXRoFzArGJS04nC/1tVdQbyvNrubQo1YE21uecevsq53y9LldEAFvckvfHtLPezHts2Zrf+QH8u3TrCUQhpozv4TE52dkpGmhOqxKSyVpnUORVa7UT/fdOGHxSAqtqMn7dL85zNnyQc3aI4H6ePF69Sx7o0pwYEnXXf8L+l/wyXS+RZiRlv+Bsb1uxAII0ObW/OVdLjdKHranx1iyoHW3hEMgQazIv5KG6rTJtJpn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PnS3xnozH2ymeboDU1zNhsmFLQmWyaSNJepnvr8Xe0l2ggornYHCRNPX0TC?=
 =?us-ascii?Q?hsvZGja02DPSxfuqqAQfNQrZrZqp3XuVwKTJbqx9aBxYAsKDlNTKskDLjgt3?=
 =?us-ascii?Q?i86R14zTM3SuS1VW73EQXUrzEuzrBgYj6E7aQzCoStc1wBqtAaPBSXpQhNli?=
 =?us-ascii?Q?5gvzFzc+oAkYXlnhyhcZRz9jfqamcCZ5EIC95N0dm73JvRA73GfXYHvVpke1?=
 =?us-ascii?Q?Kn4wWK7bBZC5f6z9RzLiqtMU1bBYmFeSstlw5VEovZrFdx4uluuckvYDPClA?=
 =?us-ascii?Q?0B/uhkRgwP5Nwp4fJxmJtE/CR8A9RMZXsVt3n3IxT5S5uqpLUjPEPyHkFRd9?=
 =?us-ascii?Q?bvA86q/LBFO7HNr0yr5EE4pmQtcfevadv/WSrtEj2N4rmfp5cAWR2ZSHgXhL?=
 =?us-ascii?Q?TgdmZfFjSHndHVlwu5+mJyI+1lC9dcMEzPJs42bBd3ICqGxXSf7CueiRtooq?=
 =?us-ascii?Q?sZehgG+laEvz2I2zYE1wGqnYyol/j4fD53ol0Qw7eIuW+k//2FpW31VA6FXB?=
 =?us-ascii?Q?TpX91aFsrC/onYg+5FS3re9znJtej/FLAoyLsCdxMaKX/QaZGQR1ZwkE0UyF?=
 =?us-ascii?Q?fx/Wtt7YQFDbsB5zBZPUh3LuY8ZSGXu+ptiwoVy6XCziYGqLBzyLLRyozT36?=
 =?us-ascii?Q?IkOkaLCIi37ckRabF9Kq0DU9cxrip86yTUDkPIWWBZHLmKkBzUc7OAz0aIwn?=
 =?us-ascii?Q?wfH1pW3mIj5omNdlCzGySPeznsbi/TA2WkxGi6qJBIyhpgEhhWnrybnTh92G?=
 =?us-ascii?Q?+1SZlZjAM+Fn0c8YMYD1X82SuffvwRnFpFRJ6iP6vhcwcOqOxMnHPRG0iJTw?=
 =?us-ascii?Q?JbD7TrbfjHHGrlAFN9IuTKIrSBy3R7moEVo1rEJfK5jDFFvU8XsWnLttQv8x?=
 =?us-ascii?Q?DNUp73U+4amvzBcuK8EcQNcoHj0HmLciJ4xphJdBRf/4WrtblbOU92ZyK58j?=
 =?us-ascii?Q?itEpaOW8JWcyKRacEdamU0wmZND6bNu4alzRCcplE73Qij1mRjPJ/jCqa4aq?=
 =?us-ascii?Q?+VYV8jmsNifJIU2jDPZGHoxruQCPuft6unsHiugVM5caPZle1bG1G08VPFGL?=
 =?us-ascii?Q?Ewx2g/i/mS7ci8Cw3i+PPUQYzHPzcWp8oTko5G7wtE60QQVQQvbXh0uDdcV9?=
 =?us-ascii?Q?1FC8+2P2L0rwbV+FfvbQ0M4izKRSGled00qTh4YvMI4tIUmO7xPUhSrBUYE0?=
 =?us-ascii?Q?FatdbqvWjWVXpOAdLgolQHMLSOZqlf3e395hIhjXvC6PJSdKfvzfCjPmEFhT?=
 =?us-ascii?Q?sFPD7VGdRPLVC5/FqicRiWkyrcqDwK/wEYFJwzQScyxESQqgkkUE8TsVc6O4?=
 =?us-ascii?Q?iQgzL3Cuz9kLpA8NWHOvJRfW50LTw+qptrhF35qcx+DL7NWanQJRkSYNJL2M?=
 =?us-ascii?Q?yjACSdZbZfTXamIT8N7eLXNbvUc30rpoK//c856VpwYXfE2hH//sCjfrHmhi?=
 =?us-ascii?Q?2XTaIeX8DsFIQBVcmmdLYrbTJOO8tMrTpKP9LYDeUyV0ziJzxpQ7dPHgX4pc?=
 =?us-ascii?Q?u19lqvIb5IiKwFrwjI68D75Npy474DDaDdUf9eNtbHz9Y6qCttmF2TMUJczs?=
 =?us-ascii?Q?dvBi9mBB1khQV/BbnTyNmywvnSGRc0x6tLFtLyTZwumgEWZrt+/H429RcbLP?=
 =?us-ascii?Q?bwLNS35iGX9+yBlUjMj8Oh1nkyBwt5faUC0xyYFmBV8PQKCICJ94f6ccgSX7?=
 =?us-ascii?Q?OUXlX3GM25ZNuI2zZekr7x/00Fx1AVWDCS9hynwl/y5g3X3N8HcRQOysUftx?=
 =?us-ascii?Q?IOde8zFNBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a8956f-ffb8-4f12-085c-08dea4faae81
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:49:31.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3MvNVEfBXZMQlc05hAIiQZsMxh79OOaDM/Ofmmg7K38+DgYAtdxgeTrnajD0MArbXeKl1ibtO1ebGvcCQH+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11720

Add dma, intr, aer and pme interrupters for pcie{0,1}.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 71394871d8dd0..6896d9c15bf53 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1861,8 +1861,12 @@ pcie0: pcie@4c300000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
@@ -1936,8 +1940,12 @@ pcie1: pcie@4c380000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.37.1

