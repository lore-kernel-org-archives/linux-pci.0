Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803B377547;
	Thu, 21 May 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355856; cv=fail; b=pAnX3N2BUwICAmOVJi2cr5NOcpCXKA/TRq7QYyBl/2U1SkVnY17vR9aXy2Betyu3SUei8U8QVUGVvYgYjwqxGZLjbuHd75sGnsblisWU591arApE4utBRC32J92uxonrWww8+bEaL7fzzhN+oPBwi9KYAVN/paME2sFQlLvK0Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355856; c=relaxed/simple;
	bh=S4yQvaY53pQFR6EsPPGNEg+YLRkI8PJNRfynsPlmg28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEWg5rrfKWGl8cQTgmTBmFQhcBNE+bAUnkUmm8qKX/RbuVr9iS7Q1vHiosxcfx66x8eguP/9CFLa+16B03j+YkGDrv0evAjpw5+Nu5kXbZsaH8szzfM/LYttV8Jbfc8UF1Q2+Oul2uYrOQRumyTIUdULZe27cw0ohqtWjba8a/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZYvp1XrM; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZYvp1XrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxiIxz6U+UymnuPEBgr1E6/1GGIIr/JaAB/GRwVfhcw5mBoDySraAwcIBMefJE+hedqNRxbNKuADrC6+sE/j17vKyn8lzY2kKxDt7BHYSEkHD+N8TWBzVLNjeLinQ1UhM6irfWqHjqABTfhyEQilD3siEbh0F+tLVZx9HvOEgCX+mxTtXGaF0w9E7WgcPSw8coaVVlMSFKmr7yLIq87tkOJ2cAW0Osvw6ZNercOh2U4nsAKLJnTVclNpmEZ97NDUeVM+dUCg+gqu2YP+lAT/abh4HlmBxh/UcaKFmWUmSQqkQiGnA/k2sfyScgUrnG0OMgCq3kXTzr5y06FfMhUDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jq+cP9MWxqoEjAT1DuoAaHhxmSq2hsOOpW9jJJvILU=;
 b=lxbFyI/T3EgBBMAMWJqt+5t5OUm5WAy7zv1aOdQgsGRGBh4uR2AxBU6BWTujSYnuMOcDWViyHPmPfJEb/qZa0n5N09//StQsERERf6pgMQDSu3wDBxpcoQB3uP1VFRiluVfe1WZ8Vgov0minJ9stltexAPiyiQkyFby4RFTHZ2wYW2hfsM293KhqKla6o5BIXyCCl1PmSx7tFOd8dRUiZSbTFBgIcN1YmBoGhKfGjNsSvq8Q3kuhYwVB9qKh7lsXE5v+OHMjDyxLL5GyYU0RfHkp8vK1dwLhX3JMmCiNSLbfGEevNo/rwjFo6zj9C/5VtouAtDd9GMz9HLl37NxbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jq+cP9MWxqoEjAT1DuoAaHhxmSq2hsOOpW9jJJvILU=;
 b=ZYvp1XrML52v7OZ9JHqLxagqOtVwbhQ6wvX6PfJRLPPAbN0LPOtYWDxzuHJvbzEXsWR72LwGr4rYz0rzIvdH3PUx8GHilcNz89Im/yAfzlfoBCjqEovGpfY+YFskPqxb+bpQDg7U3UmF2mV9MWumWefnL6jFpVnTHEKkRVq7fGOU9Vh8Zq0MgkgtDWkeZMswnW2J90ZoZG484onjh2obPAZw3rygHCSX1ugEck0I6ynqqE6ZehG6FvVoDEdO5mD8y+JUsYTolb8MfnVTZtrAFVXBkjTrPQucZZmyD0k0BK1tlZWSwzIJ+I3umzyDIosXd+Cu9VBg5qnf9kEzki0sjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by AM9PR04MB7507.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:30:52 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:30:52 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt entries for intr, aer and pme
