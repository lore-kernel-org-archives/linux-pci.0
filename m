Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41597 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751523AbdABV2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2017 16:28:11 -0500
Date: Mon, 2 Jan 2017 16:28:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Chris Murphy <lists@colorremedies.com>
cc: linux-usb@vger.kernel.org, <linux-pci@vger.kernel.org>
Subject: Re: Thunderbolt adapter fails to instantiate USB and device enumeration
 if already connected at boot time
In-Reply-To: <CAJCQCtS5gQObZr1j0stEnx9+U890_N-2FBFx_fZCZtmD8-2qJQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2 Jan 2017, Chris Murphy wrote:

> crossposting linux-usb@ and linux-pci@
> 
> I filed a bug https://bugzilla.kernel.org/show_bug.cgi?id=191681 but
> was told I need to post to the list first. I'm not actually sure this
> is a USB bug, as filed in the bug report, because I think this
> USB-C/Thunderbolt port is really a PCIe port that needs to become a
> USB port only once the adapter is connected.
> 
> Anyway, the gist of the problem is that if the USB-C to USB 3 adapter
> is connected at boot time, the kernel doesn't instantiate a USB port
> at all. So if for example I have a USB flash drive connected to the
> adapter with a Linux live OS on it, the firmware sees the stick, finds
> the bootloader, the bootloader finds and loads the kernel and
> initramfs - so clearly up to this point it's working properly. But
> then I end up at a dracut shell because there's not root fs to be
> found. And there's no rootfs because there's no USB bus at all as far
> as the kernel is concerned.
> 
> If the adapter is not connected at boot time, is connected later on,
> it all works as I'd expect it to work. I can plug it in, unplug it,
> plug it back in, and it always works fine. So weirdly it's just a "if
> connected at boot time" something is becoming deeply confused.
> 
> I've tested 4.10-rc1 from kernel.org; but it's been a problem since
> kernel 4.7.7 at least. The bug report has lspci, dmidecode, and two
> dmesg outputs from boots with the adapter connected at boot time, and
> not at boot time (but connected later). That bug report is 4.10-rc1
> based with CONFIG_PCIEASPM_DEBUG=y
> CONFIG_PCI_DEBUG=y but I'm not really seeing much additional
> information that helps figure out what the source of the problem is.

Considering that the failed boot log contains no USB messages at all, 
and no messages referring to PCI bus 0000:37 (the bus associated with 
the adapter), this certainly looks like a PCI problem.

Alan Stern

