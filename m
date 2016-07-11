Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51394 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757833AbcGKIrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jul 2016 04:47:53 -0400
Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57835D35.1000901@arm.com>
Date: Mon, 11 Jul 2016 09:47:49 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/16 03:32, Bharat Kumar Gogada wrote:
> Hi,
> 
> I have a query.
> I see that when we use PCI_MSI_IRQ_DOMAIN to handle MSI's, MSI address is not being
> written in to end point's PCI_MSI_ADDRESS_LO/HI at the call pci_enable_msi_range.
> 
> Instead it is being written at the time end point requests irq.
> 
> Can any one tell the reason why is it handled in this manner ?

Because there is no real need to do it earlier, and in some case you
cannot allocate MSIs at that stage. pci_enable_msi_range only works out
how many vectors are required. At least one MSI controller (GICv3 ITS)
needs to know how many vectors are required before they can be provided
to the end-point.

Do you see any issue with this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
