Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465884;
	b=AETxMPHMpOE+lVFj1M1A3g4nw/So7Jij6KYw0L8BCfjjfSJpWBV3CrtGWrbRkTvyQuO8
	 QSFSzMVgOhIQwBXvvLSxUJvlhnfhLZsra/vuZ8OqlZJw4Fmzs1ntegUATJS1jS5WV4hBL
	 d5P3dDKscJoBNZv11WcVtiXvBz1DiVIcQXdH3kJzgKv4qi3SJSD5O4n8NTtZndUrP2s0v
	 n8fDAGUsfXanxmpXVYaI9Ktwo+rh5I3fxWoi4AEnbkJT+V59FjK6msOBUWn9KydIEWMGW
	 m5hOjQnf35CWscw6bLyzNUyUATED9FXzkyQdmhxhwM/YyhfKV8Q5A0g2gGdoy0HH0OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465884;
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
	bh=FED9Vgn9jfu2ybkgpaAnuOcYtyhOWmnERUFp1owyo6o=;
	b=lY+hg0d+eXC3iGWpbOtAEFqeKOLe+kT2UgZr7vChqhbk/Bu48VPXjrI6FMKYI26YoGu1
	 TeQ++4L3lwkslui9I9YXd5HWuU5wEH75xv5xNSIIjXAqpFi24jTSCjC8n7Z9S9artAsIv
	 uSXt6pc4qJwlSjCXhgiSiv9ZuwZf0A+trQ4+Ms/5+txIoceq102Nyewepq/UpZJqTIQ+l
	 DfWu2mCIbpNEGVgTULEmU8ug5stUNdNJgADebP64IOOBYXLopGr1ox3Vnj6Wf9mbB+D3Y
	 0Rjuqnk3EnU1UXvXG5aiGzFFmwO5XpwSChRXE4X5dfrYqerKoKf4nruhO8o6tPctcOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ENhI3joD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DED606B57B;
	Tue, 20 Oct 2026 03:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DED606B57B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ENhI3joD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jdr5xnpjufhOpfoT512DagjNlwxQ9dzkCwHQlvnpe2/Mnybi/n7eVSa/OsgzwILHHqP5BC7DW7XYwGPVAVMjPI/+A0PHuMzkjlYTOAgfeIQFbyniI+ir5/NKTWpJTSYyFTHgSSpGytkfKdg/AMS/QGvGxOltxj8DQj4HkaFlP3zfag0BB67EhqeUAHuLQbdkCcaNuejvcj222yp5z2SS0bL3+hv8xHIloRG+5Ty9xs/PMpnlTb7EspNJ9+TcMLGzvW6mhWzP8BT/Efw9rsMJHGHell8QP90MyCp9Ac3ht7Ag6EQp+/3m7EMIhQaWvpmXSV53q1AxyT3ubuaH5skEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FED9Vgn9jfu2ybkgpaAnuOcYtyhOWmnERUFp1owyo6o=;
 b=BmxrLRWDD8ZHqerJcJvkySdlHXFUcDg2bbhm6x64U5EvQwT1M031+T3vSwct4fYo5A7BP7nRqWHFDQUHv+7UiVW3Adls/mQod82lxiroEX6iC18AQxAuRq6eH+dD9WSgRzrRlcKp0Ig7ozDbFtd7sf4fraj9iFLm2tv/6N90bBjeZ/7J5scirtuSM/tf1mQs98LToUjHZMITSJ4ttVLBaF0doZgUmYtDygWtcI8WDHSoaSL3m7Q3k8Soe5Yuf3QZs9u7PfEeoimZYyEGrDQifFtlrpCrFXF6j4yInWOJE4JHHbYQErZ/ey1yie3zK4JaKtQGw0WahNFiqg1EOcR24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FED9Vgn9jfu2ybkgpaAnuOcYtyhOWmnERUFp1owyo6o=;
 b=ENhI3joDzPCYz9Cg5eoC1vLPi5tLmz6GxGW6a17kAnXp/D9yOxF8BwBfdaAZB2uICLQm5VoeP0A+P8WofeYRNeggGjnSK1m1Cb4QnpUeKvKUkiwK6hLaC6lhRA0UOXsdP1Ayo/0PBUP4obQvJONg2pdpK2m0LEOC3CLBYNz9Gaw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:13 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:13 +0000
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
Subject: [PATCH v5 16/17] arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
Date: Tue, 20 Oct 2026 12:10:48 +0900
Message-ID: <20261020031049.969895-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 55e01712-0bb6-417f-469b-08df2e57cbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+xsIDwNujIxQbe4kRWj7Z+R0r+HsMUhgGvlr2ijk1iuulp2tbQTDCwFXbRGp8vhgHNeMZLHseNZsMe1XVvYbhvuqbYLDCwA/wKbx17G/vnS0XOlhH5W9f6a+LkjzI8G4d1ZGigLmQyrAFMpRDzEGI8WyCmyo7WezhaIaKaUIJEIxEnB55NZk/rnY4iChohrFz7pDxsQgFzKKo+kBFDPQwXPiNUA9bHJWTynRdbUgfTeBjjdeVTYyV0PhLYshiDN8Q75pw0vui0aTA2Wy50kWbi02zkSmLONyTLrJ7QdlO0QHZAIYcWTjikfatsIRGaMMvC5DTZUUX6AEF3fHAHwvBOnFr8Q0uu0/IZzyDC9UZB4HACBJvXvaDW4f276ikyFEmg9NJYA3ifhLvDdSxA6WLA9rk1rszf3fAtH8Y4cPgsnV2oqpcjIpD0igU6FGGDd/g9JeuVy3kgm4+deHZBYvaJaWqiC9xJoiudGslcGgmdGUNGVmmuurPjeoJnC2bCsbVVvh337w6BuVKlYkLFWiYltMyuBpUF26gbEDUmED3jzJe2DIafnvR4Ynw0KyklSCpXFMySUI5CclLnaXr0gc95mO6t6P5aIIkT8Z06Kjx+pafq9kE2fMUckQF+Ylvp72aQsgGBhnu3IfVPUsOPRgiSt2RieLRrjSJQTLSUalbRuWD99SyFWWEjf0KyzsydeDRYTCzuBLLJznOJ2vYbKUpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFNS+1FTaqM3S4JMJlRpPN7ecn6aRi+3sLy+p2kSbAYx44yJD4mQdSHnSqrH?=
 =?us-ascii?Q?/cd50UH22vhgCJwkPc8V6wmDTfja1A9nmp1dY+M+VThhk+thaVwnASMMrucY?=
 =?us-ascii?Q?dokFAz4Ll0Dh9xGGWXGZFhaHRkS8eei934/bK2bFczxV8zHPTBvUfGeCxwpD?=
 =?us-ascii?Q?zEXHDyt4ZN0t1WjNnUxJ3ghwqGP5IbUZMN0EOu83EIZW5wSoTHJE+ec6wfFl?=
 =?us-ascii?Q?S47wr5sHodapIb+w9eVZ+fmKrNFuAJIiAy5BSHw5l2JZHu07MO+KnrHNUx/u?=
 =?us-ascii?Q?eIs+x1UXhQwT5PZhmVNUn2YBgq4wwJuv4OslnKGtbEZFIjNWPzjA09DgBBnO?=
 =?us-ascii?Q?OT9x+6XSn78Xyue1gIa2AupwSfiqNwQaBkTnkVdd4bMxoIdp3Trng2p8b84+?=
 =?us-ascii?Q?AD349JQpX/yN5BWEmv/NN5N1evwUqz3lZnOVSm29+l/FjgzZM5BMzYB1XYTU?=
 =?us-ascii?Q?44V4d4OATppCBeoVVrNm4VVc4WiBa4b5Akzt5AqZ5u8sweY6JWzmjCHVWR+X?=
 =?us-ascii?Q?1XcQllIZQq9BK21XI0L8000ehn3kldoZgUb0mJfEE0qHyyw3TxBrRmgUggl0?=
 =?us-ascii?Q?GEkam3x109fWK+Rh83e/F3NjZEmKBD+ecgMR8htPhIZxEX1APAtO8S4tYBza?=
 =?us-ascii?Q?Vxb4u4L7CeL08HjaJGALSLeBSONDgzBBoso0SYHo81e30MyQ4Dzj01hN/OhO?=
 =?us-ascii?Q?4UK4JWLKg8lFExGQgd0KKz7t1aZYHS24ZDzZpKMDbmYbjZHmoDEB4FhPpqH5?=
 =?us-ascii?Q?TOIdnqHN6hfZxObsmtqcdxIa4T7xZGLpsbZzF2cBoYWRR5ngDYgORxhryYFY?=
 =?us-ascii?Q?oVGEANDBbSbA0pF/fyFL3kDXfMhuaujGkksSfv1ToxNs0xjSuTDbGTNJLe+T?=
 =?us-ascii?Q?FuRUU4p41KfdkaQLleTrRyjMt7WGnS9MvRQ1ewZi6o2f2f6B4BF/Cthesi39?=
 =?us-ascii?Q?9XSHelGshp7iLWl9pcxsIIiFFLp6CJUMe7sZMzloM/d5yA2AiBgEcTrpdloU?=
 =?us-ascii?Q?Ho3+a3wO+iT+jjAjUKezrYQdGyVJQYc91rl0HhTklf+eygBS1N56QlPz6yz3?=
 =?us-ascii?Q?ZqPCJW54TLydFQz34SEhe1jmjnkF7WnVJE263ih2DwkIsmySdWRIflkYHb6v?=
 =?us-ascii?Q?D5Uep219jJLIGpv1fRu9K1HQ3zNdgwuz2cTjbtnS4LbBqSA2sRp3M2Kw6O+m?=
 =?us-ascii?Q?3O3Ei4WkJ1+3/1B/pvBFjezJ66efSHToqfuX/HcWaI9XE80jOHA0SncCp17b?=
 =?us-ascii?Q?9Ng6pUf0/1HcrZ968h+TzPQMYg7foHfQhXEQ//2rkolt1TIn/dr8lYZ5i9EP?=
 =?us-ascii?Q?lxH9Ni8epg2C1jNy6qag1ELXdypYXB4cgTjWgsVX6kYzX4iNZ5kl4Duc4BQP?=
 =?us-ascii?Q?JUgHRP1nbjMTj4Mo6AsHwYhWO2EuR6fKCU1THYHjOrkFjKhrqvEtp8kP/gzw?=
 =?us-ascii?Q?i9wCEM2Iy3d24RVPHz0WJwOMg5ybM3WSKb4jf+4MfTqkdea4MgsLGhF/gCNR?=
 =?us-ascii?Q?4OTnXAXE37P5tVZMbUKxeGratf1R16PSz4mhsNjiWOSU2ujw1FjWHU+0WiP8?=
 =?us-ascii?Q?OM3YUpaiZ2waCFBCwGjv7OGrfO0fdgT/nmyfMVkicrjysfAissGmiLmjp/q6?=
 =?us-ascii?Q?uDnV+ZaYLJ08Uv407OyLXX1h1e/KbKIaKA/Avm69cuncYYkCInYkvCDijAgw?=
 =?us-ascii?Q?CsIP6ON/sPpet2S1h6VR3EyQ9LHgcAs2vqKWSs5H8Js25Jl6JRXzxQUhS2Wo?=
 =?us-ascii?Q?GHFuv3DQgHnq9afnYOk5oMTe2r7y48OgaxnwjuytHTlLv6niGMs/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e01712-0bb6-417f-469b-08df2e57cbf7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:13.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qol2pq9ygAdvPduHoz38JDGQ26eM34n/uzDyasjvXvvztIDI/6+xao8WMW14tTy1OEugj7vJNifI22DyqQLKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

The PCIe controllers report Root Port AER notifications through SPI 454
and SPI 461, respectively, separately from the integrated MSI receiver
interrupts. Describe these interrupts with the "aer" name so the
controller driver can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Marek's Reviewed-by tag. No code changes.

 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 5284923b6cef..8342d3c6f988 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -801,8 +801,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
@@ -850,8 +851,9 @@ pciec1: pcie@e65d8000 {
 			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-- 
2.54.0

