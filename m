Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B711424D48;
	Fri, 18 Sep 2026 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701659; cv=fail; b=U7sKjzr+1rxYTGG1sO1VHIEEgcLnfdp5UWRv+W8dUscrQUp9vpJ4PMWa6j1MVo56UAVkbIdteWCIISZT41M4gqi88AEG1lNp96wAzv1Z2foB61hdvjHm4R7WZyLUpwJOsjB9eRpGIxUHZgvF4Dj2b+eN/RodKQ+VtYceBTEDsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701659; c=relaxed/simple;
	bh=5pyOG1oLkTD7Cc0jVR82N+jSt1+WIc4COchbkFqfCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tF9kPB9lYGGtv0DL17evhSHQo95ICRzZnHnPBf3VFbSJ8n+w515ISpNwqGo9FUY/pVuEvGT9oc4egUr7eec7pnhfl2pqfDGzq343AKNKKTo5PhOr9lTEDOxY5cJVl6xMBcBtmIJjOWud2rWE2CDC/N3Pi6qquJ7O6jzdma9V/WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aM7YwrRI; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aM7YwrRI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHA8BFiMpHydQSzWuSr0+iqyfmWYUXfs8z1g+jyJvUIOS4RF8IELx3Wp+raYZW1vtinV6f9xTDAFvwmTqRheEWOBO00CjGhrD2au6bSPcLX1r6y8RMCwc9uloSAFVLNxzkQdIa+UEM80Zsu3UY1dAtllz8g4WRcjlL5MaRVPAAjWhBLYxZ1i7Ql85GXVkn4w5E/x4PIxYKUwR47okCUkh3qBc9Qpg2j1oxWkhcX2j16DAi5hSH2xvSNAmCFvFjnYVp0dL6p/HPOyXhVgZbqB5osN7U8Qr6cfO6wlibyVLevPlpWzkebQXlm5svdy5O1QXG3JZ2DgSljfJJas5hgoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXhL3PUvT+cHTgsWM4wSb6PBVejuViuGWBbzDBfm53c=;
 b=edRcGr5Kzu4DjSPR/pCgfMCYVMBiwPHv6QHkHYIAZj+UoEUbHDQaLuPg1ngWmwqmqC8qvSI2rnxTXk7GN9M+tVvq+ZPhYBrdzFM6TrNggd2jKEz+FSLzTj2Lx6p1eyLfzbKkesApQWHNmi4vC4c5O2fgaLMQaLq/McuR8xZQzJ7RQRYQDGJy/ILP9Sl+RQGvQ4SS4l5n2Pu9FnsDbmXHnPwaEHAqDyMhU01DcZPt6WFSzowf5Fv72PE7pSerQwKC4sW8eO89ZCqjWmW4oScwvMIjrVbxe0seRlFl3/nagsUD+2LLykPZKi3tvW3qlCXvjX2SAYLvnpOTDSgjvPQFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXhL3PUvT+cHTgsWM4wSb6PBVejuViuGWBbzDBfm53c=;
 b=aM7YwrRID6jkZkUmvSXH66mxfyTrOLEjhaIlbyCMjOQ4I+0DKjtspWunBPdM8DDn1wr7MIsXuztGlqPxzCmM56ciuQyiTC8rXszcElZll5e1N23VPJ2nUSaAP2Cm7vSQX9SufTn5Hx6eMslAhW0tNqzZywoChFmDeaLZuaTyzV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:51 +0000
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
Subject: [PATCH 09/11] PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
Date: Fri, 18 Sep 2026 12:20:36 +0900
Message-ID: <20260918032038.2216471-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 564670ca-38e2-4246-6492-08df1533d773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|5023799004|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	F6OXLzBVq/vDWVfnLfPoy0Sj5BkVXovz3Yq5MP9TbrSSBHaT0XKFXqa2pMpHllK/hv6lbs0KTV46yxOGWZgDI9duFQu80rWYDA/RdNS4AVy5nzV6YJVy5szhStaay2zDUucNgTp2X9Ud0VW9sCDltV9KjXOoT0ckjXUTLWhYtBD3yLm94TadSHY9+trDOZtWEOnLzKXs1jjqPUmyoWMJyiehH3m7GG995JrInIHZEo2Fq9gAmzFKjbWiHYqJiVYJwYJ37gKu2NUE/knkaoYyI8GSFPdIXyu/yrzc9BDuQPRjeh2BceUb0bMycni7yp7EzF4nFHYGYg9p2LeHT1IbCbxy6nrMa+Ko3OXgqxh36ZNGLx4byvTBgZZ3tNJxcwjKo3HA8J/e6ObSiaOvFiz+TgSHPHUAvfBXNHMRis0+fGPYG7I4vQnIg11mf+Rh9Ojndub2DSYG2m9wNhql+1qTVzyb+aU3WZxyLrwb2mpd1DxOQIBEfHQLfafDM/W0R+Oc6ZGyHov5/ItLCDjUf1EGMLcPmGOCfxdrHkYldGqvv1eAf5132i1UxoR79hfpZHBB+BlNjy5LB0UMIiUxMhmtCp+UV3JkBBERfc1u86asINeS+6F5oHZj6bdqja3RMY9hGZB3bZkdvgPvRp8laTfmcNbPn7WpA+EyJ5Y5ZFuhZkN+gBBR8QL/CG4K/9xSv2AI1bLugY0gygyigrtOTu1vFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(5023799004)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqxAnUB7/2e5vPy4ojgKbD6RRA1QHoKzt8FjYCAK/fcZO7FxRDuxrSQNZdx3?=
 =?us-ascii?Q?XLsbAT+t1BrsIeFp7FdHW5XkW1AzqcPlE3JJ8Tdi/h+klGbcYHTctqM8s709?=
 =?us-ascii?Q?axG+1XBkJ8JMK7L4ZEl+eQxcq3PoJV7lDFJIdqjEs/v3iMSlemqY9/MYAr03?=
 =?us-ascii?Q?+BcgtS9hPcNaFR13Nzq6ktG6eJ+Kl0recxZcxdUomChlfU2EcfjznnRnG9TO?=
 =?us-ascii?Q?cdw5bbLBy6NiK1/QxD0Hm9lJCe89/qBmYHV05REzH0wJUSw0Y68Rc1n4eRIm?=
 =?us-ascii?Q?VT4G/X8CUjsTbLTfzIe9ODI7WxdBfwGg+dqMcJkrdLP/HRB4j5xBZGauMqRH?=
 =?us-ascii?Q?v/VSTqHTvYayh3P/r/s3VQiwA/tCRK94kUU+e5R34OHXVMSk88BtHuqE3KOL?=
 =?us-ascii?Q?scxRVx35mqv+YP4zbYSm53q7Iv7lymxJiLOo/9qIMPyTmWNAslg1qwJc2ZY6?=
 =?us-ascii?Q?9tjmIXJPmDt79NTBRkfAsQ7w9RKv6JJHkk/zjWXY6mhLZahfXFcm+h5rnwLf?=
 =?us-ascii?Q?n/9JrpntEklYsG6ggHBRYfkQdTfUDF7GFi0Ss7b0kryi7s+Eq3YODkt6Ka+u?=
 =?us-ascii?Q?U4NYWfVu4m0WedbXNPpZUTFIgha65Gi1qec8Kanu2uuQQACgfesTH6WwOfdN?=
 =?us-ascii?Q?TcDDCYOjfQ60f79CtkTYrkASWKEGgP0PyiSmkObP3PeBUfvXdBz0dacd3L8r?=
 =?us-ascii?Q?3lqPiVDOs7eNjycl6lVZX29Gc1UTPB1zLBVyMUR77J+kxBUsyeWhnDNmVffg?=
 =?us-ascii?Q?SlmeWYFQ9+uG+5NEQO1x1fosg67r9M5VCOlPsxVtt4+aGtG/xxqV4uxHez10?=
 =?us-ascii?Q?QqhKKpkUZd0marvpYtK9Un0i+JGjeo/qbH37ZNyKSBHKisHAXBull8UffTW+?=
 =?us-ascii?Q?12v5wYxPf3vSfU3+wnb1eVcwp6j6knMGkXBV06HvFQdu2ldegCSHuS5ZWlBi?=
 =?us-ascii?Q?kLjm1yYbV6NwEvLLGWq4nqz2GzMMv22K650mfPfTfLl33OphoYSYoCfl93AG?=
 =?us-ascii?Q?5xKcCIoQiiTDrLy77gFzuseRNP8pwgWKUlxNWW05eV3XHaZo5ZFn2SJ7svbx?=
 =?us-ascii?Q?arP8NecDjDBcvURsL4qJKKH6aCSuyfgtuuCDa3gnjlIRJ0ONpkIL3ti/jx9V?=
 =?us-ascii?Q?oKsdtFUChCEqyZmvNZv2iPT/d5jeGSPUfeEtQOVEpBVC7Kewn2EUayaxMZvI?=
 =?us-ascii?Q?PMRoeAgQpevX5zrIBqVWQ/b9iAkoIwqHyVv3U+Crr73fEADseF7+ykrkPxXU?=
 =?us-ascii?Q?ygYJjgO3Hy6PTaVgQFaCYmVRPXuLD+VlNdiFyK+9tkBfktanqW46l5gUxaYE?=
 =?us-ascii?Q?DBzIMaQViYbocNJ0FnhedBYYjP02+HbfLPuBkMNytIUb0dDmYwuqzTHMKJhJ?=
 =?us-ascii?Q?eGIyXcAOYiH9uD5tfvGZZLS/eqpRpw1hLWT/Sri6a3IKxIZb6yJBJXUNAkEf?=
 =?us-ascii?Q?uwRFuWN2VPh5E1ih8vWBE/hRafwScy0n3ntOr2uxBJ9btGL39dlUTyirV1wz?=
 =?us-ascii?Q?1RCxlXJR51PHqc+AlOR9/XDIqm7BSf1P1qkHhGU00+cn6EUf1PHqR4O7yo+N?=
 =?us-ascii?Q?KLxN8bXcNZMcM3e1Bw4y3qbOSdi2HHuIDijD4C+uba3Ru5bDhyOKZxAkVqnT?=
 =?us-ascii?Q?tbFDDTBqkSIn1vbuNTOFTk62VXdzZCIrDCnuGV+YagPtzGrEjg/BR8YlXwtg?=
 =?us-ascii?Q?tDBVVSET0i34EY+hF7yvN6lESHkzi3DE2dQ9hoFw5px64KyAWht61CGTiU8m?=
 =?us-ascii?Q?GUZLaQQxGfDZ76AwgjOmGlzJk+v0IoDwxvtL1sUxBehAbSgB0fgi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 564670ca-38e2-4246-6492-08df1533d773
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:51.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU8HiZBuoqivr0ElpZniKbh0oFPkb6NLorLLxdiw3gYdu7d4bzxeMIaiAw/QRgjOD52BFiNP/qECZcewleakmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

