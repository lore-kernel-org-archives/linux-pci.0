Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:45521 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbaHKOSV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 10:18:21 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 11 Aug 2014 19:48:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 43DC3394001A
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:48:15 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s7BEKUrk5046604
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:50:30 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7BEIEdp030926
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:48:14 +0530
Date: Mon, 11 Aug 2014 22:18:12 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci/msi-x: Sanity check MSI-X table offset
Message-ID: <20140811141812.GB5794@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1407731815.4508.69.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407731815.4508.69.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 11, 2014 at 02:36:55PM +1000, Benjamin Herrenschmidt wrote:
>If the hardware device mis-behaves (such as for example crashes or
>gets unplugged at the wrong time) and provides us with a bogus
>MSI-X table offset, all sorts of "interesting" and potentially
>very hard to debug things can happen.
>
>For example, on POWER8, such a device caused us to ioremap an area
>outside of the region assigned to the PCI bus, causing subsequent
>accesses to cause a PowerBus timeout and checkstop the machine.
>
>Since this isn't a hot path, let's add a good dose of sanity
>checking to msix_map_region() to flag these issues early and limit
>the damage.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
> drivers/pci/msi.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>index 5a40516..a584f590 100644
>--- a/drivers/pci/msi.c
>+++ b/drivers/pci/msi.c
>@@ -666,13 +666,30 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
> static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
> {
> 	resource_size_t phys_addr;
>-	u32 table_offset;
>+	u32 table_offset, table_end;
> 	u8 bir;
>
> 	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
> 			      &table_offset);
> 	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>+	if (bir >= DEVICE_COUNT_RESOURCE) {

could we use this?

        if (bir > PCI_STD_RESOURCE_END)

my understanding is the IOV BAR and bridge resources are not proper for MSI-X
neigher.

>+		dev_err(&dev->dev, "MSI-X points to non-exiting BAR %d !\n",
>+			bir);
>+		return NULL;
>+	}
>+	if ((pci_resource_flags(dev, bir) & IORESOURCE_MEM) == 0) {
>+		dev_err(&dev->dev, "MSI-X points to non-memory BAR %d !\n",
>+			bir);
>+		return NULL;
>+	}
> 	table_offset &= PCI_MSIX_TABLE_OFFSET;
>+	table_end = table_offset + nr_entries * PCI_MSIX_ENTRY_SIZE;
>+	if (table_end <= table_offset ||
>+	    table_end > pci_resource_len(dev, bir)) {
>+		dev_err(&dev->dev, "MSI-X table outside of BAR boundary !"
>+			" (0x%08x..%08x)\n", table_offset, table_end);
>+		return NULL;
>+	}
> 	phys_addr = pci_resource_start(dev, bir) + table_offset;
>
> 	return ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

