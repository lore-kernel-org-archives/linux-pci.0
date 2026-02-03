Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04821E8826;
	Tue,  3 Feb 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083752; cv=fail; b=I9Ym9W4tqlhbWnWQeaymRrq3reXrmerEmMcx/t7kAeX3FsiOlIKwfkcesF2oiIWB48g1/fFVHk1u4zTxCqprEYpCS6wzMLhgymsDqfkkE87Uevcr7776LwBDHsnZ0x9PLg8y1wsMT3SPSu3wuyGyOapHn2G7L5NZsaYB2R42r20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083752; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0JDV2cHkAEoURCCStC8T8f21O6Dg+5YR1zyvqmKxN5DVmb94pNytoHIvYPqJEkHztoflHVuOSxtKkE8xD3QYGvZCoQLjtqpci3Ao0wsp+STlKeknrkEkLh9sjgj1etG53twB0mw/UFEH1dgr+lXXa+QqTuJVvijPHAU5GAhV60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mM/KjMwa; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mM/KjMwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDQ2sZufssc83bBbLxKV22b+yHsOc6SIos6/T+1NVEfYdhTyBgkmuDI15uzUjBeX6hDZLMEfJDyM3ZXMa6snMDgZZot1YbqslxdLQ658hu2BU2+SHVLu2KjzVUQK6G5/IIhviqD592HzEoPpFLY9lcljCvcpdE7YXSrJKqa+S0K0y5I0glwHwUT7Q+FRcGJT3vVssh6yrw7b6Vh1/NQxbpjOuX0WnexrJ2k9eSgRhVTXWVnzUdocW9P8Kpo+WWC6IlCbZ9Y46SJTyGZvFj84b7EVDHwL+DNbFNr5QIPWfMOlIQ0/EGucc8dMYshFb8td5h3FP+/GwdHdQoi3jnDRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=ue9IkpZ/mXVnMEA0ZPbuUhqANkQBMQGM+02MmNowQ+2nDNSJIhgPr3lIXstco4bE0lajI+kUckrPuEC3wH/JjXrpsqAbRc20ofi79wH7Zyr3GOCGqgBMXvxwyTMXOoMzJ/ql+o/QqgO5IH+MpOfMEGEZSWibOAb4TxgocO6U1xjLJFpJflW2+7iKDqpQyTVAIxRE01LhPlFFTXIoxp0gX7hXAIbNWz6VLViihDuEWz44nFcGZ5UcTi6fVwKA0YgYbquGrnuiOEJAMDjp34LzX/p/N0QNJrne9N1qZpH/4a9qwXs/Qo7pwyTxV9jhfMJ5mo+KbehjHj7S4bhNo/mh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=mM/KjMwaN7yif83oKiq996Zv1bCGEDHHs1e2MU1Vhvxa+d4Z9OOz4EHfmKpKxY6IXDcVspuYTkwahASCXKDTudDjVLZs/zs32DbJ9h21KAcibbUExzYvfDXe911/qaEiCn3VGgqU4tq/gV6YJKa5f3hJVokd5ETiuJKLitA4JN/jkq/R61svGpK/QHMMZZOEBfuakUwbujBVMyKuDF7UWEKJMd42PxDQDth0spMCn84uFCalQL8vscW1oQeRH6iwhvNF9Ii6PThlLDH/TAc1WQCLNcDiCZ7eS4Gj+xjWuhfv/+Fiu4DOZnMmMYI6k9C3X9d1ZE2XsERv6a3kXt+nDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:47 +0000
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
Subject: [PATCH V3 05/10] arm: dts: imx7d: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:09 +0800
Message-Id: <20260203015614.2957479-6-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57376298-7226-4343-cdfe-08de62c75960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzmqUv2HDPEfYJO5VPlo9dzgwibd7Q584XA399quH092gm6zDYTTPDRvjfGz?=
 =?us-ascii?Q?Ce6jGyVsi2LWtm2zhcSKAS3bqIk/2VWIi2l/UCCiuDyKTjKm0yQJyXDpfudf?=
 =?us-ascii?Q?VYSBqkBUE8BYDTOoC5I4jADcBCZk5jW9/MNenZYJCz372SUxSsLOK3mcVw8e?=
 =?us-ascii?Q?H/OJRdam+fdFtN9pfZWm/TewXPIKMOEw9jiUFcc5q2rDU84dt36QCW2dKG+o?=
 =?us-ascii?Q?f+8+qh0c60zLTvVWWMIlC4viIVt8fLnADlgfttyzglY5f3KPshaFBuyHqA0I?=
 =?us-ascii?Q?IrHamU2mwkhsUudY5z4O+kGWZZXKfsNIPqzqtvXoHo2djrEhhf88MZ6cvr0a?=
 =?us-ascii?Q?yN1mJfMehd5DzSikgL5ct+0k1nkBgnD4lpDGigqWD53qFsSbTPe4irxdbS6f?=
 =?us-ascii?Q?f/mz+/zZ9+6xU3i2guSHTdfLjxAH1LCpxOIL2oKCNRl684YyjlUOK0lYOpDR?=
 =?us-ascii?Q?veCTDh/QUtwcKfpRVDSs2XVgKHxT/wquDnouTiVPUdWt6CsUGQ2wF66FjMcP?=
 =?us-ascii?Q?07j3oswZRTJsdBtAwwBvbWGxMakRfWXzjeymjUGEMi/wtsyeyVPqGV3rZWd0?=
 =?us-ascii?Q?VLFDIKt2GvtTZzhm6vyvsX4su4gCaQxVGbswLzCMK3FnZKEgZaaBikIyKBgH?=
 =?us-ascii?Q?ptKa97NsiEx3XYqvHAmSdJNgPbY1BNJkbSTgIruN0hxwvocqjLKEyU7bjFSI?=
 =?us-ascii?Q?12CxPz+gWWJ5kOxRPyieegtWOo1FfdVXUj7c6hzhxRqh2ionuR0JVIgS350H?=
 =?us-ascii?Q?JKV5Oq+9DNYmfzR0mgkdWNeE9vTxSf993gSw/crQlbQ4VhMFBZfIUIwQqqwc?=
 =?us-ascii?Q?pbmbipYJQrdcxhsXyMh3ypni4k6Y+Fz9Qi9QU0t/g7Y2+HyDS9bmEdtLpivN?=
 =?us-ascii?Q?41J1dVjAKQBBSuLkSgqLXy0srj7P68bvaRJWThDh5gCD9vVQgV8izdT4ztJO?=
 =?us-ascii?Q?ybdDFr0gwlYewSK4ZJcmycyOqlfTIBEFlrGmiXcBFL6dH/qliQFKiB8xwMNs?=
 =?us-ascii?Q?ehgGMJeimKAPEDgvLQQftYnsaPIMysugWZ5a7HEGYawHW8Fgtppf5zMB/joX?=
 =?us-ascii?Q?VfXKhOOSqTwGHdjkKjQOgf92EUGQdaSdm/GjDfuCKEDtK1v+FLmaUivFJKCX?=
 =?us-ascii?Q?kxjI0M1/Dm062FNGdEbVuoB9nRynom/iRV+w9JlbsR9ISrViJbUJ5EojtrM1?=
 =?us-ascii?Q?yJEMeNccKZF8i4+iIJSa+2bHqfTPxVZMOi/B2PKVbqr2ydr393r9bR/KOCnZ?=
 =?us-ascii?Q?Wq9ckYQN3HCq8RUItdsliJC8liBXOSxlIdAugSFQG4Pph805lK7mwfYZZLnB?=
 =?us-ascii?Q?EMADfEwxqL1nykFnzexEEyyif/XtLN5tQJJbmwRQPvQq17rhyV28Qo2A8kU8?=
 =?us-ascii?Q?2D4iQsRXZQFOPO6yFZK6o1Ro5jWirL2E7kxAvZ7UBpcRgOaChAPRzPlIdGGk?=
 =?us-ascii?Q?QqVnUwxoQUqhzcNabl1yN1a9L31IcSP+iwc2g+YWyj+i2gSa3cH5arwgppZ1?=
 =?us-ascii?Q?m0wtnu+YPuyyy9Mme+dt8kjOkt//NYv+0iRaTxnrLs8MNBfHdJkbwSDIpfYS?=
 =?us-ascii?Q?njlL2lLwnte4FaIU5pobxFpJqkaIDPCfA09gCA4WmOyD9YaX3I9BKfNQcSAk?=
 =?us-ascii?Q?yD0YbXOvw07VEdA/GFZCFtACkQFHKZKjMEqr7kagXtr6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AM0+yH0N06jSNYzlZzhFKzT0SImtvpswOJvkjql+ESG9haYdY/UxQYVIW/uv?=
 =?us-ascii?Q?9bRVnT+iKU7G5JFpj7n4A5bpQkssw2ykyZRWrdSJEETjbEzEuJx1NIlOzIO4?=
 =?us-ascii?Q?GZ+aNMpSVjpq+zlJDqsVka8OwdR+OVVz2D1PceZoCBAVPpgIl/TFns+S+Z1s?=
 =?us-ascii?Q?ys6Jtdf69YG4nMEqIs6s4W/JRJEjDmk4crYyxpN/aPFPoiFvlCfYtCbNG6kK?=
 =?us-ascii?Q?jBZEUkvaCddblAscXIxcZy+YZ4Qnx+ZlGuW1pk7skY0zc9lx5Pc/xvGYdn+a?=
 =?us-ascii?Q?1HrsGmoAkFW21MzT8dQ7yRREFJer8JJeLI1eCXqShQv0wzVhV4reQhRvT2f1?=
 =?us-ascii?Q?VFej0V3pOq9zeN3DZjYIThM1PLYMtiG95EKMHSkAWvuXxOoWPSUbb+C4HnhZ?=
 =?us-ascii?Q?NHe4TRIg5VUi4A/jwcvu+FYS+/sgSMhlbdCiQCPiMMeyXQHX+PfdzAG2Cwdf?=
 =?us-ascii?Q?RkTcfue/KlsP8lcX95Mmv3ArZxAZMEyAk1mzu1+yx78CM+iBV/6bCL2/TZAq?=
 =?us-ascii?Q?rt4H50222zYAdetqnLKjf1nZr6PeQkJIjW/NKTT9d0HfZyJFVxIalUaiq03I?=
 =?us-ascii?Q?0ium1gOqziYQyp1pWP4Z3Jvr1FbvBRFH0p3OVyQGvNt4GNfuh1cru0eQxuNW?=
 =?us-ascii?Q?+2r6YNBAzaMkTWGoWZvGuF5Bp1R/n6STgB3mW4trUr9xhwR1jGNmkFCKsj50?=
 =?us-ascii?Q?YYt8hQ9dO+FfSISaKcTudze9lHJcEGP2EwuDDxcHuupj8QLQh+nbP8qwiZxX?=
 =?us-ascii?Q?AtaKtp2xT/EsxEG4vEEqQhXoR+ODCpEGGgzZE58Y5tF47aBHlnMXe3GeijAm?=
 =?us-ascii?Q?7epob/ywVNBzQ1jqD/wxyBqixu1qwX5XEcZjOYodZaPdYyYiGXK2DcEDZiC4?=
 =?us-ascii?Q?JfJwbjNdTG7r+lTp8Ne65Zilhl0ThuCYuCivbEceWok+HBNQ2agEwTEXVwFF?=
 =?us-ascii?Q?VuKUwSMlpUIYuZAnbBFL6WY/MccgUc34K25vr/mNFD1rspeK2vhHTzip8GT2?=
 =?us-ascii?Q?zwtIqUav1wnAKdjnuK/Sy0sX7c0fVT8SIUWcm0gh0VBoYMPsO62veyAsz6A0?=
 =?us-ascii?Q?rtFfgSsLAhstPgl9OKKCiq1+HvVGkaNj9OA9y+nP+1oBI2WoVwPgcgn2JVqs?=
 =?us-ascii?Q?mGc8D4qrPKufSe6J/rPJF46BkXgG7j3FKL/vrjmpqfTkKbX7x2pYcyXn3Qu3?=
 =?us-ascii?Q?pTC0L2dw7G+QqPb/QENVf8Mg1/O/H3Ch8LCb5Hjhki+1Bv4xMlX9gkGlJWCb?=
 =?us-ascii?Q?HX26ersXXECBsnKqyEhlVfOTAmrg4QR59JhBac3dMyj962iOIpsHR2lAxc8R?=
 =?us-ascii?Q?gb4rkQuUIVKIqRP8rglNG/iKzDoadgzQvHKeNLsW5Iku4BOsnbgFFmP3ptN3?=
 =?us-ascii?Q?t8A09wWYJka0a6QMYX2oV9c7UQvck8f7XQb9OPdrPnDSY3czdTgmNxT9JTbO?=
 =?us-ascii?Q?s98RJpHWuCo/yQDsY9ds9q0nZX0PMAigNK8E9M58vrco+QGW5Hev9RQ9M2T5?=
 =?us-ascii?Q?Q1woGINydrBAWttq6vJ65QyeHvPniDe2wcoDGMYW+yN2wDc1GJaRaU/drqEO?=
 =?us-ascii?Q?8BO78Donv8itYckmooYpLwKpVzTbeNEOLuLBUrLeG3s2qGCUF/Br/uM2spHg?=
 =?us-ascii?Q?WTyshz6oIbcTQ9oCt05rS/9xdHlQ7qNN3680o4BiEhHRmUS2E8Qhy92pllU+?=
 =?us-ascii?Q?Q3XYj6A7RIHZt1sDA31HWbXH/J9DErXmF+LvvvMZB4iQpBpoavMXFjeNN4Xg?=
 =?us-ascii?Q?J3f+o/6bkA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57376298-7226-4343-cdfe-08de62c75960
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:47.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbrIvVE96VAN7BMUHDibirRnjAdSIsyCsJQVLyJri7yKG9pOj+xDxa2HR2IY/Pw9h+0Fhgf9hykq31zwblH7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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

