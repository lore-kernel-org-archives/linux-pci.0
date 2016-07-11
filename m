Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:58722
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757946AbcGKJdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2016 05:33:45 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>
Subject: RE: PCIe MSI address is not written at pci_enable_msi_range call
Date: Mon, 11 Jul 2016 09:33:37 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
In-Reply-To: <57835D35.1000901@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

Thanks for the reply.

>From PCIe Spec:
MSI Enable Bit:
If 1 and the MSI-X Enable bit in the MSI-X Message
Control register (see Section 6.8.2.3) is 0, the
function is permitted to use MSI to request service
and is prohibited from using its INTx# pin.

>From Endpoint perspective, MSI Enable = 1 indicates MSI can be used which means MSI address and data fields are available/programmed.

In our SoC whenever MSI Enable goes from 0 --> 1 the hardware latches onto MSI address and MSI data values.

With current MSI implementation in kernel, our SoC is latching on to incorrect address and data values, as address/data
are updated much later than MSI Enable bit.

Thanks & Regards,
Bharat

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Monday, July 11, 2016 2:18 PM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>; Bjorn Helgaas
> <bhelgaas@google.com>
> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
>
> On 11/07/16 03:32, Bharat Kumar Gogada wrote:
> > Hi,
> >
> > I have a query.
> > I see that when we use PCI_MSI_IRQ_DOMAIN to handle MSI's, MSI
> address is not being
> > written in to end point's PCI_MSI_ADDRESS_LO/HI at the call
> pci_enable_msi_range.
> >
> > Instead it is being written at the time end point requests irq.
> >
> > Can any one tell the reason why is it handled in this manner ?
>
> Because there is no real need to do it earlier, and in some case you
> cannot allocate MSIs at that stage. pci_enable_msi_range only works out
> how many vectors are required. At least one MSI controller (GICv3 ITS)
> needs to know how many vectors are required before they can be provided
> to the end-point.
>
> Do you see any issue with this?
>
> Thanks,
>
>       M.
> --
> Jazz is not dead. It just smells funny...


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

