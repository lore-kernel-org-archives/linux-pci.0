Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91315359A8B;
	Wed, 14 Oct 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972462; cv=fail; b=XXVkOyefp0F7kPihTvN2hoTfzJU2x7We8pDKCV+avJNH1XAk/Eh9ihwwaPq4FpXVaLl912QvY5zKQ5hp+uzGd5PpqabunzkV3CTqPuV3HAU8Ah+G+HrLgDwk/pI2jozgAfuZ1VCdgKo8aRVGOyq0nTjlgB8i/4Ecx1gFS8Wy/bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972462; c=relaxed/simple;
	bh=RfCdcIg14+YBUG/cs17Zs/yJa52fNO4ffsv6lm3OLbk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DlfXfFfxJfadJ5xw3VP4ojLVwXX6IYhxIVmTWiZgkh+m9PocPkPv3m7JL5HJk1T7clrG0ju/yftAiByUa2AZrLFe2CErECmlBGOu1rXQGUDy4JM/joo5y/q6qe8QkP64zRLIsGhXcBAvk3ZTMi4SMUWVuakwKDqlCuMvfun6VPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=c5jVfFE6; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="c5jVfFE6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpLZEnSoHQMAd6KRO9e1mezxbTOebkybRkZnVGlI9M72vdcGtNnaQegNapDfsnGy6lgtTExs3Ozqtz8BzJSQjHTafpXRacSNdesdMWpPJ6YALeQOuqu678W+KuFdTBvpRyx+5mHAq+/hfdyB1mAsa6RMWfAzxtcvRvYcZb8MSS7SDKy02scjxTCBa9N060015Ax/aO7IuqCWiKqU6EgWSWHti6PM/peeFKYu9zcfhrP1PRvFjLS8enBxavEk15Bhy0+dN4HfzkR8t9hAyeQj27nEilum1hT0a22n3Ty7h2rr18cBsKHxT7Wx0tj5iSAwlzIDYCuMNvEbTCRBRL+MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSz/+BnjQYgbijbHrwe+bRqrS/QzOKRHyeoICSuw/es=;
 b=QdS8+M9PVrlb4EPZ24kTjkzSYLUEGlquxh2K9DJwIQe9Utu5T11XEhEzI17hzMPQW1ysNw6mf/V0WSxlS5h8mNfw0A08YZAx90ZyKP4ROc4Ki16gRqYbMt/dIR6YzGCymANLw3evVyVRjAHT14Y450XpIZDwrzCdr7s1X0QKUxBpGFv22xCYReVaGH0TnlBhb34DbXVDZ2eILJJZjmWVB1J3dYCRzUIMwJuahEW5Y16Q7yNq6gytG8l1BVZYacPdtlw+B7CpLv6VtrFlSOy8BCdVlrrWwaqczzjVza2+HZS30vlf3EHmjlSftMrTmv5AuM8brFGPotzNyW3cJdLteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSz/+BnjQYgbijbHrwe+bRqrS/QzOKRHyeoICSuw/es=;
 b=c5jVfFE66lgtOcTdpz+Zoz4Erzj+H1AfazSxHpcgHR+r4czzO9TdmNH3FyX2RME7w4z0ly42/f2blPSaKrDmJZamp717h7rauaZIFSEtn05EBNbOAv1mvMinZVTQ7YPRvQ2JsamIeTMUXuYzXEH+rnsmCbH4+hVzuMue16xUT5mTEyfWTC9JWqdHA4CnqXOP/lcJu/QjMpcQ0UduSTMxIHzjZVl2PGEj8MCUJc4+yRGV+vrs8P1Uv33gvl09KXo30qS7Riex4uErniEdctL8oAXxsxxV+5l2Ayney9sN2/J8v0zONc498tbUDih4fbT1IjHpPSKj+patalofYy/N+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SAWPR03MB989178.namprd03.prod.outlook.com
 (2603:10b6:806:4d3::18) by DM6PR03MB5194.namprd03.prod.outlook.com
 (2603:10b6:5:24c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 14 Oct
 2026 10:07:37 +0000
Received: from SAWPR03MB989178.namprd03.prod.outlook.com
 ([fe80::433c:5b4a:9497:d73e]) by SAWPR03MB989178.namprd03.prod.outlook.com
 ([fe80::433c:5b4a:9497:d73e%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 10:07:37 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	subhransu.sekhar.prusty@altera.com,
	mahesh.vaidya@altera.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>
Subject: [PATCH] PCI: altera: Convert root port IRQ to a requested handler
Date: Wed, 14 Oct 2026 18:07:23 +0800
Message-Id: <20261014100723.1643089-1-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To SAWPR03MB989178.namprd03.prod.outlook.com
 (2603:10b6:806:4d3::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SAWPR03MB989178:EE_|DM6PR03MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 881ea6af-e12c-4357-377d-08df29daf96a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|13003099007|55112099003|261009220027099003|261009223027099003|18002099003|56012099006|261009223327099003|5023799004|11063799006|261009221227099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3gyHoryd1jLlgRBpHW2VcSDiL9egZ5y4cfoV5gzcTB9pK6P9gLa7aX2GVqLnZVWnEJ6kirr6xrxLB1SvazQPj711QD2XMrhr/l1lA6GMOpafv+lrq3kdpwTfJZU402arnpv2tHnaHnXPd2T4TPddh51BwY5NvbvWk1PFM/Hi5FdGyxu9ne/YypqPospRfntpK5cvOqq8W4RX7XuMsCbYx72w7wh1yuE8jBu4zaVdaJG6qa2+wQLEgD36Jon/AN6bUPgmLAvkuvMwIdyb+UGVi3bhmyFG65Jw66C2p+FIxleRs/lA2D0WIQl2BVeFTgSTsHzV9YjfThqltQo5bCOYKo/WNAZhop8HW4R+Qdlzc7JzqgZo1R8v4ec9KPvkT1QlLobUHz4yL3hmFleOh2qRu5CrzVRt0IuPPa1nMg8iUHXzsyl+JWpf6+4egaEd7/ZyKQ5nlK9IKzY9AwKVXwqusDaXgAaANLG3TyZgP21X1/bjIT22s6iNIce95POLlQPPIyCME9z0J8TvFdxI9MXC0uxyUOMXnhvcR6Xx29WGcjOD0I2+0drXZlnfrYtNfAUCGl2EZ+B559JWD2n00FhPjDzAAfxsy0Jg0aXDNNKrr/rhYDvV3EvBohFxeGty2XoV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR03MB989178.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(13003099007)(55112099003)(261009220027099003)(261009223027099003)(18002099003)(56012099006)(261009223327099003)(5023799004)(11063799006)(261009221227099003)(261009221727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLTtmsfJyFaVZ9hRj1/1SGjz9NgFene4p6ra7H3Jt0o9l5sP5+/IWQGuJTYt?=
 =?us-ascii?Q?YFLNgTTeS0fy9xWgm4IpHnt0oyyXhYHsLlxW1Fj6+CrGVK6hU+9M8z3b+UYl?=
 =?us-ascii?Q?1hMlrQT0SxwRjtx4ZghAJ88mu4HnfGdXtKMXJldl3XDx16PmjeLzjgShQ+kk?=
 =?us-ascii?Q?f37QpiSMqvWfK7iyH5mKqQNTj1t1g+LEHVZa0Bg/arQ5ZjowTzKcBZ77t9Jq?=
 =?us-ascii?Q?cWVrKeaR1JSRTq1rpx9KY1ckr8xDdLVu1kQCiiw7Iex+CeRbNSVbwxEGrbwG?=
 =?us-ascii?Q?hHbLCUI3eax9LMTDZUww8JElcildoGhQIwbEmrEHqfc8Hpl5N2VaEXVu1tLF?=
 =?us-ascii?Q?vW1YPY8gailJOR297M/TgTLCQZrjpQsLobawv8wNo3B0okQfowLKCEKMJn6m?=
 =?us-ascii?Q?lu396bWeNgECRw1+he41soeXnXetfT7XapvIwZdLv9A5agE7S3dz8aA9z3a+?=
 =?us-ascii?Q?7umyO3enAS/J8t70T02LxVlp1OAhk9cEabT2BtDT/zFTwJJwwGzr6jLRVvap?=
 =?us-ascii?Q?akBekWPPzJ+nj11+dIpH3hQSpNMsAcqICKVyQB23Jch2WYt7UhCYUdOuLW5W?=
 =?us-ascii?Q?t+jILNcyg8MXAWZPzZE3RLhHXjaM+UrSsQI+t/mSmMcG/y2mr7YtI6YaoxfE?=
 =?us-ascii?Q?LAFgpOLHZsh412XE0k2H35FrD5nPt3TXmfKMyX45OInLoXlK2hUpcjO20BGi?=
 =?us-ascii?Q?ZvHvddZMfbO0diChoB6TRgiIdke7XdpjzFmVTYHo7bysTrN36sAj2Yt8Gl/5?=
 =?us-ascii?Q?C6RlBbGxJvsw/r9zuVIAskv0jnDI8+RB2Ya8yZ+Z4WzOG6dY+crqACOVPbXa?=
 =?us-ascii?Q?wRHGInmgBAnZ5YfX/4aaW7JOfvKKI789UPP+4pdKUPFKWRDe9afQVkKb8gt+?=
 =?us-ascii?Q?8oMQeZ8Mxqsi9pSEygTfTxjIwEPXkN+4GB5Y+RT7Ly9Sy86eF+JEhKuxsRZi?=
 =?us-ascii?Q?pamGYABSkHb6iagvyZ2mPn+5RlQFJW/faxdVZpTfHE0Nvn6vQVoEDUmW/j/h?=
 =?us-ascii?Q?iZRIWM2DRV1/jIv+kQZqoJc7aWWmpt2HjEv2ybGtZmSi4EDsNTq2boDrzFHD?=
 =?us-ascii?Q?KaFuFHk8wL84gh3ldHTTJ5hv5g90ivQq1TfAbk+dCdfbVsgjbCrDT6+9Beey?=
 =?us-ascii?Q?wunxAOal4q65iQs3FPMupOqeccvoCrrvE51huuhizofW1rSjvkQMEuf+jrdZ?=
 =?us-ascii?Q?rtzB0O+wHjParJHOO6pMnETwKLbqYRzOlA7i/YHMQH0nSwC13eRezpbX6Vpv?=
 =?us-ascii?Q?jWtm/FJb5xkSsbF5VCccS8nw7e8uK4PVmMh0pvdnjU8VRf6Tirq2MyxdTFBR?=
 =?us-ascii?Q?qBrjzedSWQllnWTLy/WhWnFYsfJvZpdXWf7KHYhSGEUTut8voSWw8qRItXez?=
 =?us-ascii?Q?+IxuD7Trhyb4EvduqEZpuBNG3WurrRDRjRTTNF44hAZrvsuy4SsC5xCAzjDc?=
 =?us-ascii?Q?u8RQLDBNb3Y+B5CWyrACv+O+ZgP1vACjuFqxZVkGQtxSj79FYt8FOadjq96L?=
 =?us-ascii?Q?fYyOT2TfY3rhYchRQD7z7Et+QMFJbhVuBO+3TGRYev388+yYBsImmNdZXCiW?=
 =?us-ascii?Q?aAncklcpHWxfFvEb6CWilZHk6QZg5kTChl6gTYplM69ocXZynhRQ2Itu7NK7?=
 =?us-ascii?Q?qvSF9wYoRDh1I9PC65ry3ccblvOfnulgk+WDxj26TBSayyzy65FjIlXOlxDz?=
 =?us-ascii?Q?6cvTU0uUroF5sOy1TfWgJEDG4bXWNIeL+Sj3LL0LF3w+lrIHxM6on2awvT0X?=
 =?us-ascii?Q?LlbOBRVQ8g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ea6af-e12c-4357-377d-08df29daf96a
X-MS-Exchange-CrossTenant-AuthSource: SAWPR03MB989178.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:07:37.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Symq/8HukdaWO/unyzJXR+rKVf1HM1uZX9lU/Qrc2Ml39j+iVfGV5oeyAV2UI4SOAFyctcY+9fNPU33Qj0DMypXfQkwLOVIGAJ4khU6vn2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5194

altera_pcie_irq_teardown() removes the chained handler before removing
the INTx domain. Removing the handler prevents new invocations, but does
not wait for one already running on another CPU. Such a handler can
therefore access pcie or pcie->irq_domain after they have been freed.

Chained handlers bypass handle_irq_event(), so synchronize_irq() cannot
rely on IRQD_IRQ_INPROGRESS and may return without waiting if the parent
irqchip does not report IRQCHIP_STATE_ACTIVE.

Convert the chained handler to a requested hard IRQ. Request it only
after creating the INTx domain and call free_irq() before removing the
domain. free_irq() then synchronizes against any in-flight handler.

Use IRQF_NO_THREAD because generic_handle_domain_irq() requires hardirq
context. Use IRQF_NO_SUSPEND to preserve the suspend behavior of the
previous chained cascade. Request and free the IRQ explicitly because
automatic devres cleanup happens after remove() returns.

Fixes: ec15c4d0d5d2 ("PCI: altera: Allow building as module")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/linux-pci/20260430204330.3121003-3-mahesh.vaidya@altera.com/
Suggested-by: Dinh Nguyen <dinguyen@kernel.org>
Assisted-by: ChatGPT:GPT-5
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
This converts the driver as Dinh proposed in [1], where sashiko raised
the use-after-free while Bjorn was considering 7a94138caeb2 ("PCI:
altera: Fix resource leaks on probe failure") for backport. Dinh offered
to write the conversion there; we agreed I would send it, since I have
V2 and V3 hardware to test it on.

[1] https://lore.kernel.org/linux-pci/20260430204330.3121003-3-mahesh.vaidya@altera.com/

Note for reviewers, on IRQF_NO_SUSPEND:

Converting the parent from a chained handler to a requested one changes
its suspend behavior, because suspend_device_irqs() skips chained
descriptors. I used IRQF_NO_SUSPEND to preserve the existing behavior
rather than change it in a fix. I would appreciate confirmation from the
IRQ maintainers that this is the right call. The alternative is to omit
the flag and accept the behavior change.

Tested on Stratix 10 (V2) with an igb-driven Ethernet endpoint using
INTx and on Agilex 7 (V3, M-series R-tile) with an NVMe endpoint using
INTx. On both, INTx delivery remained correct under sustained load with
no spurious interrupts reported, and repeated driver bind/unbind cycles
with interrupts in flight produced no warnings and no crashes. V1 shares
altera_pcie_isr() with V2, so the converted handler is identical there,
but I have no Cyclone V hardware to confirm it.

On backporting: I have not added Cc: stable because the conversion
affects all three supported generations and V1 remains untested. If you
would prefer this to accompany 7a94138caeb2 into stable, I can send
targeted backports.

 drivers/pci/controller/pcie-altera.c | 78 ++++++++++++++++------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 8ef56e2fabcf..c5a67aa3be79 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -9,7 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip/chained_irq.h>
+#include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -123,7 +123,7 @@ struct altera_pcie_ops {
 			   unsigned int devfn, int where, int size, u32 *value);
 	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
 			    unsigned int devfn, int where, int size, u32 value);
-	void (*rp_isr)(struct irq_desc *desc);
+	irqreturn_t (*rp_isr)(int irq, void *data);
 };
 
 struct altera_pcie_data {
@@ -796,19 +796,15 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.xlate = pci_irqd_intx_xlate,
 };
 
-static void altera_pcie_isr(struct irq_desc *desc)
+static irqreturn_t altera_pcie_isr(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct altera_pcie *pcie;
-	struct device *dev;
+	struct altera_pcie *pcie = data;
+	struct device *dev = &pcie->pdev->dev;
+	irqreturn_t handled = IRQ_NONE;
 	unsigned long status;
 	u32 bit;
 	int ret;
 
-	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
-	dev = &pcie->pdev->dev;
-
 	while ((status = cra_readl(pcie, P2A_INT_STATUS)
 		& P2A_INT_STS_ALL) != 0) {
 		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
@@ -819,34 +815,33 @@ static void altera_pcie_isr(struct irq_desc *desc)
 			if (ret)
 				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
 		}
+		handled = IRQ_HANDLED;
 	}
-	chained_irq_exit(chip, desc);
+
+	return handled;
 }
 
-static void aglx_isr(struct irq_desc *desc)
+static irqreturn_t aglx_isr(int irq, void *data)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct altera_pcie *pcie;
-	struct device *dev;
+	struct altera_pcie *pcie = data;
+	struct device *dev = &pcie->pdev->dev;
 	u32 status;
 	int ret;
 
-	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
-	dev = &pcie->pdev->dev;
-
 	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
 		       pcie->pcie_data->port_irq_status_offset);
 
-	if (status & CFG_AER) {
-		writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
-				 pcie->pcie_data->port_irq_status_offset));
+	if (!(status & CFG_AER))
+		return IRQ_NONE;
 
