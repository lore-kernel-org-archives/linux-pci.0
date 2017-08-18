Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbdHRPxd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Aug 2017 11:53:33 -0400
Date: Fri, 18 Aug 2017 10:53:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        nsekhar@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 00/18] PCI: endpoint: Make pci-epf-test more flexible
Message-ID: <20170818155331.GM28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 18, 2017 at 08:27:52PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> I've collected all the patches for PCI Endpoint in this series. This
> series contains PCI endpoint fixes and making pci-epf-test more
> flexible in terms of mapping PCI_ENDPOINT_TEST regs to any BARs,
> work with linkup notification etc.
> 
> I've been having most of these patches in my local tree created while
> adding support for endpoint in TI's K2G platform. I've also included fix
> from others who are trying to use the PCI Endpoint Framework in their
> own platforms.
> 
> It also contains minor changes in pci/dwc/ like resetting BARs in the
> EP controller and providing a page size to pci_epc_mem. I can send this
> part separately based on some of your branch if you'd prefer that.
> 
> This also contains patches for host side pci_endpoint_test driver
> in drivers/misc.
> 
> I've pushed the series to pci-endpoint tree, the details of which are
> given below.

Applied to pci/endpoint for v4.14, thanks!

> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git tags/pci-ep-for-4.14
> 
> for you to fetch changes up to 31802acb56e040bf5f269b2bad159583fc804d68:
> 
>   tools: PCI: Add a missing option help line (2017-08-18 19:23:36 +0530)
> 
> ----------------------------------------------------------------
> PCI: endpoint: for 4.14
> 
> PCI endpoint core:
>  *) Add support for page size to be configurable (for managing address
>     region within the controller)
>  *) Add an API to get matching "pci_epf_device_id"
>  *) Use of_dma_configure() to set initial dma mask of pci_epf device
>  *) Do not abort if endpoint function drivers have not populated
>     ->remove() callback
> 
> pci-epf-test function driver:
>  *) Add support to poll early for host commands
>  *) Add support to use _any_ BAR's to map PCI_ENDPOINT_TEST regs
> 
> pci_endpoint_test PCI driver:
>  *) Add support for PCI_ENDPOINT_TEST regs to be mapped to any BAR
>  *) Add support to provide aligned buffer addresses
>  *) Enable/Disable MSI using module param
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ----------------------------------------------------------------
> Kishon Vijay Abraham I (16):
>       PCI: endpoint: pci-epc-core: Use of_dma_configure() to set initial dma mask
>       PCI: endpoint: pci-epf-core: Add an API to get matching "pci_epf_device_id"
>       PCI: endpoint: pci-epf-core: Make ->remove() callback optional
>       PCI: endpoint: pci-epc-mem: Add support for configurable page size
>       PCI: endpoint: functions/pci-epf-test: Add "volatile" to pci_epf_test_reg
>       PCI: endpoint: functions/pci-epf-test: Do not reset *command* inadvertently
>       PCI: endpoint: functions/pci-epf-test: Add support to use _any_ BAR's to map PCI_ENDPOINT_TEST regs
>       PCI: endpoint: functions/pci-epf-test: Add support to poll early for host commands
>       PCI: dwc: designware: Provide page_size to pci_epc_mem
>       PCI: dwc: dra7xx: Reset all BARs during initialization
>       PCI: dwc: designware-ep: Do not disable BARs during initialization
>       misc: pci_endpoint_test: Add support for PCI_ENDPOINT_TEST regs to be mapped to any BAR
>       misc: pci_endpoint_test: Add support to provide aligned buffer addresses
>       misc: pci_endpoint_test: Add support to not enable MSI interrupts
>       misc: pci_endpoint_test: Avoid using hard coded BAR sizes
>       misc: pci_endpoint_test: Enable/Disable MSI using module param
> 
> Shawn Lin (1):
>       PCI: endpoint: functions/pci-epf-test: Remove the ->remove() callback
> 
> Stan Drozd (1):
>       tools: PCI: Add a missing option help line
> 
>  drivers/misc/pci_endpoint_test.c              | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
>  drivers/pci/dwc/pci-dra7xx.c                  |  13 +++++++++++++
>  drivers/pci/dwc/pcie-designware-ep.c          |   7 ++-----
>  drivers/pci/dwc/pcie-designware.h             |   1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c |  99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
>  drivers/pci/endpoint/pci-epc-core.c           |  11 +++++++++--
>  drivers/pci/endpoint/pci-epc-mem.c            |  59 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  drivers/pci/endpoint/pci-epf-core.c           |  21 +++++++++++++++++++--
>  include/linux/pci-epc.h                       |   8 +++++++-
>  include/linux/pci-epf.h                       |   2 ++
>  tools/pci/pcitest.c                           |   1 +
>  11 files changed, 276 insertions(+), 78 deletions(-)
> -- 
> 2.11.0
> 
