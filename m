Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E83B95F9;
	Tue,  6 Oct 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276426; cv=fail; b=FBH9GJ/DzRjoQLaqUnW52Omgs5IGHuiNHMECKt6N5z8/eQGobI8hR8FCxLwoh8mObeQqhu0EajaEz18I39jvRQDWsG0huyjAWlWNOOd0mxK/TkOhNsnPxbYrm8xxk4Y1ZO8A+ecQBF/ZrL1V4h6GG8PQ/pD7/h9vpq9BAEdrOqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276426; c=relaxed/simple;
	bh=AOaVgU+VI5BI9zw1SiifOgFq6o9qqslwkYz3OhVoyc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXUbkizJdYrx8OTFttO/Kr8ljENmMIEzO9Qqsf85ZHKw35XUvZfzirCgp/g4TF2REwb7AFsPZhBs62dK96FKYGDSdhEcbVBPtfP33mjPc4iQiWJZe5TUkHpHdvYxI+hWDFdN0KXbOiKrZFYqG34DB41FZqJJXr3c3R5sT/7ihyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SGll8Mti; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SGll8Mti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPEiwz3iyuNCb1CFRoIgQ2symHake4+6WTHEN1XPQS+A0C+LYtMRFGsJrd+RVJvlVuNlvb032EbRTdXBZA3zQPoVvut9buINpdzKTArjGtTqLJCEKdS781F/zDtS5Gy7dMEP1h2sEqnWvqVHlsM8iC80n5WKm7sndRKJZA0SxkgLPL9rrmYc71Lp39YjX12xcLI9zqdv67vkYEo9lEvYhN94Q21/aXUohbeNS6dWVY5hnUEOOgOuI8qtinALaAcXeSQ6epPfOZWJ/sIB02DNaasuFxIyCQmXyhNbdg07thg8CBAmq9/CTT5xsbH7bKtJp+SqKlzRTfrRy3MP5DRKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdkpDZat6gJVYN+OrRy8L/Zw/LbVjM65EjJN1lpWoF0=;
 b=LmCpSfOF9TQZCU8Y/U6ZuWVyyIyzU0StUB7LQ2WdY1kKEoxewtjywXl7OZNDL5zWsWcdyf2JWl52ozI7VnBXXhkGhVmRAhjyR1vBOkUTJHGvy7e8weBQ7QzVPpBrADlkpRR4Sip9/hfVypqo9ZUUlEmkQCSApB2+xKNxKfDWyiY5L/UO6sJEkUMzd2KlLkj76Y4MSUVYpaP5v5gYhP1QvKZA1T8UEGMjTrJuXd7kJZMjmvzRGjEAXAbxp0yeFR5dlCLaLWN/gZFoL9hH73V0oPmtjNQtqT6oPflD9MEXouFftE5KtLPR5mjyBiHaIqXkG2yiHkgVKcsniPv/XKgYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdkpDZat6gJVYN+OrRy8L/Zw/LbVjM65EjJN1lpWoF0=;
 b=SGll8MtiC1M+b/C6yW73NpluaV4BcCJYbyRvwGJxF1+1cSzUTrNQEFplXk5Nkgg8ae/cd7uLfiMmEYC4Jj1RHGR1qM6Cscze1bzMOFpoQzWS716WAz8iFPY8Mcf0hD6FHngKh4Hwk8FzpCPFvr2V+6w6SKjtV8G6EiFxza0YBRI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:55 +0000
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
Subject: [PATCH v3 10/18] PCI: dwc: Free the MSI domain after the host .deinit() callback
Date: Tue,  6 Oct 2026 17:46:30 +0900
Message-ID: <20261006084638.3821710-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: f9734f60-b850-4987-3b44-08df23865fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7X5Rfp6WStZKb+GGgWlwWmVe/2iukYyqoURnVetkJ4ppavMWOuh2w6oZku4P5hMnm41PzlgcySt2tW5ljHI1HjSzQcFCGrzipL6U9ytHvLnegdMf3V348/h2+uyh5T6mY8bdx+VlsoLQxLHPTKlGdlGjmZPmly95RxDVogCzvzKESJKIOKNHdYEIdzg09hTIRhTQdOx3k6rKzlA1rTQfeNZEYetCo6ob/P1ieLv6PBIRbSqsQFfSIc9rdiHSAjQozKWz5Bgr2iYyxijSPS3IFxrUtle/zh1SGp/Ebkn1dcVLXbac97UXi/ak8kvZKhZkKL47wRQ+8pzPX6cDbeV+dP/m98FhHeGzN4G8hGx9gKnLZrLE/GDLUQ290qvQliTSJcE2SBYf3BsiWbiDN7gHobcav9dWfPIohtXIqZtKsjcDs5yp4fgvevg+Gyf9spCGynSiZmRMZo33ahIE2Z9ZGNIvbBBQY28yRuA7ony6zrD7snDjlbv6hxThGreAZINZSbj/2NjKRPO5Q7K9EL/KvQKFrs8EsOEBy1YmU2E1Pcre5sBgdTQIFTeqanFx0pybFVofZtSiro3XerMJD1abmP4vSekEeW1OxOHBD3RiFtDhq/Ocvi0NYWNL8hyVy5jK8zyLGLGPRVUod4AfzRu620TzloaIjNlCOCoubuCAqTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mDOto7dJYvRylZ2rZXoM0DQNYwPxQlojuU1wD0xDP5LypZXvAbqTnJiQsVB?=
 =?us-ascii?Q?IxwcvGfHwVPzqNnC2TdOo4Dyk+iUxcbeSiaDTQli9uC8pLAsyPvPifW51umO?=
 =?us-ascii?Q?Rk1oOG3WvQZM9AdKyGbT6bn7pxpiQqZjfxFPmIIpHbsrQGdAQc5pt9UmC3Hw?=
 =?us-ascii?Q?fWkpFdbQ8ex2jx2rUj7nq9dSOpOcahVxx0t7bqOvn6BSsTPEEf/Z/her9w+2?=
 =?us-ascii?Q?U7lRMdYd7+gMRfbLGIE8i2qHMglV+Zx5ROPdW/LZz1fk9mNeVe4BnPEOzPpW?=
 =?us-ascii?Q?FR5aGwzp3q0ndZCNfDFq8k6yiCGfMVa/ZSKrz1EIqarnQfSXRt3zjyuXYuc4?=
 =?us-ascii?Q?OEOZabJZ9C9rEulG8EkwyFLsbGLDcosavWMTKr1yXSZV6Uu0TuKMqPhaYw0q?=
 =?us-ascii?Q?hgdIE8cs3k4RZ8FCl1pS07H3KSSQeb7urnnwFceheYZPEo3VYEngIGj3RMy0?=
 =?us-ascii?Q?56FofkA/84JvaoMgjLpfE3+J2jawYfXO0wGQD44JDLTBMWZQ3doTmSNG2ILn?=
 =?us-ascii?Q?iKYGNM/tsHa9Fzf/a+DGJ5LHTxQSQfUWGjsGG4LQi79jlrY5wCRfbM0Df4tV?=
 =?us-ascii?Q?dYO4eAP71hMnqDVaVDRNNJTEp2/VXxmgQz/hpSQZufuICJxFlwqWsrNMWQ77?=
 =?us-ascii?Q?MZ0TzK9unJj7BOBlrywy5EfOAxhg9/mjn4rdCUIMErfEy3gdARGRK6ZlWgQO?=
 =?us-ascii?Q?JdJ95r1yyZrg+mc6HH/Uu6T/+gHcExY6kUre2/v95whpUPkWniKKq4RaZOJd?=
 =?us-ascii?Q?0wShnkL0Wn8bl8T6swbEHnB6ECkhTBdJ7b15pNCkWkGPh5P8jATMl1KUGR6I?=
 =?us-ascii?Q?1CqBecIVkTxRauVK+Szou2h5k/tk7Yrk3LAFyC7xU33c0E9GJbhI+Px6l/xd?=
 =?us-ascii?Q?pBUgfwhxbpxyBcsfGtZQdP1gyJmcJsRxP+HLr8xOoPCFCu3yKuxSP81N4kRf?=
 =?us-ascii?Q?yu3ucAzT5rxDEcAxHdmtfj2aBL1hdqxR48GcZc2LyXkoI40H/qi68mqsm/vR?=
 =?us-ascii?Q?6juid30l+AMrj1KfatoWmH8fZFPkWC5KCV/SadHTH9ZdgXDKqUSOva42uOTg?=
 =?us-ascii?Q?1I/7NtA/FuFbXB0gPy0wnbEmzhtmxhNB4bqB4vARTHqXmlTK3x2LvklNrD0t?=
 =?us-ascii?Q?c40Gw5AXxxynS3ClqaUxdbEd6JSpxDk3JeCXAtvsHxCki6Liflup7UqkC9xZ?=
 =?us-ascii?Q?pQh3XDiBpn3WCbwrXEKgV8SfPwult0DXDVnQdy41LxMtuZhHPpv+dNilE9Kg?=
 =?us-ascii?Q?1jhNtiKbWnNRk2D9QqjK8zhlIUnQZY/bfBq6eykx5mpewzprHl5I0Yz+Lpfs?=
 =?us-ascii?Q?Tdetqes8+y/0B/Ty3u55ACBUfKSKVD6Y5vCiiK/6Y3lUwaEbgdMFtkAKa2nD?=
 =?us-ascii?Q?7ZU31UlYn5RnPCjDjKPlSli3ybBlB/JJAL4BAR6XZR/e8E401naDBQ4Z8YSO?=
 =?us-ascii?Q?LfDTYnBcNJ5pQa+/PHAqaJG0RW2sWuMHI3bk8zEQE9vYCP95QY1aDfn4ckld?=
 =?us-ascii?Q?//FpReu0xCHeL9gOM6S2BkiuTzgfTS5reyxw2pEpyDRPx4Z+jce4tJwpmoaU?=
 =?us-ascii?Q?oDyxFhPXMTTVxxv35whZaaLXHpmmUtpXnNMiMBuRnBXtqm4VfcU6RdRfY+2v?=
 =?us-ascii?Q?TL9oYGd0LCcUVCzP4RLUI9pS8CvS4yRD3fL1TKTa2XaUb0akcRyvRXar3eQp?=
 =?us-ascii?Q?SubBMa7d1OLKJS1TfQt87mP2wogg2KPSW79gfqDRN37G0pwP2uUxnatq4gwn?=
 =?us-ascii?Q?4hbFocxvhNd/69uoYms9UbHESOalDdLbZK/mbUVbfaFWoBiXnGbk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f9734f60-b850-4987-3b44-08df23865fb5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:54.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZtlJezV+KgY8Y2327gALQAVnAxhIUglO6VqLGoilp1FHhvjMgxPonj0gtIBYV0l1hlkcECox2AN0OS1B5tuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

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
Changes in v3:
  - New patch. In v2 the R-Car driver freed its parent IRQ in .deinit(),
    after the core had already removed the iMSI-RX domain. This closes
    the known gap noted under v2 patch 10:
    https://lore.kernel.org/r/20260928165230.3397664-11-den@valinux.co.jp/

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
2.51.0

