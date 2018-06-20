Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <9bd45007ddfe2c32b6ee5097e427aabdc267ce53.camel@perches.com>
Subject: pci: pci_printk use
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Date: Tue, 19 Jun 2018 21:33:18 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All the pci_printk uses are at KERN_DEBUG which is always
emitted into the kernel logging whenever the console log
level is high enough.

Are any of these appropriate for conversion to pci_dbg
to allow these only to be emitted via dynamic_debug or
if necessary via a #define DEBUG during compilation?

$ git grep -w -n pci_printk drivers
drivers/pci/bus.c:291:          pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
drivers/pci/hotplug/shpchp.h:51:                        pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
drivers/pci/pci.c:2484:                 pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
drivers/pci/pci.c:2491:         pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
drivers/pci/pci.c:2655:         pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2658:         pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2661:         pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2664:         pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:3775: pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
drivers/pci/pcie/aer.c:775:             pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
drivers/pci/pcie/aer.c:1317:    pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
drivers/pci/pcie/err.c:75:                      pci_printk(KERN_DEBUG, dev, "device has %s\n",
drivers/pci/pcie/err.c:179:     pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
drivers/pci/pcie/err.c:205:             pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
drivers/pci/pcie/err.c:211:             pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
drivers/pci/pcie/err.c:237:     pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
drivers/pci/probe.c:321:                pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
drivers/pci/probe.c:388:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:410:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:463:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:493:                                pci_printk(KERN_DEBUG, dev,
drivers/pci/probe.c:1598:       pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
drivers/pci/setup-bus.c:258:                            pci_printk(KERN_DEBUG, add_res->dev,
drivers/pci/setup-bus.c:954:            pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
drivers/pci/setup-bus.c:1101:           pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
drivers/pci/setup-bus.c:1569:           pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
