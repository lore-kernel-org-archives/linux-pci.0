Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD64F4CE7;
	Mon, 28 Sep 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614401; cv=fail; b=XXmwnIbl92d3SpwXOGsG0RJ6uSSM61y9/tSsGthEpIddRJbD03Njf5e/GJsCbN3Sh/HRIYJd3LXZQ8tYoaBNBz+KvVhhxNbNXfYvzJHdjiSAb0lYbf4r77ZlYpzaY6ahPcbWYGnAdnOIxftunCGdH4nYBwe4ydhLUHeFibXoK9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614401; c=relaxed/simple;
	bh=6e7I7f3NCtGHZTL7XmjCe5Z9TSPwiqmEadLMLcS6pZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4B4AOI2vB07cnb7pq5jdbki0nMWP4892KZVuVH5kaFQZsDSuUTJ5zh2cxbM7Ki4T2Az8LdVN7/ful4Hm6IK6wAyjecqoweW8aiGNIOQZNoLICRLaIGttVa/6y/xSAIEjwASx/P5qHrzxDn1kI1yFlkGsBvCN9SfZpmqOs5ptPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hKTdfLAe; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hKTdfLAe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW1FF0OM3Uys1/olkYPWxON4PW3yjLDr5TVs+oe4Zq20wnC8EqGzxvbjTr7yo/hjxfGOkXU8Ndl2QsD+yxCacqBBtyzY7AJ6PoLPR24NmMvJu3qGKmSTn/HZPfZqSDoZxhpwEifVo2b+Weo5f0OyZ165+puzLJB0e2qspISOjlsLQc189C3uZJPyIprdELvDj/KX228VJUZdqkxGKyqaCFrMgfXgDcTvlsM8pmlf2fMEJ+0IttEWgBPSkEQ82NtNXrni+K1OD6guSXmvhvVfm6tUJf+yQrL7Lh5rAWZfwMueKk+krT08pv+ybQvpJ6ZNAxQzLlerlGlDvLtaufOYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVoh9Q/o8i6mF5Oc/6zWMooc8QN2/rkQwyoJ6NVJgno=;
 b=Hc2ABdnkqncpnnOtnWo0Pr4EB5Cm7dUqqrc+SVgpPepQmsfXZGPXrO+z9zVv0tWb2S6NGNzlvcQR/lkF3oSK6BAroD7N3WuKXCxuZNnOLP4Ved0rWNt53JQ25gg3P+ph01pyyN4xWSw1/orwRPOZrmoHSurKtofj1yltj7snfeijWGcMxjpKnHDXkRlRASGEdGEApRoeczgNf3dipgq8udzhTDEiojNwAFaNVDB2/7umxWQBGx9f4Fuo20uscAdSAsJ36UopuzZAayWtT9fgJQdBTBAMhInYTLm0Ro4o1uBT7iXk91QR83lz3BfB/WwIZpDSSJyVWvflANg68ss7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVoh9Q/o8i6mF5Oc/6zWMooc8QN2/rkQwyoJ6NVJgno=;
 b=hKTdfLAeAgYRpF7SnnorB/+x32QXHG7lGGbHwfWXNScXxKFbdfesF2dUaj/A1fUqRSuXawGyy3MstyiqmgsCdmouKIgpVUeiy3kdnihV00+mB/m3IhNhKWS3f/pFVOAmKg5cmMA7jhmhPzAohQ8EPfO1jKzy0UC31b6nICQV+7I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:09 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:09 +0000
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
Subject: [PATCH v2 11/15] PCI: rcar-gen4: Recover the Root Port on link down
Date: Tue, 29 Sep 2026 01:52:26 +0900
Message-ID: <20260928165230.3397664-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7918c636-7979-4f71-655f-08df1d80f9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TV+wSOiDWyd/v4/GDeQefbaMtLia64TkxoDWcLvMNyXLcYyX3+3X6bjfcOK6AXiSPD5YiYv1mxsI0lIjCEG+vJ7utyeyaDGFBsdGOXG5+8veiQzlDIDvR/f+f21NNupTRa4qEFpQniMuRdIGfCnqZeVchWivD4HEah1PAAHqA6FqEmnTUOZOLckkjXjBGLuRlYM2WsHokF1mNp8Ja69e7ANbPZcNRaJOL7P2zBx7QiIbXcMdMZT+TD7WO1JiolQ3m6a42fmwUnJSddP5dpSuB0vw+iIVe7r0/5RPA1T8jHZo0LYvfpxdE0CdHuTp+sKUY0TzauyYUwO7NX6VB/Leak00lAK7RrII6zbieGYSRNfbYIvZ+hajNAJyQclHFKtNS47UHJuKk8MRQouHl6twvIhIKYANOgyOGEqMFAqg3U7D9lTVvHyEtiaeXxc+VXuRKKx7aN8QBeMbZwg4iSOyMz7cUHdC+4xFko4UGC/t7uMYHA+j58dvW7+vBI14BqCPnFwdcwYLkK3htk1rrTE+dfGeHW8R32Ps+CqZhv4KvtZnbxJqJTyb9fYGqPluWSonmbxz0PmhJ2MsbN2RA6WjUDqmbaaiHQJ9k8O4qSctWokCVovP/nPH9JjssJresPjh65ajDCGxuIhHT54tjD0AKAwXGepkw6unATXPRsmbAmXdm3Pg14PaFB8B8tzoX3+kjutcpACu9MR3HWDjWQxjiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzJOx2B1aBvxcfNhRYIKQp5SCcXoHeq11l1x/+xLL4hHhmZKiw1SB186XREe?=
 =?us-ascii?Q?GwjCcsH/KPZZHDdfzO1QBO85lyZvi7L0SLXcCDCeKhmSvyCoDUs5UiYybldw?=
 =?us-ascii?Q?7CqgaXt3GLK1DxLjONLVeGubyLFm0+o8XE7LymY7GrNuxiKkfYrtUvRpwNvP?=
 =?us-ascii?Q?QdX/U1yipzu1bOUXnbnn9ih/D9fjmX/SpXLe3zuW11/jW5fK0MjZHzvn0dkA?=
 =?us-ascii?Q?O6XXrBbzSjbhdk1l3vocSb4qFRbOGLa5rlKhmvtPbXBbW3rRkT282p02TC3k?=
 =?us-ascii?Q?nQbL0kU0aAtL2YRum5vajazZexmwxSi1jUrZ6RarjDRWVchwVXe8dDPET8DW?=
 =?us-ascii?Q?adNt7uBnw1B9OJG0BRWZ76/7LWnxgT2JDzln3EQTo3Ag/3AmaqzIO6l+hI73?=
 =?us-ascii?Q?6L6nLhPGyAPq209u7j/sUomMC+Kz7mRwUnbssggObiXvKlz0FaThDZ+KIi7a?=
 =?us-ascii?Q?EWpZOYYOmrD8HypYMfxFbzp6jg8LIePqGwKJivJotuhiAZ/gdJ7LQaluUryx?=
 =?us-ascii?Q?mNpvRZa22sdxCnICSEb8gIj2aAbo5U1AARyy/EzbOfi0HmuPUFkrd8pjfZp/?=
 =?us-ascii?Q?0e/EmoLy0yhSeG6nj4uQ6h3+2djR+d+KKRscR5QN/OYw822+LQdBOf+GyGmT?=
 =?us-ascii?Q?J6FhWDu24MDlOiIxakCn8SW1bCv/Vk0cRNIe3dzkG9VGZGViFaVqUdf5YGRy?=
 =?us-ascii?Q?zGt2ROrXmg2NMxx3uvv/24dmNPNoX0vWqgWINthNixNCITSdAsSARoMh0Kno?=
 =?us-ascii?Q?pQl/Cdic77ndz34nZOVyun6Zyf9wvKAQ8j9VTo+hnHvt59NCKnqy2f4V317a?=
 =?us-ascii?Q?99OW1cCjVuG0XBLgtBLNx3ZyXEMkdONcf/k7QtaELXxD/c90FuR9Xv72c5o5?=
 =?us-ascii?Q?yXWvQzv4udQzKZVVisvFceQvv2yUfFUr7cm5c+ASiZ7+ewxSGo0FlniNhwGr?=
 =?us-ascii?Q?xgLC4ZFRtnqQISxlR4TiZqOm/6u4KtvGzwuMjbFGgB5VgGjgE7n9dXpYA01e?=
 =?us-ascii?Q?EgN4A4JpFRn4c0simmS26oRgN7Ze8pzS5OwPw3djz2PN8Pe/dHw+1BeIK7b5?=
 =?us-ascii?Q?xxtr2UDaVEJQkS21HPs6e6Lv7laPBK4jKfqGzFBB0vKt6iRzBa9t/YDNxVkQ?=
 =?us-ascii?Q?p0Gt/+BNTzhIRf8U12yJfHOSSmxpBM5tgb5OOdlRrL0kjPRaCZybQy++m3m6?=
 =?us-ascii?Q?AoWrPUPWkjqAc94HPDhVgQBm26Q8zR38Q+4Bx5X4XfZ6rnNhPT8JRZCqM7Ot?=
 =?us-ascii?Q?2PGw7/kUCS3hTVjwDwGEvpQf7lFGolWwiVATsflINcOIC2471fjucRoAa3VJ?=
 =?us-ascii?Q?5uVATV8xVgv/nOCpDIr+oaErTgfumfl3s5avQ5aHVs5GTg/EMnP2BgB2/BeL?=
 =?us-ascii?Q?uv/988cTQ/pCvVkEZoLs466RUIhsVruHyu8ONWvo1zIEwK8hcw6GFd/0tvmJ?=
 =?us-ascii?Q?WPaGrRRxtSCOhCbn1ahR1M+CJbZzqHN4P+ikInpMzs0/tFUXvGQJJPpTC7ei?=
 =?us-ascii?Q?5ke5sYlwgUaeZFICph58eQw4UZr9Oiq7UPt36dQDGXuFcjTBv8hJ/d+V4pwp?=
 =?us-ascii?Q?8HAkc3uB7xem9CBirqSvcdfZSL080vTvSZlWr+Vo+H5J/Xmt2Z3n+DamaHXU?=
 =?us-ascii?Q?Tg98OTGUppoAljNSjmOMuLM92vXQXbh/jKIWXHTilM8YCdUUrGzPPpHFZ2E7?=
 =?us-ascii?Q?cVUbrMrbliz3eo4Y+kpFWz5odRAJLvAre1QwvtzUoMn97JnwBW/B5TjdnrDk?=
 =?us-ascii?Q?ltFlZYJVe5sSwXh+2h+gudimOpER1W+Hi0nrNO1wxHTPFRTWVKJ0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7918c636-7979-4f71-655f-08df1d80f9b3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:09.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcunyX4xiTyOdtPFvdovPPYTfU0MfitcmRdUubkHHei3FglRdlNV6DZBhSJOuUqgEOJmWFfVJFyPbXogz0lbeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