-		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
-		if (ret)
-			dev_err_ratelimited(dev, "unexpected IRQ %d\n", pcie->irq);
-	}
-	chained_irq_exit(chip, desc);
+	writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
+			 pcie->pcie_data->port_irq_status_offset));
+
+	ret = generic_handle_domain_irq(pcie->irq_domain, 0);
+	if (ret)
+		dev_err_ratelimited(dev, "unexpected IRQ %d\n", pcie->irq);
+
+	return IRQ_HANDLED;
 }
 
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
@@ -881,7 +876,12 @@ static void altera_pcie_disable_irq(struct altera_pcie *pcie)
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
 	altera_pcie_disable_irq(pcie);
-	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+
+	/*
+	 * free_irq() waits for any in-flight parent handler, so it can no
+	 * longer dispatch through pcie->irq_domain below.
+	 */
+	free_irq(pcie->irq, pcie);
 	irq_domain_remove(pcie->irq_domain);
 }
 
@@ -1034,12 +1034,19 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * The chained handler uses pcie->irq_domain, so set it only after the
-	 * INTx domain has been created.
+	 * The handler demultiplexes into pcie->irq_domain, so request the IRQ
+	 * only after the INTx domain has been created. IRQF_NO_THREAD keeps it
+	 * in hardirq context, which generic_handle_domain_irq() requires, and
+	 * IRQF_NO_SUSPEND keeps the cascade available across suspend as the
+	 * chained handler was.
 	 */
-	irq_set_chained_handler_and_data(pcie->irq,
-					 pcie->pcie_data->ops->rp_isr,
-					 pcie);
+	ret = request_irq(pcie->irq, pcie->pcie_data->ops->rp_isr,
+			  IRQF_NO_THREAD | IRQF_NO_SUSPEND, dev_name(dev),
+			  pcie);
+	if (ret) {
+		dev_err(dev, "Failed to request IRQ %d\n", pcie->irq);
+		goto err_remove_domain;
+	}
 
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
@@ -1067,6 +1074,11 @@ static int altera_pcie_probe(struct platform_device *pdev)
 err_teardown_irq:
 	altera_pcie_irq_teardown(pcie);
 
+	return ret;
+
+err_remove_domain:
+	irq_domain_remove(pcie->irq_domain);
+
 	return ret;
 }
 
-- 
2.34.1

