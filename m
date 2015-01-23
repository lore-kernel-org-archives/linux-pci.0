Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:48545 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbAWLfi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 06:35:38 -0500
Received: by mail-la0-f44.google.com with SMTP id s18so874270lam.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 03:35:36 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
In-Reply-To: <20150122222016.GF13072@google.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
	<CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
	<CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
	<CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
	<CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
	<20150122222016.GF13072@google.com>
Date: Fri, 23 Jan 2015 11:35:36 +0000
Message-ID: <CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-01-22 22:20 GMT, Bjorn Helgaas:
> [+cc Greg]

> It's better if you put your responses inline, e.g.,
> http://en.wikipedia.org/wiki/Posting_style#Interleaved_style .  That's the
> convention on Linux lists because it makes it easier for new participants
> to enter the discussion.

Ok.

> Also, some of your previous messages didn't make it to the mailing list,
> probably because they exceeded 100K; see
> http://vger.kernel.org/majordomo-info.html .

Ok, although the response I get from the server is something about my
email containing html format characters...

> I extracted the dmesg information below from your "dmesg_output2.txt"
> attachment from Jan 13.

> On Thu, Jan 22, 2015 at 08:07:14PM +0000, Paulo Fortuna Carvalho wrote:
>> Hi,
>> Yes but i want that udev .rules file launches the script on "remove"
>> ACTION.
>> The event that triggers the removal procedure is an ATCA card handle
>> switch. the corredponding hot-add event is caught by pciehp and sent to
>> udev that runs a rule which calls my script on "remove" ACTION.

> Let me summarize what I think you're trying to do.  Please correct me if I
> don't understand correctly.

> You're interested in device 0c:00.0: [1556:6014], which is here in the
> topology:

>   pci 0000:07:08.0: PCI bridge to [bus 0c]
>   pci 0000:0c:00.0: [1556:6014] type 0 class 0x001100

Yes.

> You're looking for a way to run a script when a user expresses her intent
> to remove a card, but before the card is actually removed.

> Linux currently emits a KOBJ_REMOVE uevent when it tears down the internal
> device data structure.  You can use udev to do things when that occurs, but
> that's too late for what you want to do because the device is already
> unusable.

Yes.

> 07:08.0, the Downstream Port leading to 0c:00.0, contains a hotplug
> controller with several indicators and sensors:

>   pciehp 0000:07:08.0:pcie24:   Physical Slot Number : 8
>   pciehp 0000:07:08.0:pcie24:   Attention Button     : yes
>   pciehp 0000:07:08.0:pcie24:   Power Controller     : yes
>   pciehp 0000:07:08.0:pcie24:   MRL Sensor           : yes
>   pciehp 0000:07:08.0:pcie24:   Attention Indicator  : yes
>   pciehp 0000:07:08.0:pcie24:   Power Indicator      : yes
>   pciehp 0000:07:08.0:pcie24:   Hot-Plug Surprise    :  no
>   pciehp 0000:07:08.0:pcie24:   EMI Present          :  no
>   pciehp 0000:07:08.0:pcie24:   Command Completed    : yes

Yes, although now the configuration is a little different (we dont
have some of the system components like the Attention Button):

==============================================
pciehp 0000:07:08.0:pcie24:   Physical Slot Number : 8
pciehp 0000:07:08.0:pcie24:   Attention Button     : no
pciehp 0000:07:08.0:pcie24:   Power Controller     : no
pciehp 0000:07:08.0:pcie24:   MRL Sensor           : no
pciehp 0000:07:08.0:pcie24:   Attention Indicator  : no
pciehp 0000:07:08.0:pcie24:   Power Indicator      : no
pciehp 0000:07:08.0:pcie24:   Hot-Plug Surprise    :  yes
pciehp 0000:07:08.0:pcie24:   EMI Present          :  no
pciehp 0000:07:08.0:pcie24:   Command Completed    : yes
==============================================

> It might be possible for Linux to emit other uevents, for example, when the
> Attention Button is pressed.  I don't know how such a uevent would fit into
> the udev framework.

Yes, although we don't have the Attention Button physically installed
but maybe we can use another way to trigger the interrupt.

> You're using an ATCA card handle to physically remove the device, and you
> mention a card handle switch that triggers the removal.  Is the card handle
> something like this:
> http://www.cbttechnology.com/resources/pdf/Datasheets/Sep2014/ATCA-Handles.pdf?

Yes, its a handle similar to the one in the .pdf file you sent.

> Is the microswitch mentioned there wired up as the Attention Button?  If
> not, do you know how the state of the ATCA card handle switch is
> communicated to the OS?

> In your dmesg log, I see this:

>   pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
>   pciehp 0000:07:08.0:pcie24: Presence/Notify input change
>   pciehp 0000:07:08.0:pcie24: Card not present on Slot(8)
>   pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
>   pciehp 0000:07:08.0:pcie24: Presence/Notify input change
>   pciehp 0000:07:08.0:pcie24: Card present on Slot(8)

> That means we only saw Presence Detect Changed interrupts: one for card
> removal and another for card insertion.  We didn't see an Attention Button
> interrupt at all.

Yes, thats it. The Presence Detect Change signal is what triggers the
uevent. We dont have an attention button in our ATCA system so we dont
use it.

> You can look at the Slot Status directly with "lspci -vvs07:08.0".  If you
> do that while removing the device, e.g., run it while the handle is in
> position #1, again in position #2, and again in position #3, you should see
> whether there's any signal that could potentially be used to do what you
> need.

Yes. I will try to see if the handle switch can trigger an uvent
before the remove device procedure from the system occurs. I will let
you know the result.
