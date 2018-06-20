Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752884AbeFTN2y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 09:28:54 -0400
Date: Wed, 20 Jun 2018 08:28:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: pci: pci_printk use
Message-ID: <20180620132852.GA108993@bhelgaas-glaptop.roam.corp.google.com>
References: <9bd45007ddfe2c32b6ee5097e427aabdc267ce53.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9bd45007ddfe2c32b6ee5097e427aabdc267ce53.camel@perches.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 09:33:18PM -0700, Joe Perches wrote:
> All the pci_printk uses are at KERN_DEBUG which is always
> emitted into the kernel logging whenever the console log
> level is high enough.
> 
> Are any of these appropriate for conversion to pci_dbg
> to allow these only to be emitted via dynamic_debug or
> if necessary via a #define DEBUG during compilation?

I think pci_printk(KERN_DEBUG) is a little ugly to read.  My
preference would be to remove them (and pci_dbg() uses) completely or
convert them to pci_info().  Most of these are boot-time or low
frequency messages, so I doubt the loglevel differentiation of
DEBUG/INFO is really necessary.

Using pci_dbg() means the messages depend on the kernel config
and the dynamic debug config, which is a bit of a hassle.

When I get bug reports, I'd much rather simply ask for a dmesg log
than ask people to reproduce it with a different config or figure out
the right dynamic debug option.

> $ git grep -w -n pci_printk drivers
> drivers/pci/bus.c:291:          pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
> drivers/pci/hotplug/shpchp.h:51:                        pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
> drivers/pci/pci.c:2484:                 pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
> drivers/pci/pci.c:2491:         pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
> drivers/pci/pci.c:2655:         pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> drivers/pci/pci.c:2658:         pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
> drivers/pci/pci.c:2661:         pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> drivers/pci/pci.c:2664:         pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
> drivers/pci/pci.c:3775: pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
> drivers/pci/pcie/aer.c:775:             pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
> drivers/pci/pcie/aer.c:1317:    pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
> drivers/pci/pcie/err.c:75:                      pci_printk(KERN_DEBUG, dev, "device has %s\n",
> drivers/pci/pcie/err.c:179:     pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
> drivers/pci/pcie/err.c:205:             pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
> drivers/pci/pcie/err.c:211:             pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
> drivers/pci/pcie/err.c:237:     pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
> drivers/pci/probe.c:321:                pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
> drivers/pci/probe.c:388:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> drivers/pci/probe.c:410:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> drivers/pci/probe.c:463:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> drivers/pci/probe.c:493:                                pci_printk(KERN_DEBUG, dev,
> drivers/pci/probe.c:1598:       pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
> drivers/pci/setup-bus.c:258:                            pci_printk(KERN_DEBUG, add_res->dev,
> drivers/pci/setup-bus.c:954:            pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
> drivers/pci/setup-bus.c:1101:           pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
> drivers/pci/setup-bus.c:1569:           pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
> 
