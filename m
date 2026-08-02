Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020088.outbound.protection.outlook.com [52.101.152.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9F3ACA60;
	Sun,  2 Aug 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670304; cv=fail; b=mi4cvSmseR3a7dPPrHfltNgQ9zM5GkAsNbkzHLVSjC7PjvIIMHAFeLGV+E7A7V6T8vumBJ2WLXBzLZtTe8y9hoLEUzEL/xRRO9hfxA4C/8vwuAygW/0tFqIfKdMETMMnIQmn+1dcjd79Ey1Y5xWO+Cos9BHoWxUHsrDP6ZNY4XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670304; c=relaxed/simple;
	bh=+TAICemaMV9SZi/+IFNzOQW3anMvApk50OgHu62j38Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NXwzRtjMx+aYCIqxo3ysYqxw0WEcXChopwB7uohflQyJKKKtWIEo3Vd8Wg/LfFhgT1SdqzdUigjkXBvwGmf+eXCfhb7Dqgz58wwDBj/Vo4T+cDUBCzApyb6Jv2zdpoLcARdN+yC8yXknHTqT72gYrHXlUAJ+HjOWEhkCJAv0liA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvpeCR095YbcfKX/86x9Nn5/dQ55PQ3YMsUche6HnJXRNDTBh1B/ktYpUtlUI1aZAqIOsQU433To1Z/O5HBFCWxaVuQbfWZ7p+dagcutUvp2AyZcshcaRfDvIqNcWTOJjXs9j4HZXUM7rLeTUjNOGpaDyl3noYc9it8B4JMLG8ESIOE6SkjNbzqbhiWDkIAOH+Am49sUJIWsuRdLAC719S7njRvkQyz+BOJG/We9udUYQuDW8svn5Ttzx06DfH8MmKFw4KX5OvL1reD5ZfR8f9CbSbIAiCqTVStn12PqT67vu7vy0KCu3YJOBqg7cOu81HZAZrxuq8Sj/qUNjOw+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0iMiSr3AD2fMWbNQ7QS2/o2PVuiNHZfKUhXrlC+9xQ=;
 b=m35TI1sKK9xg4dPDO0Is/qS16oLyQ5NBtApRo2YTZbJOXegb77p9GQJ0TT33YXYeGcK1tc37bZkN3IMBSfWwbayA+mDH4jg0RlWDkdzK49ZGKgjlat8vU7D/BmK49fQYQCoL/yU60qfhePoLpJKBquI75YZ2JJnQgk+wIzTblGVu4pB2ILne2Ff+RuKuz5lG5tfG6X25+spMXVd6Ew4zjwlkInbOmevEAzhji6Gq38mcUsww6nELVAfU1zQoTr3UKpk97A7RgsV6AC7TbgCw7MtxKVenas8UuqB7LgJ7Zi91C0TBRlg+uDFheHF+8BFqQwMpwARWSOgb8XqxR7+Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY4P282MB3986.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:31:32 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:31:32 +0000
Date: Sun, 2 Aug 2026 11:31:18 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rudi@heitbaum.com
Subject: [PATCH 1/3] dt-bindings: pci: fsl,imx6q-pcie: Add extref clock for
 i.MX8MQ
Message-ID: <7f99a670eba4b76c391cb87a487f7a837f66d838.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785669457.git.rudi@heitbaum.com>
X-ClientProxiedBy: ME3P282CA0130.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c4::10) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY4P282MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8bc84b-5e8e-44ac-086c-08def0899a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qq3gi3bmo8E8eK5MkCPT1xakKN3hgZHn2kcBfb8thx2vnp5j7XNkWJ4UhTYc+r3nC9tIJxlMC6TF7ROiegnOGD37RnQ6aZ+nU6ae1dgui0hn8cc2gyzfMFVZ0M2z1CtFhyXJOFudQQwhBt/io7a2InY9w3UpGtL3rPTMyArHaZ62b7igbIG/TTzalMPalAu3g4CUvWTxuVAOYwRhhtL3B7eBzaLZcF/4uiv5QXeUGNWN2j74fbam9QOU12130GNMi91v4L1Q5kF/KzzdcHa3eFHNVYUEijiB5XSMZ4X/HkYrmUj/ZfimkUAvW151N2iZB3FVhvaRrnvftbaY9+huVqGS7h591idFRd8t6Rs2VU/qYHSqOZMKARSklLGtSd5E6bWbC19yAeUniMw9ihDEjRx+Yd/hZViK1OnwXbdowSWQuMwlNfMbInFEShooqOdYp+Ahf/Kzjn+R50RH24fuJUaPNOqtAM2hlBjNt0Y6/jM51ekDpDePJ9SdcgbWWomAuqTS+mT5Ij6SATtRojOlB87gFPzXI1PVmdHEO0SNxaoIwKmYIDB5SupJOH7/3y5uWGbaorgPnZSIaWhvkVoZjIXELp9YvIne8P2AWh62W4qSTZPEDdp1ptgjalMM1jGFaA+LdxMyOggNBJUSeZOA/wRP0BrUEk1TwaY5D8Ygwfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yafuYmBnwxn38LOSm4J7SZlE8G+SoNDE1V+UUix4dH9A0hAyH63/45RuF35V?=
 =?us-ascii?Q?20H5LLjFS7kdAvJJ3mlTjlvSsDX98/NsGWhA0nvKd9GCfvRGkiz4it+8B/g0?=
 =?us-ascii?Q?b2xvZ2Oiwrb1uyCGLCTWsYGyrUkpdzlKAC1QI41o7FTfIv1u4JxKWrsTT2Gb?=
 =?us-ascii?Q?4Rna9DVMaGHR9WmWVAiBW13nz9SZx8K4VUs2aSJ9CTnpfh4+KRGPkR4DqfJF?=
 =?us-ascii?Q?9ylh1HkZZBbdl9u1COLJtrMoiUe6h8hvctpyISV7DxtIszrEA6G/HQYjYU7b?=
 =?us-ascii?Q?Aj3lRSuoYCQ5/a0TKU/+hTE0sgN0MQbT15eiqpjKoMv8ONwnHu4TSUGpHcyd?=
 =?us-ascii?Q?EDAN5l3Dqp3xQiTEP9pLSZQqYTNlDA8gLfvAXlYWYWe1AxfAxyWejn5kbkU1?=
 =?us-ascii?Q?MelQ0vJCG84LTtNrpWDGefwZRuGIDeLwaV1fEqj2KsfK7KPJnCZEMHVhTrH7?=
 =?us-ascii?Q?RJN6+a2BOKk/BeOdAIE5y/zTB/pNgDdRVgX58Sca3Zzav9kxJrDsSUH3U85k?=
 =?us-ascii?Q?B+Y5Y82l5xo/6rn3Xj6BG49mMjsSK4RPEAy5SlHV3JlDJC+1i5GeMcPFVkN/?=
 =?us-ascii?Q?+sDajzyiBj8WoNSPVDmj6/beULvHgVi9yWSS8/O6ihZLy29PSrJd70O7K/9J?=
 =?us-ascii?Q?7xY6C0OPfQVg/KwAFdaKYAEY2TTnezDNaU2IvGdk/Sdcacnzpawropfgcv35?=
 =?us-ascii?Q?ITn1ZRYLNRgifVO2ce2IxLfAFiIvfUMelwqQ838I5AyzX0JazSeWRClVcqXw?=
 =?us-ascii?Q?pg+ZbbZdY5q6mqTB8WCHaszPWV7OaDFTUknYRYs4aHEzhIE2c+kmiZY8fhbT?=
 =?us-ascii?Q?LAPhLUZZgjN3apnCArWm2WpYTfwmshHG5MGxmDTzgIFgO6cqrT4m+kvfDHJ6?=
 =?us-ascii?Q?OjZn7tn5Szd8AG4ODExEPzxstwe3+9Ci1xCCIvCNTgy6ODy9kOlcaI1LLBUY?=
 =?us-ascii?Q?N6xgT76FPAl9yRMz7NI3UzodDLkptXZyZ6LSq5sfh9HbMJV35b8/D9VVP2kq?=
 =?us-ascii?Q?aam6xU9D7VE7O3aT5tqWPIIPjJROT1bcvx3BsoUHkWbOVrwia42wQJG0zBA9?=
 =?us-ascii?Q?NcyoSgD3hUpNKCd1m/bIR/DMoIOw7oUo5QxJmGATWbQC0mwrYspC6tm2j0Xp?=
 =?us-ascii?Q?S3Vbi8PjSGY3ehK7yNAHAgZqEfLYnMydLfJDatFACVctbw+S8dJYTEQ2IfCu?=
 =?us-ascii?Q?77KCVJwA4hLdbkspSssoocaUWXBZrx6n42B0JN4ZnqHEwSoJrIQUqR1of4Si?=
 =?us-ascii?Q?8mhlGdpiJEXGF9VeOMtprrtaiI1lEhisYp5qZr9mNUM9MOtyTNv3lPZwtDSg?=
 =?us-ascii?Q?eQFnpsnnzi+OmhgG+9otRByCejuKc2lBWU/KiRCb8TYesJ5P8lGgCQBANeND?=
 =?us-ascii?Q?5IuhJh6D5dW1DdzTPuhaoDKpsNyHnC7OWAd/4qXYXPPF50t4qjzVSHbvJdQ2?=
 =?us-ascii?Q?Va4IegIxE67FoZ4Fuh5Ch0b4YxupOwIuH5Gy3Ybh7Rtq7DHYbTfweRksr39A?=
 =?us-ascii?Q?hfFS04w5gxkZNeFLitcXf45QcHJNrRsyut4FRyvNzjOhD1gg88pekdFXJZJw?=
 =?us-ascii?Q?4HR5jw61ZaU7TxLbmIWYO6zIKidG3Dq2DAobkN1WzijOhlw6qozWHh/Bkk2c?=
 =?us-ascii?Q?5WbSQoqtSuBRK6rRLTQRZRtbWPPMm91d3wFAM4kcRPcYZk67x3/W/ywY80k/?=
 =?us-ascii?Q?RsKhAlSRI1HZqIWcTBcrWt5qQmOiF3JfYyqrtfga/Y5dEZtJ?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8bc84b-5e8e-44ac-086c-08def0899a67
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:31:32.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxomrQsSwESg90WDWH++4St5xLgOPFpAzjqcCgvchInU0uxlcrAcJp/wJmQia9XoLZ24cvQAey5Wy2qc8YLySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3986

i.MX8MQ can drive PCIe REF_CLK either from the internal PLL or from an
off-chip oscillator. Allow an optional fifth "extref" clock to describe
the latter, matching the name already used for i.MX95.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index e8b8131f5f23..8fb0c919ae57 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -46,7 +46,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe internal reference clock.
+      - description: PCIe internal reference clock for imx95-pcie, or the
+          external reference clock for imx8mq-pcie.
       - description: PCIe additional external reference clock.
 
   clock-names:
@@ -173,13 +174,16 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 4
+          minItems: 4
+          maxItems: 5
         clock-names:
+          minItems: 4
           items:
             - const: pcie
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
+            - const: extref  # Optional
 
   - if:
       properties:
-- 
2.53.0

