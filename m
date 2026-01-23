Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DE3624C8;
	Fri, 23 Jan 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134547; cv=fail; b=BHGMf4XcX3rroOPhuS3XVbbGXpVz5DcDu1dIzGsKvxpgr8iH14b8ZPP0d7Wuxuz3b1tCbgELgcUhnjx28PQAH+PP1kN1A0ogsGAArmO+PcwlRVjRReEKZB8QaeYWtWaNgqmNEi09Nz9h/eReVQz5Mt0AkY75gh2sNA/jKHSNRWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134547; c=relaxed/simple;
	bh=RBcJ2jxBp/Giazk1g5+erBwEUIOf41CXk2aWWesP5WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knhxvVKTx0VoZdpErZ2vqpKFuDtJytiib7CjBWIINDQNCxILCRFy75kV7hbFA4h1a+WWQwUg3gigx4gPGZH5tOHFhjpSNn0Ryv1i2VvvW8C1n1UgkqyZnXiqvIPgz77HE/rCxHsP38/h8bbkjyIjtJHGAds0HJNFILYUJak5RQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z+PHqOWS; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+PHqOWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG/Qk01Z/ZVCE5xiva7LOZK1LDRluKj2eyC3U/0fwPWFXyzVmqtTrLVtdw82CIMst/WKfyTG+VbQzU6x0zWrNlfLUdPDvP5ffEAUP79NPxQTD/6ao6Ox5YrvbBkEEHZG4p9Jji2X6mTpixfJ94rgrLjLzL2SQc+U4iC2gv5LfGSwmf9GS++G5rY/ydci/52+TUEmaNwCVvCGGJ8x+p5rOKL2b9Ec3uJJbHVa3muRUi4jc6UE5nELas5GEXzrz5Xh4JVVlKPw0xmS5H//wSj7X03QhIANhsceFLWE9k7JZftF0ZUz1LCbEo69NNqWvpOBA3XEWfeN/DnH0XoyZG/Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D6PH6cOMzYs89FGBsHdn0J48K5y5AXXAzBUVbhGxx0=;
 b=S5TsmQa6aAu64QYWHKs26/oNSErKtjCZxBp/KnvukFwekeiUspx8jBm8jO28/tOJWp0LypoZkt2SXjSKshULxyFXSgAlU5nl/9o0x1KkpAF6+oP6EElseASaN+FLoV25wgFmQhY/lW8sy20YftCi+ctiC8WVJ/g5yWzY4wCdgKYVnmQK3/gb2LnH9U00zDM6QV+Q+yEyVCv+3uUhCDpAZYnSS1mLCQfgK+s1TrKi5ujMJCCH+XVsQGBy+Srtq7JLBo0x97zQn6OqdsGumrs3FqgejtYmB21RDl62RyF6FzSBEz1VtMJgG7nhTLwohwT/UqqwRZep3zUSt25GbBNiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D6PH6cOMzYs89FGBsHdn0J48K5y5AXXAzBUVbhGxx0=;
 b=Z+PHqOWSPJV9VGjWTyJPGdXHzBBNsg3RdGDNDDf7izt4usNtHBAq7PZbbAOFpdFahUXJXMyYuZXLgVhob4tnPajXNyfG/IogwhqEekZ6f5qDvSptiWbijRMhx6RcXg1qDSVt9EW+OkF1OfgXFSWQievb5dWiHqMJLsQs7TgJ5D47P83kpCiLar/rvvVmZLfG8iXK+vhEppbig3f+xc35Y5fKaBhPkijNgkZdBwtMNbhKooeNhjLS2b0aJgbS2STiurd1W/ouMZ5t1oFlwgMbgm8k/35gzAOJwWo/N+IU6ItHhBeUm+LjZf5bVNA/9UfVv3eQwi5UaKMUMUkwG5++1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10332.eurprd04.prod.outlook.com
 (2603:10a6:150:1ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:15:24 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:24 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Fri, 23 Jan 2026 10:14:36 +0800
Message-Id: <20260123021445.3782170-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2a1927-5b59-484a-17af-08de5a25448d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UInhVPmJnL3v9lTWVMfbTGoYq6svgw+IE6mSnZYgGwy81rTEZi7xBhnusBwz?=
 =?us-ascii?Q?+anCR10NtYN7VR1Em22E9miUft9ariYXGFc90wXVkiNEyNdQ9HsZNQQBo/Ue?=
 =?us-ascii?Q?siMjhFaYdYxG+GASxZUsPDp6i/gOoLKUCeRxoERjm9icuTem4Vd4bMyL4rmr?=
 =?us-ascii?Q?Db6GkPH/Jw5IfgQfW5qzUxn8kRftrcfs/w7cUqxdfRPS9LFf/GflyJ+gBzeH?=
 =?us-ascii?Q?GIZwNrAgVK0kVJbb7jiqqu3Bm/2pFD77/FvVXmTTcbXGVwlgdOg3SpsDyff1?=
 =?us-ascii?Q?VNcXyPotbvJClDyOioCWXqGIuN/4PD3XiGIu6XtThCnEmwTp30brr4eY0lvn?=
 =?us-ascii?Q?dPoTqwJxS8IA70hMQPQ+jw9At6GBARjrWGPmSI25vcbwid6xIAHOeyQqOh8N?=
 =?us-ascii?Q?EGP0+tc8vNRBsGSO/dgHwIRVYY0YJAJHQ8MCsMczDR6tZfWGLu0WZ0YQtfWb?=
 =?us-ascii?Q?sGy9WaJzCdqnZ82HlQoLisS8QuPgCFk+9rxU3rN3HVchC/Xlxfvn/TrTkjIe?=
 =?us-ascii?Q?F1p7WRhrPLwl6sajXJttYpxxHnGcrwlymqiAfIg6PDWdmlKXwg89EmGMwrl7?=
 =?us-ascii?Q?r32E8x4xFHcYrHvlnfj89bcZZS/1+qAdjdhfrBWj3J+uSqy97o9d/kmjM2Z6?=
 =?us-ascii?Q?fwg0J9QWpXfhpVYLPNmur3gXgaJWCwbWUkAaLcYcR1iYYUQrvprNE3lo/0J7?=
 =?us-ascii?Q?GEjMyjqfksYxU81Tn26TBMvGYAg9L/hm7hNJmBMECn8gOpPqpMJzD8HQa6Ms?=
 =?us-ascii?Q?1Uajqr0OW0h4wZkXuAM1IWucxH50NwFOo5AF8MTZmRMqEvh7Gimt29/9uKKj?=
 =?us-ascii?Q?drrBb/kHWXEaJHVvvNJtbIq/5UDnu0bUr4GIgOwRQ8zvIOCyDjxSAlY2C4Cn?=
 =?us-ascii?Q?mk35ZiraOiUfSuZKbPa3bpwXrA93+8bl4nJFiprhFZDKQ/RXUnHwbZSENisE?=
 =?us-ascii?Q?FqwxXyeRsAbpLN7Z6T13jZp2/hf3AYKCCEba0Cs5tYR/Mhe3p+6TgQ7Tb0zZ?=
 =?us-ascii?Q?IQMRrRcrXnJHIpFgFEpf0TAIQ19L3dUugG5JmhEmp2j2uL3pOlTrYhvyi1yu?=
 =?us-ascii?Q?c/5KW86cVVK99kYBDQ/+221vnaFayX0XaR1mnmSY/fMsUrp8qzG/wqKMa83+?=
 =?us-ascii?Q?Om+inqn9b6U6C+GEafhzxKrwR6IWDJnDjaW6tkwGfitWWCmyNFQpfitWu8EJ?=
 =?us-ascii?Q?MicuwMSFQZ2K8c4q9psFPGOhCekSSkayhF4g+G5xHpqUR+cCPaBic08mbaKg?=
 =?us-ascii?Q?lRr+DsOsWpI1gDd49MEmCeOokOVKsF5lHLoqg8//kO3DHSOOERhxJIi9dGMO?=
 =?us-ascii?Q?ihha+KlB7mkVWTGGx5LjVGqNSxT3CO4Wr9jC5yEeFznjwereBQWW3pmSZsvn?=
 =?us-ascii?Q?reNOQNAegRrZhGjzg4gORAfKpOPZ5u1VpTek6dwAIZvJMAvpmKcVGk7G0wXf?=
 =?us-ascii?Q?44yPCs7USjAGcs88UW1CGY+hZnw65XVY0ApxXKFxbQo1evtALQ9oVvTFU/w/?=
 =?us-ascii?Q?YshmPSgp1pqaq2/NmgzD4mS2L6hcDMPerrq/FlbkwPB0jCG7szY9200jZNys?=
 =?us-ascii?Q?3Sga2SjxM/AZf8rqpYDe11oWZfdHG8WdMbSdrfsjwUQXqxRrGFZNeYzFDS/E?=
 =?us-ascii?Q?WHRC38hzzHpvEeMIxZPfGn1uZY6E4RpMbEvbHY/BIMZz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P22/4QTB1sEzzBUd5RAyUTVTKo4JKP0hsEXnIRv2Eol+mcaVtrEhx/uC7uPE?=
 =?us-ascii?Q?yL3F/0ZCd0EiNaW0xsqEzer7mi2oI5MpW+8p3IzmGJzgHggc1OElA7RRq1Fi?=
 =?us-ascii?Q?PjngAql2F/ppzxio9F2Imu8fzdqoVFNy7ZdZ4yRgRH0zEsRSyOQ7SW5c6dVF?=
 =?us-ascii?Q?d9YSWZQHOywy3TE5QVW93Qe4yICOpD8BRyBH9oWOyy1gHO1JuOkGGgxkKf6n?=
 =?us-ascii?Q?lyYlMw4lDOHA8d/n+/DwehtifWdLTRoQzAAktAdw1CS/W37mC/Z1VvoPvjSM?=
 =?us-ascii?Q?sk6K7Nhl+SgAx6LuQxxmyrZj1ZpuxKieS9Lw4ttigChQ/mMu5F49LMg/zSEc?=
 =?us-ascii?Q?mUixJBIHVeurNZaALDEKQtGXPbzlRmWOvelmqk/DFvaNjISpON+lF3V2eugV?=
 =?us-ascii?Q?6p7436UI6zbC3YFhvLdvBoU7fzbL/3ubjHDL16rvV2nbALkKEIgpDJ2s3joy?=
 =?us-ascii?Q?2hA7l3yniE95eGHLQ9oFu9M9lzR81ZoG7w3xY0bNROjbvzYKR4AWtwQRJ7/m?=
 =?us-ascii?Q?YeVih+U8mUFwqkN5vuRl9rnHJrD1o6JJ266gr+EmcsU9bVnC8jN5SBs3V5Ek?=
 =?us-ascii?Q?4wUqwZ13jVkbIcpyywf6TSq7h0HPJXBM6mndzezeKZTdlOEy1LxASK+mJqag?=
 =?us-ascii?Q?ws260RClybRxaQIo/W8D0Lmg6O+Njzk3EzWeTJsgU8iaf1Of22LOp99mc1aB?=
 =?us-ascii?Q?FHyB+wvZkiINQUQw2HgThtnfVK9IuYIzicCiV+fVXGDPaAna8SSsS1z9ws2U?=
 =?us-ascii?Q?dYcHYp3hjvb+b9OJKtaRl7squrmq2NjnL/48ZZe+TLhJRFe86cttag6bQDQ3?=
 =?us-ascii?Q?c+5UcmIQAKqKHlWdG9bOgFwL4w1r5WwoD7msr4PRU9CJMqfeJMTKO9RX1YJk?=
 =?us-ascii?Q?1cRJ/+dl0yWiydE/blYKSGXdgX+W7PQgidhBBQyDBy9AGUnicf1bxG3zjEX8?=
 =?us-ascii?Q?L9+TWwUeDtmJhfb8ONWJKGtYvkZnx6CtlecjvvmP9nEBlHNKLomny0YqfPQf?=
 =?us-ascii?Q?UYMR+d5IIsUdZKE+kbIQ1N8BdI9mQIRNszL61HwZxZOqU4tF+6W0mAN6BZ8f?=
 =?us-ascii?Q?aveqgZyWujTGBmrXuwny3DXD2fd6HLP5WQdwuQYgybfFSDaM8yt9PEonvEbQ?=
 =?us-ascii?Q?QEd1EFJDRO0Z+VwqUMXO8XAg4FNCQC78Zg9AuWfGmziLKSa9UUJ5mhIJdZHC?=
 =?us-ascii?Q?dDV67Gh9AEGHPKFOhUP8/vYhawqgXG7z8qQ17p2GGihdD9dRts8VCAw6ryw8?=
 =?us-ascii?Q?BoSYsov8ku624k6FHOHQnbncEQ/kvZHHDzVGRy2w//0yx/Sr7GOqoxB3nGmP?=
 =?us-ascii?Q?Z0+6ZWlkND0XZYXMFr35OYyz/kCjhKE/p91iHtEK52bonnTbZwzXumxNqX/5?=
 =?us-ascii?Q?LM7Lx77rN030LQQF0mKiobd/+7bAEVelqpAgRkRL4FT7TUNxJz9vLWEO7xMq?=
 =?us-ascii?Q?0qdjlFqhBSHFaNc1uu1+yqMypcl4YVEuANauIrpF4vcSPszEIO8Oo2gKWEIp?=
 =?us-ascii?Q?TtEZEiTb5mUCdKlkOiyq4BsMrLu51I4kjOAu3oJ3czfoCiekTQGnI1kNBfRP?=
 =?us-ascii?Q?+Nv+UW4HJJ+aMSLygYk+KFMupfw4nEZneTIHWOEg0CltepJoNyZogvxuAOhz?=
 =?us-ascii?Q?fAcJkS4VfKS6RHiyYYEGva+8GD71hX4no3Dw74i1SCzwQ6Pjd70GViyVXJm/?=
 =?us-ascii?Q?XzcOQ9Pl+cBOF/VFQDC8dyCTMCyNyVoOVNJo5IOw4t85tdjfHH1znDbc2192?=
 =?us-ascii?Q?P6iC3Mq1og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2a1927-5b59-484a-17af-08de5a25448d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:24.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqqIBiEd2lZvDFaX54LwtpXLuf65Vfr1B1wGIaoAc8qMgY1byMlt6Yas0BEcDsuIbcNFNUl4E1nKuoOwAWN9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
for the Root Port node.

The reset-gpios property is already defined in pci-bus-common.yaml for
PERST#, so use it instead of the local reset-gpio property. Keep the
existing reset-gpio property in the bridge node for backward
compatibility, but mark it as deprecated.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..d1a2526f43dc 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -59,16 +59,34 @@ properties:
       - const: dma
 
   reset-gpio:
+    deprecated: true
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
       sequence (L=reset state, H=operation state) (optional required).
+      This property is deprecated, instead of referencing this property from the
+      host bridge node, use the reset-gpios property from the root port node.
 
   reset-gpio-active-high:
+    deprecated: true
     description: If present then the reset sequence using the GPIO
       specified in the "reset-gpio" property is reversed (H=reset state,
       L=operation state) (optional required).
+      This property is deprecated along with the reset-gpio property above, use
+      the reset-gpios property from the root port node.
     type: boolean
 
+  pcie@0:
+    description:
+      Describe the i.MX6 PCIe Root Port.
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -229,6 +247,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pcie: pcie@1ffc000 {
@@ -255,5 +274,18 @@ examples:
                 <&clks IMX6QDL_CLK_LVDS1_GATE>,
                 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
         clock-names = "pcie", "pcie_bus", "pcie_phy";
+
+        pcie_port0: pcie@0 {
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+        };
     };
 ...
-- 
2.37.1

