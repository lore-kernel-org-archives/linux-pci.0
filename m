Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465866;
	b=iZD6yRhBIF78nJA8xzQJfgaZ2G3K31bTSkKvjC724QevWa+E5irpUn6gw+/PlLFz9ToA
	 0RzsdqkOcX0dLATfQTa68PpzRgNlPF+JL6CQ+uTLIJSYvibtJQVDUXu9BH74CiDD9DG/4
	 /gtIZa3G8fvEh0KeW7ja55QAO6WohC5zSnVpJLejkUiUO04+/mVyantg9XwZInoDwHdtB
	 OrpDZ2E7fEm11Ebwzl8OOcdEvqGKujmVO5m2DMXrp8OzCR0Q1qXCojGP+l0hDnhsjJA8x
	 GRz1JcX5O8sgZdwGGzKe8QDhj0jGnEfSvyEAz6c8e+hmli6XGbP7iL/4LWypUSOjz0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mAT5vZlQQC4jVS5AAELZYt4e7YcGVCDhYFtx6yfIdK4=;
	b=k1M+bHTDr53w9sICLwJYXTcpTQkXRyD4ks0XCHT1x+1HCyXFyFl2GenvbvtKhFsg+Iqj
	 tNc+zhjB68sityoYz1DtcQD+BrKTC2UgHAzLTZNpKV35KQksiiT1u9HdwHZ+D/mHQQBYb
	 XMGNXGEXJ2AWSjiFXGwE3hOkG4JGYKk95sJrPzqZ0u88IuLlVglwcSArPGtwYKZYly8md
	 6LpJTfXmBbArDmGh7sr7258TxQp3eZ9y2nyPjScf4xE42/v69l0pQoe76EPdsfxZzz9fG
	 v0fyzG1XTViZzYBr0lr133PYtz6IFWNaFifUNb0EZc7r87ZPOBfOSxru849J1ano0Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=bayC8GUR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EE606AF5D;
	Tue, 20 Oct 2026 03:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939EE606AF5D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=bayC8GUR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZfdJVQFsyk3dq/Pb9iJGMSTJ918I3wHv1rBFZxOUx+oJjSyBryb4XpVBe1Rb2Bwf1XDNlKkehkRtytY175G5K2DNv2xZvgAm5C80nlrcoVpeDIzMts4NNlCQ9AFfrQnuWYa1RbPnz8qiijD+1Mz02l2mRNGiPxnEcjqkAudlzXK+PzMbEw/wxyF4HHPSchD+h70KTRAjZCi/yixEmPzdPhTXR4fYb8y3LYdfwFcy5w1jd6WFIryb2TQaLx1OM+dU7TDXhFrypwcOEsjCmc+4M8+f+VY8/SlC4IjzqGaaV1N++/Yvk18BYOmtJ166gJrt2tsyOWzA6juAyIo04bxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAT5vZlQQC4jVS5AAELZYt4e7YcGVCDhYFtx6yfIdK4=;
 b=L1JZTQ7oD5z7mYXbbjkGgCgbgQqn304uM7k6sHjioqdXOJcELQVVajgkhNATI6UeKOGe+eSyLNyJ9C5lD/zfTSeJX3CW2u0cDBG9OWLrwGqhI6ICpR+7rMSPsyJGt7LcATjrPfMbpAVj1B1Lushz31wJJM15fTKEmA1CLzRMPqDDzrRvMrJ6UAusQ86BgvGSuIv9/nV0VCOevufvyX46/DnWUCTLcuIyjiqFez02HjgsjbXcLjjks1wMFg+ngYxsZvAthHOF8/9Wikwd5uSfa1nic+U2H0jULkc4vIs6/T1KcaE9eP1c23qFMIUaDsg9A15IBz9LROwnMxEc+p8hvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAT5vZlQQC4jVS5AAELZYt4e7YcGVCDhYFtx6yfIdK4=;
 b=bayC8GURD4nmg62Ioj2Kf+d5RIUaK9ZORjwSDOqpztM1zSMp3BcvHDAFb0gYOwgRXuXPVPHSxXIlb0yX9ECknc/B8uKCEfPSkNzdVo3XAedBgn8ae6tasDTVzcBHAF+U9nrUUYXbTmBbrCo22M85ArSzhQ8N33PEDIlKS3+ipT0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/17] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car Gen4 SoCs
