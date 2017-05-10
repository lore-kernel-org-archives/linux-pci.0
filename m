Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34149 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdEJVow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2017 17:44:52 -0400
Received: by mail-wm0-f48.google.com with SMTP id u65so26923657wmu.1
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2017 14:44:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3tHG2c0XJhs3qD0xS4BP==fWEwP6Y78+4WpUmn-KksBg@mail.gmail.com>
References: <20170426181502.770-1-l.stach@pengutronix.de> <CAJ+vNU0AEZtc+DaYSV7S1LtXCncVh9nV4hG7BtYxJE=m6-80EA@mail.gmail.com>
 <1493282584.13947.6.camel@pengutronix.de> <CAJ+vNU3tHG2c0XJhs3qD0xS4BP==fWEwP6Y78+4WpUmn-KksBg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 10 May 2017 14:44:50 -0700
Message-ID: <CAJ+vNU0pcivE53grF6n939gXC0E6-HN4fFJ7Pm9hq3nV1YYSUQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: fall back to legacy IRQs when multiple devices
 are attached
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 27, 2017 at 8:32 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Thu, Apr 27, 2017 at 1:43 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> Am Mittwoch, den 26.04.2017, 14:11 -0700 schrieb Tim Harvey:
>>> On Wed, Apr 26, 2017 at 11:15 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>>> > The DWC host does not support legacy PCI IRQs and MSIs at the same time,
>>> > so we need to fall back to using only legacy IRQs if there is a chance
>>> > that multiple devices with differing MSI capabilities are connected to
>>> > the host. The only configuration where MSIs can be safely used is when
>>> > the device below the host bridge is not a bridge, i.e. the only device
>>> > connected to this host.
>>> >
>>> > By disallowing MSI allocation when multiple devices might be attached
>>> > we get those configurations in a working state. The only configurations
>>> > that depend on MSIs being available, that I am aware of, are some
>>> > embedded devices with a PCIe attached FPGA, that is incapable of
>>> > generating PCI legacy IRQs. Those are kept working by allowing MSIs
>>> > when only a single device is attached to the host.
>>> >
>>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>> > ---
>>> >  drivers/pci/dwc/pcie-designware-host.c | 24 ++++++++++++++++++++++--
>>> >  drivers/pci/dwc/pcie-designware.h      |  1 +
>>> >  2 files changed, 23 insertions(+), 2 deletions(-)
>>> >
>>> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>>> > index 5ba334938b52..be2b2762c944 100644
>>> > --- a/drivers/pci/dwc/pcie-designware-host.c
>>> > +++ b/drivers/pci/dwc/pcie-designware-host.c
>>> > @@ -92,6 +92,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>>> >                             (u32)(msi_target & 0xffffffff));
>>> >         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>>> >                             (u32)(msi_target >> 32 & 0xffffffff));
>>> > +
>>> > +       pp->msi_disabled = false;
>>> >  }
>>> >
>>> >  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
>>> > @@ -136,9 +138,11 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>>> >  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>>> >  {
>>> >         int irq, pos0, i;
>>> > -       struct pcie_port *pp;
>>> > +       struct pcie_port *pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
>>> > +
>>> > +       if (pp->msi_disabled)
>>> > +               return -EINVAL;
>>> >
>>> > -       pp = (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
>>> >         pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>>> >                                        order_base_2(no_irqs));
>>> >         if (pos0 < 0)
>>> > @@ -410,6 +414,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>> >                 goto error;
>>> >         }
>>> >
>>> > +       /*
>>> > +        * The DWC host does not support legacy PCI IRQs and MSIs at the same
>>> > +        * time, so we need to fall back to using only legacy IRQs if there is
>>> > +        * a chance that multiple devices with differing MSI capabilities are
>>> > +        * connected to the host. The only configuration where MSIs can be
>>> > +        * safely used is when the device below the host bridge is not a bridge,
>>> > +        * i.e. the only device connected to this host.
>>> > +        */
>>> > +       child = list_first_entry(&bus->children, struct pci_bus, node);
>>> > +       if (!list_empty(&child->devices)) {
>>> > +               struct pci_dev *dev = list_first_entry(&child->devices,
>>> > +                                                      struct pci_dev, bus_list);
>>> > +               if (pci_is_bridge(dev))
>>> > +                       pp->msi_disabled = true;
>>> > +       }
>>> > +
>>> >         if (pp->ops->scan_bus)
>>> >                 pp->ops->scan_bus(pp);
>>> >
>>> > diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
>>> > index cd3b8713fe50..741bc31f8947 100644
>>> > --- a/drivers/pci/dwc/pcie-designware.h
>>> > +++ b/drivers/pci/dwc/pcie-designware.h
>>> > @@ -140,6 +140,7 @@ struct pcie_port {
>>> >         struct irq_domain       *irq_domain;
>>> >         unsigned long           msi_data;
>>> >         DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>> > +       bool                    msi_disabled;
>>> >  };
>>> >
>>> >  struct dw_pcie_ops {
>>> > --
>>> > 2.11.0
>>> >
>>>
>>> Lucas,
>>>
>>> Legacy interrupts are still not firing with this.
>>
>> Can you provide me the output of "cat /proc/interrupts" and "lspci -t"
>> on your system? I've tested this change on the GW54xx and legacy IRQs
>> seemed to work there.
>>
>
> Lucas,
>
> Right, I should have given you more detail. The legacy interrupts are
> firing for endpoints through a bridge, but not for boards without a
> bridge:
>
> GW54xx + ath9k:
> root@ventana:~# echo $(cat /proc/device-tree/model)
> Gateworks Ventana i.MX6 Dual/Quad GW54XX
> root@ventana:~# cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  16:       4343       1141       2358       1998     GIC-0  29 Edge      twd
>  17:         91         79         76         65       GPC  55 Level
>   i.MX Timer Tick
>  18:      93375          0          0          0       GPC  13 Level     mxs-dma
>  19:      21611          0          0          0       GPC  15 Level     bch
>  20:          0          0          0          0       GPC 115 Level
>   120000.hdmi
>  21:          0          0          0          0       GPC   9 Level
>   130000.gpu
>  22:          0          0          0          0       GPC  10 Level
>   134000.gpu
>  24:          3          0          0          0       GPC 120 Level
>   mx6-pcie-msi, ath9k
> ^^^^ correct legacy irq and its firing (3 interrupts)
>  26:          0          0          0          0       GPC  32 Level
>   200c000.ecspi
>  27:          0          0          0          0       GPC  26 Level
>   2020000.serial
>  28:          0          0          0          0       GPC  46 Level
>   2028000.ssi
>  29:          0          0          0          0       GPC  47 Level
>   202c000.ssi
>  30:          0          0          0          0       GPC  50 Level
>   2034000.asrc
>  31:          0          0          0          0       GPC  12 Level
>   2040000.vpu
>  49:          0          0          0          0       GPC  81 Level
>   20c0000.wdog
>  50:          0          0          0          0       GPC  49 Level
>   imx_thermal
>  55:          0          0          0          0       GPC  19 Level
>   rtc alarm
>  61:          2          0          0          0       GPC   2 Level     sdma
>  62:          0          0          0          0       GPC  43 Level
>   2184000.usb
>  63:         30          0          0          0       GPC  40 Level
>   2184200.usb
>  64:       1699          0          0          0     GIC-0 150 Level
>   2188000.ethernet
>  65:          0          0          0          0     GIC-0 151 Level
>   2188000.ethernet
>  66:          0          0          0          0       GPC  24 Level     mmc0
>  67:         30          0          0          0       GPC  36 Level
>   21a0000.i2c
>  68:         92          0          0          0       GPC  37 Level
>   21a4000.i2c
>  69:        298          0          0          0       GPC  38 Level
>   21a8000.i2c
>  70:          0          0          0          0       GPC  18 Level     vdoa
>  71:        500          0          0          0       GPC  27 Level
>   21e8000.serial
>  72:          0          0          0          0       GPC  30 Level
>   21f4000.serial
>  75:          0          0          0          0       GPC  39 Level
>   ahci-imx[2200000.sata]
>  76:          0          0          0          0       GPC  11 Level
>   2204000.gpu
> 271:          0          0          0          0  gpio-mxc   0 Edge
>   2198000.usdhc cd
> 335:          0          0          0          0       GPC 123 Level
>   PCIe PME, aerdrv
> 338:          0          0          0          0       IPU 457 Edge
>   2400000.ipu
> 339:          0          0          0          0       IPU 451 Edge
>   2400000.ipu
> 340:          0          0          0          0       IPU 457 Edge
>   2800000.ipu
> 341:          0          0          0          0       IPU 451 Edge
>   2800000.ipu
> 342:       1029          1          1          0       IPU  23 Edge      imx_drm
> 343:          0          0          0          0       IPU  28 Edge      imx_drm
> 344:          0          0          0          0       IPU  23 Edge      imx_drm
> 345:          0          0          0          0       IPU  28 Edge      imx_drm
> 346:          2          0          0          0       GPC 105 Level
>   2101000.jr0
> 347:          0          0          0          0       GPC 106 Level
>   2102000.jr1
> IPI0:          0          0          0          0  CPU wakeup interrupts
> IPI1:         25         36         15         22  Timer broadcast interrupts
> IPI2:        862       8482       4490       4783  Rescheduling interrupts
> IPI3:         36         29         41         44  Function call interrupts
> IPI4:          0          0          0          0  CPU stop interrupts
> IPI5:        229        174        430        250  IRQ work interrupts
> IPI6:          0          0          0          0  completion interrupts
> Err:          0
> root@ventana:~# lspci -t
> -[0000:00]---00.0-[01]--+-00.0-[02-09]--+-01.0-[03]--
>                         |               +-04.0-[04]--
>                         |               +-05.0-[05]--
>                         |               +-06.0-[06]--
>                         |               +-07.0-[07]----00.0
>                         |               +-08.0-[08]----00.0
>                         |               \-09.0-[09]--
>                         \-00.1
>
> GW51xx + ath9k (no bridge):
> root@ventana:~# echo $(cat /proc/device-tree/model)
> Gateworks Ventana i.MX6 Dual/Quad GW51XX
> root@ventana:~# cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  16:       3818        991       1747       2665     GIC-0  29 Edge      twd
>  17:         65         90         57         60       GPC  55 Level
>   i.MX Timer Tick
>  18:      39451          0          0          0       GPC  13 Level     mxs-dma
>  19:      10397          0          0          0       GPC  15 Level     bch
>  20:          0          0          0          0       GPC 115 Level
>   120000.hdmi
>  21:          0          0          0          0       GPC   9 Level
>   130000.gpu
>  22:          0          0          0          0       GPC  10 Level
>   134000.gpu
>  24:          0          0          0          0       GPC 120 Level
>   mx6-pcie-msi
>  26:          0          0          0          0       GPC  26 Level
>   2020000.serial
>  27:          0          0          0          0       GPC  50 Level
>   2034000.asrc
>  28:          0          0          0          0       GPC  12 Level
>   2040000.vpu
>  44:          0          0          0          0       GPC  49 Level
>   imx_thermal
>  49:          0          0          0          0       GPC  19 Level
>   rtc alarm
>  55:          0          0          0          0       GPC   2 Level     sdma
>  56:          0          0          0          0       GPC  43 Level
>   2184000.usb
>  57:          0          0          0          0       GPC  40 Level
>   2184200.usb
>  58:       2186          0          0          0     GIC-0 150 Level
>   2188000.ethernet
>  59:          0          0          0          0     GIC-0 151 Level
>   2188000.ethernet
>  60:         30          0          0          0       GPC  36 Level
>   21a0000.i2c
>  61:         61          0          0          0       GPC  37 Level
>   21a4000.i2c
>  62:          0          0          0          0       GPC  38 Level
>   21a8000.i2c
>  63:          0          0          0          0       GPC  18 Level     vdoa
>  64:        328          0          0          0       GPC  27 Level
>   21e8000.serial
>  65:          0          0          0          0       GPC  28 Level
>   21ec000.serial
>  66:          0          0          0          0       GPC  30 Level
>   21f4000.serial
>  69:          0          0          0          0       GPC  11 Level
>   2204000.gpu
>  80:          0          0          0          0  gpio-mxc   8 Level     ltc3676
> 296:          0          0          0          0   PCI-MSI   0 Edge
>   PCIe PME, aerdrv
> 328:          0          0          0          0       GPC 123 Level     ath9k
> ^^^^ correct legacy interrupt, but not firing (0 interrupts)
> 329:          0          0          0          0       IPU 457 Edge
>   2400000.ipu
> 330:          0          0          0          0       IPU 451 Edge
>   2400000.ipu
> 331:          0          0          0          0       IPU 457 Edge
>   2800000.ipu
> 332:          0          0          0          0       IPU 451 Edge
>   2800000.ipu
> 333:          0          0          0          0       IPU  23 Edge      imx_drm
> 334:          0          0          0          0       IPU  28 Edge      imx_drm
> 335:          0          0          0          0       IPU  23 Edge      imx_drm
> 336:          0          0          0          0       IPU  28 Edge      imx_drm
> 337:          2          0          0          0       GPC 105 Level
>   2101000.jr0
> 338:          0          0          0          0       GPC 106 Level
>   2102000.jr1
> IPI0:          0          0          0          0  CPU wakeup interrupts
> IPI1:         22         18         23         18  Timer broadcast interrupts
> IPI2:       1016       5415      18358       6131  Rescheduling interrupts
> IPI3:         40         44         34         50  Function call interrupts
> IPI4:          0          0          0          0  CPU stop interrupts
> IPI5:        455        152        326        609  IRQ work interrupts
> IPI6:          0          0          0          0  completion interrupts
> Err:          0
> root@ventana:~# lspci -t
> -[0000:00]---00.0-[01]----00.0
>
> A GW51xx + ath10k (no bridge, device requesting MSI interrupts) looks
> appropriate with the patch (uses MSI):
> root@ventana:~# echo $(cat /proc/device-tree/model)
> Gateworks Ventana i.MX6 Dual/Quad GW51XX
> root@ventana:~# cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  16:       1759       1224        771       2368     GIC-0  29 Edge      twd
>  17:         38         88         71         62       GPC  55 Level
>   i.MX Timer Tick
>  18:      39627          0          0          0       GPC  13 Level     mxs-dma
>  19:      10451          0          0          0       GPC  15 Level     bch
>  20:          0          0          0          0       GPC 115 Level
>   120000.hdmi
>  21:          0          0          0          0       GPC   9 Level
>   130000.gpu
>  22:          0          0          0          0       GPC  10 Level
>   134000.gpu
>  24:         78          0          0          0       GPC 120 Level
>   mx6-pcie-msi
>  26:          0          0          0          0       GPC  26 Level
>   2020000.serial
>  27:          0          0          0          0       GPC  50 Level
>   2034000.asrc
>  28:          0          0          0          0       GPC  12 Level
>   2040000.vpu
>  44:          0          0          0          0       GPC  49 Level
>   imx_thermal
>  49:          0          0          0          0       GPC  19 Level
>   rtc alarm
>  55:          0          0          0          0       GPC   2 Level     sdma
>  56:          0          0          0          0       GPC  43 Level
>   2184000.usb
>  57:          0          0          0          0       GPC  40 Level
>   2184200.usb
>  58:        806          0          0          0     GIC-0 150 Level
>   2188000.ethernet
>  59:          0          0          0          0     GIC-0 151 Level
>   2188000.ethernet
>  60:         30          0          0          0       GPC  36 Level
>   21a0000.i2c
>  61:         61          0          0          0       GPC  37 Level
>   21a4000.i2c
>  62:          0          0          0          0       GPC  38 Level
>   21a8000.i2c
>  63:          0          0          0          0       GPC  18 Level     vdoa
>  64:        201          0          0          0       GPC  27 Level
>   21e8000.serial
>  65:          0          0          0          0       GPC  28 Level
>   21ec000.serial
>  66:          0          0          0          0       GPC  30 Level
>   21f4000.serial
>  69:          0          0          0          0       GPC  11 Level
>   2204000.gpu
>  80:          0          0          0          0  gpio-mxc   8 Level     ltc3676
> 296:          0          0          0          0   PCI-MSI   0 Edge
>   PCIe PME, aerdrv
> 297:         78          0          0          0   PCI-MSI   1 Edge
>   ath10k_pci
> ^^^^ MSI interrupt and its firing (78 interrupts)
> 329:          0          0          0          0       IPU 457 Edge
>   2400000.ipu
> 330:          0          0          0          0       IPU 451 Edge
>   2400000.ipu
> 331:          0          0          0          0       IPU 457 Edge
>   2800000.ipu
> 332:          0          0          0          0       IPU 451 Edge
>   2800000.ipu
> 333:          0          0          0          0       IPU  23 Edge      imx_drm
> 334:          0          0          0          0       IPU  28 Edge      imx_drm
> 335:          0          0          0          0       IPU  23 Edge      imx_drm
> 336:          0          0          0          0       IPU  28 Edge      imx_drm
> 337:          2          0          0          0       GPC 105 Level
>   2101000.jr0
> 338:          0          0          0          0       GPC 106 Level
>   2102000.jr1
> IPI0:          0          0          0          0  CPU wakeup interrupts
> IPI1:         12         24         13         20  Timer broadcast interrupts
> IPI2:        905       7340      17490       6554  Rescheduling interrupts
> IPI3:         50         49         34         48  Function call interrupts
> IPI4:          0          0          0          0  CPU stop interrupts
> IPI5:        192        160         60         29  IRQ work interrupts
> IPI6:          0          0          0          0  completion interrupts
> Err:          0
> root@ventana:~# lspci -t
> -[0000:00]---00.0-[01]----00.0
> root@ventana:~# grep ath /proc/interrupts
> 297:         78          0          0          0   PCI-MSI   1 Edge
>   ath10k_pci
>
> Regards,
>
> Tim

Lucas,

Are you not able to repeat my findings?

Since Linux 4.8 IMX PCIe is completely broken for PCIe devices that do
not support MSI interrupts (and there are a whole lot of 802.11n
radios that fall into this category) as you can no longer disable MSI
because the IMX PCIe driver depends on it.

It seems like your patch is the right approach but something must
still be getting set that causes the legacy interrupts to not fire.

Regards,

Tim