On R-Car Gen4, the Root Port's own interrupts never arrive as MSIs: the
controller (DWC 5.20a) lacks SII2MSI, and the APP block latches the SII
signals into PCIEINTSTS0 and raises platform IRQs instead, AER on
intreq_pcim_lperr, PME and bandwidth events on intreq_pcim_sub. On an
R-Car S4 with GIC ITS, a link retrain set LnkSta.LBMS and latched
PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root Port's MSI never fired
while endpoint MSIs worked fine. With iMSI-RX the Root Port MSI
capabilities are already hidden, but its INTx maps to the chained
iMSI-RX IRQ, which the port services cannot request. In either case,
Root Port interrupts are not delivered.

Set no_rp_msi so the port services fall back to INTx, and stand in for
the Root Port's INTx with a single-entry virtual IRQ domain that the
bridge map_irq callback returns for the Root Port only, leaving the
downstream INTx mappings untouched. Notifications from different
platform IRQs can then feed the one IRQ the port services share. Route
the AER notifications from the "aer" interrupt to it. host_msi_init()
sets the Root Port's MSI Enable (MSICAP0) whenever MSI is enabled, and
hiding the capability does not clear it, so handle both the MSI and INTx
forms of the status bits. DTs without "aer" keep Root Port AER
unavailable as before.

