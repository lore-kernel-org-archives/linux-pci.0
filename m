Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Oct 2017 18:21:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 1/2] PCI: pci-host-generic: add support for Synopsys
 DesignWare RC in ECAM mode
Message-ID: <20171006232158.GI25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
 <20171006163919.14898-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171006163919.14898-2-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>,
 linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 06, 2017 at 05:39:18PM +0100, Ard Biesheuvel wrote:
> Some implementations of the Synopsys DesignWare PCIe controller implement
> a so-called ECAM shift mode, which allows a static memory window to be
> configured that covers the configuration space of the entire bus range.
> 
> Usually, when the firmware performs all the low level configuration that
> is required to expose this controller in a fully ECAM compatible manner,
> we can simply describe it as "pci-host-ecam-generic" and be done with it.
> However, in some cases (e.g., the Marvell Armada 80x0 as well as the
> Socionext SynQuacer Soc), the IP was synthesized with an ATU window
> granularity that does not allow the first bus to be mapped in a way that
> prevents the device on the downstream port from appearing more than once,
> and so we still need special handling in software to drive this static
> almost-ECAM configuration.
> 
> So extend the pci-host-generic driver so it can support these controllers
> as well, by adding special config space accessors that take the above
> quirk into account.
> 
> Note that, unlike most drivers for this IP, this driver does not expose
> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
> given that this is not a true bridge, and does not require any windows
> to be configured in order for the downstream device to operate correctly.
> Omitting it also prevents the PCI resource allocation routines from
> handing out BAR space to it unnecessarily.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/pci/host/pci-host-generic.c | 46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 7d709a7e0aa8..01e81a30e303 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -35,6 +35,43 @@ static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
>  	}
>  };
>  
> +static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
> +				   int size, u32 *val)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +
> +	/*
> +	 * The Synopsys DesignWare PCIe controller in ECAM mode will not filter
> +	 * type 0 config TLPs sent to devices 1 and up on its downstream port,
> +	 * resulting in devices appearing multiple times on bus 0 unless we
> +	 * filter out those accesses here.
> +	 */
> +	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;

I think we should return 0xffffffff data here, as we do in other
similar accessors (dw_pcie_rd_conf(), altera_pcie_cfg_read(),
rockchip_pcie_rd_conf()).

Actually, xilinx-nwl has a nice trick: it implements
nwl_pcie_map_bus(), which returns NULL for invalid devices.  Then it
can use the generic accessors, and pci_generic_config_read() already
fills in ~0 for this case. 

What do you think of the following?  I put it on my pci/host-generic
branch for now (pending your response and an ack from Will).



commit 5aec78ea05fe23c7c17f8e6c757bc64fb9142728
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri Oct 6 17:39:18 2017 +0100

    PCI: generic: Add support for Synopsys DesignWare RC in ECAM mode
    
    Some implementations of the Synopsys DesignWare PCIe controller implement
    a so-called ECAM shift mode, which allows a static memory window to be
    configured that covers the configuration space of the entire bus range.
    
    Usually, when the firmware performs all the low level configuration that
    is required to expose this controller in a fully ECAM compatible manner,
    we can simply describe it as "pci-host-ecam-generic" and be done with it.
    However, in some cases (e.g., the Marvell Armada 80x0 as well as the
    Socionext SynQuacer Soc), the IP was synthesized with an ATU window
    granularity that does not allow the first bus to be mapped in a way that
    prevents the device on the downstream port from appearing more than once,
    and so we still need special handling in software to drive this static
    almost-ECAM configuration.
    
    So extend the pci-host-generic driver so it can support these controllers
    as well, by adding special config space accessors that take the above quirk
    into account.
    
    Note that, unlike most drivers for this IP, this driver does not expose a
    fake bridge device at B/D/F 00:00.0. There is no point in doing so, given
    that this is not a true bridge, and does not require any windows to be
    configured in order for the downstream device to operate correctly.
    Omitting it also prevents the PCI resource allocation routines from handing
    out BAR space to it unnecessarily.
    
    Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    [bhelgaas: factor out pci_dw_valid_device(), add pci_dw_ecam_map_bus() and
    use generic read/write functions]
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 7d709a7e0aa8..2f05511ce718 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -35,6 +35,40 @@ static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	}
 };
 
+static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	/*
+	 * The Synopsys DesignWare PCIe controller in ECAM mode will not filter
+	 * type 0 config TLPs sent to devices 1 and up on its downstream port,
+	 * resulting in devices appearing multiple times on bus 0 unless we
+	 * filter out those accesses here.
+	 */
+	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
+		return false;
+
+	return true;
+}
+
+static void __iomem *pci_dw_ecam_map_bus(struct pci_bus *bus,
+					 unsigned int devfn, int where)
+{
+	if (!pci_dw_valid_device(bus, devfn))
+		return NULL;
+
+	return pci_ecam_map_bus(bus, devfn, where);
+}
+
+static struct pci_ecam_ops pci_dw_ecam_bus_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_dw_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
 	  .data = &gen_pci_cfg_cam_bus_ops },
@@ -42,6 +76,15 @@ static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
 
+	{ .compatible = "marvell,armada8k-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
+	{ .compatible = "socionext,synquacer-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
+	{ .compatible = "snps,dw-pcie-ecam",
+	  .data = &pci_dw_ecam_bus_ops },
+
 	{ },
 };
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
