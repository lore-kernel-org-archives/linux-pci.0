Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:42009 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbaE1CsY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 22:48:24 -0400
Received: by mail-ie0-f171.google.com with SMTP id to1so9760276ieb.16
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 19:48:24 -0700 (PDT)
Date: Tue, 27 May 2014 20:48:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v8 0/3] R-Car Gen2 PCIe host driver
Message-ID: <20140528024820.GL11907@google.com>
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 12, 2014 at 11:57:47AM +0100, Phil Edworthy wrote:
> This is version 8 of a PCIe Host driver for the R-Car Gen2 devices,
> i.e. R-Car H2 (r8a7790) and R-Car M2 (r8a7791).
> 
> v8:
>  - Platform changes removed from this patch set
>  - Moved header file contents into c file
>  - Formatting cleaned up
>  - Remove bus/dev/func range checks for config access
>  - Add comment about config access serialization
>  - Made rcar_pcie_setup_window() return void as no errors possible
>  - Remove unused register definitions
>  - Removed __init markers to fix section mismatches
>  - Add explicit bus number range
>  - Get the root bus nr from config writes instead of sys->busnr
>  - Use PCI domains
>  - Removed unused variable in rcar_msi_free()
>  - Split interrupt bindings into separate cells
> 
> v7:
>  - Change binding description of clocks to 'clock specifiers'
> 
> v6:
>  - Correct DT bindings description for reg and clocks
>  - Split device and board DT changes
>  - Add shmobile to subject for shmobile DT patches
>  - Don't check MSI irq number is valid, as upper level checks this
>  - Change "Unexpected MSI" msg to debug level
>  - Reword "Unexpected MSI" comment so that it's one line
>  - Remove patch that adds HAVE_ARM_ARCH_TIMER to koelsch defconfig as not needed
> 
> v5:
>  - Use module_platform_driver instead of subsys_initcall
>  - Use the of_device_id data field for HW init function
>  - Init hw_pci struct in declaration
>  - Renesas SoC compatible string has peripheral before device name
>  - Add PCIe bus clock reference
>  - Use dma-ranges property to specify inbound memory regions
>  - Support multiple IO windows and correct resources
>  - Return IRQ_NONE from MSI isr when there is no pending MSI
>  - Add additional interrupt bindings
> 
> v4:
>  - Use runtime PM properly
> 
> Phil Edworthy (3):
>   PCI: host: rcar: Add Renesas R-Car PCIe driver
>   PCI: host: rcar: Add MSI support
>   dt-bindings: pci: rcar pcie device tree bindings
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |   47 +
>  drivers/pci/host/Kconfig                           |    6 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-rcar.c                       | 1008 ++++++++++++++++++++
>  4 files changed, 1062 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
>  create mode 100644 drivers/pci/host/pcie-rcar.c

Applied with Simon's ack to pci/host-rcar for v3.16, thanks!

Bjorn
