Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com ([104.47.38.86]:57888
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751236AbcGMIdt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 04:33:49 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>
Subject: RE: PCIe MSI address is not written at pci_enable_msi_range call
Date: Wed, 13 Jul 2016 08:33:40 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B896E@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
 <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5785133A.6070908@arm.com>
 <8520D5D51A55D047800579B094147198258B8909@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5785F8DC.4060100@arm.com>
In-Reply-To: <5785F8DC.4060100@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
>
> On 13/07/16 07:22, Bharat Kumar Gogada wrote:
> >> Subject: Re: PCIe MSI address is not written at pci_enable_msi_range
> >> call
> >>
> >> On 11/07/16 10:33, Bharat Kumar Gogada wrote:
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
> >>> incorrect address and data values, as address/data are updated much
> >>> later
> >> than MSI Enable bit.
> >>
> >> As a side question, how does setting the affinity work on this
> >> end-point if this involves changing the address programmed in the MSI
> registers?
> >> Do you expect the enabled bit to be toggled to around the write?
> >>
> >
> > Yes,
>
> Well, that's pretty annoying, as this will not work either. But maybe your MSI
> controller has a single doorbell? You haven't mentioned which HW that is...
>
The MSI address/data is located in config space, in our SoC for the logic behind PCIe
to become aware of new address/data  MSI enable transition is used (0 to 1).
The logic cannot keep polling these registers in configuration space as it would consume power.

So the logic uses the transition in MSI enable to latch on to address/data.

> > Would anybody change MSI address in between wouldn't it cause race
> condition ?
>
> Changing the affinity of an interrupt is always racy, and the kernel deals with
> it.
>

Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

