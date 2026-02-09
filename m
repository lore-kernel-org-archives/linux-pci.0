Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506633090D7;
	Mon,  9 Feb 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625437; cv=fail; b=hIljZBsRZYAlQEwNiG/VGFvv1wimBlE+eit9LOnlZ/nO7fHZrry/gk7NtFIbYLnnk51PSmuZ2z/vnpuWgqdijgOQEIUGLy3mTIphlI7gVqdueLR0moGRtaQ4r+IPL05iQI4Mz6AO46xWP1lQ2X2c5o00yCEBsvh/hXq9Lox2CBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625437; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZE/IS2pWpWKKzP/rTPM9xKAMAKlHmy1j1Sw+2ldf97rAewsRL5yRHo4/9Ag9+mkW3sVcz6v+R6a5tOVY/zi7HiXqIFcRvDS0SiFDjOYMqZvuAP/WZtbXROlvazjsoNj2E7hYiXdj9kt/s2XjQWriKHKlIEmqTZWmTCBtDfFKK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bs+FZvn8; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bs+FZvn8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4MrTd0KMil3ABRP76tBaCOnQ/BRy6/5S4RZ/s+h6xSqBJCfHd7H4224lMtE1P5svO3+FA4wtdbSZxYgw112TK+R4fB5Dgi5Zz5qqBCCFYghAIM0hpYE1xlPHpQREUC+8aQmVy6ON7CpEZrHqGIZPWzbCRdABycgmvwJZl2vSfGkcSMikB3OMPhdacHHxPW28tlb6hfqiZSgKZRST3ai1wx1yicuAG5ouKe2fF0esE/WlzECNwMZw2nx7fTzH75MhVq/t/UDKZw8q/Ih09WNCsaGMS+n2aqa1wI2KFQfUtIBVs/Rydbf+f/tqQn1lU8ZvsfP0DFIcVrIN/uvPJiB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=whyC7xttDUkThIjz14Iz/70gFvZ+Nyj33qaTggrpfR5A5DH7glMTGsiZ2h/7A68Ncv/NYIFgkbHe4pPKqXFvwieSW39dvPAXbG7wBfz/32Ezvmgl8sD8lSVi0attJcNqgkyR404JUFCYR4Te2KkJ0nrJXAxmUUxDkEcrh6Q6/VfBGk9vR08YSR97k/WaKQNg29b+6LTuEMioC7TS+A9KJ07uhpcQKRIW9LQxi/37CX42DTpnbL2oZ6zk7e3XK1FHaUZP59H9ukySGZdM31EbFSdsKXuPCJCuzsOF5VDUO0BfyhIA5dsE2x+Y0/rmjLFKQHLvGNYrN+JmHx3bv+NLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=Bs+FZvn8Jpjkcqhp590gOyrdWb+syADRAkk9HLuZBslZaJ3CdoNUF+Y1llRLnxiy/54yzRTX8XImZHYckhmhV77luKHDj2HsG/SA0e/QKAosrX+uT9fQZu7eNBypTkjgwzO5RSQpKzKUvbVfseRkL/0fxmymgkf34voIfrSju4pUBnKEGc6EWmltyjL1sFN2pCopQqZEg93LmxWV0CDS2ikLIjKkmM1pPfISOBA7nPn9zt6Per8M3646aOudsmTVlTlXVHJjJdG7qLEOhKMqlQDNtADTvt/6Y6AOM8biWntY58cey5xbYQWvwhmF5RzmJh/p2sSr0jvV3iGYyWw8cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB9661.eurprd04.prod.outlook.com
 (2603:10a6:102:273::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:23:53 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:23:53 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 01/11] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Mon,  9 Feb 2026 16:24:44 +0800
