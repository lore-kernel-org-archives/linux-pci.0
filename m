Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27447 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab3DOS0Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Apr 2013 14:26:24 -0400
Date: Mon, 15 Apr 2013 11:26:14 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: "Bulkow, David" <David.Bulkow@stratus.com>
Cc: "Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB PCI quirk issue
Message-ID: <20130415182614.GB9224@xanatos>
References: <5AA430FFE4486C448003201AC83BC85E01F83F0D@EXHQ.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5AA430FFE4486C448003201AC83BC85E01F83F0D@EXHQ.corp.stratus.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cc-ing the public Linux PCI and USB mailing lists.

On Fri, Apr 12, 2013 at 02:59:29PM -0400, Bulkow, David wrote:
> Susan,

I'm Sarah. :)

> While testing Linux 3.9 we ran into an issue which I believe is a
> conflict between a couple of PCI changes.  Stratus has hardware that
> can hot add/remove chunks of its PCI hierarchy which has tickled some
> of the newer code.  I am mailing you because I believe the second
> change I list below holds the key.
> 
> I believe we are experiencing a collision between two changes.  The
> first:
> 
> PCI: Put pci_dev in device tree as early as possible
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4f535093cf8f6da8cfda7c36c2c1ecd2e9586ee4
> 
> is causing device_add to be called during pci_scan_slot.  The second:
> 
> USB: Fix handoff when BIOS disables host PCI device
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=cab928ee1f221c9cc48d6615070fefe2e444384a
> 
> is getting activated by device_add.

So this system includes a Panther Point or Lynx Point xHCI host?

I'm running 3.9-rc6 with a Panther Point xHCI host, and it works fine,
so this is probably related to hot-plug, or perhaps a hardware-specific
issue.

> We are seeing complaints during pci_scan_slot like "BIOS handoff
> failed", "device not available... can't reserve IO" or mem for all USB
> devices.  Furthermore we are seeing the enable_cnt <= 0 warning,
> "disabling already-disabled device" in pci_disable_device during
> subsequent bringdown (or hot remove) operations.  We are using the
> protocol pci_scan_slot -> <assign IO/mem resources> ->
> pci_add_bus_resources to hot-add devices after they have been
> initialized.  I believe the first set of messages are because we have
> not yet assigned resources, but to do so the pci devices must be
> established - in pci_scan_slot.  The disable message is happening
> because the first failures during pci_scan_slot are over-decrementing
> enable_cnt in pci_enable_device_flags when do_pci_enable_device fails.

What are your BIOS settings for xHCI?  Some BIOSes have an option to
disable the xHCI host.  In that case, the BIOS won't respond to the xHCI
BIOS/OS handoff, and the xHCI PCI register that tells Linux which ports
are available to switch over from EHCI to xHCI will be all zeroes
(meaning we can't switch any ports over).

Originally, there was some talk of having the BIOS hide the PCI device
from the OS if the xHCI host was disabled in the BIOS.  I wonder if some
non-Intel BIOS vendor did that.

> What caught my eye in the second change, in usb quirk code, is that it
> does not differentiate between boot mode or hot-add operation. It is
> certainly possible we are doing PCI add incorrectly - things are
> moving quickly right now.

I don't understand why it should matter whether that code is run
directly after boot or on hot-add.  All that code does is read and write
the PCI MMIO registers, which should be available when the quirk is
called.

> Would you mind taking a look and correcting my understanding?

As for the other warnings, I think the PCI maintainer (Bjorn) is going
to have to address those, as I'm not a PCI expert.

Sarah Sharp
