Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 6 Jul 2017 14:46:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
Message-ID: <20170706194628.GQ13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
 <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
 <20170705180359.GL13824@bhelgaas-glaptop.roam.corp.google.com>
 <5a1207cb-31fd-6b85-86af-8c37bd57ad4f@free.fr>
 <20170705213419.GD25063@bhelgaas-glaptop.roam.corp.google.com>
 <8dcab663-245b-880a-be3a-2965fd12d663@free.fr>
 <20170706033946.GO13824@bhelgaas-glaptop.roam.corp.google.com>
 <d04e1632-17b8-85f9-31c4-b789d55cc853@free.fr>
MIME-Version: 1.0
In-Reply-To: <d04e1632-17b8-85f9-31c4-b789d55cc853@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DT <devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 02:26:44PM +0200, Mason wrote:
> On 06/07/2017 05:39, Bjorn Helgaas wrote:
> 
> > On Wed, Jul 05, 2017 at 11:59:33PM +0200, Mason wrote:
> >
> >> There were a few nits I wanted to address:
> >>
> >> - Since we added suppress_bind_attrs = true, probe()
> >> can only be called at init, so I wanted to mark __init
> >> all the probe functions, to save space.
> >>
> >> - I left the definition of MSI_MAX in the wrong patch

I moved this.

> >> - You put a pointer to the pdev in the struct tango_pcie.
> >> I think this is redundant, since the pdev already has a
> >> pointer to the struct, as drvdata.
> >> So I wanted to change tango_msi_probe() to take a pdev
> >> as argument (to make it more like an actual probe function)
> >> and derive pcie from pdev, instead of the other way around.
> > 
> > I don't think tango_msi_probe() is really a "probe" function.  It's
> > all part of the tango driver, and it's not claiming a separate piece
> > of hardware.
> 
> I agree that tango_msi_probe() is not a probe function;
> it is merely a piece of the actual probe function (static
> with single call site). I split the probe function in two,
> because it seemed to make sense at the time.
> 
> Perhaps it's better to inline tango_msi_probe? That would
> avoid the issues of that function's name and parameters.
> 
> If you think it's better to keep the two pieces separate,
> I can rename the MSI part to tango_msi_init() or some such.
> But I'd like to avoid adding unnecessary fields to the struct.

I think it's better to follow the structure of existing drivers unless
your hardware dictates a different model.  Same with adding fields to
the struct.  If you have a better way of doing it that works for all
the drivers, great -- but please change all the drivers to do it that
way.  If it's a matter of saving one pointer per system, by making the
code look different than other drivers, that's not so great.

> >  So I would keep the name and structure similar to these:
> > 
> >   advk_pcie_init_msi_irq_domain()
> >   nwl_pcie_init_msi_irq_domain()
> > 
> > BTW, those functions use irq_domain_add_linear(), while you are one of
> > the very few callers of irq_domain_create_linear().  Why the difference?
> > If your code does basically the same thing, it's very helpful to me if
> > it *looks* basically the same.
> 
> It was a suggestion from Marc Z on 2017-03-23.
> 
> <QUOTE>
> + irq_dom = irq_domain_add_linear(NULL, MSI_COUNT, &msi_domain_ops, pcie);
> 
> Use irq_domain_create_linear, pass the same fwnode.
> </QUOTE>
> 
> It seems odd to pass NULL as the first argument.
> (As I had first done, when copying the Altera driver.)

I'm a little queasy about the MSI stuff.  It doesn't feel very settled
yet, and I don't want to keep tweaking it at this stage.

How about we merge the base patch for v4.13 and deal with MSIs for
v4.14?  I need confirmation that the base patch works ASAP.  Or if
it's not really useful by itself, we can defer it all until v4.14.

For v4.14, I'd really like to see some unification of naming and
structure across the drivers in how they handle IRQ domains, and
then have tango follow whatever pattern that ends up being.

Right now we don't have much consistency in the names of legacy and
MSI IRQ domains, what device_node they're associated with, how we
handle the 0-3 vs 1-4 legacy numbering, pci_msi_create_irq_domain()
usage, etc.  Some of this may be dictated by different hardware
requirements, but I doubt all of it is.

Bjorn


