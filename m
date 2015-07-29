Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKc0Boc4oRY0wnH0Hb4pEd6U=2i+46A8Yj68sM0btshHQ@mail.gmail.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-4-git-send-email-lftan@altera.com>
	<CAL_JsqKc0Boc4oRY0wnH0Hb4pEd6U=2i+46A8Yj68sM0btshHQ@mail.gmail.com>
Date: Wed, 29 Jul 2015 19:08:16 +0800
Message-ID: <CAFiDJ59+ysG0Cm5p987+CQ3is-Yzvu7F+9r28J4NdJDD=RVPcg@mail.gmail.com>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 11:43 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 5:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> This patch adds the Altera PCIe host controller driver.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>

>> +
>> +static int altera_pcie_setup(int nr, struct pci_sys_data *sys)
>> +{
>> +       struct altera_pcie *pcie = sys->private_data;
>> +
>> +       list_splice_init(&pcie->resources, &sys->resources);
>> +
>> +       return 1;
>> +}
>> +
>> +static int altera_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>> +{
>> +       struct altera_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
>> +       int irq;
>> +
>> +       irq = of_irq_parse_and_map_pci(pdev, slot, pin);
>> +
>> +       if (!irq)
>> +               irq = pcie->hwirq;
>> +
>> +       return irq;
>> +}
>
> This should not be needed as the core code should take care of this.
Okay.

>
>> +
>> +static struct pci_bus *altera_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>> +{
>> +       struct altera_pcie *pcie = sys_to_pcie(sys);
>> +       struct pci_bus *bus;
>> +
>> +       pcie->root_bus_nr = sys->busnr;
>> +       bus = pci_scan_root_bus(&pcie->pdev->dev, sys->busnr, &altera_pcie_ops,
>> +                               sys, &sys->resources);
>> +
>> +       return bus;
>> +}
>> +
>> +static struct hw_pci altera_pcie_hw __initdata = {
>> +#ifdef CONFIG_PCI_DOMAINS
>> +       .domain                 = 0,
>> +#endif
>> +       .nr_controllers         = 1,
>> +       .ops                    = &altera_pcie_ops,
>> +       .setup                  = altera_pcie_setup,
>> +       .map_irq                        = altera_pcie_map_irq,
>> +       .scan                   = altera_pcie_scan_bus,
>
> You should be able to only have an empty hw_pci struct now.
Will remove this.

>> +static void altera_pcie_free_irq_domain(struct altera_pcie *pcie)
>> +{
>> +       int i;
>> +       u32 irq;
>> +
>> +       for (i = 0; i < INTX_NUM; i++) {
>> +               irq = irq_find_mapping(pcie->irq_domain, i);
>> +               if (irq > 0)
>> +                       irq_dispose_mapping(irq);
>> +       }
>> +
>> +       irq_domain_remove(pcie->irq_domain);
>> +}
>> +
>> +static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>> +{
>> +       struct device *dev = &pcie->pdev->dev;
>> +       struct device_node *node = dev->of_node;
>> +
>> +       /* Setup INTx */
>> +       pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
>> +                                       &intx_domain_ops, pcie);
>> +       if (!pcie->irq_domain) {
>> +               dev_err(dev, "Failed to get a INTx IRQ domain\n");
>> +               return PTR_ERR(pcie->irq_domain);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>> +{
>> +       struct resource *cra;
>> +       int ret;
>> +       struct platform_device *pdev = pcie->pdev;
>> +
>> +       cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
>> +       pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
>> +       if (IS_ERR(pcie->cra_base)) {
>> +               dev_err(&pdev->dev, "get Cra resource failed\n");
>> +               return PTR_ERR(pcie->cra_base);
>> +       }
>> +
>> +       /* setup IRQ */
>> +       pcie->hwirq = platform_get_irq(pdev, 0);
>> +       if (pcie->hwirq <= 0) {
>> +               dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->hwirq);
>> +               return -EINVAL;
>> +       }
>> +       ret = devm_request_irq(&pdev->dev, pcie->hwirq, altera_pcie_isr,
>> +                       IRQF_SHARED, pdev->name, pcie);
>> +
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to request irq %d\n", pcie->hwirq);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int altera_pcie_probe(struct platform_device *pdev)
>> +{
>> +       struct altera_pcie *pcie;
>> +       int ret;
>> +
>> +       pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>> +       if (!pcie)
>> +               return -ENOMEM;
>> +
>> +       pcie->pdev = pdev;
>> +
>> +       ret = altera_pcie_parse_dt(pcie);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Parsing DT failed\n");
>> +               return ret;
>> +       }
>> +
>> +       INIT_LIST_HEAD(&pcie->resources);
>> +
>> +       ret = altera_pcie_parse_request_of_pci_ranges(pcie);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed add resources\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = altera_pcie_init_irq_domain(pcie);
>
> I don't think you need an irq domain here.
The controller have one single interrupt  for INTx. So, we need IRQ
domain for map and decode
the 4 INTx interrupt and route them to this domain.

>
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
>> +               return ret;
>> +       }
>> +
>> +       pcie->root_bus_nr = -1;
>> +
>> +       /* clear all interrupts */
>> +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
>> +       /* enable all interrupts */
>> +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>> +
>> +       altera_pcie_hw.private_data = (void **)&pcie;
>> +
>> +       pci_common_init_dev(&pdev->dev, &altera_pcie_hw);
>
> You should not call this, but call pci_scan_root_bus directly. See
> pci-host-generic.c or pci-versatile.c for examples.
Okay, will change to pci_scan_root_bus.

Thanks.

Regards
Ley Foon
