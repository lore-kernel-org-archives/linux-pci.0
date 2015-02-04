Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from icebox.esperi.org.uk ([81.187.191.129]:54829 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbBDAR5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 19:17:57 -0500
From: Nix <nix@esperi.org.uk>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Expand quirk's handling of CS553x devices
References: <20150203230124.1578.94572.stgit@amt.stowe>
Date: Wed, 04 Feb 2015 00:17:49 +0000
In-Reply-To: <20150203230124.1578.94572.stgit@amt.stowe> (Myron Stowe's
	message of "Tue, 03 Feb 2015 16:01:24 -0700")
Message-ID: <871tm6jzrm.fsf@spindle.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3 Feb 2015, Myron Stowe told this:

> There seem to be a number of issues with CS553x devices and due to a
> recent patch series that detects PCI read-only BARs [1], we've encountered
> more.
>
> It appears that not only are the BAR values associated with this device
> often greater than the largest range that an IO decoder can request, they
> can also be non-conformant with respect to PCI's BAR sizing aspects,
> behaving instead, in a read-only manner [2].
>
> This patch addresses read-only BAR values corresponding to CS553x devices
> by expanding the existing quirk, manually inserting regions based on the
> device's BIOS settings (as opposed to basing such on normal BAR sizing
> actions) when necessary.

Looks good!

[    0.270107] PCI: Probing PCI hardware
[    0.280187] PCI host bridge to bus 0000:00
[    0.290028] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.300021] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.310018] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.325514] pci 0000:00:14.0: [Firmware Bug]: CS5536 ISA bridge quirk: reg 0x10: [io  0x6000-0x6007]
[    0.330042] pci 0000:00:14.0: [Firmware Bug]: CS5536 ISA bridge quirk: reg 0x14: [io  0x6100-0x61ff]
[    0.340039] pci 0000:00:14.0: [Firmware Bug]: CS5536 ISA bridge quirk: reg 0x18: [io  0x6200-0x63ff]
[    0.350017] pci 0000:00:14.0: CS5536 ISA bridge bug detected (incorrect header); workaround applied
[    0.361456] pci 0000:00:14.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.370019] pci 0000:00:14.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.380019] pci 0000:00:14.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.390017] pci 0000:00:14.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.405842] pci 0000:00:0e.0: PCI bridge to [bus 01]
[    0.412043] Switched to clocksource pit
[...]
[    0.780013] cs5535-gpio cs5535-gpio: reserved resource region [io  0x6100-0x61ff]
[    0.785102] cs5535-mfgpt cs5535-mfgpt: reserved resource region [io  0x6200-0x63ff]
[    0.801002] cs5535-mfgpt cs5535-mfgpt: 8 MFGPT timers available
[    0.806684] cs5535-mfd 0000:00:14.0: 5 devices registered.
[...]
[    1.451754] cs5535-smb cs5535-smb: SCx200 device 'CS5535 ACB0' registered
[    1.452515] pc87360: Device 0x09 not activated
[    1.470755] cs5535-mfgpt cs5535-mfgpt: registered timer 0
[    1.473869] Geode LX AES 0000:00:01.2: GEODE AES engine enabled.
[    1.489999] cs5535-mfgpt cs5535-mfgpt: registered timer 1
[    1.492402] cs5535-clockevt: Registering MFGPT timer as a clock event, using IRQ 7
[...]
[    1.621402] Switched to clocksource tsc

nix@fold 3 /home/nix% grep cs5535 /proc/timer_list
Clock Event Device: cs5535-clockevt
nix@fold 4 /home/nix% ls -l /dev/watchdog
crw------- 1 root root 10, 130 Feb  4 00:14 /dev/watchdog

Thank you for such a prompt fix on hardware as obscure as this :)

-- 
NULL && (void)
