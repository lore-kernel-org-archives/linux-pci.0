Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021114.outbound.protection.outlook.com [40.107.39.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672D3AD506;
	Sun,  2 Aug 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670374; cv=fail; b=Tt04abYzcDB9ZsL3k+xy1VRvYTdcwdjJ9nxhnZQBOQgjRI3lz044lOxb/UU5UAQiqkNOW/GbE/DTeSRNaPXJnS9LgnI85CUjWw+6QIpeW/almZDd62qdCeo5xG3JhEMvmon2rCyqUjbh0/H7HKr8OQA6WuIIVAFOq38R0khTG2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670374; c=relaxed/simple;
	bh=tBspO9EuN6M8rJ/y5oOUXbN4kiOWPzcPNrmWFG12uWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3I+ZUA93hb+0F/MgkKxXZ6005tdiMpZF9eyWsfIWdwAkWdVaYY47RyoIc3saS8tGd0n189U+sTmP743RumIs1/F6nqd2RN6xnYiLTgUWAqkPBYmB1yq62gDG8U+6jTnLsn7uMcnuOpmkfIJPRXCmz3RI3pap3Ibfa1uIzlZPlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6apiqP80aB8EING6/KCjTW264I7Ku+vYFCMeUjtTvqLmcSXKylmZ629Rn6oxSH4b4niBaVh5JAaK+XZt/ACS4vSFd3Sgi0dJdWLajU+2eeYaJlK3/KdPdgzpTEBjPRxjttt8938ohO+C+5v0rjKQI4T8cLESaaJf+JEa6oLfzfAdzYqTyv/eTFiOTqK1aACWVqYhtKdKQJujtVqiX21c6ObnRSOsFnN2QoFohxwa9v7sYrBzPqkVA3bmfOV460SCzBGgtFbaeOBMqiE6ZmVMVV6MBrVWMzIvxGItdEX2JU9ABJk/kLxs2i3TnL3NNrcXWerDNXZRQ5cqa1Eszr+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKitOyWlILbisqzXDu4zJ6NnI8kGFQdW6d+iEn1lD6A=;
 b=GesE7cHrRYqls4AJqE9bHmjYZDwz5/v+UzR9eRLzFnV65fjCqeU2gdGY3xTDXzfRGKWp3bmkBaReXv0ykkeDFQLNoar0rg8OyOheCRV/RRzGU/BuHZfCl8XtxdBhTIoEtHhzbBUgw/Mx5ifU9l5JCDjvbG69fMKgxmhD1/MJDYzdzrkM+WElGrNAr06lA6UQgNJynZQpsRSCLhL6bmlbU+4igP+HkzM6gWlJKjmT2giezNeY//oSiEw9fcOXtJTEewBRYdcjHLISP1UHKhE7K7iLEB1u+E5TwanoQuNxlzNKcLoHAoS3o9fn5bOITzsqG8Ua5kn3QOjDQBlUCVP39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY4P282MB3986.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:32:43 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:32:43 +0000
Date: Sun, 2 Aug 2026 11:32:30 +0000
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
Subject: [PATCH 3/3] arm64: dts: imx8mq: Declare the PCIe extref clock
Message-ID: <3436ea65303090e435a24ba04416425f0380bd90.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785669457.git.rudi@heitbaum.com>
X-ClientProxiedBy: ME0P282CA0095.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:213::12) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY4P282MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: 96258ad0-f989-4bc7-6ceb-08def089c4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0foQ85qI4fw9mKzKbXI+qXTYE3a/PPjAZFel6qCEnBDehEjb6M7xCGmZG+6Mauympkahrbe3TXpSzh4VLI/X9LHKPl7X/ho6uBScTT9aT2RkV4bHueiEIZmogKnciuSzjbuVyzEPWAQ4mqM7eFrodtmYQALVRBS3lHp7xKbbOrZBDBdujyyyyHVtkC/iYw6kUfyQhnez7CTwFgRjKKZwbTeAXMTUaizBR2zxu/88D/UPBKWKRGFcSEoMFot5TQIQkhkvggYBOqDYz04uFwX0fZCdiQO/18GhYbHjY+NAmrPbKuLdOUTZtmakeYrTcwZqFk2cHtEAQPES9CME6WiEJ44fVJXFQhY96o0LJiSdJeTeOHrWDj6K6N4+1yyuFn/PeldBHI/5qrYmQfigPToRqJyhjrP49wmqi6jdqDNwWEL9+rFLNuVMVSS9qiNZKU7H+/m7Ugj+W7Z/MIQ0/Oo8WUaUbY9dIgi+FtqArCjw7p5P/ZSGul6voW0sdmu4LJ6o0Ur7EiPHucO3hEfvmEmRe+7UUfoQb9BGhK8fE9NN0D1qka8FAo4e/Zq+JCeG79o+ZJEsN61/n+hD2dyKwUPUm7F5qyBvcZM3DWl4wmjaNm1npkswc9kE7vfJfgQXWo5UyGjAwbR5OuaU8v0K2ElO1y6ILOb9Z337r6WqsrBScrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EVcwkzEXxQMfYNaMnEnkXg0Pp5t45TdijjiGjZgloP6hVz6pjINlqLgh580/?=
 =?us-ascii?Q?ANiRk+GYnamprPZNaYMx6oZ7noqA/5bhdbUd+04PpBu4l9vT7wp65i9leqin?=
 =?us-ascii?Q?2g8SrujhNBhUQYFfzVoUmXrJ+QMGrc/6XFa4REIzBwhKMVZih+znhOFnLzg0?=
 =?us-ascii?Q?TkryfHdTlshI7nViQx/oCD0rpEup+ox4hx8yjZl7CW67XI8vpg/Hv0e5HDTJ?=
 =?us-ascii?Q?pF6KOyZckPQ2f32URItLjpUY/zOQzx+1YAaIZ+yVGqzeg/MsI8GJex9gw9Rt?=
 =?us-ascii?Q?m7LO6JxTwXwoiOWJtQ/DFZYa9k/Z7nqvpk7isK8BEqE+uh2rWMS3czq+dIa/?=
 =?us-ascii?Q?/2HSv0I9H6E/kEW00FTwKnnSx5dzJLSR+ePGOuCdMx439iOzw7Qw+v3gTj1U?=
 =?us-ascii?Q?oiiQZhG/m/8TtYEawAABWtkCdNWo2CJ02Yy3Fb4m4NUsuCAdq1IVTCuclfWm?=
 =?us-ascii?Q?++vCqeWbp4e/NNkqcucnkElmnM3bnGHSogOnmlFKps528Gpd2rEBEWk8sCg4?=
 =?us-ascii?Q?rflnZzEhgSzsQVZAPmAkpukhXJ7W2bF59RLf3C6Kyb9vcFIyOk56YoEr05o9?=
 =?us-ascii?Q?2PglHUo7pmZQufMXmRgqMUCxIh1KBWDbbKb0Ht51dV4lxN//DBOQrQc3HI4G?=
 =?us-ascii?Q?w8rXg+tFNj5LhFhSBm2YgifwUcPHhOvWEPVgxOHtp4iD+DGBReEH0tzA/WK7?=
 =?us-ascii?Q?ZfVzN7PukuV3JD5kSAobdAWmKwh9tg7QxXf4/QUWhfgtre8iFyFG00yyQCf3?=
 =?us-ascii?Q?9G247Ly0im7/rGNykucxhO2+JRKIGh0u+LO/7C/D1MiL8v1zGfx8NweTqnrk?=
 =?us-ascii?Q?hY0dZl1A0qyQFNpzBV938WP6gYkgKVwVlp3oChya7ibS5qnkfrZ7vArgc1Mk?=
 =?us-ascii?Q?eai/cqq9+yTmL93V7F7hEUFS9Pl4PBnSlqPfIb95POdTI7HEOVLXENNjyfGn?=
 =?us-ascii?Q?K5T9oOQ51WQ6B5AimCsx5ZbSsVCWgNL2XRnrn1jOzg3dAM88tq+M1HkVbkuZ?=
 =?us-ascii?Q?lxmNaqrYCjAaRMGHjXHu4LHQKgIH6miYH6+czVytQdGo9zkI+DfIP0YfPT6t?=
 =?us-ascii?Q?uuVehpKBPkP37gttYpFL9TQ1MEaL2VIi6ElEIqKo1AdsfRDnA7UKpOjCc645?=
 =?us-ascii?Q?rR/URqYxGOIts1A5xOQ2NYBWpJXnhVTK9O60hyz1RBh/lXrxcIAAlBqDJVI9?=
 =?us-ascii?Q?PkmCD3/M8H+6+doOzLsoDhw/PseE42xpqPp/OJXQ/VDfOBULr3OEwXUhJ6iM?=
 =?us-ascii?Q?z69CA4vJp2ykzWC5JnqqVWiNJTGYBXrz88Fco2ULcSdcmfMOduuVK5W3l+NO?=
 =?us-ascii?Q?iQ9oVyw8lMT78cVdL77lElyCAOqeAJEOsmTdBUu6iyEMD2WZXSzDemDSpUei?=
 =?us-ascii?Q?UZVJKhHSiQ90rbjWE/zoBrIThdbEmMyQcAbxtyfZ5QBszVcZYWlHlZEMFFNk?=
 =?us-ascii?Q?BToNar13NXMyMndlAnpzJDdWScbEOaV84StIQWMgLVv3Km16Tak2g/6pf2vN?=
 =?us-ascii?Q?aPCz7wbVie6lAcBW87Gnpv/fQbSh5y+EH4oABn4lyZmrr+LZUpPGmb8ThLqk?=
 =?us-ascii?Q?jdVtDJAyCG8S0jYExW1l1QT50H9zAxzD3xn0kUCBMYxwINhex4lCQQIznsp5?=
 =?us-ascii?Q?IyJwN2Ak1n1mXsrCWMU4L8oLUZqiearL4eUmdYH7u/TOLeB0+RG1igIBLB/y?=
 =?us-ascii?Q?yzgnzE5UIVAy/PvjfQSnnAZ56H1Q2wO0YAnI8Y6bsqKl9KxX?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96258ad0-f989-4bc7-6ceb-08def089c4ec
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:32:43.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tG9G7X7JCe0yTz6Px/NDjcMscdErxcbrW8N5i3Bl4PIyX0dRpukP+bE+qTRH74dr6bOOCrisVQlRdJZZX5/J3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3986

