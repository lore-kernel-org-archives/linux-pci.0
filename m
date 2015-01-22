Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:39175 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbAVWUX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jan 2015 17:20:23 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so2050849obc.4
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2015 14:20:23 -0800 (PST)
Date: Thu, 22 Jan 2015 16:20:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Hot add a PCIe device driver upon hotplug event
Message-ID: <20150122222016.GF13072@google.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
 <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
 <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
 <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg]

It's better if you put your responses inline, e.g.,
http://en.wikipedia.org/wiki/Posting_style#Interleaved_style .  That's the
convention on Linux lists because it makes it easier for new participants
to enter the discussion.

Also, some of your previous messages didn't make it to the mailing list,
probably because they exceeded 100K; see
http://vger.kernel.org/majordomo-info.html .

I extracted the dmesg information below from your "dmesg_output2.txt"
attachment from Jan 13.

On Thu, Jan 22, 2015 at 08:07:14PM +0000, Paulo Fortuna Carvalho wrote:
> Hi,
> Yes but i want that udev .rules file launches the script on "remove" ACTION.
> The event that triggers the removal procedure is an ATCA card handle
> switch. the corredponding hot-add event is caught by pciehp and sent to
> udev that runs a rule which calls my script on "remove" ACTION.

Let me summarize what I think you're trying to do.  Please correct me if I
don't understand correctly.

You're interested in device 0c:00.0: [1556:6014], which is here in the
topology:

  pci 0000:07:08.0: PCI bridge to [bus 0c]
  pci 0000:0c:00.0: [1556:6014] type 0 class 0x001100

You're looking for a way to run a script when a user expresses her intent
to remove a card, but before the card is actually removed.

Linux currently emits a KOBJ_REMOVE uevent when it tears down the internal
device data structure.  You can use udev to do things when that occurs, but
that's too late for what you want to do because the device is already
unusable.

07:08.0, the Downstream Port leading to 0c:00.0, contains a hotplug
controller with several indicators and sensors:

  pciehp 0000:07:08.0:pcie24:   Physical Slot Number : 8
  pciehp 0000:07:08.0:pcie24:   Attention Button     : yes
  pciehp 0000:07:08.0:pcie24:   Power Controller     : yes
  pciehp 0000:07:08.0:pcie24:   MRL Sensor           : yes
  pciehp 0000:07:08.0:pcie24:   Attention Indicator  : yes
  pciehp 0000:07:08.0:pcie24:   Power Indicator      : yes
  pciehp 0000:07:08.0:pcie24:   Hot-Plug Surprise    :  no
  pciehp 0000:07:08.0:pcie24:   EMI Present          :  no
  pciehp 0000:07:08.0:pcie24:   Command Completed    : yes

It might be possible for Linux to emit other uevents, for example, when the
Attention Button is pressed.  I don't know how such a uevent would fit into
the udev framework.

You're using an ATCA card handle to physically remove the device, and you
mention a card handle switch that triggers the removal.  Is the card handle
something like this:
http://www.cbttechnology.com/resources/pdf/Datasheets/Sep2014/ATCA-Handles.pdf?

Is the microswitch mentioned there wired up as the Attention Button?  If
not, do you know how the state of the ATCA card handle switch is
communicated to the OS?

In your dmesg log, I see this:

  pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
  pciehp 0000:07:08.0:pcie24: Presence/Notify input change
  pciehp 0000:07:08.0:pcie24: Card not present on Slot(8)
  pciehp 0000:07:08.0:pcie24: pcie_isr: intr_loc 8
  pciehp 0000:07:08.0:pcie24: Presence/Notify input change
  pciehp 0000:07:08.0:pcie24: Card present on Slot(8)

That means we only saw Presence Detect Changed interrupts: one for card
removal and another for card insertion.  We didn't see an Attention Button
interrupt at all.

You can look at the Slot Status directly with "lspci -vvs07:08.0".  If you
do that while removing the device, e.g., run it while the handle is in
position #1, again in position #2, and again in position #3, you should see
whether there's any signal that could potentially be used to do what you
need.

>  On Jan 22, 2015 5:41 PM, "Bjorn Helgaas" <bhelgaas@google.com> wrote:
> > On Thu, Jan 22, 2015 at 8:35 AM, Paulo Fortuna Carvalho
> > <pricardofc@gmail.com> wrote:
> > > Hello Bjorn,
> > > I can add and remove an ATCA card with a PCIExpress endpoint.
> > > UDEV device manager runs hotplug scripts ok and device files are created
> > and
> > > removed from system accdordingly.
> > > Im trying now to run a script that on remove kills running applications
> > > using a certain device before it is removed from system.
> > > To do so I implement in my .rules file an entry regarding "remove" that
> > > calls a script to perform that task.
> > > My problem is that before script runs the device node is no longer there
> > and
> > > my system crashes.
> > > Do you have any idea on how can run my script stopping the applciations
> > > before device remove procedure occurs?
> >
> > If I understand correctly, you want to run a script while your device
> > is still in the system, *before* it is removed.  I'm not familiar with
> > the ATCA hotplug slot details.  What event would trigger the script to
> > run?  Is there an attention button used to request card removal?  Is
> > there a sysfs or similar software interface to request removal?
> >
> > > 2015-01-12 16:58 GMT+00:00 Bjorn Helgaas <bhelgaas@google.com>:
> > >>
> > >> On Mon, Jan 12, 2015 at 5:42 AM, Paulo Fortuna Carvalho
> > >> <pricardofc@gmail.com> wrote:
> > >> > Hello,
> > >> > I want to automatically load/unload a PCIe device driver when a card
> > >> > is inserted/removed from the system. I can see in the system logger
> > >> > with dmesg that the interrupt event is captured and acknowledged by
> > >> > the pciehp hotplug service driver.
> > >> > What I want to do next is that the operating system load/unload the
> > >> > corresponding PCIe device driver for that card.
> > >>
> > >> When pciehp receives the interrupt, it should enumerate the device,
> > >> and you should see a line in dmesg similar to this (of course, it will
> > >> have different bus/device/function and different vendor/device IDs):
> > >>
> > >>   pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
> > >>
> > >> The PCI core should then add the device using device_add(), and part
> > >> of that is to emit a uevent, which can be read by user-space.
> > >> Generally udev would handle the event and load the appropriate driver.
> > >> I don't know the details of how the user-space side works.
> > >>
> > >> Bjorn
> > >
> > >
> >
