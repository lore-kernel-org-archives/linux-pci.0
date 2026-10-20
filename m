Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465872;
	b=stRCkW0K2tr2ONHXHxy1KSc+pDX8lqPHzKNBwBonrTqcBIMGJpqJlnJhPIftiK5kgtdY
	 pf+IvFRBahnrXmNpS5k2WIxDSbAY8Hx+YTkAJR9IqLNS3uj3Ed/E5q3Swb7jNncfhLX06
	 Sn4LfL/Etpy1huofTaEeMGEJXGwcxJWa9mT0gU2+04jRDy8SGdlEZI1iRyuNMvhnXnEUZ
	 oO70kMTQA/pZAmjzLCpFF0+eyrqJUrTfitOAPYCqXXhD3fyiV3xlPOL9JfGG0NNgtcjMO
	 dDb8usMCFzyp6Yl34ajUgMNZdzlDV4Y1wOA5huKwh75/IHMEU4BAprvLINh3P1qpMtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465872;
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
	bh=cnJngJ8QpLfjtoNFbUehTGHVIpXYC2zYipnQATi+iHQ=;
	b=LJQr3j0NAtt0IiC/25q/1iXSiCIUFhHbAA2W8IY2gG2eeJXOdgGH/GHSNqBEpBl+OM9D
	 HD6p9jFMdYBAeCs/5V3mmD5JKghnz73lcb0ZTq/V74l0SRlLYdz9nVnq+kOS+l0Wxdsl4
	 hW4MMtN1vNxE8AoKWIqHkArapcRZGQW3/KBJ8MuiQpSdxSEha7qviacNq71tqaOkawVg3
	 GN7axP3Itz/CqobojvBFOzQ/DCnnQcQ8zl3Z43lTNNnndI4vY7C0Ls1RNfvDDR47ZooXE
	 ZFYzSq7BHdHQb/IFOxZsmfu1HPUFoSeck0ger9d6halV4IG0fKK0fnbz3FlPaS2AmhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=C0+bYtm9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4660A4AD7;
	Tue, 20 Oct 2026 03:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF4660A4AD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=C0+bYtm9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqxoSbV1dW8Oqy+rHjcpv90F6zmqsmSeqAY7h8HtGONpt/Y9234H/49Yn42MPg3zt7HhlHGILwIJ1a2GHcTF1PAjflAeHrr2iNtTJQf7ICfGelxxtKc7D9Q0dgPWNpsopFa6NBM2Xt6MW+1z+xB12UWMwgayptpAcfErov7tBELQGAG7PNAaJd2i/PsynbmGBAxI9XPAckWd96PUJ+RjyO5eTZlSsWZwCM1bWseo2rNMpVB4kBu8a7Mgw1hVi1c2fJVhbuk/xHK8IW9n8aMsDLZ1nkiaYYV/HRY0mtK2RZ+BwzJ3OcuCa2HP7UJLs0f6oiyi4PVzjTdIEXtqoPOvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnJngJ8QpLfjtoNFbUehTGHVIpXYC2zYipnQATi+iHQ=;
 b=RO2du5lAO3dCrFLt0s7ea3leHV2T2RlTgSiCcbQtuxzxkiPj3SRDfSV87zFhEBp8LVEJkdsh/+Nm8XZQk+6fFEb8RxpG56LqSrDnYJrwE2JmGDYCMhBjUQzu1cotTrb/ct1HURcp1wzAR+Cnd02yKqdj0k6PlqIuZLhhKnfwX6HH1qyqWz1KHDoxhD0gbYU7SP4lNxFnxisNZjMuEKceqlwbahdWQV8vdNRI3NPoG+AXhipK2OOP/kimk6zKQV1Acmfej87jE4ZCLNiChkgaEpWwFchHgn9yxI4MSZ18FPyRbF5mCC0lbM66jjna8TVUHd3yVN2PxDNZ+7kA1r0zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnJngJ8QpLfjtoNFbUehTGHVIpXYC2zYipnQATi+iHQ=;
 b=C0+bYtm9pZVhj60cBwKHsdUx7Q6cH9N3uWYUXxnASIYumRMB+rxMRHgI1YxyBT8V0wPjcCV/QpOgvS7ae5PFH/KI10uD5t9EsxTijkdf79ZUqq3fW8Mv4KWlJcUSDun5JHd1x3h5GYZvJPMcJvzNHJhLkSVxcf+J4FA1ELUaUi8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:10 +0000
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
Subject: [PATCH v5 13/17] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Tue, 20 Oct 2026 12:10:45 +0900
Message-ID: <20261020031049.969895-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 147e3b92-0bf0-42bc-7296-08df2e57ca71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|5023799004|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dms32hdBD28O9laQZVE27fjZBXkre8LQnULRQS/wOeYrNGnUp3qENgqL2PiTat3WhIRVz2SncdSJuImWUr7O/ko/IciG747NleR95thagxBQgtWJMhBcjdN1+NXIuYL53Ipm3Ff888krb6saUwSaDwKtV+vnGbAQTIjv7V3s15YfV9Pts0DO/W0dqmPeWz3HBtpond4r5BnHGNLhT/mrHn76FMK0jQ6XjFAFmBNj2Hycd2SJDegUwtUQX60ljt8e0Ivj6e5hLmfAydOf/N0lGCrHp0Y3q8sbOvqsWENAXvlCv7FHCnFeM9p4bCg6e3+XPccoJ8C9/IQcY5l0pJICqn6Rp6X0YLJSb/S4Omi5yDnfc0a2c47bbz9Ni7ckABrShqZpNOSN32pHQg5MChriAe6cPUuhURUf5y/8/ZPrErE47ug+8VQo0/CwFa0J2a/IFW4XYNxiHtG6VfcOZ1GaUNpOjZOiUbyD2NV4E0RbX4djkb3SyIPEQ3fHHH+hi6+tIw/DUBZbhMCszmgaXSLNJ/SAc9YkCVq2/PUAOeyw1EnZERG9lyIJGbY+h0q0MYLvxQiL+OzxjQqR4+EUUVY3IFixLylfj7dK7vubWcx2vo/kvw84m6hI6mpN+IvnAQjqzTCzUTV9EVdA7L5cZXRKgdOezzU75jJHrSzU+NFlJAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(5023799004)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I74mFUIzM7canl1ABZ8bRwwAUQK8tn1LexSpoaKgV38/2n8/mtafThorizLV?=
 =?us-ascii?Q?Ijf3v6TNSnbr+YOcbjtiyXBIiWQX0COvOn10f2SvGKZ/DeVBAG2yZv8y4tI8?=
 =?us-ascii?Q?UNW7N8H2RhOkVw15Pw37wP53lU3e2A7/0me77NOqS4uiZ07yvi8CqkSfsiHv?=
 =?us-ascii?Q?3ZQNoXiydzoHzB5XAg6eDBz0IL3F+IIFXzgkzBfOqQ7kHN2K5dZYsEgUmKuR?=
 =?us-ascii?Q?V4DJkrrYvLdb0iWeT0ah1ffAMb5vjoElUOOZu4Oqv3xhLtWm/fb05mZ8gMpB?=
 =?us-ascii?Q?IbEqza9nulImvyE5VJ4hwFYUP/9KWZyMlEdd34jTULiAePDQVLFnc7NfWOn1?=
 =?us-ascii?Q?fIlRJjgtTDvO2x9WpSaqYMIhgv91ROXRYsTvylnCWvlgeVEpuYzFdyN5ckY7?=
 =?us-ascii?Q?iwOKmd4tMGfL8pouJOiwvTjgUeBeNj7NCOwF4YCk+MjWYP3dsTsXmovlVxy1?=
 =?us-ascii?Q?L5P/+1ZALjC+Ghlrl8UBRzzLL7YDy9+2ynOT5tWqcT7FLEeJOAly9+dCJ2pl?=
 =?us-ascii?Q?KrSpkrhyp+o7jA/jDM9hY8mlLdAJSpG71TDK2CFGauvTEsQAgDOhcxloFFD4?=
 =?us-ascii?Q?IqDCWJrUfrFMxVG9GyPJ0nZakaw3+7LQM+3a8C5TpCj5EnoKd9Iwo93jsHXm?=
 =?us-ascii?Q?VbhARtrtUCiGFld+r9jvgp8UDpBztcUuN7ReYhZHSP+VOwuoFEDIjdroxqna?=
 =?us-ascii?Q?IP+comy8V0L665jQeWC9S3QwUi19LgVicoh6v1BgMpyLvmYzI2seDdxnn00t?=
 =?us-ascii?Q?x9oPDgwoVS5kkLfPgoKxTaK1xZZJunCiRf5zPQJGPF1Ybq/KGTd3UEZvf8d/?=
 =?us-ascii?Q?WoWDlme9MhvD4rFwyBW8pJdW0W+11otTGBKLpWiVDUvPKtroGDaW149SNUbs?=
 =?us-ascii?Q?CjBXJ69c3R2Hq9UTmxhSZz2P82AT3QmoqGSFr4l8/kIST3Ef3I1LABDvL1x6?=
 =?us-ascii?Q?1OziGUlbFYmh33+1vKc87hf0tkZO86kUMhGVE6BQflDh3mdESUL8PNNhY9v1?=
 =?us-ascii?Q?KimK719AYdt1FyZ5vLfd4Bicf6Aub8Ri6aj6f+5ll45E8jmEmzTkwRRAy/vN?=
 =?us-ascii?Q?0VwtDGADuO4Fa6qv1gWpGVxNeHSLOREDGYaVzobyiGotUsTe4qlJ2LEgACVK?=
 =?us-ascii?Q?1ED4kk0JX4S26FwzOt0xX77G+Q6ZfywrSgXM4eKfQm/6ZJ4sBwnuqbQ88LN/?=
 =?us-ascii?Q?0WN7CRBxh4P357vfyEzQhDrKreqQ6KBYTSRKcpfTzvWv2IHOsWT7vvjOa5An?=
 =?us-ascii?Q?VQY+0n0Ew4kAp/58HzsNUESs/xjTsuffAOpNx554OFdCZx2YYmksZSnrmufv?=
 =?us-ascii?Q?YVvWHUUIoaixt9PfeCf5UFrbHnVI0YZ/ESsqmtMNdrgB2VIHh+NralTde9/Y?=
 =?us-ascii?Q?K4JekqJGbYyz+2VE2Bfa1Nd4XxFyqlz1JQqEYQFH2mMmp//o/obPWHZDXZ8G?=
 =?us-ascii?Q?CcJVNZcUskNQXxIQsMliKDuGvFF0OcZiNFuQR1buhwdcVRIUHB19ons1rWyR?=
 =?us-ascii?Q?HhrKLWPjiIquB3Lf4SDU//9F4yxEPEsgTLkgBUjjp1IXISWfXyCRNNl+y23S?=
 =?us-ascii?Q?V9xhrPCRsaVX0x56TuqaGLBA903QDwTeAvs24/fmFflrt2uV9t7wJgzPdfhy?=
 =?us-ascii?Q?K+V3y+caZgexopPAy/sho9Fc80hDfM6hM0xh02RWhz//zl5a493SNbNWnt5N?=
 =?us-ascii?Q?k/q+27Rfs71YKClW4DjupbkQp+6Rkc1liN9lrbFjpvY0Y7hWAsEoxjJJbh4R?=
 =?us-ascii?Q?pgHZt26HY1TVGQ3qKbuw5aejDS3QSaYFuxcOG0wr4NDg2AB1Z1tr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 147e3b92-0bf0-42bc-7296-08df2e57ca71
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:10.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44CJgBAB+Q/+N99RMa6y9fJJcAVU1YkMm6uZBevhIIGGT0Z/I/j1FKNo/inEKyNr08xbp2rYNhnkoG7AYoIyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
intreq_pcim_lperr, and PME and bandwidth notifications to
intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
Root Port MSI capabilities are already hidden, but its INTx maps to
intreq_pcim_sub. Note that even before this driver took over the IRQ
with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
request it, as the DWC core used that IRQ for its chained MSI handler.
In either case, iMSI-RX or an external MSI controller, Root Port
interrupts are not delivered to the port services.

