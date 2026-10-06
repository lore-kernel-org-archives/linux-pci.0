Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFC3EE1FD;
	Tue,  6 Oct 2026 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276429; cv=fail; b=qyWpey4PFCxUiI+Np7vkCkc4e/2XRV/wE+gRNWIZ9PINSLiEDFHVMxeyTYUdeLMMY9LJ9WBvG88RIzgzzEwCgC7BjBNshr60tm1jtjfIpRh06KOtAHhVnBmM1wIuttT04ds23R/tDaGCS7KIhjhwuxKrI3G5tfst+BecbAd6zbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276429; c=relaxed/simple;
	bh=QGHXHNgqtptH7Cqimx9z1BLgc6eiJftqCgi3ApZH8u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxITIfDWfEvzo+xHJ0BW4H0uXdBcmAvVXmuq/fkLHsYfq6NewGGxKxemASlc04liU3TwfViJ2eSXoIEfsqPDT/MSvsUItPwEhzJNzns42WrkptXLxM98Wgz+DHPj85nkr68tAafwFKnByWRj5kSPTx7VQM2xDGlq2nLd8XtMPVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HVZjsfvZ; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HVZjsfvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1IljAFbMTYIdtKXs4vaUkrChnz/RSYZbrL7Z9QDAsxFOKpDlBdgKSFMAyvpeEjIkaH0/1Zf2Bq5iJ0Zv3ZhOVRTPvaV/DcO5v5n5mB7oKiEc3RvBGAqWShSADyWEsIELH9gfTUvh6gUnh3SUVymVzEaIV481KHT/1FQlnaIuhYuOw0FSO3bqjTO5tl72UO57QLETIAeoBLVpnkmkRkFnlQT9LSCi85kWpf0YtXQeN0KMc1Kmi64URJ6JJrNUPnU7U1WHlZLLs7J7b02Nyuro6dSZHPkc6Dj4Oq9GrVFKliy1ZL6vl+Czy8tkJ8iCI4H6yZUJ/QYaeOZbBXYeGUmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BDSPzBWJ5W6N0OFnrhyZkbVJiK6KkZv3dwWbTuA+rA=;
 b=PojU1AJNWD0YTKgplyQexcDQxMXUvVZZNExukY61/Cj/W7MV3ziojYVXGJCJQgxKaC+41mmejQL/0QMLeLWe1mXfyFgJ4Oav1zggXG+8H6OZCvXUnQOhrAOzhX54DGh8tGycm6xV6wdP8kQFjQ9n8caau8faVPjIGah1K7AKoGlpqrfWlB/67gRP32zM1LBJv4wOdHerfXmQJtpl0x+DQaA3vJEL7TUxCz9LMSEAN6jZLoJhgalK1CoLc+Eynh5DFsZXkxcNSOL+CBU+KrRA8NI30HWMz0zj+eFU2oooy+AeOGfEkJZ6rE3hy/tYOAAY+zruH7wHpnovwKdQeExr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BDSPzBWJ5W6N0OFnrhyZkbVJiK6KkZv3dwWbTuA+rA=;
 b=HVZjsfvZi3Xr6JtzTXM7dqvHIKTHuwzWW2A5v0KtwfAzO+QEhmQA67fRldVcZWasUw1RgTyUMlELK7Xfkk9vD34qmsSZ3LzowHdBL8dvwFa/WrjFzzjDE+KXAyCWPz2fYw1qoIvdExZOzRsVybP5XC/RpSbbeKKsaLTwtmdLU2E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:58 +0000
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
Subject: [PATCH v3 13/18] PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
Date: Tue,  6 Oct 2026 17:46:33 +0900
Message-ID: <20261006084638.3821710-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 705ce325-cedb-47ec-ab68-08df238661ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IiI4aimvx4ptti977RxnDbUL/+a+TQ8qQljRVKu21X0GGAnS6Eref4bzZHE7EwgQnjyNDJ7RSNoNgmTKJCC9r+I0/eXSpfjXwqcLlPHyYFdeJTAQ6Db3eTIP5tDWi3zhlhy0RAHjKzjp+lxTz0BIjk9csAWJI6XAMcSy7UVc2Mu2nZcS5AvSwXJFytsyzvfXvdJiR7xb61inEnQg/8Zo1K8JXh6elKq/Kh3CGuQf6ZQbRay9npOAi+ytrbx5Mpb5mXR9YxSuq/eO4ziiSXA2Xmb38x9CeQ4+KrVqgRKoJjl1s1td9tVlkVm8ja90imZxeoArHn6GY7vQFL8PHEhW3yvZtpqiPSu3jVPf8YuPe0glQUsLPZ/aWuD2SxE3CTKj0pI9tdcgVLTFKmkxlB5nC7TOCk7nzFJDSql0AI+mkMgCqavZ2J9AhRDh4ZXhCkcVRGfwh4bhnGak9y1JSQl0EoNvI45VdbUEd7y36k4BOr8bMBcP7rTlCxXAQh4bh/dTjEX3ndjDiEGCENxEX9nAJrlAFRP9fYByQKyqmACBJRI35zETGJlwuWOTXH9t8cCftL6ZK8i5UMFl2eNqF0+xfeq0SA5B59blk7WapL8woLZoVD+9q3ARJkt2SHB8Xm+fAISMvWlUpsttrFY5T2FfUzsmfVJz8r0kEaIwpyK31gElgTV6SZv2/vFQPZMHWdU5QfZaEKivYlISBVVVzhFLgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4Wa3KxrHXQSYG6TGeoPchHWE78yeAjvabqCK5usfSF1sezqjF2zdxTb2OET?=
 =?us-ascii?Q?tpHa3PYcosy27duRVupThTilC0t/sroSPht4LzSY4uPPGXTSJCok8cBQGUNY?=
 =?us-ascii?Q?nf9Vc6iIKbPI1S5Act87jMMBZWYjoLYH0T/yzy4YLX6lWbI6Bjihwn4mNFXr?=
 =?us-ascii?Q?XguhILpr1XsnRdJOetKCk4juqdiJ2iIuxplhcZgJdLBHyUnBemKWTu+UA0nB?=
 =?us-ascii?Q?9J8Frn9Ue8BiOFMomr5iQtde+T36Ku0yM8tU41ZOoHketFNTH89ia/Oo6jdG?=
 =?us-ascii?Q?HtvuYEpyYN5lxg0/MDc7tysmyYJLMy4ctzREpEwxjpXqzJgkHooZLqj5zGZO?=
 =?us-ascii?Q?wGUaJ7J71PtSLWfnZCszo6wK5K8vrQzIFcoyxZ0eScm5EDPwxkjWHMo0NgyK?=
 =?us-ascii?Q?Vga2NDgdAPIbgFV6do+gygiaB7b3HsQYDhheaFCjddXhT4jKz3gkaboHTsvq?=
 =?us-ascii?Q?XvKkMDlAj9cEBzG5rswLcik/4FaMNOl2DHQ21b2ip5MLhtYXv9xVsOhXsAjV?=
 =?us-ascii?Q?2tkRTDTxbcIJ4rMr1LGM4yy9AvyFGGKak10MjNADeYFktKtLxLCfb2uJ9aSn?=
 =?us-ascii?Q?ZPfDnHPG4feXUycvLbWoDtk49wwiBxGJilulSc9qKGmoG2X5F0kyRtZSN9NU?=
 =?us-ascii?Q?1G733OJ4o80q9Nfuu4g6qUoRlELljezOhicPB/amtH64nHbkW+XQL2BIMbUQ?=
 =?us-ascii?Q?fA6WGdiaVLlOY3dvmWYOf4p17XflQmM1MMbn/kDuvETv9MyLGenQIVuX4bE4?=
 =?us-ascii?Q?zcA776gIQLHDjdaidWwWgV3++90zGJjGhZf8KrfOoVctWCLul17yx6tI/reb?=
 =?us-ascii?Q?0RqV2Npv/vY3NPVHaVukbmbrJT3Tm1NDo0hNbAxpmQtWlyFDfXuHOczQNZ8q?=
 =?us-ascii?Q?Hhv+Ip1uXsWhkn+TzlZuCzcV4feB+FX/eBaBRaV/4GqrDkvSt3HHAhalgSsa?=
 =?us-ascii?Q?+Ysd0ugTgJznENqq5FhXfTEcMKbY85n9ujdgRf65MNI76ToJdpaiu3LvGPLl?=
 =?us-ascii?Q?qkY3IyRVn8I9zeY28RlbkBV5Sblgi8Mg7DUCY9fHOj4ih6kRwN/QwV7nkg5m?=
 =?us-ascii?Q?u4PXXKXz1sihOjz6VFPk9wb8YAbrwlfXGt0Z+YPYLf7O+ypkvIGlqk/N4HvF?=
 =?us-ascii?Q?+MwSrmbG/M6hflKukh9oU4e/vQpflfBLp1ArLyh9u7Msc2YhKIqwykrkwhyR?=
 =?us-ascii?Q?octdjpJCgIa5qw6Na2XqasOM+j0DICP1uL1EmdDidloZm1ytwlhipMlvFcJZ?=
 =?us-ascii?Q?ix2g6BoHZhYd+4yP29RYVceFXAAV6Kc9CBXn4lowd0YxRtreUtpisje32ab+?=
 =?us-ascii?Q?bdRWG8lr3cZjsJ7KDqslpnzVmh893XtI3gR8+ilDxFId+wywBWPOACynLwBo?=
 =?us-ascii?Q?kE5InPyKmrhZuetLpMpZ8QgBg/jKI2IRx9SLcb5axupJISEqRzLkAbtjLNNG?=
 =?us-ascii?Q?EnIXiwc3lUWoFrUrErXjJETlYFpJfSCqeGYpCXcXaVZU5KAvXbdm7gmtl5nE?=
 =?us-ascii?Q?EoNbRpSbaov2YCv3F9/3Oxq0vd54y0J8RkIjpuCsu1TN9TUnE+kVaNR2XdGA?=
 =?us-ascii?Q?zJ4F4pGDgcQC+1iO3wuKTZmLkMKZrV21JEXIBC2HrBHJv2KlHovVykIPe5sb?=
 =?us-ascii?Q?oOe9dJAA0L+VUz/AhTtgoN8w1FjWnGCU/VLQoqEruC9E6tsGq++VZsuGH9rA?=
 =?us-ascii?Q?iH81lnrKOA4+IhIW9Qw7Og+MCCTCjA2TNtSFD4tCPom9FXJYzTpkFwTns4hf?=
 =?us-ascii?Q?61Gc415b9JueGIpb1d5qYq9imxbZbEZQ6UbHyb1mf0rFzQOnIs62?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 705ce325-cedb-47ec-ab68-08df238661ab
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:58.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZyWWoSevPIKVII/T064wnIoWsYnVpUx8MjZe+5ZgVv9ylKSoG3sk3i6d+h76xW7sdpCnArRsPyHZNc1FgpaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
capabilities when iMSI-RX is the MSI controller, as it cannot receive
the Root Port's own MSIs.

