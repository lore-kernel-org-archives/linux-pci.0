Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749149;
	b=KgFeMhJ4xY5vfifFby5wbHh39mrE+/j8baBHnznm6u0XGqQV6ak3WHiGGuDLd9nPlKFS
	 k5EXKc/MqqTflIxX3p+gQFeWPhwHFyJaNVorw28NPhNiKughKIVOBhkoZY7TBJXz/D+HR
	 g4TbXt612mLwr6Th1rC+qoHD3nLszcHgBzXxJgXQpqbtFhZ7P57oySMItJoNecJDUGhEL
	 Uwuu9lsYTtHNU8OdvRJcc35z0fdPuk8cv5zJ1TzQZ63HGqeI3Jr+ax/WQcu68smh0H6ai
	 PIooF7flMG5OnixkJ9WF4daXrML/Wk3cqtUjhS675rPjNq7VWWm7KNzS6s8BDT1t/Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749149;
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
	bh=x0VtTxDDUozFud8mF45CeAKEGsbVeE5i3Q5KIU1Lnr4=;
	b=n4LlcoquhQJGF8FLpYTjrZgBEP3FSL25BVr5bwY8TN4G5INs1Zt0vfkH+8u+kQ5PQ8mk
	 U6fcFxaDSM/fLbv3n9UEraRQDcsG/J8O2rDDP4FDkTde2CO1PRJXDidseAQrkSo//Jvxo
	 aeTLoHFnFRCW+ezdOqXqvFzJYkslfCc49G8vZGDmxVGeb4rf55NLectlGIbZ2qmzLEEX3
	 PwFL1dW5gYwM6uLvvNks3n8P6GYdx83pCerlBoyal6QHK03o9Dzw4n+y1AhQk8ZNCDYqI
	 11OpK7ZcsaP6mMJue/Hq/23/mldiMrw9DMOY927EIT3LbDGVflqBfVU4HqMpKcU3MVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=SM0dJOh6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBA60A2625;
	Fri, 27 Nov 2026 03:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CEBA60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=SM0dJOh6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGQuwhMKeWC6VQmn1foMuAKiYbKQKnF1L8NMIoiJUTCIRvwx9e8uCpkc9+MBoHDnRL+R30mC0kcEdoGmbEx1r2uzsbTtvaKyxUi2YVTg4s9o1y/fbdI76tirQ99yoN+TiF515GSeR45ABaXQA8FuF7T7MaQHfiJTdvXpKC1rzJ5ef6jpOIrP72MEQvcsfJ/qpQy3suF01lwKMw/mTbWaio2VgUzc++K3SPct7AZY55j/YCKJH5tZsiZER6TvRTY6nW+BF8Cv4wfSWLQsVJD4MmfrtRbeia/lIoMhP/6LujVXQKqkUkq/NYWGOc6co2d0B6yMmXSAWba/3aIZO5DsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0VtTxDDUozFud8mF45CeAKEGsbVeE5i3Q5KIU1Lnr4=;
 b=XY6IpaKhFtSuayWKy1yQiQMea/CFAWDfIU4ADIEc5enqGqgC3FR1x3FiCBMz7OvqXhaeHxmsa9J4d5Spt/YH9c9cRcm66KfwI9fOt02e1zx+THhhVahUJnj9wU7Um9IFRiljajGY0Pb5pS7hc89TQj5VMEZGhnXaFpkk543Ubzt2ByhDM0CzZWvYORThAl+fV7Cuk5TtlqEYXXT5pXrhllV+EQz9kDZBuVyJgBv1zg4LbV0kxQzIw1tCfcbkPHjXarW2YUYBSyrDjQIjSKocU26ft8y1rKdfJoJWVZfE9bkQZpA9tkDIKBLNQY9wVh6bygiHslEdx3r/LI8LIJwS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0VtTxDDUozFud8mF45CeAKEGsbVeE5i3Q5KIU1Lnr4=;
 b=SM0dJOh6DSspocvqQiPHbxuHAE/J/kBQvGhsBXk1k6iKJu8N1wjjm05ipaxWPa9VvZysrrCqHOP0t2UKd07RKpi0qZDbZlaPAO5RUhJU7gUnxbl14i2VsDiwIgx1yaEyLpvUIYMqkBkSC6RB0Ln5rgMjSVdi5K8S3xofXZVopeM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:25 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/17] arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
