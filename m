Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Wed, 8 Jun 2016 17:15:08 +0200
Message-ID: <CAPv3WKcznGD4p-YO3QLLYw+y+7w4ha-d_Nt6FHue7d2_SiyK0w@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: host: new PCI host controller driver for Marvell
 Armada 3700
From: Marcin Wojtas <mw@semihalf.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Hanna Hawa <hannah@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,


> +static const struct irq_domain_ops advk_pcie_msi_irq_ops = {
> +       .map = advk_pcie_msi_map,
> +};
> +
> +static void advk_pcie_irq_mask(struct irq_data *d)
> +{
> +       struct advk_pcie *pcie = d->domain->host_data;
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       u32 mask;
> +
> +       mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> +       mask |= PCIE_ISR0_INTX_ASSERT(hwirq) |
> +               PCIE_ISR0_INTX_DEASSERT(hwirq);
> +       advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
> +}
> +
> +static void advk_pcie_irq_unmask(struct irq_data *d)
> +{
> +       struct advk_pcie *pcie = d->domain->host_data;
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       u32 mask;
> +
> +       mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> +       mask &= ~(PCIE_ISR0_INTX_ASSERT(hwirq) |
> +                 PCIE_ISR0_INTX_DEASSERT(hwirq));

Have you checked my latest improvements of interrupt handling in this
controller? As DEASSERT is polled in advk_pcie_handle_int() I don't
think it should be able to trigger root complex interrupt at all.
Hence I think it shouldn't be unmasked.

> +       advk_writel(pcie, mask, PCIE_ISR0_MASK_REG);
> +}
> +
> +static int advk_pcie_irq_map(struct irq_domain *h,
> +                            unsigned int virq, irq_hw_number_t hwirq)
> +{
> +       struct advk_pcie *pcie = h->host_data;
> +
> +       advk_pcie_irq_mask(irq_get_irq_data(virq));
> +       irq_set_status_flags(virq, IRQ_LEVEL);
> +       irq_set_chip_and_handler(virq, &pcie->irq_chip,
> +                                handle_level_irq);
> +       irq_set_chip_data(virq, pcie);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops advk_pcie_irq_domain_ops = {
> +       .map = advk_pcie_irq_map,
> +       .xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int advk_pcie_init_irq(struct advk_pcie *pcie)
> +{
> +       struct device *dev = &pcie->pdev->dev;
> +       struct device_node *node = dev->of_node;
> +       struct device_node *pcie_intc_node;
> +       struct irq_chip *irq_chip, *msi_irq_chip;
> +       struct msi_controller *msi;
> +       phys_addr_t msi_msg_phys;
> +
> +       pcie_intc_node =  of_get_next_child(node, NULL);
> +       if (!pcie_intc_node) {
> +               dev_err(dev, "No PCIe Intc node found\n");
> +               return PTR_ERR(pcie_intc_node);
> +       }
> +
> +       irq_chip = &pcie->irq_chip;
> +
> +       irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
> +                                       dev_name(dev));
> +       if (!irq_chip->name)
> +               return -ENOMEM;
> +       irq_chip->irq_mask = advk_pcie_irq_mask;
> +       irq_chip->irq_mask_ack = advk_pcie_irq_mask;
> +       irq_chip->irq_unmask = advk_pcie_irq_unmask;
> +
> +       pcie->irq_domain =
> +               irq_domain_add_linear(pcie_intc_node, LEGACY_IRQ_NUM,
> +                                     &advk_pcie_irq_domain_ops, pcie);
> +       if (!pcie->irq_domain) {
> +               dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +               return PTR_ERR(pcie->irq_domain);
> +       }
> +
> +       msi_irq_chip = &pcie->msi_irq_chip;
> +
> +       msi_irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-msi",
> +                                                dev_name(dev));
> +       if (!msi_irq_chip->name) {
> +               irq_domain_remove(pcie->irq_domain);
> +               return -ENOMEM;
> +       }
> +
> +       msi_irq_chip->irq_enable = pci_msi_unmask_irq;
> +       msi_irq_chip->irq_disable = pci_msi_mask_irq;
> +       msi_irq_chip->irq_mask = pci_msi_mask_irq;
> +       msi_irq_chip->irq_unmask = pci_msi_unmask_irq;
> +
> +       msi = &pcie->msi;

Do we consciously resign from CONFIG_MSI dependency? I know it should
always be enabled, but just making sure.

> +
> +       msi->setup_irq = advk_pcie_setup_msi_irq;
> +       msi->teardown_irq = advk_pcie_teardown_msi_irq;
> +       msi->of_node = node;
> +
> +       mutex_init(&pcie->msi_used_lock);
> +
> +       msi_msg_phys = virt_to_phys(&pcie->msi_msg);
> +
> +       advk_writel(pcie, lower_32_bits(msi_msg_phys),
> +                   PCIE_MSI_ADDR_LOW_REG);
> +       advk_writel(pcie, upper_32_bits(msi_msg_phys),
> +                   PCIE_MSI_ADDR_HIGH_REG);
> +
> +       pcie->msi_domain =
> +               irq_domain_add_linear(NULL, MSI_IRQ_NUM,
> +                                     &advk_pcie_msi_irq_ops, pcie);
> +       if (!pcie->msi_domain) {
> +               irq_domain_remove(pcie->irq_domain);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void advk_pcie_handle_msi(struct advk_pcie *pcie)
> +{
> +       u32 msi_val, msi_mask, msi_status, msi_idx;
> +       u16 msi_data;
> +
> +       msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
> +       msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> +       msi_status = msi_val & ~msi_mask;
> +
> +       for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
> +               if (!(BIT(msi_idx) & msi_status))
> +                       continue;
> +
> +               advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
> +               msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
> +               generic_handle_irq(msi_data);
> +       }
> +
> +       advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
> +                   PCIE_ISR0_REG);
> +}
> +
> +static void advk_pcie_handle_int(struct advk_pcie *pcie)
> +{
> +       u32 val, mask, status;
> +
> +       val = advk_readl(pcie, PCIE_ISR0_REG);
> +       mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> +       status = val & ((~mask) & PCIE_ISR0_ALL_MASK);
> +
> +       if (!status) {
> +               advk_writel(pcie, val, PCIE_ISR0_REG);
> +               return;
> +       }
> +
> +       /* Process MSI interrupts */
> +       if (status & PCIE_ISR0_MSI_INT_PENDING)
> +               advk_pcie_handle_msi(pcie);
> +
> +       /* Process legacy interrupts */
> +       do {
> +               int i;
> +
> +               /*
> +                * As documented in the datasheet, we need to raise an
> +                * interrupt for each ASSERT(i) bit that is set, and
> +                * continue to deliver the interrupt until the
> +                * DEASSERT(i) bit gets set
> +                */

Below code will result in spurious interrupt flood (I can provide test
details with SATA3.0 card). I know this part of specs very well, but
expected EP operation flow should look like this:
a. EP interrupt
b. INTX_ASSERT signal
c. root complex interrupt
d. clear INTX_ASSERT bit
e. execute EP handler
f. INTX_DEASSERT signal
g. clear INTX_DEASSERT bit
h. exit interrupt

Now between d. and f., in case of any shortest delay we will force
executing EP handler numerous of times, which IMO is not desired. All
of them for e.g. the SATA3.0 card are registered as spurious
interrupts, pretty quickly resulting in "switching to irq poll"
failure after 100k of such happenings. Actually I think that after
executing generic_handle_irq(virq); we should leave root complex isr
asap, the polling for DEASSERT in such case is not resulting in any
benefits. In my code I ignored DEASSERT signal existence - it neither
triggers interrupt nor we don't poll for it. Under big stress nothing
wrong happens. We rely only on interrupts triggered by INTX_ASSERT
signal, so we care only for its status.

> +               for (i = 0; i < LEGACY_IRQ_NUM; i++) {
> +                       if (!(status & PCIE_ISR0_INTX_ASSERT(i)))
> +                               continue;
> +
> +                       do {
> +                               int virq;
> +
> +                               advk_writel(pcie, PCIE_ISR0_INTX_ASSERT(i),
> +                                           PCIE_ISR0_REG);
> +                               virq = irq_find_mapping(pcie->irq_domain, i);
> +                               generic_handle_irq(virq);
> +                               status = advk_readl(pcie, PCIE_ISR0_REG);
> +                       } while (!(status & PCIE_ISR0_INTX_DEASSERT(i)));
> +
> +                       advk_writel(pcie, PCIE_ISR0_INTX_DEASSERT(i),
> +                                   PCIE_ISR0_REG);
> +               }
> +
> +               status = advk_readl(pcie, PCIE_ISR0_REG);
> +       } while (status & PCIE_ISR0_INTX_MASK);

How about simplifying code a bit and remove this do-while loop? IMO
it's enough to do single iterating through INTA/B/C/D and exit - in
such case we wouldn't spent too much time in single top half handler.

I'm looking forward to your feedback.

Best regards,
Marcin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
