Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeABMBf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 07:01:35 -0500
Date: Tue, 2 Jan 2018 12:02:28 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, robh@kernel.org,
        devicetree@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Subject: Re: [PATCH v5 3/3] PCI: mobiveil: Add MSI support for Mobiveil PCIe
 Host
Message-ID: <20180102120228.GD10536@red-moon>
References: <1513181336-19955-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <23b886bf-b21e-8e8c-460c-42316469f989@arm.com>
 <CAFZiPx3G=khQJqAPs=qnx=bya_MQLfOSPaK3ckNsUq=U2EQGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx3G=khQJqAPs=qnx=bya_MQLfOSPaK3ckNsUq=U2EQGYw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 22, 2017 at 02:27:54PM +0530, Subrahmanya Lingappa wrote:

[...]

> > >  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> > >  {
> > >       u32 value;
> > > @@ -465,7 +559,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> > >               (1 << PEX_PIO_ENABLE_SHIFT),
> > >               PAB_CTRL);
> > >
> > > -     csr_writel(pcie, PAB_INTP_INTX_MASK, PAB_INTP_AMBA_MISC_ENB);
> > > +     csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> > > +             PAB_INTP_AMBA_MISC_ENB);
> > >
> > >       /* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
> > >        * PAB_AXI_PIO_CTRL Register
> > > @@ -503,6 +598,10 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> > >               }
> > >       }
> > >
> > > +     /* setup MSI hardware registers */
> > > +     if (IS_ENABLED(CONFIG_PCI_MSI))
> >
> > Your driver already depends on PCI_MSI_IRQ_DOMAIN, which depends on
> > PCI_MSI. So this IS_ENABLED() is pointless.
> >
> as Lorenzo pointed out on the other thread, I will take out
> PCI_MSI_IRQ_DOMAIN dependency.

I said that the PCI_MSI_IRQ_DOMAIN dependency was not needed in the
patch I was commenting on - not that it was not needed at all.

Thanks,
Lorenzo

> So looks like better to follow other tested drivers and continue to keep it no ?
> 
> >
> > > +             mobiveil_pcie_enable_msi(pcie);
> > > +
> > >       return err;
> > >  }
> > >
> > > @@ -520,6 +619,118 @@ static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> > >       .map = mobiveil_pcie_intx_map,
> > >  };
> > >
> > > +static struct irq_chip mobiveil_msi_irq_chip = {
> > > +     .name = "Mobiveil PCIe MSI",
> > > +     .irq_mask = pci_msi_mask_irq,
> > > +     .irq_unmask = pci_msi_unmask_irq,
> > > +};
> > > +
> > > +static struct msi_domain_info mobiveil_msi_domain_info = {
> > > +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > > +                  MSI_FLAG_PCI_MSIX),
> > > +     .chip   = &mobiveil_msi_irq_chip,
> > > +};
> > > +
> > > +static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > > +{
> > > +     struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
> > > +     phys_addr_t addr = virt_to_phys((void *)pcie->msi.msi_pages +
> > > +                             (data->hwirq * sizeof(int)));
> > > +
> > > +     msg->address_lo = lower_32_bits(addr);
> > > +     msg->address_hi = upper_32_bits(addr);
> > > +     msg->data = data->hwirq;
> > > +
> > > +     dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
> > > +             (int)data->hwirq, msg->address_hi, msg->address_lo);
> > > +}
> > > +
> > > +static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
> > > +             const struct cpumask *mask, bool force)
> > > +{
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static struct irq_chip mobiveil_msi_bottom_irq_chip = {
> > > +     .name                   = "Mobiveil MSI",
> > > +     .irq_compose_msi_msg    = mobiveil_compose_msi_msg,
> > > +     .irq_set_affinity       = mobiveil_msi_set_affinity,
> > > +};
> > > +
> > > +static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
> > > +             unsigned int virq, unsigned int nr_irqs, void *args)
> > > +{
> > > +     struct mobiveil_pcie *pcie = domain->host_data;
> > > +     struct mobiveil_msi *msi = &pcie->msi;
> > > +     unsigned long bit;
> > > +
> > > +     WARN_ON(nr_irqs != 1);
> > > +     mutex_lock(&msi->lock);
> > > +
> > > +     bit = find_first_zero_bit(msi->msi_irq_in_use, msi->num_of_vectors);
> > > +     if (bit >= msi->num_of_vectors) {
> > > +             mutex_unlock(&msi->lock);
> > > +             return -ENOSPC;
> > > +     }
> > > +
> > > +     set_bit(bit, msi->msi_irq_in_use);
> > > +
> > > +     mutex_unlock(&msi->lock);
> > > +
> > > +     irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
> > > +                         domain->host_data, handle_simple_irq,
> > > +                         NULL, NULL);
> > > +     return 0;
> > > +}
> > > +
> > > +static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
> > > +             unsigned int virq, unsigned int nr_irqs)
> > > +{
> > > +     struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> > > +     struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
> > > +     struct mobiveil_msi *msi = &pcie->msi;
> > > +
> > > +     mutex_lock(&msi->lock);
> > > +
> > > +     if (!test_bit(d->hwirq, msi->msi_irq_in_use)) {
> > > +             dev_err(&pcie->pdev->dev, "trying to free unused MSI#%lu\n",
> > > +                     d->hwirq);
> > > +     } else {
> > > +             __clear_bit(d->hwirq, msi->msi_irq_in_use);
> > > +     }
> > > +
> > > +     mutex_unlock(&msi->lock);
> > > +}
> > > +
> > > +static const struct irq_domain_ops msi_domain_ops = {
> > > +     .alloc  = mobiveil_irq_msi_domain_alloc,
> > > +     .free   = mobiveil_irq_msi_domain_free,
> > > +};
> > > +
> > > +static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
> > > +{
> > > +     struct device *dev = &pcie->pdev->dev;
> > > +     struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > > +     struct mobiveil_msi *msi = &pcie->msi;
> > > +
> > > +     mutex_init(&pcie->msi.lock);
> > > +     msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
> > > +                                          &msi_domain_ops, pcie);
> > > +     if (!msi->dev_domain) {
> > > +             dev_err(dev, "failed to create IRQ domain\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> > > +                             &mobiveil_msi_domain_info, msi->dev_domain);
> > > +     if (!msi->msi_domain) {
> > > +             dev_err(dev, "failed to create MSI domain\n");
> > > +             irq_domain_remove(msi->dev_domain);
> > > +             return -ENOMEM;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> > >  {
> > >       struct device *dev = &pcie->pdev->dev;
> > > @@ -535,6 +746,13 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> > >               return -ENODEV;
> > >       }
> > >
> > > +#ifdef CONFIG_PCI_MSI
> >
> > Useless #ifdef
> >
> > > +     /* setup MSI */
> > > +     ret = mobiveil_allocate_msi_domains(pcie);
> > > +     if (ret)
> > > +             return ret;
> > > +#endif
> > > +
> > >       return 0;
> > >  }
> > >
> > >
> >
> > Now, there is something that I find a bit annoying: This code looks very
> > similar to drivers/pci/host/pcie-altera-msi.c, to the extent that I
> > suspect this is the same IP.
> >
> Its a different IP.
> 
> >
> > I suggest you investigate whether you can reuse the existing code
> > instead of adding yet another MSI driver to the kernel.
> >
> > Thanks,
> >
> >         M.
> > --
> > Jazz is not dead. It just smells funny...
> 
> 
> Thanks,
> Subrahmanya