On R-Car, the controller's reset requests (smlh_req_rst_not,
link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
demultiplexed from, so DBI is read as soon as the link goes down. On
R-Car S4 that is a hazard: DBI accesses issued within a few hundred
microseconds of an unexpected link down do not complete and hang the
host. In testing, the first Root Port config read after powering off
the link partner hung unless delayed by ~300 us.

Check the APP reset status in the interrupt handler before DBI is
touched. When a reset request is latched, flag the controller as
needing reinitialization, which masks the sources, ack the request and
schedule recovery work. The work calls pci_host_handle_link_down() on
the Root Port, which runs the AER-style recovery and resets the
controller through reset_root_port(); it holds a reference on the port,
which can be removed through sysfs meanwhile. The check also reports a
recovery already pending, whether started by another interrupt or left
over from a failed reset, so the handler issues no further DBI accesses
until a reset succeeds.

Arm the detection once enumeration is done, as the recovery needs the
Root Port to exist. Only unmasked status bits are handled and pending
latches are cleared when the sources are re-enabled, so requests
recorded during probe or the reset itself do not trigger another
recovery. Teardown only disarms the detection: MSI delivery has to keep
working while devices are removed.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Check the reset status from the driver's own handler now that it
    owns the interrupt, instead of the pre_msi_irq host op. The separate
    request_irq() path for external MSI controllers is gone. (Marek)
  - Use bool flags instead of state bits. (Marek)
  - Hold a reference on the Root Port in the recovery work.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 107 ++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 256410fb4b1c..aa80232afaba 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -26,6 +26,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /* Renesas-specific */
