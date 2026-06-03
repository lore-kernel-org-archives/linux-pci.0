Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC838C401;
	Wed,  3 Jun 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467747; cv=fail; b=ORLFNkYwIyusjX8DtK+l9Qnh4qCLLOxR5+pwPwsfbNfOr1dQ7c70RwDlLCxfmZMXtbr5lXcH5MkTY0yCxHOVM1LKqr7Zlkurhry0eDJXIrlfrGOQNXSOFcHm9SL31+tRHr9TkfsJzFb2tBT0oKFCGNHtn+dQLdA/WfJinsqKVzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467747; c=relaxed/simple;
	bh=p7b/gl6VHt2n3sWAOyNiX0q2indOH5ajX7Y5wmslv/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skusm4oMmv0ytJe+19SWfyzeSvp6qUKMjZNQ0L5asq+1InyXwMvpxKtsczZu/ibgjAd3CceQmADvN/UMpesC7ST03OJ2TUsa60/hJdpd7ZIBdXEJkq77KaWbaoAuBt/TH7Dqiz5MMJjtg87r8H7l+wCHlQ2ogzNADUZitr5x1SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BprBaST5; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BprBaST5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2htKTrrhFDcARD4gKLETQz07tl23SNHwAIDN3tnyZNwWA6IQ4tzD8r8uuu4fPFSm1EU5qJUpimZILQ/lt1z0D18hic1hPB/Vfs5FsrosVExk1opar3TZvGTvcurAERFCA1rOnlXdoqK3gncqdPwYmqGppOVRjf+2JbmRMQsLkG+mRZ+oLD30ajda2faJTt+x/txjRwtr3dFzoDPZHoYj/TjC2aPvr/d5mpXIfN3bJKdHd6mXK0NXu9ocGuJbJdrMSQtfFi0gq+Bk0dWICHX5QVzjkFsKtIMvgpiQU3Oa9DEHGPW4tuHQBIIeQc/fFa3nXzO5W8o9kfjJ2AI3khcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEIUU+mOPoUda2PoIMvEoqZs0urcWvxqrGsUIcBPTvY=;
 b=JyiZhp5xR2RbgbXZEExh9xvmbazh1TnaKsxxvXffQb+Suq/5OMgkmSHu2bjKS5022PZCv7/vRaAsg/B179U7b2MUwIQprzgyjmyVceuoxFFS6n1v+WO51zIdWzAhr+OX+re9Jn4NCxN+4VnRTty413Pu1OzZ1EIu6XukoMVlu63rehT4MnUMA62T2ajllSY7w5l9LNAOQeI5d50SuLa81ccKLyZrCzXcxY6LSbQK1cdhmRGSMkv+tkd/FysutHtCb4qRVJhYBJ1at1KfuTh8/fAvdwNeWp4n/q90gStO+R0RgKnH6JeE9XNjG/vMsgh00weQ5pIPRfD3aCLwMqhJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEIUU+mOPoUda2PoIMvEoqZs0urcWvxqrGsUIcBPTvY=;
 b=BprBaST53RYcvEvi89h8Ix+OjSbfdgO/zhbsVqQj/ddUxJZONCuZglz3cqoT7v4kMhGdCB+ErwtuUYmAgAr/Kmiujc6u+iXNnYeXKdB2r+lEzcwCSvbdPFdquJJLGcmq+6YcqYvQTpq5N8IvmORnXoPOwL9k7+ZZizIcN+BDlq1yF/k7ZnEbnq3n8UdL84UJ8ZJ6w2ypIAWFXuEcZSF06dOuUFhj6DZPkMgc6407gg0K9QhGP4PidPfanMemaNBPxfLTEYFdXbISj3hHEBdIETRKb8C10GPV7rbSqkNYpzjjqHEkDr2DCdoAjqMqVgW2hJOocMjf9A+uc68ApaKzgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:22:23 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:22:23 +0000