Mirror the virtual IRQ's mask state in software so the APP enables are
re-derived after a reset and stay masked during recovery or teardown.
Clear the latches in irq_ack, before the service clears the Root Error
Status register, so back-to-back notifications are not lost. Error
command handling and recovery remain with the standard AER driver.

The AER interrupt can also fire on link down, so run the reset-request
handling first and skip the dispatch once recovery has started.
Synchronize and free the parent IRQ before tearing down the domain.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 246 +++++++++++++++++++-
 1 file changed, 244 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 238755852045..c24ac82a1ec6 100644
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
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -56,6 +58,11 @@
 #define PCIEINTSTS0EN		0x0310
 #define MSI_CTRL_INT		BIT(26)
 
+/* Root Port notifications routed to intreq_pcim_lperr ("aer") */
+#define AER_RC_ERR_MSI		BIT(29)
+#define AER_RC_ERR_INT		BIT(27)
+#define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
+
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
@@ -63,6 +70,9 @@
 /* PCIe Reset Status Clear */
 #define PCIERSTSTSCLR		0x0330
 
+/* PCIe Interrupt Status 0 Clear */
+#define PCIEINTSTS0CLR		0x0340
+
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
 
@@ -123,6 +133,12 @@ struct rcar_gen4_pcie {
 	int sub_irq;
 	bool sub_irq_owned;
 	struct work_struct link_down_work;
+	/* Virtual Root Port INTx, fed from intreq_pcim_lperr ("aer") */
+	struct irq_domain *rp_irq_domain;
+	struct fwnode_handle *rp_fwnode;
+	unsigned int rp_irq;
+	bool rp_irq_enabled;
+	int aer_irq;
 	unsigned long state;
 	/* Protects APP interrupt enable registers and their software state. */
 	raw_spinlock_t app_lock;
@@ -376,7 +392,7 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
-/* Whether the APP interrupt sources may currently be enabled. */
+/* True if APP interrupt enables should stay masked */
 static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
 {
 	return !!rcar->state;
@@ -401,7 +417,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
 	/*
 	 * MSI delivery only depends on DBI being usable; teardown must not
 	 * stop it while devices are still being removed.
@@ -409,6 +425,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	if (!rcar_gen4_pcie_dbi_unsafe(rcar) && pp->use_imsi_rx &&
 	    pci_msi_enabled())
 		val |= MSI_CTRL_INT;
+	if (armed && rcar->rp_irq_enabled && rcar->aer_irq > 0)
+		val |= RP_AER_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -504,6 +522,11 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 						     &rcar->state);
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 		writel(status, rcar->base + PCIERSTSTSCLR);
+		/*
+		 * Drop any Root Port events triggered by link down; the
+		 * upcoming reset will reinitialize the controller anyway.
+		 */
+		writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
 	}
 
 	if (schedule)
@@ -512,6 +535,30 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 	return true;
 }
 
