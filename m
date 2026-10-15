Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14F3E6DCF;
	Thu, 15 Oct 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035091; cv=fail; b=gI2Oug1v+nIdWEfIYlHNxiMxEFcSbwK917K/KZr8Q9OAuP9bWEbMsnYBNU4CFLYRQBwWOdCihJueIxAVqrbKsd+ES5LN/vsXZQDmKwDTtb/kGKejmNrBP0XHGspLE450El/i/B4CuxHVtL4dNGSVcmioj8PlgOZLjmljgFtxSNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035091; c=relaxed/simple;
	bh=jydi3X6RURuzNWCLR5a+IYMxS7QyjbLa6orDZKeXgrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGzNCReZavhX33EWJbwGn31THf6l+7VXCnuJB4T5lDxk5w9Cl9+/oCYXkNV5PdjW7b3zoCq9aPB76JdLr0TJ3OV+A9Gu7TUxo9reJsnLxVh9Fb4j4k12Ln7tMy4r7WA3Va6Ecs9BkMrJZZrkP+yBQG847DaKF5crtaYsHSM94fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tH+TDzus; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tH+TDzus"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVH//CbRMNMYJUes4t1k98bt9fi03SzQ9S2FuLN3YPkj7GbX3738ZN5F08DUs+b/clCDfZ+tPTqZmerGMwM8W42GKJYOk0d7uaJnh3ipRBbBtEm/iTY4bZiWgztZL9ov1YrJOtjQtcyAzObqeAx7YtPNjLhS9Us26YmB7gUSW6WQNIhCswJnGDiiCJa9bcsGTcUN0MUimTUmW9nmM/1RL+zpXZ1Hi/8msPlqjiiHLSCcR7C8h6G/aLLvMIPiElUAIct80NkVqr9w4cSo5n6mxpGynuyIcBe5oS5SwGdkkqUEGcg5YMiSZxCnysIDH/wbpe0HzbdpDzJ3ndXhF+5rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzv150k7K+kS3gr6dd73b4XqpzuV7JQMcOSgo251DZs=;
 b=T4i/x7PEdO/8T+4XaKdT9KowO0JwHbgm71qmBMe2FxBryEQ3lWMhiaGOJkccbGsBWfkiOYJiOuckkU8PWItCFNjsygh70+W474o89lEgRrAQRuUxxcMW7iuyrSdEMoMmIvirAhwpmpkPp54qwIYZ4xQxFSmd5A2jKDIrEnfl3Ne5r7UFIn9NA2y98O1PcLfRCsxIwMgWagyv76F4You+0TKeejdegOm8zWBSNikTcshJbZxji3BScivpbAA/b885XWmHswfdBa9GHzf0RtT0KsJsURuD3lIiYojbO+omqJgZI4cwXDeXaxd0Neu2D8Kq/YnbKElerVzCdmjmoxRXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzv150k7K+kS3gr6dd73b4XqpzuV7JQMcOSgo251DZs=;
 b=tH+TDzusZ9+payrffCR3CZMkd/2ICdhxoNFxu0osLrvJyLyDrd6i02Xq9ESVdJg1pJ1T6JVwvGtRBPF7UDgHu8KkISWdcXN1EqTbhDXKtOT2/H0s0rvWB9nO/InK1a0TTDlnuq6wVviQaCXoskNALkdreSigjzHRboBZjrIHSjE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:18 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:18 +0000
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
Subject: [PATCH v4 10/18] PCI: dwc: Free the MSI domain after the host .deinit() callback
Date: Thu, 15 Oct 2026 12:30:55 +0900
Message-ID: <20261015033103.3076869-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cb1ac8-dd26-4ba0-191d-08df2a6cc675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a6qm711PemLAbj4SKJ9OGk+lIxJaGMaKUIOPvzS1PVL4jENNV2eXM+/kl9pxxb8x+TMU729DNVyYUxmVY00pZiZTr1A/LISE/u4b5DFZeZqkXxb97THCqKwGJ0q8Qqi9YQdW2ycbGwi1cANWhErkRBSuqe+VkecOxBpaMYVoACMAYNjaHA8qKEhLrjYYLA/kS99hYBmvIl90kHu0hCoYcLpdHKUCASxZL+9bjN3KHKi3PGC57L5f4/fhfN0zmKb+f4KnheuI+e08eBuMayYT87PBjSPmIxtLThj2KAtlY5kYq5nEFJlbicuALcRbw9x8CUJhSQvF+7i4+LcDxL/9aNqRVwlvDwMAkUkM/IpBhUc6i3GEQBIpaNtu5xEQuO5cGuZBu43rszMzjBWXE60tDjrysMTMG22qhWB/DKLjkv7fxWbIWhf2mDtm7bz9kUhlnAi4icf7DUoMXE8haST+dGFm1hUrFeHr51nEA67VBsQSq95NBQJUFCw4gA7KGYUFHvCTEfKqrsztiwRvg0ImQ3o4pZAcb/2WqNQ/TqLeHFWoESWOHsDsK03mqEylBKo9WXon3sOBaZapjbIOgRo06uhxc21i1joqL1aqYHsr5XlG3pmPYortSgJaRgEG/63ouk0XsTzcYIVUMsvYM4WFyOwTRK/NoI+fKpe8+1T4ZdJouPMJ9bIiDKD7m01fs+odRQksh7yCV1RjNbVtBk0PqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHPQloZbB2LSSiOVzTED8VdpcV6gT+xkyjUHHimUFqLpOJKUHuvHT7GSnoGC?=
 =?us-ascii?Q?FiGEWLe7buOZqNCq4U9Q2rseZhS9lfB/KkXAPeNyJlsVGpHa59XLtUBGQQ6+?=
 =?us-ascii?Q?glCZw0XveksoVTeirK+3rz4rB2QvEr+6qLohluEbYsRIGu6UfrcM/9WILJfC?=
 =?us-ascii?Q?KN9q31ulO2JATVxp8hUhduA2wwnD9MZHldKtG4C5tZsQZEuIsLRs8OgRLZqp?=
 =?us-ascii?Q?L5oWfixvb1qzgJ6jQyCMnEHEsLdErFJ95Jy7MhUHjlU2CBX64qKET2PDfgQS?=
 =?us-ascii?Q?rV+V6vrUaUNiI9fkxD4ECKh5SkEy16ZblwasgtGZAUYrqs7e/QQOhSfnC6Nm?=
 =?us-ascii?Q?QLzZx4HluKoOno1B5RTnRjqVr09Pbch3lJrRNkBH0RTsvpdt0VCjzkBWWRSN?=
 =?us-ascii?Q?fd3xz4x1x0P6Yl3DfY9PF1WhO12iQCJ63AamyJu+WNQzbNTF8LCTr2mIISse?=
 =?us-ascii?Q?cNaI5a4bpAgi1XgZ10ZxyCq+nQbXhYo9vLQkvmgcveze8gdyJW/ISQu3XROd?=
 =?us-ascii?Q?i5MV8cqgiA2P+EgS0uZ2ZPDiHvHdwpmyCDJp82/ZSAyzra031Kqp83mn1/WG?=
 =?us-ascii?Q?XAwhofQmkq1pd7uj5IDao2UKlfVfgPLhGQF/DboCWSexW09/kVujAqDF0KkT?=
 =?us-ascii?Q?wmOGTInt/nH0pvwl275epSoMMOd8qWqcFLNVwTRPU1nf3O5T5r3lGp4kit3N?=
 =?us-ascii?Q?vI80XJEhs9ehuleZ+noeYW8hlXryr8jm5dkV7mxWEKeAUHo3fBGYiBk9guLH?=
 =?us-ascii?Q?+5hd0JQacaJU+y5XhsMt0ZGoDUnFxTiPEk0TUJ38IoeaSp/dQKy3t+N/LHf0?=
 =?us-ascii?Q?Pg/Rbrv3GuomVMkHL4hI4jBEu7jqi05bb5g64lD8ytBSoxfrn7jAJEQ4tOMi?=
 =?us-ascii?Q?wXMXafu/iswndrZ3bWQEiSqs7s+rNWhKlJwZPa1k/A0Z40JSzyaceWunkQv2?=
 =?us-ascii?Q?tlGsMiMfSyxQ4ps3Az72P1q3sYPEekTKpvCIzxFWwGKxDJTdIKEq+mjcsQ8j?=
 =?us-ascii?Q?hIpnyTLLc25fo7jUYtyZZQdqnOwWZ7gskJ5HFnFPSHD4JzOXlsC91dErM5Hm?=
 =?us-ascii?Q?RmBwYI0d2YKTFsbnL/olBRQlneiU/a1SL/YarR021Icvn/zh/bSaswOsNiLL?=
 =?us-ascii?Q?giSbAHCVTEEVs30zMJtw+O+I2Wem+kKHHZYoIlxmy2+VeQS5erHn6eYr2D5y?=
 =?us-ascii?Q?5E2fMDhRC9XCDyb48wKdpfIAZmb5fBK0Bx7O3ZB7cGG3LmOhXFtoiD7tE4Yj?=
 =?us-ascii?Q?BSnYAccvTsrGKIrZvqgftQvARDII6ts48zwnk4SYugKKYX+/XMn6H+nK7ZiY?=
 =?us-ascii?Q?FALsQBO8AsXsqnuwKQQd5nfg1j7zgIYjDOMevdXadGbF/3Nq0YZT+qp1UG/E?=
 =?us-ascii?Q?ajIzMInbpfcBaBLksfCrTJWHd+oYzWjCpv3oVYq/FM658IUvXfSjZ89D8J5h?=
 =?us-ascii?Q?/j08gFWGckDxeTal5hvyJWSwLVdEn7Ev9/WpSNiyCkY1EkF3XkiQJu3rS6Tm?=
 =?us-ascii?Q?sOqSIwz4Xm5oJrAsR0MG5gPzs+nIOnxXFK77D87sziyqqX9edBu3W2DS7roT?=
 =?us-ascii?Q?4BUk4FJOqCKby4Lh8AVj5A+3q5g3QHsrdoxV54+Ui0UcN9ciZFG6EppD1FLc?=
 =?us-ascii?Q?IwWS0E1vfwG0kr/FljDhVW2nr9bM1d7BhcIiPGKEWRDgAaYcduZqP1GGh0wW?=
 =?us-ascii?Q?IvdxeBHQ77S3R9S7geYCku958LrPG05ls1PgX0WPpP2nidam8RpiRFGFEVBo?=
 =?us-ascii?Q?AHpZROyUOuXdSci3znU3C5xSkoQ1/E3IUzPrQtsnXA7mk6GUbzEv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cb1ac8-dd26-4ba0-191d-08df2a6cc675
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:18.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rHUxsofqMwJvFNHSHlTQUcwdmnNjRLVyla07mOH8PB+oeGxjPUawQ7GE9C4Mjs8F5wf3bCJFq4stxbutzSwmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
down. Clear pp->irq_domain when the domain is removed so the unwind can
tell whether it exists.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 .../pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 63b38532d069..774e1936d999 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -228,7 +228,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
 
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
 	irq_domain_remove(pp->irq_domain);
+	pp->irq_domain = NULL;
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
+	if (pp->use_imsi_rx && pp->irq_domain)
+		dw_pcie_remove_msi_handlers(pp);
+
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+	if (pp->use_imsi_rx && pp->irq_domain)
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