Some platforms cannot deliver them with an external MSI controller
either. The DesignWare core signals Root Port interrupts (AER, PME,
bandwidth, hotplug) as sideband signals on its SII interface and only
turns them into MSI writes with the optional SII2MSI feature. Otherwise
it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
(DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
the signals into status registers wired to platform IRQs, so an MSI
targeted at the GIC ITS is never sent.

Add a no_rp_msi flag so glue drivers can request the same INTx fallback
regardless of the MSI controller in use. It is the counterpart of
'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
MSI capability with iMSI-RX to work around hardware bug"), which keeps
precedence: that one is needed for endpoint MSIs to work at all, whereas
hiding the capability only moves the Root Port services to INTx. The
removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
reset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Clarify the SoC generation in the commit message. No code changes.

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 774e1936d999..32e179603cf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1191,9 +1191,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
 	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
 	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
-	 * to fall back to INTx instead.
+	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
+	 * platform never delivers the Root Port's own MSIs, whatever the MSI
+	 * controller in use.
 	 */
-	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
+	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 2ce61709b58c..d94116402b74 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -445,6 +445,7 @@ struct dw_pcie_host_ops {
 struct dw_pcie_rp {
 	bool			use_imsi_rx:1;
 	bool			keep_rp_msi_en:1;
+	bool			no_rp_msi:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
-- 
2.51.0

