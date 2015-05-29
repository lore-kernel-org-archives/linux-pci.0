Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33997 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbbE2Vts (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 17:49:48 -0400
Received: by qgdy38 with SMTP id y38so9500688qgd.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2015 14:49:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e4a52d80e1b4864a36708b816aab19e@XCGVAG27.northgrum.com>
References: <4e4a52d80e1b4864a36708b816aab19e@XCGVAG27.northgrum.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 29 May 2015 16:49:27 -0500
Message-ID: <CAErSpo7hnXQWt6Jhyaq4cjTwzB-VOMdnng7V2F+ot0-y=UPm9g@mail.gmail.com>
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 29, 2015 at 4:14 PM, Tang, Jason (ES) <Jason.Tang2@ngc.com> wrote:
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> On Thu, May 28, 2015 at 11:24:45PM +0000, Tang, Jason (ES) wrote:
>> > Correct, in cases where some faulty hardware requests less memory than it
>> > really needs.
>>
>> Hmm.  This sounds potentially problematic.  Does the device have a BAR that
>> reports a size smaller than what the device actually responds to, e.g., the
>> BAR says it's 1MB, but the device actually responds to 2MB of space?
>
> Yes, on a custom PCI endpoint, it had a BAR smaller than actually used.

I recommend trying to add a quirk for this device, assuming you can
identify it via vendor/device ID or something.  That would be safer
than just assuming the broken device is only at a certain
bus/device/function address.

>> > The two places where I see 'is_hotplug_bridge' set are in
>> > quirk_hotplug_bridge() and in set_pcie_hotplug_bridge(). Both of these
>> > check that the bridge is a particular type (a PLX 6254, or if the device
>> > has the PCI_>QP_SLTCAP_HPC capability). What I propose is a more
>> general
>> > purpose that works for any PCI bridge.
>>
>> Right.  Do we set that bit for your bridge?  Those two places certainly
>> don't cover all the cases: the quirk only applies to one specific device,
>> and the other only works for bridges with native PCIe hotplug.
>>
>> If you have a different kind of bridge, is_hotplug_bridge won't be set, but
>> it probably should be.  What sort of bridge do you have?
>
> This bridge is a COTS bridge, with no special hotplugging capabilities. I
> have a need to hot-add things underneath that bridge. Yes, this will
> probably void various warranties, but in testing I have found it is
> electrically safe to do so.

Does that mean you have no hotplug events, e.g., interrupts for
presence detect, attention button, etc.?  So when you want to hot-add
a device, you have to manually "echo 1 > /sys/.../rescan" or similar?

>> This sounds like two Linux bugs: 1) we don't set is_hotplug_bridge for some
>> bridges that support hotplug, and 2) we don't reserve any bus numbers for
>> bridges that support hotplug.  If we can fix those in a generic way, it
>> will be more useful than adding a lot of code to allow users to manually
>> work around the bugs.
>
> How about: 1) Let hotplugged bridges reserve bus numbers, and then 2) let
> users declare certain bridges as hotplugable, in addition to existing
> checks?

1) sounds great; I think that would definitely improve things for
everybody.  2) sounds at least possible, too.  I don't really like
things that apply to certain devices, because there's not really a
guarantee that you can identify a device by its bus/device/function
number.  The BIOS can reassign bus numbers depending on what other
devices are in the machine.  And the OS can do the same, of course.
Linux doesn't do very much of that sort of reassignment now, but I
don't want to preclude it in the future.  But we should at least
explore it.

Bjorn
