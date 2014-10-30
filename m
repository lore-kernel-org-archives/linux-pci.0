Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:59389 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934250AbaJ3PdO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 11:33:14 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so3853571qac.17
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2014 08:33:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BF3270C86E8B1349A26C34E4EC1C44CB3E860095@CMEXMB1.ad.emulex.com>
References: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
 <20141023154054.GA7137@google.com> <BF3270C86E8B1349A26C34E4EC1C44CB3E860095@CMEXMB1.ad.emulex.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 30 Oct 2014 09:32:51 -0600
Message-ID: <CAErSpo7_9xxtBmHOCgxsHeVLbKUeMVhLF6Q9OyFkz11EZbtJCA@mail.gmail.com>
Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual
 length supported.
To: Venkat Duvvuru <VenkatKumar.Duvvuru@emulex.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 7:38 AM, Venkat Duvvuru
<VenkatKumar.Duvvuru@emulex.com> wrote:
> Hi Bjorn,
> Please find my comments inline.
>
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Thursday, October 23, 2014 9:11 PM
>> To: Venkat Duvvuru
>> Cc: linux-pci@vger.kernel.org
>> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual
>> length supported.
>>
>> On Thu, Oct 16, 2014 at 02:16:42PM +0530, Venkat Duvvuru wrote:
>> > By default pci utilities/subsystem tries to read 32k bytes of vpd data no
>> matter
>> > what the device supports. This can lead to unexpected behavior depending
>> > on how each of the devices handle this condition. This patch fixes the
>> > problem for Emulex adapter family.
>> >
>> > v1:
>> > Addressed Bjorn's comments
>> > 1. Removed Vendor id and Device id macros from pci_ids.h and
>> >    using the Vendor and Device id values directly in
>> DECLARE_PCI_FIXUP_FINAL() lines.
>> >
>> > Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
>>
>> Hi Venkat,
>>
>> I'll merge this (in some form), but I'd like the changelog to include more
>> details about what unexpected behavior occurs when reading too much data.
>> This is to help people who trip over this problem find this patch as the
>> solution.
> [Venkat] "Timeout" happens on excessive VPD reads and  Kernel keeps logging the following message
> "vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update"
>>
>> In my opinion, this is a hardware defect, and I'd like to know what your
>> hardware folks think, because I don't want to have to merge similar quirks
>> for future devices.  Here's my reasoning:
>>
>> If a device doesn't implement the entire 32K of possible VPD space, I would
>> expect the device to just return zeros or 0xff, or maybe alias the space by
>> dropping the high-order unused address bits.
> [Venkat] We do return 0xffs beyond the supported size but excessive VPD reads are causing timeouts when the adapter is handling some high priority work.

That makes it sounds like this is really an issue with how the adapter
firmware manages the workload, not something strictly related to the
size of implemented VPD space.  In other words, it sounds like it's
possible for the timeout to occur even when reading the space that
*is* implemented.

You say the kernel "keeps logging" the message.  From the code, it
looks like it should only log it once per attempt to read or write the
VPD.  Is that what you observe, or is there a problem where we don't
abort the read/write after the first timeout, and we emit many
messages?

The message is already KERN_DEBUG, so it's pretty minimal.  If the
message is the only problem, maybe we could make it a one-time thing,
so it would only be emitted once per device.

But it looks like if we time out, pci_read_vpd() will return an error
instead of returning the data it has read so far.  So I suspect *that*
is the real problem.  If so, maybe we should look into returning a
short read with the data.

VPD is defined by the spec and supported by the generic PCI core.  So,
as you can tell, I have a problem with something that requires
device-specific knowledge in that generic code because that's not a
scalable model.

Bjorn