Date: Thu, 21 May 2026 17:32:53 +0800
Message-Id: <20260521093255.61585-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260521093255.61585-1-hongxing.zhu@nxp.com>
References: <20260521093255.61585-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To VI0PR04MB12008.eurprd04.prod.outlook.com (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|AM9PR04MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dc76ab-bdfd-4eda-55ec-08deb71ba678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|921020|38350700014|22082099003|56012099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7wX/NG3euhDXZ/cO9aMwTYfhRb2ayAwM+VtM0TejEdSQ2A+C9Qv8lUQ4vhP/e8IMCyPZ9Dw+Q46fyr0XH+Z8SIAd1UVeqO/FJeJQCSUTxy78oBwiXFb8WN/el8/WCx70PxThhQ5XlBCb85h4rPOFUFzu7gvFs7EXni2SPbdpLrZbUI7zoIQhTc7EbI7+/K3+Z8SgY5tg+0dcHEpRJHm2OIE4sFyjO9W+jvdczzZli9Rq1VRY5JqN+ZGrp83Q4DdApDoQ2aU5Nhgg8syVjYFAOyAo18DQc69Qa7ZlzB2NsfjFZKcRM36zF1yIzpOeLG3GsGhjD11EBs3DpV6ao+kUh9SGEMHdCd4tUuLTtbGZxLd5FBMnNgCF2KYht2uZgpejyFwQFwVRR8uWZIYRG2GoCzSIF/UNwOkBmOlkXrHZGRSfGgGHthGPChJgw6673ONfUKldnGYNj9GqEf+bbvMd2ADxwVdp2fRaYFO6OynZYyoCkY1/085ybHQjMJ2sfKFphSm/e5WODCMg2QJUAbQTsnaT3HPSC2qBOY8DeEchLwxnjofdIQiUp/6Xn86Rgq/3qDI2TSVTCTIhbcb7KEk5lxv4Cs0M/NyTulrM6SA/px9r1tXVeTVZY0A8cw3IM9kQqpPoPBlL6TkS6ReQZI8+fhwEQPEKgi6UeWsyTM5cWdUFUoyunwinseJ6xzLgXVUJUTMmoWTCD8oelAqeOjL7QGeqSbEF/MKbjzz8rMyRuvm55OEmGS0no/7MpchaP4C4rhZgOyZQJ4wGaxzaPtpB1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7PcWZbNGK5UHsy+6DNfbSA8rJGt1lXrwYpoEisS9XcI3jKuN5b3VOu9yvRB?=
 =?us-ascii?Q?efhIOPnF1Lan/lMfeVjzkbQg+9JmmyGpnYyr/X6iZPepazw+DwGCgq2H08rH?=
 =?us-ascii?Q?r6kRb4jLxUfpsQ3ac8YLSfF6JA/N4UIksC3FpM1k4FFzygz04vJCyaXZiX4B?=
 =?us-ascii?Q?/M3IXQy/tAV790igY6Qu+fJkuQKivWuQBn0CtHDlvjmteXuMUr+XfSjvgBWy?=
 =?us-ascii?Q?Ul0VVUJaSrCgok1lvYulYKjjp2FoQsbU+TzH8S+xGdjE94aI/SHZr5N883l0?=
 =?us-ascii?Q?LfFhrRLn0nwL3eAgU/mW9M384v8ZbRXSVxgwqGQb5dlt1MjTZpHWo6geuaNp?=
 =?us-ascii?Q?DpmnNAHhSL7c66Az7jnlPBlwk+BaMGsWo9/0CF3O0DhYQDl8YoW27x9Ft4jQ?=
 =?us-ascii?Q?DdQ6zhwb5xjPRgnrKgY6sysy/CUXmg7eDbKO+7m5oE+uFi1CMm9sPhm87LyN?=
 =?us-ascii?Q?fWcIQ41eaDqkUkmeNMOT8NzYZzHskMAROi53XIDeVk9oCDenGz6jxEw+B4zN?=
 =?us-ascii?Q?K409l5eoLmn1S39qM04WdAQZZOIOENIwBgOPc1KCvgfEpp75MGX7z7QsyVGb?=
 =?us-ascii?Q?rpXNAQJ7eZqVbWt7uRP2s6jQdtK9B9urCnRhWyzErBdcgoWNSTSKQRy6VSpD?=
 =?us-ascii?Q?RMjsl7FIZkJpc2qju5yFl3z1qNosbbwoJGxl14t5p4dp9F/qbeVf9hoUO+XR?=
 =?us-ascii?Q?5Ib8dsWrWZaFDAK+X5ZphOaqGCbV1F2uTYUYHG4b8zlcrD/9MOJillWSgNrt?=
 =?us-ascii?Q?1tqnFp+oD2Ef3mBxP9TkPMElFYUFir3W4pN/IO89aLEJqgu4szhRHUa6c6ON?=
 =?us-ascii?Q?YiL2wIupYVIErD2cB/v53UIpOuRyuQ8T4MOtX4UOTSCgfLfbB2ok12ZzVonY?=
 =?us-ascii?Q?ZkXw39ci+xgO05jVlSixGlNgF2XvyMNZ+oYiHSRgqS1aQulk4xSEAofWJq/a?=
 =?us-ascii?Q?W59+64ivfLYT4Eek29Z8RZTPF2RbVMQlpi9W9FE+21IUmNUqiP37QutIWx5p?=
 =?us-ascii?Q?rLLXZR5hsI3iz4XeIAp2B1r5oSbLT3r4YKeT8c8Bwsxb9nFGCQGBrQ9W7MGD?=
 =?us-ascii?Q?0D5S4j++u/9jlJhzwwHHwdqhWFOtq9DfB/wt3wxYm18Gp3UAc1zPCG2Rth0Q?=
 =?us-ascii?Q?aX8aZFiHAcpRG3N0ZdfwwL8k1I37AWPLWUH02iwJHmmAn6CDux9UzZ0+ULTJ?=
 =?us-ascii?Q?tyJ5EQ++jAaHB0H+vu0EC02NiP2u/f8zdg51EjpS84P6sifEigAeTd136Ilb?=
 =?us-ascii?Q?9hkgVcRA1FewgZMMhyNkYzKHJfLfduMWVyECxLcdLDBlvsTVQM7W7ifMMrzr?=
 =?us-ascii?Q?wV8E4ai/hrHTH4GX6WRrE/Y4nBfvWfEQl2nZUKI580XmQxcLlFqdzsFZf4lX?=
 =?us-ascii?Q?9RYJAzpmL8tAzWt6sMD/BPb/c/wBXPeey2mp9G9jNZTJC47F4S839/MCOuBZ?=
 =?us-ascii?Q?0vrFPm5bF39yRooj47TvlSbYsrzB36YN/QP5L0Gyg9srySWBCcPe7OiT4pFs?=
 =?us-ascii?Q?BtO5oFc82MyLarVYJKbgrddKg64Mhq6stBF/cdyHQ/a/F5gHgq6jaQatF75W?=
 =?us-ascii?Q?2Q8z1iOovmEpWLbLyyGMFLQ3lqqJWxa74wIpb7qewCst9aErTCQ5a/i9Ysxl?=
 =?us-ascii?Q?aATB5GJsnAr8EAL5+HFVlF2UCUOiX1aF3jArLN9LDe7QRAt5dQEUoCSOSsLr?=
 =?us-ascii?Q?ONhSmEdSW9nGWG+gn3EhgbfGJXkSbQ5wsOKC8o5EVLwnuW0QNOmNFbjhkKYY?=
 =?us-ascii?Q?kmABOborkQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc76ab-bdfd-4eda-55ec-08deb71ba678
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:30:51.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF1WTyl8L/RLPPkLuX113PhixMZpi5E2V4t9hvUla7unvKOmPEpDK4bnVuwge2yKUETXNm9AiWsHcpTojwwBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507

The i.MX95 PCIe controller introduces three dedicated hardware interrupt
lines:
- intr: general controller events
- aer: Advanced Error Reporting
- pme: Power Management Events

Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm, imx8mp,
imx8mq, imx8q) do not have these dedicated interrupt lines.

PCIe basic functionality (enumeration, configuration, and data transfer)
works correctly regardless of whether these interrupts are present. Mark
these interrupts as optional to maintain backward compatibility with SoCs
that lack these hardware interrupt lines.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 9d1349855b42..cf709132ff1e 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -58,12 +58,18 @@ properties:
     items:
       - description: builtin MSI controller.
       - description: builtin DMA controller.
+      - description: PCIe event interrupt.
+      - description: builtin AER SPI standalone interrupt line.
+      - description: builtin PME SPI standalone interrupt line.
 
   interrupt-names:
     minItems: 1
     items:
       - const: msi
       - const: dma
+      - const: intr
+      - const: aer
+      - const: pme
 
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
-- 
2.37.1

