Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932308AbcHXU0Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Aug 2016 16:26:16 -0400
Date: Wed, 24 Aug 2016 15:15:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard van der Hoff <linux@rvanderhoff.org.uk>
Cc: linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Hotplug not working for USB 3.1 docking station on Dell XPS 13
Message-ID: <20160824201511.GF23914@localhost>
References: <57BDCE15.4080201@rvanderhoff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57BDCE15.4080201@rvanderhoff.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Andreas, linux-kernel]

On Wed, Aug 24, 2016 at 05:40:53PM +0100, Richard van der Hoff wrote:
> I'm having problems with a Plugable USB-C docking station, with my
> laptop, a Dell XPS 13 (9350). If the docking station is plugged in
> at boot, it works correctly; however, when I hotplug it after boot,
> the USB devices are not detected until I force a rescan of the PCI
> bus.
> 
> I have also raised this as a bug at
> https://bugzilla.kernel.org/show_bug.cgi?id=151261. There are some
> dmesg traces and lspci logs attached to that bug.
> 
> The lspci output suggests a chain of three PCI bridges (00:1c.0,
> 01:00.0, 02:02.0) before a PCI->USB bridge (05:00.0 or 39:00.0). If
> I boot without the docking station plugged in, 01:00.0 and beyond do
> not appear, and nor do they appear on hotplug. However, if I hotplug
> the docking station and then force a rescan with "echo 1 >
> /sys/bus/pci/devices/0000:00:1c.0/rescan", the PCI bridges and USB
> devices appear and spring into life.
> 
> My impression, and feedback from the linux-usb mailing list, is
> therefore that this is a PCI hotplug problem.

Please include a pointer to the linux-usb analysis.

> There are some ACPI errors in the dmesg at hotplug but they don't
> really mean much to me.

>From https://bugzilla.kernel.org/attachment.cgi?id=227331 (dock
present at boot):

  00:1c.0 PCI bridge: Intel Device 9d10 (PCIe Root Port)
    Bus: primary=00, secondary=01, subordinate=39
  01:00.0 PCI bridge: Intel Device 1576 (Alpine Ridge Thunderbolt)
    Bus: primary=01, secondary=02, subordinate=05
  02:02.0 PCI bridge: Intel Device 1576 (Alpine Ridge Thunderbolt)
    Bus: primary=02, secondary=05, subordinate=05
  05:00.0 USB controller: Intel Device 15b5 (Alpine Ridge USB 3.1)

01:00.0 and 02:02.0 are ports of a Thunderbolt switch.  Since they
don't appear when you boot without the docking station, the dock
connection must be between 00:1c.0 and 01:00.0.

>From the kernel's point of view, plugging in the dock would be a PCIe
hotplug event on 00:1c.0 that should be handled by pciehp.  Do you
have pciehp included in your kernel?  

Bjorn
