Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43287 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbcAHUeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 15:34:01 -0500
Date: Fri, 8 Jan 2016 14:33:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v3 0/2] adding PCI support to AXS10x
Message-ID: <20160108203358.GI5354@localhost>
References: <cover.1450694884.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1450694884.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Mon, Dec 21, 2015 at 03:44:14PM +0000, Joao Pinto wrote:
> This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
> AXS10x. It includes the necessary tweaks to the ARC architecture, necessary
> tweaks to the PCI subsystem and a new driver (pcie-snpsdev).
> This new driver will be used extensively in the PCIe RC Prototyping Kit.
> 
> The patches were produced against Bjorn Helgaas' repository. It was properly
> tested in an IP Prototyping Kit.
> 
> Joao Pinto (2):
>   PCI support added to ARC
>   add new platform driver for PCI RC
> 
>  .../devicetree/bindings/pci/pcie-snpsdev.txt       |  33 +++
>  MAINTAINERS                                        |   7 +
>  arch/arc/Kconfig                                   |  23 ++
>  arch/arc/include/asm/dma.h                         |   5 +
>  arch/arc/include/asm/io.h                          |  10 +
>  arch/arc/include/asm/pci.h                         |  43 ++++
>  arch/arc/kernel/Makefile                           |   1 +
>  arch/arc/kernel/pcibios.c                          |  55 ++++
>  arch/arc/mm/ioremap.c                              |  10 +-
>  arch/arc/plat-axs10x/Kconfig                       |   1 +
>  drivers/pci/Makefile                               |   1 +
>  drivers/pci/host/Kconfig                           |   5 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-designware.c                 |  11 +
>  drivers/pci/host/pcie-designware.h                 |   1 +
>  drivers/pci/host/pcie-snpsdev.c                    | 286 +++++++++++++++++++++
>  16 files changed, 492 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
>  create mode 100644 arch/arc/include/asm/pci.h
>  create mode 100644 arch/arc/kernel/pcibios.c
>  create mode 100644 drivers/pci/host/pcie-snpsdev.c

This failed the kbuild test, so I'm waiting for a refresh to fix that.

Bjorn
