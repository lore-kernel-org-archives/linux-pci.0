Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Nov 2017 15:50:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: Add support to the Cadence PCIe controller
Message-ID: <20171128155039.GA17154@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:01:45PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> this series of patches adds support to the Cadence PCIe controller.
> It was tested on a ARM64 platform emulated by a Palladium running both
> linux-next (next-20171123) and pci-next kernels.
> 
> The host mode was tested with some PCIe devices connected to the Palladium
> through a speed-bridge. Some of those devices were a USB host controller
> and a SATA controller. The PCIe host controller was also tested with a
> second controller configured in endpoint mode and connected back to back
> to the first controller.
> 
> The EndPoint Controller (EPC) driver of this series was tested with the
> pci-epf-test.c EndPoint Function (EPF) driver and the pcitest userspace
> program.
> 
> For linux-next, I applied this series on top of Kishon's patch
> ("PCI: endpoint: Use EPC's device in dma_alloc_coherent/dma_free_coherent")
> otherwise dma_alloc_coherent() fails when called by pci_epf_alloc_space().
> 
> Also, I patched drivers/Makefile rather than drivers/pci/Makefile to make
> the drivers/pci/cadence/pcie-cadence-ep.o linked after
> drivers/pci/endpoint/*.o objects, otherwise the built-in pci-cadence-ep
> driver would be probed before the PCI endpoint framework would have been
> initialized, which results in a kernel crash.

Nice :( - isn't there a way to improve this (ie probe deferral or
registering the EPF bus earlier) ?

> I guess this is the reason why the "pci/dwc" line was also put in
> drivers/Makefile, right after the "pci/endpoint" line.

Or probably the other way around - see commit 5e8cb4033807

@Kishon, thoughts ?

Thanks,
Lorenzo

> Best regards,
> 
> Cyrille
> 
> Cyrille Pitchen (4):
>   PCI: Add vendor ID for Cadence
>   PCI: cadence: Add host driver for Cadence PCIe controller
>   dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint
>     controller
>   PCI: cadence: add EndPoint Controller driver for Cadence PCIe
>     controller
> 
> Scott Telford (1):
>   dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host
>     controller
> 
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  20 +
>  .../bindings/pci/cdns,cdns-pcie-host.txt           |  54 ++
>  drivers/Makefile                                   |   1 +
>  drivers/pci/Kconfig                                |   1 +
>  drivers/pci/cadence/Kconfig                        |  33 ++
>  drivers/pci/cadence/Makefile                       |   3 +
>  drivers/pci/cadence/pcie-cadence-ep.c              | 553 +++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence-host.c            | 425 ++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.c                 | 110 ++++
>  drivers/pci/cadence/pcie-cadence.h                 | 325 ++++++++++++
>  include/linux/pci_ids.h                            |   2 +
>  11 files changed, 1527 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>  create mode 100644 drivers/pci/cadence/Kconfig
>  create mode 100644 drivers/pci/cadence/Makefile
>  create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>  create mode 100644 drivers/pci/cadence/pcie-cadence.h
> 
> -- 
> 2.11.0
> 
