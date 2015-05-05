Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36808 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbEESGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 14:06:20 -0400
Received: by qku63 with SMTP id 63so111473971qku.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2015 11:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2934645.mRJ7KPhQhB@tvenkinys>
References: <2934645.mRJ7KPhQhB@tvenkinys>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 5 May 2015 13:05:58 -0500
Message-ID: <CAErSpo6kLtdr3RONAS1Kuz2OY-FO1YM3Za3a381yrbQMMW530g@mail.gmail.com>
Subject: Re: bug: ExpressCard type USB3.0 adapter does not work on hotplug
To: "Donatas G." <dg@lapas.info>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Donatas,

Thanks a lot for the problem report.

On Tue, May 5, 2015 at 9:10 AM, Donatas G. <dg@lapas.info> wrote:
> [1.] One line summary of the problem:
> ExpressCard type USB3.0 adapter does not work on hotplug
>
> [2.] Full description of the problem/report:
> ExpressCard type USB3.0 adapter for laptop does not work on hotplug with the
> current mainline kernel 4.1.0-040100rc2-generic – devices attached to it do
> not get reported by the system as attached and cannot get mounted/function.
> The hotplug does work on an older kernel (giving 3x read spead from an
> external USB 3.0 drive), so it looks like a regression.

What's the newest kernel you know about where it works correctly?

Would you mind opening a report at http://bugzilla.kernel.org and
attaching a complete dmesg log and "lspci -vv" output?  If you have a
similar log for the working kernel, please attach that, too.

> No idea what else might be relevant. Here is dmesg output when manipulating
> (inserting and detaching) the expressCard adapter and devices to it:
>
> $ dmesg ## after plugging in the expressCard adapter:
> [  189.077601] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [  189.077618] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus
> number 3
> [  189.082972] xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100
> quirks 0x00000090
> [  189.083409] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
> [  189.083415] usb usb3: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [  189.083420] usb usb3: Product: xHCI Host Controller
> [  189.083425] usb usb3: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
> [  189.083429] usb usb3: SerialNumber: 0000:05:00.0
> [  189.083941] hub 3-0:1.0: USB hub found
> [  189.084014] hub 3-0:1.0: 2 ports detected
> [  189.084279] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [  189.084290] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus
> number 4
> [  189.086591] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
> [  189.086601] usb usb4: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [  189.086607] usb usb4: Product: xHCI Host Controller
> [  189.086614] usb usb4: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
> [  189.086620] usb usb4: SerialNumber: 0000:05:00.0
> [  189.087119] hub 4-0:1.0: USB hub found
> [  189.087200] hub 4-0:1.0: 2 ports detected
>
> ## upon unplugging adapter: no output!
>
> ## upon replugging adapter - no output!

Strange.  We should mention it when the xHCI controller goes away, and
also when it returns.  Maybe we're not detecting those events
correctly.

Bjorn
