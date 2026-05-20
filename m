Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C0367B64;
	Wed, 20 May 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266862; cv=fail; b=k8U/icjCy0h6KPYDc6QqnIUldQI8ebfOxCO2Cl27EwP/sNmMkGLiEGgeoXJKwSc83z0wvvAP2w1nxyKNSDJKdMzuLjTWwNfTD00L/6XxJwgKmAHco0niDyXrID1tVvstsa+f3NdQfUZbsmlpbTz2UK9q8qVc4wprNjLN20XCc+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266862; c=relaxed/simple;
	bh=LHBcDM8dfl1nFnPHVF2wwKjwTVGPt1TLDNdn4H3isFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2Wn0GCFhUZHnmPsuTak70Xioy3EMdKJQQOBFZ5XDG9kHI4G95i/s6PmcoU5BDH+a21H7kYU8Ey7mB7hBrBGeWCp11beGEf9//qe06Og89/IptWtmUzYwj9xkIA4jttTWjoeuaZEMjDG6q2dbvGjKw3fNCaV+9PKtbPKi92jSZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aoXb2N4o; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aoXb2N4o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3ljBm9SHjF8h07+8tzyEXdkSHeB6htBhfCXA0Bt75Npf9TLZltl2t9JJTgOUVu8kR1VTQ+z61pVXu7V2LdhtvlBDXm07O2qI+7bGZCCfvnk2lAuMLcjODPWw6cUcxRI/jI2QV8U6MbBCbgCLK8O9x283GtV1C2MdygDiql+NCltnDCkGYQQcrjetsNAdZ/2I8nFqXMkmm+nxRuv8T4QGM/GxSIIam2cJbAeMylEt7ICUFxeBnp1l5VClLrslxjTY6cl725NCJFHd11LchjCOKyzh0eD4CG7GrnB7E9R+0dl3x7DgbjcN3bk5RzfrY2WTNXsQJXDz3rNOnQdeOLOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pIiOuKT42uQZY/okegLVc/PbpFcf7qI+s3E8PzKqw4=;
 b=OidUKRExElKoo09GxnhFrdJcsZc0Nfu6qlqw+rwRdBFCU0jpV6mzghBjgZeYKxyBDVpjnvPGoTl181cljocMwn4YBtND5qrKph5P1gvcufMq0lFR9Br9YoBmIf4fk4HdGAd0kYZiXbHgUQ60xbWi7lJnvAYQdCvdC3HTpprGiQTjZfgmreacqs3ZAiG7CHBFSAnZmc7bEHJsuQKL3G8MPy8pVU6dNER3yeT+AQ/+cdKXyFnIleuNYjPv26Dui4zYYSYqm+bShr2mYbQvgwAn8pDHivg4vHRlDiaCSxw18yd6XaKs4tgvnRrkHNhLB+bfmgEpiFTC67YYoRSTqz0gYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pIiOuKT42uQZY/okegLVc/PbpFcf7qI+s3E8PzKqw4=;
 b=aoXb2N4oHnhZCdxvThNl85N6B6l88g3kyfKzk4475OD0QSCLsAk65IUQLYsGS9pvKHLz2tiOOEycX2mvDzCvN4dpG0LbtY2EJqcB+X4c+v8swTUJEU9JA1QJSZqQ8NXmmT/DJMqgdn+gI1ogbg4rYu9XfOlDyfjShoO84qTJO3+oAAIBoth2ktW/Uyev06vOYybMPnIU53BU6M4Ou48HEiwPNF6Zzn58Nk6N14xZe3fKXr/Xac82xmDQLQOyBUMlIXYkCjH61dx1Dq/AhddnQFhi9EbxpsRacoommwaEzX4c0Utn20jVAT3IENMH5C4vr9cP4BudeKtV/0IQaYx4NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 08:47:37 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:47:37 +0000
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
Subject: [PATCH V3 3/8] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
Date: Wed, 20 May 2026 16:48:59 +0800
Message-Id: <20260520084904.2424253-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::9) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 26aca19c-3981-4bb7-01d3-08deb64c7194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mzA1j08CJPi0veKFw6pxaSk42odsLq223wmu0j14p6CXlQtykCnAnBSKE8pZgoVDG4h9LWrKWcnNX0rn9s2KObogiQ38TvDr8+v8ytwOCowRd8hmEreJqVlJFU1Mk3JgUKYMCCtlKWD6GZKeJlePIu3BYxHsyug/cJyz43KNJIqp+L95xSr/2n77GnrTWMCMVCTloFrWBSKA8P1VB+o9rLSqApGbPeROLxPHHfJaxvB+yRC29UKf3GprOXi9UfZNxwlf52snzcUTL0IxnX4fosrLaKvHvQNPSPUIbv/Ip/Co958jKntFkzy4Tdul5C2TCsez3552kVf7hujfd9R/XPEb3e9W26Lo59z4m3JS7tA69a8pSO2C3yNro/QtUQUqjgV5BjQf1X4lJOK7ptPamIhezX8eEesgcV7Zm5+exG5OKTvxZWy4e0o1iWTisurDCeQUHfx7fdVHbC3Q/SeTFYAXn3BTV/GJaUzlva300krhUrJvlIqO6PRbGKeK8RUPpRlVrH2riuBjY4aou392qz6fGJ1fnAUNQL4MVOZzupbLN96Lvqyf8NtAKNWNxM5se+S0EUfXOrZ/G4qjR6ioH/0d9aE/s5A9bTsygsVoreA1m2ff2t522/EW48CqdhL8s44vnvwC9Mt1PuuLfUBo+zAI9M2SGC3pSWw7toVEw+ATPVf78yBG02oIjNeHhIeRCXHa1qbihOykRaO5TwnFD88F98oao2BHXcOuSk89QaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsRHWqEmxuWcKJgba+NVV0SdVlEQmaCyX32c4yiyWDs69jlTPNimOITyzsg+?=
 =?us-ascii?Q?PODa5+JIqOKI7ltOBSgQYE+lz2uNTYsOMo3k+4bigbgSPQ9uWd0rOcBgQcar?=
 =?us-ascii?Q?zuk+YtojUpg6ZjHJaAmdiK5eXcGeL2DCILNhGK3PoKwsEQ/81hLVfUU0bkCz?=
 =?us-ascii?Q?yd8WcEG0HshgEki438xrFxFvLCv4AtS91/Iu1IbBUi7jWDYTSgV5ZENjHQj3?=
 =?us-ascii?Q?RjWsIBv7ugZmJqtaTjauDntjpLRJnyKf/wpAfiFmiHllk3OUCtPQQvPG/BkF?=
 =?us-ascii?Q?WXOC6VBRB0a08aBzFQDVmRrwgpNd9/uPIiC8MDWRNP20jo/Bo11qDIj7OSoD?=
 =?us-ascii?Q?BmlnT68htoudpwtbgrMcYSsiBEGxbafFAzbGH032rX6BXziWm6JiqDHsWG7C?=
 =?us-ascii?Q?Ax7B7cl6RvQdi5DoMFfWYof8G39+YJpurWvlBLyac2sNmImSOTcqfTYv0bxJ?=
 =?us-ascii?Q?MefYYl949w2ZafwtjFs73t93ApZwZJbrz0bzHbKujYiORjyrGyiDmxWRqQv+?=
 =?us-ascii?Q?FJz98ji8uzZvHAmozZUjahJAZqbW/kFBcDQyGyFuSNH79w4cX6cgTfAZHOr5?=
 =?us-ascii?Q?K0l+dF6dFs1cizMzoPwpYWx6KhFhcLmxUhPIR6YkdkcSw3F1LrGKa72qCNMz?=
 =?us-ascii?Q?vfSXC/T5NwLMo6a2rDeKFplXJEvEpTiQjh9NsxCSYEIDLuhjYwuLwoJX6p5x?=
 =?us-ascii?Q?MznlcDGVYfMByv7i+7zDGzkl59ravWmrPYPoyo7Ml5DdpIsPCh1Jre5RBZxa?=
 =?us-ascii?Q?iz4TkdKMkhAzJ+IelUGZNPvr480NEOwp2SNNGlT9GEmVlIeR5E2MPfSFAz0z?=
 =?us-ascii?Q?lnQ0RRj9pY1OJEtOIOhPCNthb/UOMHcTs3J8lnC1gZJjl7EL3em8RVyf58x5?=
 =?us-ascii?Q?KjcDxYu1oFQRgbK6g75KKM3xCMO1nyTOK6ajR7aa+Z0xtVOl+LVO8Jkj5Ssc?=
 =?us-ascii?Q?ZEC2LFjfksadA15s/9mumYYRNqCmqC2aA8NaFY+ytDmYEeMIKajUC4OKDn8/?=
 =?us-ascii?Q?uznCE81k1EBDY6xrM9BKpEi/Ca1ibOzKWf03rlYbeX+yQ60VBbmTYYJvKgSW?=
 =?us-ascii?Q?uHYAY9BJHfJ9OZFixKjCJgaXj75uuS5Qn1UR3CxQH6XF5Iz2VwhuE4UatvTN?=
 =?us-ascii?Q?6BtS1x6nUxsNJEOoQ7/0Q682RWe9WMW3FjR0KjAVLW3sM5VZolEQ0AFKQcv0?=
 =?us-ascii?Q?+WR28VIVA9YEJuH8wdizS+L+gtDvzb6QwxkuSuemZ2tMWjkHMiGn9OJt0jdB?=
 =?us-ascii?Q?Vz/714sOI8n1SuInLvEnU1RqKmMekQMuBHqYmnamJ68XQn9q/SQUvAkX7Eq7?=
 =?us-ascii?Q?b6Xsxr7jRXaRfcYFynHPRMPEB0mUxkDKijHhqpGWXLcFGcHoBMXBiAcw3xiA?=
 =?us-ascii?Q?vwU59X3uE145C0n5KthtaVulvkc+YYzA7ecBf+uJp0TDQ9ZMDyz5vaLJ1CBW?=
 =?us-ascii?Q?eoL1mbA2uq6V44DDZwn32rvD/I9ZlQXC8mMzpd6JQNn/d4xVF66g78qLVEVu?=
 =?us-ascii?Q?uY6vbuhgWx2ey8aYWsGSOoyjoMoi/E9QNPNUGWOFoGvLnjrOcFuKu4Y+774z?=
 =?us-ascii?Q?0qGgrWhk2T5lPEc+EZLWSYZ8WN2pvY0aPuty83r3Xj1NvTLFQFHd/coiRoKv?=
 =?us-ascii?Q?g7XdU++vVYdRVYpaPYfEh8+wUxoEn12Fha6g+FtKM/zd2apz9MCaIjMQwn1w?=
 =?us-ascii?Q?F7CuJjR55elTY3QtZpLDCkbb8c//Rslut+AM14R2X8dWhKzeQp9cI6KDaBE4?=
 =?us-ascii?Q?ofPC2MPNUA2THyKV9yeRPdWFw6frjqxIqMMOCzIm70Gp2WEKHSY4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aca19c-3981-4bb7-01d3-08deb64c7194
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:37.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/rqsec8ZQNnzpTPDZR1dnp/Lg57bSLHVaxzaO5MSn60xP4JXn0p1YrYRZWCVonR/CpArL8cZ6kVFj3lSHM0oWLSqVyKBekASxUE5tdEEJfIUxp9pW0NgLC7d8fIBJv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

From: Sherry Sun <sherry.sun@nxp.com>

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 338de4d144b2..7633ba2139d3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -284,12 +284,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie_gpio>;
 };
 
 &lcdif1 {
-- 
2.37.1

