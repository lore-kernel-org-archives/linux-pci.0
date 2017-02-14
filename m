Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbdBNW7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 17:59:30 -0500
Date: Tue, 14 Feb 2017 16:59:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 3/8] PCI: pciehp: Reinstate runtime PM on Thunderbolt
 hotplug ports
Message-ID: <20170214225926.GB19040@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1486913733.git.lukas@wunner.de>
 <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> Commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> hotplug ports") extended runtime PM for PCIe ports to hotplug ports.
> However Yinghai Lu reported the following breakage caused by the commit:
> 
> * After disabling a slot on one of his servers, the slot signals PME
>   which causes pciehp to immediately re-enable the card, thus defeating
>   manual slot control via sysfs.

I don't think we've clearly established this.  It surprises me that a
Downstream Port would signal PME after turning off power to the slot.
Wouldn't that make PME useless?

I'd like to look at this in a little more detail, either by turning
off PM and pciehp and poking things manually with setpci, or possibly
by adding some debug output in the PME ISR and the pciehp ISR and
"write command" paths.

> * On another server which has a Power Controller for PCIe hotplug ports
>   (PCIe r3.1, sec 6.7.1.8), the slot cannot be re-enabled after manually
>   disabling it via sysfs since commit 68db9bc81436 acquired a runtime
>   ref only *after* enabling power on the slot, yet this particular
>   SkyLake server requires that the port is in D0 when enabling power.

So this server requires that the Downstream Port must be in D0 before
we turn on power to the slot below the Downstream Port?  That seems
like it would be a requirement for *all* systems.  If the bridge is
not in D0, we can't generate any PCI transactions on the secondary bus
(PCI PM r1.1., Table 19), so we can't enumerate anything in the slot.

Bjorn
