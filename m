Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:3552
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751928AbcGLJL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 05:11:59 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>
Subject: RE: PCIe MSI address is not written at pci_enable_msi_range call
Date: Tue, 12 Jul 2016 09:11:51 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B861F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
 <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5783733C.70702@arm.com>
 <8520D5D51A55D047800579B094147198258B823D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5783C02F.7030901@arm.com>
In-Reply-To: <5783C02F.7030901@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
>
> On 11/07/16 11:51, Bharat Kumar Gogada wrote:
> >>> Hi Marc,
> >>>
> >>> Thanks for the reply.
> >>>
> >>> From PCIe Spec:
> >>> MSI Enable Bit:
> >>> If 1 and the MSI-X Enable bit in the MSI-X Message Control register
> >>> (see Section 6.8.2.3) is 0, the function is permitted to use MSI to
> >>> request service and is prohibited from using its INTx# pin.
> >>>
> >>> From Endpoint perspective, MSI Enable = 1 indicates MSI can be used
> >> which means MSI address and data fields are available/programmed.
> >>>
> >>> In our SoC whenever MSI Enable goes from 0 --> 1 the hardware
> >>> latches
> >> onto MSI address and MSI data values.
> >>>
> >>> With current MSI implementation in kernel, our SoC is latching on to
> >> incorrect address and data values, as address/data
> >>> are updated much later than MSI Enable bit.
> >>
> >> Interesting. It looks like we're doing something wrong in the MSI flow.
> >> Can you confirm that this is limited to MSI and doesn't affect MSI-X?
> >>
> > I think it's the same issue irrespective of MSI or MSI-X as we are
> > enabling these interrupts before providing the  vectors.
> >
> > So we always have a hole when MSI/MSI-X is 1, and software driver has
> > not registered the irq, and End Point may raise an interrupt (may be
> > due to error) in this point of time.
>
> Looking at the MSI-X part of the code, there is this:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci
> /msi.c#n764
>
> which hints that it may not be possible to do otherwise. Damned if you do,
> damned if you don't.
>
MSI-X might not have problem then, how to resolve the issue with MSI ?

Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