Message-Id: <20260209082454.2097628-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: fdad20b4-663e-4723-4a78-08de67b48f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7TgErVk1QMjmgrD5SFt4rxaWpIixYHNHPePc4x1RNco8Nue6OgVZnXN6mIJx?=
 =?us-ascii?Q?vsHofvE4l9xnDwiTv9hREtVs1DQ+3FhWjNYQl7Eu9S7FZ3GJ343KUcgBiTPa?=
 =?us-ascii?Q?Hv6UG7mKV7jFnsjXzAm3zerSjmPo/UCSPkoClqd50pjnWkV/H+h88ToCnBF5?=
 =?us-ascii?Q?X8qKqfMHro3VxtGkunqN1UB4E48IfK3DM1E2wuhITkKqM2UnEcN379OZJXWQ?=
 =?us-ascii?Q?eKfvlFcm1vRq6OhEHficjlC7MpdhN2tLOfTKX0NF+DPLPf913r37mLjQ0cCm?=
 =?us-ascii?Q?w2CkX4bagc6w94cEgllWD9DBfB2MQw//XIww7kBetQ1hj599laaze5t00Mnl?=
 =?us-ascii?Q?j4jABasxYU7qSxmtwcinLbNhyeuD7TsH28o95+1U8gEpSmLW4xFR5X4NnLJU?=
 =?us-ascii?Q?7kt7jdbVdHhOi9afWhnLT78QhavN0m3BLkq1ePFJ59+mV7BKScWDGqrI97P5?=
 =?us-ascii?Q?qLI6UZJdO4wYQVtH2BsMmpxKTtft+tyrMPsIqo8ReLra/SFgJoSy6/rjTBox?=
 =?us-ascii?Q?cFb0k1NYkbHNkSZZOa1P+XhI7OadsAdUklCXVXJHFm/qwb2ZwZZizuh8oYSI?=
 =?us-ascii?Q?eNKPndpSaJ05kWAhsozhs/zl/aej/jwu2xBQoFe+AHd4WFrYkIFj9mazuY6n?=
 =?us-ascii?Q?bZ+BKq0BKemfhiHhHrQ/ahtTVrBuH5qlAgInBp4jxalOUDH3zugGCwg1R1KH?=
 =?us-ascii?Q?XnLVl5Fpjdbh64cGUq7I94sotjtQ/3FW70S8k8+P5SGR9n1V9fw0qqq4gWTp?=
 =?us-ascii?Q?HiPxbiXQogMmWSwaqEOFIDT7sTtzF8D/4zQ8w5Kr3VDB0mVQS2H/wTj0hUKN?=
 =?us-ascii?Q?XGgEatKUuQbaHevxZn1jm3FA/v4Tdb9RcStdafRgd2xBJGTbn/BdDehNyKZc?=
 =?us-ascii?Q?8G4vyEQEdfVC6eIR4mafoSDeVzdQIEFcm8uZdLC5f/C49aO7fVogNmfj4Hm+?=
 =?us-ascii?Q?a1CixOzMx4luOI2+yvzOZpskRVaQyBrXGIcq9yaX7Fz3K1nOTzpPJXhi6VHh?=
 =?us-ascii?Q?wzNcBWY98VHs0gIdPcEDmSnVnr3OPusxWEyn5F/BrjIctuxz15RoZDrvOI4W?=
 =?us-ascii?Q?RzIQPSICe2xEx/pZwRyelnUBycrw88TU7pWgHgZPMeF5c97HG6o1Mkab0OVr?=
 =?us-ascii?Q?AwsaRlS5JJiTQu9J955WlDbQ6t+aSY0Yy6Ks94xbVGa0P849bLOtllK9jqwB?=
 =?us-ascii?Q?zSGHJbnexx80J4iosR3UbvbgkpzLrtqEB6+jL+vEbiT3gq8soWDvQbqbcYpt?=
 =?us-ascii?Q?1+CDaJ47WLIxwJB8PDI+uNAp3E6gBoiy8osev2280MjQ04lZyAJxQAQ3zA01?=
 =?us-ascii?Q?bs3s+46bmT6c2GYRln4HHryhBKiGTZHfTOq4LLD34fxrHB2o2FdpGi58917j?=
 =?us-ascii?Q?5ft0TpxI7AtwiwcgtgXNqb6pNOAPN1LMQQ4v1STZpE4Gt9BP5Ird1PYuqt9s?=
 =?us-ascii?Q?a4rCpyZNqfC5QNKU183dSwwIXa/m68Yx0ZV3QRutYvTTlPghceuqCsTF1V4l?=
 =?us-ascii?Q?Av9RDEuuUhVW4uOWIOvacGoIm2UuHE7gS2ikDIfH0sw0HJVUPlL67tdj0i2o?=
 =?us-ascii?Q?6PHvOGTW9ocZc/xhkqeBijfX+g26Z5zTb84Fj5AWwjCZWHOeCreFVOIoh49a?=
 =?us-ascii?Q?0dkr5PCUssZ4A1ZFVvgz9h/Ot7lDHQ751bhkap0seXJf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f2Fd7uquHhmNqn9S3sWXXsanMNhb6y7mgIgyktRA730nWBrDYz9Z4cGRwQ62?=
 =?us-ascii?Q?RZM0Z5lB/nqaLFIVGmaQVJKA4ofIW7+Qo8nM9pKsgOO8NRaRUvIo6hPY3znm?=
 =?us-ascii?Q?ycQSDBirGS3feZKNIDlEwHRZXTwwWAGTakLiSwkJxN4D2tiyRh0LEWVUn4vM?=
 =?us-ascii?Q?sQnB0M4AWIU5wl6E2nQJ3ezCGPw0y2uxp9RD3aX64QKp9Gk2n3xB7gl38fxq?=
 =?us-ascii?Q?a6fg190zNj+ufUPYZVAmt2+6hT8fRdWrEYObDovU9Lp0ChsHBK891sByRhos?=
 =?us-ascii?Q?m1tPLyqIumo9Qo5DFLHr21uWwm2k4PbGDPU/Xc/0uB2RAZ7CMFKaQmHZIvAm?=
 =?us-ascii?Q?+PAdGd9OJnd0WsqOwU1y7QxanDaniDvvECKnmThpRMfCgKoLKogk/xJKMUIM?=
 =?us-ascii?Q?/9y90G3k2Eg2socF7tuMo8IILUUBv77dhY++HqGLS56mTZQVw02mUrxuCpT3?=
 =?us-ascii?Q?CVzJ9gAQtqPqjEj3NgqGJiM4qvUBonzDv/LnAhivAfPRZD5WTeBI/VQ/HXJp?=
 =?us-ascii?Q?Uw/quwrFlrvxzt/Psh4BPQE8rezWYWgG8AKOj0obg3qg51bslPGrLxbaof5J?=
 =?us-ascii?Q?jZhJaosXmfz+ajdoh4U+jITo8tTaHCq4Pj6YEgtWG4g5WM03ag1F3QJuWs/j?=
 =?us-ascii?Q?T3GTik8H+k6pW4KgHv84Dlam4dp8waWXxBa4YfrKzMHuFYCM+9KuVBFbyesa?=
 =?us-ascii?Q?Uk6Mj6yOldR7hg7f/JaL/jq6MYBcvPk2qdcxAnQC3E6uUWVn1EooEyl7841C?=
 =?us-ascii?Q?dMSbnVTp2kzuTPxW1opTyuajJ5OZFneP84CvBe0BB4DSeChMoE0rXRCqoWk3?=
 =?us-ascii?Q?0LltJA3OZsrXHaDXOjUEG+2xR6AYG464dpz0W79mZmzig9MxYjF/0xu1AAkE?=
 =?us-ascii?Q?OpoKIFPanSTY4y1C98CpYx3k9YSQJt4xWVyWYDorNuR1YFhgdCa76SjGlio+?=
 =?us-ascii?Q?OC7Jx2q2/ERNyu5LP5SHXUE+FGyDxMZgJR2thROg97RkvxoZWV7sW4N0UvYx?=
 =?us-ascii?Q?Qoe7DgTCR0BQcQ+lCOlqsfF51De9q6Gc8Di9yzisPfSvb5ZtmXidm0U1f6KF?=
 =?us-ascii?Q?z3WHHsGO4H+bCK7OQLj5S4qUzZgGRjBkDl6gtnViZejB2j6sE7smB54wJUw/?=
 =?us-ascii?Q?ygxqiDUOKRyXJraQ2YZSGk/w2T+HcQMir2x3u22fTI51WintjOAVEcdyxI61?=
 =?us-ascii?Q?RxErm1G6xj2JenaWpkWaX5/Ptvl9NT80tQ+o9hB+igJqW1L0hum+iuVgGLs5?=
 =?us-ascii?Q?o0HYhG4KPjubmZY7N4y6uvr7clU+a4fDezFbC8nCOspXHhXrHypjYjUsYvFU?=
 =?us-ascii?Q?uFwJAPssozBLKjdNTQuL9esATBrKf8j9iw/76/yC2FWU/fOhGpf/2Z2mhGpK?=
 =?us-ascii?Q?x58E+9xDmJ6IiGzCdAQ/9ki4DA+b8SyY+dqRRmA3aNxBZm1J8K6Z4XSZNsk/?=
 =?us-ascii?Q?kPWbjpaEQ2Pp+SmA66GqOGzpkTI1T7vHb/dl+pV/tm546oKaSHU9AcymIKbE?=
 =?us-ascii?Q?kuymKpUqcT2tbiPu/dkvqmvIuFaZgsJ+9BXwYylI8bbaUUpdA6s3fz6zp/WM?=
 =?us-ascii?Q?vf5puSOKhol+lmhg4VbgmPqugM02v+bIX2tQPG0A1xnVCAWhWwwGnjR25nn6?=
 =?us-ascii?Q?ulohftDD/zoTrc1oy0+J8rtt05rhaVSwh2P5kVn3ae0x3JOGrhzbLVPwnsIr?=
 =?us-ascii?Q?+WM4XogSZqFJ/2iUnCqrUD6dcS0h79MRNQkffjwXx7sW/FclN6wU1lFWT9Sv?=
 =?us-ascii?Q?RGk4nVH+QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad20b4-663e-4723-4a78-08de67b48f26
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:23:52.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEphgv49XbygF5ZOm6wyAR1aKuhaSKju3gYSj64YlG6q/GJGHKR5vVXtjxIyLzWBoDoWilOIvFa+AFihK2gMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

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

