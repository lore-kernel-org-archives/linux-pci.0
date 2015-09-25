Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:62276 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933168AbbIYUaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2015 16:30:07 -0400
MIME-Version: 1.0
Message-ID: <trinity-873ca220-d869-40c4-88b0-a6ae9ec8548d-1443213001295@3capp-webde-bs54>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2015 22:30:01 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

> (I still think it's the BIOS's fault.)

You're spot on, and the keyboard doesn't have enough special characters
to express my feelings. (@$#!§*)

I created a bootable USB stick with the Xubuntu 15.04 installer.
When booting in legacy BIOS mode...

> lspci
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series SoC Transaction Register (rev 0e)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Graphics & Display (rev 0e)
00:12.0 SD Host controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series SDIO Controller (rev 0e)
00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series USB xHCI (rev 0e)
00:17.0 SD Host controller: Intel Corporation Device 0f50 (rev 0e)
00:1a.0 Encryption controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0e)
00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx Series High Definition Audio Controller (rev 0e)
00:1c.0 PCI bridge: Intel Corporation Device 0f48 (rev 0e)
00:1c.1 PCI bridge: Intel Corporation Device 0f4a (rev 0e)
00:1c.2 PCI bridge: Intel Corporation Device 0f4c (rev 0e)
00:1d.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series USB EHCI (rev 0e)
00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Power Control Unit (rev 0e)
00:1f.3 SMBus: Intel Corporation Device 0f12 (rev 0e)
02:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless Network Adapter (rev 01)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)

and the machine freezes.
When booting in UEFI mode (insecure)...

> lspci
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series SoC Transaction Register (rev 0e)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Graphics & Display (rev 0e)
00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series USB xHCI (rev 0e)
00:1a.0 Encryption controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0e)
00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx Series High Definition Audio Controller (rev 0e)
00:1c.0 PCI bridge: Intel Corporation Device 0f48 (rev 0e)
00:1c.1 PCI bridge: Intel Corporation Device 0f4a (rev 0e)
00:1c.2 PCI bridge: Intel Corporation Device 0f4c (rev 0e)
00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Power Control Unit (rev 0e)
00:1f.3 SMBus: Intel Corporation Device 0f12 (rev 0e)
02:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless Network Adapter (rev 01)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)

and the machine does not freeze. The device 00:1d.0 which caused my problem
has simply vanished, along with 00:12.0 and 00:17.0. Apparently, there's
some unused hardware in the machine and Acer decided to hide it from the OS
in UEFI mode, but didn't bother to do the same in legacy BIOS mode. Or maybe
BIOS doesn't support such behavior.

I'll try the upcoming re-installation in UEFI mode. And if it goes as I hope,
I won't be able to trigger the freeze anymore. It'd be kind of an unsatisfactory
ending to a months-long wild goose chase. But the simplest solution might
turn out to be telling people not to use legacy BIOS mode on this machine.

I'll wait with the installation until Sunday morning, just in case you or
somebody else would like me to gather some more information in BIOS mode.
And of course I'll report the outcome of the installation.

thanks for all your efforts,
  Roland