From: hongxing.zhu@oss.nxp.com
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
Subject: [PATCH v6 1/3] dt-bindings: imx6q-pcie: Add optional intr/aer/pme interrupts for i.MX95
Date: Wed,  3 Jun 2026 14:25:08 +0800
Message-Id: <20260603062510.3767610-2-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
References: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0252.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::8) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b676e0-335a-4502-cd42-08dec138792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9Y3gqnURpM6Blg4wRS6dz5CKvtJIqduca5zmqSgoCofz88r8gaA6S5X37fdS/OYjoOBur0yv9raDnI/jE4vtDWEpx/dO/p6q6vnZrUZ9gntXyx12gbsY5gaMT8SvtiTaujWQdqTrFK9MIup+wYfC+FXmtBCbO00XWcmzgcPugOfm9Jm2jnxEQK3OzQ9gv7hQT6lKYTFjA75hkfzN7hz0/FgePRCuRxbMf3/aTfNI7hGWRqmkumw32LPPldm4mIL3B10V3/uqWf+i3V4V5Caj6cg5Xi2fvsCgdYA568Ew8NLvcL8kKnGimjQwcUPgzHC88CY0O3VPeqxWVrRW7vQEe42CtaLjoKXaF3Z7FQm+vzNg/Mn5NwDMamKFRtu0XYekv+lyfwEt3m/Vv3kCPr65ZOVkNDxt8guiN1UXLTDavz8gWGTlh/13sc1ylqMg+U96vZrmV0BUolkBNKMOluX/uYKJaXgn48MRNNC6f8fMkaUD/YJt9MsuctsVTk+IH3KPOSjIBFrvqySbI96GshAfXhFv29hoiD1gNVdD6VPKfJXxpskXX3vpCFxXPMMKR160ZSf8nPhnIvhn0F0W82Ugsu0MsnB6FOrEXvbYG119X42Udz2vbvdJQps5LMQJLMHkrJyWDvGenVrFSDi6W5Q67DGguiwegHLhR2aK/QJP2Lb8qVpGiI62fUAyHYPaZxrUgRlFTNtuJoPTxYjYnac8kaEzgOc4z0w/IGy0weDeMew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gOx0vmi9DKfP881t7RtQITYSqiuHsxF0jTDxHdM1KpkAvDiUjBk3CczPRVDQ?=
 =?us-ascii?Q?x7eGYsJJtIpzeIgPOIa7Tqiv23vBYrnlmUkd7wph4QtCEbPcdsUfXaqZwL9E?=
 =?us-ascii?Q?ovOWTKkmS1k2P6TqBspGgFLtA4a3cfZjQcW3rDjZbU4HyV+GmddYKSCFBzlo?=
 =?us-ascii?Q?t3ssxWFotgxUQ/xvtOVoqNkC4MFVcmnvHI38N5lrsow4Lo0oR7nvjahRQb8g?=
 =?us-ascii?Q?0XmgPENlDzd1kMI3KI61l0+1KjPXlPeVL/1m92hBbfcgD1Uutark2L6OPbPD?=
 =?us-ascii?Q?rsVOxvFGqK1uaOwB/3xVamBJYuTyZGvzKDeLHlh5KQPIbPgvl2fqeScbl/KN?=
 =?us-ascii?Q?/KkVVglIIIOJYBdYdnKeTzTLowntnqT98SBXM6tKC6upfEV6B3OS+SsC6XVa?=
 =?us-ascii?Q?vLfwEbJmAb6XIdYS8pC+vfyjGf48NR1ovaOUo4ZTUMxXdisSjXgFAh8SbXNd?=
 =?us-ascii?Q?OFz3oaYh4IkIQbwrBwtzXtsfe+bkNK3sDmw4mFm0UctLZ5mVf62UoCiiIXyZ?=
 =?us-ascii?Q?luNSvOISOwmuNLe13I/wabRijWFMgGNWNqcaX23Y0MJxmV9eQVgL4Qh96fuZ?=
 =?us-ascii?Q?nECwJ1UiTS8WexMg/BH8NFrzAitHKNXGEZW+jdaXwlWRqqdophFEtDFCBZTl?=
 =?us-ascii?Q?MCI1ZvxpFVrdUb+Dl/Ebwti+rLNpYz48sus7OLT0qk0p7sch3WaQ21ubaMqE?=
 =?us-ascii?Q?t09hpxvaLdvk1oX++na9s3bbjiyvF0elK9ghY1chwdoUvS54z1NatlQ1lBxK?=
 =?us-ascii?Q?lIvnvr6hETJ1a7focMCWu/DW7grsGJrGGUnOlFEmL6oIl4NMTruHVx0eo6LQ?=
 =?us-ascii?Q?mBsGHQwfJs0ULmu/znNmJgONqEaWJhHyngTkVo/h7noHu6nvIoDKgacK8RDs?=
 =?us-ascii?Q?2izWgnQu7cx0ywWQYXP9o0xH8B1bnQnmcGzTJ4xTRoMV95Uoe91DyEFdh28Y?=
 =?us-ascii?Q?rGohInYbAumvhIv3hvopYNaWqKLLvNJBNsuFgLIZ2X/bzmjqEp1qgDIA/o4Q?=
 =?us-ascii?Q?otuq5vTz4LoIBudCDXW30erIa+1b0qt9kJ0CINMVfWCiK+QG47wR+y4JgoWw?=
 =?us-ascii?Q?TQuRMFrVzFpY/Y40JhFQ3B1+WF9h1iy5E4hKS78Up3hXMB7GQ/4iw9Mibd+n?=
 =?us-ascii?Q?xyMMeShkNqo/B0hoTT61o6v0lIGfEuRiEE7CPKJH4tKGFL/2Oo5cPtH4am6m?=
 =?us-ascii?Q?+2fX5Y/G/PxpzSe0HCjYbq84IDqJUX1BTsv6gRWyBPSmxLiDCFajs1Ce49Zv?=
 =?us-ascii?Q?L4d3u/W9ycSmSSlRFirmRMeyBcTfFgxgN8AGw0oEd37fJZRkra12Cjvx/AmT?=
 =?us-ascii?Q?YeIn8D8T8TH+JRxz4qlKXmB4TRzN3EVXqW+NljX4KkIWBeM1pJ8pdeT5fvCb?=
 =?us-ascii?Q?jQ3YCYa+PIzevAhIKHSL22BgXicS8o85Iu4SKd0t91cKdXkOWqrV8bigi9zO?=
 =?us-ascii?Q?lzoXOdijflcnBBu4KBtuxLKJ6WX39h1gA1C6UkGdEeoMVFiQqK0kRwoGepa+?=
 =?us-ascii?Q?gyvVHXO1SP5Zqaz9Dibau3d2YwIKxHZwc31l7/wp3MG3EeC2S0CO3ShQsiEh?=
 =?us-ascii?Q?eayYNCR1NfxsUm0KiJldEJyLlfCwhsROj0KynF+tc2IsaOcm5XHMzeLL6d5r?=
 =?us-ascii?Q?i4cmf3UANHLIBfrtLQY4B1aQI7AbV2zGWsjUws7zWuvB/NjikG4nOi9aEhY6?=
 =?us-ascii?Q?T+J9s9e9+lj5rHhC3yYgIgolH3wDE0V9JkYEwULBS9bOXQyEQHYaz+Sfk5it?=
 =?us-ascii?Q?hqxwzalxVz6VUQDZHuRs6xqBBwoalXd0EEps6Bhjiw/cW5n+llx3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b676e0-335a-4502-cd42-08dec138792b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:22:23.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c5gI5aKBAz01AqyGK1Dqxl/c2oIccaDUg0gkthI/EATmiZAJUsExk5bUTW5hozxEmCA7WPUVgqjvi8Ip35vQVGRJcImvOSBvxwRqlMYuPB1JlyViyv0PzEgJMHK2nky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

