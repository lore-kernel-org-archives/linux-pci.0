Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.missinglinkelectronics.com ([5.9.45.205]:60746 "EHLO
	smtp.missinglinkelectronics.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754506Ab3FAOk6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2013 10:40:58 -0400
Message-ID: <f0393aa007065187ad5ef5e765d75640.squirrel@mail.missinglinkelectronics.com>
In-Reply-To: <COL126-W433C75A9D7FCC1A5A561B3B7930@phx.gbl>
References: <51A920C5.40209@missinglinkelectronics.com>
    <CAErSpo7CrajY0__m91yRMi0oo0CjrGdqWPYWxQx+rx5zz4F-qg@mail.gmail.com>
    <51A9333C.60902@missinglinkelectronics.com>,<51A9DB54.3090709@missinglinkelectronics.com>
    <COL126-W433C75A9D7FCC1A5A561B3B7930@phx.gbl>
Date: Sat, 1 Jun 2013 07:40:50 -0700
Subject: RE: MSI-X capability display of pciutils
From: "David Epping" <david.epping@missinglinkelectronics.com>
To: "Pramod KS" <psudheen@live.com>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> David/All,
> Not sure if I can use this thread to ask but wonderingwhere do hobbyists
> can get to see the PCIe spec?
>
>> Date: Sat, 1 Jun 2013 13:30:28 +0200
>> From: david.epping@missinglinkelectronics.com
>> To: bhelgaas@google.com
>> CC: linux-pci@vger.kernel.org
>> Subject: Re: MSI-X capability display of pciutils
>>
>> Bjorn,
>>
>> I found a ECN and presentation by PCI-SIG. Both documents describe
>> exactly the scheme you pointed out.
>> Seems I have been using an old or draft version. I will request the
>> current version right now.
>>
>> Thank you for your kind help and sorry for any confusion caused.
>> Best regards,
>> David
>>
>> On 01.06.2013 01:33, David Epping wrote:
>> > On 01.06.2013 00:48, Bjorn Helgaas wrote:
>> >> On Fri, May 31, 2013 at 4:14 PM, David Epping
>> >> <david.epping@missinglinkelectronics.com>  wrote:
>> >>> Hello,
>> >>>
>> >>> I am inspecting the MSI-X setup of some PCIe devices and have
>> questions
>> >>> about the output of lspci.
>> >>>
>> >>> It looks something like this:
>> >>> Capabilities: [50] MSI-X: Enable+ Count=32 Masked-
>> >>>      Vector table: BAR=0 offset=00002000
>> >>>      PBA: BAR=0 offset=00003000
>> >>>
>> >>> As far as I understand the PCI 3.0 specification MSI-X capabilities
>> >>> define a
>> >>> 32 bit register for the upper address portion of the MSI target
>> >>> addresses
>> >>> (at capability offset 4) and another 32 bit register pointing to the
>> >>> BAR and
>> >>> inter-BAR offset for the table of lower address portions of the MSI
>> >>> target
>> >>> addresses (at capability offset 8).
>> >>> Why are there two lines in the lspci output indicating some BAR and
>> >>> offset?
>> >>> What do they mean?
>> >> My understanding is that there are three data structures here:
>> >>    1) The MSI-X Capability (Figure 6-10) in config space
>> >>    2) The "MSI-X Table" (Figure 6-11) in PCI memory space
>> >>    3) The "MSI-X PBA" (Pending Bit Array, Figure 6-12) in PCI memory
>> >> space
>> >>
>> >> The "Vector table" line tells you how to find the "MSI-X Table," and
>> >> the "PBA" line tells you how to find the "MSI-X PBA" table.
>> >>
>> >> In MSI (not MSI-X), there is only one MSI target address, and it is
>> in
>> >> the MSI capability.
>> >>
>> >> In MSI-X, each MSI-X vector can have its own target address, and
>> those
>> >> addresses are not in the capability itself; they are stored in the
>> >> memory decoded by a BAR.
>> >>
>> >> In your case, you would read the bus address from BAR 0, and the
>> >> vector table should be at offsets 0x2000-0x21ff (32 16-byte entries)
>> >> from that address.  The PBA should be at offsets 0x3000-0x30ff (32
>> >> 8-byte entries).
>> >>
>> >> lspci will show you the BAR values, but it doesn't dump PCI memory
>> >> space, so you'd have to use /dev/mem or a tool like
>> >> http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c to actually look at the
>> >> tables.
>> >>
>> >> Bjorn
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-pci"
>> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> > Bjorn,
>> >
>> > thank you for your quick reply.
>> >
>> > So far the concepts of MSI and MSI-X are clear. I did not have the
>> > meaning of the PBA acronym, but now I know what it stands for.
>> > I do however not see that reflected in the spec. As your figure
>> > references are off by one and I do not have the PBA figure, we should
>> > clarify the document used. I'm looking at PCI Local Bus Specification
>> > Revision 3.0 from August 2002.
>> >
>> > According to this document (and in case I'm reading it correctly) the
>> > pending bit is part of each MSI-X Vector Table entry (lowest bit in
>> > the address portion - section 6.8.2.6). The lspci source code and its
>> > output (and your explanation) however suggest that the pending bits
>> > are stored in a separate table.
>> > In addition this specification document has the common upper address
>> > portion of each MSI target address at capability offset 4 and the BAR
>> > and intra-BAR offset at capability offset 8. The pciutils source code
>> > defines the later to be at 4 and uses offset 8 to derive the PBA.
>> >
>> > I wonder where our disconnect is. What is the title and revision of
>> > the document you are referring to?
>> > Thanks again,
>> > David
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
>> in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> David Epping
>> david.epping@missinglinkelectronics.com
>> Skype: david.epping
>> Mobile US: +1 (408) 4757-574
>> Mobile DE: +49 (179) 9656-223
>>
>> Missing Link Electronics
>> http://www.missinglinkelectronics.com
>> Office DE: +49 (731) 802-3930
>> Office US: +1  (408) 457-0700
>> Skype: missing.link.electronics
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

AFAIK there is no public (full or reduced) version of the relevant
specifications. There are some documents available for download for
non-members, but for the real spec your employer is probably your best
chance.

