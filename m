Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1530148652.28284.4.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] PCI: mediatek: Add loadable kernel module support
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Jun 2018 09:17:32 +0800
In-Reply-To: <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree <devicetree@vger.kernel.org>,
 hongkun.cao@mediatek.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 YT Shen <yt.shen@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, ryder.lee@mediatek.com,
 "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, yong.wu@mediatek.com,
 Bjorn Helgaas <bhelgaas@google.com>, yingjoe.chen@mediatek.com,
 Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-06-27 at 19:39 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > Implement remove callback function for Mediatek PCIe driver to add
> > loadable kernel module support.
> 
> > +static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
> > +{
> > +       struct mtk_pcie_port *port, *tmp;
> > +
> 
> > +       if (list_empty(&pcie->ports))
> > +               return;
> 
> This is redundant.

Yeah, you are right, I will remove it.

> 
> > +
> > +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > +               irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> > +
> > +               if (port->irq_domain)
> > +                       irq_domain_remove(port->irq_domain);
> > +
> > +               if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +                       if (port->msi_domain)
> > +                               irq_domain_remove(port->msi_domain);
> > +                       if (port->inner_domain)
> > +                               irq_domain_remove(port->inner_domain);
> > +               }
> > +
> > +               irq_dispose_mapping(port->irq);
> > +       }
> > +}
> 
> > +static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
> > +{
> > +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > +       struct list_head *windows = &host->windows;
> > +
> > +       pci_unmap_iospace(&pcie->pio);
> > +       pci_free_resource_list(windows);
> > +}
> > +
> > +static int mtk_pcie_remove(struct platform_device *pdev)
> > +{
> > +       struct mtk_pcie *pcie = platform_get_drvdata(pdev);
> > +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > +
> > +       pci_stop_root_bus(host->bus);
> > +       pci_remove_root_bus(host->bus);
> > +       mtk_pcie_free_resources(pcie);
> > +
> > +       mtk_pcie_irq_teardown(pcie);
> > +
> 
> > +       if (!list_empty(&pcie->ports))
> 
> I think this is also not needed. Do you put runtime PM by the way?

Yes, it's could be removed.
the pm was putted in mtk_pcie_put_resources which will call
mtk_pcie_subsys_powerdown, and the pm was putted in that function.

thanks.

> 
> > +               mtk_pcie_put_resources(pcie);
> > +
> > +       return 0;
> > +}
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
