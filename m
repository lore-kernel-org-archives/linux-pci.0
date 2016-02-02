Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41852 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933207AbcBBROk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 12:14:40 -0500
Date: Tue, 2 Feb 2016 11:14:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de
Subject: Re: [PATCH v7 0/2] adding PCI support to AXS10x
Message-ID: <20160202171437.GD11085@localhost>
References: <cover.1454349430.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1454349430.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 06:07:43PM +0000, Joao Pinto wrote:
> This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
> AXS10x. It includes the necessary tweaks to the ARC architecture, 
> necessary tweaks to the PCI subsystem and a new driver (pcie-synopsys).
> This new driver will be used extensively in the PCIe RC Prototyping Kit.
> 
> The patches were produced against Bjorn Helgaas' repository. It was properly
> tested in an IP Prototyping Kit.
> 
> Joao Pinto (2):
>   PCI support added to ARC
>   add new platform driver for PCI RC
> 
>  .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 +++
>  MAINTAINERS                                        |   7 +
>  arch/arc/Kconfig                                   |  23 ++
>  arch/arc/include/asm/dma.h                         |   5 +
>  arch/arc/include/asm/io.h                          |   9 +
>  arch/arc/include/asm/pci.h                         |  31 +++
>  arch/arc/kernel/Makefile                           |   1 +
>  arch/arc/kernel/pcibios.c                          |  23 ++
>  arch/arc/plat-axs10x/Kconfig                       |   1 +
>  drivers/pci/Makefile                               |   1 +
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-synopsys.c                   | 257 +++++++++++++++++++++
>  13 files changed, 400 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
>  create mode 100644 arch/arc/include/asm/pci.h
>  create mode 100644 arch/arc/kernel/pcibios.c
>  create mode 100644 drivers/pci/host/pcie-synopsys.c

I applied these to pci/host-synopsys, and I plan to merge them for v4.5.

Bjorn
