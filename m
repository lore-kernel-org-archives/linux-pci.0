Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:64902 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaKDRev (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 12:34:51 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so11411916qcy.28
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2014 09:34:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BF3270C86E8B1349A26C34E4EC1C44CB3E862DC6@CMEXMB1.ad.emulex.com>
References: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
 <20141023154054.GA7137@google.com> <BF3270C86E8B1349A26C34E4EC1C44CB3E860095@CMEXMB1.ad.emulex.com>
 <CAErSpo7_9xxtBmHOCgxsHeVLbKUeMVhLF6Q9OyFkz11EZbtJCA@mail.gmail.com> <BF3270C86E8B1349A26C34E4EC1C44CB3E862DC6@CMEXMB1.ad.emulex.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Nov 2014 10:34:30 -0700
Message-ID: <CAErSpo7KKka6-nHWnVbqVW3hx-E=4x6cEjeEGEAWz32za6xCGQ@mail.gmail.com>
Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual
 length supported.
To: Venkat Duvvuru <VenkatKumar.Duvvuru@emulex.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 3, 2014 at 5:18 AM, Venkat Duvvuru
<VenkatKumar.Duvvuru@emulex.com> wrote:
>
>
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Thursday, October 30, 2014 9:03 PM
>> To: Venkat Duvvuru
>> Cc: linux-pci@vger.kernel.org
>> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual
>> length supported.
>>
>> On Thu, Oct 30, 2014 at 7:38 AM, Venkat Duvvuru
>> <VenkatKumar.Duvvuru@emulex.com> wrote:
>> > Hi Bjorn,
>> > Please find my comments inline.
>> >
>> >> -----Original Message-----
>> >> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> >> Sent: Thursday, October 23, 2014 9:11 PM
>> >> To: Venkat Duvvuru
>> >> Cc: linux-pci@vger.kernel.org
>> >> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the
>> actual
>> >> length supported.
>> >>
>> >> On Thu, Oct 16, 2014 at 02:16:42PM +0530, Venkat Duvvuru wrote:
>> >> > By default pci utilities/subsystem tries to read 32k bytes of vpd data no
>> >> matter
>> >> > what the device supports. This can lead to unexpected behavior depending
>> >> > on how each of the devices handle this condition. This patch fixes the
>> >> > problem for Emulex adapter family.
>> >> >
>> >> > v1:
>> >> > Addressed Bjorn's comments
>> >> > 1. Removed Vendor id and Device id macros from pci_ids.h and
>> >> >    using the Vendor and Device id values directly in
>> >> DECLARE_PCI_FIXUP_FINAL() lines.
>> >> >
>> >> > Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
>> >>
>> >> Hi Venkat,
>> >>
>> >> I'll merge this (in some form), but I'd like the changelog to include more
>> >> details about what unexpected behavior occurs when reading too much
>> data.
>> >> This is to help people who trip over this problem find this patch as the
>> >> solution.
>> > [Venkat] "Timeout" happens on excessive VPD reads and  Kernel keeps
>> logging the following message
>> > "vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card
>> vendor for a firmware update"
>> >>
>> >> In my opinion, this is a hardware defect, and I'd like to know what your
>> >> hardware folks think, because I don't want to have to merge similar quirks
>> >> for future devices.  Here's my reasoning:
>> >>
>> >> If a device doesn't implement the entire 32K of possible VPD space, I would
>> >> expect the device to just return zeros or 0xff, or maybe alias the space by
>> >> dropping the high-order unused address bits.
>> > [Venkat] We do return 0xffs beyond the supported size but excessive VPD
>> reads are causing timeouts when the adapter is handling some high priority
>> work.
>>
>> That makes it sounds like this is really an issue with how the adapter
>> firmware manages the workload, not something strictly related to the
>> size of implemented VPD space. In other words, it sounds like it's
>> possible for the timeout to occur even when reading the space that
>> *is* implemented.
> In this case when the host reads 32k space, the adapter gets around 8K interrupts and sometimes gets overwhelmed with the interrupt storm. This could cause the adapter to stop functioning properly.
> Limiting the VPD read to 1K causes only 256 interrupts (on the adapter) and the problem never seems to occur.
> This has been the main motivation behind my patch.
> I do agree that the timeout could still occur even when reading the 1K implemented space, but I feel it's highly improbable.

OK.  I would guess that something like

  while /bin/true; do
    cat /sys/devices/pci0000:00/0000:00:00.0/vpd
  done

could still overwhelm the adapter, even with the 1K limit in place.

> As an alternative solution, would you be open to a fix in PCI -core to stop reading after the End-tag is detected?  (This logic is used by pci-utility (ls-vpd.c) while reading VPD data.)
> I now feel that this is the *right* solution than my pci-quirks patch.

That's a possibility, and if we were implementing VPD support from
scratch, I'd probably do it that way.

My only concern with changing now is that it could break existing
users for devices where the VPD content doesn't have the structure
specified by the spec.  There aren't *too* many users of
pci_read_vpd() in the tree, so it might be feasible to just ask the
bnx2x, tg3, cxgb4, sky2, and efx folks whether they think it's safe.

I took a quick look at those drivers, and it actually looks like most
of them look for the tag structure, e.g., by using pci_vpd_find_tag()
or doing something similar.  So maybe it actually would be safe to do
this.  Maybe you could have a more thorough look at them and see if
you agree?

>> You say the kernel "keeps logging" the message.  From the code, it
>> looks like it should only log it once per attempt to read or write the
>> VPD.  Is that what you observe, or is there a problem where we don't
>> abort the read/write after the first timeout, and we emit many
>> messages?
> Yes the kernel logs only for one time per attempt but there are configurations where we have many VFs per PF and we see this message for every VF and PF.

Makes sense.  It's really just one message per device, but there can
be many devices.

Bjorn