Date: Tue, 20 Oct 2026 12:10:36 +0900
Message-ID: <20261020031049.969895-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6582044e-034d-4103-adcb-08df2e57c54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rNgy1m+uVWZuBEVEYphgzOAVMFCqqreQkQrZdWqYe7iUFgCZ0PEAD4OQgHkyBblHBW6ddpSXbjRewOiQy/AoM6nv0z72XxQDUTQOYZrVURMqNmYuSq+btoMndsCqNoSvfiKoamR9+ENO9ey+O//w1LHKGiPg3PMw6Ppjo9bMckCGOOZ4xl4fEkcukewlJiFJ1wDcsIxJHCvKuFlo996hnvqdCOjU+A0Up70hk+DiZ4ev3ZQBvvRqEnf6hvMkyj/jr6oCCOQEXIxRj6EaAW7XRSOfiJg7V7uJdyugn27sN8biTvZa5gTCe/0FHlcZVuhawtJ+gV/nsB3NNa9M526RVCnbo+iJ7rtsLcpsjWG/rz3cD0TkvY/36A0lEJxnXfGWU443TQomn+DrXaE7nVKU7hqidZoF+G7hrLljAwNKn0yyjhnKo7lm7NxAAzMh620i/J2+ze9eZI4VvSNJ6aeuPIwKd12C8VZp+JYmYAG4N1a0z/Lo56BYy6WVNjPxuuFuk6yQugB9SevALYjuQbjJ0cOG5RvCkr0LbFSvH6NHU/RzePsfgVFbPk7Krnms5dnFyO8GnOF0fuB55Ls3l4xCxDNGWk0+kHghkuZngAieO2k/TT6iGWxYvQB/iRnF4GpwnsQ3qrzbN0vxt8ru8H+Nsy58uZXOZ/gcsePw69g1VT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPk35GfNKa9k+PNusAvOA7x/GfNQE01T6nRRdrLWyZ7mkKj7xNGpi2Ytj7qa?=
 =?us-ascii?Q?aBJfpAvrlUh3dGBuJ2miCBk1gWF1O1bBXi0RwnnEbyyUSLfEqjHJDCL721/b?=
 =?us-ascii?Q?3VR2Mni1j/qWuim5vBvTMuTc4MWtb7Ngs4z2MB7+ohRF1b1stfqOo1GXp3MU?=
 =?us-ascii?Q?SypN21CW24nMHH59d1gzslGauUp9F5BSG7oIqHrNzenSeR1YQKnLGTEUiCGy?=
 =?us-ascii?Q?OaQV0iW80Be+32AEdaImWPc5Y34nZAx7QfUAoYw4RuwrNwKOgB02QjTRRFig?=
 =?us-ascii?Q?Sojj3kqRHWe1abggWLtQmR4uZMWzqSUuS/Hl9xDko9b9ESVp2hScCItTTzgZ?=
 =?us-ascii?Q?1PYTmyHyl5n/Cqy6PYmiowa79VhTXI6GHWfYOflRNiSq2rXN9eMK4KJOjcne?=
 =?us-ascii?Q?bnQoX8U4515qEffYpjkgREKHhJwljvCwVCNvqDADSozfc+tQn8rck6L5hgvz?=
 =?us-ascii?Q?xPz/yEIt4xrv+VQvDvKYHuaxP1Ulg/iIkYKGF1UT9DkObGb+tATvmdUHwSiV?=
 =?us-ascii?Q?5N9pzNefjnYovAjHq7f32pNONDvp7LbMTQRRMH0bgkyaTZt6SA3vSaP34q1T?=
 =?us-ascii?Q?Bt+ozp7w17//GiWt8pIcQzDTtJ00v65CuWII1ZNgLrLNzb7SeC17sbM0QUyl?=
 =?us-ascii?Q?usPu4kjQ4LOxZMsv0vM29AvFl0NXtkOnNenGsotAy2B8SuUahAe43bGYWPQP?=
 =?us-ascii?Q?c8ibGLMBlis8EkMFle+uR6jfgh99yJq2Cce3+etzVzvcB9TFvyvAEs1AoKnp?=
 =?us-ascii?Q?WDInoAMo46yGJux4sZzxfS4dP0+eQubhkTwmIyNOG1TYJQsIwEQfJoVpaCUa?=
 =?us-ascii?Q?5tOEi5QVOQFY7/M0TVKJoyMxMvXf2Z7UZMaBUHylGNrxWgqKF0SW0keAmpkk?=
 =?us-ascii?Q?Os9eNqHD8FzLm8dQS/1IBV4/0IWX98fO4zKDTtfmXYCGgXBQUyIiOX0xyLyP?=
 =?us-ascii?Q?9/24B1kCO67z66kItW9xacyoLEHyl2gcyCYXZI6mR0VZWkLCsAb2/v5Cg2Ey?=
 =?us-ascii?Q?2fZIX1UsOvGoOxsz1OlPXC+1RrsKDASJnCIiTyjCc39BDH6fRJHSeqIpdFZk?=
 =?us-ascii?Q?uE4vvH42t+7GnE+O4l4GxlOwJCF9eJvm2KVlS1HOSARw9d0l1IoBut28d1TN?=
 =?us-ascii?Q?KZcwVnce8LNjNE96OCSJ0YoMtyBOCJbxaLJ4xQClCdt2nj9AM7v6AA74mzqi?=
 =?us-ascii?Q?hXgN4/3WF8QbdN5U3o22n1zZVaPGS4JdO+Z9ZZi2TI/Z9e2e3FdeTIIz/dEO?=
 =?us-ascii?Q?4AnVtZt47SI3+gWhTUyOcdNAnSkMzOJmB0DKZTe5a+jn4gD0N+zX9wOO60RS?=
 =?us-ascii?Q?PWo2U1hcuVaZ5960F9Nj+xk3bBotQxGKSYpbxNEoW5/LNmsHU8heEW83pusr?=
 =?us-ascii?Q?aM766JOJ50QbsV81NxbEYCBrDxMS17q3qF3C95hAbIUBR6eJwPEauDcJ8HJw?=
 =?us-ascii?Q?ozT0E+KUx6Hynd/RhzXIbpXXH4lQw/BUKBEClH9oTctosQg54cIPgA/Lu0Oy?=
 =?us-ascii?Q?l174ZMTaLn2uATPQ1tmR9RrSL6cN4VsQSVTEjKDgE+/Ctfb4x3gCYtXhYNat?=
 =?us-ascii?Q?k9CEj7QcG48O8WBRM3EyTwara4gSYgUqHLvJLGFArUMAc7/UapvYxSV9jpMR?=
 =?us-ascii?Q?kzsQC1hZOQP/nTtXsKE6D06rJWTBm7ryamlsn7SLz1f+jKfegAqj3mNDiiwE?=
 =?us-ascii?Q?betu+HA8RVfIk3BaSNI3x3BP7PIFR4Ik8IcmHV2xEFLwRA0CApoF05BSpkrC?=
 =?us-ascii?Q?mCSYuGEAcMm3QXO1vUtSCGG21QvbUaN36w1J+cbiZDtov8F1UDAI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6582044e-034d-4103-adcb-08df2e57c54c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:01.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zfncC0E214n5mYaJiRkUbKPNDBhs3D6ZCLKqjCC6+m/+BDn9Ne4Z5UGmorIku49ZFlugAlIgCbXjYF+5OhtFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
trees remain valid. Extend the example accordingly.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Rob's Reviewed-by tag. No code changes.

v4: https://lore.kernel.org/r/20261015033103.3076869-5-den@valinux.co.jp/

 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 083b77d4de8f..a86c06701fa9 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -26,7 +26,8 @@ properties:
           - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   clocks:
     maxItems: 2
@@ -93,11 +94,13 @@ allOf:
             - const: config
 
         interrupt-names:
+          minItems: 4
           items:
             - const: msi
             - const: dma
             - const: sft_ce
             - const: app
+            - const: aer
   - if:
       properties:
         compatible:
@@ -117,6 +120,9 @@ allOf:
             - const: app
             - const: config
 
+        interrupts:
+          maxItems: 4
+
         interrupt-names:
           items:
             - const: msi
@@ -146,8 +152,9 @@ examples:
             interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi", "dma", "sft_ce", "app";
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.54.0