Hide the Root Port MSI/MSI-X capabilities so the port services use
INTx regardless of the MSI controller. Do this in the R-Car host setup,
which also runs on reset and resume. Use a virtual IRQ to deliver
notifications from separate platform IRQs to the standard handlers.
Route AER from the optional "aer" interrupt. DTs without it remain
supported, but Root Port AER stays unavailable.

The APP block may still receive MSI-form notifications because hiding
the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
these alongside the INTx-form level signals. Clear the MSI-form latch
before the AER handler clears Root Error Status, so a late APP clear
does not erase a new notification.

Check for reset requests before dispatch: on S4, DBI accesses from
the port services can hang the host immediately after link down.

The next patch also feeds PME and bandwidth notifications from "msi"
into this IRQ, so both parents may dispatch concurrently.
handle_level_irq() calls irq_ack() before checking whether it can run
the handlers. Keep the APP latches set while the IRQ is in progress or
disabled, so the level parents can retry through the reset checks.
This avoids losing notifications without a raw lock around port
services that take regular spinlocks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Hide the Root Port MSI/MSI-X capabilities in host_setup() instead of
    adding a no_rp_msi flag to the DWC core. (Shawn)
    https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
    I did not carry Marek's Reviewed-by tag over due to the change.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 213 +++++++++++++++++++-
 1 file changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 50d4b74e63b0..b0440f2c5329 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -14,10 +14,12 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -59,6 +61,11 @@
 #define SMLH_LINK_UP		BIT(7)
 #define RDLH_LINK_UP		BIT(6)
 
