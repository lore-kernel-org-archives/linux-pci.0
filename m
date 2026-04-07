Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EA3A874B;
	Tue,  7 Apr 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558518; cv=fail; b=qqnVEdx4v9IiSoCu072uQhJBewTn0aDxsodqVnGFnovv4tpY/pWLmkYEbzL8tZOkmDqz5DQol6KA+lTwJD4O3CUJwN691nQOuJCddq7qbeF8jbcKRqWg62H9PHlujgACGb8adLz2vhB0Bsnpe3Em9TjnQmq/oJfxL31hMtdWp44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558518; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=haHfxSHIsGIT6rlU3odu8u5wmslBNYJSFZrSDdwg19rdgdpzEbC8+8mm8xofXuPWdfOWrBROn3MVhI5rnfKJdF/rSihLZ59aEeWMcugCKklTICuCV+NrHdSrlnJUwtbNcX7ZUHvLjbcx+1z0CzQWmkZ4JodGWWIPnmvMQfbcHZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=duCRVQNp; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="duCRVQNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmHk9dquQ77ALkwJC+5y8r7mUU49BCXvDgXwnZL/40fZKeqlZ071M4mVe+HyJHMRjWwaBkbbkrmk7XdsDpyMqcJMeTQXApG4grRR72LV2Z+BH4fQssL/vl5o+xnF/XvmCirL8XtOgqPTRuvim68Uw7+cx8NpjRk6ydnMdBQQzj15CzdowFzBKo2u/kh/Ybw/4OzTMFESSMUc3KigO6lV/WX9eqCYpIwBtgkDP8IdIHSiK9DBHNaupdcfRuEbrWKZJyRYytLP1OSsKOpFOkH7U7dn6OgK/lYI16uROoP0nC/aYvClDk6Wu4+1k1Gpekyyf7B8fS0SEhPXnzpbcYDMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=eyhygPAxODDp6hOQrActOJy4vCV6QgEdNI+QaukVCoB0C4T8GyX2MdpGzztQT3b5vCcxQhWCD7fETZ4cNlKwmY5NkShNFEy78gwYJuzwttnAmj32jnsKqri5UuePKu02WXf596AfxwIFB16D4KCIEMyHiMW9v09iRln4t0oaOBR+cfz2rLeA9JAxYL9pRqViHhuEGqAQkf/h7WmkKtC3aC7lvOs0NpVxNd5FlCvEksEPSq7Or2Y3M1MM4LfXZyhdblVbLHWWDLZ3CDqw6ynqbFojb/8EHGfXIAHKfpHIechW+MSvyd3VfUB5hwK/6nPcZBoCzVGi1fR88/OvvPHrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=duCRVQNpgg85TJNN6tarxicm5EnwCumNTYwM6P3W6HojBE73cELOFaXcoDHLEeIVMfZ09/JB501zAVXxZiCWmLhmeOvZzS8li70SEDkkxxSGhEOz0PmKi7EQ606tixwntQHw52lIfCKgPTOFy6UM7rKSYWKLoRMfULSz04bAAGWMXU+INPaKu8EdErh2uZQ2co3noelJWkvFM/BQi4Bz9w/8q16ydBGxZOu+2ERi3oX4l1/ggkS9nyEe7kJchF+ZOOJZHQgzECnGPNzR4M7UwVdBiWszdao8Vsrlrbbw+g7oM8YWJKY/5FuJOP5trN5Q4Cth5WBhbGQbhsauMxTlcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:41:50 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:41:50 +0000
