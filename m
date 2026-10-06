Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2DA3EB111;
	Tue,  6 Oct 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276428; cv=fail; b=j3z/XR+FjV0sdAQ59zBFEQ5K2ZcTZGD4CoIyC2/FJKqfvpybzugdq/194KeqhOekHVXACMWYOrJH/cl6vZOgiDBrzUuMI9oMr9V+Ax8ynRyCE8+kmRHalUgfSGIlnvYNUD4tl6GKGjKYeK/USbMJCLrOGIOZxCyWfk7FEP7hNRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276428; c=relaxed/simple;
	bh=Q7z7RQ4K9shtt+fbqYy/8Ooyo3eoiZT4O+d/LxlJsZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcVgJopf6StIRbv8ljvGcoZsPjNDQDr7kn9qp0SJaKV6qERbv/U+WckJLYxtNqQfOjzlDKzPyV61tPFAk0HCYGIgKaZYaDQoQTfvzISv195A/cBXNNnduQSk4CXolDLTZyGZmZmSS94OxMK/JMuH4vMzUxFjqnMFL9yzhqIO78M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s+btPqB+; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s+btPqB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDTo0g5IIZ1Yo7fUmCuJpWO/+GN+MpeB8DA1ifz/EHWuth+RSuaC6ykRpgpBFdn0UKgF/jUnRBiVZ6biZWeDpt9Y+e7GtPnvHuR5g+SMkYRwhyeR46q2hV1crcEorZI/3/l7fyjFyUZdyub2dgStwNlbW4gBebaxzmHNuzJPXnvWlcT521FhfDU7KHX+dziw8ANMVdM55kI1otYQnXmHbBXsxBnJu/K3S4Zp+/WTPGfOqz+Qqc2x6oaB8OB3xx+1QLX28WzOaz//tLe0DzF/U9Xb6M/WbAhdb74wZPRQ8YylDUwP6TezbvoKhNzvhW/iAy/Qs+to5iiDoUqQqCvpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZmLzgafAVYvXRh4+Ms5x1OS0w+F4hOqcbdvMTSAQz4=;
 b=nFj3/g1LB8Gt6YUO2f92ROQNenLfmpHrvJcMNY31rMeCcFFzOuzCQs1LjZaTLvPCS/ESfiin4l3jgScvi4zHVEIprP+9PDTBAvuxquwBUGWYOoWi0DFd3usLAUDlw9o7PlhDhemrsnahaYVoYZCtVQyCh6oLDupVDDMTn/MXnTn2TtSniarC+RUsYwWHrxk/FHsphaVax13d6VlZFgLT+eNuVFaHxJO8P9uxF3GroToda2m3fCdV4wHlly+lpY/zl8dffRayKk3tinuHxZo9ij7IF0PRvq4Xfp1eCrDlNnnWDyaoeZ5wquowfaetNzqbcCE+VUjvn96B7RgbwaymJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZmLzgafAVYvXRh4+Ms5x1OS0w+F4hOqcbdvMTSAQz4=;
 b=s+btPqB+JVHvxydmjMv2q4wikso55k8zhj0Q+Zsa+QoqjR2lxufXQ8akUV+CMwXol9DLdGtBgHf4zJEZ251UR2//QsDDR5YgGM+2T4aogHGwJuDHegoTpvsKn/pNSC/k/VB943r2KDGKfj4Pup8fvXTWaTnc5h+XD4Z/diSF9CA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2621.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:47:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:47:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Subject: [PATCH v3 18/18] arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt
