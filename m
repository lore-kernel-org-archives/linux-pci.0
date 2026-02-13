Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D825DB0D;
	Fri, 13 Feb 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955711; cv=fail; b=nRe60jHN1RvVg7AsCjlUW6kl5INZE/58HdEWWrgchzqqKEz+X2XEkGTocAadRS9/0OAz9MzmmBIslUxcNJMZAWSrzj5gZm8ydKVwfc/09exofHD+Ej9OfOkn/R4hKLuR/6QExOBpqgDmeSw1doJoP5yAoU1t+96pFwqcc/lxao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955711; c=relaxed/simple;
	bh=dGLGGGayHF1kXMBXPouDMRXOhNmIWfXdQITz3dlnR8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIWjT8f+wNGKMD/xAdIJteuySzCHWgJG+d5TlD79Hpx3HhDwU6+0bQX10WO7yo75JNEBBooY2kwE6g5lwBfVup6rk2jNKo8OpWlvtL6q9WU0XBLRWgpO9YPh7HJQk0VDhVxSkp0SyD3c/tfO/bdQW7y6aZOLheTTn1MWci1A86w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K+vkcrMB; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+vkcrMB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj0FqsNfHhfmHqnMp1mIubG+Yw+gspNrzZEYVF+rlfv70W78f2uf/2J1l2BipmPmQD7fkZzqs+K2iNMD4GThVVeP+CAbamXPa7HDAtO2QdvwHE65rFr3vzjprLK9ddnKVW3kngVXjGLo2q15nwUz7q6ZT6Mii2Twxks2YwusxwWDyiCDn/nr96ZvHE0Y5eKN5wnJz7rNXURH3WWRcA8AIo5W1driOAZx7p4xyngxSKEco9B7+xn355QcBhPH3F0soFHstw9diY407f30v4l6nMHHH28wnmbWcjD240hdIfgVgPnOyJII7ZPMGbWeovsWbe3UbEUil7EtAYGhsMjZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=DOF7ikVlosxaHxJzDSjEyQuS1wo/M3Ur0l2z7sAylqDyG4uy2k+87GvBBE8ImmYe2q3w88GWz/HHVvbw51clSp8VeNkOCFFd14+00ISg6av8HGVqoO9t9rqpLMMAn5PjZsXXj98Uhp2QnCFAEqG7NKhly12Df/lwGnqX8pbKwJaUkCuNMJx2HsXBTjzVhfCbAIC4awtk5feNJTXQHfqrAf6JcRLOBbMcA2llNtBmdf2fIx6AcZMAt1hv5eVq+E4H//wJ5jKshoEJJ+FY3E5OEc90+cgvxOkBuQcUestXYnrDeqvuhiuzJbz035MYpH0o9FD4zSJQmkHAO3zq8qjQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=K+vkcrMBC8vUZdddf6Knjevi6jSwpmMMBp5gtWk1XHReedUBQGs/58/o193kl42Yq1yYi60EBdHQHEd1igYwoVbeMR/AOyghrvbONAVp7xxTnbUpW0rL6AgpWGlximlLcumksvO5Y2pO3HxUK0TL/yR/oVdPzkXA6j1TO2vEYUdhbM4vGWU7fdV4jRKL6vf9djx9gasTErIFKOU9/qQPG9a7U0aW3QOlL4bQXj9xqKHbAttSJpecf1r/Y0bm/plbhCN8NQb1wUKoSixAREtC8lbqBIJhCGvQq8w30+fI9pWRt64w3IMX4gmJh7Kcv8NTiO4qj3GNYtj9rmfWGgKHpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:28 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:28 +0000
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
Subject: [PATCH V5 06/12] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:46 +0800
Message-Id: <20260213040852.3340547-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb5da88-a77b-4935-59ef-08de6ab58abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtcfXkk6fzKZf4x82gQPA48LdG4tUQroIFtqEj7vgi9gWfV8S87sHQccZYZm?=
 =?us-ascii?Q?PekCbxeqhEjBI7ultSs0q80UIeVTqUp6Wr3ryC3rRGg6Y+d+x5gCQsGSTocd?=
 =?us-ascii?Q?VkVxv/qTFYX/Se5N5IY0IR/oeajCUXnxdxsLwYwfLcxH7+PGJmY+F3s72E4T?=
 =?us-ascii?Q?T1D/7vFB2gMGr9vJ3fAz2I4bdDk9rwjhbzC6fYYxcl9hV68u4RWXJ1Ouv4ch?=
 =?us-ascii?Q?WOz3CdazvdsclRmgMUOsjo/nEVdJjcCI48J2A00LwGMBLAvSNn9NTaz1WRTX?=
 =?us-ascii?Q?pMOwEenNW2MJtnO8Cv+meHAPy5PSFKf6ti2mdy2PpC7xyl+fZ9CnsHCrchkD?=
 =?us-ascii?Q?68so54iO3qyvj4Hfcv2pAKQuPBrbIMHgMKtPJqLeJ5BjR9R2I8u256pWOCon?=
 =?us-ascii?Q?DWM2nzwI3npwj9YY31ugNQt5/ne1BYrI2YNu/C29sFfw0/f+jGkoYS71gIzJ?=
 =?us-ascii?Q?WC2XncpWWrUmZJx/3k+UiUpQfS7lskGcJzXhw+Af3UWGrrnLaC6ZixTVZLvW?=
 =?us-ascii?Q?kuvp8vrmdHkJhyeQeUDR0XkasoJ2lUtXMEqAq+1Tl5EAONzmQpzmCj7Vlj6N?=
 =?us-ascii?Q?F56pF3Gob2mfsLST+QaTMvIwrD5edwPuhByG3IbVy/3SxL50JokAMCr9If6L?=
 =?us-ascii?Q?1NUF0LWcPP93rzjqKU6YE4JYZdojZh451BCTAEvtLgteUHlrpJwWHJO+/M5x?=
 =?us-ascii?Q?BQAKL4enjuAJHHPUMSxoYgzaZ/WYu+52d1cgN3bZ6+CRjEwDqm6I62oW6Pbn?=
 =?us-ascii?Q?FcZAA1AnNi5THV7In6WDzHxCuGJI0dA330SXqN/m/A6PkcrRP6uwiMPi3pji?=
 =?us-ascii?Q?2FgGcOydguQz1BhVH1wsOtQJnIFe9zcUmNULsLxYLPiEfB8UdwDV2sfV4aw2?=
 =?us-ascii?Q?F6dzFs92O2XNsrUdpgyOANpo24Kw0xecaY8Mz6eD2cgIr90B3jD53fCo0oby?=
 =?us-ascii?Q?5fu1PP7uPb9S5kP/pVM2xD5JTyoxEVBhCqwOl+Yj+mlTpviLDDdtms8y/7lz?=
 =?us-ascii?Q?24rsF0fKdqsGx74cAiAbyvO6UM4zfyoOCDXsIh/iXSj8dwJI+6Y1EyzQdV8F?=
 =?us-ascii?Q?dvuoucGUAHF5TrLRkv0RY3Vni7tg/oc+RsktWEj/KVy5kKy/VF/sf79IrGrH?=
 =?us-ascii?Q?szePijASJa1VC6NsgXw8miKHtLml2y8YQiGBtEWI0kJvRaIT+JRssfs6/nFs?=
 =?us-ascii?Q?nuRLFbOdiqH2pEjg/SR1G8sGSKuazR5LnU2UwZZfo92IDFw2KOcAOvN91Or1?=
 =?us-ascii?Q?Spdamx6KIuHZiiHv3mn4zYKpoqSdbino63xHBGmshDypIXY06BUaWVbkATb9?=
 =?us-ascii?Q?h4QiHLyYDBr76/8FAOV0Wp10Uixe4nd0ZaWAeoIVZOGkTuPVjMEBUDnyfHiH?=
 =?us-ascii?Q?XuHOTxxBtSki4TwymOWGE9hwQI5IbxhC3c7OWagsqMtOq+nfULbm2rPTmq4G?=
 =?us-ascii?Q?GOISScLm14C1XSp6pynicYDUX3Ic5QrSjPsrI1v6obytLJzGNd5QxqcwwtR8?=
 =?us-ascii?Q?FOeswx89esC6KKhSBBY60O4JX7vBGX3cG82V0gfSd5xfaRFNzveYWd+8G+U9?=
 =?us-ascii?Q?JB69HYOZPAVtklrQxvj2gSmQx/Jz8E7hT2j0Bc/DxCC3sYUGNTXCeEp9kZbt?=
 =?us-ascii?Q?/2U2oOH2cPk38UqjVVHwBanv3CPKU0LGggDmKCXtk+8z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utgJ2u+YNYdUFWrOSEvsxab92ZLuySanE0nYV5Aym7TOSnvQDpat5qUfUs/F?=
 =?us-ascii?Q?j/aZo8Sw6YtUpjShrZ0Y88tZejHm8sPYh97T8XBDKlECnwnWYTuyWUMF02nO?=
 =?us-ascii?Q?apwD7Auy2cJowfNeRD7HZj/TDrBk/9kSMGHRjNwN+kyHReG6rPahLKhyYCnL?=
 =?us-ascii?Q?l9R4TIOZihW5uZcxteYsWoyJBsnL2pUG6Pge3E98jtADi9uYQwWEAkqkGaiG?=
 =?us-ascii?Q?gux6b19h8fOuVhbNTJqhlaalsAinY4VBG5FfnGKyplI//Bd63d/oLbZ3cbb9?=
 =?us-ascii?Q?Xt2lhbBMSQAfmkBDUpz9AYoBtAYT47MFJjvNFapguGnqxN2iw2Pl3+vo0BBI?=
 =?us-ascii?Q?Oy1lEJuKime35b6yyVry67COVqVKWBF27RyQ77793HELe6CybnkzmW6oDV0D?=
 =?us-ascii?Q?1FkkywO2UYFWLJ9wRdoXp7rDUc6QBh48ZHuxLjiMdlae5Irpa88LEVu3a7WO?=
 =?us-ascii?Q?yZ0buLesi4L+HEENxu4a3hcmsYMAbgn10ekEh4Q/+zanjCePxYSaHIYKpCLe?=
 =?us-ascii?Q?wj0JylZ+6ZwubgMLTUg6dQlyex0rtkrHpXtT1VOW/gfQzm3Zk7XdCVPaGJWU?=
 =?us-ascii?Q?h7crJzLKEDWLIYyz48K2loDrAfl5ESxx0QpdcXlXQeYTY5yqBzWkJcJieov3?=
 =?us-ascii?Q?r26gD2WV6EUWVu2NUbwpnOutCfSuP4acSi52lzz9a7cbNXcqkxrbTH0tgrS+?=
 =?us-ascii?Q?2CdMe8Pd2UAK0Ht8F8hPaBq87C+DsEXm5b4x+FaWB2jKgPMy5u6VWCohFy6Q?=
 =?us-ascii?Q?RWDX/atFIwmOYdh1/GFPUqiQhd8lZAFMfriuEvLkOoDvQv9RnnFfJbqVb4By?=
 =?us-ascii?Q?JFRdjentjuJja5bvyiVwAgATtaevYgNIODMIAm7BJnbe4Ca7wje2l+M5t9AC?=
 =?us-ascii?Q?yw1mr7xgHVfrzURyioN3i81KspCCjxLpoqRWJyV9Pnb6JNmpj/YQbEMjwQlY?=
 =?us-ascii?Q?QUvX0xKTMk0WFmeQBG1838k4D8+daCH3IcAmgsmdzmnZD0gmRSyrOjhp2srO?=
 =?us-ascii?Q?MrmpWHxPLpDZ0GhBkQTZ4ShuD0Zb8ZfkbJ7Pvqg2oXAaYFtI92jF903VIL8e?=
 =?us-ascii?Q?FXtTbHcXYDSau7K4BstV736XcBRDwyjxKUAwdi1qD2/QeD+IZBsyqIcLhdKR?=
 =?us-ascii?Q?DCmbE0EUr5WxzQkYAPJ0ajn+CRP+2MximmjhPGrPO4QkH7mjVPGc7JBg07pI?=
 =?us-ascii?Q?X3KqSEyLyF8UxVIX1JWJ6Ihp0hBbdS2kdpf1u95jUC3erNszWPtHxIr+nUpT?=
 =?us-ascii?Q?+KrQkUu3oZypsFp2kVgF89Loe5/oOyAvfTAH/z1eTkw0qIQR/zhLioO/8IUF?=
 =?us-ascii?Q?HwYbkv5MjtQ3dhMabOxYplc0w6LTx/xXErQRkXMhBJbmNUTLzIbUVEEEBeDv?=
 =?us-ascii?Q?9gudqta5SAMgJY+9BkOasvsXNL/0G2AMSnERm8c+Oc00c476MnmoUhimr7IL?=
 =?us-ascii?Q?kJ+gQeRFbl0mnAWNtBxEWn3CvRXt/8PJjsD4yPi9OaifOk8x2+rcRCq4T89L?=
 =?us-ascii?Q?RMmafkeEeA0xlukqTZosGVYzhfJpoDkA0qCakAQklXmbmzrHr1lQSetXPwlH?=
 =?us-ascii?Q?gM8zinPKObbTEsT3Fm9K7swpSiZp6uIknDRd7yYVmD6sn90CiOOReK9gLver?=
 =?us-ascii?Q?ox+xPLyfKZoQSiY37K9FDOuCFbhYikroktvfJFN/uriFS2hTxPdq3re+yOBQ?=
 =?us-ascii?Q?Is3JTpcqUsdd7hq9xvkTV4xAMPTFDsreZXAKO52kFfr97kOMhKH/+81u20R3?=
 =?us-ascii?Q?mf/DsbkP+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb5da88-a77b-4935-59ef-08de6ab58abd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:28.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E5QSpwLwIw0XdPdkCLux7tktS38EN1YFcipLC963e8U27TT+cozkrtPE2UT+jZKchjl3452FAwb1LAuSeP3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..338de4d144b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,16 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 1426f357d474..d42363cb5105 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
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

