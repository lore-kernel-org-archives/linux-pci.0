Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33273 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaCZTfc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 15:35:32 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so861271igc.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2014 12:35:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMm_7Epo7D53_Cui7zN1Zv0F4HAOSdUv6M9pLJxjrFAWbB7aNw@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
 <CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com>
 <CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
 <CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
 <CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
 <CAErSpo5-rWeWeayeTpzgg+N_UYWfyT5-qdYReQm0WDy0WwHFkg@mail.gmail.com>
 <CAMm_7EoCGgQ7aZfESY_-+WFdsZqpBrjEee94e6GyT50CLaVbdQ@mail.gmail.com>
 <CAErSpo5ncPGV9_ijfzCJJP28AX=4erb_iN2sei_DJC7eCsevMg@mail.gmail.com> <CAMm_7Epo7D53_Cui7zN1Zv0F4HAOSdUv6M9pLJxjrFAWbB7aNw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 26 Mar 2014 13:35:11 -0600
Message-ID: <CAErSpo7Xz5pBSALhA1gy5kMxYC39VKvGKBdb23Zr8CKPVAcZRA@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
To: Cristina Olariu <colariu@elfiq.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 26, 2014 at 12:23 PM, Cristina Olariu <colariu@elfiq.com> wrote:
> On Mon, Mar 24, 2014 at 7:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Matt, Jordan]
>
>> I was really trying to ask "what is the specific information you have
>> about your network port that you want to match up with something from
>> PCI?"
>
> Sorry; what I had in mind was the PCI address: domain/bus/device/function.
> ...

> I get a list of all PCI network devices and for each one I look up its
> interface name in sysfs.
> From SMBIOS I get the list of physical slots along with their
> corresponding  bus addresses.
> Then, I match the lists and identify the physical slot for every network device.

Can you attach the dmidecode output to the bugzilla as well?  I don't
work with all these pieces enough to be clear in my mind without
having a concrete example to work through.

I don't have an SMBIOS spec, so I don't know how the physical slot/bus
address mapping works.  I assume all it can tell you is the bus number
associated with the slot (and even that assumes that the OS doesn't
reconfigure any bus numbers).

> I was trying to simplify the design and thought that it would be
> easier if the physical slot number would be already available in sysfs
> hierarchy.
>
>> ...  Maybe the slot number, e.g., the PCIe or SHPC "Physical Slot
>> Number" could be exposed in the device directory of the upstream
>> bridge, e.g., /sys/devices/pci0000:00/0000:00:1c.3/slot.
>
> Yes, this could be helpful. I was looking for a PCI address inside
> /sys/bus/pci/slots/X but this is better.

There is a /sys/bus/pci/slots/X/address (where X is some function of
the physical slot number of the bridge leading to the slot), which
contains the PCI domain/bus/device of whatever is plugged into the
slot.  If we added a /sys/devices/pci0000:00/0000:00:1c.3/slot, that
would be associated with the upstream bridge, not with the device in
the slot, so you'd still have to search up the tree.

I'm not sure what we would put in a "slot" file; it could be just the
Physical Slot Number from the PCIe capability, or we could include the
Chassis Number from the optional Slot Number capability (I was quite
surprised to learn that Linux doesn't even look for the Chassis
Number).  But if it's not identical to the X from the
/sys/bus/pci/slots/X subtree, it seems like we're asking for a lot of
confusion.

To fix the problem of "we only have sysfs slot information for hotplug
slots," the simplest thing (in terms of a patch) would probably be to
move the pci_create_slot() call from __pci_hp_register() to a more
generic place where we could call it for every PCIe bridge that has a
slot below it.

Bjorn
