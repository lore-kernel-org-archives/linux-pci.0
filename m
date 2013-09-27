Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:44596
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109Ab3I0Bio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Sep 2013 21:38:44 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>, Sean Cross <xobs@kosagi.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Fri, 27 Sep 2013 01:38:39 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D3F7E6A@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU32oMZq=jrSCpk_ZjYc08kRBAqhOS8uYfor28gY8WGhnw@mail.gmail.com>
In-Reply-To: <CAJ+vNU32oMZq=jrSCpk_ZjYc08kRBAqhOS8uYfor28gY8WGhnw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim:
Thanks for your tests.
Yes, it is. There are some problems when the PCIe switch is used on the 3.1x kernel at my side too, although the PCIe switch
is ok on FSL imx_3.0.35 kernels.
I'm debugging this issue now, and would summit the patches asap.

Best Regards
Richard Zhu


-----Original Message-----
From: Tim Harvey [mailto:tharvey@gateworks.com] 
Sent: Thursday, September 26, 2013 1:54 PM
To: Sean Cross
Cc: devicetree@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sascha Hauer; Zhu Richard-R65037; Shawn Guo; bhelgaas@google.com
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller

> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig index 
> 3d95048..efa24d9 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -15,6 +15,12 @@ config PCI_EXYNOS
>         select PCIEPORTBUS
>         select PCIE_DW
>
> +config PCI_IMX6
> +       bool "Freescale i.MX6 PCIe controller"
> +       depends on SOC_IMX6Q
> +       select PCIEPORTBUS

What is PCIEPORTBUS really for?  When I enable this with a PCIe switch off the root complex I get invalid IRQ messages during enumeration of ports on the switch:

[    6.572410] PCI: Device 0000:00:00.0 not available because of
resource collisi
[    6.572433] pcieport: probe of 0000:00:00.0 failed with error -22
[    6.572489] pcieport 0000:01:00.0: device [10b5:8609] has invalid
IRQ; check vendor BIOS             [    6.572536] pcieport: probe of
0000:01:00.0 failed with error -22
[    6.572593] pcieport 0000:02:01.0: device [10b5:8609] has invalid
IRQ; check vendor BIOS
[    6.572621] PCI: enabling device 0000:02:01.0 (0140 -> 0143)
[    6.572672] pcieport 0000:02:01.0: enabling bus mastering
[    6.573045] pcieport 0000:02:04.0: device [10b5:8609] has invalid
IRQ; check vendor BIOS
if I remove PCIEPORTBUS these go away however cards behind the switch don't operate correctly (I believe the interrupts do not get mapped properly).  Is there some logic perhaps missing in the driver required for PCIe switches?

> +
> +/*  Added for PCI abort handling */
> +static int imx6q_pcie_abort_handler(unsigned long addr,
> +               unsigned int fsr, struct pt_regs *regs) {
> +       /*
> +        * If it was an imprecise abort, then we need to correct the
> +        * return address to be _after_ the instruction.
> +        */
> +       if (fsr & (1 << 10))
> +               regs->ARM_pc += 4;
> +       return 0;
> +}
> +

you added this per my request but after more testing I'm not sure now it should be needed.  On the i.MX6, imprecise aborts will occur when an un-populated device behind a bridge is accessed.  However somewhere a few kernels back (3.9 I believe) this behavior changed such that the aborts were not enabled/checked until the kernel completed init.
Therefore with the current kernel any un-populated device will cause a single imprecise abort to be caught at the end of init and as such it should be ignored 'without touching the PC'.  I'm not clear if this should happen - whatever enables the catching of the abort should perhaps clear any pending flags I would think.  I'm also not clear if an abort handler should really be required as the current kernel has a default handler that results in:
...
Freeing unused kernel memory: 6600K (80817000 - 80e89000) Unhandled fault: imprecise external abort (0x1406) at 0xca8c0d71 ...

Do we hook a handler that does nothing but 'return 0' just to eliminate the Unhandled fault message?