@@ -41,9 +42,18 @@
 #define MSICAP0_MMESCAP_MASK	GENMASK(19, 17)
 #define MSICAP0_MSIE		BIT(16)
 
+/* PCIe Reset Status */
+#define PCIERSTSTS		0x0020
+#define SMLH_REQ_RST_NOT	BIT(2)
+#define LINK_REQ_RST_NOT	BIT(1)
+#define LINK_DOWN_RESET_MASK	(SMLH_REQ_RST_NOT | LINK_REQ_RST_NOT)
+
 /* PCIe Interrupt Status 0 */
 #define PCIEINTSTS0		0x0084
 
+/* PCIe Reset Status Enable */
+#define PCIERSTSTSEN		0x0300
+
 /* PCIe Interrupt Status 0 Enable */
 #define PCIEINTSTS0EN		0x0310
 #define MSI_CTRL_INT		BIT(26)
@@ -54,6 +64,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Reset Status Clear */
+#define PCIERSTSTSCLR		0x0330
+
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
 
@@ -118,6 +131,9 @@ struct rcar_gen4_pcie {
 	const struct rcar_gen4_pcie_drvdata *drvdata;
 	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
 	int msi_irq;
+	struct work_struct link_down_work;
+	/* Allow Root Port event handling after enumeration and until teardown. */
+	bool rp_events_armed;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -559,15 +575,35 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	bool rp_events = rcar->rp_events_armed && !rcar->reinit_pending;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
+	/*
+	 * Note that rcar->rp_events_armed is not checked here because device
+	 * removal may still need iMSI-RX interrupts after Root Port events have
+	 * been disarmed.
+	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
+
+	val = readl(rcar->base + PCIERSTSTSEN);
+	if (rp_events) {
+		/*
+		 * Clear latches recorded while the sources were masked, so
+		 * stale requests do not fire as soon as they are re-enabled.
+		 */
+		if (!(val & LINK_DOWN_RESET_MASK))
+			writel(LINK_DOWN_RESET_MASK, rcar->base + PCIERSTSTSCLR);
+		val |= LINK_DOWN_RESET_MASK;
+	} else {
+		val &= ~LINK_DOWN_RESET_MASK;
+	}
+	writel(val, rcar->base + PCIERSTSTSEN);
 }
 
 static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
