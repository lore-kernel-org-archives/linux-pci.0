Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749145;
	b=jt2DzTQ8w/91AFPW6KQgKWcPtBtvW2RQ3LkgAF9e9PPT3J047owIVr3stJ5KcnCtKwdg
	 FesKem2FDP9noftUASwLHc8frFNpUB/zc3wdxZrQoUN03BAx82Z4rmJr6VQuu2U1y9y6h
	 Jjd+PkrUlNHmE8qa5VqJAOMqkp430F2CkIToSv6Pg7rNDIBekMjwACHc/JlUKel37ZX+v
	 cJLqyc5s7YLLxE1HPtNSE51pPB08sEBK+TuisKuuLJqfeRkUFESfz6GzEIaz9crBuVC6R
	 QJyc3ge0ellrwSn+XtEr14DTSGtZb5VCSUa/f16V6SiYgqDw76EPMm8bceRQ/WoJ5mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749145;
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
	bh=lWPllDV9T8Yy2iuFIjj/5so6JLU4ClbLFlLavZkshJc=;
	b=Kpx9B4dfvva5DNNu1yFUEhG/sIudqR+tLulUPrE6hnhJSOUWDMu7KFCa4TdTLy9sF7wB
	 QpZmKG3An7ppHpzAFNB8fuhbXFMtH2esOmhhiykjx1cSQzVfGcbT1Uul8cw83SlhE3Hb7
	 G72T8EQUIRgLKEn+Ygdy/gTLuLfgo9Ww/zzTcr2Sa2ihnN17ACMqW/SOS2kWn81LSOiSU
	 QR1jEwe05onIqF9B8lgMyhLYLmFqQt8s/SdtPRdE58w6mYsrnNB/k2QFIgS5JWSTp1+up
	 qt1LTGE2vNoZyDesdPcY9kNeTqlkroz/JAi745OFZYr/rV1Y9DUMPLrzYi/VV8A4jvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lBX6KGbQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDF60A2631;
	Fri, 27 Nov 2026 03:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CDF60A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=lBX6KGbQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2s3GurNXq7OFnUfiCAs3WKaf10A0zccMx7abFk48DBh+gImssiGa26Srji0DeOBwZHNKlNLMCRPH+2UkXJEpS3tc9gF+4fN5+w6zqB6Lp5kU5jZu2SWT6VFbP3VFODvb0GpZVh/+ow9Pc7s+Bf3M6tRGqh/k2YUCXDAiRSBTe5CSq6yDdQtjv9a4q3hjxVVyqoQfcGUJBSn4JMOwORfihtyUQ4wVoR6Gi1WQNbhFeIVpYkhtZZnbdsRyXlhiudID2CFQQpW4AxefwYnH0TQXGvXgcMGWV7YRINNL3I+BPra/Eyb7rnjwnD8wpkbvQRlD3lcbhgnkaNMvrmOLS9lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWPllDV9T8Yy2iuFIjj/5so6JLU4ClbLFlLavZkshJc=;
 b=fvPcnXmCpcsiZaAn/eOMSN4N86TTma7HjouxL2ADBT1rAhJLe53Iq98qV4ldOL8TH94dzSaiEaFLEcpj+LpemwxgO/aD9ctIkCt9j+k7G04zMwAzs5qk2+Ajv8kDQB79v2yB+By599O1hbNVcByVrLSDuq3kcyfbcsbm844lsMhFZomFghSeEBE8ObUvaOgNIx19RHfmQTIM8TxDpac5bh55deI3kJTThiHIgNFfB0LvphlJXrZivadnO6VvqT5wqYkM9tAXThWZw4uRSloaNez2XZbuVQ302SCcZZ9A3z2KBuM29djxjLngq0SH2w7UErYg75TMzLQeNp0nMtD5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWPllDV9T8Yy2iuFIjj/5so6JLU4ClbLFlLavZkshJc=;
 b=lBX6KGbQGbZZeF6XTOH5T+DaXfK6R6Twi4HQ+BiMDUP8E0lXgfmBz7Wbs7cYEW5KAA3idNkb277BNTSmJIvy01YglLcXctVw0/7IrVWlvApPoLqSSghnzp7Z+pToB3qoRdKU1VQOHfbc6Rrj/YmA/YSqsXV3SEUce6YTB7rF0PQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:22 +0000
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
Subject: [PATCH v6 11/17] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Date: Fri, 27 Nov 2026 12:11:39 +0900
Message-ID: <20261127031145.2521228-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: c308bbfa-4d5c-4f82-9e32-08df4c343ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|5023799004|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	y+hQOvdiY3xo1AEmA0naUp85ldm7/THlcSIDJpj/X93PPhWGo4B9n/Uah6TuZwQD6maYCmljA8OEijEztFVD+V5tIbAuDTroYhjek631ZGfABPRi1wG05A6Qc8rkYAYa1labSnz/Ei1bpG9cJ7ET6XOfLWVBT0dv1i7d70sLambPblJSwmRzb+2Wz85Iupm3vf4LEU5l+Y3UtHunohtdYmdsPHcUEmPFcmFeRWqToZETkH4DDXv4I51OzF0iuK6m1BU3NOIUk1JysVS4KE2c6WlsjMihrY+TR0D5+67tQ6qwSZU0jnZaw4ECDvRUuJUmuivxvyH9I/awm3WZGkEH/iXRcpifWTS7MB4TrsSB9h9RQ2DJ7i39XW4NcDe93GeQgG0qK71QuEFLnIYRnByRwoohV/uoc0jQM/kUXOREDPgFrEoC+vAdlbrhtIGINaQcQoqMyDlRqVNxcShIC6ZGKMrtritXYESy3d6YFdUabI+PZT9bLDMisH8uRK9SAjPu4jHg+d+MAgwQKXQ/HLiku685UsHEs1PMFHVcFRLFwXXiWmPaL752CZzLPFChdJ02z4s4oVd24e3XFNYjfuIw/ZQEBKlogt61wmO8Mf2CnCAyEzZAryiQr/A21DXlUdaUKZrIZp16KXu000cid1m8+z3WxTggeAvvfiGjXmCNLrA4cLXY6irCR/mAP+K557Swj5VjOmpa2XTpfuqOQGgvww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(5023799004)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmpkheF5b5DNeWXTUdagN2XPTqHQshwCncniPMEDFNfHJBiit8GudKwjtP6d?=
 =?us-ascii?Q?2MEymza6BTG/yA6OENSgNpocbEN8R68Linin3Hw1wAeqGCoJE9G//qVAQhW/?=
 =?us-ascii?Q?Rbpz2epdPh8r5C228AyIoWIvp2LhOGytm9o10btoKbSm5BWCBMzBpznLOb/A?=
 =?us-ascii?Q?SvxnL24c7vHCgvrk1a2LkeatblOBBtMQ0tDzium5CZbp2/xs8PiEGGot+Bbd?=
 =?us-ascii?Q?R9D8dMQ6aY2ms16UhSt/72x48fZSKZOk6goVd7OfRCoV/liCJtl1hMwUuzmA?=
 =?us-ascii?Q?F1G35T2VqneEUXaWAH9kCpSoWzs6XwF43Vn4unLbZ7cJjcs3m0a9tMDp+gBy?=
 =?us-ascii?Q?GlwZunI5E13kgwZW5SYX1BySgj+T2Bxf45jJWRxe2MnD8wzTXZtZEF4FaIgP?=
 =?us-ascii?Q?6MWaheSCFpbFZ1laRJWtbz0QDCQIwMnCLGb5aKKvZckWEHXfcq1Tj0A/P2vV?=
 =?us-ascii?Q?dwMuyDCZOO69ho6nTPICk1iIoUr9w+yhWgIsavdDeiKDdiZwSzkHXA/KnzmY?=
 =?us-ascii?Q?t0mBGi6hPRjXIkvQbi8+7OOjd/znKB7J15vVQuLdqHA69jWvE5v+DolgOInT?=
 =?us-ascii?Q?TutY86SyBrXmslL8fCQEDmXvlrdow6TsS8HmLoA4R/TF5L6n7disHx2MuQhW?=
 =?us-ascii?Q?YoHhVWg6HlWeWVpVrc+F2kCoZ6Wg24Z6r47Qctboij8C2OFWpJUYTpirXkle?=
 =?us-ascii?Q?8PeHd1rBth4Qs/Bdgs2m5HeI6bVmq9vdr7YSdoIxsICo/IQDkrYjli0S/d3L?=
 =?us-ascii?Q?QGGWjE1+xmuQRVw9Sw5fe4SF3w9nW3nvnN9sLSZQaJ59jrqjMaOSHWaL5Nt0?=
 =?us-ascii?Q?K4OSDhmcV/QcJGRB/qknTuk9BcxRItL8C16SVo0lwwtwYppaNagM9pvtVK40?=
 =?us-ascii?Q?vvGG8kIoYlTnTr6Szv9SdsBeA9UIvu/N5Bgh+sdJO0/431bwG1GuZNGl9Otd?=
 =?us-ascii?Q?JQoeMMDEk2eB3VtMnMzhW4lRcFFMV7OAG6N7oUKwZwQtyP1SGlCp1c0EZKJU?=
 =?us-ascii?Q?kzNGI+ScIPoFA28avDwiqUcf7e6k3ULbxKXf1qKLZ55fQkvLc0tN9+DObb6p?=
 =?us-ascii?Q?3hl/j2rtvTpVXaSX7YBbW8U4hDsUH0w1nP7LjN2RDisdB0j+8q5uXZKK5uN4?=
 =?us-ascii?Q?HRxeUpMkdjltuobhx53UbKf/PIlMZ5QwuKxaHQE/6r4on0+tuhe0aW8tOO4R?=
 =?us-ascii?Q?DYW5NC2KagVIrUe+XY5msWZzoIq9xknZKx56dSQITrP91ZNll33SUHdArkOt?=
 =?us-ascii?Q?yUhugFxFbpeWpYcTyhqJLOiR77fptpXnRK/Moh15G2LXUfmBmpH3nv3QY0en?=
 =?us-ascii?Q?TCUmJRX+54swhQ9Zy/jl3hQ+I4s4Xi+qInz7mxxKEX8w+wN1lvAlaQ8xh1q+?=
 =?us-ascii?Q?+2aOtfBf+sZTVYMpfPMu0FBiLOsEXToTrDxTZfQn6tO5HrWItoXdf1NfgyFs?=
 =?us-ascii?Q?kiRNRtzupwwPM+PcgmDlp/XPNwb0R5qELywVkbDgkL9u4ps/A86Xa9URijuO?=
 =?us-ascii?Q?2ugHMHsdhw7onG0J2Y0pKLvo8LB+W9HUFf5HrEwJKsiyNbj01ECr+46/3Z+8?=
 =?us-ascii?Q?dhjfxDivvBbeb6H5PFVy2reCXmBiWMvNmmO1BkavYd9Mg+9/NUw8CCaSxFu5?=
 =?us-ascii?Q?/DbOZE3S1JeeaQNuD4IFvSFYc2GvN35M7YoUy7ojH9j5GxA72NeAadr0UlJE?=
 =?us-ascii?Q?JrWU1bZ18EkEkiURr082l9dBKCnckiavPBanNTMLCHC4VTs1yszTZ8Su+waz?=
 =?us-ascii?Q?UGXR5JmF/gEsZejq9skvc5TuwgJxH5xtoFxJpgClpoqPbEs9rb8k?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c308bbfa-4d5c-4f82-9e32-08df4c343ef0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:18.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sypDiIFB/KIUEWfvR58XkOeJVaUrpf/344068IinMzU1oYtupFZBcjrkR/r+mjN2OdYUU+jzM974UKMh+veU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
