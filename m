Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2C4F55C3;
	Mon, 28 Sep 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614403; cv=fail; b=La3DNWWcAcaz+pKfDzp5Ensh74EWC0JODt48w+o/YPMvVES2wC+h37N/Z8uYEfI7EODW7+i7U6WAmMMT4M/iBLhmRhSOaKIk9hDgx9ajN3WoCQnDSoeommxH1r6tMT80regdG1iprHcaOb+rvf/tnLlH01Su77/p8Licp7Z04h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614403; c=relaxed/simple;
	bh=7YiJmtb8fsTSldU4wy4TX/q03EwGDFbm+vzpRA+9WnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rn31x2Y6gmRBDvmg4v8DXZKJJ6fxHeLEn+D1iCYmX3gU9YcNFap7umoRAIrf36kzORD1Xq6nJy2yDsR3ciWUQDSo1g4Ew0VGYUyPTh43mg2IepQ0NVewMdSzgy2oHD0nAvi7Vlc+bLwG6qPWtxeJzZBO+CSbuiwzeh/ey0srRY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TM0Blx5I; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TM0Blx5I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYrzCJntnMQmvsRlKaSaajknvmkfRvQjdL/K1fwXvn5q5A7wcsG/ApG2h1ARAe9j6fr6PqH5+6cVaYKFhP/E31pWrf2K0j3Bsecz3Hb6QHzHjK1uRP1Wl2hIQYc3znnwgvNSUQ1t5PVGxiHcjOeoT4J9FxtwHfxdbcL9sul+fQJjMBj8CfN3BNXudMHGFpi9uy4MCBfTfpU3lOMY3itwOeMun+SfM3D1JnjKxniEhrPMYCvQkpbSFzhDhwul8QT2fUR+Kn3wB7zqR2FpfK7lh9yv5bInshwsJx/VqswQnbCHPYDoVWW0NssNt42Ill46cev66TMKseDC7WdfAhettg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df7GrnResB/H3iPA26aEiWiray8J3E532SYuX+HTPik=;
 b=VyiOdAInE1TE8//2dkYEe2QIrqdvJCnaqg7FWndez7XJ8JpLi5A4ZIEb8Jpv78CLXOJDWYp6ngKwjYZn5/jNG1R9ND3TC5mopK5NlaJfDeInlBkYXSC+U3vKqLc2YiSEEXY4wU7yWqu5SfQIBErhP7XFSQG/gCht7Ua0o57CXxquYnB7l/Nw9UMuwP6SEUncxM0cAsGWnccHHJ9nqEStBmSYizzyd3Ig/hOAjgKsS9FyioJc12EHXlv2zxZC1zj6761bw362pqv4JI8Ogu0+a4AS7rSUVSPAJ7EbROj2wklnYOgt1OhR1y5qfpygb4ktRH8+8+dCFxLkpFzaPQWw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df7GrnResB/H3iPA26aEiWiray8J3E532SYuX+HTPik=;
 b=TM0Blx5IZdLJdqdkPqc8MOzlPEJogxHTk8pk+SeD/GXEMBaTQGtKok6KHuKBokjTXt1hNQqtgcRPFE0D1RAZ7aZfckz+fN+ggKImhe1+1rE9oeTw3da8/s8R4/VrRVzDG0LqFMWcafgSW97gkL4drWjVlyp2bRsHAhjXYzmznm4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH v2 13/15] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Tue, 29 Sep 2026 01:52:28 +0900
