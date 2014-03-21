Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64611 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaCUUfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 16:35:05 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so3051425iec.37
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2014 13:35:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
 <CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com> <CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Mar 2014 14:34:43 -0600
Message-ID: <CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
To: Cristina Olariu <colariu@elfiq.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 2:14 PM, Cristina Olariu <colariu@elfiq.com> wrote:
> Hello Bjorn,
>
> Thank you very much for your answer.
>
> You were right. I was trying to get sysfs info via pci_create_slot().
> The PCIe slots on our platform don't support hotplug; consequently
> /sys/bus/pci/slots remains empty.
>
> For us it is important to be able to list all the devices in a physical PCI
> slot even if it doesn't implement the hotplug functionnality.
>
> I will follow your advice and open a bugzilla.

Thanks.  Please respond to this thread with the bugzilla URL.

By the way, your email is something other than plain text, so I don't
think it made it to the linux-pci list.  See
http://vger.kernel.org/majordomo-info.html

> On Fri, Mar 21, 2014 at 2:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> [+cc linux-pci]
>>
>> On Fri, Mar 21, 2014 at 11:56 AM, Cristina Olariu <colariu@elfiq.com>
>> wrote:
>> > Hello Bjorn,
>> >
>> > I was trying to use the pci_slot module in order to associate a network
>> > interface  to  its corresponding network port by matching devices with
>> > physical slot information.
>> >
>> > Unfortunately the PCIe slots on our platform don't support the hot-plug
>> > function and the pci_slot module doesn't expose the slots interface in
>> > sysfs.
>> >
>> > Is there another way to list devices by physical add-in slots?  We are
>> > using
>> > kernel version 3.4.67.
>> > Any pointers you may be able to offer would be appreciated.
>>
>> I haven't paid much attention recently to the way we expose slot
>> numbers.  I assume you're looking for the sysfs info that is exposed
>> via pci_create_slot().
>>
>> The pci_slot module only puts slot info in sysfs (via
>> pci_create_slot()) when the ACPI namespace contains certain
>> information (_ADR, _SUN, etc.)  If you don't support hotplug, you
>> probably wouldn't have this info in the namespace.
>>
>> It looks like the only other user of pci_create_slot() is
>> pci_hp_register(), which is called by various hotplug drivers.  But
>> none of these help you either if you don't support hotplug.
>>
>> "lspci -vv" should show you the "Physical Slot Number" from the Slot
>> Capabilities register in the PCIe capability.  Is that the number
>> you're looking for?  That seems like something we might want to expose
>> via sysfs, but based on the places that use PCI_EXP_SLTCAP_PSN, I
>> don't see anything that would do so.  (Sigh, I see that pciehp defines
>> PSN, which doesn't use PCI_EXP_SLTCAP_PSN but is extracting the same
>> field.  I'll fix this.)
>>
>> In any event, I'm guessing pciehp doesn't do anything (including
>> creating the sysfs slot info) on your system because you don't support
>> hotplug.  But it seems reasonable that the slot number could be useful
>> even without hotplug, so maybe this functionality should be moved out
>> of pciehp somehow.
>>
>> Could you open a bugzilla at http://bugzilla.kernel.org and attach a
>> complete dmesg log (with pciehp and pci_slot enabled) and complete
>> "lspci -vv" info?  Maybe we can figure out a nice way to do this.
>>
>> Bjorn
>
>
>
>
> --
> CRISTINA OLARIU • Elfiq Networks • Software Developer
> T. 514.667.0611 x 821 •  E.  colariu@elfiq.com
