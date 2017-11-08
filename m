Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbdKHR1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Nov 2017 12:27:46 -0500
Date: Wed, 8 Nov 2017 11:27:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/17] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171108172745.GD28427@bhelgaas-glaptop.roam.corp.google.com>
References: <20171103134722.5532-1-niklas.cassel@axis.com>
 <20171103134722.5532-2-niklas.cassel@axis.com>
 <20171108005614.GF22847@bhelgaas-glaptop.roam.corp.google.com>
 <1c059ad0-aa57-fca4-6d92-e68736ffad5f@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1c059ad0-aa57-fca4-6d92-e68736ffad5f@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 08, 2017 at 12:45:49PM +0000, Joao Pinto wrote:
> Hello to all,
> 
> Às 12:56 AM de 11/8/2017, Bjorn Helgaas escreveu:
> > On Fri, Nov 03, 2017 at 02:47:05PM +0100, Niklas Cassel wrote:
> >> Use the DMA-API to get the MSI address. This address will be written to
> >> our PCI config space and to the register which determines which AXI
> >> address the DWC IP will spoof for incoming MSI irqs.
> >>
> >> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> >> to write to the MSI address, the proper way to get the MSI address is by
> >> using the DMA API, not by using virt_to_phys().
> >>
> >> Using virt_to_phys() might work on some systems, but using the DMA API
> >> should work on all systems.
> >>
> >> This is essentially the same thing as allocating a buffer in a driver
> >> to which the endpoint will write to. To do this, we use the DMA API.
> >>
> >> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > 
> > I'm expecting Jingoo and/or Joao to chime in and ack the
> > DesignWare-related patches.  I think all the others are in
> > pretty good shape.
> > 
> >> ---
> >>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
> >>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
> >>  2 files changed, 14 insertions(+), 4 deletions(-)
> >> ...
> 
> Let me test this patch-set in my setup first!
> I will give feedback until Friday.

OK, thanks.  This may push this series out until v4.16 because the
v4.15 merge window will probably open Sunday, and I don't like to add
code during the window and merge it immediately.

Bjorn
