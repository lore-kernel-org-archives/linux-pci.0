Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdHQIVc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 04:21:32 -0400
Subject: Re: PCIe oops for NULL pointer dereference during next-20170807 and
 next-20170815
To: Joerg Roedel <joro@8bytes.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <c6ae57b6-1175-4ba4-b66d-d2f5393d06fc@rock-chips.com>
 <2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
 <20170817075825.GR30515@8bytes.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <94b7e141-362d-02f3-1403-af7a1dfc8c4e@arm.com>
Date: Thu, 17 Aug 2017 09:21:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170817075825.GR30515@8bytes.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/08/17 08:58, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 03:02:31PM +0800, Shawn Lin wrote:
>> So should we revert this commit or maybe we could add some checking
>> into gic-v2m and gic-v3-its to see if the dev is iommu-capable? If not,
>> we should create another routine to map MSI msg.
> 
> Yes, fixing this in gic code is the right approach. I usually don't
> revert patches to hide problems somewhere else.
Here's what it would look like:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b47097a3e4b4..5e81ad62c801 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1125,6 +1125,8 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
+	struct iommu_group *group;
+	struct device *dev;
 	u64 addr;
 
 	its = its_dev->its;
@@ -1134,7 +1136,12 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->address_hi		= upper_32_bits(addr);
 	msg->data		= its_get_event_id(d);
 
-	iommu_dma_map_msi_msg(d->irq, msg);
+	dev = msi_desc_to_dev(irq_get_msi_desc(d->irq));
+	group = iommu_group_get(dev);
+	if (group) {
+		iommu_dma_map_msi_msg(d->irq, msg);
+		iommu_group_put(group);
+	}
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,

I'm not convinced  that playing with the group refcount in an irqchip
is the right approach...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