> +static void imx6_pcie_host_init(struct pcie_port *pp) {
> +       int count = 0;
> +       struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +
> +       imx6_pcie_assert_core_reset(pp);
> +
> +       imx6_pcie_init_phy(pp);
> +
> +       imx6_pcie_deassert_core_reset(pp);
> +
> +       dw_pcie_setup_rc(pp);
> +
> +       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +                       IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> +
> +       while (!dw_pcie_link_up(pp)) {
> +               usleep_range(100, 1000);

I've found that I needed to increase this delay in order for a link detect with a PLX PEX8609 switch off the root complex.  A usleep_range(2000, 3000) worked in my testing.

> +static int imx6_pcie_link_up(struct pcie_port *pp) {
> +       u32 rc, ltssm, rx_valid, temp;
> +
> +       /* link is debug bit 36, debug register 1 starts at bit 32 */
> +       rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
> +       if (rc)
> +               return -EAGAIN;

I'm still having trouble accessing devices behind a PCIe switch in 3.12-rc2.  Device enumeration goes fine however after kernel init it seems that any access to a switch port fails the check for link in dw_pcie_valid_config which calls imx6_pcie_link_up here.  I'm wondering if this is some ASPM issue (I've tried both with that enabled and disabled).  When I backport this driver to 3.11 I do not see this behavior and can access config space of all devices behind the bridge within userspace.  Any ideas here?

Tim

>
> +
> +       /*
> +        * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> +        * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
> +        * If (MAC/LTSSM.state == Recovery.RcvrLock)
> +        * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
> +        * to gen2 is stuck
> +        */
> +       pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
> +       ltssm = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0) & 0x3F;
> +
> +       if (rx_valid & 0x01)
> +               return 0;
> +
> +       if (ltssm != 0x0d)
> +               return 0;
> +
> +       dev_err(pp->dev,
> +               "transition to gen2 is stuck, reset PHY!\n");
> +
> +       pcie_phy_read(pp->dbi_base,
> +               PHY_RX_OVRD_IN_LO, &temp);
> +       temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN
> +               | PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +       pcie_phy_write(pp->dbi_base,
> +               PHY_RX_OVRD_IN_LO, temp);
> +
> +       usleep_range(2000, 3000);
> +
> +       pcie_phy_read(pp->dbi_base,
> +               PHY_RX_OVRD_IN_LO, &temp);
> +       temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN
> +               | PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +       pcie_phy_write(pp->dbi_base,
> +               PHY_RX_OVRD_IN_LO, temp);
> +
> +       return 0;
> +}
> +
> +static struct pcie_host_ops imx6_pcie_host_ops = {
> +       .link_up = imx6_pcie_link_up,
> +       .host_init = imx6_pcie_host_init, };
> +
> +static int imx6_add_pcie_port(struct pcie_port *pp,
> +                       struct platform_device *pdev) {
> +       int ret;
> +
> +       pp->irq = platform_get_irq(pdev, 0);
> +       if (!pp->irq) {
> +               dev_err(&pdev->dev, "failed to get irq\n");
> +               return -ENODEV;
> +       }
> +
> +       pp->root_bus_nr = -1;
> +       pp->ops = &imx6_pcie_host_ops;
> +
> +       spin_lock_init(&pp->conf_lock);
> +       ret = dw_pcie_host_init(pp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to initialize host\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int __init imx6_pcie_probe(struct platform_device *pdev) {
> +       struct imx6_pcie *imx6_pcie;
> +       struct pcie_port *pp;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *dbi_base;
> +       int ret;
> +
> +       imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
> +       if (!imx6_pcie)
> +               return -ENOMEM;
> +
> +       pp = &imx6_pcie->pp;
> +       pp->dev = &pdev->dev;
> +
> +       /* Added for PCI abort handling */
> +       hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> +               "imprecise external abort");
> +
> +       dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!dbi_base) {
> +               dev_err(&pdev->dev, "dbi_base memory resource not found\n");
> +               return -ENODEV;
> +       }
> +
> +       pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> +       if (IS_ERR(pp->dbi_base)) {
> +               dev_err(&pdev->dev, "unable to remap dbi_base\n");
> +               ret = PTR_ERR(pp->dbi_base);
> +               goto err;
> +       }
> +
> +       /* Fetch GPIOs */
> +       imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +       if (!gpio_is_valid(imx6_pcie->reset_gpio)) {
> +               dev_err(&pdev->dev, "no reset-gpio defined\n");
> +               ret = -ENODEV;
> +       }
> +       ret = devm_gpio_request_one(&pdev->dev,
> +                               imx6_pcie->reset_gpio,
> +                               GPIOF_OUT_INIT_LOW,
> +                               "PCIe reset");
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to get reset gpio\n");
> +               goto err;
> +       }
> +
> +       imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
> +       if (gpio_is_valid(imx6_pcie->power_on_gpio)) {
> +               ret = devm_gpio_request_one(&pdev->dev,
> +                                       imx6_pcie->power_on_gpio,
> +                                       GPIOF_OUT_INIT_LOW,
> +                                       "PCIe power enable");
> +               if (ret) {
> +                       dev_err(&pdev->dev, "unable to get power-on gpio\n");
> +                       goto err;
> +               }
> +       }
> +
> +       imx6_pcie->wake_up_gpio = of_get_named_gpio(np, "wake-up-gpio", 0);
> +       if (gpio_is_valid(imx6_pcie->wake_up_gpio)) {
> +               ret = devm_gpio_request_one(&pdev->dev,
> +                                       imx6_pcie->wake_up_gpio,
> +                                       GPIOF_IN,
> +                                       "PCIe wake up");
> +               if (ret) {
> +                       dev_err(&pdev->dev, "unable to get wake-up gpio\n");
> +                       goto err;
> +               }
> +       }
> +
> +       imx6_pcie->disable_gpio = of_get_named_gpio(np, "disable-gpio", 0);
> +       if (gpio_is_valid(imx6_pcie->disable_gpio)) {
> +               ret = devm_gpio_request_one(&pdev->dev,
> +                                       imx6_pcie->disable_gpio,
> +                                       GPIOF_OUT_INIT_HIGH,
> +                                       "PCIe disable endpoint");
> +               if (ret) {
> +                       dev_err(&pdev->dev, "unable to get disable-ep gpio\n");
> +                       goto err;
> +               }
> +       }
> +
> +       /* Fetch clocks */
> +       imx6_pcie->lvds_gate = clk_get(&pdev->dev, "lvds_gate");
> +       if (IS_ERR(imx6_pcie->lvds_gate)) {
> +               dev_err(&pdev->dev,
> +                       "lvds_gate clock select missing or invalid\n");
> +               ret = PTR_ERR(imx6_pcie->lvds_gate);
> +               goto err;
> +       }
> +
> +       imx6_pcie->sata_ref_100m = clk_get(&pdev->dev, "sata_ref_100m");
> +       if (IS_ERR(imx6_pcie->sata_ref_100m)) {
> +               dev_err(&pdev->dev,
> +                       "sata_ref_100m clock source missing or invalid\n");
> +               ret = PTR_ERR(imx6_pcie->sata_ref_100m);
> +               goto err;
> +       }
> +
> +       imx6_pcie->pcie_ref_125m = clk_get(&pdev->dev, "pcie_ref_125m");
> +       if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
> +               dev_err(&pdev->dev,
> +                       "pcie_ref_125m clock source missing or invalid\n");
> +               ret = PTR_ERR(imx6_pcie->pcie_ref_125m);
> +               goto err;
> +       }
> +
> +       imx6_pcie->pcie_axi = clk_get(&pdev->dev, "pcie_axi");
> +       if (IS_ERR(imx6_pcie->pcie_axi)) {
> +               dev_err(&pdev->dev,
> +                       "pcie_axi clock source missing or invalid\n");
> +               ret = PTR_ERR(imx6_pcie->pcie_axi);
> +               goto err;
> +       }
> +
> +       /* Grab GPR config register range */
> +       imx6_pcie->iomuxc_gpr =
> +                syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +       if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> +               dev_err(&pdev->dev, "unable to find iomuxc registers\n");
> +               ret = PTR_ERR(imx6_pcie->iomuxc_gpr);
> +               goto err;
> +       }
> +
> +       ret = imx6_add_pcie_port(pp, pdev);
> +       if (ret < 0)
> +               goto err;
> +
> +       platform_set_drvdata(pdev, imx6_pcie);
> +       return 0;
> +
> +err:
> +       return ret;
> +}
> +
> +static const struct of_device_id imx6_pcie_of_match[] = {
> +       { .compatible = "fsl,imx6q-pcie", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
> +
> +static struct platform_driver imx6_pcie_driver = {
> +       .driver = {
> +               .name   = "imx6q-pcie",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(imx6_pcie_of_match),
> +       },
> +};
> +
> +/* Freescale PCIe driver does not allow module unload */
> +
> +static int __init imx6_init(void)
> +{
> +       return platform_driver_probe(&imx6_pcie_driver, 
> +imx6_pcie_probe); } module_init(imx6_init);
> +
> +MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>"); 
> +MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver"); 
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>


