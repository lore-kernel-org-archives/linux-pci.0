Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34063DC85B;
	Thu, 15 Oct 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035100; cv=fail; b=UjzJ0BWvKE2HlOKlpAhaHLfl172ul0K0kbmkOiSc2k0WG7pqJsSfcM2wHB8x2f27NMBOATW6gHPcBSx4M8nJGLbzBrxcL1K0214qGw95kWg8gf3rpYa5fpCWM1UFyElcpr+yiUChFNx+WrIL0iPfc8qY84zfr8EwVj+lxIIf1go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035100; c=relaxed/simple;
	bh=GTk9Kb7lKjpUNgeB7a8QPamxY7gzQ8lcaNP+uzjFO4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfYtBTp9tRHUz+aax0JEu04ofKXsKuhGegf0KZKgnZWz0nCgv1DWIJtuk2bfFLROowmK+c4ByUOcqdwjSc4rOwrWO6KMmGe54OAKUHYQCDacE4KR/M+2i4OKWE6GQ7iUFoCBZwDY9SiEScRjXNDB3Fgg6fmboAqvve4MvQjvVTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cFTZSStF; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cFTZSStF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyTHNLe76DGPzJ4bhjehVGpu7wLWbG4cLDYIODxiycrN2r8Z/uWiUbt/WGwlA78T3KF7XyRB0mL8xS9W6OTHYC3O6CzqjML5KoEghZcr+gpkEjhvzxV9v2L6bM0X7MauZ/hxYci97kyHUz74ko/b1ZzvW6yPUWkVStQ0o/Z9T2sP3Dh75YEEY4VhwPQdNAQRVQOWCLJm9OHbri4mLnneaet28jfBr2/SckyJtJ8CjPPJ81f5K/HwK6zXOk9dKXWzWJZWapRKu5qJ7cTO482NOKNYdSPIr+PRQ3/UWe6lnSnSE1/3wS/T7I9DE3X+RYSiyVy63YpSw6sFdyoCQLpNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq1noi2ka1C/7vAb4M0SEvi8kYFsH9hYg9wvJdNWcek=;
 b=x7wV8Hkd8saLRifLcF6sMK7WzJ8T/H/9zuY5u7k4UxtnM50IL66ZtWoOi/IXxf0vCcmk+yGimkL+CgNvQDo18hOHzT7BEnBIGgQAp2MiEJPvT/btHdaQPN2k33FvFBKSUVYKVMzCZfV6j0biG6PzjQxxJ/qc/EcJhjhsvbn239U77VdeGWlL5U1xZS9EOmG3fvIfoS53obc3znxoTqyt9s3Da7Gi0RKGyiUuDoz2/CEK/bnYkJfN6MuuuY0XvbIdhrGNiHFrG2R+gEOx67jCwJuNYndlrWtiHINnZuF2p+25qNdb64I2DjpeF5qY9zBWvesnJol7Xb6yWdBww2Gl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq1noi2ka1C/7vAb4M0SEvi8kYFsH9hYg9wvJdNWcek=;
 b=cFTZSStFH3Tzp9HfvUGtHlPgy+F+VoaEhzt6inLSWTQOtojMH9jvVsEDTTBTk4OCUEo7jLZ22V1TrCF2rR1Lnbcaw8jAsccZ+RQVz22325ci2VssY5vJ1Hq9fGzn9pHnCakmVMdTCPrk0oNvaREWTCdz/e11N/maEWgHJeGNfdc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:22 +0000
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
Subject: [PATCH v4 14/18] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Thu, 15 Oct 2026 12:30:59 +0900
Message-ID: <20261015033103.3076869-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7bad2d-ab76-4397-094a-08df2a6cc890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nhjpnMki4MaG9tWL/KE+9+besD/e/n6thvBn3Dc0Yw7OQ14bQL4k7ixhIyWZZQNkK7puBce0JY+1Xc713YMOqAQWFzW2K+xCcB6/sKA6e3Gy9d5lHrbsBzgTFJ8LmJp0L93siqdkG85Z3bDdIMCM9WVhcNNZwLS6GqTUSN10qSZeeg5n4c9HeINfiAS9yrr8UHUFHTK2AidwsHlYJd2nfuW4qJTw6hEyc1oIiEYOxpl3Qc1GCkRSysYD699V8IJwd9HyplRAsFeVWgQ2EsaUS/aUZ1jOJTyHn45+Uq1qi+KXzNueXleJH+LMlNpfMLrk2+7sUecnKgvpHOMQ3XpIX2ro0vPEYMdPECOXVIMPmROUSgYSH8HLUc1J9nIWDzPZB8Fk+ElxNy8eTV0AFpkUCt5bBvyw5iIBoZlf4gQA6UBiqqJ0hvfOixhImkMDn+AkMYx6I9wdRQlMX5bhSgIBa8cnhlEwpTvBXTeNmtIewb9YJwUKZEx9DFEwXImZx06grY66HhMiMwPQwAg6U7jjBumKEFXfUFCKD9seXXqDaUOTP9Wm0TigaCvyj421BHsUJeLVWllEnCHLOCg//dH3XQ7A/b3/8r2cXeaQzk62JZjq0RsXUgyho79Y0+qNqKsyOpjXVbwBcIR5DX+v1HU+wn1m85FjOMNF0ixZvf8JLHmBqg7cWS94CiL7HLSHI0ktoLKH2L6ub8QG2Mjjb6OMiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3R8xzpmbPFJWU8OTdDbiL6jBmv4Z/dpxuzJ00Sp5Femv8SxxJsMkVCjBK7jI?=
 =?us-ascii?Q?EMgWFfyOgP8xTk1l2vNhgmWJdRtjpob8QbZLKGWBsl6rRSFN7oe5+2afOrXR?=
 =?us-ascii?Q?3nA295DhJoSJkSM+gwaS2A+WZn2tpYUep0ml9EtFZm27TTFTJ5C12WqY2i/d?=
 =?us-ascii?Q?W+t+tWcgo+RW0fJpdPahpSctmqnGTfInEqxfAMlNiG2ukE3wmPj4Sl9RPQrh?=
 =?us-ascii?Q?t66/6pYhD9EnIGh415gFGpcCdPaWpSICL7qrTi0jbVGXW98DbW1Mq3iaM/Kb?=
 =?us-ascii?Q?68YwlULVLLEbr7O2pVMBNC/lcYmJpfPDpbgSFTc3SOAV3crHlOFqxT9tBp7X?=
 =?us-ascii?Q?iofdt2t3Tx1Xk8HcHObgkhAQtBo2VXZLiD7t1XV5+xbWvajY0WwAxUDEFRwF?=
 =?us-ascii?Q?z5BJFK36K0KcYB7wO8gaLrnpLekp/Mlex+cLzZ7obcX3yNGUXKCtVEjt7PWR?=
 =?us-ascii?Q?R48vRjeo0w9HE+nrVCYZLYUTbq9ExZSz1mRSQSDtFzZuMM1zlbI6SWSI7lmS?=
 =?us-ascii?Q?93hhd/T8NXYx4Rvpqe1751NcXWnDQrGSdNuLgcFjrRx4q1Gbqor85+SoRKCo?=
 =?us-ascii?Q?dJ5QBXbwITWleIY7EIY6pG7+HMMRODnefTEO2+B0NvZp3WCPnviMHaHf9DH2?=
 =?us-ascii?Q?jfE0uIcSaEc3wsnProEfjuh8lUt7c/m4Kkibov78nvn+mi4k6yRdJ/OSCtRd?=
 =?us-ascii?Q?bpYSqkUFSfVjwle9kj7LEBzzXFkQERri8EkuWO5lQGAqjvDEgIT4aYYLTANW?=
 =?us-ascii?Q?n7ho8Or0it68QD4iZomoV+JfGUYhMBLCq33ujU1oxhvDu0Dsrz8+eXkEWNMB?=
 =?us-ascii?Q?q8gEvVR0aoeYw5tiQ4/Pds2Ke9q+NY8c3y55Z2wZBuxqwLk2hc4IYPlCaBLR?=
 =?us-ascii?Q?32TlPrWqwlyDES59Abvr5b1EPQfjXL67xdz72uKEHwu/ivlclfdKysKseany?=
 =?us-ascii?Q?e9ACDYKwR0qdbenSAPViX+fLNqmUQmhK6ZYNZGumlUWSVVKyA4b30unpgnTN?=
 =?us-ascii?Q?0vBkGhpqNs4set48eZmi3KnN8IZw/ZysaQV7cyLF4rw1Lb7MM2vAlceS+VRN?=
 =?us-ascii?Q?dvLZB8MooNKYRl4YXMR3AWuWBO5iXwHbOtjyLeQ31TUTFEH4wKDRDGIuHbWD?=
 =?us-ascii?Q?lYFlLClp9j/MsN5TukmaIJs8H55Zb2XQbsBdijv0w9F0xqz1p6e5FO6r5bzK?=
 =?us-ascii?Q?e3+tfAWpA6Atgh+tbu6aGUvkHsf6TdIVyArfqyzw1aJyjUZuW19ge9M6UjaU?=
 =?us-ascii?Q?+5ancSJJ/GejHQAn/AYQPCacasVkTgQCJIvXhqip9tRYv4NPFvfdXzABo0Tk?=
 =?us-ascii?Q?XpG3ZE1NhJgjnbL4+h3w7Ni6eX3WdDXzCpWDcmcGCBUUYDBDQ7ErUw4YPutn?=
 =?us-ascii?Q?VVdbyDMaT5AL3BFRmLF3zuNRXnoYyGoCJkyHWT14Gu4Fv1ViaQjCXBjRxLFL?=
 =?us-ascii?Q?T7gP/8S5ZNtJGJSR1nxYEVfFu+yx7hKk7iJqZ6JaZgFak+/nurdBW5a46awd?=
 =?us-ascii?Q?lUYINtyJlBSf6++xXBDGjKhwtMl06+ogt1Z1V/jmoG+XvDie+AaVJLJ8o0tU?=
 =?us-ascii?Q?84k0XQfzLwcBw0YIDc8iPezUF6BaBwU7Kwe0AlQqkTiQKWmn/wBjzCG6GgsS?=
 =?us-ascii?Q?wTHvefBxarJSlmwH7gXg7GdTO1oJ/K3atPjr9fQU5qlQnofuTU9stBARUFXR?=
 =?us-ascii?Q?XIGm9dAOKQ5MNGx+fJyAUDZdDxHNyVRWQfWWWq+Cs0i8axy7SlSl8eFgDzQh?=
 =?us-ascii?Q?lNevreEDBUwlKzAtWgaXTjwMFVM0ChtLrHCCrRtSOrfIQzD/Lqj8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7bad2d-ab76-4397-094a-08df2a6cc890
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:22.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2dVQFf5icVd1lEMH7G27JRj8i0ilcC5YT7slLlcd0KqU94SKISDi76AFuQL/bqB2vYsZbrfdubp+fKnX6MTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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

