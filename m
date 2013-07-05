Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41764 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab3GEWhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jul 2013 18:37:07 -0400
Message-ID: <1373063807.4446.10.camel@pasglop>
Subject: Re: [PATCH 1/8] PCI: Add pcibios_stop_dev()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Sat, 06 Jul 2013 08:36:47 +1000
In-Reply-To: <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
	 <CAErSpo7QGD99HM1fEcvGi-9h3HX6C8nu1mzJHnMMUKWTNO0vnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-07-05 at 12:49 -0600, Bjorn Helgaas wrote:
> We already have pcibios_release_device() (just merged for v3.11).
> Would that work for you?  I haven't seen your whole series, so I can't
> tell whether you need something different.

Maybe... Gavin's original hook applies when the device is removed
from the tree, your new hook when the refcount expires and the
structure is about to be freed...

I *suspect* that's fine but I'll need to have a closer look (or wait
for Gavin to be back from vacation :-)

BTW. One thing we do in EEH is that if we get an error and the driver
for the device doesn't implement recovery, we simulate a hotplug.

IE. We unplug the device (currently removing it), reset it (or the
bus it's on, whatever applies, which lifts the fence established by
the EEH hardware), and re-plug it.

The current method really removes the device from the PCI subsystem,
and "plugs" it back. IE. We rescan the slot, and might even end up
re-assigning resources, which I'm not too fan about. It's also unclear
what quirks gets called in that re-plug case, etc...

I'm wondering whether it might be better to keep the pci_dev around,
just mark it blocked for user access, unbind the driver, reset, restore
the BARs to their original values, unblock and re-bind.

What's your take on this ?

Cheers,
Ben.


