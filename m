Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:59649 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2EWRw4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 13:52:56 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <jlarrew@linux.vnet.ibm.com>;
	Wed, 23 May 2012 11:52:55 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BCBCC3E40047
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:52:13 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q4NHq0Yc179366
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:52:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q4NHpxTq026768
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:52:00 -0600
Message-ID: <4FBD23BD.6050703@linux.vnet.ibm.com>
Date: Wed, 23 May 2012 12:51:57 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, jbarnes@virtuousgeek.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier
 for powerpc
References: <4FBC4C92.7080902@jp.fujitsu.com>
In-Reply-To: <4FBC4C92.7080902@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2012 09:33 PM, Hiroo Matsumoto wrote:

> +static int pcibios_device_change_notifier(struct notifier_block *nb,
> +					  unsigned long action, void *data)
> +{
> +	struct pci_dev *dev = to_pci_dev(data);
> +



In the general case, we don't know what *data contains until we evaluate
'action'. This conversion should probably be moved inside the case:
statement.

> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		/* Setup OF node pointer in the device */
> +		dev->dev.of_node = pci_device_to_OF_node(dev);
> +
> +		/* Fixup NUMA node as it may not be setup yet by the generic
> +		 * code and is needed by the DMA init
> +		 */
> +		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
> +
> +		/* Hook up default DMA ops */
> +		set_dma_ops(&dev->dev, pci_dma_ops);
> +		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> +
> +		/* Additional platform DMA/iommu setup */
> +		if (ppc_md.pci_dma_dev_setup)
> +			ppc_md.pci_dma_dev_setup(dev);
> +
> +		/* Read default IRQs and fixup if necessary */
> +		pci_read_irq_line(dev);
> +		if (ppc_md.pci_irq_fixup)
> +			ppc_md.pci_irq_fixup(dev);
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block device_nb = {
> +	.notifier_call = pcibios_device_change_notifier,
> +};



This is just a nit pick, but I think the naming of
pcibios_device_change_notifier() is a bit misleading. It doesn't
actually notify anything, but instead it *handles* notifications.
Perhaps a better name would be pcibios_device_change_handler() or
pcibios_device_change_callback()?

Sincerely,

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com

