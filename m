Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749148;
	b=e7sJypzXPkexe/69CYaokJrm2QSRgKOnK7jBy4e3nJjbknIhCKhfL+mtL4kIXhowS2YK
	 pRFX8/LFjDNUlDXdfpkSHqws29onocAzy0+S0uEcy7QJ3w4LCdWFU0LP8MU0qX2Nfx6GX
	 O8INxC9t5HW78DoWkAJKZiEultif4qQdKcY4Tyy4Dsq/AJ9KIl69hPnvhVJRUz5XoVP5D
	 ZaKdy/f4t3cUJsAvQnpddQV+2FYOws93hlh63gTuAPLwyq7V5npgiJy4dAoXzCla10p5o
	 ltBSdcurz0wqVN86C7K4h9N0X4dCv/pqeNVtLYr9gwP8wmmu2n/Eg3a+qZqSMGaKOXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749148;
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
	bh=F7knQuLQaKzDRvk48PNVB2RL6JwPZBzUIIEZLhne9MA=;
	b=OlnJb1L2Iz29basP7h4Spnb/J3Lu9ChWSOCvHC2W5N998g+ojE223JYbT4Gp9qJ8M96n
	 RKn1XiNNcxYjxyx/L9+asD9RALcYNIrK1ltBmtHoJpsmp4jTnjO3hvkYVT7EqJXnn1Lti
	 hNX78I/KAb5cdjmBJv44KT7Alp6FAbg+wan5M/JxwuvSdSwhRCBOwSscTuBcXUygcjHYl
	 oAQcleSDzXwDmnm/0FL0rlaOb5JzhPVVhKUgn18pBAgfDRRoT0zqeD53lUeiYkbydKi3c
	 JrFDV5krvHW2/4tfqlX2vRGonjcJh6o1sgKftZJzGdGZGjAuAB7EQCxc2hL3NCiJfvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UIVARmrG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B24606A6B5;
	Fri, 27 Nov 2026 03:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B24606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UIVARmrG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqt1AMZa6NkV1hLWOj08HTfIoDjJUdMi7ZZ32PTlB5rRElymw4DtyzkiJNAEr16KAGlw/lYfDPa472YOgMI/QfU9rYgXesqhnvi+l/1P8iI91Rq9fzuRTvTrdFhTIjNgLhMrh4ovloIeoTjFFKM2DUwZQgdk5mD+tFpvhYJrOQUQPPoU3MZXp/lWwciUWbfSfGdyn2WzHjLMfmx/pL+4ohfc9qorA47DYNmgeWWTTg7xau0Cbv7xg/LPr2PLnETBdikMiBvVMuTQWI9oqurqxLKDR42vk3Vllt8N2vCpUSA710VM2ZK0zVOTdkF6GC3HnHhhs9q1f+TT3mfCXbqErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7knQuLQaKzDRvk48PNVB2RL6JwPZBzUIIEZLhne9MA=;
 b=ND1MBXZIXddnw+5lLrnCJvCmhOus31EVvJN4hRtq4qiEtZSmTtXAhJtOCMGR0OeCHoM8tkV3pzzJdsZUCSkgdDHgi+DWn5VzmTSpqTJquH7uO9yep0EvEtgq1K2NsZ5+STiMSyUfv7/RzeL5pATtiHOzX6r2fCXj764idVwsJgpEc7+48ArBXEyBaDSauPmq3y1js2jpBRh3ScTi8OsmyLQjTENxLp3k46n7v1Hu9CZ8F+vp080BzE4Tc5SuYcJ5Jq7EkaAgynNdglf1ISsJ8Fn1PYqC/8yPUcfPK3hVdGawd03rNGw09t/ztGZGLpTF0zSX4Tj5AmunSXgTOE9p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7knQuLQaKzDRvk48PNVB2RL6JwPZBzUIIEZLhne9MA=;
 b=UIVARmrGN3Z0dciNNip75TBOWQlRJF8g7nMiamnfdepNRBKDIsRR6AoTvuM9ztjUBC+xxBhA/nC6vp78ZI/UjcwFrYC5dPWHXIpwaqTfZ+bYqq1HLP0+Tt2JGgrKJ4/P4JlpszdgSicQFCJVDsS61vP0yiRb6+Sy6iB2iSzn9PE=
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
 03:12:24 +0000
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
Subject: [PATCH v6 15/17] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Fri, 27 Nov 2026 12:11:43 +0900
Message-ID: <20261127031145.2521228-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: da54c650-379a-4aeb-19bb-08df4c3441b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	rStxH3UNmjo5yYBUnggFYkpwXSsZzyMgdgySKI0N/W0fiZDM/cqLklkTncDHJDxh88PNdyIK1mEt8GXs4XcHICudjTms04EVE3b0Fgu/4YwlO0B08kvJRqqHf3i8khHnTVLmofwAda20uqgN+efEC4UFUMrjToFpxazDoA3Ucl+e0vO/DjV6irNjbYp1r/1ZyW24ZudiREWnETLhRRZRE4mmakAXlVOARKPUZhfbQ3B1Lbr3zlka2kBmg966GdErAEgxoa8MV3KIdbPP1ZV6gkZzMAyKgXyxZJ39df2M9k554DSQ2SG2mXXqXUHD9MNr7gaFqfHbIR7z06QNL23HcX4VbX+2H/cfSsE0vTm0JVyjbobgBtACqyZyIrD6sA2P5gGyy6ym7EDFeHOtV3BHg0VlkKkg8/J2o7mTzomI25IqWgy9BCVHMPMkmwtYxtg5fPtptySa03AuqRteazeuBQCoRqIFgZcnxdsAu/91bjDU/wstLnXZcyKlUqIhwLA/hoCxpY2l0XXacmXeHVeXCo0WS+Zjz1Jo4hH+prPLOejflbrluxIRnSNgpQLvs2m8JuuPLhzozqHsBVeYFuX6pS6ouPo7WH/gTYm37eEyNYIGBaerHzi7Ja8wTwCN7f//5amIEhumePLRkevaWjcHP0d2UnkL+wOYJDTQ91Djjv4FlN2UuJCa5vl3J+MqLFvz4zyrJbQJNIZk2j1ijpO5aQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bBG4LXfTnmOz/QTH7iQaeua2WiN+fr0h5NmsMfK/t701twIZ3RevVc6Jm7H?=
 =?us-ascii?Q?eYhHRS4MQwqMqPwwS7+y8q1bQFcG5zqtr53JAv2VliN3RhRmqXmTcpj5ESIh?=
 =?us-ascii?Q?Yvqo0vU551huPNp31xmE51pV0WP3Dmy1oxthdgNU+ooBF/jX8QOtP7uFUWph?=
 =?us-ascii?Q?UkanJQo1sjsCnXYY9rjiBK3XRC0wdbFqOs3XBG6eMP4/lAe/ZLPezKHUzg3H?=
 =?us-ascii?Q?6FHls3luErxmTStZfzfRgGQXznYwkjR2/tQDQOmT+LOztjzJhHdyU4/BQtD3?=
 =?us-ascii?Q?BCkfwWf6C3sVzsjGTuGqZ/OKBVbVHvk1N3M/VFgrIwqKqHiRUoQTH7ZpUxG8?=
 =?us-ascii?Q?k4dlThZpBXBdSj/CBrD8uDQ44n3TeW23wyPk3w1leQISOTmGHb3pKNfVzosU?=
 =?us-ascii?Q?BxdYTAKTAgsq4GwOuLLVVWtuPuvOD6Ur5KJmb9/nuk1DVXg7TBxs/jXjQWD/?=
 =?us-ascii?Q?qAtX8As3F7WWsfZp/dVe5T+pzFIU+6GZdAkN8VB9jZmpgfp5TwQkl90p3ksz?=
 =?us-ascii?Q?MktVL/q+7ko4mrJ3kS/08j0WMGil8t5/+oz01K5rGwxRGPCvst/wid+f4zyQ?=
 =?us-ascii?Q?1oSq6Q3a70v20kQjIBj3ZyB4T1rTO9pdcBiqDgivZ18Nvjc4JXC8TQFHO2pu?=
 =?us-ascii?Q?Zwg+PH6Ro0jNxgk4qauc2z0tFZF2kk0C4oAQ8RyJjnRvycd/CL9DpTeOnxr5?=
 =?us-ascii?Q?oOcAP28DREgNy3B2qHiB82C57ZnqeT1UiWZ2QG81CU9D6DIMd8cW3pEUr/MX?=
 =?us-ascii?Q?2jLft6OX7BlADwTqvos5JTHxY8j77Ed0yrQeIw6n5UYnbVVlO7Rpu+6F+Lbc?=
 =?us-ascii?Q?rwrl7Lr97yWVo4sgyZMuPgWiHHfl72ScXkDB4//vhCbPuBZ9jydof1XVbeH2?=
 =?us-ascii?Q?SzBNyyWYy7c0Bz5ciCKk/xA9esWK9Hp0d7dIHfn8u7hqwJqysn7yIgo3sGD5?=
 =?us-ascii?Q?1S34Hhg8FA+AeXV1I96SXvO+n+cglMIqpae7m+VsyCZux5LM/96T3VOBPNuz?=
 =?us-ascii?Q?CtlSr2y0b+DyAEdi9bOe42O4SNMCq7S9eCib3+rpO97xgDDuacxgKHx4ZQo0?=
 =?us-ascii?Q?tpQJtUGpIP+pjwl4+lsMSQx8tQqcmQDRsxJ3cB9dfO7q1xVSjZBwX7a58G8y?=
 =?us-ascii?Q?ZlpTDvWYs8EugFxZ/JIDhZyVUEK/pVVl/65qhikv2aKGws5AocZ5xtoYGmtV?=
 =?us-ascii?Q?GthtYplLHxmGfpkRLA4QORJaD4KA/9ERnugyTdwP93LoR1IHMHqgyl6mlP7Q?=
 =?us-ascii?Q?REQOuu2PaZwOXue0DBA8zYAcqw5wv73++i5vB1ktmg3I5yT9fzW6TuiaAaqW?=
 =?us-ascii?Q?qs89iu+cPnmWhXFC2WHWkN4NI/wbSoCTSXmAFkEcf/ZMNHpfvb2xTsASKW9o?=
 =?us-ascii?Q?2gvTNT9FiRt6mPBN9GtNO0BuSeAYPRflp8ul+3RQZcr/8SpWUeAlBNLb1AVv?=
 =?us-ascii?Q?OacdN1Hiayqs6sFZhruU9iKwVmeaQD+a3tD/bRERlAkrMVy7ZJgG3R8wWgsT?=
 =?us-ascii?Q?9WfJSJXw4m9EO0oou0ssqA5Y6R74tVwRCPH91fzp0nrfwLidmxrevbLLVm2n?=
 =?us-ascii?Q?FKmwYogrZkgWvve2hmqLMs/dmOLqtb+B+BMc+FMiL/Az1lmvO3Cb6B0v3dR9?=
 =?us-ascii?Q?GAw9qAcmjHnL26/MbmNnEDs3lN9sRK4XiOftEeDC2Wn7kT6xY4eYRhu69uqx?=
 =?us-ascii?Q?/bj2bsq6e5K6arxyk0NXQkpo2FzlamBvpKS5tiCWLbofxUpEiijq8Z4cS5o7?=
 =?us-ascii?Q?8ZqMgh9Tp397DESnbva4MN3ey/0wdJuRbfVnn80Vo5X+h5O7HoWd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da54c650-379a-4aeb-19bb-08df4c3441b3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:23.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9D1gGphrdLwDR/3Yptfh92nNn8r3XQzFW5AchWFZp2Nt3z28MA2xqQpc0ZumHsGladhLZMf81Yub2kY6NP3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The PCIe controllers report Root Port AER notifications through
intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
respectively, separately from the integrated MSI receiver interrupts.
Describe these interrupts with the "aer" name so the controller driver
can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Add Geert's Reviewed-by tag. No code changes.

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 17a632770e65..8c818eb93119 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -785,8 +785,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
@@ -824,8 +825,9 @@ pciec1: pcie@e65d8000 {
 			interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.54.0

