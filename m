Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48104 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbbA0QbG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 11:31:06 -0500
Received: by mail-lb0-f181.google.com with SMTP id u10so14015496lbd.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 08:31:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
In-Reply-To: <CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
	<CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
	<CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
	<CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
	<CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
	<20150122222016.GF13072@google.com>
	<CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
	<CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com>
Date: Tue, 27 Jan 2015 16:31:04 +0000
Message-ID: <CAH9N0t9o63GLEYyLgW2CThhP8TW3Bc7_RxbP4bdwwcd120-gRw@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Is it possible to cancel somehow the remove procedure if the device is in use?
When we are using the device and remove occurs the kernel crashes.

Regards,
Paulo.



2015-01-23 14:36 GMT, Bjorn Helgaas <bhelgaas@google.com>:
> On Fri, Jan 23, 2015 at 5:35 AM, Paulo Fortuna Carvalho
> <pricardofc@gmail.com> wrote:
>> 2015-01-22 22:20 GMT, Bjorn Helgaas:
>
>>> In your dmesg log, I see this:
>>
>>>   pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
>>>   pciehp 0000:07:08.0:pcie24: Presence/Notify input change
>>>   pciehp 0000:07:08.0:pcie24: Card not present on Slot(8)
>>>   pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
>>>   pciehp 0000:07:08.0:pcie24: Presence/Notify input change
>>>   pciehp 0000:07:08.0:pcie24: Card present on Slot(8)
>>
>>> That means we only saw Presence Detect Changed interrupts: one for card
>>> removal and another for card insertion.  We didn't see an Attention
>>> Button
>>> interrupt at all.
>>
>> Yes, thats it. The Presence Detect Change signal is what triggers the
>> uevent. We dont have an attention button in our ATCA system so we dont
>> use it.
>
> If the only signal you have is Presence Detect, I think you're out of
> luck, because if Presence Detect State is "false" (see PCIe spec r3.0,
> sec 7.8.11), the card is already gone and it's too late to do anything
> with it.  If that's the case, you'd have to look for a software
> solution, e.g., run a script when you decide to remove the card,
> before you physically touch the card.
>
>>> You can look at the Slot Status directly with "lspci -vvs07:08.0".  If
>>> you
>>> do that while removing the device, e.g., run it while the handle is in
>>> position #1, again in position #2, and again in position #3, you should
>>> see
>>> whether there's any signal that could potentially be used to do what you
>>> need.
>>
>> Yes. I will try to see if the handle switch can trigger an uvent
>> before the remove device procedure from the system occurs. I will let
>> you know the result.
>
> Sec 6.7.3 lists the events pciehp has to work with:
>
> - Slot events:
>   - Attention Button
>   - Power Fault Detected
>   - MRL Sensor Changed
>   - Presence Detect Changed
> - Command Completed Events (this is internal to the hotplug controller)
> - Data Link Layer State Changed Events
>
> These are really the only inputs to the pciehp driver.  You apparently
> don't have an Attention Button.  You do have Presence Detect and
> possibly others, but I don't think they normally (other than an
> Attention Button) will give you any warning before the card is
> removed.
>
> The only possibility I see is the Power Fault handling (see sec
> 6.7.1.8).  Depending on the form factor, there is the possibility of
> independent main and auxiliary power faults.  An auxiliary power fault
> can be detected and reported without affecting main power.  And it
> says "For example, one form factor may remove auxiliary power when the
> MRL for the slot is opened."  If your form factor does that, we might
> get a Power Fault when the latch is opened, and the card would still
> have main power and software should still be able to operate it.
>
> I don't know how we would distinguish such an auxiliary power fault
> from a main power fault.  Maybe a form factor spec would talk about
> that.  Do you have any pointers to something like that?  If we could
> figure that out, it might be possible to emit a uevent for that case.
>
> Bjorn
>