Message-ID: <20260928165230.3397664-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 12633c42-f627-4a0b-c71d-08df1d80faa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|5023799004|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sqno+lYfGdYCLAfMXLQY8xSOW71h9ovOfPDNptKThz92xU9IlqXE603xYCUkeretzm2xYtdO6FWzPTColFvVEmVl5rgr1pvLKk++r8/RPEOGi7AZP7r0+/iPZVBqyAE25iL9A2h84uw86ofhiUaoZ9dJ0+h2q2TvMOewzZHvf5UzXXNPaMTElF4CGhiu5CGfl85ERCElNKN7/uanDXonNYNIboWqOgAff5HpZ5cOvxkDE8927aZHv8vSb5lUQ8xTKYT7AaCSF1K949SY0Ai439jedeE5/1JBtoZfw/irCeSp7lp3xJ4HpdXfj8TQqVpoArCCC8GrMP7B1Bzo8Rde+RpRz9WRhvWOyjJjL6ljN5QB1gi6VnWcc4tmV1Tg4OKw5LtxYiA7aZADPcD49H0iYgr4cTXaGhwDJTCDls7lFTu9yozaBFh+1vu0rsjAh9hf5gXL2Knd28SnSG1OWgG2WEiprZkLhZfogwDHlDSNba4wvZRl4rBhU7dildY7VDydEPh3mUsYnu8aANToZQIMPzehe5W/KLIHr4bYMdmfKIgpSUJVdy5ELLIHDH70aAo9byxYa42wcQpZYMU5mbO53lu1hf8Jk626DFkKfTM4XET6b2s+paQIcDPCoXccTW3zb/xH7yqJRZZmtKTq6hvVyYUioYEApaDTbYn4w8muc5yegzBWUcWODLDNvwGC/EaRHqACBNTI85Lnf18Fh5qXXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(5023799004)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uf6OEUzvsITRF+m7HwDJZH8wMcpBJ2fGUq6Z+MdjgwikIoKnf/KszINbHrh1?=
 =?us-ascii?Q?k8l+U4zUcowC79yWjsZEEx60jL+F7es1PTw1+iUZ8AGyhix6zgeL45QdXWcV?=
 =?us-ascii?Q?h0LStMP39GNfdfWTnte1smrN6ZJJ+/YBHeQcO5KgdJuel6Ncx++mZHPFW+Q6?=
 =?us-ascii?Q?s3Vgh3f2wbHwc+SwHsCzQTGsrELq4lmfx72EKC54gQxqhrsDtfNITyiVSTyB?=
 =?us-ascii?Q?R5OpYTDuGtSJTfWaOUFkWYWpbtvpivMAC/i1y8Trqujv0KPHp+f9UtLTbXKn?=
 =?us-ascii?Q?RTa/H/abZtn2bgZ+nrsZwrMCQx/M2BBKSwpzq+lte/HDyqtABaygNaLL8oJ6?=
 =?us-ascii?Q?b+5zrCDSG7nHIYrUu2p7I7BXRTV33K6M72Aftk2zhYVmKXfH5P9sVWQSNYSs?=
 =?us-ascii?Q?h4xcmb2KHiILIMZpjfGsYVocyVCkuJjcaEMWe+jQOjjZIcQwCUFGEtr0KmDE?=
 =?us-ascii?Q?0NMbJA0oO/VEGO56rbaL4Vs4/MWpaB7UAFnKnCDdFP09fcMpnuDETkvc+FAu?=
 =?us-ascii?Q?ZSSDc82A21LhHH/uP9G6UEKvzICbYmXpmfwYcytD9m4qOsxIDNSONhRvhddz?=
 =?us-ascii?Q?3O2BfxG/m+xT7qjCT8Em2kdYNWy+8Abst2Z537lc2o35/1Xs/KIU/jTrjus0?=
 =?us-ascii?Q?OMkhSy5f91omSb/VGjeoGMuh71vANirqzhECpTnHdYrJPKsIPWQjiy7hcSfI?=
 =?us-ascii?Q?34d8FXStQLYzESn5pA461b03dcZj8+pt7F+UxsO5vLA4fOONj79vK98OfQDq?=
 =?us-ascii?Q?iAKdEtdzygF9W2u6VzxirFStC2xDhAs8WYT6UI6+Hyinxa/JcWHcnGae80a8?=
 =?us-ascii?Q?F+zyMXUEpLWJLOKO7dJVM7Tq0T08yE7Np5j+Dw/dXoObX7AsiC76J2sH63La?=
 =?us-ascii?Q?MG1tpRHNXOan8IToVE0NN1B5UNmBH5c0ZbLjuaW/NQgEwvlIniDCnIOCWT+n?=
 =?us-ascii?Q?bkg2EA8xT2PeJoR73sbJohXP4P+XJivrlWWn8aXglIMQbySHfYylIogfF5f8?=
 =?us-ascii?Q?POfxY6MEDjZz9aZTM1VVZFqflfUkOG+lTLmQWHR6J8AbRsNxH3grbq/yE5ut?=
 =?us-ascii?Q?MSbYDpb2PQCS+6XrALW2f/BgOZx5QCIrXn0g3Uef3x6Zt+MvAH/cIfXTGKZi?=
 =?us-ascii?Q?z5y7bTEFqPKQ0QjYJtKUDgGDG7heEDmIeK9uBrjBwzpJ4m05R6KhKbsjNQB3?=
 =?us-ascii?Q?vyxHND48a6n3bVlJVfAeqB9TnEWHjQ5bJoDInIolRjlCXirLmwp2G5oWMAp5?=
 =?us-ascii?Q?BSwvJJoO/paD+GZtRsNGnCZc7ewI9KvG1P8Gwhv8WBWZpZGUmIQk8MjO6CqD?=
 =?us-ascii?Q?/izUkaeR7KIgz6kXa/lst+G1Uz6jxjgRpgPMDjB5o0UscZ8lzvwmHGlMbkCc?=
 =?us-ascii?Q?rcsgptMhg9W7YCLzRNuuKRXY6/Za+ImY3K4cuJoX34Po/6vtn0UVI+xZ5JyL?=
 =?us-ascii?Q?uhDw/OAT9SLFSigy21Kv0BgTbIbstxeTDTeruzRYWyk8lh1/yv0bpB3GznYA?=
 =?us-ascii?Q?4QsOTH+RiAm/abhHEr0UQqKft/bK2FyoQO3YJqvImSDwOyD3O3qzhcDrKBrJ?=
 =?us-ascii?Q?sI/qCHPqJ+2JtimU0W+DuwRW+Mkn0dOpxk8X9nOIb0pgRjrqQ1wCPsxyF/Hx?=
 =?us-ascii?Q?GwZcEbdUTo43kvoTJivW2GBEIwBJiyvkXcohsPy+3I8/1WFPK21/FOnKJH0N?=
 =?us-ascii?Q?bqmgaxXtDQged2G5k5AcMNLzkPL5E4xgk3wSX1Ypv7gyXcZS/COAUNoV1RO+?=
 =?us-ascii?Q?dqs8JlDTL8k/qb/k5RMUZxEpOLbWo2l83EkMv+1DajlOJz86SUOl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 12633c42-f627-4a0b-c71d-08df1d80faa1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:10.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqfxc+hI/2Ex60+bK8kZUHBwFqP5HI+sG8O1E6jtHugWt6z7KNYGOuSvsoFvLHZ4pRYTVvLovt9q5bvqLdpwxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

