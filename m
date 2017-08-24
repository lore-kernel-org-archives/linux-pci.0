Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 11:46:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/3] pci: add support for firmware initialized designware
 RCs
Message-ID: <20170824164633.GI31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 Leif Lindholm <leif.lindholm@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 08:29:04PM +0100, Ard Biesheuvel wrote:
> UEFI based systems incorporating a Synopsys Designware PCIe controller
> in RC mode will typically configure it before entering the OS. If this
> configuration is fully static and ECAM compliant, there is no need to
> expose particulars of the device to the OS, and we can simply describe
> it as "pci-host-ecam-generic".

I *love* the idea of moving more of this to firmware.  I spend an
incredible amount of time looking at all these native drivers, and
*zero* time looking at the ACPI driver (pci_root.c).  And it's not
like all this code in the native drivers is adding features or
performance.  It's just extra work for no benefit.

I'm assuming there'll be a v2 soon for the kbuild warnings.

> However, the Synopsys IP may be synthesized in a way where a quirk is
> needed for config space accesses to the first bus. It makes little sense
> to instantiate yet another pcie-designware driver that contains all the
> low level setup code, but it is also not justified to add quirks handling
> to the generic ECAM driver.
> 
> So instead, create a variant of the generic ECAM driver that filters config
> space accesses directed at device #1 and up on the first bus.
> 
> Also, add a binding and driver to support the MSI functionality available
> in some versions of this IP. This allows the MSI routing to be described
> at the DT level rather than hardcoding it in the driver.
> 
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Graeme Gregory <graeme.gregory@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> Ard Biesheuvel (3):
>   pci: designware: add driver for DWC controller in ECAM shift mode
>   pci: designware: add separate driver for the MSI part of the RC
>   dt-bindings: designware: add binding for Designware PCIe in ECAM mode
> 
>  Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt |  56 +++++
>  drivers/pci/dwc/Kconfig                                        |  11 +
>  drivers/pci/dwc/Makefile                                       |   4 +-
>  drivers/pci/dwc/pcie-designware-ecam.c                         |  75 ++++++
>  drivers/pci/dwc/pcie-designware-msi.c                          | 255 ++++++++++++++++++++
>  5 files changed, 400 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>  create mode 100644 drivers/pci/dwc/pcie-designware-ecam.c
>  create mode 100644 drivers/pci/dwc/pcie-designware-msi.c
> 
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
