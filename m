Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Jan 2016 08:53:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v3 0/2] adding PCI support to AXS10x
Message-ID: <20160111145353.GD25540@localhost>
References: <cover.1450694884.git.jpinto@synopsys.com>
 <20160108203358.GI5354@localhost>
 <5693BCD7.4050703@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5693BCD7.4050703@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 11, 2016 at 02:31:51PM +0000, Joao Pinto wrote:
> Hi Bjorn,
> 
> On 1/8/2016 8:33 PM, Bjorn Helgaas wrote:
> > Hi Joao,
> > 
> > On Mon, Dec 21, 2015 at 03:44:14PM +0000, Joao Pinto wrote:
> >> This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
> >> AXS10x. It includes the necessary tweaks to the ARC architecture, necessary
> >> tweaks to the PCI subsystem and a new driver (pcie-snpsdev).
> >> This new driver will be used extensively in the PCIe RC Prototyping Kit.
> >>
> >> The patches were produced against Bjorn Helgaas' repository. It was properly
> >> tested in an IP Prototyping Kit.
> >>
> >> Joao Pinto (2):
> >>   PCI support added to ARC
> >>   add new platform driver for PCI RC
> >>
> >>  .../devicetree/bindings/pci/pcie-snpsdev.txt       |  33 +++
> >>  MAINTAINERS                                        |   7 +
> >>  arch/arc/Kconfig                                   |  23 ++
> >>  arch/arc/include/asm/dma.h                         |   5 +
> >>  arch/arc/include/asm/io.h                          |  10 +
> >>  arch/arc/include/asm/pci.h                         |  43 ++++
> >>  arch/arc/kernel/Makefile                           |   1 +
> >>  arch/arc/kernel/pcibios.c                          |  55 ++++
> >>  arch/arc/mm/ioremap.c                              |  10 +-
> >>  arch/arc/plat-axs10x/Kconfig                       |   1 +
> >>  drivers/pci/Makefile                               |   1 +
> >>  drivers/pci/host/Kconfig                           |   5 +
> >>  drivers/pci/host/Makefile                          |   1 +
> >>  drivers/pci/host/pcie-designware.c                 |  11 +
> >>  drivers/pci/host/pcie-designware.h                 |   1 +
> >>  drivers/pci/host/pcie-snpsdev.c                    | 286 +++++++++++++++++++++
> >>  16 files changed, 492 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> >>  create mode 100644 arch/arc/include/asm/pci.h
> >>  create mode 100644 arch/arc/kernel/pcibios.c
> >>  create mode 100644 drivers/pci/host/pcie-snpsdev.c
> > 
> > This failed the kbuild test, so I'm waiting for a refresh to fix that.
> 
> Just checked the kbuild robot error and it is happening in ARC git tree when
> built for i386 arch and the problem is independent from my patches. The build
> error is the following:
> 
>    drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
> >> drivers/pci/host/pcie-designware.c:556:7: error: implicit declaration of function
> 'pci_has_flag' [-Werror=implicit-function-declaration]
>      if (!pci_has_flag(PCI_PROBE_ONLY)) {
>           ^
> >> drivers/pci/host/pcie-designware.c:556:20: error: 'PCI_PROBE_ONLY' undeclared
> (first use in
> this function)
>      if (!pci_has_flag(PCI_PROBE_ONLY)) {
>                        ^
> This problem has been already identified by Stephen Rothwell as you can see in
> the following mailing list thread:
> 
> http://www.gossamer-threads.com/lists/linux/kernel/2341200

Stephen saw that problem while building the Qualcomm driver
(CONFIG_PCIE_QCOM), and we fixed it by changing Kconfig so we won't build
that driver on x86.

That fix only affects CONFIG_PCIE_QCOM, so it won't help your driver.

You need some improvements to your drivers/pci/host/Kconfig patch -- some
help text and probably some dependencies.

Bjorn
