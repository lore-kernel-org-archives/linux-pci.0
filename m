Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63F24468C;
	Fri, 13 Feb 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955730; cv=fail; b=FldoPQZKtoDhdwOkc+ARe86aqMVS3rxCENSHzb77AtZtfG+TZ6uJiGvhsuMFIt/0hGGJt9hHTdRbPNSnWSRDYi0ycLygnoNK5s+HZ05OUSQLkbHHqEqLQhKl3OPiIDjx5Sgd36tlhGJN+VlPPAJp+3GJPO5wiYK8XjLgUMTatt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955730; c=relaxed/simple;
	bh=ZDruEd/MKZ4VVvHfQrkn+K+6dovwVnUlvXolnMqigG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VbF44d4s7BmMuSHVDL36yZBak9xrhs1aNnsAYdLI8PGz5LKf6jkoLJJnAxPkEdhXAOwV709r+3MlKUo9rlsTKnP577djoK8zaJYl9KwfHRhba8g9raRL4XRTHF92cUBgTbvXs/Dd1SaRiQ1KQqtxyQ1kIdGaLmT3doTPzc0aFsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jzy00pG1; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jzy00pG1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4JOe3ydUpt/5xEYYD2bUUQJ8MzTqxm+BjxftVI+1vlCjfcaR0Z0/ygL33saG6VKsDzTBG8xvMINWZUOcKHqyu8AvdPC1rbBlCdiNabzG+RCrQuAbUcbBwtSoVmqxYcaOX56A4urhpy7Y6mOT4qeMlfeZR5F1eRqyrawcMrdRWAzkrwYzMCdVFpf97qM/OSCf1suTJyxVU6GkxPKPNZ2AA6mUxJmwSsJrEHsClLc1jQCHJ5tx0NpYVaBttvsWI06Ej5L+5BYxINkOWZQEu4GqT8/+f7tN+Qk/lZX40xKnGA4rpTo/QyzdB3/q5s0f7jRFze8RheHlbRl8w3mTLMJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=kYLZvQA3NgZZ9pzZUyh+bkLwZKhZhDu5W9R3C+GgVj8EViCC4b+ZIEYUzJP8hQqXKkvAZb2GCI8VVdcWF+Izw9dTQ6ZBIiWZgJuWaGBRhyPUVvVX4qKb7rtI/thjYi+IB+sW6W73dvHIHEHX71Zr8vtHJo+ErGqgJnLCuokPav44x3RUfjed4iACDWtVXLIDDofEjRgeR0WFCjXn6ASvn9uiwvpbqeD+SmRlfXaTIksBxBpkw4NBUwikPDnJsbue+CbfJ3QRAH/a5EzAONWJ4o86jcqM+KE/FokgXIZPsXXCkbDkylKtdoB3XZ535UzewYJQX1aP2fmLbMu8JrbvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=Jzy00pG1ynDgEtNDYZ7f6rBsPqfVwB7PNPpcZHYVl/+fimNs+5MLGmhn7ghjvVP/LyzryWRXDgAcJiRtReXuraJM4D8fHCdUmV9Rz23hmHhxlOIY2mK9w+Xna2z7caorRb41NyN5U4iOWSwvtO312g6UjIzLz3qJE9qhbKQULSt6HpG0c52opLqOK4Eg15mx36ti4suyb05kQLhVkstIF6tquMXQgQklfk18KiPVcHJHHTUFB9G7L7P5zO63bH25mJeE0hSkZ33Y3tq35fJqCB5ExN8JlT35HifQxIssockzZMOlRpqMJksqkxW6qJvda1GFSw1zhXi0J529pS8dkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:46 +0000
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
Subject: [PATCH V5 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:49 +0800
Message-Id: <20260213040852.3340547-10-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa633df5-1f30-436a-0fff-08de6ab59580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOfpa14dWd6FBtpdKWC7Upg+Epg44P9v3jvKHRnGDa6mgEmP92c/lIF4Dng6?=
 =?us-ascii?Q?KPQB50y0fjmwxyElkM4roO4LyyCdj8I7ys8HMU4kkspv++DRGqwuEM9qbcTF?=
 =?us-ascii?Q?xdTHjPtK4IR2WIxF8HtDIFaSYL914b6YANtQW31wwgf3Zd6+M/01GJ+4X238?=
 =?us-ascii?Q?hwJvXos5JogEHt24TrRAB6vONHbdujUCmB1OtBp08kzKV5k9KPO0yMLFgcKQ?=
 =?us-ascii?Q?etGQ/+fXD5iMtxlZBJf6RsRk9vJdjlG2zjCcJRy0uC0D3kyg43v4F+IR+7vJ?=
 =?us-ascii?Q?zK+QZZUtr3Bx05G8uksIjMdReu68GLWOWjoRiItwySqf4bjT9Sxp1p+re+w0?=
 =?us-ascii?Q?Q+b4g7619FdTwW9chTh/SxZlBJY2PYIq/KdjNfGToJmo7JJf44lgnMtjCugy?=
 =?us-ascii?Q?DbdMSaRZcJE6zxcV+p5lQyr7UiDS5wJOlCPMMNh48/QKzjWdcAkdVk400EkB?=
 =?us-ascii?Q?nEU4T8C7QK7oQPLWKk4A6wLXC/+U3+oCpBuxVxkKBVx08gKSudfLO003v8rc?=
 =?us-ascii?Q?IA902IcbCOanwFzU7dAvDjwR6BSjD51O+svtHneMX7V+6q9qvMiwnoniw0vh?=
 =?us-ascii?Q?VjOMemZe9bijt6JFyxgsx821uWzrfdr9+1Dm4shaJDfGlob9Bbr87hkYnz7R?=
 =?us-ascii?Q?9f6g99gaVwgxl3NNeoqmi50sVkOUvdo4HL2LQRyTYNF8egwTjD/xnU0Gwz45?=
 =?us-ascii?Q?c13C9JHa9TamNqrbjlgutHcsoiiwT5Dp9zB+Wzii1gZSUfGBiF7G9FKGzAO5?=
 =?us-ascii?Q?00gy/bjenelhpu05pQo3JyYyY3U1wu/Pj9iKzFLvrveHMBGoZ4zkf/D2pr3t?=
 =?us-ascii?Q?kLcmIVLuaOS7ISqdxzypOfAVUAZ0n6pb5pmM1byprgfmDAOAbvZluNrPonm/?=
 =?us-ascii?Q?VA5eZqqRQyPeQWXA6J8aR44LVKr1/DXXN5bq9TVb6A18iITT1xpN8oepQkt0?=
 =?us-ascii?Q?mWtYv+RvxNKN1AhJgGNh8HP4aILfsxbwAXJJTlhvn6EJSxVXUzkXBeqsta6H?=
 =?us-ascii?Q?e5HpAQva8jGHSKw5yMJFiJi1rvKZCJ54sqmgD4S7QZeSDnHaClekS1XZzNfi?=
 =?us-ascii?Q?x5fFduWGG+eFetOd7M56eA6C5qeCVpTow9f5dXzkLkB0quzYKngcHSt9qA/F?=
 =?us-ascii?Q?5TnGeyF7WKbr34CpVrRHGYNmFldYItB01DwvsDXKCNx0FTG6WeM70h4dbdCj?=
 =?us-ascii?Q?LmQgNMF1rpjQMaX9tjk2fZiHxP2MH/hpyT6IrUkfLkeBV3N9xYmy8mWtA2x0?=
 =?us-ascii?Q?WbehE8iFWxvGcfEveIlaU/evE9WV8idSQINt+W7WVBUBSCnkWOiNeKRtUt/R?=
 =?us-ascii?Q?5Z65vr2eEGtIFC8Zv537dHkZeiHW2QdjHv0NH7e1xo2jsiPYOdH0RMKMh1Wo?=
 =?us-ascii?Q?P5Yiz+KUi/C0ellVt5pLIV4Sub5lrNvMElFLAYALyWb3MBoypK+Nx6Pmp0TK?=
 =?us-ascii?Q?3p/BeEQADQH/KgoAbXcuJD39m8IKOONUT8l2VsYS9StFA7V0g/56n2V7Biud?=
 =?us-ascii?Q?q/JeuKVRu72K2D4T50JGBq3yBdd57p5lvzcE/1HDw4FZ0G67TivzTXy4tn2D?=
 =?us-ascii?Q?0yoZZdbvsS7HMHrQ1/wFOCvN+OGUK2h61ea54PpKAB0UyH6CLKL20Pzt9+VL?=
 =?us-ascii?Q?5gimxsP97v5g0HCz3B7WpX48MObLPEjPStRaL6KXW8PH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2Jbwyk3cw/YxvWHbG1RjRONTGtX05/HVmfh/t5r+AKTTPE5C//qrAYOHldH?=
 =?us-ascii?Q?DjEWeebOz/+xg08DV2Kxlt5maLkyxEV1skKUC9dYF7qXX8A0DriJWPPK7Yed?=
 =?us-ascii?Q?2b65Ww8hP7PGzGX+Q2lTOul3uY67Bx36Ec0Rs8fY93sHWNiupnJZT69p407I?=
 =?us-ascii?Q?g2sfzdAVlZQyy3RdRmrUus1tlNtwbpBsGulJzFNrM//lZ5W5Z+Z6TrsgG2zt?=
 =?us-ascii?Q?LAHunMV3DZNfu24s2FqoyCk50nuPVbfdbaKgBD9yZ8C73c6sERx2G15rAfnU?=
 =?us-ascii?Q?JPtEaMGjGuBcmIpwU86Iaf4IA9PsERq/vDM0NVvxZ8rQ2Yg87ep17iIEA8yh?=
 =?us-ascii?Q?ExBLCJb/li5+hD0BZmMgzjxSOu7eOrqlr0A9OkeEMxxC6oFbZI/tsCFGH5av?=
 =?us-ascii?Q?6QzSKGOAZmq3F3ensWxpgdMkIn9vu1Lyd+zqWz+hEuwEGGF3p7Nzhdy8DWoQ?=
 =?us-ascii?Q?vePJrlIuDou8e79pJ9Ud92ed/hzSYefus+SRqzfQkvxvRkpizU4e8V0pWnJD?=
 =?us-ascii?Q?qwe5QVVYkrBPNy3c+DNZjTzRagsXXd/yfq8JJPz54RsQXtqEnNAMkN+iTCag?=
 =?us-ascii?Q?C4/hOBoU2oK0KcYaYf371/V1EbvqNuRMuKL9yamhV1ByaEHp5jX4g52Uwfmm?=
 =?us-ascii?Q?zPSgNTPxd+/cpqpKo+IEAStxbcd5y1PkwdlaFLt9PvT/3r/MLiHOnleXYnbh?=
 =?us-ascii?Q?GSk5NZjbLo3IQ0DsXiqMRSZ0rU3iGuBEYqIsOS3CN0Uc0bQ7kQS0DA57FhRw?=
 =?us-ascii?Q?+ICfbXXrM9tLbFnE/W5vGA6XQpiZji1rNLFEIzpBOiiFR7fIFubCzUXwG9e0?=
 =?us-ascii?Q?Js7s7zUrh296DB7uQr/WzQu+n841Bnm/bW0VPFPhbvIRBehPtT3HBt8227/7?=
 =?us-ascii?Q?EWFvNUBW9KSg4u0IBHf6ltHE+RSVaIL8yzpxmV5E53LOcLyj7io0PN3uhUsu?=
 =?us-ascii?Q?26doWavl3cYkAIQ4Z3zQOF2BzLN04WQ1aWWje9GviS20bnyBcKAYYy+nTVin?=
 =?us-ascii?Q?UIiJU2p2zMbvcx+ppjYYEfwfkEwKfONzlybEArQlqCty3cANFB6S6tBrwWkK?=
 =?us-ascii?Q?tu4OVXFqgtQN23egOfyKJcMQC6eTa8eOHejlXDVr8fZRvfUl0HJt/+K86noW?=
 =?us-ascii?Q?oGOSTHOLLvsCYTFBX7oq7OOIrXBu80M7058dYhucQGeiyAngjHHp3A+sUADu?=
 =?us-ascii?Q?4wQcptDTGff6bYd9cX8rRUSYL2LpXYDt63Pv20Dd+4BaMMJKnRfCqDZtj3dW?=
 =?us-ascii?Q?GHFRD3Gv7NuCxHkjroG+dsO+6IjMRLZXKQNn4L5BgWDy3MA9XLgFalwKBpCS?=
 =?us-ascii?Q?kizj68Hu41H7zkuHs8qPdQW4MpH7zeqFKlIoydVs/Dfo6/ct3iI1k998O71B?=
 =?us-ascii?Q?GCk62MYt7oAhNnHwZVO9moDL8t/D5gNLDQhIB2pPvnf130QZ6RZCEFhmGiJk?=
 =?us-ascii?Q?3wleAVZZenYALOBu97go+uMXVU/fVD1WLYt6sXudOHT8RW4yQV4uXORtkdCZ?=
 =?us-ascii?Q?JdmUR7NpIlGt5ISUrJx3/sGXKP3i5GuvM86gTwz/gMDSt+zQQXJTZyUFcdn+?=
 =?us-ascii?Q?+Ixz7I/EWRsaAIdmzSg2QFpKuOrIcZmZ3Ptl7ntiB6QLWRhEwpM9enMDlLv2?=
 =?us-ascii?Q?hLJnTvqb6wECSSJgzmrCb00v9JUZn3CjOn4y30xI8coj2v6rvXM6w+yLhE2A?=
 =?us-ascii?Q?kSA2zyCaWSy69PuvbLGyUiHE4Zu9NxZ5iVcre5x7ZQhP6Xswj/vklZcyII5f?=
 =?us-ascii?Q?A1PzEIvxww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa633df5-1f30-436a-0fff-08de6ab59580
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:46.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh9BsOOr8WpYZiBs9nxirf/kmpoYe6HDIMmevMiRdZPQvjZQAAb/l7hd5LzUU3dFcGfKTmmM/SnSLAArvY/3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 50850cb6d287..dfcdcc739ec6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -769,6 +769,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -782,6 +783,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b2b3a9bf9e8..f66667735a02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2266,6 +2266,17 @@ pcie0: pcie: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
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
 
 		pcie0_ep: pcie_ep: pcie-ep@33800000 {
-- 
2.37.1

