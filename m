Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36628FFF6;
	Tue, 10 Mar 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129231; cv=fail; b=kZBYwO3OJMO2MFLizsxqNBOMX9bLBxd8GdAkEmi966bD3SiR2E8kpapSQOGDhTREBvcRITPUzfJMf9+8YhOKNXw8wC1vvgeuJzipWGwFPFRnWa6phK3VLBAURs5B0ah5DHFwMFuW387XKeAfcDiphpdqQVFokHzsi5chFEXHiLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129231; c=relaxed/simple;
	bh=Bi0YZJspVP9nElcPOqZq8/eHQL5FHb31aKaiD1PoHUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcFPoXtJGKHbfo3SfX5SO8My2DVy7eNnNA8lfHg/lWrtTo+HKSDuhN78lamlRTuXKfhSzS4iHIKqy9eL4ty1Wlo6N04xHTcu2Lv1q7YqoWbAnxepryQguiao5Ft9i3ZdjXlpmYP7Oq3kfJDBKlmPHxePBTp1myftAv5C+NSi2HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LXPkRjF5; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LXPkRjF5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfDRofiN4M6MX9lAIjAOdc5vsk9KSNkxonhQ3nh8CYpocNlDNlWHhz3qEO2BIpHIFHpGB6hm0bsnObpjKiHJ/R6SvNiC5Y1CCStYrJigolvXZfVbeR1RTMl2HRlfFURr8a/2I5Pwxijhd5MEZv/xVEJfPzl8gqK6yGRwR3Lkdq9+GeoPnrCcp5Yydi+X/p9aNOP3VjidyU/5Fh3lJ73dNIQ3j9IXybpOBEAk1Ohc1HrVGmDJHMn4uQbz5X5kf9jkImXLILOef8EZp7ZDzUqfkb6SlQyRkbyxtrC864CfkxiappUN/kjRUOnQ2nfc7gqjv4zeiIoukW2hlP3bkukINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU6geA0BySOfoM1jF1YGl2JvBUqQ4D5rAFR7/29HkZU=;
 b=wXmYY+FUDhvsqyx7hjVkWRIpSG2SzBvaBNPbhzg/k45pJxBg2PuVmy55lLqyeDgWc4+0hpOPKuH4VI0VWzCIU//5h4F3LOUiCrB4t0svWgBNGDbsfIPHsEy4S+ZUyYWg8soytYgDZ847058YuYhYPgFavUwSRI4pRN9B6hMcYSVGCroMIcqzNcuGoHffBJi/GrA4RYh2BgBNqSb14rhVPV+cP+zxQTL4m8REz7alhALDwDQwfmEBFrIXqSiycUIUtbhTb1HreqTVwv7PoGY8urxjjihQGq/CaxOuWIlSqDUwXwduoBT9cLgL3vI5ceDh4UsZ5WSByzEgG7rPsEZaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU6geA0BySOfoM1jF1YGl2JvBUqQ4D5rAFR7/29HkZU=;
 b=LXPkRjF5Cy7/pAO6Z0mmPqqVj6eERqLihJbEOdzthfWJ1l1unBasyH/YXT3Yu8FNedVHArDFXS0i1g9AwbbiLxndUzwYJ321ugMeqDS/bI4vMPDNk7LUslEfDwUUhrTW+5geoH9K3RiYy4SCVhO2/aJH4TqklD98dDqHAs+2vu48yDiwCpk308sQhMaKn1zSjGUQx4OTSLP4Xk94YzFvJkw3A71soGSH8z7J/iePGSj/+9y46Ty4PU9Fza1V5tU8XSVtAvcFCWA4GRwi152ONS6ztn+uXHuhWq81DGvx1UUIsvaFDuBgN9tKLZuoyFMDKnxaR0B+xzHvy3WigirePw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:53:39 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:53:45 +0000
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
Subject: [PATCH v4 1/4] dt-bindings: PCI: pci-imx6: Change maxItems of clocks and clock-names to 6
Date: Tue, 10 Mar 2026 15:54:56 +0800
Message-Id: <20260310075459.726495-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310075459.726495-1-hongxing.zhu@nxp.com>
References: <20260310075459.726495-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c366a3-8dea-4022-7fc3-08de7e7a2794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	FhyIxrZK5zBu9BwZaL3S3vVJZjuDVBOPOoV5dYZArrVCcLj6IOMl573MEHV23Mg6cCj6rLPDYDGmcedwiKSpFr11oRSD8XZoKNv0bui8s0PdBrEBccBl0rRKVz6YwbhAf2T4X9jRT+tULfOFMa3VU5KPqmAP9pifLZVlnn62NTUbcXNWV5THKilz2ezmdiEXgRNpnBEM/RU/LRAjkm81k2aEGmIsFffaeWj50sqiP8/AcocZ+c9qUrfv5OodbtW9HhhFauvaCj16x/s/tNm6xatzFnDqAglzslMhjJs3+/cuY6yf2y7UgRxkUxBxdH7wQ9YOZ6Qlj5u70AoyP3AStFdFvgYeWI+wTZmW6Ct3iXI2Sfko0EWDy7OE1l9BcCy2hMUyItuxg4x3TiaTJu91M3LS+q1f0HYB169HVlhvfOuL8yQSSxMHT2s+chWZdwxZELyhQzXdH/BEIUTFNOLbFaMIui1AdLrTAMb8PfCPS/lD8jmE6s6l4tSUc06Bw3Fjw1RD+MK2BDR06hjygDQeMKIJwYsUQaQ8xMj6ZnDaWH/VFW3X/liHe3vqau7HnDE0Ot227DsZ7fnpXEM1iiktXl1BuGJfQbsE4TY0/wXLlHIIWAgz4NdH52GrOchruPMxKcUBa/Ln8VZQDK/G6lHbRlAWnqSuo5gGXU79/WMzRbHXtwXdqpEBN3DeoBJLe1sVVcuVhXXgkb/4D0NNDWBF/h2n3PMfRtmHy6oh93xi7rAwY4HY2XrvrZ0rP8GdYpIokz694CZRUXw/B/PgpIuu9XWBu5OxT9Hgr8KspVO6Mi8k4W48/SfeYO6Kn5oa2KO8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8b5rlyBrcMGr2rdNHbWsHoQfxKcwaj+ext6a4g0zETLT2/ls+SS8jkMLxYu?=
 =?us-ascii?Q?huWLEyO244rGdldfPrxqFOa1VUzz6aOWPcm4N7QiFKWB3YWxOrBS/KlvOpMC?=
 =?us-ascii?Q?pt/MsgCLxJiJ/oqwIOMpDsycoN/z5CXeUoMv9UN5jODApA5LuUgjUaRbWZQG?=
 =?us-ascii?Q?we2wrrhKq538vjBRb1U/euhAqh2DA/vt+e+C1QOdSbYOkDXE5QiYj9IyGvdg?=
 =?us-ascii?Q?cal3dClSTU94XM6ChkTtBubtOIafUNyqJp4JOeAl5fDrwF98FBi2Avpy1894?=
 =?us-ascii?Q?rfa42afM0JsDiuIvUTgF7Q4bhX7xrJmMzr6SOnfJxAIOtVkaNfQhTemwAT4l?=
 =?us-ascii?Q?zvCv9252i9fVJuWVwRRXInC2PJbLdTxMsxpNhUv4k9g5QJDcK6YN+NKhMLz2?=
 =?us-ascii?Q?yfQlp54QRqVB+187ZodYAW/h7PBM/ilACizITj9zLeLJzhf/p+K1zrtsmoQT?=
 =?us-ascii?Q?tTYvCqqOXb9cQGij5OHCeOupGMh0AJw17TY/EqeJndtb+yv9geTxQ4D70n9h?=
 =?us-ascii?Q?pWrCdBYUoJC6eSlw8s1/5g81YvvmwbSgBRs10rntT9IPL3Sbro/+zFXGilvr?=
 =?us-ascii?Q?bLy0jRqt32JzM23tki4WHtpcBcupZPM1sOq7vqmTw1SM8FsP0MDo1c+Fy+36?=
 =?us-ascii?Q?dtnFiIe/HgaQ00WJzvNNIbSSmT226qqNPC7V5zxIXWRHIYv2C95dO8hwajb1?=
 =?us-ascii?Q?rJ9Nr1pjdHHCU8Kp4ldnRwxckgqKp4pe5WKwJd68rHrt4tBXqfOIDd4WHISu?=
 =?us-ascii?Q?7VOaq2651W5PzztRlQFD392hclCiQfk/KRB0RyI//Z6plnzDt1JhWuoERYdK?=
 =?us-ascii?Q?a4ZnoGNfuRSshlUHF5xgbfYkGfHTMOvOlWtX0U3V38m0iUCGP/gNje0VGE32?=
 =?us-ascii?Q?WpF+1CALE+M8cQiMJlR2VFCtYrGYnAQsK0MIl0XOzx29h7lcH3PPcl+YUe+x?=
 =?us-ascii?Q?m8J6/9abGv3XgnMDJKByL5G9VwHp/6kCAVkHbrpz6/JdoZTUksjpy95Z7jAk?=
 =?us-ascii?Q?FVL6B0PmCZcapK+qFSCHo69NRSQtpzTbCq/xYFxeasZktw2BTn7Kt89FQTIu?=
 =?us-ascii?Q?iUXRRVfVrctsZMGw4am/mXC1+o32qz7HIO8fcXRNixaJ/mlhdcM4eyEKySDs?=
 =?us-ascii?Q?74cFeKQuZnpzyvEnoFxKQ07+kzRTzPPN/KKALDV8v5YrIUaYW8lTPkbR5t9Y?=
 =?us-ascii?Q?0hRKWK9BkerX4xyhWeneX1BLR+qmnLXUAa+zExF9GHjJeKGlmZExrS/R9i75?=
 =?us-ascii?Q?Xtb/PxuivKX43NWHCCkh702mePT97DMIJgKO1V/RGcxVpcxkK2RL9jVBv7Ue?=
 =?us-ascii?Q?sftrKCsbL5aEsUO3NEtAunBkotLSZ80dTRwuM9x3uL51Op0lTxc2ZYuN03EY?=
 =?us-ascii?Q?Vpsu7Z8WUbSxTyF1GRjCqppaCh1tTCGClI8aMyqFMdZ2jgIioXu5dI06u4uY?=
 =?us-ascii?Q?jIc+AHk+K+0zrA17Xtp2sSYhLYZ7zylS3399ljWiRrLrL3XNF/kRpeY85bvS?=
 =?us-ascii?Q?2SFMff7cF4lallGiMyLx1i5Pvrm9VT+j11wDY8dQk/SPpUOXfFcMCH5dUOZ/?=
 =?us-ascii?Q?+GHzC+iDd9+EAJBXPHPVkzug2RtUYvS2JnOG8WrT8FnmEvgJUA3Lns9spSKW?=
 =?us-ascii?Q?r8Sv8pwgKDE8MytqnaoIx/izZLD9dHcokhBIkLIjFKiE2Z0iQtGZbWdSMUtk?=
 =?us-ascii?Q?xjHZeqLZjLx28s8DuPlFf/tBbBu2Ih4WUQtc4IZ318K8AYF/eROU9KCOgotp?=
 =?us-ascii?Q?rjto9lI+xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c366a3-8dea-4022-7fc3-08de7e7a2794
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:53:45.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WwfF2t0kZAvn2tiCCUu4A9xwgkceWvm60l4QucHHLvh42z9P99ZSkQZrwpZCHGmlwgFFy1KgPfHV4YqXzFw1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Previous commit 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
was incomplete.

The constraints for "clocks" and "clock-names" still enforce an incorrect
number of items. Update maxItems for both properties to 6 to match the
actual hardware configuration.

Fixes: 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Sorry to miss testing when work 1352f58d7c8d.
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml        | 4 ++--
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index cddbe21f99f2..0488c942092d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..7fe1e0e9b565 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,7 +40,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe reference clock.
+      - description: PCIe internal reference clock.
+      - description: PCIe additional external reference clock
 
   clock-names:
     minItems: 3
-- 
2.37.1

