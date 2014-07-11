Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:39350 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaGKSAp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 14:00:45 -0400
Received: by mail-qc0-f170.google.com with SMTP id c9so1322637qcz.29
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 11:00:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
References: <20140611060118.GB3169@yanx> <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
 <20140702210736.GB28852@google.com> <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
 <20140703131526.GG28852@google.com> <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
 <20140703221152.GH28852@google.com> <CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Jul 2014 12:00:21 -0600
Message-ID: <CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 10, 2014 at 7:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jul 3, 2014 at 3:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Jul 03, 2014 at 12:59:21PM -0700, Yinghai Lu wrote:
>
>>> when we try to size it,  means that bar is not assigned. with r->flags
>>> = 0, means
>>> we will ignore it all the way.
>>
>> With "r->flags = 0", we will not try to assign resources to the BAR,
>> but the hardware BAR still exists and contains some address.  If the
>> device has other memory BARs, pci_enable_resources() will turn on
>> PCI_COMMAND_MEMORY.  Now the "r->flags == 0" BAR is enabled but the
>> address it contains might conflict with other devices.  That's the
>> problem.
>>
>> To fix this, I think we need to do "r->flags |= IORESOURCE_UNSET |
>> IORESOURCE_DISABLED".
>
> No, that is not right.
>
> Current that r->flags = 0 and reset_resource() cover the bug in
> pci_enable_resources() when assign and reassign resource fail.
>
> In pci_enable_resources() if there is one resource with IO BAR or SRIOV BAR
> is not assigned and have UNSET, it will prevent device from being enabled.
>
> Most drivers could work without io port.
>
> If you change r->flags = 0 to
> r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED
>
> Those drivers would not work anymore.

If a driver doesn't need IO ports, it should use
pci_enable_device_mem().  Then pci_enable_device_flags() will build a
BAR bitmask that does not include the IO BARs, and
pci_enable_resources() will not look at the resources corresponding to
those BARs at all (so it doesn't matter what r->flags is), and it will
not turn on PCI_COMMAND_IO.

> I also know one driver that could work with pref mmio, but mmio is not assigned.
> --- silicon bug, that it exposes non-needed mmio bar.

The driver might work, but turning on PCI_COMMAND_MEMORY when an MMIO
BAR is not assigned is dangerous and could cause bus conflicts.  If we
can't safely turn on PCI_COMMAND_MEMORY and this driver stops working,
well, I think that's tough luck.

I explained why I think it is dangerous in the paragraph "With
'r->flags = 0', ..." above.  This a question of how the hardware
behaves, so if you think I'm wrong, you need to point out something in
the spec that says the hardware works differently than how I think it
does.

> BTW I think we may need to clear the BAR in pci_claim_resource().
>
> Maybe Linus or Greg have more idea about this.
> Do we need to get more strict? will only enable PCI_COMMAND_MEMORY
> unless all mmio BARs get assigned value?

I think we should turn on PCI_COMMAND_MEMORY only when the driver
requests IORESOURCE_MEM and all MMIO BARs are assigned.

Bjorn
