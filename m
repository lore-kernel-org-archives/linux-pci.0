Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465863;
	b=0haNk4jsNe3tUPe9RU1IZ+X2eyT04KEB+4vteA9Ju/NFiXrP0h7UA0BR+jy/EzdVgYY2
	 1xZ00anxRrOtnYBP73LuHP0/b07h4ao2jr3gTaBUGC0yC6m0X1nQfUbXwj+a2lZay11b5
	 SPwWk9juZ49Wng0oTNid8QDIN8ttwjawDt326NOpLrGZ6MBuoxMFIxLnIuHRVf4kI6DU2
	 1Ly+BMJlmYsZe6f/4+RRjFHqV+ofDU1WiYQjSH1mGcc1qSBuYCmAHkNkcy4e9GTf1CuAV
	 aAVUe8yQJHMfUe/fAMP8i0khwuJZG83QoDuJzV0MYfm/+mY55m/r7iD/7MElvCkNsmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465863;
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
	bh=kcJ+HB1qtczVfdS6u7X7TkCrX7CANWVt9uLN/89rxqk=;
	b=lvml6WCteLGx1eHqPQV/rlxSSR9FFw67JtAd+yw+sCDlHzT4NP6HkvPuYaCECm13yXio
	 hn/Q4JZhfIIwqXToAFM8bdcYCYHsd3NH0CfMOlz8bdBRjILGihryVkPjhex0BERxESxgV
	 AlqtqqBFWYr/8xYMmASUOHMu2y4WaDhuw0888flEkQ7uI1nbZMPD02YVW2jim5upD17OT
	 +H2E5I22Vtf9ELBN/8+SXCHe/4KLIzVhhpAVYvHzHG8cGKEYSGBAE+H4t25nCB+NkHdap
	 3dGRYKzpINLORzpY1cUrheJCB3/qnsv6W3aEC4VwSKAIqPlq+DN+3XjwBacHaqt0mSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GfhB0i2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC6606AF42;
	Tue, 20 Oct 2026 03:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EC6606AF42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GfhB0i2Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t33v3rbLD60NPR2TwFns+VLRsLviwlpDrGruNXWPQsadwulmY3ktm34g9kvD68Hf3nEKvZUk/LUh0ez2kGzt4kXf9es9Y079kQPnbWXGWpGXNbpoqW9ZKI3Kjjqy9cFQYQyYDBVjQzU+OhRzBruMi8WkOJ5TlR5k2WEstRHFTvBLNPA4bISPq8EoZ9ewzUy3QZA4X4UaCtrdkBXoanyx5mTWzoxoQ4mdRVM5/bkGWXxX9YWmGxJjTsf95vSjvkBPStsKj0PR/CNXM8lBOwy1VmkvsnJdiSZq4WgAxJGpFP+m9Yp9kXip62b3zrcaLXWdDdyolyG5uvDHZJvaLJzvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcJ+HB1qtczVfdS6u7X7TkCrX7CANWVt9uLN/89rxqk=;
 b=NkcYbMPv5x/aN5aA0UDNV8Rs/2+A9PyDrv+iZ8XaE65Qd/qIsNjePIQ0d8p1jsoYlpAm2ZWv731D6bc25RMv3EN3k+hVRH9oXGClCuvWRpepv6AJ/73AQu5VZFGKFOPakXdrSFwrbYqHtryn+tD914lwGV08CPQ5vUKVBopteiZGxiiCZ7o03sWpQlw/GT7OAo+/cC7XDektjcni5tDDA1XLRBLhJpn352m2RKVTIym6I8Q5OhhnIHJM6EYc3ob6tJ2V6cDA7WSM59UqZou0r/RaCDNDW5O+1iDidWc7M2+IHM5kCO5V4WlivTr3S7nfKp1CIBmCwYu5xuu/CY8Xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcJ+HB1qtczVfdS6u7X7TkCrX7CANWVt9uLN/89rxqk=;
 b=GfhB0i2Qng6bgd/8w2ydu1koGpQLFtI75S6iNTJJTbhZbhZzRKcaJ5GapCGQrMQZlBxk8XRFKcKGLUp0Yq0gCzLfuNPau7uwXdtBmV0S6exIL5VgHNcWEI5f1l87nuswu8V76tDctZRMXXMRaU4EM4cNIug/x1xLcSXKfhgWwAs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:10:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:10:59 +0000
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
Subject: [PATCH v5 01/17] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Tue, 20 Oct 2026 12:10:33 +0900
Message-ID: <20261020031049.969895-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 01c9620f-763e-4e2b-4098-08df2e57c3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fvwmztfRMlJDDkDYwvAwW++G46AprAn5nRiIaH6q9Ch/3LDKRbWB0+dElS4+uY01jSWdSugWwlJ/mhbouLoq5D/hXV7Lbgb0z888Oj0eBBTVb2FaiMFIwSOKsFi+AF2U11DUEZwJ2am6o/zGZZ2ooEfuGDZoaNfHEmqZ4G6OdEQDeXv2N+/jyIAR5fzCRX58PzJVZj4iqeUjIAryhymFQtMCj5p9NcBcceHHGaDD3XEYpClRbfFd7/CDpLPdvgqCbwsvT/ik0jMlLMg2cEN+j1eKSOYVaN+cJskuOBlgODLCQ73zCVJInaFkhkeRK68DVwrjnlf+hFoigrv+yPc65RFImM2DoDU0NyhJxnPnV6SpmiZYgzNXvriUIoPcZSsq/BXKxB4xrhaflnkX6n+17tkT/iTzFZp6roJvMnro5kmxMzOb147JsQPAAIzLABV5useoJdQKmUugYmkUZvGHcCt65yudkw8WWZpvelrBCq+MQkOffteMFYyLWwt38nl/uUkg2W5iQjCcJuov+3FiuSCg9//umxdZnm5HON9gNeCRjkuLCjVoQGw3EFtzZ6vTxlZFifYvySsnw0snyzxxgAk2MoOdmL8o7e+8yrM1E4XNDSl50cEbFC6xTOXPecFNtQueO9S1ZNU+kpqFrsg5Mm12DMOpfof86y3+WvRBTnSL3+gdMVh8/x64vY3bx80YD147BY/kIjI1zSPeejTlqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pMc8+LZlvQKzhOUroogquCzPHu+75IZFKOXfRHuLvoKcNf+6Tm9+1E52lpw?=
 =?us-ascii?Q?+DxyUR8TC4OI3eK0Q9yU61j5qHWnkPBZ5O5AlBSONFifuOQSZ7369egvRGWw?=
 =?us-ascii?Q?D3T52VcfsdMhMT49ofP9RqhZ/NzvnOcoRby+d+WGwLdkwf/iBol4I9hsQ17o?=
 =?us-ascii?Q?n/0zgySHBhktm8qusgOPX5wuLSsbq4Kd9SfJpabRF+thR2PehkjdadDMjxlN?=
 =?us-ascii?Q?XnJVa+fRS6UDTnw3wp11ckYD9OO4WghYzpNEb+xsHmHS2vYf7nChRLI0FwTf?=
 =?us-ascii?Q?k3+DhBhRjelaV3uhOjubzpE54IFnZW6u6xflVZFcF3oIziVWw+6P2NoSEc9t?=
 =?us-ascii?Q?imwZYOTRLNgQdbj99mArMfojiwBJJN67fO0F9PpXv4U4i20aLd0RKjgiBBiZ?=
 =?us-ascii?Q?bj70VP4jPwnyK0SLw5/Lwbi+8znJ8s7oa1VxNrZ0v4LJnPpBfwjChsmX0N0/?=
 =?us-ascii?Q?EZb8QZYKfF7LXNeJeb1iFwCduXGIB/j+cA28BH0FGW7VAiGW2e4hj+T898B/?=
 =?us-ascii?Q?yMFND3HKBEssqVVLEx0bn3APL5cuAaj+MTrtCc4Al6+/1ZU4MJt0oeLo+zft?=
 =?us-ascii?Q?IC67z6Ren4rHsU8I/DAnz9nhIsKq9nRTzfYS65VpioeJ/zBecepuN9pN++PW?=
 =?us-ascii?Q?hogUCPlpHdPnI1jtxoso8XAvTXcsPN4rFabm7oyRQj4AfJkODToESRG5UfhB?=
 =?us-ascii?Q?UQigJLNjAGitx7arvY1Kb0eSNyLb0ZXjXZTrRN7+/cuMMbkztI7pl3+BUk1N?=
 =?us-ascii?Q?otZ1w+SGsYct9klHa7zBthYhudSM0SGyzroQKizz8w4yYkQoj1qdJ4TLjd2P?=
 =?us-ascii?Q?5h5oBDTASvfxqxPyHg6i9sKcjBuXfG8+DuPl0nSzgER8h9+CeYugLQHHGAYt?=
 =?us-ascii?Q?RyHW4gZON5MDpePP+yNDYeKFX31PCP+EsJe7E7xBrbCktzoocm5TJo7t3HtN?=
 =?us-ascii?Q?vwY0uBhmxG8dV/y5Tqra0QS2JDTdSrDvwDsUNJN/WIok1nGdg7OidpPQ/6V7?=
 =?us-ascii?Q?4px2u42NmwEdsNX1SX2ouZqy8eEN2D7Vig/ImKLfzsJ0siFd4vfTGRr6XCkb?=
 =?us-ascii?Q?9kksQOim75iuyQpfTNXhCWxvXaeALqgi1BNL9UOBoLZ5EdzI5XRuo2FQE7aY?=
 =?us-ascii?Q?RHW0VlzitPBJzAYx1x23Ak2KVULPuGvZ03j2s5rjBkHTooiIRNtLbgGSFP16?=
 =?us-ascii?Q?nLe2S8cx39KZKZkkBfm0RM8gCRpmHjDDlMtkNX9yyUhwKMhzE7QFP+MQxAaV?=
 =?us-ascii?Q?J6CQnZNN2ISS4f3Oyg/ETvxIrOrjnXqgt6rNKaQ/suCWDD+OEAf6T7WpC9LM?=
 =?us-ascii?Q?7b99K6bcu2EKYAfb0ApsMBJekTQNHN6edUBrMgfhikp6eAD/0m9B/typpJ+1?=
 =?us-ascii?Q?U+LCOFbmOvLKFE3sSTVfJ9JE1S2FrAhG/OC7ZBpVGAW5izZYrSC6qlUz3s7c?=
 =?us-ascii?Q?pI9pQCmWPi8kdWaP1GPajvnW4gWlJoGqV8rD/+qJvMhtyRur8HsCYPX/QGnw?=
 =?us-ascii?Q?wKhFV8ULmsP5Qc6U2jhYTe4PxtujDPTt2WI53MIQCh0h2Ays4aL33gRsIJgi?=
 =?us-ascii?Q?C1I5ohM7HbyhLQG3KNB3ndVuezLR1228MoByw20X5gTRxM6PG8XDyJ98T+Lg?=
 =?us-ascii?Q?unJm+VPes4iJnlDlFPuk3qy/WP+2Pm7zbcg9EfRdPl1ANmWZDmjDX/t/0UGw?=
 =?us-ascii?Q?4BAHnXOhOYVdEt5G8GDIU4OIiTTgrvurAsWas30cYhFSqWmQgpg5+V4FJJvO?=
 =?us-ascii?Q?u/hRBCckFbsP08IQ3cdq0lBu00Ptgd1ZN28IYFVhczbfkoYFDVVM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c9620f-763e-4e2b-4098-08df2e57c3af
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:10:59.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUhClFNVymAo92lB1Nocc0DXAosaVlbUI6tCdtnyBX3Penp77d61xbaZVclcabkDcBtNp9PWMLNLiYx4e1va1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 include/linux/pcie-dwc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 097e806c714c..e5693895dbd5 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -38,6 +38,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_LECARC,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_RENESAS,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 
-- 
2.54.0

