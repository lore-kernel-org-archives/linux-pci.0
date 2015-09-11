Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33385 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbIKMLT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 08:11:19 -0400
Received: by lbcjc2 with SMTP id jc2so38440529lbc.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2015 05:11:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441961093.3126.8.camel@pengutronix.de>
References: <loom.20150910T144529-230@post.gmane.org> <1441893436.7900.10.camel@pengutronix.de>
 <CABFJKVLW3MsnxybhDjZ02ghUV2mKfPgj7kmMdiuJ+oK94OYFxQ@mail.gmail.com> <1441961093.3126.8.camel@pengutronix.de>
From: Frank Jenner <faj6816@rit.edu>
Date: Fri, 11 Sep 2015 08:10:57 -0400
Message-ID: <CABFJKVKxpkS5Qb7mYbOuFxnW+_oaqdRX2UUW2GWaeT6Ss=oa0A@mail.gmail.com>
Subject: Re: Multiple MSIs on ARM imx6q
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ah! Things are making more sense to me now. I was failing to realize
the distinction between the "port" and the "device" in terms of the
MSI allocations. In particular, I was getting confused because the
"port" happened to be limited to only 32 MSIs (even though the
hardware can support 256), which is the same as the number of MSIs
allowed for a device.

By simply increasing the MAX_MSI_IRQS value from 32 to 64 (in
conjunction with using your multivector MSI support patches mentioned
previously), I was able to successfully allocate all 32 of the EP's
MSIs, while also allowing PME to use an MSI. I'm not sure if there
should be more to it than that, but all 32 MSIs from the EP appear to
work now with that change.

If there's more I'm missing besides just modifying MAX_MSI_IRQS and
you still want to make a patch for me to test, I'll be happy to give
it a go with my device.

Thanks again!


On Fri, Sep 11, 2015 at 4:44 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Frank,
>
> Am Donnerstag, den 10.09.2015, 13:37 -0400 schrieb Frank Jenner:
>> Hi Lucas,
>>
>> Thanks for the quick response. See inline:
>>
>> On Thu, Sep 10, 2015 at 9:57 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> [...]
>
>> >
>> > An implementation for the i.MX6 is already sitting in Bjorns PCI
>> > maintainer tree and is expected to be merged in kernel 4.4.
>> >
>>
>> I took a look at Bjorn's pci-4.4/host-designware branch and saw your
>> commits. It looks like the patches I'm using apply most of the same
>> changes. While they do enable me to get multiple MSIs back from
>> pci_enable_msi_range() and I get the correct IRQs back to my ISR, I
>> still run into the issue below when attempting to get the full 32
>> vectors.
>>
>> >> Unfortunately, even if I work around the arch_setup_msi_irqs() limitation
>> >> (which I've done by trying out patches 448141 and 448142 from
>> >> http://patchwork.ozlabs.org/project/linux-pci/list/) and break through to
>> >> the assign_irq() function in drivers/pci/host/pcie-designware.c, I still
>> >> cannot allocate all 32 MSIs that my device reports.
>> >>
>> >> It appears that one of the bits in the msi_irq_in_use bitmap is already set
>> >> prior to my driver requesting any MSIs, meaning there aren't enough free
>> >> slots for the 32 MSIs I am requesting, and causing the function to fail with
>> >> -ENOSPC. Based on the output from /proc/interrupts, I believe that the PCIe
>> >> PME service driver is consuming one of the 32 available MSI slots. Thus, my
>> >> second question is:
>> >>
>> >> 2.) Is it possible to leverage all 32 MSIs while still using PCIe PME?
>> >>
>> >> I tried using the kernel command line argument pcie_pme=nomsi, but that
>> >> appeared to disable all MSIs for the device rather than just making the PME
>> >> service driver use some other mechanism.
>> >>
>> > It should be possible to make PME use a legacy INT, but I would have to
>> > look this up in the code.
>>
>> Could you please elaborate on this? I'm a little confused why PME
>> occupies one of the MSI slots in the first place. Also, as I thought a
>> device could only use either MSIs or legacy INTs (but not both), is it
>> even possible for PME to use legacy INTs while my driver uses MSIs?
>> >
>
> Sorry, I'm not sure about this myself.
>
>> > Another alternative is to extend the i.MX6 driver. It should be able to
>> > provide up to 256 MSI interrupt vectors. But I have no way to test that,
>> > so if you could help with testing I can certainly come up with a patch
>> > for that.
>>
>> Where does the 256 come from?
>>
> It's the size of the register space available for MSI IRQs in the i.MX6
> implementation.
>
>> I appreciate the help, and I would be happy to test out a patch for
>> you with the caveat that I'm using a custom board so I can only test
>> any changes against our specific device.
>>
> That's totally fine. I can test that I don't break the currently working
> cases myself, so I only need you to test if the extension works as I
> have no EP with such a large number of MSI IRQs.
>
> Regards,
> Lucas
> --
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
>