On R-Car Gen4, the APP block exposes the Root Port interrupt signals in
PCIEINTSTS0 and routes them to platform IRQs: AER to intreq_pcim_lperr,
and PME and bandwidth notifications to intreq_pcim_sub. On an R-Car S4
with GIC ITS, a link retrain set LnkSta.LBMS and latched PCIEINTSTS0[23]
(cfg_bw_mgt_msi), but the Root Port's MSI never fired while endpoint
MSIs worked fine. With iMSI-RX the Root Port MSI capabilities are
already hidden, but its INTx maps to intreq_pcim_sub. Note that even
before this driver took over the IRQ with
rcar_gen4_pcie_msi_irq_handler, the port service was unable to request
it, as the DWC core used that IRQ for its chained MSI handler. In either
case (ie. iMSI-RX or an external MSI controller), Root Port interrupts
are not delivered to the port services.

Set no_rp_msi so the port services always fall back to INTx. Allocate an
IRQ in a single-entry domain and return its number from the bridge's
map_irq callback for the Root Port only, leaving downstream INTx
mappings unchanged. Notifications from different platform IRQs can then
feed the one IRQ the port services share. Route the AER notifications
from the "aer" interrupt to it. rcar_gen4_pcie_host_msi_init() sets
MSICAP0.MSIE when pci_msi_enabled() is true, and hiding the capability
does not clear it, so handle both the MSI and INTx forms of the status
bits. DTs without "aer" remain supported, but the APP AER notification
sources stay masked.

Preserve the virtual IRQ's enable state across controller resets, but
keep its APP sources masked while reinitialization is pending or Root
Port events are disarmed. Clear only the MSI-form APP latch, before the
AER handler clears Root Error Status, to avoid clearing a newly latched
notification.

Handle pending reset requests before dispatching AER to avoid unsafe DBI
access. Serialize dispatches from the parent IRQs, including the "msi"
path added by the next patch, since handle_level_irq() could otherwise
acknowledge a concurrent interrupt without running its handlers. Recheck
reset requests after taking the lock in case the other parent has marked
reinitialization as pending.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Adapt to the driver taking over the iMSI-RX interrupt, and keep
    AER notifications masked until .post_init, after enumeration.
  - Clear only the MSI-form latch through PCIEINTSTS0CLR; the INTx bit
    is reserved there.
  - Serialize dispatches to the virtual Root Port IRQ.
  - Revise the commit message.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 220 +++++++++++++++++++-
 1 file changed, 218 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index aa80232afaba..c01f157a7198 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -14,11 +14,13 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -60,6 +62,11 @@
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
@@ -69,6 +76,7 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
+#define RP_LATCHED_MASK		AER_RC_ERR_MSI
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -134,6 +142,14 @@ struct rcar_gen4_pcie {
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
 	bool rp_events_armed;
+	/* Virtual Root Port INTx shared by the port services */
+	struct irq_domain *rp_irq_domain;
+	unsigned int rp_irq;
+	bool rp_irq_enabled;
+	/* Serializes dispatch to the virtual Root Port IRQ from its parent IRQs */
+	raw_spinlock_t rp_irq_lock;
+	/* intreq_pcim_lperr ("aer"): Root Port AER notifications, optional */
+	int aer_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -581,7 +597,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -589,6 +605,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
+	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
+		val |= RP_AER_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -689,6 +707,21 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 	return rcar->reinit_pending;
 }
 