Boards feeding PCIe REF_CLK from an off-chip oscillator described it as
the "pcie_bus" clock, which the driver never looks up by name and which
therefore selects nothing. The oscillator was used only because the
driver forced IMX8MQ_GPR_PCIE_REF_USE_PAD unconditionally.

Now that the selection follows the "extref" clock, name the oscillator
explicitly on every board that depends on it so the behaviour is
unchanged. The "pcie_bus" entries are left alone.

Endpoint nodes are not touched: they are all disabled and use a separate
binding.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts              | 8 ++++++--
 .../boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts      | 8 ++++++--
 arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts      | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 8 ++++++--
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi       | 8 ++++++--
 5 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index e7d87ea81b69..3dc0047cd1de 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -374,7 +374,9 @@ &pcie0 {
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
-		 <&clk IMX8MQ_CLK_PCIE1_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	vph-supply = <&vgen5_reg>;
 	supports-clkreq;
 	status = "okay";
@@ -402,7 +404,9 @@ &pcie1 {
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	vpcie-supply = <&reg_pcie1>;
 	vpcie3v3aux-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index d8cf1f27c3ec..8cf6a64db1a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -247,7 +247,9 @@ &pcie0 {
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
-		 <&clk IMX8MQ_CLK_PCIE1_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	status = "okay";
 };
 
@@ -256,7 +258,9 @@ &pcie1 {
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie1_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&pcie1_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	fsl,max-link-speed = <1>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
index 3ae3824be027..bf931d2f3a87 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
@@ -199,7 +199,9 @@ &pcie1 {
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie1_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&pcie1_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
index 0165f3a25985..761c43db3026 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
@@ -97,7 +97,9 @@ &pcie0 {
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcieclk 3>,
 		 <&pcieclk 2>,
-		 <&clk IMX8MQ_CLK_PCIE1_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&pcieclk 3>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	status = "okay";
 };
 
@@ -109,7 +111,9 @@ &pcie1 {
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcieclk 1>,
 		 <&pcieclk 0>,
-		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&pcieclk 1>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index c7bbba45f368..31db96adb237 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -551,7 +551,9 @@ &pcie0 {
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 	         <&pcie0_refclk>,
 	         <&clk IMX8MQ_CLK_PCIE1_PHY>,
-	         <&clk IMX8MQ_CLK_PCIE1_AUX>;
+	         <&clk IMX8MQ_CLK_PCIE1_AUX>,
+	         <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	vph-supply = <&vgen5_reg>;
 	status = "okay";
 };
@@ -563,7 +565,9 @@ &pcie1 {
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 	         <&pcie1_refclk>,
 	         <&clk IMX8MQ_CLK_PCIE2_PHY>,
-	         <&clk IMX8MQ_CLK_PCIE2_AUX>;
+	         <&clk IMX8MQ_CLK_PCIE2_AUX>,
+	         <&pcie1_refclk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "extref";
 	vph-supply = <&vgen5_reg>;
 	status = "okay";
 };
-- 
2.53.0

