Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1183FFAD7;
	Tue,  6 Oct 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276433; cv=fail; b=J92TGnittMqfe+pzxkqHjUZa/bPg//O25MAQkaUCUosridG9+zpV5s8tSXJo3uEXyc1db6d5XKWHSVDHoXm2FlxaSY8qasAXLVzv6WkzoGB/vOpvEXWSfIsA9n7yBnq1GbimDjY1mMrbvJ1ApfMXrM/uULMXV1oh3jzs/z80gz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276433; c=relaxed/simple;
	bh=hFqjqkUGf9bJovkXsqgHoZSa5TCUuvClkSiVLlLrfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSgEeFgJPlQjO3yPTSGo15XmBLs8/6eyMqpzn7cwBXM5Qi5AHLgUOt+iClHpqlac2VjvVx3Gygh7Qob6ysm5pMh7uTmvVa3OkEbERa+o8jhUS1dRGIKeRvzByw86zFzsEGTOlk37eqUkKOv+RbQIv0d1TlNT161qDKjAzK/uWxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Mj4kEiz4; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Mj4kEiz4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfszhraJ8K7wlBJ7vjb2kmY3uQcLCPe4u7r5xU10BrYzvAX7F04THQUXpiEU/Sdf5zTAT7srH9Fn+XUjQHLX57iFtkMJeTQ0y1/oIb4vCVO70JByx7w8EA52omuckQI5zlznmVrWhThGyLpbEcYOhONJuzELTjjAs9NPDwqYxtxzWBJyWQ2jQ79VBu5p51on5W3ltn4GG+ZdIA4TdFExEFGysVBbewl3GcjQVus9Z7dqarmqV+gIN49QJI4yy2DK1OA5LxPeeYKdL/rW0g62KqCux/z1zMHp8NxiIs5KVCJcOwGi0uF1TjlgpsF4ZZn2FMdHrWy3Gk7cFM0Z+TqVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O76DrauHSF72QErdmK7iLpCAnBp+rClLWCBUR2bYeVU=;
 b=Dc61oCLWMwczW2XkzXXoJZrbq3CmaMablRJPoBX0zn86pfTRVxb/C88KX5CZvS5zfgSjmZf7bazFZPA/6Q+b0DrNR5OdZXxFRHqixNXifVIiMvAV56nf/+2K99tomwpw3mS+YhVlCI3RR2P2sfqU4rnXpPVwo0ySmEjgrbYX71eK2hSm5rqVXiIp39SMUqkPf1eiVLDCVLjR0jllu6WKjFthFmx/0bSxUAEmNUhgENb5WR5y+1V1OL+I89MmprAJKucrbtbXlnvcOCeUc7nMUPxl4S5zIOF0VUt0FF5WF7jtEOWiWV+9/X97K+5ivcnsl2X7tTcTe5zkTxp4/mzNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O76DrauHSF72QErdmK7iLpCAnBp+rClLWCBUR2bYeVU=;
 b=Mj4kEiz4c+ufT4H1KJVgNXASXRQXuS0iwz7CQDvAt9ojwyPRYKSHF3FP9PTo8AwzshoDJGdxzBc69QuObSqZgFdeus82AvwTjX54jrbINNJiftgK84Xqw0NDUxoQqH9n8+wsyBxfEE//bYxT+B1OBCz75x0VTKW+50lQ55aewpg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
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
Subject: [PATCH v3 17/18] arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
Date: Tue,  6 Oct 2026 17:46:37 +0900
Message-ID: <20261006084638.3821710-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: bccbace2-6822-40bf-f412-08df238663ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5eL0KN3WK7r8Ps8zZXuSrplFr4i4ZJoDdG0BPZFBZnr/2K4UMsGAltG2+seqvfElNUjTRVWkRrexNr3KbA6EyOGGwyTTUyEGikhDigKJ154rp9lWyLb+qYo9eVYWxYfITMxmpGQf9v/iF1yjCcmxbKpFvGZAUFSswTHWG3/YV2ljmVqJ8TLdTGsAF2ABNyD+SV9q+XwuAlAfrwK38XmNc8qC6NN/RDUjBVRp7lrRS1yqKTbDYH6TjWyktLyQqYyGuayXyB6yU2MyXoMwZFKJfPiSGmQfgLnjc+/rzcRIXx0C+ojGrTP/L3cidk2jXdeT3m26YDUG1bggndl4MJc4UY9RD+840uMxrdLzg36UTJSmQ8gohViu7FvuKMzb47GSsHPe494FTqr5Z95Hv69vndZWbxX4ZJxtMMGR7AllbstNAxW3TJmoQypujCN5dGG9kdjr8MihJGJRs7zKy11SZ5Es90503nrDW5HW3wbEQp05nrgPi5HSF/m/AZhmHwHEezy6lS2dTyIU4vlwNuG8rAvTy6YLKBtqX0TM0869TvVG9BeTU5zi9ylI0IA1/YF0z9f+MKIrwfAs7QMniWjTo/IC3gxOBMj7xfRZ8fJ9vBw8mZXFISwPvC/4ReMcwAh9OllEBO0y+KXq9wEa7gcj0VEh9nJHpJgFnpxdBmHqOeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0FS3PB7PGxYYCdGqfUSWd2JWn4YBsQBzcoOWx5Wj7eCvz2iLJtL/X3qT8hpz?=
 =?us-ascii?Q?WBB0rAmeZ96RllaQpyyovHS3Wtvbfcp8LV7Hwce0vuPtxgEw7QVIDq+U/nZT?=
 =?us-ascii?Q?Lwd47+rDzLdXAkUYmmODlvdVv7YlXU0czlOMKr6O0kkVNf5WD/fKowXTCsE6?=
 =?us-ascii?Q?HmDQ1dueXAdYn14pWRoPv/ZfFKsmcC/5q61rosEXMa/6wC3OcVDnFs7gElgt?=
 =?us-ascii?Q?+PhnDIzSe2liXsSV5q5oz030PW9dZEuOZ8vrqjfxoSvqp16QSyi780UGTBJk?=
 =?us-ascii?Q?0vDcydA/xgUYvATkuqrGMNXyETn4bdDrLYVj6hqOi2NKeTBhhySv+8wX8ibt?=
 =?us-ascii?Q?94yGU1os1YZQbnuLKe+n/H0xZQ0Ko0Sx3+WKEIygz+YxLYkoo0eirw180oJh?=
 =?us-ascii?Q?TbmGZkAt+2JWkd8CuV3WpAVzKvp8+9n0x7GgcT61FA6yE5CEeMbOYLPVUnQK?=
 =?us-ascii?Q?jdHDWmhrRgN5gNKzIFe7awSacZ0MoDWpe0EWoweoDRQ5sLvJw0TpG0zxOJcT?=
 =?us-ascii?Q?B3bZ+37ElQIqhyPBJf0SrIejgtGc3D3M0tNScdO2PAFRRYwv6oWqSW4hH2Lb?=
 =?us-ascii?Q?bn0KB8+pKmxJ8SkAI6UqFEXtEzce1uGlAv5VY8nbMH2ui7lLGhGbmU5dTL8P?=
 =?us-ascii?Q?NsyRw4qcoT7kpQJ1vr/0LNkBC1tcvsnl/PfA/ajRfsJ6ZYkjlFAdmtddybUg?=
 =?us-ascii?Q?l1hcotSnFJqZfNDmEd05o+TGFBUSWxMB8/QHhFXI15VusjYQRWQ2Y+wKxqHF?=
 =?us-ascii?Q?KXc9C7j0SB+B+o1EwDAtYKwjKsQWe5XVajaPr46DcXWFtxplBx+K9W+9FxCy?=
 =?us-ascii?Q?k+gafkjs+xIuwGJludO9MngFamunO23d7Cwm3vYnecJ3tEgA/bYaj3YusG8W?=
 =?us-ascii?Q?zXhnVBUgEdiE+9jO/trfirjhAlYDciKc5kyslNPOoIf2N888Yv/bF4xprcQ4?=
 =?us-ascii?Q?Y/rdBKcq7N77ucT5dk02Me0bYLvCjGaat1fTeQRCnLkYFsLL+X7zyaCswVu6?=
 =?us-ascii?Q?N2ro5PjqEDjwSV6w03qUTQhk0MY0l/661PpgFe4HZL/EAgRJSCqTmymKZ+tz?=
 =?us-ascii?Q?bn/aBwIX5B4u/uoLW5tZ1lvnbK1qQV+aNoGi7T2LlG5A//vHzTE64oYEuXHi?=
 =?us-ascii?Q?wrGAjPoj8loGNzD7J9C3Owz/OGYcbadfYzMj9winw6RoWUre+B41m/PRqsaZ?=
 =?us-ascii?Q?e5zb9w5whU/6B8LHSZOJWchSlN1AbSU8wM0JC0CICe1ZEKi498PiucnguYnz?=
 =?us-ascii?Q?NMBsPvP1TMBVWPNcCSqnk2ic2G8dFm6VXIk1F6xHL57ASXngIdmYNOrjsTQV?=
 =?us-ascii?Q?oPqVQSbhXiK/LuJUl5ecFwLaVPlmq8Jb769KS6bnk7/0xNfoqqE6wkco81+9?=
 =?us-ascii?Q?XoKPZVvbScZhnHrErJ6dWqgCsEb8j2xN5G/U+raDwCsLUHDamaxBh6pceff2?=
 =?us-ascii?Q?uilY3oRyIZxJExF+LksascrYGChUxzXBny1b3+/h7HH8yACaOHrCU6nna5SI?=
 =?us-ascii?Q?H2SSeIotUkzSA2ba4/YwIy5BI7mMyGZ5kiLCTrzJCad0teR6cGfdaEPIMO6r?=
 =?us-ascii?Q?MDBi9cfkL/5AKZIvAey/fuVc1H8HmWXQ6rLmCEQGwLPuTXifmqTOEHGYm1Mk?=
 =?us-ascii?Q?tcDCLRIw+7FJqDRDdA600j0u2kMNBW7hkYKUz+rmJSyEaAJNJymy2RHBUkBS?=
 =?us-ascii?Q?oeZk5OTlXbvpfwGi0kT9bSoCUSagkl2DKhWWpgOrF4/eqIq2iaf1LvLXkoie?=
 =?us-ascii?Q?OVEri6XRjeULMP27T4fOvi50dDZCl3LIkl6Nsz6kp5PkeoySXfgU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bccbace2-6822-40bf-f412-08df238663ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:47:01.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Stl/9olAH/7ETJwA9lXhKoGm39jIuQP/w+ZhP25KMPVQijUS1R4hgtAdmBwf/i06ecEIroX9See4E7Rr1IGYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

The PCIe controllers report Root Port AER notifications through SPI 454
and SPI 461, respectively, separately from the integrated MSI receiver
interrupts. Describe these interrupts with the "aer" name so the
controller driver can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. Marek provided this change and ran the bandwidth
    notification and Root Port AER tests from the cover letter on a
    Retronix Sparrow Hawk (R-Car V4H).
    https://lore.kernel.org/r/d9ffb9f3-ad89-4912-b863-637c838196cb@mailbox.org/

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
2.51.0

