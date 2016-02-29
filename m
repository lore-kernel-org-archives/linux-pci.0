Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Feb 2016 13:22:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v11 0/4] ARC: Add PCI support
Message-ID: <20160229192211.GA10370@localhost>
References: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <6C7E76B729B341419CE4B84926C1D2CD010BCE1D@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6C7E76B729B341419CE4B84926C1D2CD010BCE1D@DE02WEMBXB.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 06:30:52PM +0000, Joao Pinto wrote:
> Hi Bjorn!
> 
> Is it possible to pull this patch set into 4.5?

No, it's a little late for v4.5.  We're already at v4.5-rc6, so it's
only critical bug fixes until the v4.6 merge window opens.

Bjorn

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Friday, February 26, 2016 4:30 PM
> To: Joao Pinto
> Cc: mark.rutland@arm.com; Alexey.Brodkin@synopsys.com; arnd@arndb.de; pawel.moll@arm.com; ijc+devicetree@hellion.org.uk; linux-pci@vger.kernel.org; Vineet.Gupta1@synopsys.com; Pratyush Anand; linux-kernel@vger.kernel.org; CARLOS.PALMINHA@synopsys.com; robh+dt@kernel.org; Murali Karicheri; galak@codeaurora.org; Jingoo Han; linux-snps-arc@lists.infradead.org
> Subject: [PATCH v11 0/4] ARC: Add PCI support
> 
> >From Joao's v9 posting
> (http://lkml.kernel.org/r/cover.1454952698.git.jpinto@synopsys.com):
> 
>   "This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
>   AXS10x. It includes the necessary tweaks to:
> 
>    - the ARC architecture (PCI support)
>    - the PCI subsystem (ARC CPU support)
>    - to pcie-designware (Centralisation of wait for link routine)
>    - to dra7xx, exynos, imx6 and spear13xx drivers to use the centralised
>      code for link wait
> 
>   A simple module was (pcie-designware-plat) was created to contain the
>   specific platform init code."
> 
> Changes from v10:
>   - Update keystone link establishment to wait longer for link to come up
>     before re-initiating link training
>   - Also use generic dw_pcie_wait_for_link() in keystone and qcom drivers
> 
> I would still like acks from DesignWare maintainers (Jingoo or Pratyush), from Murali for the Keystone changes, and from Arnd for the DT updates.
> 
> This series is in my pci/host-synopsys branch here:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-syn
> opsys
> ---
> 
> Joao Pinto (4):
>       ARC: Add PCI support
>       PCI: designware: Add generic dw_pcie_wait_for_link()
>       PCI: designware: Add default link up check if sub-driver doesn't override
>       PCI: designware: Add driver for prototyping kits based on ARC SDP
> 
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |   17 ++
>  MAINTAINERS                                        |    7 +
>  arch/arc/Kconfig                                   |   26 ++++
>  arch/arc/include/asm/dma.h                         |    5 +
>  arch/arc/include/asm/io.h                          |    9 +
>  arch/arc/include/asm/pci.h                         |   31 ++++
>  arch/arc/kernel/Makefile                           |    1 
>  arch/arc/kernel/pcibios.c                          |   22 +++
>  arch/arc/plat-axs10x/Kconfig                       |    1 
>  drivers/pci/Makefile                               |    1 
>  drivers/pci/host/Kconfig                           |   11 ++
>  drivers/pci/host/Makefile                          |    1 
>  drivers/pci/host/pci-dra7xx.c                      |   11 --
>  drivers/pci/host/pci-exynos.c                      |   13 --
>  drivers/pci/host/pci-imx6.c                        |   13 +-
>  drivers/pci/host/pci-keystone.c                    |   10 +
>  drivers/pci/host/pcie-designware-plat.c            |  138 ++++++++++++++++++++
>  drivers/pci/host/pcie-designware.c                 |   29 ++++
>  drivers/pci/host/pcie-designware.h                 |    6 +
>  drivers/pci/host/pcie-qcom.c                       |   10 -
>  drivers/pci/host/pcie-spear13xx.c                  |   14 --
>  21 files changed, 318 insertions(+), 58 deletions(-)  create mode 100644 arch/arc/include/asm/pci.h  create mode 100644 arch/arc/kernel/pcibios.c  create mode 100644 drivers/pci/host/pcie-designware-plat.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
