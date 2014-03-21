Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48535 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaCUVrL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 17:47:11 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so3221835oag.34
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2014 14:47:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
	<CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com>
	<CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
	<CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
Date: Fri, 21 Mar 2014 17:47:10 -0400
Message-ID: <CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
From: Cristina Olariu <colariu@elfiq.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

I just submitted the bug and here is the URL:

https://bugzilla.kernel.org/show_bug.cgi?id=72681

Thank you,

Cristina

On Fri, Mar 21, 2014 at 4:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Mar 21, 2014 at 2:14 PM, Cristina Olariu <colariu@elfiq.com> wrote:
>> Hello Bjorn,
>>
>> Thank you very much for your answer.
>>
>> You were right. I was trying to get sysfs info via pci_create_slot().
>> The PCIe slots on our platform don't support hotplug; consequently
>> /sys/bus/pci/slots remains empty.
>>
>> For us it is important to be able to list all the devices in a physical PCI
>> slot even if it doesn't implement the hotplug functionnality.
>>
>> I will follow your advice and open a bugzilla.
>
> Thanks.  Please respond to this thread with the bugzilla URL.
>
> By the way, your email is something other than plain text, so I don't
> think it made it to the linux-pci list.  See
> http://vger.kernel.org/majordomo-info.html
>
>> On Fri, Mar 21, 2014 at 2:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> [+cc linux-pci]
>>>
>>> On Fri, Mar 21, 2014 at 11:56 AM, Cristina Olariu <colariu@elfiq.com>
>>> wrote:
>>> > Hello Bjorn,
>>> >
>>> > I was trying to use the pci_slot module in order to associate a network
>>> > interface  to  its corresponding network port by matching devices with
>>> > physical slot information.
>>> >
>>> > Unfortunately the PCIe slots on our platform don't support the hot-plug
>>> > function and the pci_slot module doesn't expose the slots interface in
>>> > sysfs.
>>> >
>>> > Is there another way to list devices by physical add-in slots?  We are
>>> > using
>>> > kernel version 3.4.67.
>>> > Any pointers you may be able to offer would be appreciated.
>>>
>>> I haven't paid much attention recently to the way we expose slot
>>> numbers.  I assume you're looking for the sysfs info that is exposed
>>> via pci_create_slot().
>>>
>>> The pci_slot module only puts slot info in sysfs (via
>>> pci_create_slot()) when the ACPI namespace contains certain
>>> information (_ADR, _SUN, etc.)  If you don't support hotplug, you
>>> probably wouldn't have this info in the namespace.
>>>
>>> It looks like the only other user of pci_create_slot() is
>>> pci_hp_register(), which is called by various hotplug drivers.  But
>>> none of these help you either if you don't support hotplug.
>>>
>>> "lspci -vv" should show you the "Physical Slot Number" from the Slot
>>> Capabilities register in the PCIe capability.  Is that the number
>>> you're looking for?  That seems like something we might want to expose
>>> via sysfs, but based on the places that use PCI_EXP_SLTCAP_PSN, I
>>> don't see anything that would do so.  (Sigh, I see that pciehp defines
>>> PSN, which doesn't use PCI_EXP_SLTCAP_PSN but is extracting the same
>>> field.  I'll fix this.)
>>>
>>> In any event, I'm guessing pciehp doesn't do anything (including
>>> creating the sysfs slot info) on your system because you don't support
>>> hotplug.  But it seems reasonable that the slot number could be useful
>>> even without hotplug, so maybe this functionality should be moved out
>>> of pciehp somehow.
>>>
>>> Could you open a bugzilla at http://bugzilla.kernel.org and attach a
>>> complete dmesg log (with pciehp and pci_slot enabled) and complete
>>> "lspci -vv" info?  Maybe we can figure out a nice way to do this.
>>>
>>> Bjorn
>>
>>
>>
>>
>> --
>> CRISTINA OLARIU * Elfiq Networks * Software Developer
>> T. 514.667.0611 x 821 *  E.  colariu@elfiq.com



-- 
CRISTINA OLARIU * Elfiq Networks * Software Developer
T. 514.667.0611 x 821 *  E.  colariu@elfiq.com