+static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
+{
+	/*
+	 * Serialize dispatches from the parent IRQs. handle_level_irq() would
+	 * ack an IRQ already in progress without running its handlers again.
+	 * Recheck after taking the lock since the parent's check may be stale.
+	 */
+	guard(raw_spinlock_irqsave)(&rcar->rp_irq_lock);
+
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return;
+
+	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
+}
+
 static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
 {
 	struct rcar_gen4_pcie *rcar =
@@ -779,6 +812,170 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
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
+	 * Clear APP latches before the service clears Root Error Status so
+	 * we don't drop back-to-back notifications.
+	 */
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
+static int rcar_gen4_pcie_rp_irq_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	struct device *dev = dw->dev;
+	struct fwnode_handle *fwnode;
+	int irq, ret;
+
+	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
+	if (irq == -ENXIO)
+		irq = 0;	/* old DT: Root Port AER stays unavailable */
+	else if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
+
+	/*
+	 * Note: suspend/resume support must not tear down and recreate this
+	 * domain, as the port driver keeps the mapped IRQ.
+	 */
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
+		 * PREEMPT_RT. Released in .deinit, like the "msi" IRQ.
+		 */
+		ret = request_irq(irq, rcar_gen4_pcie_aer_irq_handler,
+				  IRQF_NO_THREAD, "rcar-gen4-pcie-aer", rcar);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
+			goto err_dispose_mapping;
+		}
+		rcar->aer_irq = irq;
+	}
+
+	/*
+	 * The Root Port MSI capabilities are hidden (no_rp_msi), so the port
+	 * services fall back to INTx; route it to the virtual IRQ.
+	 */
+	pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
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
+	/* The port services are gone; stop the parent IRQ before the domain. */
+	if (rcar->aer_irq > 0)
+		free_irq(rcar->aer_irq, rcar);
+
+	irq_dispose_mapping(rcar->rp_irq);
+	irq_domain_remove(rcar->rp_irq_domain);
+	irq_domain_free_fwnode(fwnode);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -879,6 +1076,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 
 	/* The MSI status lives in DBI; keep the handler away during the reset. */
 	disable_irq(rcar->msi_irq);
+	if (rcar->aer_irq > 0)
+		disable_irq(rcar->aer_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -889,6 +1088,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
 
+	if (rcar->aer_irq > 0)
+		enable_irq(rcar->aer_irq);
 	enable_irq(rcar->msi_irq);
 }
 
@@ -963,12 +1164,18 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_deinit;
 
-	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	ret = rcar_gen4_pcie_rp_irq_init(pp);
 	if (ret)
 		goto err_assert_perst;
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		goto err_rp_irq_deinit;
+
 	return 0;
 
+err_rp_irq_deinit:
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
 err_assert_perst:
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 err_deinit:
@@ -984,6 +1191,8 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	/* Stop the handler before asserting reset and disabling the clocks. */
 	free_irq(rcar->msi_irq, rcar);
 
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
+
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
@@ -1007,6 +1216,7 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return ret;
 
 	raw_spin_lock_init(&rcar->app_lock);
+	raw_spin_lock_init(&rcar->rp_irq_lock);
 	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	pp->num_vectors = MAX_MSI_IRQS;
@@ -1016,6 +1226,12 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	 * iMSI-RX MSIs from its own handler.
 	 */
 	pp->msi_irq[0] = -ENODEV;
+	/*
+	 * The APP block only latches the Root Port's own interrupts into
+	 * PCIEINTSTS0; they are never delivered as MSI. Fall back to INTx,
+	 * which rcar_gen4_pcie_map_irq() routes to the virtual Root Port IRQ.
+	 */
+	pp->no_rp_msi = true;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
 	return dw_pcie_host_init(pp);
-- 
2.51.0

