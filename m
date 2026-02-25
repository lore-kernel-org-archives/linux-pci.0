Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A47392C3D;
	Wed, 25 Feb 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016858; cv=fail; b=iO+oFOu7wVCoMyuzvZ2w37goxJ5IP8VIXlzpsU+1INmTzj5oPwzIahBj6NXWubraOSpoCnEOD5taVLunrRPbncOyWKG/rSbWBKCHiUyZX+biz6wN4iqmfU9pbVIlHkttY/fF37KR7aS15BTB3/BDSVFxK5N5YLudMJTrtzBaUjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016858; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gBTvUXZUNw/9Pdk+SQ+5ZB1Jkl6aeN5nkNmL0EkkVJazyNNj4KNx9+9KGdJTdFr97ibGI2OOyJQe/XKYzoseI2pGz5fvRSN9BCmX+4Amvv9bcuo8ZDYn6UuKerVoC9m12GPcuFmIJ0cJRMer8neqhnRfXnsLM9XYIErFzlBNHkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hlk4QQKz; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlk4QQKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Anhnub0LdZj9wezyrzv+ORP7XENXG21zfj3dn0F51wupBSU6ENTgNkSnMJPPtRIcOezLksecZKcZg+CaVPvMxbUH8i/pFq1RjbJ0mWorC0af0c5WBRlJqcqHeNr09JVSEXtybR3JiAjO/d0xWx1LRPfmo5EFnvIhxu5WiMB3wRBO2mNyHRHsw3ZxHwlPChk/gZKSG4F+DJgUHIic6cTFpmofRrphVUQzrLayOe0HwdS9bZq+AnLPRBYo+hs8/fNbNQKML41LeofdpnjiVhnM+Uh4oKuaiHVjdOyOQzcL9BAugxmwY2LmMHLpo+NtE/ECOFSPKTuuLsFvrynJaVlPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=qlGLsZmJ8HCmd1HKHQVkullbMqAiWtM+pUDGrr+SbQ9bvsZeAnD9veqC7yP7Es8cBpEE4BTOn1zfj4MMx0haTp2BIkQUWf1BpyIFlzti3R/2wuHFOhyvwk/xozzFW2829Qfq4ZoPo/3BICGVedCO/uS56pUw8a2fBWlyQ+jOQzyiHyTQFGt7C+Zjw4Q8+UI5fwGnGTS4IGAyP4XSLgocRW3nzi7HGW+ZVQgWCS4yTy4sExe/0Pg6igO34wJdUdeMUOH1C8IaTDd0miD7z8ojuqmTKANIElN1GmoQjvv7aUFiXZb78qXt4JEdiWaqNzgm0DHlhANUmr0V1/SrgtRVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=hlk4QQKzH/EmF50F613aF6R5NPcmqw2DzzQYlB+Rp6QN+dxh7lZBXgJxbwMjqTbSydwwRzeRdTcRZkNXi/s34Mq+5KRFQ1MEcj7I9Cak4vcZvmQJg7Lzt8ZUPpVOXOEJdbCmInVaO80Zc83YbYUu8iiy2wFIkBGFHDsgJ4isM1gmDUUXd10WZAyUzykPSOjS3vnbLji2CLSaGQz2Ip7gM5KoPij5Cbw0T8h2SzGX6X9r5csln8VdkVaQbvjwDWlTFl+INT7fNLlGmEnknWC6dNPFvtq2polgKa59dkQ1UdxW9HWHMLotNRKkgfkeZAwtYPsXVWAGsL8Jn3/U7qIXpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:54:14 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:54:14 +0000
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
Subject: [PATCH V6 01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Wed, 25 Feb 2026 18:55:12 +0800
Message-Id: <20260225105523.748775-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5059204f-64e3-4c32-7d99-08de745c3727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	xoU9r14ozkJnOw46BufdOEKZgz1xa7MvHojNxx42y13VoZnwQ//zcGqMGcAYFgkqAkEAcfKQqzMbtIUs4Tx3yNkVk/kISCJ3raqfb36ynvZ09JLTIeS9JZGc31HofuKPSrYCw62o2L74g3aOXzBZ49R/gxW1o5wi1jKWyTyxNQRR0bJY+/IV4phlzp08F5eb37n71J0Nh1BZVnLCK3n3n6r9jEjqNhxJN6W+lNI1djRM85eIokQl5fOBLfPX0q/q5KqQ2RSkGyxWiXbq/eSJ7iTujvNqsWCo7rnkdl7pdfg2PskndlxWxsGDUNjJopZqjNIp7WRwNsiuTil20wC1BsIQ/J1ou7WC0wbO/91m8k4MvOTKtrfRVeYmXf3dyAhjFlq1cl1f+9i+44WIKmYYAviaHCRVRuIkzKH2X6j4wOb2Fk7+FI1xWAKTerZTzK9+4xcZM9bb94LV5JJfO1r3XT5IXytHkR3dnqwHNDK4bcwLbzVd6xYJBa3eeKNCR/ilKaHoYDzuibUoDeh5GtOEMhzMZM8sGyh+V6kKkkoI8a2b5sK+hQDhTwOjX92jmEwfDmAxIJTJ3705imLmr3CQcpl499NdIM3Xsy7SXEnYY6JSVOR2tKebpX7Bg3ASDZkUsjMrp5C8OVpB8K1aAqUt1fscoDRnPErhQNOjmMP4zDOETUQF+stYp03gPjD+At/fLj51KSN+4qb2q6nssiIO9skxaiV72lCQILKNvWqUmcJJXpL6T6Hk3zZMtL/hKGBWvH6qUO7t7pCF60jQPoK6s/MFrlrxJqjgyfkswUk471tliPXLOpgvpU94+qbzaOao
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qwnFf5s4yeNaHLzOq9uVGZtWab05xdH1eiI1nPhTcFRIYM1OgOt3JlcUtXS?=
 =?us-ascii?Q?BZ2MQjPQeObxmMdVYJH/dbfPEBc10KWVUY0rx2tWdV1zcOAWYdmCJUC73Hre?=
 =?us-ascii?Q?roXDWk2J8kdQ3GAA9rHMX/io6N7vUnb/u4XyKMe5psMfAOMeHVTVNV6jZvOV?=
 =?us-ascii?Q?rrUHcg9Iaxz/jW4RohJr3Xu+14dOP0hC/xQSHBUryRf+1Fz2TLeRLCzWBVAl?=
 =?us-ascii?Q?ZFamOxipiKQ3EFvQ9ySXfe6/zld4MK+ymg0kNeEmllzS54TQ2by1zbBk7Vzu?=
 =?us-ascii?Q?aBC03/bEC4R7JaP9Fr+Ahomko55raQ203GxGyk7ggv6R9knJcsu2RcpUeHYu?=
 =?us-ascii?Q?w+7VC4UbWfv/liwEzFp9K8epC7J+DqcLxPqm7+sYvECx9PKQQuDLE0q+NuXI?=
 =?us-ascii?Q?BTwcf8NHCWgwoJaaOlpcS1ksUkPvrsi9r+np1krmv3B4HjmgJnY0F1RAUeS9?=
 =?us-ascii?Q?3fDKDPsAcV9x6OnKlCkuyaUNQVlYg/krhveC2Js9BT6dWfugJk3U1NBDxdjE?=
 =?us-ascii?Q?sVqRHmKBSkKaROqWmbcQJu86fQhaKj5UU/Dd3gxxOnj1oearE9AenFsyvh9q?=
 =?us-ascii?Q?Tt84xxzABrqfV33fNszf0fVTNEZR6qiVm2o3RiaZVOtJ305o3BdI1NiO4odq?=
 =?us-ascii?Q?cb8QQrAGaTIHHus6EiVRKqTQUWHPdXQEKagNtF9JNZPj3vimlP2Fc8gmfE7r?=
 =?us-ascii?Q?gXbPDlxzWdXeDGkSSUZ1oKqSxtC2pPJchgSoQedqv3Nd00rNj/YqOfqO0xjz?=
 =?us-ascii?Q?iuCg6uTfwI8YwglprAt0Bjh//qPPTVCbF1tB7naztlY0uFr+H1WUBkMnlh99?=
 =?us-ascii?Q?2+hdZHsJ7Za0BUkmeKVeua8i1b+Ndwi/Qf7MHo8jQDBgqHtUO+q58x65oRrV?=
 =?us-ascii?Q?/d1OpH2O4Sp2ndpuGNkTy+CkaM93eJXILhe//U7vgVZPijykuZTgnqMyIls2?=
 =?us-ascii?Q?eHvjCnHyRcB8UHeUmh3k/vQsdkUqn+yRv4EcnWFK2F1iDRCdq4EEl0HkdPEb?=
 =?us-ascii?Q?Z7gcVcdNENUzUu7PYm0X+oYVVPwQIH84+Uqy8+rkZgfJvEvRVPDKRHhIjtKi?=
 =?us-ascii?Q?GbqJ/nAqI+0NlCBjLBOEj8j+rjgnB19wCw7Mxem+rclg5yVbxCdEOM4JHd3x?=
 =?us-ascii?Q?hF+AuAiq/f6wwrWNB03i3Bm7y10gyoy3jWxlM261HYKVHO9bxbQhyv3GQ2zO?=
 =?us-ascii?Q?D5M8gdInudnHCT36ekmP3LQUGAE63WBOKq4tkg824+q5qc4GuKndu/ZmDDGs?=
 =?us-ascii?Q?Mmnc4rkAqGKgPe3afi9lKTfhFD/3HFHTeh0hFyDD51XCuUbq8x+j3j72JThN?=
 =?us-ascii?Q?yF+PyKPMY8IWvUC7hA+AtauBgdpYq75twVGKfGW3XYvN+7+occeDWO78MGk4?=
 =?us-ascii?Q?531fg1YHihnilPPs5EXjoiQIdT23oIve4J/lkjISuUvRKvOVR/YL3U1rodBq?=
 =?us-ascii?Q?Exx0R9JrCk/XuphCHpSvGLqxujIGSPt38XWasEmr/Qd0U5Let0Zens9wF7vd?=
 =?us-ascii?Q?XJLDfGATR7Df6c294SVDno6xTmHJb5Pzn55xpt38hFxI4ZwtXAz/HU/RE/QZ?=
 =?us-ascii?Q?0R6WjEvrjaUN2hDntIWrJR8FFYbPLYmeMI7/P1HrITvClzMvDfJomg4OHg0+?=
 =?us-ascii?Q?51kLDqJf5yHmtNreCNRULQBR+ZhBpgZhuLYhSqqqWzrmZepyEp+XTR061oMH?=
 =?us-ascii?Q?uZHM2PJ/ZpM+2JuIeHFbO2NGFfPJyppT8ji2NMboBPWx471PVgtCZS8dVI7F?=
 =?us-ascii?Q?Co85p55YfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5059204f-64e3-4c32-7d99-08de745c3727
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:54:14.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWjwRs9oSOCWEFjI+txRUuwOcqG+GqDGq12NBBAIa8YacgC7tFOXdiLHoP4JU4ke96ttfnmoJP4L/RgVdZww6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

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

