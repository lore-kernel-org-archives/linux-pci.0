Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160163F1040;
	Tue,  6 Oct 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276431; cv=fail; b=pZohQuj7UamP3/2mgC9nI9Hikr+9/TssRfr1GMbd1nUcoBaN3ADFzjYAWTp0ZjsLwyGDysscF0E/ClmdcqnGC/w161xjWpLwlpIM8C9121rAPJ3/6MombwmmIDzJJhyltcSexxGugvInnGJ4x9BKYQ1MVCCMJ0vpAnERbByD2eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276431; c=relaxed/simple;
	bh=P4jIZMu/S3lArjQgn0tx6a62Pe5T5BQxJdiXYOj3u3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2NIlYZT+UTiwl+ttJqF4+o4477yWmkmy0ZHF8SG/vWBNmR/A2F0WfoRM36o/8W6QfD0A6yS5qd8RD6tj2Fr8R553SGQiIvkY5p6dAvcXbQYe+Y6SuSoUZ0Z8XO+ouIo9n2JoEdLMuK9OkiYeBqSN0XT/wZdleJrNh25QnJodxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eMj1lNK6; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eMj1lNK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO9ViGy85NaDZqKE6byY0u/QclqUI3DTXmYq1b/Mu/H7l+d8HGMxbs6c/gGZSid08zn6+CHppkXhu3calS/Gvq5fFbCxjCU2cPeGObzojt8y1Td49BLInZ+DSKJG6f+Na/Do3qT0ziDOmEDDZkDYTXL7EG+jgLpP1FjFglOBWVfWIa9w2YhvUPizVwAvxLfrrG6mtR7pMLtRFxdkBxF4kD2uYmWmB2IKorid3BEovRzvR4AoLoovwQ5Pzt7CpzQ3SNMxkgsnEp+t1dUjZvIYgzeXon/hEoSGQ4KSyIrlOrGzbFIWba87Oys57GT4MIOPBESVGH2kM6Mmyl/dl3GNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdvImlOCcbx/Qt3M6m8fCLrr9t+KZHRUc3MgkwrIYMk=;
 b=jstEfQE5BMzfBLOU/jLphwhhhtYCg136/dAAsBUiWsxYl34dFod60PvmZ8UldiX/0NYMkrIMYatx1IzzZ5mjm9zAONvq3ngUwe7y6Dys0P2ZjaPh8+srLTEEUaDesuBuWbM4mW45D88c2lVVzL8n3pgP/xMXc2G4HfSAAagGL1y6MmAVYL7l66L3fJeaMDXPUT2yOE+ajOK9E1dz/4OX1AVvYX++6Arzk0pGlXqzrKG23DxmgXcaaTOWLyBN2H/qkDwXX8pxLHKIfiBGfvyPjz34Z7gnvHXMaxqXhnHLWXUa111OMzWnoGwnUS6RoIgEw+twH1ad7zHmwURrVCLkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdvImlOCcbx/Qt3M6m8fCLrr9t+KZHRUc3MgkwrIYMk=;
 b=eMj1lNK6CirefXXKoLP+eWjl1JP4X63Sw9uVcnJjsTv5DBbrrrHZC8Qz6PeMyZewjm2So05S/dzlobuq3LtO3vp2pG1GsEB232YZdX2+Xa0r5Qw5CBPmAex7XKMa/ZhIw4ciEN0UYhlyJHGhUC298daC2pMmkdIbX6zrHERzH6E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:59 +0000
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
Subject: [PATCH v3 14/18] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Tue,  6 Oct 2026 17:46:34 +0900
Message-ID: <20261006084638.3821710-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f18534-c21a-42e9-e047-08df23866233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|5023799004|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vtdmwIB8gMEN59BTmZ/x5bshlQkibF5v20f4ZzFfbvPdjXU7m60poQMYoptGbn1SBHmDv3QCBgktWr0FYa+A06wD1dBHalckjWdIsUVZYPCTIBZiklqV6jHv+3a3rW9k8qieZQRkDoMOjRcHDXXgVGR3riaDfyiAWg9ua+7FbjwDM4frlJc2NGPukq5IFi97LEmN3l+N6W2qk9CT55YcCGXOXyzM/Jf987GTAkRprfG2FtDvD7ITFEd2Gw2FihIrMTzd6RfHZ73pLCXWgnwWhexSPMFD593YutT4EtMtzZJv+KQj8j3IMuAn4MJ0aRhqoTFvuAZltpqFn6TVw4Z+Cq4MrBU/Z5me+gdC5tiZfD87wNRRXqStuxDTu6i/OwSYUp0BUCwyxvG84l3eDzOq3OUrM8CaOko6TisXMPmleDsP5I8DJ6zdjRWx9vs3jgWBb69dVCw9xDC2PvAQ9MFju4SVk7uVfKZSIhkBytxY7YMf/4J25qZa7Uuyn9TDw/QQtoa2dzDyLzvIUN6UTZkyj2805UPf+3HTR2EYw8i11YkFj20Sm/vcO0GO08ZtiajHVaoOv4nhL6dVg1moVeALFetY9E/Jo3MqTz7uTR7KK0Qi4cgFTuM0ccXyLb6IjbgxxB+EwZ4O3kOrI3dkXLSMBwPy4NelVVUZy119bf9rlXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(5023799004)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PQUEuszsuExGDqddvhXbFmbMQ5SUafwsV1S4jagYO6Y+nLy63hqsV89y+VQ?=
 =?us-ascii?Q?yGOr5bK7R6pB65BqbJD/Y+SSVRqcs4+dBE/jgnopr9B5CE6RlOEx0inR1tGd?=
 =?us-ascii?Q?cIUn+WLEfVw3O7cVty851gQEgD58R42bEo1PDIyI/xSox4T+OllWzSPFbkAb?=
 =?us-ascii?Q?4F33iJ/XNMqo9q5iVfLLxnXfSInNAqPBDRFIlB7sV8XJ8ah5z/c/XXYY1Kn8?=
 =?us-ascii?Q?VRq1tCWGlyRxLTVSd3WWlHluGWvJK/hGdfiPKfFPMTi3uG0BWokqwyDV/Sk3?=
 =?us-ascii?Q?/m1ysslxT2dVINL2Df+dywnBXWPqXaJyGPyjuwLTQwFA623jGkpCNi6XbE3/?=
 =?us-ascii?Q?e+ojiZi58j1F2GzLGeK9vl3y73/GZoktKcT4J9RgTYpDet24z3FyAwp3PPYG?=
 =?us-ascii?Q?9FQiAj1u+Lkq8nTQIHRWsV5fMhbBeXKLdEJa7WhZ5+AC/ZYOPwJFsLQGHULx?=
 =?us-ascii?Q?aDzflRfNTIXV3fd1armp9EpiLNp1V9/G+oaVdrJWQ3nujEkH9mDqlz0H+opJ?=
 =?us-ascii?Q?yOfaikg/tkEdPdWLF6ztpbvlJFQWJ2MDO7v0iowSovczoZezxsAjaVuxkG8a?=
 =?us-ascii?Q?/KNXl2B/dkw4RyDwUhNdoRlrOECoUIbGjNY0N5Nl3MH6NgvwTptfbydDILiU?=
 =?us-ascii?Q?WSms6/2+pEvz7sf5nXTXeQjYK7StUF2gCYuS/BeK+8XGpwAJ47xQXmPtpvl5?=
 =?us-ascii?Q?R3s6agXvjqEI45J7I8BGztShnML2kvPkfSiwQURdT8KoT2DU4Xl3BAnWDb/r?=
 =?us-ascii?Q?foV9oyAD7NJrsUO3WuKP0eadOtxJvQOLqmu6ncSNudt4sf9vcYKZ3c/hrhd8?=
 =?us-ascii?Q?vEZkw61ZnSUD/Aa9MVEpjTaolhSeTm4+RR5DoZXrCFYqnOfH+kbbstIaAt6p?=
 =?us-ascii?Q?FS0dpKlvPAI8pBm9fmtEiHxTqvl1/1KRDL+Ggfe8CAs/r1+v1ZWKkLlKueaY?=
 =?us-ascii?Q?0UBs1RW1gcWtdcj1OU0w5ix2z1HIQBII1I3TlvHwrIcTRmy/SopfPdCJpaO/?=
 =?us-ascii?Q?80J+AKthb0P3W2YFQE45v9QWBADtTDSqexKYzsLr/LyOnh0pVwe2Ep+pLStA?=
 =?us-ascii?Q?fUmb1AUNo+CuwrBxn8WfhgX46UYV6H0cidBjdh381NSvKsiCIbekY7zPvjFo?=
 =?us-ascii?Q?HEs2bo0f4jP5CiZK4uv56KjFVue2CMnoVpAx3Y00UsIQbv8GADZ36tW1P9LM?=
 =?us-ascii?Q?veGVzMG+2l9+fsRhKl6LWDtZByuQl6yKR+GXJ1knXrkLsksmiuEzhPinI2rk?=
 =?us-ascii?Q?h+/6oq6Xormo4nf6j7N4a3kPcU7dTohRCmayHsQtDfawfhs4vbwybwWz4NhV?=
 =?us-ascii?Q?+jEkIQ74QAr2n/PIEqqq5B8XBbcKxcHtRpQ9IajH5tZzGSRfGflXRxeAnnAK?=
 =?us-ascii?Q?Zr8GpWG/IDXkuCMSOUrFrsKdycfCxL8d91vFOUVgeLW8shdXfCN9HQ4ThGWu?=
 =?us-ascii?Q?zpbF6GMlUt9qm6XMG9Gmye8+S1o9weJ+WSfn/AimA0VZZGmVZmXm9V7iahsI?=
 =?us-ascii?Q?tM9Aur+/pG0x3TNuHy1B6MRqlrDwTcOOehQ/j1pIybn/2/JMIlli+9axVjHP?=
 =?us-ascii?Q?3z4GOfG5jpFzYJUug76nxQ1k8pjP8AsOrVQL+EjFgt4sK+gfl7Pw+dhFkm4a?=
 =?us-ascii?Q?mTA/zEAHaUb8jY5nw61Ami2OCR1vP4sTLc5m2MSQgjboaYSCz9xW7JfXYdop?=
 =?us-ascii?Q?XZKIlnstt/jo/4MN6ri64WQv+2nf5E3YGT03ZJj0VLgRum9oqfXXQMFj9uGB?=
 =?us-ascii?Q?P4dVmNpwxhzal1oVgPcML8FAa+N8M+g3udFr8/j723dunjz2g+ER?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f18534-c21a-42e9-e047-08df23866233
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:59.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBxhz6GWyn5QaoexAQ0ooiJiw+70tm+MQbpV1RVCQyWh6J0TknOuzBpTGaXrmbsMIsKFUmWAaiQcYpCogEeHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

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
Changes in v3:
  - Create the virtual Root Port IRQ and request the AER parent in probe,
    keep them for the lifetime of the driver, and enable and disable the
    parent in .init() and .deinit() like the "msi" one.
  - Drop the dispatch lock of v2, which nested the port services' locks
    inside a raw spinlock. Keep the MSI-form latches set in irq_ack()
    while the virtual IRQ is in progress or disabled instead. (Sashiko)
  - Mark the virtual IRQ as level-triggered, so a pending interrupt is
    re-delivered by the parent lines rather than resent in software.
  - Revise the commit message.

v2: https://lore.kernel.org/r/20260928165230.3397664-14-den@valinux.co.jp/

@Marek, I did not carry your R-b tag over, as the patch changed quite a
bit. I'd appreciate another look.

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
2.51.0