Date: Fri, 27 Nov 2026 12:11:44 +0900
Message-ID: <20261127031145.2521228-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d593c2-031a-4e83-b3dc-08df4c344278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	lb9+04ZmbL1NyKq4TUSOdLsCfOJUOniZRIu36jyGlVyNYfThYV7nN1yEwWECDDPYc9uge4BUmhvUcIA3uXk+lq10rU5ecUCgapPqcUvWIrrve/UyQad9DkwnXJtHddww3j3qvUmKpjJhwzauwCeUg++lmXgEpHX7qxuRdETX0T5aeyG2uH7XoPwHlLFiY+OkVZMd+7TyLJ6/4SnADbnFx95LM6azpp5X5l6VzGYX6g1t3GSZX7CvPsJyvVpj3J6Ir+U1DVgBldiAbCSmFKVRRRY56uXzBqEIiYu3sWbkrf4mAd2XE1RFL2rTaHbJ004n1lanucI0sxqwKgv0TDfy53F2d5yxNvlPjDCKNFSBP+cNocxDiTJGWIppaG17x/40UdbC9N1ivfmyrG6IbZb2+v1YtaBMjDTu+hHbzpv9cSTTRbSdXIyWZ9xZgEk5It0il1iUZY92uGOiYK8rXAH+AuPqZSYEcxc72+ffrLON3SSXcmqLFvvLLKEyd4ARQUEb0dq8l+vL7N/oe5/tlc/j7torOR5oNBggiO71M1AkIOsRZVIGlWoTl4Dwwp6BT0JspmCjMnqtTwf2KBxSPTiPlCfRnYm/jAUxDSvM31X73nw1kmi4WGHArrivRpbDpyfGg3/uG8Pti6c0YorkZ3XODoAPdp6/65W9+Fy3axynJ7Hf9AjYIyg8b3OUcSNIrgYBWClmwwfltnsQSQ+idDWhGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnF9Uzj8+4K7L9OpqCivOzanNOjbLxhU0tRH/9GR3rq+bCG5j4ip65T5yzAA?=
 =?us-ascii?Q?Kkk6dsVcEtsrfIpxRt9zfTYHwyCoTu9dp9u9MQsADYjBLT/yt6wUyPAqTows?=
 =?us-ascii?Q?GJKFSbYCAFDdTkXVSuKfm4HbtB1p3lhSb1Tqx3qn6lG9QbJQya79dRuUgUbX?=
 =?us-ascii?Q?cDT49/zYoEj4VZjkGrOonQE5voUu8XrP8d02P7rr8pKhTvn1ddVALrXBcHJa?=
 =?us-ascii?Q?sntQGEMYOjubRNE5PemH8ug1ZvEVxYGlFU1n3fZjobo6CttVNz0eZGERH83I?=
 =?us-ascii?Q?3QF79zwkO+f1BDoL4N/toeqG+cYt6DVekAra0vi6udOvwjOEbfqFwg3G0urO?=
 =?us-ascii?Q?luYNrNzC17H+Krt2xxaVsSTJ/gowVvvXqqNjNvoSEJjfebV6KGMdqFX+jAJx?=
 =?us-ascii?Q?VC9/fdSGaVxEcquz9596orWQcfDOusnFKixRfdLf6LMr5IgT58A+XMcu/gHP?=
 =?us-ascii?Q?RBkSQsP2P8/8Nd0k0nPkSHM8R0QTUlFt2IFBFQ3abaxOG+7z0kivzo2n76hZ?=
 =?us-ascii?Q?J5WG3aT2bd0Dh/z30/XMtCyO2f+Edc5JwNNYBN4bQPBQFslxZd45bCJmZgBE?=
 =?us-ascii?Q?wrxtNQiHffc3b0dEc09BpRnZIzeP5F3OOwiXoOm8djiEyiPpI4J1pbmugNAf?=
 =?us-ascii?Q?CzTGnQSnbK5DE0U6XfDkWufxEBJt8pD/qVmXEa/j1aTFZPhBl5rALvkARvxm?=
 =?us-ascii?Q?1ad3XlFS4o01xWT9uG+7ZZCASd0E6v9rOS2/P/5Gk66YOPjcOMB12q6Pbbac?=
 =?us-ascii?Q?7oy9W5hy1RRwkOwwSS0P2N/NHn393oaSjpfWdfTMSTIipll2uiTc7ABzHyon?=
 =?us-ascii?Q?plCI3hZiqq4cOxrZSoIPDc055iRd4du7A6aKynOiCSYsuS2PQ1LnUCqKl7fb?=
 =?us-ascii?Q?E8IizP25+rNwpvrxWP8lXAJQay+uZ/7hfpiR73ZfTdDi5ejOPlkVNcRATX9F?=
 =?us-ascii?Q?hF3ZAWhAkqTMRSLJLTmHV698/+tv2fIUy+zaTiZFreEmc8ARWfpL9XKiyTMY?=
 =?us-ascii?Q?IczUeXrsPBZejeTPQ7d7oz4HKyVYaxMwNfGJkrOISOCFdesQtM6TLTRSfq0L?=
 =?us-ascii?Q?OvPEH03Hr5S7QGdDVCuyM15F/WrOFvcEFkbazDmo/AWV6EZbacfe+F+HiT8a?=
 =?us-ascii?Q?8R1WCgRez4AtWqJrCnzs+4IOvO8t+rDX4gD4VS4hfT2XU8ezj3czExxDMxG2?=
 =?us-ascii?Q?HnLPUkaGVTaOBWUXZgqZun7JdhJwAMJkLGyPPLnKsV83jflKb/SXOS2WuOo7?=
 =?us-ascii?Q?OzMifSvHIBWg8SWH9zagCaJ8NiC7rzn+g+X6mFFb6RTgK4CLH2jGfkKpIqsT?=
 =?us-ascii?Q?zUhJ0V+31C8CKHu+S8ahPodqMyHacqs4M9VzWHJMtaaLJyal0VAz9jGZ6YdI?=
 =?us-ascii?Q?/j3EFqdJfxqa5HiokIt7PFjaFa58hvcSR5m3QbTmYcYAL4A8nPKTTQowk/Ej?=
 =?us-ascii?Q?0YkyITa09KqpWWWsBeNo5ZP+x10mPs9STwMFWYTP5MG6wGenOdCR5CSvw7KN?=
 =?us-ascii?Q?gpFjpuIUl17Acb1RpvSucboI9kJ1ajPoR3EPQSXgU5Wh4wOpvjF3jwT/nd1D?=
 =?us-ascii?Q?9SAclNNgNRqy3zRN7C7vUhYr0hdOQA3OoyyWbJl5QJtb/1CaTMZr32/TFQWi?=
 =?us-ascii?Q?Z/btdoGmlF5HJYbzZWwOU3tsF8ydaF/ZVPJ8mX834bh3dlNUaOggUT0Mp5B2?=
 =?us-ascii?Q?eL0CZQzA2iklLNx98MN5ezDT8ShQcPqMEvPjpLzGW+kgKPa6t95W0fh/mrjr?=
 =?us-ascii?Q?Cei68jojTaGj3d+kIGiaN6XvZGBCS5FIvUYN644ZkAZWbjx/trzU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d593c2-031a-4e83-b3dc-08df4c344278
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:24.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRIllJiaKSokSynBuirpGteS/6U0lapKxhBfTGtxvE7Zw4LcgTgN4i249Xe/XopyqkSlSc6fMsYyYDszmx0JWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The PCIe controllers report Root Port AER notifications through SPI 454
and SPI 461, respectively, separately from the integrated MSI receiver
interrupts. Describe these interrupts with the "aer" name so the
controller driver can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Add Geert's Reviewed-by tag. No code changes.

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

