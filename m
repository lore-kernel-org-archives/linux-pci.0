Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F642B753;
	Wed,  1 Jul 2026 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903092; cv=fail; b=aHAvkprcYGX6d5Wqimd2SaJi76A8f8aPSN+tC+G4f4mNBqTAzfcRnOC47W3EBxyW+B3pB5pe5f9VoyfsrGYj+OwHwj0gp/Fb5WXKAH3j8DAb0pCDbc7neznEvQxkPgdbg3uSnAyN+vmltmJZNLi5OQhz5bcUaMx48k0jSVWGYYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903092; c=relaxed/simple;
	bh=RaNbqO8xDaanGeug4p9JSGpNcrpRh5WeC2abojwSVVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VViSGXjwMZZtQmkRwgswJdyP0BUnnIGEjMeJQBRlCIlIeneIJKQG8XuSTH/8EezjRisRvFPsjWEdzPRr3j1ArG5KN9z5ZazDaDCnUMuI+84HklSzXt2HRwSCgNYMS3JVeiy3vY5PhWJb/AIDNeSnZXzYWYso1tdsdS1xHYGwpNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lmrC7FQ2; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lmrC7FQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCpLKGviF+ebW2jNyzbG4fqsjgLp6hDelPqNxXc8Zb/PwEvstHJsO7FGGa4Gp3PABeEtl8viMEwuxB3JjuxkzFbXZGLh3yGEj1PvRJ7ZDBPmklQUp3ldVsP1cY3rntxtXWBZ7HD4Bc8jmiNJ55yTzX+znlH8M1VygIJldE4XQIFdnOOLG3vwQm7wszFiJrpp9zV1q4OkiGNk3/CvJxkZr0HkbsoZKCN0Mh1RBpcEDWjK4Bbo03YM49eBglv/QkkspcjKBlfQXOD7yfJTmP7NL981K/VYMISU8nK+QU53nrIsAB9g5Ld1eNMl3KauhQCHrYjOKiRESk3gEdi+hcWgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3xcKgsHVEOzzQWLbdHR+bvYzUbolVaNe8LkLsMG9YU=;
 b=ndGPVXjW0vn55x7vgXe9gsVCIncU4VPWxgw8IMwidzvFt9BRwB+2LiU7TR88JaCUHng9z9hdMfvMpVomecSS4ksK50rlrFV/wG7vDGn9xqXjzh7OQ3XyTWQz3AQYFHRIBSp6sPUrRvTk359iXzfGFb6om5lnsYmU1yi88ciGKRUspKAFvFWQ95VV9M14UZxgHR7v/LOJ9O+nm/1we+R47tspApbWGWelRpfZyYAdcQEAZn7XCoI8wuJ0+XHYld47EydXO52IyNOv+/M9oE8cPTy4TgYBR16TCziXgl4a0YnpEvo0Ee4nfMQvOcUoXlhyUUYwlizbGgsQBrGgHEuGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3xcKgsHVEOzzQWLbdHR+bvYzUbolVaNe8LkLsMG9YU=;
 b=lmrC7FQ2Tr7qlj9x5n0yiYrImZEpXGDExgTFPsTNT0QSLAqdRwJ+PtIms+TDM0teaWgr78mzO8jVoH3bjdmPVIszNyDrD9Q+v9A1eAv0RdclEHT45/B1HNBjO4IAVKQTMqWbTmOl+vOJBmEOgJnLcf1qZzo8HC1hfczJaHc/bZ/txLK/jyO2yHj7zv97Cl2P2uTTqeGoLU2MdvWXfDRcsHFgxtmg/5jeVn2e9XCWUybB7yz2RCtsSVLpeGL7RzdMQCgsPiOX8IGRE48eMZlE4c+aRNDFFje15eIiyGL/sWlsZu9jy7jNR3wRgt+4ZfvkdetV24LIgPGxdl9KK2uysw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:51:27 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:51:26 +0000
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
Subject: [PATCH V5 7/7] arm64: dts: imx95: Move power supply properties to Root Port node
Date: Wed,  1 Jul 2026 18:52:34 +0800
Message-ID: <20260701105234.198987-8-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: 439b837b-2c25-4797-4a65-08ded75eb343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4pUO6COJv/qzVMyXDXot5aAsnq0P/CbsyD+HeIEFXVJ/daqxV1qDtWCCJQtlM4f7GoUlUciVjCwXQChK+26u+xr2r0QuiDFJ5O61g0nOpKTJpMdWjUrkBgsoPG+YUcLQFyQR62aA60UFs4F8bjMlTFLiPHzViwYbG+9198R8u/zUzOOYicNN8JiozEtAkV5qJVTtDos8XGBTXy8BokTSEzyv9VQL2Y1/8MeH7WoRYw9SUIMxnF//xt9wci3dY0N1/INkULj6J8RXU8FDDVCZcDHKr6FM/X4L9EJFzc5T26PYQRNY0mgytUmtd2S6IAJ8L6iz5y7q1kpMNf9TAMrNZ2Mcp1fNkMS5EsWL1JOnqEyPx5p81wLX1rvsfGNuOJUf9a/6HlH/W2/D41mR2yY2WZli/ipnMdjLg2XvyIFSDqel15n0AS65Sr14GO/1Ni/ZoNZu+mhSnlC8Xjp978HiSnd6QKm52q1dwxXbIBgYk25eLf2amILzwlS539bsl/DaT8x9pF4NxhbdaiIoaONzU4N3xi38zn/w5MiOX28tjAW6w/XBlmJMxKzepcRAO6p+OtdfutF8tKSQ/i2qwciQVxrGI5wDTpRIlnDYlMHm0MJztGwD3eF3+veblWhB3MJTFWJYqGf9wp7QVLccQTmJF4ng7i7YILS/OAVwAp60obfPX0oAPgvfztcqLkEdzfNgHb1nlrLamCuEk7jCt1TOjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkdJg8M6MtJoiNUsbFNYX1h4hbfBXsDoFrLfrTwgjqfHTGpj3HAwGWF1NBqK?=
 =?us-ascii?Q?dKhYPQSItLLUzEThAo9BE57TMsxiExvg/qObv7ndn2+Z76DduxvV8wCx+cuM?=
 =?us-ascii?Q?dWnirYgBpHpjarq9dt0P+saIogv3yK2AVBnMFAKZH9dJJbGmPjWSmR7KrF0E?=
 =?us-ascii?Q?xamTg1+D5OdxIewvX51adOilamrftYMi7zbZxDBXcIdotBQof+xbxZMveFU6?=
 =?us-ascii?Q?vfImcuJjorP2X9Kqwu9r04Nrpu3j+9uC+Ee873oDroF+5B5tLiM5HOi4ZjnZ?=
 =?us-ascii?Q?nayOaEdgRMNw9fQYFSqSwAuSh0oFEFgsY28stLL5IPgWERpsSCzE7sTvBSvt?=
 =?us-ascii?Q?Snv6Ay0PfCy2gD4m++nyUPYJi9+pLSpaslzBj10s7hyVFhsj/eZVHpktq3Ww?=
 =?us-ascii?Q?pfU9feY+A4JF+lq0y9vGCQ+Tun7iBqsyOlP/6DidUjxefWAUoU5+VWKP6cf1?=
 =?us-ascii?Q?3Lpz7MEWTgu94tZTEmvejFxSQvORBECZXTofbsPDAuHe7L3Io7n6l+Ke8ECR?=
 =?us-ascii?Q?aG0P/yZ5zns2JNu+dcRdQyS94prd7G0mX3FYhqoTRClqf+Cjyt1pje4fG8Z/?=
 =?us-ascii?Q?VyONHmz45RhNA5R2dKk6pX+BLYw5o7F+TiZ+MbUrdy5aPipGtjdOfCIkgH2h?=
 =?us-ascii?Q?NwhmdwrmN0rYQL64BslIJm6S8liKqW0QukFJQ5dmsF7eM3UqSV9cYU82+Osa?=
 =?us-ascii?Q?a0le9lchWxZeodwWqFz0zk3pGc+WKrtsLJhj+vyqMXk4j+lss66+QRXZaMYk?=
 =?us-ascii?Q?CX+iglHVq97TfGZsousgm6K8crIT4tc5wowAev658g0cUIEdumUi/xFcbBnC?=
 =?us-ascii?Q?9twdiJPj45juYlByKXIiAqC5s2ebWCUZdq8YMFYphbXqEPHXvB82AFE+W3oA?=
 =?us-ascii?Q?F/TiMrDgMIpwp4IKN078kFUgT09m72H2wjULQ42FzhsxaE/JzGhm5aNz0PNw?=
 =?us-ascii?Q?6Gb9JJkCc9wxu04gBOC5Iysciu0VYNMPmZOd5o3QUhjoj4+LUmDfXvageeRq?=
 =?us-ascii?Q?V17BKmcQ+FgAC9PdCrqztcY63tCshp2aU3rUR73gGa6/6ouAKzRZg882XjiO?=
 =?us-ascii?Q?uolEHcS2/IzSJbgEIkYcZH5Rkw6O+fwQS5gDmdThTcjOCW6PPA1cKZVFgjgp?=
 =?us-ascii?Q?zaCdc7nP4MaeA7xd/7Bkz1fA6giv2K91wzOxMVsSEMSAWxHuAAHfJdZ4Tykc?=
 =?us-ascii?Q?CBEuqawoNNHhnDBTadHFYlhTVQyZa3tKgdDwZz2mfXPQCZR0GFRGfVmydr5W?=
 =?us-ascii?Q?8WKpw3d1Y0nkmSs4QyZOBsjKAdOfuYT8IM6nUeN7y2OFhdiD5d2wvfDi+xxm?=
 =?us-ascii?Q?ArWVuhArKOjGBUvdIrVvJR1ZB+97tVLV0DfZtCHrdMUR9Blj2XWldSA5QXM0?=
 =?us-ascii?Q?DhMJD0D5pjKwezirDO26N6b8mOngQBn6BYKTddLdPr+dMBbZlkcwSeGrMmwx?=
 =?us-ascii?Q?D3FNJyRMrYh7O270CxlVWq1iEUxLKZQJUuM3XlyGfbtfZh9MkLYtmKVCA3ws?=
 =?us-ascii?Q?85MxXJALrWNznHrC9vJ7VCSAoCKIEhtAlxQYREV+KfxWF3q95lDEugzjJi2Y?=
 =?us-ascii?Q?Qd1P23irf+XOZiUQ45T4ZNLaNZD82fb3fLPNpmztZTpk4jI9nSNU9QAySVEq?=
 =?us-ascii?Q?hOy7+/kRNCzMRS+Tq9Phvla5RN1FiLbppgiltD76nBGs5EI4MTF0V2a91/rp?=
 =?us-ascii?Q?NKyTHXzNtu3qU7Mo/P85OFWMI3etfQrOC6QMNzV+My3zUBLd4YUnJ+49TMv/?=
 =?us-ascii?Q?qK53DA9fdDrrekWLbcHnwPygZE3sPxGiXaWPrlt9lh0NouCMEIq5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b837b-2c25-4797-4a65-08ded75eb343
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:51:26.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1mxu7HLn86Hd5e+si9N70KK/zzn/RmG3AQm9cvtTqU7+gw8i7ufFkqNmQIzQLM7lKjaDD6fA5qg4sY6dFAppi5QOWM+zpDesTEOlJpLS2NQg9BIlNR6ww2LHaNyFD4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply properties from the PCIe controller nodes to the
Root Port child nodes to support the new PCI pwrctrl framework.

Since i.MX95 is the new platform that under development phase, it should
be fine to simply move the power supply properties.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 7d820a0f80b2..6aedcbbe915a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -555,8 +555,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_m2_pwr>;
-	vpcie3v3aux-supply = <&reg_m2_pwr>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -570,6 +568,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_m2_pwr>;
+	vpcie3v3aux-supply = <&reg_m2_pwr>;
 };
 
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2e463bc7c601..340ab0253ec2 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -542,8 +542,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -557,6 +555,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pcie1 {
@@ -564,8 +564,6 @@ &pcie1 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_slot_pwr>;
-	vpcie3v3aux-supply = <&reg_slot_pwr>;
 	status = "okay";
 };
 
@@ -578,6 +576,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_slot_pwr>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
 };
 
 &sai1 {
-- 
2.50.1

