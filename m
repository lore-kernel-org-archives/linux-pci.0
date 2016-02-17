Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33395 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQRHf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2016 12:07:35 -0500
Received: by mail-yw0-f179.google.com with SMTP id u200so18304865ywf.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Feb 2016 09:07:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160216210337.GA8244@localhost>
References: <1455487501-28630-2-git-send-email-jchandra@broadcom.com>
 <1455528398-29311-1-git-send-email-jchandra@broadcom.com> <20160215183015.GC12641@localhost>
 <CAKc_7PVVn2ookpbOUuT-jyUq6e6hJYKLpM+d9=6CqYtLO45tWw@mail.gmail.com>
 <20160216171418.GA702@localhost> <CAKc_7PVBH8h9aPK7j74yCjTOnJ22FzNd2O8nDUJn7n0iKUD_FQ@mail.gmail.com>
 <20160216210337.GA8244@localhost>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Wed, 17 Feb 2016 22:36:55 +0530
Message-ID: <CAKc_7PW3OBZcAW-rVEdWa2i94acgT9EhjS2Kbnb-ot36ZXPMUw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: Handle Broadcom Vulcan quirks
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 2:33 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Arnd, Rob, DT host bridge description questions]
>
> On Tue, Feb 16, 2016 at 11:39:41PM +0530, Jayachandran Chandrashekaran Nair wrote:
>> On Tue, Feb 16, 2016 at 10:44 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Tue, Feb 16, 2016 at 09:47:34PM +0530, Jayachandran Chandrashekaran Nair wrote:
>> >> On Tue, Feb 16, 2016 at 12:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> > On Mon, Feb 15, 2016 at 02:56:38PM +0530, Jayachandran C wrote:
>> >> >> Handle two quirks of the PCI controller on Broadcom's Vulcan processor.
>> >> >>  - Mark internal bridges so that they are skipped during DMA alias
>> >> >>    search.
>> >> >>  - Skip BAR0 resource assignment for internal bridges. The BARs
>> >> >>    of internal bridges should not be assigned from the mem resource
>> >> >>    range.
>> >> >> ...
>> >> >>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
>> >> >>  1 file changed, 21 insertions(+)
>> >> >>
>> >> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> >> >> index 0575a1e..afc186a 100644
>> >> >> --- a/drivers/pci/quirks.c
>> >> >> +++ b/drivers/pci/quirks.c
>> >> >> @@ -3705,6 +3705,27 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
>> >> >>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>> >> >>
>> >> >>  /*
>> >> >> + * Two levels of bridges in Broadcom Vulcan are not real PCI or PCIe bridges.
>> >> >> + * These are internal bridges and should not be used for dma alias
>> >> >> + * calculations. Additionally, the BAR0 of thes bridges should not be
>> >> >> + * assigned with a mem resource from linux
>> >> >> + */
>> >> >> +static void quirk_bridge_brcm_vulcan_internal(struct pci_dev *pdev)
>> >> >> +{
>> >> >> +     struct resource *r = &pdev->resource[0];
>> >> >> +
>> >> >> +     /* skip from alias search */
>> >> >> +     pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS;
>> >> >> +
>> >> >> +     /* clear BAR0, should not be used from Linux */
>> >> >> +     memset(r, 0, sizeof(*r));
>> >> >
>> >> > This definitely needs some explanation.  The whole point of the
>> >> > architected PCI config space header is so that generic OS code can
>> >> > manage the device without having to add device-specific code.
>> >> >
>> >> > Are you saying the register at 0x10 in config space is not actually a
>> >> > BAR at all?  Or it is a BAR, but you don't think anybody should need
>> >> > to use it?
>> >>
>> >> These is a proper BAR (64 bit pref) in the bridge's Type 1 header, but:
>> >> 1. Assigning a memory resource from the pci memory window to this
>> >>    BAR causes the PCIe system to fail (this is a bug). So we cannot
>> >>    expose this BAR to standard Linux code without even more quirks
>> >>    and hacks.
>> >
>> > Are you saying assigning space for this BAR exposes a Linux PCI bug?
>> > If so, I'd like to know more about that because we should fix it.
>> >
>> > Or does it expose a hardware bug in the Broadcom device?
>>
>> This is a hardware bug (or non-compliance). The BAR cannot be
>> assigned from the PCI MEM range. To use it we need to program
>> an address outside the areas assigned to PCI to the BAR. But like
>> I said it is better for us to ignore the BAR in linux and then the
>> device acts as a normal bridge.
>
> Your PCI host bridge has a window of address space that it forwards
> from the primary (CPU) side to the secondary (PCI) side.  I assume
> that's what you mean by the "PCI MEM range."  Apparently if the BAR is
> programmed inside that window, it causes some hardware error.  That
> still seems strange; there's no driver for the device, and we know the
> range is in use so it won't be assigned to any other device, so Linux
> should never *access* the range.

This is correct. The write to this bridge BAR with a address from
the host bridge window will cause a hardware issue.

> Apparently if you program the BAR *outside* the window, the hardware
> error does not happen, and the private registers are accessible.  But
> Linux currently doesn't know where this space is.
>
> If we ignore the BAR in Linux, apparently the hardware error does not
> happen.  But the BAR still contains some value, so this is really the
> same as having the BAR outside the window, presumably because it came
> out of reset that way, or maybe firmware programmed it.

Yes.

> It sounds to me like you should do the following:
>
> a) Have firmware program this BAR where you want it,
>
> b) Describe these private registers as internal PCI bridge registers,
>    using a DT "reg" property,

Two ponts here:
- We have to support ACPI as well
- There is no need to use the private registers in linux, so the
   whole thing will be pointless.

> c) Describe the host bridge window (which doesn't include the above
>    registers) using the normal "ranges" property, and

This is standard code (and ACPI works as well)..

> d) Arrange for config writes to BAR 0 to be dropped and for reads to
>    return 0, maybe by checks in your config accessors.

Here we are hiding the BAR from linux using checks in config read
write (if i understand correctly). This will need custom config accessors
for Vulcan both on device tree as well as in ACPI.

The patch (above) is trying to do it in a much much simpler way by
clearing the bar0 resource in DECLARE_PCI_FIXUP_HEADER quirk.
I am not able to see why this is not valid.

Thanks,
JC.
