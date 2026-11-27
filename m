Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749145;
	b=g4LR27zyR5Bq3c3ffeNY7zBBZI4/aFHH3sPmqQ9O3oMoqn/cCpyQaPAh2fgeEqGGpTTF
	 TGOJ6JgIwWbseyb33Rve7iMWlKS6y0KQrfvYGCD8J8L5JmYN9ufDwl6CSVDKOOSg77j7V
	 7bInUuCJoENNGHOvQfq4eVPPzmycZA5STfprGf3Il0H/lx1hH2oFI31TUDKbCVr1Wp5x7
	 OWlVvebFDplZ3UMHheK0UIlN7xKqpOYVEAFv3d3sWc1KqdEj0bUznDWafaZeG7gZ/HT0o
	 4q1adwv1TBkL2D4kwBZx7kIe1XuFrTr9qAQXWrvpcIiZi4DK9uD+KF2MDQpoWPdSwug==
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
	bh=NWk0pdpTjYpeklCDyZqmKOSBJsrQ8lP4Xveu/fno3U4=;
	b=xx6gB6bhYQ3shHsAqtv/cJ/KzIsBK4yP7Q7rw2n6+bomY4CRqzHty3DkVa/KcJYPqoSp
	 zLNRrI0O7Dfjc0i6V0uKpvsezGNs4udvA26E52kUMf9aGWHgPnDN4D/vIy5vMP/0pq89l
	 J2OUxJp2m2IxQTySU7hpDtsZ9OFGSjLfY7U6k1S6055bSULQxfcItbTrUbC1JQvpYWC12
	 0ZrfLlDcjHAHrNfcgf9HYujLUv0XEWs35BISq4tA2w+Qz3C9yEonTvTH9u0AHtqy98LDe
	 3gGU0+uLGGAStICZ00paNbp2PRvqm87Z5x3s9AF1YMPQPDD7TdpthjKYA7lz4sU1fKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nmkbT9zl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF72606A69F;
	Fri, 27 Nov 2026 03:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF72606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=nmkbT9zl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWiN3QM7F7V5tbacHbeFRukVhM6bwIOqmxjxfVFTrnI8qgfiURBsRWUxt35bkCP+HgfTHz5OZ+Cjo7Q43v2jflJC+z8vjX5LIN4X2pdxYu9xDp20JU6hd1tRFVbwa8rAsilqFauAoiBTIcHf7aYXT0CgQsNZ0+74EFccbna3z4C+vtAl0N5DoWOJiHGUKlWWO4QLQ6KpcaIcP2qT3KUQID4d0akJkNFQAwftng24eDZlSXWjmRWhgDDr3schXqBzVyOifD7MuEJXb9j1yIxeYMPJ9VxQI45SVo27VJAXpLD/uSPUVB1i8S576KESJfF8NsqpaEt3GxD/M7UaY617mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWk0pdpTjYpeklCDyZqmKOSBJsrQ8lP4Xveu/fno3U4=;
 b=fJG4JUyxCX0f2WkqpEn4s8CkueN0FD22J9/tLQG3cw3ZHTLnJI4HprfGcl/E7SzCsRNu3o7azR+j9CmNB9GVp6VRyZI17r3Ngsygj1cQUMtWnEZFAYqaJjPhwlZ/ZMPz39V7z458Fiphk8Zz6tjvvhwWckvEgBXnjCbIoJ+2zIi7mEKJbaEnuTJ6Sid0Ge8Gx6mZVbySGjo5/emC1AQJjgrGybu9Ugk6M2m/CT3G91oWT4bSoYrOyfWLhpnENkxOO1od9NusckUbuokPxYMpEV8X1mu1lXyZpFG/u46MTewM4OZ199ZMIhacWyQSN/rCKtSr0DkUxQxlapzpj3JJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWk0pdpTjYpeklCDyZqmKOSBJsrQ8lP4Xveu/fno3U4=;
 b=nmkbT9zl9gyCKVCcAYhuS6wpo0mIrIQgbT9ppxJufMN/m3AhF6nklfYs5azn5vEBgeh6Y8m5Sc4y1ICCIn+N1N/6d4ZRbzku8AQ7uygqyCyhDJJlzSzQIJKtFCC3TRwB8xR+Pyb32BPApdZ1PtSALTLgwdeJBAfHlCNhK+NF+zo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:21 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:17 +0000
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
Subject: [PATCH v6 10/17] PCI: dwc: Free the MSI domain after the host .deinit() callback
Date: Fri, 27 Nov 2026 12:11:38 +0900
Message-ID: <20261127031145.2521228-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 476b99f3-af52-44d1-3ec7-08df4c343dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102130727099003|261102123227099003|261028144727099003|261026140227099003|261026135527099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	lTLMZyEOSUEBHW/cq0rJGerW6nIFf3SAwSZgKlrQtHCINiv4hmmj3/rGI1Bc/Z57YxG0VDaaykTctPi/SseMWWsbwnG4Sj6g8szYLt8azXwKQZrzBxR4/HRT8UPTRN7bdNG33JaivQBgDp7jFOorjlURz7Sk7enN/yGdk1oiha0CqCb6jb5MnO7RmYsn+YE30KHx54Evs8/CtaJWqeiYUBbK+/DpZGHYSyzR6GFh4zH2AbqnKuaCZyZwSc32BgK9j0tqrIi8NC9kk6zipzCXSPRKgkvr6RX/YKhZt0P875NMaDTL02/YLjMxfwi0nguJtSQmBTDPdt0Q+OnyATqVgtkmUY9yKAxgfLrQxabUtvZPNg4DmEe9IPM8R/WEkVP1p6jhIDzD0/bM9Fui7ZpHqhO6UZ+76Azc5/pBxtRF7Yfqk6SGyRqcP0/YF0e0kB7b6uB8fGOrboXq4REqoPZ0MVGTdAP9LqxL/CPoAQnk15JmhC/z7T1BvlxBI63bFb2Tu6JNgDlShM04lrhMD7u4k+9Hh921OJjinnFjLvYh2nE0QWEYPQumNCrhWvpLrqRbHcs/qGTYDraHy8UFPTdD4JAJ5F/GC+/EFK+S3oNQ8hr/lJsfpd6lB8b2y7zX/sFBpjrDJWQJq/1GxvE9VWq/kDFLsmIJiqF5idj5W+wmZ6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102130727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026135527099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MNTT9ItjVpYdqB1oeL6L22gTsGlAzTiwbVXJLE20bTep6/5Fevf2Fe8G5lLc?=
 =?us-ascii?Q?Sh+WKxkrW1S9NQLyYU2px7ARKSyPeo+DqOvjZtp9qNls45U3XMq7nErhAzdw?=
 =?us-ascii?Q?dDXnJEtNDuo3I0cDNX27GKPwVX/8kky02L/kclJZpxdNsuRBIs8LBe9L1dB6?=
 =?us-ascii?Q?JgvAbtI6IJASaqWWBiHVcDw12SEIrVH12jaJKlfAXBBZT6gOa7+O7aDe6+b/?=
 =?us-ascii?Q?Z7B6L2cZ9L7xe/rhgbKKM6pfKAi/FElpyGXbWZ6g2AYyrhJx+8cOU7m6DVMe?=
 =?us-ascii?Q?r4xUcDQIx7OsW9w6Cw4/uIYsFOrmtb2kKwtJP44VeESfHRr8jfI1GrExyvaw?=
 =?us-ascii?Q?m0X0nKrAoM1fI1mPA0sC5or2qz3elDKpNzZOud+xaMQZ6+YyL5xbn2YGY3ar?=
 =?us-ascii?Q?jJXw8XD3LZ0VcQ3tViZuAdS0vbunbr74+73sywwgQRI4F2HXJeOJP52PuL6D?=
 =?us-ascii?Q?UYHzYlRmPHzaK/o9ugXveXcoqj2WTUu2g7M6jg20wD5Pq1q/pMVhS+I3UdTQ?=
 =?us-ascii?Q?e6xQ+Guz/XXpxJNx805nvcuKpCj1GIPv41/0lnJXHjpiY4FVvlBSVOLpT0vq?=
 =?us-ascii?Q?qMnOVapdjPQja+/WLONGc1NF6/KKMX53HCsRK+AnKJy6ESZv2Vp4VBni+URg?=
 =?us-ascii?Q?oeX/ZXsKeodxTXm59OE243ai784m2Awo/ig32zr51IPVvaOEHTp9/sHieQk+?=
 =?us-ascii?Q?64H2Q0s0q01ZHY2bvc0xt0ByF59ZjZLM1UqXFtYkmG8GbNMS4mwAtUKxYDu8?=
 =?us-ascii?Q?hQevM75PfJDMSQ4Ql2+KKBTO7jtbUKe5GKtiHknFR3S1MNVLubAlIQivVlOz?=
 =?us-ascii?Q?/VrLSJLIH3+O9IdSlHz3HypkFTLn2Bj8+P4TB7/Ek7+t9hdvV2u1lEhgck50?=
 =?us-ascii?Q?/Vy3wBtSOzVwU1UoK195r7m7zZyIBHgMw2BzXBzG2e87XFvvMEDxqm56BrFB?=
 =?us-ascii?Q?xZsuZt3qsgyejp6feMrQ0gVAFhpZsBjUm2IJN3yEAZqzNyj0kjizgBpua4nK?=
 =?us-ascii?Q?f0VfE4nFbh0+ZPoRg8572OMI5Jhsa0xAydfsnGzeBf9EfDMkZmd6SFzW3k0o?=
 =?us-ascii?Q?Kcvba2AD4/K7Q53/oMj/Nur/3QeBy6q6PolhHcEZWVLtI5Us5IGLOK9YaZiu?=
 =?us-ascii?Q?dfjOJqxXcAWC13MqUW8ww/MIh1HSlQMC1j2HGb4dKl4ey/kknX15ABYx6lLQ?=
 =?us-ascii?Q?SS0WJDGPgeA1qynVagAgUi9hjHbzEg5Kko/NwT9L8pWJL9D71uaOGBx3vk/r?=
 =?us-ascii?Q?KAZMa0xiQoXDw2So1CiF1P/C88u2YRqwbxFxNMxlJMbW3IKN4HPwa/tlUXe1?=
 =?us-ascii?Q?rtkXz0wI365yO3yqO8plwR4mNXLMc96d+/gyIA5F2a6y1DgQgc9oAjFVSCK2?=
 =?us-ascii?Q?Zjyz4xuLCERaEGZWXAw46JJ15s64u8hwzwOQ/3THTJQrC5EhjvvCklR0Ys+e?=
 =?us-ascii?Q?aI6Cab+q6Lf3gU2jlFi4wBwOIFEBSFFexAvcyFXXXZbj8tbCeLhtZZAVelaJ?=
 =?us-ascii?Q?59CfHeUC60ulmaHUXAMWQFemp1zwgNUkoI8LT8PneX1NMBGExqwGya4kv4lK?=
 =?us-ascii?Q?/nvQZAAveb/XfQTS8omGfCdNtL6DvwR399awfwLtVfAD7IE0y1wvosbRU9Ty?=
 =?us-ascii?Q?4wavi4+jmaAZ9yyADraXoufs7QYsJrHmhfr2ru2ZViYD5dFJrLT7YCVtjim1?=
 =?us-ascii?Q?b8J4eAtlmj3ZEpfr8M/yBPxRwXpVreVs5wzr24hqxMXY1H+GImiHqikGcfql?=
 =?us-ascii?Q?yHlUBqzWRzwC1ARYDzzAmifGX2qhhvpJmn36l56P2d3NblL2bJj7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b99f3-af52-44d1-3ec7-08df4c343dfb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:17.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQmBUCMy/ZHj6kIE+IFaPxMPHJDAAkdqQfrJJbzjbI1B7bhJ3b0V2P6bP9R/5oabsjLbJ13XTe1u4xGEse8A/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
