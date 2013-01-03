Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out03.msg.oleane.net ([62.161.7.1]:33050 "EHLO
	smtp-out03.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3ACJS3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 04:18:29 -0500
Received: from smtp07.msg.oleane.net (smtp07.mail.priv [172.17.20.116])
	by smtp-out03.msg.oleane.net with ESMTP id r039IQCW013811
	for <linux-pci@vger.kernel.org>; Thu, 3 Jan 2013 10:18:26 +0100
Message-ID: <50E54818.9030401@interfaceconcept.com>
Date: Thu, 03 Jan 2013 09:58:00 +0100
From: =?ISO-8859-1?Q?C=E9dric_Cano?= <ccano@interfaceconcept.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: Question: how can I get the real PCI address of a BAR?
References: <50DD6811.7020301@ic.fr> <CAErSpo4nkWwwY5qtsAzgsPYAvUWAKPkML99u+2oiuuzdq4VPKw@mail.gmail.com>
In-Reply-To: <CAErSpo4nkWwwY5qtsAzgsPYAvUWAKPkML99u+2oiuuzdq4VPKw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

pcibios_resource_to_bus() does  what I need.

Thanks.

Le 30/12/2012 20:46, Bjorn Helgaas a écrit :
> On Fri, Dec 28, 2012 at 2:36 AM, Cédric Cano <ccano@interfaceconcept.com> wrote:
>> Hi,
>>
>> I'm writing a driver for a DMA engine on the PCI bus. My architecture is a
>> 36-bit PowerPC (MPC85xx).
>>
>> In my DMA driver, I want to configure the DMA to transfer data to/from a PCI
>> device.
>> I get the PCI address of the device BAR with the command pci_resource_start.
> pci_resource_start() doesn't give you a PCI bus address; it gives you
> a CPU physical address.  You ioremap() that address if you want a CPU
> to access the BAR MMIO space.
>
>> This address is 36-bit but the PCI BAR of the device is 32-bit: I can't use
>> the 36-bit address to run the DMA.
>>
>> In kernel documentations, it's advised not to directly read the BAR.
>>
>> Is there a function which provides the real PCI address i.e. the one stored
>> in the BAR?
> You can use pcibios_resource_to_bus() to convert the CPU physical
> address from the pci_dev.resource[] back to a PCI bus address.
> sym_iomap_device() does something similar to what you're asking about.
>
> Bjorn
>

