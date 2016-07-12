Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60320 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbcGLP4q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 11:56:46 -0400
Subject: Re: PCIe MSI address is not written at pci_enable_msi_range call
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8520D5D51A55D047800579B094147198258B80DE@XAP-PVEXMBX01.xlnx.xilinx.com>
 <57835D35.1000901@arm.com>
 <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <5785133A.6070908@arm.com>
Date: Tue, 12 Jul 2016 16:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258B81DF@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/16 10:33, Bharat Kumar Gogada wrote:
> Hi Marc,
> 
> Thanks for the reply.
> 
> From PCIe Spec:
> MSI Enable Bit:
> If 1 and the MSI-X Enable bit in the MSI-X Message
> Control register (see Section 6.8.2.3) is 0, the
> function is permitted to use MSI to request service
> and is prohibited from using its INTx# pin.
> 
> From Endpoint perspective, MSI Enable = 1 indicates MSI can be used which means MSI address and data fields are available/programmed.
> 
> In our SoC whenever MSI Enable goes from 0 --> 1 the hardware latches onto MSI address and MSI data values.
> 
> With current MSI implementation in kernel, our SoC is latching on to incorrect address and data values, as address/data
> are updated much later than MSI Enable bit.

As a side question, how does setting the affinity work on this end-point
if this involves changing the address programmed in the MSI registers?
Do you expect the enabled bit to be toggled to around the write?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
