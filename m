Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1530091298-28120-4-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-4-git-send-email-honghui.zhang@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Jun 2018 19:45:36 +0300
Message-ID: <CAHp75VcHgJrujzqstSc4RWpUbjip1vtJu87HN3uTosoLdOiT3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: mediatek: Add system pm support for MT2712 and
 MT7622
To: Honghui Zhang <honghui.zhang@mediatek.com>
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
 YT Shen <yt.shen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 ryder.lee@mediatek.com,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 yong.wu@mediatek.com, Bjorn Helgaas <bhelgaas@google.com>,
 yingjoe.chen@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
>
> The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> suspend, and all the internal control register will be reset after system
> resume. The PCIe link should be re-established and the related control
> register values should be re-set after system resume.

>  struct mtk_pcie_soc {
>         bool need_fix_class_id;

> +       bool pm_support;

Hmm... Do you really need this flag? Can't runtime PM API tell you this?

>         struct pci_ops *ops;
>         int (*startup)(struct mtk_pcie_port *port);
>         int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -1195,12 +1197,76 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>         return err;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pcie_suspend_noirq(struct device *dev)

Perhaps __maybe_unused?

> +{
> +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +       const struct mtk_pcie_soc *soc = pcie->soc;
> +       struct mtk_pcie_port *port;
> +
> +       if (!soc->pm_support)
> +               return 0;
> +

> +       if (list_empty(&pcie->ports))
> +               return 0;

So, if the list is empty you are not suspending for the host?


> +
> +       list_for_each_entry(port, &pcie->ports, list) {
> +               clk_disable_unprepare(port->pipe_ck);
> +               clk_disable_unprepare(port->obff_ck);
> +               clk_disable_unprepare(port->axi_ck);
> +               clk_disable_unprepare(port->aux_ck);
> +               clk_disable_unprepare(port->ahb_ck);
> +               clk_disable_unprepare(port->sys_ck);
> +               phy_power_off(port->phy);
> +               phy_exit(port->phy);
> +       }
> +
> +       mtk_pcie_subsys_powerdown(pcie);
> +
> +       return 0;
> +}
> +
> +static int mtk_pcie_resume_noirq(struct device *dev)
> +{
> +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +       const struct mtk_pcie_soc *soc = pcie->soc;
> +       struct mtk_pcie_port *port;
> +
> +       if (!soc->pm_support)
> +               return 0;
> +

> +       if (list_empty(&pcie->ports))
> +               return 0;

No runtime PM for this case?
(It seems now I understand why in previous patch you have a similar check)

> +
> +       if (dev->pm_domain) {
> +               pm_runtime_enable(dev);
> +               pm_runtime_get_sync(dev);
> +       }
> +
> +       clk_prepare_enable(pcie->free_ck);
> +
> +       list_for_each_entry(port, &pcie->ports, list)
> +               mtk_pcie_enable_port(port);
> +

> +       if (list_empty(&pcie->ports))

Hmm... How it would be true if you already bailed out above on the
same condition?

> +               mtk_pcie_subsys_powerdown(pcie);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> +                                     mtk_pcie_resume_noirq)
> +};
> +
>  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
>         .ops = &mtk_pcie_ops,
>         .startup = mtk_pcie_startup_port,
>  };
>
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> +       .pm_support = true,
>         .ops = &mtk_pcie_ops_v2,
>         .startup = mtk_pcie_startup_port_v2,
>         .setup_irq = mtk_pcie_setup_irq,

No update for .pm ?

> @@ -1208,6 +1274,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>         .need_fix_class_id = true,
> +       .pm_support = true,
>         .ops = &mtk_pcie_ops_v2,
>         .startup = mtk_pcie_startup_port_v2,
>         .setup_irq = mtk_pcie_setup_irq,
> @@ -1227,6 +1294,7 @@ static struct platform_driver mtk_pcie_driver = {
>                 .name = "mtk-pcie",
>                 .of_match_table = mtk_pcie_ids,
>                 .suppress_bind_attrs = true,
> +               .pm = &mtk_pcie_pm_ops,
>         },
>  };
>  builtin_platform_driver(mtk_pcie_driver);
> --
> 2.6.4
>



-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