From: Sherry Sun <sherry.sun@nxp.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Tue,  7 Apr 2026 18:41:43 +0800
Message-Id: <20260407104154.2842132-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fd92cb-dd48-4ed3-8b28-08de9492469b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KtyFKwdKTpOoZr7FjRp4PYjhPJYW4DO1AOJ1jX/nkSSyl8OcIWQIhQiYKeYklVXM5gvu+QYTU6QR6XNYKNYxF9zm+jals3yDQUYx4rkDd2ZEy3CFy6ZovLi87mWOj9KAUlNBt+pRCbC80riVWjCHdEBw9i8NLCgM7Hb/+B+DxZuO0ZgV4KUv3qk2rPKwJw32bxroDTY8LGij4Ub7wLXELC5Umf4JbzXySFA2iFFGX9WnYMLjiOKEj4q6mPv+63tCx0ezYyIic3h0hU85Cf7N0dBbY+ukSHttxoMejcM/Mq/jDZzWzLdSEBMLc5Xy4lVd8WKRvS4W2kqje3dF/xS7ORA6afseB4xDa8cBOOcmIf5KF54cp8YQ77ntcPpKI5bmlPtc28Sye5UArIOtGqHDnN+KuHrEkneud0Cm4rP5Bfw2N2x5Cpji+rZN+KwmEQqKs/jYnxIUcej2NkVkhse4Z/oKsG8nSf35tiYrB30pwpBrJScnVu4yB/9+YYlvlFgWCD6plL/gglYaLG0CpgtjwPnomKcNkt7lepuNuorPZu0Nka4Pk32ljw4TDatudkXS6QaILIdZ5Oxi5pDNb3LrXQphnOT+UdjFjG8wbA5YUStv5E72RoaBWzkjizNKAAicaejU1ciRUJrxNNs5E7+vM2gzwwvJFq1Wieai8KWNJnilwcIbNv7jkZl4s7nm2dqHGqATnFQxu2yVlXlrCx0kAldyhrTTPHF3MHzCltTR8sOH2BD4k98KkHvYOfOCOxT/gWSoeyryhPp5hpcNetorTzJNssF1M6HbEU5oP7hqnlBWeUJFTrswAEpmLYEUzsVi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0VpHHrVh/JKsNCtr1ou2q7OLwAWclYFZ+V7NuPPcUzG07RFK5yEtv2H0o1o?=
 =?us-ascii?Q?J2oaWMQ4ETnFLWkFSuT4PmDs/PNncQMl10Wsb5pDbWekwV+Kiq77u56HWY2t?=
 =?us-ascii?Q?RPU3jQ7wG+GlykpGWoM9B7XwPPOO4ZmSzubLk2Wv+wNTsLscHheoIqUBfnBl?=
 =?us-ascii?Q?YKNfXPEQh4JMWa5fNx33BxfntUm1IKQJV4XULN9uyLlHaCrzy4OvDiLaAaCz?=
 =?us-ascii?Q?SEVAl1rcGRwQjFfTDTS2QSkz/HBJzt+fF2D/+h41QZS5QNQ+ZiXb8rKnk2Rq?=
 =?us-ascii?Q?bpvJL/kskmMSWvFMWlMqqKsKOmgYqgPKDGe/u0Ylc2z1a92CjaGsYmyIDDss?=
 =?us-ascii?Q?GF1A3FjhWJCfuoixKPZ9JvRGciL/LztKTJSD65NIJAymaadkLE0kW07Vw8fc?=
 =?us-ascii?Q?Z8wooo/yh3qXkK1UIdn1skIGoSEpqnaNGwCZ6qoH/JboG/9Z3Owd/zXAY00r?=
 =?us-ascii?Q?qvu3fcaLmTxPQp77dcPhilNRL/2TcuFEIQQ8X0gEGjws858vhlI87aqH1M9v?=
 =?us-ascii?Q?f5PxOJaBBXJn+0dyg50ik0qxv41vGaxteug74p6ZzvA5WcNRybCSKm7NSAqE?=
 =?us-ascii?Q?N6KiXcRn9bWf4tVjnDGQVUJo+ZZ6EsGu1AyfvC45xkgGciovQJmbx3qczqkZ?=
 =?us-ascii?Q?P70Z2hsh+ts1rUloeZBZKyoSXXAa9N+aAOxBNYVDzrrHDAFvPs/PGuO3XR6+?=
 =?us-ascii?Q?/Y07ccW1CyBeVqmRVnN7XINz8pWHp9+DeTfCBOavKM8QB1p7ujJ1/CFEx52/?=
 =?us-ascii?Q?QHBfn8olnfdyaJinR6CgHEj/7YtcBdkMDOSTxz+n2yWPTJFTrP9TQ+fXOIAR?=
 =?us-ascii?Q?2FJ2TjMsuFQmLA7043XGW5x9M2EFI1yGs6OrQIWvs6/lyblglJ0FU9kYmzTk?=
 =?us-ascii?Q?q9EnMQuSsEsve/LcnJKAiAd3eOKMc4FpQUT1y01FEpq296nIu6KgCTRiX65V?=
 =?us-ascii?Q?yJsZQbik8tMYFpsz9Y33GtAklaJf9t66Wpg7mih4gM8/0M+wQa+VrN22lYkW?=
 =?us-ascii?Q?wO8/+FoyaV5YyQcT39a+WKmpshjbk76e+ytSKQjl2UIyYTkQI3w0lruhnpB0?=
 =?us-ascii?Q?on8px5hJjTM5gf648A2WU6O2iAg+DNzmlJO1rrzFqmXz9iA1mXXx96UrihCp?=
 =?us-ascii?Q?GqhdU4kG4L1Ad301ezondqvOg80PMS2W0w78/cSDbMuBVOe51l9URCCYHzMw?=
 =?us-ascii?Q?3PFwjTjzgEEk3reO6Nv83NNmybIqO/XtrG/k6Ob4vKTYnyojB7QWNPBevsmQ?=
 =?us-ascii?Q?hey7QJ9KZp6pR+6fEQHkH/XImgf6HULMkwFBzib3VslikFWfw2M4f8sZ3mPF?=
 =?us-ascii?Q?c0JD9syTZFPar/BPhDXqLlsu/gNGNmFhGeGuxhaF7y4785GsdwllYuMDKeAB?=
 =?us-ascii?Q?008fMeTiNq29/1Hf6purnhb1xDGNYpf93j1/KDelsBEXddirBs62jj3gfmdq?=
 =?us-ascii?Q?jcKvKj+j14/PsyyK8wFzpiilXOlbWr2cZsfwrhdK6CvWig/gcITGv1JS4HZV?=
 =?us-ascii?Q?Tvi1mr84zcdGaFuptqWg2KWKG6VD86Y+Z3LZcSRpvRLInufhAJvWJ2EIUeLs?=
 =?us-ascii?Q?wEvnrkzB3H4PhKpWERSSXmPAw9KpyIWjRHJ6Xjs9LOMZxiKOtmpnIJHY0yIv?=
 =?us-ascii?Q?y+pEeRIY8+rAoeilruVNQUcy4Ke2wZ2zjqTI6fvTOPVSNW6Le6dxqC4VXdEZ?=
 =?us-ascii?Q?UPNIMUgb9kUSFknrn4YwFKQ6ouC23sIoJt6aDKHIkvVYbtUbfkK9VxLzfdg7?=
 =?us-ascii?Q?SgWs0x0ZHA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fd92cb-dd48-4ed3-8b28-08de9492469b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:41:50.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq7IQkg49/tVYvnc86EEvGHn/rjns7pDjMp0lpCM8O0IwDZRgQ+83KndhKqppTQW3YPNP1CxqRezT3x7/UV5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
for the Root Port node.

The reset-gpios property is already defined in pci-bus-common.yaml for
PERST#, so use it instead of the local reset-gpio property. Keep the
existing reset-gpio property in the bridge node for backward
compatibility, but mark it as deprecated.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

