Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48244 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab2B1E02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2012 23:26:28 -0500
Received: by wejx9 with SMTP id x9so713685wej.19
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2012 20:26:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330401133.11728.24.camel@pasglop>
References: <20120228025002.3990.7392.stgit@bhelgaas.mtv.corp.google.com> <1330401133.11728.24.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 27 Feb 2012 21:26:06 -0700
Message-ID: <CAErSpo704j799mzULS-yU3oM5QL881jcX=EzeRBTuR-JuCMO3w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/PCI: compute I/O space bus-to-resource offset consistently
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2012 at 8:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-02-27 at 19:50 -0700, Bjorn Helgaas wrote:
>> --- a/arch/powerpc/kernel/pci_32.c
>> +++ b/arch/powerpc/kernel/pci_32.c
>> @@ -219,9 +219,9 @@ void __devinit pcibios_setup_phb_io_space(struct
>> pci_controller *hose)
>>         struct resource *res = &hose->io_resource;
>>
>>         /* Fixup IO space offset */
>> -       io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
>> -       res->start = (res->start + io_offset) & 0xffffffffu;
>> -       res->end = (res->end + io_offset) & 0xffffffffu;
>> +       io_offset = pcibios_io_space_offset(hose);
>> +       res->start += io_offset;
>> +       res->end += io_offset;
>>  }
>
> Well, you are losing the 0xffffffff mask... so basically, what happens
> is that your offset, if negative, will be 0 extended by
> pcibios_io_space_offset() instead of sign-extended, and thus the
> resource will have crap stuff in the top 32-bit.

I don't think it will have random crap.  Here's what I think will
happen.  Assume typical 64KB I/O port spaces, PCI bus addresses in the
range 0x0-0xffff, with isa_io_base = 0x10000000.  If we compute the
offset as I did in the patch:

    (unsigned long) hose->io_base_virt - _IO_BASE

the subtraction result is 32-bits and is zero-extended to 64 bits.
Alternatively, we could do this:

    (unsigned long long) (unsigned long) hose->io_base_virt - _IO_BASE

Here the conversion to 64 bits happens before the subtraction, so the
upper 32 bits of the result are likely all ones.  Examples:

hose->io_base_virt      offset                  resource
0x10000000              0x00000000              [io 0x0000-0xffff]
0x11000000              0x01000000              [io 0x01000000-0x0100ffff]
0x0f000000              0xff000000              [io 0xff000000-0xff00ffff]

0x10000000              0x00000000              [io 0x0000-0xffff]
0x11000000              0x01000000              [io 0x01000000-0x0100ffff]
0x0f000000              0xffffffffff000000      [io
0xffffffffff000000-0xffffffffff00ffff]

Either way will probably work since you only care about the low 32
bits, which are the same either way.  I chose the first because
casting the 32-bit pointer to a 64-bit value seemed to require two
ugly casts and the resulting resource values look unwieldy when
printed.

Bjorn
