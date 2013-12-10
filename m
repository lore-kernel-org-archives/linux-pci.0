Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44525 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab3LJAKK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 19:10:10 -0500
Date: Mon, 9 Dec 2013 17:10:08 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
Message-ID: <20131210001008.GM5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193332.GB20199@obsidianresearch.com>
 <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
 <20131209212744.GK5429@obsidianresearch.com>
 <CAErSpo6ZNM0SW+q7tSi+1hT6yAfb7Ckz85LjM4QUDgbH3wLAaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6ZNM0SW+q7tSi+1hT6yAfb7Ckz85LjM4QUDgbH3wLAaw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 02:58:06PM -0700, Bjorn Helgaas wrote:

> >> "A function must not restrict the size of the access it supports in
> >> Configuration Space. The configuration commands, like other commands,
> >> allow data to be accessed using any combination of bytes (including a
> >> byte, word, DWORD, or non-contiguous bytes) and multiple data phases
> >> in a burst. The target is required to handle any combination of byte
> >> enables."
> >
> > This verbage is talking about the target/responder, not the host. Any
> > target must respond to all possible sizes for all possible config
> > registers, including combinations that even x86 can't issue (like a BE
> > pattern of b0110)
> 
> Now I'm confused.  From the PCI core's point of view,
> pci_setup_bridge_io() is talking to a target, namely a PCI-to-PCI
> bridge.  PCI config space accessors are also for talking to targets.

The fundamental issue is that the PCI host drivers I pointed out have
hardware that cannot construct a PCI-E ConfigWr TLP (or PCI/PCI-X
eqiuv) with any content other than a 32 bit DWORD write.

So even though pci_setup_bridge_io is talking to a target, and the
target is required to handle all possible ConfigWr TLPs, the host
driver (struct pci_ops) can only generate one possibility.

The problematic host drivers are all emulating non-32 bit ConfigWr
support by doing RMW, and you have observed that RMW is not 100%
correct when dealing with write 1 to clear bits.

Basically, your fix to pci_setup_bridge_io is fine - but your
observation led me to realize that the HW drivers implementing RMW for
8 and 16 bit ops under their struct pci_ops.read function have exactly
the same flaw you are fixing here - they will silently wipe out write
1 to clear bits.

> Some arches set up their host bridges so they appear in PCI config
> space and have register layouts that look like PCI-to-PCI bridges.  In
> my opinion, those arches then have the responsibility of following all
> the PCI-to-PCI bridge rules, including access size restrictions,
> either directly in hardware or in their config accessors.

Sure, but this isn't the problem :)

IMHO, the pci core needs to help host drivers implement a correct
pci_ops.write function for the case where the host hardware can only
produce 32 bit ConfigWR TLPs. That seems to be common enough and
subtle enough it shouldn't be inlined into every driver.

Just to be clear, I am talking about implementations like this:

static int cns3xxx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
                                    int where, int size, u32 val)
{
        u32 v;
        void __iomem *base;
        u32 mask = (0x1ull << (size * 8)) - 1;
        int shift = (where % 4) * 8;

        base = cns3xxx_pci_cfg_base(bus, devfn, where);
        if (!base)
                return PCIBIOS_SUCCESSFUL;

        v = __raw_readl(base);

        v &= ~(mask << shift);
        v |= (val & mask) << shift;

        __raw_writel(v, base);

        return PCIBIOS_SUCCESSFUL;
}

static struct pci_ops cns3xxx_pcie_ops = {
        .read = cns3xxx_pci_read_config,
        .write = cns3xxx_pci_write_config,
};

Which we now know is subtly broken as it will clear write 1 to clear
bits when doing sub dword operations.

I found 6 copies of this pattern in 5 mins of searching :(

Regards,
Jason