Date: Tue,  6 Oct 2026 17:46:38 +0900
Message-ID: <20261006084638.3821710-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2621:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e49446-7be4-4d29-cb6b-08df23866470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|22082099003|18002099003|921020|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0tGW4oExuSeE6qmzOAAY7F5TSpX0VzEU886Y0ILLkOfTDSCllKzyos0KI18nNNZFHhqppFAcjS7LqL3WvkZlc1xeqlSzf5FWtpRbae/mqNEy/hk9z7UpxX0PzK3/KYVoa/ibN4xcajPw1L4Bu7uvGP5XteE9xWwv8qNha32rIAIEuhHSwFvCqOFdAfkUuiu4eRpEaw75TUw7xlwCnaE13DHogWVG0Ir5NeXvOgNiozaY6crBROM8ipmFzKZxv8uHubv4/dzFdP3l58sPzEJuxhUfKiMahCul7xlD1nWA7Zwt5BEKGvAUxk6So9LAkgGBCJyfp6ASwMHecknNvrum4+GE/M6nMDRQJsRaWMUCLKXRy5SfRg0aXO7+x89XF1RJWcy7AeVCA7ul+EAbImUYAP2hCiskfXQTCrQbtJ3f+BHkl7gtZ3ditL24NRqPDNUvU3U6FeT5FhrRDuSF8Twrtw8fmxtu77pNZoHKA0hRFdAEnwMitFSSgbUSaa17cNTEAs+ErOBa+ugOVpnRnlEJamwyoyukq20eJq9WVOHLeKMnFNGHKoZeS3d4Eu0+AnKYJRackWQDwxgUk3WUmKWpboZwN9kp37pdLpXKm6lStswsj2iUoinHL0wsZ/hVUBw+5SXUs/bP0Nl6IgO1ALoPJXN5Ul8MHfnWNHo78WR/zRY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(921020)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7bQb4/wJc0UuV0LWCqX41bng69iDrPJ2ibiWaM2KYAn0xvuZvmFeRHHXdS3?=
 =?us-ascii?Q?SmXgbUQlZejHttBJ14ur8WW7URd1RKRGzf6GWQZQLr7WAVlNfZ7xFyq8rJ8e?=
 =?us-ascii?Q?xCQLYdN5iMvldGlZzTs6At3EvR/L7S0MxCJJwk9JlKGD4BOFMF0txkQ7HLiq?=
 =?us-ascii?Q?AFOJbsy1IbPhpoTxQA3JslKiDd+8/2pytfQETv906ryIXe9KP83ugK6hUwz6?=
 =?us-ascii?Q?iibuWRbepkqmQ303NxS1pFTZbqtbuY486ETK0dP+vJYED9TtHvog4nQ+LO2d?=
 =?us-ascii?Q?m4LIGdR6bkkX5/67dJpYzPa1lzMkn54ALxQpjeimRTYAPD/txorDkT6gMVvP?=
 =?us-ascii?Q?GZl16+crfDsQp577kxkAkLZQ7WikUT5UocHHWFOPYFhY55Xz6FnDJeAZ/HXZ?=
 =?us-ascii?Q?WDfqqyS6bR+WVefLccxwRJUouVKw4XGN+5DJZIhXB1EhQUBjJjLpxgUxq5ib?=
 =?us-ascii?Q?8S/reEnPEonfJJKiQo3+JYOKic6ugzxSf8WuFd9pWTddWHYXhBkPubQyXkfx?=
 =?us-ascii?Q?6GFZeuJdqlG2qrfjkQNqy4QuaqF3jY7IzzbbyA2Rmnc2Xal0sQlKORKYWB50?=
 =?us-ascii?Q?6ARbuQaB0jn8HSNYEaHZLhx/F6dcTpNA2Bewkc4DVMfZU0ndd7wT950U0z+O?=
 =?us-ascii?Q?xJRmABqgDj2T/RR660pbIbH1PYwDjp7btOdXX3hG+QZm23DJAQiKg2x1udtY?=
 =?us-ascii?Q?xIwUW7FglN2n40hO6vSCgSCZfAPYGIIiQGUQ8AxlgM16/fEpgWZf01ock5Pq?=
 =?us-ascii?Q?VIZtkD/yGRHPmOsBItjDW7R0OhH6+ZKad1O2jOxJfhZ8yzdT/LmcGleDgPu7?=
 =?us-ascii?Q?Nte4EcYvGk9oCg/lEGnbndtPNezQ0Z86SXeNcSiM6nSZarMNHM9Ryvgucyf2?=
 =?us-ascii?Q?I1IUq3GaNv48IepCjkp5hUE9I22RWBM3X5AA6BJJ9eyQS/qRsCBiCwSizbTF?=
 =?us-ascii?Q?77yJouu1do5KlSf1X2XdcINikfzIehMgNNZdgy/O8iynWQWH3OBGqTJptXVC?=
 =?us-ascii?Q?w0x/UCnIDottRU412qa0RewVfygq3TDS6JsIDWDmqqItlWVDN9XdDY0PPMhu?=
 =?us-ascii?Q?YEty791o3vjmAXFwCgKDopUYbmuZgHhw2LO9xx7WmqscmmF5cD3D8BdMIS8P?=
 =?us-ascii?Q?j/qATHFP80FbWqS+rlwL4YijEW2CYceB7VqbpAWRxmhEi1WQSa3G6CeqH92p?=
 =?us-ascii?Q?1PdPe9HVdRN9u0AJ40Xuja5R4Eal7/B3Ci1Om2nOx8efbgSl3m0DLqibdGGf?=
 =?us-ascii?Q?wAVbmpcmaGEnOED02d+So1fECydJZVy29VpbcCxrA8JLvrZdPqns6hVr2BEV?=
 =?us-ascii?Q?MxksAWIov62Rj8GbLN+6I6ldVpqtDYoIXfh5mfmHPr5MDiiQPZfh2y9pPClU?=
 =?us-ascii?Q?8eJXYhkayz6btWyaMp9tldd07EZZGKCf/eV6YFT4NcUWriOYduocXVjq4bw3?=
 =?us-ascii?Q?njkUoy9hIavNtpbN5aU8JqHp9T61Zds4j8TD5oi8G/6TJzFHe6GjTB3BoJ+o?=
 =?us-ascii?Q?dDgIijupqws+Hx7B9BlzYE9D7+6zyavOCSHaKh9DWzK12y5FFCx5VlOAZHQ0?=
 =?us-ascii?Q?dseOacN9DzdeQfRMh8GLLJ9BwVCZrLBV94LxJkXzIv3OcZj1fxtg7ZmfeXCD?=
 =?us-ascii?Q?nveihc8M38PNkcuXiAh8EW+5iZDp/VMV+Y7jMctHfAu+DN7jxSgO3+WtRq7L?=
 =?us-ascii?Q?QKMpvScalRUX7SGDMfmqpgAnD8f8TOhaZKUyOjsjIRMv2bk1QiCy0lIDTzUs?=
 =?us-ascii?Q?au+ATOnwP2yT02uuXgKT0Pw8JJDVlVMO5wvEmNHVeb3g6ToGWUf7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e49446-7be4-4d29-cb6b-08df23866470
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:47:02.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUA5IYRAAGEVJqB0JmmHPUnmVD4ZQHbmGVZS/qAVWJEZPxJGqffhTjq1UT8DCo7W+Wb1dN8cUIiMQDixTitK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2621

The PCIe controller reports Root Port AER notifications through SPI 454,
separately from the integrated MSI receiver interrupt. Describe this
interrupt with the "aer" name so the controller driver can use it for
Root Port error reporting.

Append the new interrupt to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. Marek provided this change and boot-tested it on an R-Car
    V4M board without a PCIe device attached.
    https://lore.kernel.org/r/d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org/

 arch/arm64/boot/dts/renesas/r8a779h0.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index 5f9223a0f446..a377aab3c8be 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -683,8 +683,9 @@ pciec0: pcie@e65d0000 {
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
 			power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
-- 
2.51.0

