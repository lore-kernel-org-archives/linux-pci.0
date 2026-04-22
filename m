Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD583C2794;
	Wed, 22 Apr 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850498; cv=fail; b=lrx+UMNw+jyOaZqj2Fmlnf7BLDcYZULpUjdiZ8cpoo12Y+WGgSDy6JHp6S+tEpL+/H768WOdx5hK6X5tDksX1I5mpwMuRGT9n3/4xB9CnfsDgvBOYi6yuRs5UOqZLMP9sO7Nml87hc4aLZTgPZwjLCLeMPt/TRtLECF52Ye42iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850498; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIF0n6PZQ2zAD6G99uNH5jlhu6t7FVBJ9SxqNDdHmslQC8Eec+Ye7xIHapzhFeoCLA7QkOXjQ2bDi0CpmAxNfzpkLX/xyhOLU5e6KIM3+tL3jrZwW3CGJaJ9stMRku2eF2fCm3FZnyRfj+1HrZ80bae6ADCIY4dGciIw7yej2ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iIC2o9Gv; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iIC2o9Gv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB/XoCY72NF2RkEsUlFgmntVYpEz2LcWq0sXusWAlnRybKtQiQNNYsFXWipsBOvl5ttJOf85MSzgaReT/fzGnpGIMHkSygRYd8LqcHwJ6jDG1WDcncOONlC+zo5G6PjaMU5o6MNDGtnGm2ennasiQjD5jKkO45Y6L4cqSAh50vQoeXbvS0lOTMb+0ThrCAfeZgagA0EsTIDLqzt5moRUuGzHllcIaHUXaqAeOz2L74srYe/FwiJNi/ZGNpAtNuQCEW5csZPAR6ZzIcYnNIvMRrgf75mESv7mY2KFP0LrmimZS4d/UPD9RYnVfssab1SQaHJXz/ptkqTiTEM4JKKmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=v4uUNQVIsHgf9SbXNoNOceGT2Gnlfen/hJmRlox7S8LQ6Bns7PZIDzb06bp4MTkM9hLB68CUzFTNSegjEQH1xxcvV/jwRNqlUKxrmsesQ+Rwxot0SJ/UK4yTmFyv0GmMwfVc8OQEu+EWufzvWOfDuO7wuEQymkSWgpEVbv3jDg8ULx1J3wQ0E5cBdBiKt21gNax+d3lHPS8XJ4uKn873KosJNzgljYkSZ+KEeGo4W0uuW27yXxmfHXVuvRFE2ouceBsBB+fi36P2LfZp9oUDm4Dmo4HbzCCIevPu5O8l/99/qu+b6E2ec6a9QH92so6vR+l1v0xjZ4FoU7gF9Ph3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=iIC2o9Gvsn41p+A+oUw/zSYZf6GUm1WzY0HpC+wdsPXU7lOn0KEn/G/m0EEHLV7h0KpapZIeYfSxm9gzbAxQk8iHEQdm01EQ94Dzn4dPx2mZ2D6+CXsMjfsuQdkQQ+Z4SKXqOEjANzzWRM94mBWw3dvNJcddFHq3AFEUww7jsoh67GrdSb6+14cMqPQzT4fZulnOQ+NOotx8Oit2iZSHwvcfT7F2eEgcBs2og9R/FOE9O9lXAekzdb4BOHp+KGsqEenb90NWIp7jrv/i5KQrZ8lJCCU7fYYbO/AGFMs50wQkCyRLq+5omZkmMj3qmLdTI9rNucfSgwVXN9GXjLOxDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:54 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:54 +0000
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
Subject: [PATCH V14 07/12] arm: dts: imx7d: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:44 +0800
Message-Id: <20260422093549.407022-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: 513eaf59-bfd3-4961-139b-08dea05268eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	6Yc5moINIrL0w/b+BqMoNfu/mLkpJ/ZwGK+GvOAmyxSLoEeUiEJIktvh3uMdAaSbmhXY8KRMPvDhMomWdYzvSgSkXG9WJ/FywBZx3v6LswEGE+SsDNo7PthvFHNpT74rGEs/uYMa+loM7yLNz6jelPIhxgjsMQlW4Enk8ctvDKdfuUPntEGlfEt6ddw6MdtbgahEwTI0XroH4H8X90sH/3h2n7ztVDlavmELm4s5biuxJyNDaFepjVMubalmMYPs6uwCHCpDiqJqKHPnFLRbn8kefPjIaQEs+lofnlMp4Sz3KGydzlkEQ07lyuxTWTKx9FuqvR3bYaQg+2EMn56VLFC76Ut1C1Z4EOcbn7u4IskyFKmENkBOn+oghWkRHcMIGSlEv7GivzW6bUrCiAWA0/XE3Bsj/I23F7eaQ5h/3pCrM53lHbWv4zQRH5ofQnWj3lEiC3CG+KF7FDgZmCeuggipt/RYbYu4h5pfSCp+/M2aV1QqWK9uJMneRklTEHzsQA+AQpZaAEvAbn4R60uqdOX7acDVEHiKo2Rtzscw/wH2tNACbm2davvB42IpEig6eDML2lhPP5e/rWNzUvnUaiTT3U2JJaYbnrKz8geR8v5y0epkzNZ0IY6tVDPZHP0J1vb6cfovaICRc0lY3CEZRBzxvSaFFRqi6Gen38DDHHcFm0P9uPTIiIIf7DySB/hq2Qmed8mcuokHeM2W4AtbFP3sQwvltschrwG48k7rUUfMp35iiYgLzjnz3gh5SjDalcyrRTWrsd3qOhpmx2eByTW9dQMUTgCI0S8w/sXKaDb7jhjBaO2TKDA3tVx+MNfJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cEpCfLl/vYZCwSMPZJX7rxe6uqbyJ5PSNoSJsQUU9zL8LJvnsplpPwzGDzB?=
 =?us-ascii?Q?UKBQrdRe9UaStEHZYfWe7qTMHjeBGAJcYtA4cbc/bW5/M5wI+RUjhpizCjab?=
 =?us-ascii?Q?Hnbq7HI38tntzNoGivMFYSa4Rmt9RTBT5b315A5Mlcul/fZBhB7U92A58Osr?=
 =?us-ascii?Q?DNgzTiHg3Rz6RBBtjWOCtGdf/1a2jbNMJskW8s1Tiuyq44GVB9DQrrL5i6Ll?=
 =?us-ascii?Q?nb+EmpfRMo4scLwi1y0oN1ud0NiL2SFLFT6Re699E1pDGNcGN7eMM64M67Hs?=
 =?us-ascii?Q?Ohrv0CaI7B5O3+RdjOnM1ULOTml0dVQIS67zL0fAFDa7d7tdQw4hYgKxwPZL?=
 =?us-ascii?Q?GPWJhk8ttlTsUgwFUKaCBkO1T444F/4qTK9fUiqPqMpTkkOQNgZTbWszD7ne?=
 =?us-ascii?Q?NNauqAOWro+ncJ5M58iKPXo4R1kovSSD2QMZJY1g49XH3H68UEb46v+01vnL?=
 =?us-ascii?Q?uog38VJgfVdH34HN5vmX/f7i0JJqQVwBlaNy6HDuZiJmkzx5Dj8TSJd0haOY?=
 =?us-ascii?Q?o83P/O/0+3l4jRErTza/3P3FGUn1B6TKkfIv0KELtpzRVbiUo7duJL6kM0ej?=
 =?us-ascii?Q?SR/CN9mOCvIVEfXshHGE8gN67rROx8tqUYfu5eXU0LCdjLHzx0vWj4jw3Uwt?=
 =?us-ascii?Q?WLq6k+FcXIHASe6UjtYRofxZHiURkAmKQZv5ccL0fNH2Y6vYm6+lSR200sO4?=
 =?us-ascii?Q?cIIsMH+y+hgX6JNp1+xVLs8JWUfBhnTQ9MPaWPyqu5xI0TlWtLXbpshRHWEU?=
 =?us-ascii?Q?TmVp2ulc8AXIxpZK/pTK9knmvUN3C2BeTqaAKkIX+93GRw+EPh5rBBMNXzle?=
 =?us-ascii?Q?6eyxu3Q1OnFZoGkxifBewyOlSEhiipBtq0fbsiRSDa2Q05k8WE1uQIudzYpe?=
 =?us-ascii?Q?AAjs0ycekhu9c9TXmYapXh+E3wBwRHv0Pi4/DvIptnxj/42KHpBlidvnFG3g?=
 =?us-ascii?Q?gZC9A7O6xXp4kCyszv8DUxYd0/VDK6b/r9fZSZTjMZPC6+JDZgHmnrvqM8Oa?=
 =?us-ascii?Q?2bR8FvmMDjCykcbWthJqBH4H/vKgj0B63u2T+QHKRzz5u+xITxdqGnmbKRlr?=
 =?us-ascii?Q?GqdRhNZ+TDPpoIUJ0hYzwHlXVd4o9pgW0EFX5rJTLNXosbNMMwGnVPXfEF1m?=
 =?us-ascii?Q?y+pa3Kgvb/dj/6kDh7QR5rfTSABeqYk9VyffPZz6ViRdeTaOxs8ltSRpJ9Y7?=
 =?us-ascii?Q?iFeYoVGJ60Lvt2Xg0NpF2ZcT5YJu04C5p34h9GObbzU/S+pXsk9eVpBt1foK?=
 =?us-ascii?Q?fknwCwev226qhY+MIKL1e0B058HhQsSTRCZZMTcBhLbhLF24unPiu0hBcYUV?=
 =?us-ascii?Q?OLOk3d9c0VW81SsXVAIOdlK/afzSZxSR0d/uksZPm9b9XzzB74IqxipOOlKF?=
 =?us-ascii?Q?YWEWQaXLPzM7OHIaKUZyU84HzKOzJJAxX6DLM0S9MvrWhEDWb7ej3WPAFxmM?=
 =?us-ascii?Q?JDWjfOaM+kEAcFLXDzfTZK1I57OxLfiiGuIc4Ed8pL6v/5Kn5glsrzb6Z1tC?=
 =?us-ascii?Q?WTU4eot0PLNe0PHgF6sJf0WkERmmZhbbKibZNT9m9fBF3hMPfSOPebHgfztc?=
 =?us-ascii?Q?w7TPrtbsZ7TyGTtF+dLiEe7eZSfq/Fwg5T8UYd5gzQBSeVURCbUDneEqWbH0?=
 =?us-ascii?Q?gXrLmGI1aGah9VmftFP8nVt9FxW0cuY3EjCbYy2GC09LJm/rbzgiyCnAkjv2?=
 =?us-ascii?Q?Q4lKHasnutoW+zSt5abe+5aCRB7OEKfXl0jjRwVEMARBqWtLCYwMYOHPajAt?=
 =?us-ascii?Q?f/rHlLnkZg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513eaf59-bfd3-4961-139b-08dea05268eb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:54.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9yKSREdbYb9iy0pekKfk9yEWbp9qJHhMgCElz+G2dTYyaGobQXtkbi4nylGGZWQUjmhCJ8K+5OaRS60epgeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

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

