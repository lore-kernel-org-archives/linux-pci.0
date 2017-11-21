Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdKUOk0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Nov 2017 09:40:26 -0500
Date: Tue, 21 Nov 2017 08:40:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH 1/1 v2 ] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver
Message-ID: <20171121144024.GF16362@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx3yvDY-qOkTeakyKuk+G=bXGFxjEvPxeQLy+qW0jwpBiA@mail.gmail.com>
 <0ebbcfea-4186-5987-bdf1-3288a4e1f907@mobiveil.co.in>
 <20171109234331.GC7629@bhelgaas-glaptop.roam.corp.google.com>
 <CAFZiPx14ABgM8kCxoQVyxS6bbhMpmMmF5+fEg1UEFEgC3RmA2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx14ABgM8kCxoQVyxS6bbhMpmMmF5+fEg1UEFEgC3RmA2A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo, Tanmay]

On Tue, Nov 21, 2017 at 05:45:16PM +0530, Subrahmanya Lingappa wrote:
> On Fri, Nov 10, 2017 at 5:13 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Nov 09, 2017 at 05:33:03PM +0530, subrahmanya_lingappa wrote:

> >> +     /* create the PCIe root bus */
> >> +     bus =
> >> +         pci_create_root_bus(&pdev->dev, 0, &mobiveil_pcie_ops, pcie, &res);
> >> +     if (!bus)
> >> +             return -ENOMEM;
> >> +
> >> +     /* setup MSI, if enabled */
> >> +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >> +             mobiveil_pcie_msi_chip.dev = &pcie->pdev->dev;
> >> +             bus->msi = &mobiveil_pcie_msi_chip;
> >> +     }
> >> +
> >> +     /* setup the kernel resources for the newly added PCIe root bus */
> >> +     pci_scan_child_bus(bus);
> >
> > Use pci_scan_root_bus_bridge().  For example, see
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=123db533072e
> >
> >> +     pci_assign_unassigned_bus_resources(bus);
> >> +
> >> +     list_for_each_entry(child, &bus->children, node)
> >> +             pcie_bus_configure_settings(child);
> >> +
> >> +     pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >
> > pci_scan_root_bus_bridge() also takes care of this pci_fixup_irqs()
> > (which doesn't exist anymore); see
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6ab380957838
> >
> I am testing this driver on a board whcih supports  Xilinx's latest
> Petalinux build environment has Linux-4.9 kernel version with all
> the patches from Xilinx included in it. But these
> pci_scan_root_bus_bridge() and friends we added in recent versions
> will it be ok keeping pci_scan_child_bus() for now ?

I would strongly prefer to use pci_scan_root_bus_bridge().  As I
mentioned, pci_fixup_irqs() doesn't even exist upstream anymore, so
this can't be merged as-is.

BTW, Lorenzo, it looks like 9af275be15f7 ("PCI: xgene: Convert PCI
scan API to pci_scan_root_bus_bridge()") forgot to remove the
pci_scan_child_bus() call from xgene_pcie_probe().

Bjorn
