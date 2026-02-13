Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6A2222C5;
	Fri, 13 Feb 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955671; cv=fail; b=MvD22tXA0t5Jd+kRTQ65F/BaO4jB1LErFi+0K3/h33k9qPHvhmoamP39VVuFqk0oR6ygbC054v4MfOuExeoTqvvVSAiYTU3bmfw3W3QRhNMvvQphYrLfGi2Rbu8WPROP/au9NRiTnJcPYQm5vpHE/TSkdDEWxetrU7PKJ7A6lv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955671; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jichbFYIqKdkI4ZdsnLJIIQQindPOPJ5MEi2CFUSrNQOLENZZ8hhByFmqmhgUhuB5iqQqjLOtjI2JHSG+fYLWa6sCXDMIU8/mwdgyS7m40+OKxgLvwP0sKy1GqWA0DMP9urQuVxOoQ+4gUrGKvBKGiyRL/hH5+Akn0Hj6S6U1UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lR892/iI; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lR892/iI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZJOg+JB5y5n9asUYK/MJ2FRz4EQMMqx6RwSanptQ1EXQsPLd768KdrkEN8OuFWddBCXaNiYzG6005kntQtRGs+XmlFUcCifUJeCCRIoBVUNz6fXcXnT4DmHrovfi6iGxioLFUMVOJ39Syu72GJhYB4HIKvvFZMRKrCUgQNFSI9ANHZkeOJlqn+b5WDnObu17NYeaaI5U3RN8FY1VJEGxfsXnxYk55ffHFUg0Wk3EmfYnVX7nNQfwQdj+U+lZi3EPxENhg3hyqdb17Psv3yLmEzel7uMnAZnIYvGSPpTTpb5l5R7Dhld7/XTSqJbQWsPn5dLu/0s53MFDr/Klfzfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=DP8YqSApqrefnGr3z8rlKP48Ua2j1bYlt6tLinmXzXSIsDFCHozrCNoVfxQNbhTvGmkK7YnvdPspB1knd9oaUnMUq2swC4dU+H/B0hRBb/xBd4QmlKS8gXYu0CYK4nFvLg+7/GuhEcSIW/sAb6RtscdiP8jTSXEk3g7L1JvGjX0T5KVQe8fUBNoUJFq6yYy4kdBvbDFIHpRWT1wVps81sKrbPkTiwBbt76rgpnEC5g/xZ5tuL3oNo//QnpRCB0rWxSVkmhBV3jurvvwB94tZmJj0qgw/hyRyf5+k8VSRrzO9zRKtAZF2ZP2Nr+mvG2SEuvajXbTwJ1Qr4rvwBF9R0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=lR892/iI7jmpUDtwwDra6Cfk23MfuBKRn7kuKDH4rHIxSzzU3GYGFfNSoHb0VQJCDGbMCKb1MOqGV8TlERFbI4ZxZGxqvJwhrNnH7e/Ao906HzcDdU/OpWsLzArPZYwNpSiNYWc4RzItDB6aUS3461QbXHghXfV1TdaAyYWfnPwzCT0eDx8fSJvP0hQo1vVzuoBNBrYkgkLuNeYJkVXXQ7o62GbPjKPhKJA/R9inZZWSzG8lwG8U9nafLkBlhlKaWLotw0NL0aHFNvEIynoEp82P2bjJuOi6mEMXccvuPFvcLcegMIECWUFBkjAiVaQ/no2GbXt6bPDk0cFTJXhSzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:07:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:07:47 +0000
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
Subject: [PATCH V5 01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Fri, 13 Feb 2026 12:08:41 +0800
Message-Id: <20260213040852.3340547-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9435d1f1-1e91-4014-6f59-08de6ab5727f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9syZ/kstYzKUGZkaiw0PMYPC5vx4pYm4oKAJuysN6a7OTf91nSmbBuiifQtd?=
 =?us-ascii?Q?XGRR7Vius7YvFAcKG7LFmhJDVstFvP4lFclNLDM6XPGBYnTQEDs9XUfO33wJ?=
 =?us-ascii?Q?fRXMrrYryUQY4ScrYDwcwPa41NKGc+6KPeiMl+Q4jp+8dbqAA8Vy4ccfSdw0?=
 =?us-ascii?Q?DEKqHsBRzX7hs3skqz19NxHfCt5ENRF/HCMXg3fbMYYmdlDaHgDec3t3uLS/?=
 =?us-ascii?Q?jxua9Pj/IzBZDwmbyTCIWjgfSK7wmCroZ+rEUCBvUHggRmj2KlRwzijha8ot?=
 =?us-ascii?Q?+L6Y0hEhV0Lu04RsW3brIkKRn3aDd8treD7NbJUGsEZ0yBeUSYSI68maAU0y?=
 =?us-ascii?Q?dYhppayOY7AKrMVS6/b/fDdJt1o/RHxs1LUCGiwJTBgiphd9zIlCFacjn1e3?=
 =?us-ascii?Q?2HBZ9+M1qVof0I6DIk+UvdwVpy3ML/i1bqO8LnJP9IkBSyJT+D7J2yID4S/H?=
 =?us-ascii?Q?/BiMwxh6ySTPNNerjyjbpu4+0ziWU80td/HqdLcu/FzRa5NyG6xag5AkxDhT?=
 =?us-ascii?Q?HnnDxY6IFIsWoOfXD0rs5r1oYto1Ka9aV2o9G7YVPOGCibILTICDnW2Vj3E2?=
 =?us-ascii?Q?N+wIby8bQVUG/CVUyEQvASQZHbe8owSi755V9k8Dl6CrzvWrpuR4HxCxE3YL?=
 =?us-ascii?Q?LsX20DEa3OsE7FAAvetlwFe44o2P2KWvFPJHqvXjk2Ai84fHyhdjOWIgs9Yq?=
 =?us-ascii?Q?ZpshFb4L15B9SmxvThPgiqZ6KMIBJSEk8f2kGwUl/XOyFxsbWHO06xK55cDO?=
 =?us-ascii?Q?NS4FfZMtzea6rzO3QL1WKYWX3pVXk0gDUgCgRglr+ol0P5AJ9saG2QppyNIw?=
 =?us-ascii?Q?hutFMJ5CMWtpiVklvYMsjtfkpzsI1lJ4HKoKhAsKjtZ7/3STo4csFlO6CRGP?=
 =?us-ascii?Q?WoS2ZcSMtJpslVEvGJk2qqAQ9eIG5HTU69Qk9fmpaYmZ9zpqI20LKsbStBwN?=
 =?us-ascii?Q?SZuNo2gz5oBLtecaPmLnUE9HYKoJaywuTC7BwdsUs6BedzTNCANedGn6Wer7?=
 =?us-ascii?Q?8GyH2BiM2Pr3hP/iFzd5t8vsPXUIwlScok7JsT3YgfupcMqHmVvsVjfpb06x?=
 =?us-ascii?Q?MZtn5yWnH5Yy+SckXT9KccqSjkUhUNVJTo6Uy36Am/iRJeHlzwePcvE3Q7Zt?=
 =?us-ascii?Q?BJuySTMrNlzFm9hHKdJsTvMsvEaZnO2+zUpvj6ngTSCZqKPKN7MFTP/JU6oe?=
 =?us-ascii?Q?W6CzEOIVc+qWyuRdjmoSN2Cq1uNbKdNSezawmjw2NK+z1eameG7znKEsKtUr?=
 =?us-ascii?Q?Lmo13dm7Df43zvXqE4Cj2SP9i+XwvDBjwOxegr9cMYwo+DDBI+Jt/qL/gz+k?=
 =?us-ascii?Q?Juzi1QMslXLCcmeo6u9WSGGgxpg/ukZhnfz1AF/LbGDopMpETUI2FkLpwP3m?=
 =?us-ascii?Q?YQfHhnToB5ZjfSA/ZxoMmAr+eCvxo1RpkImAGU8RT61UIlq1TH56mUHrp8ij?=
 =?us-ascii?Q?+NAWYG0jIskewZtKVXJNLHi9/LgFd1dAbhh1KziY4a+I3/L9/e1cWN0EMuBl?=
 =?us-ascii?Q?b9kAQjQHl3yqHw+InApU7LmA69EtZ9f53vz/QqDRen7lOvGuBxO9btCAOcGP?=
 =?us-ascii?Q?qBM3Qx2aSQmsLxDhS2OdfbrRf8yH1qy7kGEc+NG7xH9MddrkaUVM7NlYFeEo?=
 =?us-ascii?Q?z2cHk11PVtjp526DWuN6zykdDGk0JbGwCHfBn+AnpRPB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0QjTyyDbClKkCdheGFmxSCHgAUrFz2CxaOJ8YOhWUj35nKFjmU5Wax+l/pW?=
 =?us-ascii?Q?Tqsdbjdo2fWhO2SyNuXWjEJcFl6OTWFjac5UkGdFDkUUB8nzhnpn10/Gom9c?=
 =?us-ascii?Q?Pd30eOQJD1n3mDw0WLSDmTxLFEYgsX3oLI+8MjKRx1Idra+PfkeHX3Fvbznu?=
 =?us-ascii?Q?m9/8U/KIbwwAQy/QvkIGv+rBDJMWB5sjXn2ksG2ZbIk5oJcyAcN3JMMgDkVw?=
 =?us-ascii?Q?rC7nlmyha0i4XT3u7xugGJbvg8B6Pcb6HQJImuMxJRpSPNeONqpgOhI4ab1b?=
 =?us-ascii?Q?MEt+QvgjFx3114MVrq3bDlPvjvqvsgAMr6XHeQlmg0qXcdcTTwn66ktXJpL0?=
 =?us-ascii?Q?2wOKVDH4s1XO65VqNyIx31/nIrjPDNuRL0EQBRiK+jby7oN0bYwQkp5VTEWF?=
 =?us-ascii?Q?2ouLa3TuSbDsEsy4suQ5CFVWc5FDX13ViysZmTZ3QnKQdm/A41n4QFdbNUdk?=
 =?us-ascii?Q?+BM++n2yOwDVkT/bh6snEIN59WQXcGRXpNNKntdvyHXw3YtmF6wQy4rQ/8uH?=
 =?us-ascii?Q?kGD0pLJIbhnJuuf1+5D+Z9dgCO0+Kzb4/gzUjHIVlJJfb/ka/qOmBARj6siG?=
 =?us-ascii?Q?pxLlYzWmst8XVS4KAAsRDdAccYhkT1Mq46RN/zKGm2OltDfUhY7vJYZ7puye?=
 =?us-ascii?Q?FO55vZVokU/a56rZE+5KrjRQAeUidv9DZdNthCsU7FIGG7bfQSYVoHU0dVUS?=
 =?us-ascii?Q?1fJ/NwH52PfwQGFpIwm3Ijop+zlUZ7Ci4qrlWe/Nho3y9/DUo8Ol2R9s+VO4?=
 =?us-ascii?Q?5MvQ5c5Ja5zRR9VAqSwyO53QN+rLkw2s3BRfNCTEuUyyuI8Fk0ywBM9FoQwh?=
 =?us-ascii?Q?W68oo/pVk4tk3hjjWAxu79bBW0D7vHNH6oorjO17IvCvYJK0FlJFVKyoMJS+?=
 =?us-ascii?Q?4dEHy9XBrS1TjvvlbrVq4dGRyfJFp0Xc/JJXS4eKSgmTrhPUHxxZDfao8h67?=
 =?us-ascii?Q?3fXnEWKU+gJYSJmGVddwSbFW1UqRl8kjb2QNq4pQyVqopLuK8IhFNSzBXciu?=
 =?us-ascii?Q?ub83qTP8+tZFpN3IUaFFIjKhy4RGB0tTlAfdgDiYzYC+QWZXNsU0w4gXxAbw?=
 =?us-ascii?Q?ha06HsYxRdKjQv4XSxAsd/S8nDemoCkzdWuwF4yQNvLt5003Kj3PyXOp8zLZ?=
 =?us-ascii?Q?bGerSktimnBpTJlyNpkji7GrsqgMVGIzYR4YJsjNDo0RpOBsro3qfA4JOJHT?=
 =?us-ascii?Q?rN+xoKpi3n5z9jdFhI8jjRWE8nUdKJKeJdIAGvZ+mOfEb3pq7hpwexODyczI?=
 =?us-ascii?Q?x7d6jnVwW+PEJPQzcmY5n0X+Vew65VFbgAA9GPmHgNrsH3H7vFMfK2GKaMYH?=
 =?us-ascii?Q?cOgd448X6wTbCENvhSPdwthTn1CJJ7y3kmD0Jf+thnZmtyh0pFbNtnFlohWU?=
 =?us-ascii?Q?4Ij3M9JqVWAHAbBz5V3dDXnBMXmvlD031jTcHNTePA51afebxekmtMaYv3zT?=
 =?us-ascii?Q?j/upPuMPjRIPHzEFE6iZITkczFR6R6uM+gpeV2l9FHY9VOfglC5KD/TK5KTB?=
 =?us-ascii?Q?C99Zm2nLdHp/3/8gvkoKIeURarHzoshR7fvSnYmaV4rtKJeupUJHSPvQecnY?=
 =?us-ascii?Q?sLGyU9eFCYwqdkFheJD9sBT66GvXCwEypQ6+7QlRnaa7JEdKKYZyJyBztItU?=
 =?us-ascii?Q?Rl4VffBa3knCLy6ZfRlR8mPfPxSMU1MZkJIWM3uCyORTJjL+oAaGu/q9QbY3?=
 =?us-ascii?Q?aO5C7SV9qkQZGmtw3umNeMVfeo5Dkb1LgCDAmRdScf1wFT2sLVQO3rJFYIlz?=
 =?us-ascii?Q?hJ6IetPNiw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9435d1f1-1e91-4014-6f59-08de6ab5727f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:07:47.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWYwlAZKkYQnxC521hUi71l3m8nkRqsUkgUf/JkgOjugEw6EIx1RCi1zegpE3azhgaTxdWJzpbcrw2iqMt0HTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

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