P.S. Notes about current IRQ domain usage below, just for reference
about where I'm seeing inconsistencies.

    advk_pcie_probe			# "marvell,armada-3700-pcie"
      advk_pcie_init_irq_domain
        pcie_intc_node =  of_get_next_child(node, NULL)
        irq_domain_add_linear(pcie_intc_node, ...)
      advk_pcie_init_msi_irq_domain
        pcie->msi_inner_domain = irq_domain_add_linear(NULL, ...)
        pcie->msi_domain = pci_msi_create_irq_domain(...)

    altera_pcie_probe			# "altr,pcie-root-port-1.0"
      altera_pcie_init_irq_domain
        pcie->irq_domain = irq_domain_add_linear(node, ...)
    altera_msi_probe			# "altr,msi-1.0"
      altera_allocate_domains
        msi->inner_domain = irq_domain_add_linear(NULL, ...)
        msi->msi_domain = pci_msi_create_irq_domain(fwnode, ...)

    iproc_pcie_pltfm_probe		# "brcm,iproc-pcie", etc
      iproc_pcie_setup
        iproc_pcie_msi_enable
          iproc_msi_init
            iproc_msi_alloc_domains
              msi->inner_domain = irq_domain_add_linear(NULL, ...)
              msi->msi_domain = pci_msi_create_irq_domain(...)

    rcar_pcie_probe			# "renesas,pcie-r8a7779", etc
      rcar_pcie_enable_msi
        msi->domain = irq_domain_add_linear(dev->of_node, ...)

    rockchip_pcie_probe			# "rockchip,rk3399-pcie"
      rockchip_pcie_init_irq_domain
        intc = of_get_next_child(dev->of_node, NULL)
        rockchip->irq_domain = irq_domain_add_linear(intc, ...)
  
    xilinx_pcie_probe			# "xlnx,axi-pcie-host-1.00.a"
      xilinx_pcie_init_irq_domain
        pcie_intc_node = of_get_next_child(node, NULL)
        port->leg_domain = irq_domain_add_linear(pcie_intc_node, ...)
        port->msi_domain = irq_domain_add_linear(node, ...)

    nwl_pcie_probe			# "xlnx,nwl-pcie-2.11"
      nwl_pcie_init_irq_domain
        legacy_intc_node = of_get_next_child(node, NULL)
        pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node, ...)
        nwl_pcie_init_msi_irq_domain
          msi->dev_domain = irq_domain_add_linear(NULL, ...)
          msi->msi_domain = pci_msi_create_irq_domain(fwnode, ...)

    faraday_pci_probe			# "faraday,ftpci100", etc
      faraday_pci_setup_cascaded_irq
        intc = of_get_next_child(p->dev->of_node, NULL)
        p->irqdomain = irq_domain_add_linear(intc, ...)

    hv_pci_probe
      hv_pcie_init_irq_domain
        hbus->irq_domain = pci_msi_create_irq_domain(...)

    tegra_pcie_probe			# "nvidia,tegra210-pcie", etc
      tegra_pcie_enable_msi
        msi->domain = irq_domain_add_linear(dev->of_node, ...)

    xgene_pcie_probe_bridge		# "apm,xgene-pcie"
    xgene_msi_probe			# "apm,xgene1-msi"
      xgene_allocate_domains
        msi->inner_domain = irq_domain_add_linear(NULL, ...)
        msi->msi_domain = pci_msi_create_irq_domain(...)

    vmd_probe				# [8086:201d]
      vmd_enable_domain
        vmd->irq_domain = pci_msi_create_irq_domain(NULL, ...)

    dra7xx_pcie_probe			# "ti,dra7-pcie", etc
      dra7xx_add_pcie_port
        dra7xx_pcie_init_irq_domain
          pcie_intc_node =  of_get_next_child(node, NULL)
          dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, ...)

    dw_pcie_host_init
      pp->ops->msi_host_init
        ks_dw_pcie_msi_host_init	# .msi_host_init
          pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np, ...)

    ks_pcie_probe			# "ti,keystone-pcie"
      ks_add_pcie_port
        ks_dw_pcie_host_init
          ks_pcie->legacy_irq_domain = irq_domain_add_linear(ks_pcie->legacy_intc_np, ...)

    *_add_pcie_port
      dw_pcie_host_init
        pp->irq_domain = irq_domain_add_linear(dev->of_node, ...) # generic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