+/*
+ * Dispatch pending Root Port notifications in @mask to the virtual Root
+ * Port IRQ. Returns true if there was something to handle.
+ */
+static bool rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar,
+					   u32 mask)
+{
+	u32 status;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN) & mask;
+	if (!status)
+		return false;
+
+	/* Check once more right before running handlers that access DBI. */
+	if (rcar_gen4_pcie_handle_link_down(rcar) ||
+	    rcar_gen4_pcie_irqs_blocked(rcar))
+		return true;
+
+	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
+
+	return true;
+}
+
 static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
 {
 	struct rcar_gen4_pcie *rcar =
@@ -604,6 +651,8 @@ static void rcar_gen4_pcie_link_down_irq_deinit(struct rcar_gen4_pcie *rcar)
 
 	if (rcar->sub_irq > 0)
 		synchronize_irq(rcar->sub_irq);
+	if (rcar->aer_irq > 0)
+		synchronize_irq(rcar->aer_irq);
 
 	cancel_work_sync(&rcar->link_down_work);
 
@@ -614,6 +663,183 @@ static void rcar_gen4_pcie_link_down_irq_deinit(struct rcar_gen4_pcie *rcar)
 	rcar->sub_irq = 0;
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
+	writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
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
+
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
+	return rcar_gen4_pcie_rp_irq_dispatch(rcar, RP_AER_MASK) ?
+		IRQ_HANDLED : IRQ_NONE;
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
+	int irq, ret;
+
+	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
+	if (irq == -ENXIO)
+		irq = 0;	/* old DT: Root Port AER stays unavailable */
+	else if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
+
+	/* Keep the notifications masked until a port service requests the IRQ. */
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->rp_irq_enabled = false;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+	writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
+
+	/*
+	 * Note: suspend/resume support must not tear down and recreate this
+	 * domain, as the port driver keeps the mapped IRQ.
+	 */
+	rcar->rp_fwnode = irq_domain_alloc_named_fwnode(dev_name(dev));
+	if (!rcar->rp_fwnode)
+		return -ENOMEM;
+
+	rcar->rp_irq_domain = irq_domain_create_linear(rcar->rp_fwnode, 1,
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
+		/* Dispatch the child IRQ in hard IRQ context, including on PREEMPT_RT. */
+		ret = devm_request_irq(dev, irq,
+				       rcar_gen4_pcie_aer_irq_handler,
+				       IRQF_NO_THREAD, "rcar-gen4-pcie-aer",
+				       rcar);
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
+	rcar->rp_irq = 0;
+err_remove_domain:
+	irq_domain_remove(rcar->rp_irq_domain);
+	rcar->rp_irq_domain = NULL;
+err_free_fwnode:
+	irq_domain_free_fwnode(rcar->rp_fwnode);
+	rcar->rp_fwnode = NULL;
+
+	return ret;
+}
+
+static void rcar_gen4_pcie_rp_irq_deinit(struct rcar_gen4_pcie *rcar)
+{
+	if (!rcar->rp_irq_domain)
+		return;
+
+	/*
+	 * The port services are gone; stop the parent IRQ before tearing down
+	 * the domain.
+	 */
+	if (rcar->aer_irq > 0)
+		devm_free_irq(rcar->dw.dev, rcar->aer_irq, rcar);
+
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->rp_irq_enabled = false;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+
+	irq_dispose_mapping(rcar->rp_irq);
+	irq_domain_remove(rcar->rp_irq_domain);
+	irq_domain_free_fwnode(rcar->rp_fwnode);
+	rcar->rp_irq_domain = NULL;
+	rcar->rp_irq = 0;
+	rcar->aer_irq = 0;
+	rcar->rp_fwnode = NULL;
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -706,6 +932,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 
 	if (rcar->sub_irq > 0)
 		disable_irq(rcar->sub_irq);
+	if (rcar->aer_irq > 0)
+		disable_irq(rcar->aer_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -718,6 +946,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
 
+	if (rcar->aer_irq > 0)
+		enable_irq(rcar->aer_irq);
 	if (rcar->sub_irq > 0)
 		enable_irq(rcar->sub_irq);
 }
@@ -786,9 +1016,14 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err;
 
+	ret = rcar_gen4_pcie_rp_irq_init(pp);
+	if (ret)
+		goto err;
+
 	return 0;
 
 err:
+	gpiod_set_value_cansleep(dw->pe_rst, 1);
 	rcar_gen4_pcie_common_deinit(rcar);
 	return ret;
 }
@@ -799,6 +1034,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
 	rcar_gen4_pcie_link_down_irq_deinit(rcar);
+	rcar_gen4_pcie_rp_irq_deinit(rcar);
 
 	gpiod_set_value_cansleep(dw->pe_rst, 1);
 	rcar_gen4_pcie_common_deinit(rcar);
@@ -827,6 +1063,12 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	pp->num_vectors = MAX_MSI_IRQS;
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

