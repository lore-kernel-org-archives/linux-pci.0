Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A1E8826;
	Tue,  3 Feb 2026 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083746; cv=fail; b=X3t0jvjGs5MrMjn08GlMiVPXVSRvAEWWQhvDLsgmf45FUtdy1ckM8I3/DwNBNzjjKA5wn8pCnlS8qDHenBYETf6XrJdF1+kPOYEtIJg5x9pI752RNKO6S04M8eSzeHDDqB+Exj/5I9mOTK3o5DGlA80gQMvY1emUrTj45fK/SXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083746; c=relaxed/simple;
	bh=dGLGGGayHF1kXMBXPouDMRXOhNmIWfXdQITz3dlnR8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iuawWDUE+grbftVrkNw/UaDRzXz+TJ49hH9tzm33LxMdFE6yAmyfys3Zq8gP9XPAbHNW4g2gB4kXizs2wzpjp5pyPk3LIqZxfGOuNvnO5bLHysueB6R5PHsiW4q8Fdkl3lDh2OISBhEUS6nKKrgDMmoDQunmm1kwcB/0RQoaGGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TKLSBydC; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKLSBydC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vknrWAeCjh4dvVIo7kQmuyBOHgD2c5ddt77CWfrLNf/pssAHbJQVMJcT4g7ogtyQkMp8DoS+QstEX4KUCYXE8BPJHbhm5LASBBNlCTZhqKOqrcnY1UAy8gj4533vsG1FLYhQJBIMDsq1YJFYtWX01tGDup4zDfZvBsFoyJerQSBx4sDU/mN4RiS0oomzGTYTES5S9vNriacvrWflmmHXHPnXSrpGViMTue225KOb6UDv1BQYTbVeRmRPGhRun5aqtgKYVv6uWn81gfb3C1Lw2a6HYl4Cw4jdNWBYLKB8dk80GAo47v7Jh+0+wXNW8+ScsY7i/1ETjXcWeMIRIdyQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=IJe19xgmv4N/mwVCoIX92tFS6jkelfHHZIN3lnfrsfNLLb+dA5YGv2d54tazjStu+udgvZKtg2n0z2wiAhGXmhA13kg8tCa/bTJA6Pt5hZmhszc2b21H9Grouah0KTsywA9n6rbqmj4ftZjk+lDOzkBuA7/Yz4rvBlUaYIUAIlDsF/Xae9LTlJC/9bXIbQ29fQ0a4ek/g/K5/ylgrQA8cZq+VloVPe/qjqqrMRL7fO3MZz5ndsJj5nX7wCLo5W4UZXYQYCohcioBvoQ+CksrqlS2JJKz6YNeGfgJZ8dBmpaCcI4uUEiCvfCgFSKbHDeZLGvQ8TOTPf8km0XWypSIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=TKLSBydCBNQPRKq2me6vNJOrr2WqM+MTIZEJEVbXaJCo6KuaXNdZGsHy7K+AGpCHhTyz6XC+y/Lzo05fVqpzASNuyC61jzvPtVHfndeMz+YcEN8OolhcfzeakwK8SieKZtV62LDBgH0ggcOWsw1iJY9fArTx2Yv1ALYpVq7SVcD7THtJNMDkqHfMlH0VsjfLL14aaCy2gkYNR/TlgMn6RsK9/MKn44P16sZm3wHu2V6lsdV6REP7pl0hP0tWIfN2t7qWyJgPTPv/W5ZMBlrcf/aYtYY2ozn5iszkowoJL4wIwPhv4HZ28XnhwzbW95mHJtssQZ32H1JkemsDampEUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:41 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:41 +0000
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
Subject: [PATCH V3 04/10] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:08 +0800
Message-Id: <20260203015614.2957479-5-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4527f02e-5f93-4a28-ba64-08de62c755f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDsE4EfRikOoqj+ixJAIIISM3XaOFRtu1JoyqDmLeJ27+Uix+5E3kmN/1mXm?=
 =?us-ascii?Q?WivoXPRY5Msb9Rh4GmW+K2r/ri4JfxlpDcL4j+WFSvbBF6y0nue0PgU4t6Qz?=
 =?us-ascii?Q?xsy7UlnFlb6J/LofIubnZeNTbRnJKEG+4cFCvK0CX/mHenBmU4r0MoOb/M+c?=
 =?us-ascii?Q?KjuIDvu6ft/yuZV/uNcVDvoTDEg9Ckti8uGDA3FiG0a1j0JWrn2OK2hH8oCT?=
 =?us-ascii?Q?l6CSJT6RQ3IyKlKUqmc1e42NNOSTfoAT0wm2N1cF2b8kXpWxqWGckjNbJjSF?=
 =?us-ascii?Q?Mj3sHh8s2Br7BkCYiLnz6zxSSp1iDn5d/rgcUd80OyGgTzuf7ecSt2B5E7nu?=
 =?us-ascii?Q?GOoBUr7eLIClrsCuKGd1IZ2fFuFqfvmjTcBTw++S5YKFmsYqI602BqtexNms?=
 =?us-ascii?Q?q38eVKaMMje9j/EpH80LmgnLl1mjKbGpAhHPG6T3gJYwnlimHldOYMWn10Yb?=
 =?us-ascii?Q?5vPCGnB9hK7IcRefQWJNKGV0PadZU267VUW7pDGxHyfV/RITHnKU+fMI1Va5?=
 =?us-ascii?Q?+QwRY7IU+5VxPbxugdh1qiyxFhV1xfuxsxi1T/9+2NBDFUj55YZcUytecwKk?=
 =?us-ascii?Q?DUgANqNVI3yINw5SMIIB64pXvzltOgmj6QGwdH/RRAnl9w58Di9S1o90IY9b?=
 =?us-ascii?Q?e4um+OQQVqb1cnRny4Wzu26UC8mCzvBywaYiZ1dUH5aoLFwBLxRFoVUf1RrT?=
 =?us-ascii?Q?XHSHIfR6jOG6Fm15F4lVSbEyeYlbWOJK3X6JRWwo3lDXNT7MON3mC6jtVIB9?=
 =?us-ascii?Q?H6a6fw9kHJF6DkGLb7qxIICTa8asDVsyj2COJ4RwGOhPGW+1w1EWmx31uAJ4?=
 =?us-ascii?Q?6HnXEWemkDWZ/s81g+toY3keiBC3urNpCLPlsLUkdXkcFKDKU6w8W2s0y4aY?=
 =?us-ascii?Q?nA+mkrXqa/im1tX/OzRp8XaGk7EToOGbePuq5iSZK5FPP2AsvMVJahyyLBrG?=
 =?us-ascii?Q?ABZ2ICf2AsWNQIgNzbMtKaoj52+bi+lYz85t2FTmc3TcLzElhxwlSSSntAz+?=
 =?us-ascii?Q?h9PiZ3O/Q3bw937vyRghDGPuNa7EpGF9E7wA/Z2SMgC+AnTjX1yIUj76sA2o?=
 =?us-ascii?Q?0gosh2vI4o1UEOhGQj0HZUyKFJggP8mtLcDmuI7rSma5wgXMeJPTB/IvEaal?=
 =?us-ascii?Q?jQgZKnlWhWP8VhPHmeRQ89qUPJ87eQ0PYjBwr5NOIeiK9dGEJqLnqBruTr8u?=
 =?us-ascii?Q?UFdDlXg13RpxZcHe/+htHm4XEnsnXUSZD3LxosI9+6pe7rF+sfaZ/sz+N5IZ?=
 =?us-ascii?Q?qRVuQGbOm1M0FxaxOoRFgyyZk2J0Ud9gT7h+bsSsbYXRszo9v79tnmypf65M?=
 =?us-ascii?Q?JgCnY/v7WkFvxs0dzy6MNP3vYR/gQ3LwrwQT3quC6bX14+hyJHA0WqcPtSqZ?=
 =?us-ascii?Q?heq2hR2uajY6k99kqZoct+knNHStIZQEH9W+ytpksiMrNJknRHDQqEUFn5wp?=
 =?us-ascii?Q?x+znS73YeSK5glGP4JVQiwfBDlqmNT4K59GFQOzWT4XlURmTr3whnQTbWMj3?=
 =?us-ascii?Q?hgc+SRp2lUFfMbYDpnCBPA1mZePcel9ebEQjVNyfYoWu+sTlyk4CRqCmGnZo?=
 =?us-ascii?Q?hd64YzVoSpgn3MjL8DbE7aczmasCut8tYLp3Xl6msBHUnhdbQzjNQ3WBEqsg?=
 =?us-ascii?Q?re/y4Z/lR5O+kswmtam6EhhMRtry4kKFrZL2XIrUXMwO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpb1vyx79nVRWIow2diAjMX9kKYfPtd2fgMQ707Ss4JrmcGp8ASGI3vuX8OC?=
 =?us-ascii?Q?VKNxt7Hun619FQ29pnZA6Pp9MjbnPalHNxOqDHVxkDdlXBtXEeREstDy8P9C?=
 =?us-ascii?Q?RthWshAJSYc9/fNw/Wvqk3Wy4YmLKgz8mMZUHreXguFcgJOuEVLYc+5hJEdg?=
 =?us-ascii?Q?d38/2aj1eBIQ/tpFhTtv4Xkkk3BaLPZ4OwlSokMmEuSneaTUsswhts/EnZk4?=
 =?us-ascii?Q?vOnSlytXyg+bAH4UhjykS7g1ZURkB72OQkojuEAVWJjRXyt7QiLpMMmeFh2c?=
 =?us-ascii?Q?DLLrfXf5hQ7/XFvPauXLY6u9O88ygJiPFahwB05nKPN3Cq2GMYLPdVhebIZn?=
 =?us-ascii?Q?d66WaDfbl7zreOlkYlMrL2KBhFZXlsrDn3x7IPtYK1E9yifYkErBvJkIo+5m?=
 =?us-ascii?Q?ue/nR7zeJXqKbUKcecroolGPQx0v1kO6DIcBJ642K+xIk58zz+RWkEjvPAlY?=
 =?us-ascii?Q?8WV4Ak/8L0ibY9iHIbIsKolYh3xGkmrionNYNx7jHsiM6urai4O9kW1Ei3dP?=
 =?us-ascii?Q?0S+zuGabhCjhRvuiZ7mGnAZrF+f9DX+mMLNZAlLosCuXwY6qz8vxPmF7i5Um?=
 =?us-ascii?Q?gaNoYQ9C8SE4eIP4+r8SL6vTlD6fuQ99U76kCPuCLI/eiROb20BSxWbKuD5r?=
 =?us-ascii?Q?n7i8H6gEczCOaguvu43YAEgPAxVE/OmTPZ5qwsn63FRl48lcjiEUc+vAcmVJ?=
 =?us-ascii?Q?pBEQd+tAMhSorIeJwCQHQ+M94ttLkXo8Cn3Umo9oGCANUbufUFoBPyetUxCg?=
 =?us-ascii?Q?xcP8mIH5LsMLUKiHF1NkegkrTC61D00/pVshPtO/UaGSxzq8Ox0MLd6cM+Fy?=
 =?us-ascii?Q?4zdbXmkXZx69e/KFDsTf4F7QTyPpI7XxmV1AuebeGwnLpQFSfK0AIaOgJXyd?=
 =?us-ascii?Q?qdSWHmFhH2iUkD7/MKxDcNj2QPbNVr+VJUN5DsQ//zL8qXTD7urioKHFP+C1?=
 =?us-ascii?Q?Iem4GJR216qUqBT7jLTijJc/tLyC+qdsorJ/GDLvCd2r0nb9S8qfF/cb3rhJ?=
 =?us-ascii?Q?D0XmdF39vThfp8xtd1rA+IllkZtWQGhX8xwVM44YUNvlc7oYsGlGzK6MmaQJ?=
 =?us-ascii?Q?uoZPhxO8GRng6xRgHVzcYmMXHItRqCbFVK6Ys8vHNVk0xdXm41eSE9fjjrbZ?=
 =?us-ascii?Q?B3GuK47oxWUyQraQvXV1NYOwGKW0u/klCHpAb6qtHqNeQXpyW/zhkljsZ9+G?=
 =?us-ascii?Q?gbmVVw71CokjyNeWSz8N6/QJyTUjv4Te5kOT1L/VDk8wqJLdZcvXsXGfiZsx?=
 =?us-ascii?Q?qP4C1Y4QHTJTj+0erYkgxrYJHNXSAs9LJgMwDnFIIeColZFSLh6LEqayJ3Bx?=
 =?us-ascii?Q?nobBhDn9iZgzh5WpJI7Vl0LyV3akEUecOrWieRlVZx/VYuTs8CFmtZSm+io3?=
 =?us-ascii?Q?E+Ubk1i1PlH3KQve7VTfMX1LV5lp/notceh6Llj9bZPC+pwJGZVw6mRlyemc?=
 =?us-ascii?Q?f3bLevNPx7cRKS7jFsuUP0iPmvb/fCPlQetZea0XN2qjs4EoYAlMSxLFIqo0?=
 =?us-ascii?Q?+yskrrFgz9CT8wsmvpyI5z+lUtnlIBp+0iBa/xW1iIocMvQNb2y9OlN2rdr+?=
 =?us-ascii?Q?FsXn/pEDyopsEAEy5J5BJwRcXjNVnRhXzHrKYjSNszAASNnd0RmN3/WdOj2v?=
 =?us-ascii?Q?inyOFOrMvPM4SQ9FBJii6UY1BGViY2bytcqO1lfxNa1EuOB740Xxd2NVErUj?=
 =?us-ascii?Q?eAKNZGWWJ7T0evWrnOEkEpOiUuwKCWT+bOTHM88mjwjgJRWF+04Yrdegf1yd?=
 =?us-ascii?Q?J4yYwID9mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4527f02e-5f93-4a28-ba64-08de62c755f9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:41.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+4ggCNUQV2m6BdKHF31ZDGnriXQf2uLg7hLEXawupFVtg1pfQVzIYtdSvQxyBF27G5fLbIYdwYVQmL0P3tLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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