integrated MSI receiver: the controller's reset requests and the Root
Port's PME and bandwidth notifications are signalled on the same line,
and the following patches need to handle them. With the DesignWare core
owning the line through its chained handler, the driver would have to
hook into that handler when iMSI-RX is used and request the line itself
otherwise.

Instead, request the interrupt in the driver in all configurations and
set pp->msi_irq[0] to -ENODEV so the core does not install its chained
handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
the MSIs through dw_handle_msi_irq() when the APP block reports
msi_ctrl_int, in hard IRQ context like the chained handler did. With an
external MSI controller or pci=nomsi the iMSI-RX is not set up, so keep
msi_ctrl_int masked, and the handler has nothing to do there yet.

Request the interrupt in probe with IRQF_NO_AUTOEN and enable it at the
end of .init(), before endpoint drivers can use MSIs from their probe.
Disable it in .deinit(), before the controller is powered down, and
around a Root Port reset, as the handler reads the controller registers.
Suspend and resume go through the same two callbacks.

The DT routes downstream INTx to the same line, but the driver has never
supported INTx (no INTx domain, INTx enables never set), so requesting
the line exclusively takes nothing away.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 79 ++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 4277ddcffccd..b54acdd386f1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -115,6 +115,8 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	int msi_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -540,13 +542,14 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
-	if (!rcar->reinit_pending && pci_msi_enabled())
+	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 }
@@ -612,6 +615,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
+ * notifications, so the driver owns it instead of the DesignWare core (see
+ * pp->msi_irq[0]) and demultiplexes the MSIs itself.
+ */
+static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+	u32 status;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN);
+	if (!(status & MSI_CTRL_INT))
+		return IRQ_NONE;
+
+	dw_handle_msi_irq(&rcar->dw.pp);
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	int irq, ret;
+
+	irq = platform_get_irq_byname(rcar->pdev, "msi");
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * Child IRQ flow handlers require local IRQs to be disabled. Keep this
+	 * handler in hard IRQ context on PREEMPT_RT.
+	 *
+	 * Keep the IRQ registered for the lifetime of the driver. .init()
+	 * enables it once the controller is set up, and .deinit() disables it
+	 * before the controller is powered down.
+	 */
+	ret = devm_request_irq(dev, irq, rcar_gen4_pcie_msi_irq_handler,
+			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, dev_name(dev),
+			       rcar);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request \"msi\" IRQ\n");
+
+	rcar->msi_irq = irq;
+
+	return 0;
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -709,6 +760,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 		rcar->reinit_pending = true;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	/* The MSI status lives in DBI; keep the handler away during the reset. */
+	disable_irq(rcar->msi_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -718,6 +772,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar->reinit_pending = !recovered;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	enable_irq(rcar->msi_irq);
 }
 
 /*
@@ -795,6 +851,13 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err;
 
+	/*
+	 * Undo IRQF_NO_AUTOEN at probe, or the disable in .deinit() on resume.
+	 * The iMSI-RX interrupts stay disabled until dw_pcie_setup_rc(), so the
+	 * handler cannot run before the MSI domain exists.
+	 */
+	rcar_gen4_pcie_resume_irqs(rcar, true);
+
 	return 0;
 
 err:
@@ -807,6 +870,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Stop the handler before asserting reset and disabling the clocks. */
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
@@ -819,15 +885,26 @@ static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
 	raw_spin_lock_init(&rcar->app_lock);
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		return ret;
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
+	/*
+	 * intreq_pcim_sub ("msi") is shared with other controller
+	 * notifications: the driver requests it itself and demultiplexes the
+	 * iMSI-RX MSIs from its own handler.
+	 */
+	pp->msi_irq[0] = -ENODEV;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
 	return dw_pcie_host_init(pp);
-- 
2.54.0

