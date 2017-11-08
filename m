Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Nov 2017 18:56:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/17] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171108005614.GF22847@bhelgaas-glaptop.roam.corp.google.com>
References: <20171103134722.5532-1-niklas.cassel@axis.com>
 <20171103134722.5532-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171103134722.5532-2-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 03, 2017 at 02:47:05PM +0100, Niklas Cassel wrote:
> Use the DMA-API to get the MSI address. This address will be written to
> our PCI config space and to the register which determines which AXI
> address the DWC IP will spoof for incoming MSI irqs.
> 
> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> to write to the MSI address, the proper way to get the MSI address is by
> using the DMA API, not by using virt_to_phys().
> 
> Using virt_to_phys() might work on some systems, but using the DMA API
> should work on all systems.
> 
> This is essentially the same thing as allocating a buffer in a driver
> to which the endpoint will write to. To do this, we use the DMA API.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

I'm expecting Jingoo and/or Joao to chime in and ack the
DesignWare-related patches.  I think all the others are in
pretty good shape.

> ---
>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> ...