From: Richard Zhu <hongxing.zhu@nxp.com>

The i.MX95 PCIe controller introduces three additional dedicated hardware
interrupt lines for specific events:
- intr: general controller events
- aer: Advanced Error Reporting events
- pme: Power Management Events

These interrupts are optional on i.MX95. PCIe basic functionality
(enumeration, configuration, and data transfer) works correctly without
them, as the controller can operate using only the existing msi interrupt.

Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm, imx8mp,
imx8mq, imx8q) do not have these three dedicated interrupt lines.

Update the binding to allow up to 5 interrupts for i.MX95, while
restricting earlier variants to a maximum of 2 interrupts using
conditional constraints (if/then schema). This ensures the schema
accurately reflects the hardware capabilities of each SoC variant.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index e8b8131f5f23..9b5d4e59dfff 100644
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
     deprecated: true
@@ -248,6 +254,29 @@ allOf:
             - const: pcie_aux
             - const: ref
             - const: extref  # Optional
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie
+            - fsl,imx6sx-pcie
+            - fsl,imx6qp-pcie
+            - fsl,imx7d-pcie
+            - fsl,imx8mm-pcie
+            - fsl,imx8mp-pcie
+            - fsl,imx8mq-pcie
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
 
 unevaluatedProperties: false
 
-- 
2.34.1

