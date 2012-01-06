Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46596 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759152Ab2AFXty (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 18:49:54 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 487C520A4A
	for <linux-pci@vger.kernel.org>; Fri,  6 Jan 2012 18:49:54 -0500 (EST)
Date: Fri, 6 Jan 2012 15:49:14 -0800
From: Greg KH <greg@kroah.com>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Add pcie_hp=nomsi to disable MSI for pciehp driver
Message-ID: <20120106234914.GB14926@kroah.com>
References: <20120106170422.17595.31912.sendpatchset@dhcp-189-101.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120106170422.17595.31912.sendpatchset@dhcp-189-101.bos.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 06, 2012 at 12:04:22PM -0500, MUNEDA Takahiro wrote:
> --- linux-3.2.orig/drivers/pci/pcie/portdrv_core.c
> +++ linux-3.2/drivers/pci/pcie/portdrv_core.c
> @@ -189,8 +189,20 @@ static int init_service_irqs(struct pci_
>  {
>  	int i, irq = -1;
>  
> -	/* We have to use INTx if MSI cannot be used for PCIe PME. */
> -	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) {
> +	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
> +	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
> +	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
> +		if (dev->pin)
> +			irq = dev->irq;
> +		goto no_msi;
> +	}
> +
> +	/*
> +	 * Disable MSI/MSI-X to prevent un-wanted interrupts while
> +	 * device shutting down
> +	 */
> +	if ((mask & PCIE_PORT_SERVICE_HP) &&
> +	    dev->vendor == PCI_VENDOR_ID_IDT && dev->device == 0x807f) {
>  		if (dev->pin)
>  			irq = dev->irq;
>  		goto no_msi;

Why not combine the if statements, you are doing the same thing in them,
right?

greg k-h