+/* Root Port notifications routed to intreq_pcim_lperr ("aer") */
+#define AER_RC_ERR_MSI		BIT(29)
+#define AER_RC_ERR_INT		BIT(27)
+#define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
+
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
@@ -68,6 +75,7 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
+#define RP_LATCHED_MASK		AER_RC_ERR_MSI
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -133,6 +141,12 @@ struct rcar_gen4_pcie {
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
 	bool rp_events_armed;
+	/* Virtual Root Port INTx shared by the port services */
+	struct irq_domain *rp_irq_domain;
+	unsigned int rp_irq;
+	bool rp_irq_enabled;
+	/* intreq_pcim_lperr ("aer"): Root Port AER notifications, optional */
+	int aer_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -565,7 +579,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -573,6 +587,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
+	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
+		val |= RP_AER_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -675,6 +691,15 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 	return rcar->reinit_pending;
 }
 
+static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
+{
+	/* Recheck reset requests after the parent's status read. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return;
+
+	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
+}
+
 static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
 {
 	struct rcar_gen4_pcie *rcar =
@@ -769,6 +794,162 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
 	cancel_work_sync(&rcar->link_down_work);
 }
 
+static void rcar_gen4_pcie_rp_irq_mask(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_irq_enabled = false;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_irq_unmask(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_irq_enabled = true;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_irq_ack(struct irq_data *d)
+{
+	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * handle_level_irq() may skip the handlers after calling irq_ack().
+	 * Keep notifications latched if the IRQ is disabled or in progress,
+	 * so they raise a parent IRQ again after unmasking. The descriptor
+	 * lock serializes this check with IRQD_IRQ_INPROGRESS.
+	 */
+	if (irqd_irq_disabled(d) || irqd_irq_inprogress(d))
+		return;
+
+	/* Clear APP latches before the service clears Root Error Status. */
+	writel(RP_LATCHED_MASK, rcar->base + PCIEINTSTS0CLR);
+}
+
+static const struct irq_chip rcar_gen4_pcie_rp_irq_chip = {
+	.name = "rcar-gen4-rp",
+	.irq_mask = rcar_gen4_pcie_rp_irq_mask,
+	.irq_unmask = rcar_gen4_pcie_rp_irq_unmask,
+	.irq_ack = rcar_gen4_pcie_rp_irq_ack,
+};
+
+static int rcar_gen4_pcie_rp_irq_map(struct irq_domain *domain,
+				     unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &rcar_gen4_pcie_rp_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rcar_gen4_pcie_rp_irq_domain_ops = {
+	.map = rcar_gen4_pcie_rp_irq_map,
+};
+
+static irqreturn_t rcar_gen4_pcie_aer_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+	u32 status;
+
+	/* The line also fires on link down; reset requests come first. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN);
+	if (!(status & RP_AER_MASK))
+		return IRQ_NONE;
+
+	rcar_gen4_pcie_rp_irq_dispatch(rcar);
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_gen4_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+
+	/* Downstream devices use standard OF INTx mapping */
+	if (!pci_is_root_bus(dev->bus))
+		return of_irq_parse_and_map_pci(dev, slot, pin);
+
+	/* Root Port uses the virtual IRQ (always INTA) */
+	return rcar->rp_irq;
+}
+
+static int rcar_gen4_pcie_rp_irq_init(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	struct fwnode_handle *fwnode;
+	int irq, ret;
+
+	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
+	if (irq == -ENXIO)
+		irq = 0;	/* old DT: Root Port AER stays unavailable */
+	else if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
+
+	fwnode = irq_domain_alloc_named_fwnode(dev_name(dev));
+	if (!fwnode)
+		return -ENOMEM;
+
+	rcar->rp_irq_domain = irq_domain_create_linear(fwnode, 1,
+						       &rcar_gen4_pcie_rp_irq_domain_ops,
+						       rcar);
+	if (!rcar->rp_irq_domain) {
+		ret = -ENOMEM;
+		goto err_free_fwnode;
+	}
+
+	rcar->rp_irq = irq_create_mapping(rcar->rp_irq_domain, 0);
+	if (!rcar->rp_irq) {
+		ret = -ENOMEM;
+		goto err_remove_domain;
+	}
+
+	if (irq) {
+		/*
+		 * Dispatch the child IRQ in hard IRQ context, including on
+		 * PREEMPT_RT. Enable it together with the "msi" parent IRQ.
+		 */
+		ret = devm_request_irq(dev, irq, rcar_gen4_pcie_aer_irq_handler,
+				       IRQF_NO_THREAD | IRQF_NO_AUTOEN,
+				       "rcar-gen4-pcie-aer", rcar);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
+			goto err_dispose_mapping;
+		}
+		rcar->aer_irq = irq;
+	}
+
+	return 0;
+
+err_dispose_mapping:
+	irq_dispose_mapping(rcar->rp_irq);
+err_remove_domain:
+	irq_domain_remove(rcar->rp_irq_domain);
+err_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+
+	return ret;
+}
+
+static void rcar_gen4_pcie_rp_irq_deinit(struct rcar_gen4_pcie *rcar)
+{
+	struct fwnode_handle *fwnode = rcar->rp_irq_domain->fwnode;
+
+	irq_dispose_mapping(rcar->rp_irq);
+	irq_domain_remove(rcar->rp_irq_domain);
+	irq_domain_free_fwnode(fwnode);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -854,6 +1035,13 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	/*
+	 * Root Port MSIs are not delivered. Hide the MSI/MSI-X capabilities
+	 * so port services use the virtual INTx IRQ.
+	 */
+	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSI);
+	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSIX);
+
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
 	rcar_gen4_pcie_host_perst_assert(pp, false);
 
@@ -869,6 +1057,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 
 	/* The MSI status lives in DBI; keep the handler away during the reset. */
 	disable_irq(rcar->msi_irq);
+	if (rcar->aer_irq > 0)
+		disable_irq(rcar->aer_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -879,6 +1069,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
 
+	if (rcar->aer_irq > 0)
+		enable_irq(rcar->aer_irq);
 	enable_irq(rcar->msi_irq);
 }
 
@@ -945,6 +1137,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+		/* Route Root Port INTx to the virtual IRQ. */
+		pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
 	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
@@ -1003,10 +1197,14 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	raw_spin_lock_init(&rcar->app_lock);
 	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
-	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	ret = rcar_gen4_pcie_rp_irq_init(rcar);
 	if (ret)
 		return ret;
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		goto err_rp_irq_deinit;
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
@@ -1018,7 +1216,15 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	pp->msi_irq[0] = -ENODEV;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
-	return dw_pcie_host_init(pp);
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		goto err_rp_irq_deinit;
+
+	return 0;
+
+err_rp_irq_deinit:
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
+	return ret;
 }
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -1026,6 +1232,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	/* Cancel recovery work before removing the PCI bus */
 	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
 }
 
 /* Endpoint mode */
-- 
2.54.0

