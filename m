Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34705 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbcDEVlB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 17:41:01 -0400
Received: by mail-oi0-f52.google.com with SMTP id s79so34505375oie.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Apr 2016 14:41:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160404221804.GL24264@redhat.com>
References: <CACmAtJvLMDbJG7FrnfcRoaLM843GNx5+9rehwn4-tD_QWTEn=Q@mail.gmail.com>
	<20160404195317.GA19031@localhost>
	<20160404221804.GL24264@redhat.com>
Date: Tue, 5 Apr 2016 23:40:59 +0200
Message-ID: <CACmAtJvOm34e0=qk0d7q6mE442i2Wkx0MqVEtzZn5wuGY6LhWg@mail.gmail.com>
Subject: Re: Dell XPS13 9350 thunderbolt 3
From: Martin Andersson <martin.andersson@purplescout.se>
To: Jarod Wilson <jarod@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, prarit@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have filed a bug at the kernel bugzilla
 https://bugzilla.kernel.org/show_bug.cgi?id=115931

dmesg, lspci -vv and lsusb -vv are attached.

I have also referenced the bug you mentioned, Bjorn.

Jarod, I haven't had time to try the patch you mentioned.

Looking through dmesg logs it appears, at least, the network
controller in the dock is recognized but the then the usb hub fails
and the devices are disconnected (from dmesg attached in the bug):

[   13.135684] xhci_hcd 0000:09:00.0: Stopped the command ring failed,
maybe the host is dead
[   13.135744] xhci_hcd 0000:09:00.0: Host not halted after 16000 microseconds.
[   13.135756] xhci_hcd 0000:09:00.0: Abort command ring failed
[   13.135777] xhci_hcd 0000:09:00.0: HC died; cleaning up
[   13.135834] xhci_hcd 0000:09:00.0: Error while assigning device slot ID
[   13.135841] xhci_hcd 0000:09:00.0: Timeout while waiting for
configure endpoint command
[   13.135854] xhci_hcd 0000:09:00.0: Max number of devices this xHCI
host supports is 255.
[   13.135866] usb 3-1-port5: couldn't allocate usb_device
[   13.135913] usb 3-1: USB disconnect, device number 2
[   13.137034] usb 4-1: USB disconnect, device number 2
[   13.137046] usb 4-1.2: USB disconnect, device number 3


On Tue, Apr 5, 2016 at 12:18 AM, Jarod Wilson <jarod@redhat.com> wrote:
> On Mon, Apr 04, 2016 at 02:53:17PM -0500, Bjorn Helgaas wrote:
>> On Mon, Apr 04, 2016 at 04:01:42PM +0200, Martin Andersson wrote:
>> > Hi all,
>> >
>> > I have a Dell XPS 13 9350 laptop with a Dell Thunderbolt 3 dock (TB15)
>> > that I'm trying to get to talk to each other. I hope this is the right
>> > forum.
>> >
>> > Lukas Wunner was kind enough to give me some pointers and after
>> > upgrading the thunderbolt firmware and disabling all the security
>> > settings for thunderbolt in the bios I'm able to see a usb hub
>> > (ASMedia Technology) from the dock with lspci. But that's it. Nothing
>> > happens when I attach any usb devices to the dock and I see no sign of
>> > the ethernet or audio devices in the dock.
>> >
>> > cut from lspci -vv:
>> >
>> > 09:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host
>> > Controller (prog-if 30 [XHCI])
>> >         Subsystem: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
>> >         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>> > ParErr- Stepping- SERR- FastB2B- DisINTx-
>> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >         Interrupt: pin A routed to IRQ 18
>> >         Region 0: Memory at c4100000 (64-bit, non-prefetchable) [size=32K]
>> >         Capabilities: <access denied>
>> >         Kernel driver in use: xhci_hcd
>> >
>> >
>> > Also I only see the usb hub when I boot with the dock attached. I have
>> > tried with pcie_hp=nomsi and echo "1" > /sys/bus/pci/rescan with no
>> > luck. But hotplug is, of course, not my main concern at this point ;)
>> >
>> > Should I open a bug at the kernel bugzilla and attach dmesg logs?
>>
>> Looks like https://bugzilla.kernel.org/show_bug.cgi?id=115121
>
> This looks possibly relevant:
>
> http://marc.info/?l=linux-acpi&m=145929159015853&w=2
>
> I believe it was sussed out on a Dell Precision 5510, with the Dell tb3
> dock. I actually have said dock and a 3510 here in hand, and have been
> meaning to give Prarit's patch a spin myself.
>
> --
> Jarod Wilson
> jarod@redhat.com
>



-- 
Hälsningar,
Martin Andersson
Purple Scout AB
+46 732 05 14 01
