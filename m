Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5142882C;
	Wed,  1 Jul 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903046; cv=fail; b=kFjuxhOdPSw1sNXtXaNaitXqlwlwrj6iBHVU2a6iN23/b8KvpXVhvGAitIQOcq67CiPs50GwlvbNP25VZCkvkUNRLMv9cxzf4vbueP8/X6lNEkcOSH4cB2d0Aa5mQIicosdylhO6/p7F6sgtgTnaWpSHE4ii9fU/VwuRPJeEh04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903046; c=relaxed/simple;
	bh=Zj4XvBGy9TWEcudAWvs2POliDQxbj0eC2xhKQCXiB2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYOY0/Md16ECw62Tt9HCcaAk3jlpnCXHTwPnkJ8jIeB39zhm80PZyAXoW6OVcG2g/+wSU5nwGpIsqX/UrlCPTDlDOmFBEifonHpnboh7ZbhspNrjbB+xIDGXMu2y2MBygkNB+mlzArDX2A4XQ/pFXHRjvT46aWwOany7f4yzLuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AXTc+QCB; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AXTc+QCB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFU6DsRghxz0DUU2CN584g6qfTy8hoxbLTFwofFs3d3yFk2ZSEeZHNsOapFi5kOY+9K7kIIRj5jhPc40EmSq4zqyaEuvVjGoxykRbWJZtQWrBOWY5wmMojY+/KNhkpURvr82fzgbNeIkNyOCitbztEsMl3Khqc2R3w/yZzCK2jjfgHQkrTSVXtr9XMszVTSV07OMISzcr1lGMi3cQGTJjY54dOEEXpWbR2ABK2QXzCs49Vpr8RvEEWvyOhocm1Z23RbtIshublwD6MjJgAb4FXe4kvbFY/4IDUz4jkhl6WDDCkYhLY7JnPNzzcp3NUiLI821eveKnH9BZ239TW1e8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaJuN8FNlh5ryokBGjh4M+UJmmu+ghcEkBKYm12uVoc=;
 b=EshLckm8K3wlZOJgEfcgBwNcb6z0YkUoPeIr4sBwEqPShKlG/dZthLwGJAnpx1SsDnXzJVELZBb7PmDUFz3YN77GvgUGhOYznH8uqq3qTYd25ekMoEvkh/AJIjk8AeRhNbg+2JBO5uDB311BpLhVM3NHUDMSGccmuvJtMDkj9Z1Kxh9P95lzB2PRZoIL10+BAVtGukribhTuZ3XfHCIDp5fRuOeDudZo9juzZfB49M+E1TDxHq5pJ4yW699w3iW7YkEb5Ib//htkukPOQho8vFZhfVcWIHJyY5yxYfN/GxfdpxGa3h9YoDGu/itV59hGcvkBLvisnFPlR975qOMqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaJuN8FNlh5ryokBGjh4M+UJmmu+ghcEkBKYm12uVoc=;
 b=AXTc+QCBZLKD9X8re4EvDMp1oA2Z75ytViEMvlzcKvJN45gQyBrY7Z8B/2fbt08OJndYegfbHqxFR2biE3yT5x9gm/12e3cb2d6J7YPfndeAiCU10vO/PZP6vmTj3P7va0V9m1vZmJI20StMHsJGYJ+fzCo3uuPRZDu7ZQ93bkF7eX/Oas0H8uh9aSwosbkp8TOasmH6KOToSK89sWGiL2ZOxMU4KvEJGRxQcxXU0lqg+CuYWEdNOSq1xhIgVocxk2D1YJ6M4gWWGk8gkZvvd2KwzMIruq/FMAUWvr4zT3IP6q908d3RxfZCmPpAkic8edrjBMwHnJCGMIQ/CrtsJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV1PR04MB10252.eurprd04.prod.outlook.com (2603:10a6:150:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:50:40 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:50:40 +0000
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
Subject: [PATCH V5 1/7] arm: dts: imx6qdl-sabresd: Add power supply property to Root Port node
Date: Wed,  1 Jul 2026 18:52:28 +0800
Message-ID: <20260701105234.198987-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV1PR04MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ac6494-4b84-476a-afa2-08ded75e9747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0vARrQerD4YRDpa5bFHPtBVk5Ij5dJVgEKoyhykxanynfV6TwbjfYpuiB6kyAlcGAwxo5BHAaA7q3xXCizdBldxSFiXcnqxNUz9MIWL5EJ8GkkdelNGnTPgErCKb0SJcYHhyDz41hfACjkHJFe/lYy33VaDF9Xmr2Y6de+4hMYMsR1Q1Uxc8xQDuaO4Whf0OtuGoycyeDPvyOv6S/Sl7YbHMhbT6xvDyilpGsaVw0GoVZZzFrfqu3zOZOEP3WFTzidMNDR0jumjJLIV3JZAIB86a/vyXVfbg9mHtWLz6kiPz3hgriECjz3V+zQm0qTNfMjgtZMFOaYzVVHqPa/5Iv7U2jjzCRBiD8P88Vrj+rDte4YGz+Nk38pmzEBBUGnbXVzcGmv1Vjgu2pbsOdT5WeehUxtBEdyjPCk9MJedIEt/qdP6AMT3oMHpOhAlnwvyXd2hkW415EuTAoxiSnVE8DInwwJM0+4DVKV+zfUbzdF2g1FBBIQDMgCEsC9+u0y9mHAYfyXhP0HUWLyjG7a3x1ltRT3KWHX6a+QnjEqsgeYwwRWglc0JcLM4B1Y4OgWsPrsa1n+/tj/VGciSD/e4LEfhDN+PX3KGryFm81zOTy253HjFrBUhpxclLh4Xaq0tIw4pVyMeKGj73V8zTi/+GSn0XikmD7yv8M1AkgT2QH469IPuqiptRYLUcoJ9zhDAHm188saJqaZcryY0QbD2ooQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIFGaYeccjSxOeWozecamD0WaHK/a2VUji7hptntHhvDq5nBV4REjKbHvEPJ?=
 =?us-ascii?Q?OP+0qhi8iKwEKEkjB5skFa4Tc9Y92a6pYhLNW7FzL/wUIFGJniURZMG9C/6/?=
 =?us-ascii?Q?DLX7XKRBsZxXUIGho5tksYpSiOOzUfre61WUxhMWp1cogP+9qe/GKUStIktX?=
 =?us-ascii?Q?5J2K5IteTwy+nb1/b66ngCLzmUFSgIWpKbhTudZE6EQ/Lxw4OzYF3m8PhO/A?=
 =?us-ascii?Q?BIAzXLxSnr4zM1v3ha2BCZpekDGxabV5tBn3DLjnPww9rQBCVU1lJ+ooRyM1?=
 =?us-ascii?Q?1ZmVC0orta0xesw2ozjD67IGYgbZ4ECXsVIyBE+JkxOgCnR7tXwxK+C4E72B?=
 =?us-ascii?Q?D5w8fiBNEBaGTdTYXeZosEX4/KzIKc6ZUaGmsGJDe5f1ryD7F+PI/IzrBa+I?=
 =?us-ascii?Q?HpynwQCHA/DMo28OHL8PThxNcJ4+RxwNcqPsYb2zHaPEDoFpZZWp9RgF1j43?=
 =?us-ascii?Q?Fg4/p3I3XEKleJmf8JrigqsufqIurp5zyxuAcM17fEaA5EfA0wXdfyOS7ZPa?=
 =?us-ascii?Q?o+aXGJkApmPWoRtH8I4PNNkmgTj471n5YUGhByiSIGG9oJqbGRwNNQG0J2XU?=
 =?us-ascii?Q?zxiZGwXv8dI6liNYpeqq5KY3HRpLtWtG/76ySajd9tpCAefVKBsv0XE4qNwg?=
 =?us-ascii?Q?L+4wlpv5Dnx6U2cG12gQEX5O407x+m2oh3cKl+Y5SGFeLArE9T/kKNY3zIG/?=
 =?us-ascii?Q?dnzgmpG9aMcwwVgm9SmH7wOO1pPWBTTa8zQO2ySwT904D/Me+TpTBZwT5Yia?=
 =?us-ascii?Q?da8xRG7DefiJ27fLRUSjTrLIz1Am1UBQ2pltGvknFbW4/IbuIhx2Gf199Pya?=
 =?us-ascii?Q?W72FZKARKUG7/Y11MPWikh3CVeebidTGWEFFPMea8NlEx17Gk6FhbAmmwiQO?=
 =?us-ascii?Q?O1PsJqXsPlpVzhVtCSxg9PJbgwHOTbAFkAlkg3ElF45jQWlRSxiPk2UjO6UX?=
 =?us-ascii?Q?iiRqXlV0kcrJ1GHH3Re0Le5m/PcXmhh4o+XPpP4hP6ZBWQv96a67hcMi2QsC?=
 =?us-ascii?Q?S87QiWMoTiUucPGvdHN+MKdGzWHYK8KkBFMRWZ8cLn35aVcBK9XJnUbMqVgb?=
 =?us-ascii?Q?vbsey2bsuUvrR8sQl6h/JB3vOMxKQDeUBh/mEdIEHL+UUKHddSctkJcEaLLa?=
 =?us-ascii?Q?mqI921rwMchJkMq28vXRPMsGmharMTFGHB8Ban9owbumlhayBJeCr5MHRAfB?=
 =?us-ascii?Q?GpKGNjCllrgpjnLbfAf5NkVqrtkdLqecc5U44YNhOLYrsSDn7aJOIfKS6lKV?=
 =?us-ascii?Q?IoeEkojjIdHJObiG6YO5mDV+xRZzwcFhOkjcJ22DufU1Q0hE4iUXgHNw3Ypz?=
 =?us-ascii?Q?XPK5eecOPfaGytYZicng2WYo149WM4gp/90ZGiKUgg770/bCMJgo6rGab/O2?=
 =?us-ascii?Q?eoj+j23g0G6r50qPZ9zu7QRA7O8g5xJd4gErOSMO3rFUzofG4wMAhEsv3pOV?=
 =?us-ascii?Q?ItgQ0AO0E00qk60RsQuL0cqtqC1LKz+fwJEPT1HMWKzDk5DRWRX2uUhcmAmc?=
 =?us-ascii?Q?/Nk/dCnuud6DBh5ylMu1qoDB3IvO7Q/w37DTu5k2Im6Hs8Cc93Ujb7KVQeqH?=
 =?us-ascii?Q?5qwE6Dmk0z34ZcQxJ/JH0Moi0T/56Ub4pe4y0okaH4v+c87Iu+yM+XalmMSD?=
 =?us-ascii?Q?EdcjCmISZ+bqSxSBj+BubyB56bdhl8CNjuVJkTQcnyWBSxQg53QHVDOMmcgP?=
 =?us-ascii?Q?GFzm15JPlA4japiJ0H7zhsYdI+B7GeFvl9MdQG3l4cuupBLnMQe0IUrqniWk?=
 =?us-ascii?Q?wddRZbUtmqU8kY2VmA0pTm/13nu2WLr4zSt9YJnAhKOs7CZShqGg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ac6494-4b84-476a-afa2-08ded75e9747
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:50:39.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdbq9jM5rDuXdV7R9CFkIil/km6VLH+mhhnfLv/ZYZoWNwCSSiwZ07BxDn24BIUoBEU50XheElUEaROn22/gurtmpPxya0TSAnkNOcwu6aMiCk5FzBr+iiEYGYfMOQCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10252

From: Sherry Sun <sherry.sun@nxp.com>

Add the power supply property to the Root Port child node to support the
new PCI pwrctrl framework.

Legacy power supply property is retained for backward compatibility with
existing kernels. New device trees should specify power supply at the
Root Port level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index fe9046c03ddd..60fe0f973668 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -756,12 +756,14 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie>;
 };
 
 &pwm1 {
-- 
2.50.1

