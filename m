Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749136;
	b=5FYePchwR1mqySLFDlxwVdR61Ij8sXHOcaVtAymmGhfxoOc9Nz8VgwiCiNiHZhDb3JDQ
	 yPCD0ffeu6EIIkf8ICvThwhYkMJCQ3A8n43shHjYtqppUcZ7ZvjNoClCvjPadatW3Ecqx
	 6E0ZyO9L7TDgiAU0c4A1qqo3RW2KHicudaJ354fLNdamudLO5zE1usQFarC6anxLlOFG0
	 KEPiOJk6gRSLtpzi/6oA/wGauk8pZGJnYFUZtxBAoWWcEqNQACBppFPl4+RZ0beXfmk2U
	 0INujMM+f3VNvDcKErrrNLkl41xu30lJ6WYNlfhEe17qo6tef1T4wH9De9/iNDrE28w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749136;
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
	bh=+SE66CAGC80wVBpwy391ytCH9sxWuAbVkNJ12yGy7w8=;
	b=b7TGkmBha7k8TlXejFpLTy1CJyexKtAL2XFi9ly+ijecCYjYW4xtLBC9WuwH6zEk6FTy
	 PA/DAuckblgFk30CuS+3i5dRlfZJFX+J+sFkZDMUqMYaIJk9BInc7GJnDA+bb4nkiFCED
	 TZec1HPurdgScAYBeAwT1/9JpDHlFLtv8WhXZPtqX6uVugPXBw/4qSQsbOgmQX/Ea2Ysx
	 HJ8ymd45g530JYRWwgoJdLIWegfdky+1enn1PV7tz1j2wlU78bGuxzAQZVYtZg2hVqpMm
	 xEuczE2raWqBVdlmNKXkc6+3wBMKUk2/oUjudKG8kqyn4oJYEUtSfOwl5scXUxtCQHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="jvj4MP/L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C2606A327;
	Fri, 27 Nov 2026 03:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364C2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=jvj4MP/L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e55Qu4ivsDpwpkz+vO/rz4qyoukwX8mrsghA7c4IUC9IJFDNWldKnRgEUU8c/herv9dLICuR2eCszqTSJxRBWKUQatzH3loHKQDskT1h9ThevN+iTnRGM+VAuPYVo6vgzAMM0dMppe9SJCndSaGtRTQaJaByXjpRMA9AxSv1U/P5qbhnpBCk1YBAAf0H8WwD0DrWaT3c0/dG4NiMwyRmJfyMD8UDt/jpujUqSRld0pVKhVKq7T3mSAyWlLalclZifM5CWMooNiqXwtikFYCiIkW4sHeoIgrNv3ddmTFwJZ/P+TCOgw6Fg1qyLH6hW2V9Z9ayzoZ9TpnVqhHEV/XJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SE66CAGC80wVBpwy391ytCH9sxWuAbVkNJ12yGy7w8=;
 b=iXXNJmw0t5K5irgG+w9jPCBWOyo0cr2Dk87DJf+P6gajti8ovZnHsyNzAaE1M7KkcR+wfQqHDvSxy7pRD1I5XbfSIBIPskY9JEhz+IulQzsMVvs5nsRbqm1oEHtBpD73mU3UQ98YXp1xie83+oYf2aORpPjT93C5oQIL5YiWPes2xg7dBCQHtJ0bCsxU+wFXh8/caKMbM0eJxKHxNDAT5g2XK+oawaoJWodgvXt37myyMfLNymGFJzobZC5vNjVYNc5rLOuJvL3sFmSJYOnbT9c+8JboeKNojmdiYPPMcjl4LG8zv2yTFgZkpXCgO9T7M/uxy6QsXdFQsa/MVCUzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SE66CAGC80wVBpwy391ytCH9sxWuAbVkNJ12yGy7w8=;
 b=jvj4MP/LwCPBhxai1OjqvYNJAyX7dhvn7RNQXR1Y0xOKLKW1vT0zRLkutSpbjIvHn06H76ETkAG6M3AHVm36jpHg60GEr+SIumwi5aNbaSICaheW7rdo25sslq3TNvNvZd4x7ycwQpUhDYdLGjrPZ0wAfGo4M6gQRXH1luK3mSo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:11 +0000
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
Subject: [PATCH v6 05/17] PCI: dwc: Export dw_handle_msi_irq()
Date: Fri, 27 Nov 2026 12:11:33 +0900
Message-ID: <20261127031145.2521228-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: a344325e-0c36-429d-d93a-08df4c3439ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102130727099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	e3XOT5kQ70y6jTdIYdAtYpmG/9vC6kBoTWkBXZ2CnaaIbm0oAThpdsLgFjsdMVXE9IAk5thA6OGrWtNlcbCaqPrWs1ZYhred3SQE59fPrIxbXQyIDnLFMGM6+pAOO431/DKdea0i5boKdkHStckaJHV+4BHh67R53VO8SjnToEdkIXp68gqho6OF2WlPOWnQNoZ/wX8AIqZo68+jpSmL/HREeMX2DcU8YTJuQe3L24EnkZv7JGIhF0SP6wCREf8jTtc3i75jOyVAxsl/ALekx8RcYZN5jDT0lanX2PruIA1e4f2WVJqQKCw/BSPDJEoJ7+BhKsCNNKsoLQs5T3tdbtaX8QvIlrOoxe21SPq3W9BGAb+b2Vcicbe79lg3+MKMB4FJgrElANJw8qmr/kceWR+epq1KOqddoEuaZzncJQvz8LIPqXETBdoshSjR9K7g4nFYgfqQmAuS575bZVWAp/KC3ZSmLCRIi8p7MaeyBP4q1/ui/zt+DEui4qEhKVPveOuH9mzMFHPqTYA9A/ThjGNr+meVeuhnzHpaIAccoJRdVVcMo9mjfUauDUpA87vuVX9BFeDPdFxeoBOkG7xgrIeulIiuSN+Zpx1TzDNECXDth0IDjxjjYP1tjXc2nZuwR4YBfEbrGYB1zFTL0mqYntaKwuHMq4PR855HygJXArTy/4gkYrHc1kqxdGSGA17Esm8kb9Sb1VFnyLkPdxNKyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102130727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeH3aWuNHb9XJuRQIjAKczLGP/4rv0BL7QCDcZCNx0ZNDU3rlqgPei/qmjpi?=
 =?us-ascii?Q?LK0r3aigUrii4MkY7OBfKpAK/p0NYsNam0V5kq5tWZAfiZK+mpPRyBvqL4so?=
 =?us-ascii?Q?2eCSoxo+xyKsYk+T6pEkJOAgxJo5HPYsQO8MkOD3NkYmrWFJ7wxBuC/WrH/q?=
 =?us-ascii?Q?DHyXUK6NAepdsqa8s7b87hL6GOp4C2L1YpSKJ5lm/RAlM9XroOgNDahx+gy9?=
 =?us-ascii?Q?2x3dd253kuWoLo+dOmUEO5l1vc9TeIuZ5JwcbHC3HYyRGQuoJ54t+eWmmPPf?=
 =?us-ascii?Q?hGZaIS65eiGLAJRPDpq45ksrjt+37w5c+okzqK7kvokCXKLh+PKVoPf4Uu5i?=
 =?us-ascii?Q?2+vnUypmK3tSlWogF3bWItQSaZKK0MDdi8/jEgI3N52cMJvrpA6v/XwwXpm9?=
 =?us-ascii?Q?7DlxiAqewD1mLNf0A3IO7fYzWI1Jgcb5AHg02Wh5J2tfMtGDy7Y+ZcJV7YNf?=
 =?us-ascii?Q?AmaGvlPNm8LjQXMY0//vcm6JOWzoBps5UlvrjMjsblJbTNojwoLT5sIcgSIW?=
 =?us-ascii?Q?aFVBWMNCi5jTCAeZzIQDefCf4D7c0m8FNQJlCEWxTg6QdADMjHuJk6G88iZm?=
 =?us-ascii?Q?AAl7Q6ZeEbB+fE79JUFeumCj7+4r+eiTvPyc+xe4ztLMYmD9rVnw+YprEZEt?=
 =?us-ascii?Q?TlKosqsK/szeEC6AYtNeEdx9YkvwPwoyH2GlKbZ7ZheLxPHYn2Atex0x8KwH?=
 =?us-ascii?Q?ENdm2vsO7r9aThlttA1RkhiwCQTY1JPAHnTykfODJWzDNLmX46aV35WTWgjC?=
 =?us-ascii?Q?5abRFfDjZRHxLgYDsQRrg2Wx6LyHHzLfkq3D1IotUQR24xOsxVxOzQMlEW7w?=
 =?us-ascii?Q?s+2PbTqFq6MyUCebA9nmDkEZtGukd+v76CzClbXfApGxaR/AJHD28pHB6aUz?=
 =?us-ascii?Q?jCa8r3M1v5M5phJE66nfj5s7NXlOgWuH9NuEDcSUf2glTG5sYnIGBxtlHGg0?=
 =?us-ascii?Q?SK3ARoWHObfU796sWpjvbWZtVcyseCPp6PcEESK9AAU8C2re+Fo77JI/G9gw?=
 =?us-ascii?Q?FDKwdC9TQV4KSAODNCQfegNFxvazVD86AtgqUVQ//mOetkp2oasgbLX2pwUY?=
 =?us-ascii?Q?droIgnh+pu6PzQWnVJxsdFy9db+x3IrWLmBKS1JXhe4G9ZQhFdNnatR/XkW+?=
 =?us-ascii?Q?PD+HYweXqOUEFC0ZWdxs73i63ivzrFz28Sjlo8lOjRe7tVt+V/D0d2I4KGKe?=
 =?us-ascii?Q?WgCIlxi4QjLxvTzHUovHRTojEcLnc6pLfw4PKPukqw8uvoUC9ZNBE4iuDVdU?=
 =?us-ascii?Q?jOQKZ9kHOmsxiMP32bsaiS/OpgAh8Zd8LsIEa2nGqvyZaKHuVtN0hF4jOGob?=
 =?us-ascii?Q?xbpqdmtoSitcgLn063TRzi+wsIFKmCl4p5X1AndX2TGG3zN5YT7KAppFjLcu?=
 =?us-ascii?Q?2U/jyUZ95NSVhSEGqBbf9UYHnfkN6YNL5a56y6/R+aHfdHGE61JXbYyfTvKP?=
 =?us-ascii?Q?NYKa2rswI7ew0TTfM1ZXlftx83QDhN3IZoYSTTBIgcnSE1VF+c21DTm57rME?=
 =?us-ascii?Q?eYGZrmb3QOXGg5QHNPY0fHd6LC1kAKpyVlNmHdd06r44qvnMiYI4Ny60dYwy?=
 =?us-ascii?Q?PKZZtwN3aBdNK93rS1AWmK5edNMsxdbsMc3ble5b3y5H6YLU0vt7Se7M3f3Q?=
 =?us-ascii?Q?n7Vq/0ocO/1rkm+5k8HBTGZMFNYQtD9NXQWq2EuSbyI6k6itgBQeYpLz7Cmw?=
 =?us-ascii?Q?Zn4Li1skb2TbqL2XpjGx99J74tgEC/BGJNmue7UBdvHohwHdov3ws/+TEUUm?=
 =?us-ascii?Q?d7u9dLUGmjqwVzRUaCDxPggQ4+FiU5fDWG/wJqNrXydC5j/UfeWL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a344325e-0c36-429d-d93a-08df4c3439ba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:10.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrW64O5NT7/DYN9xIIwwdlh2bXJgSmQLcjfZ6g2EZ1kjPw4XTzdpRSsoGfRbGos3/Xgb792rxGiwj9K3+pgbjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

Not every platform brings the iMSI-RX interrupt out as a dedicated
line. On spear13xx and keembay it is a status bit in the SoC wrapper's
interrupt register that the glue driver has to check and clear, and on
dra7xx it shares the line with other sources the glue driver has to
demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
not install its chained handler, and service the MSIs from a handler of
their own. spear13xx and keembay call dw_handle_msi_irq() for that.
Both are built-in, so the function was never exported. dra7xx can be a
module and has an MSI loop of its own.

Export the function so that modular glue drivers can use it as well.
The pcie-rcar-gen4 driver, where both situations apply, is the first user.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 869a39107a81..025103312991 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			generic_handle_demux_domain_irq(pp->msi_irq_domain, irq_off + pos);
 	}
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 /* Chained MSI interrupt service routine */
 static void dw_chained_msi_isr(struct irq_desc *desc)
-- 
2.54.0

