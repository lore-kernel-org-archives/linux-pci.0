Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 08:31:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH] of: Devices with pci_epf_bus_type require DMA
        configuration
Message-ID: <20171023063113.GB16978@lst.de>
References: <20171011080041.12918-1-kishon@ti.com> <cae4b8e9-9944-6482-c12c-8ce87aea1487@arm.com> <3599d3e2-d496-eac3-7179-2d1795fc059d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3599d3e2-d496-eac3-7179-2d1795fc059d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 23, 2017 at 11:13:23AM +0530, Kishon Vijay Abraham I wrote:
> EPF devices use EPC devices which in turn use the actual platform device for
> configuring the hardware. IMO the devices in one layer shouldn't have to
> explicitly use devices in another layer other than using clearly defined API's.
> Here platform_device is the bottom later, above which is epc_device and on top
> is epf_device.
> 
> The idea is just by doing the initial setup in the framework, the epf driver be
> able to use APIs like dma_alloc_coherent using it's own *device* rather than
> the EPC's "device".

That's a little strange - normally we only call dma_map* routines on
the actual physical bus devices.