@@ -630,6 +666,44 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * Consume a latched reset request and start recovery. Returns true if DBI
+ * must be left alone: a request was just consumed or recovery is pending.
+ */
+static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
+{
+	u32 status;
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	status = readl(rcar->base + PCIERSTSTS) &
+		 readl(rcar->base + PCIERSTSTSEN) & LINK_DOWN_RESET_MASK;
+	if (status) {
+		/* The sources are only enabled while armed with no reinit pending. */
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+		writel(status, rcar->base + PCIERSTSTSCLR);
+		schedule_work(&rcar->link_down_work);
+	}
+
+	return rcar->reinit_pending;
+}
+
+static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
+{
+	struct rcar_gen4_pcie *rcar =
+		container_of(work, struct rcar_gen4_pcie, link_down_work);
+	struct pci_dev *port;
+
+	/* Hold a reference: the Root Port can be removed through sysfs. */
+	port = pci_get_slot(rcar->dw.pp.bridge->bus, PCI_DEVFN(0, 0));
+	if (!port)
+		return;
+
+	pci_host_handle_link_down(port);
+	pci_dev_put(port);
+}
+
 /*
  * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
  * notifications, so the driver owns it instead of the DesignWare core (see
@@ -640,6 +714,10 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 	struct rcar_gen4_pcie *rcar = data;
 	u32 status;
 
+	/* Check reset requests before MSI handling, which accesses DBI. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
 	if (!(status & MSI_CTRL_INT))
@@ -676,6 +754,31 @@ static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+/*
+ * Arm Root Port events once enumeration is done, as recovery needs the
+ * Root Port to exist.
+ */
+static void rcar_gen4_pcie_rp_events_arm(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_events_armed = true;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->rp_events_armed = false;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+
+	/* Handlers queue the work under app_lock, so none can follow this. */
+	cancel_work_sync(&rcar->link_down_work);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -888,6 +991,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 	.init = rcar_gen4_pcie_host_init,
 	.deinit = rcar_gen4_pcie_host_deinit,
+	.post_init = rcar_gen4_pcie_rp_events_arm,
 };
 
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -903,6 +1007,7 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return ret;
 
 	raw_spin_lock_init(&rcar->app_lock);
+	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	pp->num_vectors = MAX_MSI_IRQS;
 	/*
@@ -918,6 +1023,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
+	/* Cancel recovery work before removing the PCI bus */
+	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
 }
 
-- 
2.51.0