Set no_rp_msi so the Root Port services use INTx regardless of the MSI
controller. Use a virtual IRQ to deliver notifications from separate
platform IRQs to the standard handlers. Route AER from the optional
"aer" interrupt. DTs without it remain supported, but Root Port AER
stays unavailable.

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
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 216 +++++++++++++++++++-
 1 file changed, 213 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b8a5bfaf0bbc..db0d5362eaed 100644
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
@@ -676,6 +692,15 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
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
@@ -770,6 +795,162 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
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
@@ -870,6 +1051,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 
 	/* The MSI status lives in DBI; keep the handler away during the reset. */
 	disable_irq(rcar->msi_irq);
+	if (rcar->aer_irq > 0)
+		disable_irq(rcar->aer_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -880,6 +1063,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
 
+	if (rcar->aer_irq > 0)
+		enable_irq(rcar->aer_irq);
 	enable_irq(rcar->msi_irq);
 }
 
@@ -946,6 +1131,12 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
 		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+		/*
+		 * The Root Port MSI capabilities are hidden (no_rp_msi), so
+		 * the port services fall back to INTx; route it to the
+		 * virtual IRQ.
+		 */
+		pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
 	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
@@ -1004,10 +1195,14 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
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
@@ -1017,9 +1212,23 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
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
@@ -1027,6 +1236,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	/* Cancel recovery work before removing the PCI bus */
 	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
 }
 
 /* Endpoint mode */
-- 
2.54.0

