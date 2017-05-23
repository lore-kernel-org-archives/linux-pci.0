Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 23 May 2017 12:24:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
Message-ID: <20170523172409.GD24431@bhelgaas-glaptop.roam.corp.google.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 04:31:25PM +0200, Marc Gonzalez wrote:
> This driver is required to work around several hardware bugs in the
> PCIe controller.
> 
> NB: Revision 1 does not support legacy interrupts, or IO space.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++++++
>  drivers/pci/host/Kconfig                             |   8 ++
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 161 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h                              |   2 +
>  5 files changed, 204 insertions(+)
> ...

> +static int smp8759_config_read(struct pci_bus *bus,
> +		unsigned int devfn, int where, int size, u32 *val)
> +{
> +	int ret;
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
> +
> +	/*
> +	 * QUIRK #1
> +	 * Reads in configuration space outside devfn 0 return garbage.
> +	 */
> +	if (devfn != 0)
> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +
> +	/*
> +	 * QUIRK #2
> +	 * Unfortunately, config and mem spaces are muxed.
> +	 * Linux does not support such a setting, since drivers are free
> +	 * to access mem space directly, at any time.
> +	 * Therefore, we can only PRAY that config and mem space accesses
> +	 * NEVER occur concurrently.
> +	 */
> +	writel_relaxed(1, pcie->mux);
> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
> +	writel_relaxed(0, pcie->mux);

This is a major issue and possibly even a security problem.
Unprivileged users can cause config accesses via lspci/setpci.

I don't have a good suggestion for addressing it, but if you can't
make this work reliably, you need at least a dev_err() in the probe
function and probably a taint of the kernel (see add_taint()).

> +	return ret;
> +}
> +
> +static int smp8759_config_write(struct pci_bus *bus,
> +		unsigned int devfn, int where, int size, u32 val)
> +{
> +	int ret;
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
> +
> +	writel_relaxed(1, pcie->mux);
> +	ret = pci_generic_config_write(bus, devfn, where, size, val);
> +	writel_relaxed(0, pcie->mux);
> +
> +	return ret;
> +}
> +
> +static struct pci_ecam_ops smp8759_ecam_ops = {
> +	.bus_shift	= 20,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= smp8759_config_read,
> +		.write		= smp8759_config_write,
> +	}
> +};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
