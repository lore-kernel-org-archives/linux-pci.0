Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeHXTrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Aug 2018 15:47:39 -0400
Date: Fri, 24 Aug 2018 11:12:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH 0/4] Add support to register platform service IRQ
Message-ID: <20180824161219.GA141098@bhelgaas-glaptop.roam.corp.google.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 24, 2018 at 12:16:20PM +0000, Bharat Kumar Gogada wrote:
> > Subject: [PATCH 0/4] Add support to register platform service IRQ
> > 
> > Some platforms have dedicated IRQ lines for PCIe services like AER/PME etc.
> > The root complex on these platform will use these seperate IRQ lines to
> > report AER/PME etc., interrupts and will not generate MSI/MSI-X/INTx
> > interrupts for these services.
> > These patches will add new method for these kind of platforms to register
> > the platform IRQ number with respective PCIe services.
> > 
> > Bharat Kumar Gogada (4):
> >   PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
> >   PCI: Add pci_check_platform_service_irqs
> >   PCI/portdrv: Check platform supported service IRQ's
> >   PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
> > 
> >  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
> >  drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
> >  include/linux/pci.h                      |   25 +++++++++++++++++++++++++
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> Hi Bjorn,
> Can you comment on this series.

I'm taking a breather during the merge window.  As soon as -rc1 comes
out (probably Sunday), I'll start processing the patches in the queue.

Bjorn