.deinit() callback. For a core-owned parent interrupt,
dw_pcie_free_msi() removes the chained handler right before the domain.
A glue driver that owns the parent interrupt and demultiplexes the MSIs
itself through dw_handle_msi_irq() can only stop its handler in
.deinit(), after the domain is gone, so a late interrupt can still
dispatch into the freed domain.

Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
dw_pcie_host_init() unwind. Keep removing the chained handlers of
core-owned interrupts before .deinit(), which powers the controller
down. Clear pp->msi_irq_domain when the domain is removed so the unwind
can tell whether it exists.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Use pp->msi_irq_domain after the DWC rename. (Shawn, Geert)

v5: https://lore.kernel.org/r/20261020031049.969895-11-den@valinux.co.jp/

 .../pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 025103312991..c24603f9d140 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -228,7 +228,7 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_allocate_msi_domains);
 
-void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+static void dw_pcie_remove_msi_handlers(struct dw_pcie_rp *pp)
 {
 	u32 ctrl;
 
@@ -236,8 +236,18 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
+}
 
+static void dw_pcie_free_msi_domain(struct dw_pcie_rp *pp)
+{
 	irq_domain_remove(pp->msi_irq_domain);
+	pp->msi_irq_domain = NULL;
+}
+
+void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+{
+	dw_pcie_remove_msi_handlers(pp);
+	dw_pcie_free_msi_domain(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
@@ -633,7 +643,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
 	if (ret)
-		goto err_free_msi;
+		goto err_deinit_host;
 
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
@@ -649,7 +659,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
-		goto err_free_msi;
+		goto err_deinit_host;
 
 	ret = dw_pcie_setup_rc(pp);
 	if (ret)
@@ -686,14 +696,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 err_remove_edma:
 	dw_pcie_edma_remove(pci);
 
-err_free_msi:
-	if (pp->use_imsi_rx)
-		dw_pcie_free_msi(pp);
-
 err_deinit_host:
+	if (pp->use_imsi_rx && pp->msi_irq_domain)
+		dw_pcie_remove_msi_handlers(pp);
+
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+	if (pp->use_imsi_rx && pp->msi_irq_domain)
+		dw_pcie_free_msi_domain(pp);
+
 err_free_ecam:
 	if (pp->cfg)
 		pci_ecam_free(pp->cfg);
@@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 	dw_pcie_edma_remove(pci);
 
 	if (pp->use_imsi_rx)
-		dw_pcie_free_msi(pp);
+		dw_pcie_remove_msi_handlers(pp);
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+	if (pp->use_imsi_rx)
+		dw_pcie_free_msi_domain(pp);
+
 	if (pp->cfg)
 		pci_ecam_free(pp->cfg);
 }
-- 
2.54.0

