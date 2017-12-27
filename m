Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54593 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdL0OZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 09:25:32 -0500
Subject: Re: Re-activate task to add MSI-X to pcie-designware
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
References: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
 <20171208110225.GC26816@red-moon>
 <9ede58a6-7c0d-ae66-4e15-147234cbad6d@ti.com>
 <69f78abd-f83e-b3a6-0daf-638f89d07f99@synopsys.com>
 <8771860f-babd-afcb-ed07-2642d2a4d6a8@ti.com>
 <0531c3e9-57e7-d531-1bee-a5a5bbff2a8c@synopsys.com>
 <2e04befd-9434-b3ec-0c18-96a80744e327@ti.com>
 <513e28db-924d-569c-b3ae-cbb949229cc9@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <cafeb5b6-4954-becf-0d30-8b6ee7e71efa@synopsys.com>
Date: Wed, 27 Dec 2017 14:25:27 +0000
MIME-Version: 1.0
In-Reply-To: <513e28db-924d-569c-b3ae-cbb949229cc9@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/12/2017 12:57, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 23 December 2017 03:46 PM, Kishon Vijay Abraham I wrote:
>> Hi Gustavo,
>>
>> On Thursday 21 December 2017 07:38 PM, Gustavo Pimentel wrote:
>>> On 20/12/2017 13:03, Kishon Vijay Abraham I wrote:This is our most recent
>>> version of the patches that are running on our equipment, please check with yours
>>>> Hi,
>>>>
>>>> On Monday 18 December 2017 09:31 PM, Gustavo Pimentel wrote:
>>>>> Hi Kishon,
>>>>>
>>>>> I would like to collaborate with you on this subject, I have on my side João's
>>>>> patches updated to the Bjorn's latest kernel version.
>>>>
>>>> cool, do you have a branch so that I can check what breaks in keystone and debug?
>>>>
>>> Unfortunately not, however I'll mailed you the patches immediately.
>>> Once again, thanks.
>>
>> Thanks.
>>
>> I tried raising MSI with pci_endpoint_test EP device (16 MSI interrupts). Here
>> are some of my observations after applying your patch series.
>>
>> root@k2g-evm:~# cat /proc/interrupts
>>            CPU0
>>  17:          0     GICv2  29 Level     arch_timer
>>  18:       1816     GICv2  30 Level     arch_timer
>>  21:          0     GICv2  36 Edge      arm-pmu
>>  22:        792     GICv2 196 Edge      ttyS0
>>  23:          5     GICv2 120 Edge      2530000.i2c
>>  24:          0     GICv2  33 Edge      soc:keystone_irq@26202a0
>>  25:        901     GICv2 356 Level     2a00000.msgmgr rx_005_002
>>  41:          0     GICv2 232 Edge      2700000.edma_ccint
>>  43:          0     GICv2 249 Edge      2700000.edma_ccerrint
>>  44:       2497     GICv2 240 Edge      2728000.edma_ccint
>>  46:          0     GICv2 252 Edge      2728000.edma_ccerrint
>>  47:       7551     GICv2 128 Edge      mmc0
>>  48:          0     GICv2 160 Edge      2680000.keystone-dwc3, xhci-hcd:usb1
>>  49:          0     GICv2 176 Edge      2580000.keystone-dwc3, xhci-hcd:usb3
>>  50:          0     GICv2  96 Edge      21805400.spi
>>  52:          0     GICv2 100 Edge      21805c00.spi
>>  53:          0     GICv2 102 Edge      21806000.spi
>>  54:          0     GICv2  92 Edge      pcie-error-irq
>> 211:          0      GPIO  12 Edge    -davinci_gpio  23000000.mmc cd
>> 280:          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
>> 281:          0   PCI-MSI 524288 Edge      pci-endpoint-test
>> 282:          0   PCI-MSI 524289 Edge      pci-endpoint-test
>> 283:          0   PCI-MSI 524290 Edge      pci-endpoint-test
>> 284:          0   PCI-MSI 524291 Edge      pci-endpoint-test
>> 285:          0   PCI-MSI 524292 Edge      pci-endpoint-test
>> 286:          0   PCI-MSI 524293 Edge      pci-endpoint-test
>> 287:          0   PCI-MSI 524294 Edge      pci-endpoint-test
>> 288:          0   PCI-MSI 524295 Edge      pci-endpoint-test
>> 289:          0   PCI-MSI 524296 Edge      pci-endpoint-test
>> 290:          0   PCI-MSI 524297 Edge      pci-endpoint-test
>> 291:          0   PCI-MSI 524298 Edge      pci-endpoint-test
>> 292:          0   PCI-MSI 524299 Edge      pci-endpoint-test
>> 293:          0   PCI-MSI 524300 Edge      pci-endpoint-test
>> 294:          0   PCI-MSI 524301 Edge      pci-endpoint-test
>> 295:          0   PCI-MSI 524302 Edge      pci-endpoint-test
>> 296:          0   PCI-MSI 524303 Edge      pci-endpoint-test
>> IPI0:          0  CPU wakeup interrupts
>> IPI1:          0  Timer broadcast interrupts
>> IPI2:          0  Rescheduling interrupts
>> IPI3:          0  Function call interrupts
>> IPI4:          0  CPU stop interrupts
>> IPI5:          0  IRQ work interrupts
>> IPI6:          0  completion interrupts
>> Err:          0
>>
>> root@k2g-evm:~# pcitest -m 1
>> [   45.966437] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 271
>> [   45.973544] keystone-pcie 21801000.pcie: irq: bit 0, vector 0, virq 280
>> MSI1:           NOT OKAY
>>
>> Here there is an off by one error. "pcitest -m 1" should ideally have raised an
>> interrupt in 281 but from the above debug print it looks like it's raising an
>> interrupt in 280.
> 
> The above error was due to an pci_endpoint bug. I'll send a patch to fix this
> separately.

Ok great!

>>
>> So I tried disabling the pcieportbus driver. These are my observations once I
>> disable pcieportbus driver
>>
>> root@k2g-evm:~# cat /proc/interrupts
>>            CPU0
>>  17:          0     GICv2  29 Level     arch_timer
>>  18:       2222     GICv2  30 Level     arch_timer
>>  21:          0     GICv2  36 Edge      arm-pmu
>>  22:        821     GICv2 196 Edge      ttyS0
>>  23:          5     GICv2 120 Edge      2530000.i2c
>>  24:          0     GICv2  33 Edge      soc:keystone_irq@26202a0
>>  25:        909     GICv2 356 Level     2a00000.msgmgr rx_005_002
>>  41:          0     GICv2 232 Edge      2700000.edma_ccint
>>  43:          0     GICv2 249 Edge      2700000.edma_ccerrint
>>  44:       2442     GICv2 240 Edge      2728000.edma_ccint
>>  46:          0     GICv2 252 Edge      2728000.edma_ccerrint
>>  47:       7297     GICv2 128 Edge      mmc0
>>  48:          0     GICv2 160 Edge      2680000.keystone-dwc3, xhci-hcd:usb1
>>  49:          0     GICv2 176 Edge      2580000.keystone-dwc3, xhci-hcd:usb3
>>  50:          0     GICv2  96 Edge      21805400.spi
>>  52:          0     GICv2 100 Edge      21805c00.spi
>>  53:          0     GICv2 102 Edge      21806000.spi
>>  54:          0     GICv2  92 Edge      pcie-error-irq
>> 211:          0      GPIO  12 Edge    -davinci_gpio  23000000.mmc cd
>> 280:          0   PCI-MSI 524288 Edge      pci-endpoint-test
>> 281:          0   PCI-MSI 524289 Edge      pci-endpoint-test
>> 282:          0   PCI-MSI 524290 Edge      pci-endpoint-test
>> 283:          0   PCI-MSI 524291 Edge      pci-endpoint-test
>> 284:          0   PCI-MSI 524292 Edge      pci-endpoint-test
>> 285:          0   PCI-MSI 524293 Edge      pci-endpoint-test
>> 286:          0   PCI-MSI 524294 Edge      pci-endpoint-test
>> 287:          0   PCI-MSI 524295 Edge      pci-endpoint-test
>> 288:          0   PCI-MSI 524296 Edge      pci-endpoint-test
>> 289:          0   PCI-MSI 524297 Edge      pci-endpoint-test
>> 290:          0   PCI-MSI 524298 Edge      pci-endpoint-test
>> 291:          0   PCI-MSI 524299 Edge      pci-endpoint-test
>> 292:          0   PCI-MSI 524300 Edge      pci-endpoint-test
>> 293:          0   PCI-MSI 524301 Edge      pci-endpoint-test
>> 294:          0   PCI-MSI 524302 Edge      pci-endpoint-test
>> 295:          0   PCI-MSI 524303 Edge      pci-endpoint-test
>> IPI0:          0  CPU wakeup interrupts
>> IPI1:          0  Timer broadcast interrupts
>> IPI2:          0  Rescheduling interrupts
>> IPI3:          0  Function call interrupts
>> IPI4:          0  CPU stop interrupts
>> IPI5:          0  IRQ work interrupts
>> IPI6:          0  completion interrupts
>> Err:          0
>>
>> root@k2g-evm:~# pcitest -m 1
>> [   57.791535] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 271
>> [   57.798643] keystone-pcie 21801000.pcie: irq: bit 0, vector 0, virq 280
>> MSI1:           OKAY
>> root@k2g-evm:~# pcitest -m 2
>> [   59.791509] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 272
>> [   59.798614] keystone-pcie 21801000.pcie: irq: bit 0, vector 1, virq 281
>> MSI2:           OKAY
>> root@k2g-evm:~# pcitest -m 3
>> [   61.271509] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 273
>> [   61.278616] keystone-pcie 21801000.pcie: irq: bit 0, vector 2, virq 282
>> MSI3:           OKAY
>> root@k2g-evm:~# pcitest -m 4
>> [   62.791514] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 274
>> [   62.798619] keystone-pcie 21801000.pcie: irq: bit 0, vector 3, virq 283
>> MSI4:           OKAY
>> root@k2g-evm:~# pcitest -m 5
>> [   64.311513] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 275
>> [   64.318620] keystone-pcie 21801000.pcie: irq: bit 0, vector 4, virq 284
>> MSI5:           OKAY
>> root@k2g-evm:~# pcitest -m 6
>> [   66.351518] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 276
>> [   66.358624] keystone-pcie 21801000.pcie: irq: bit 0, vector 5, virq 285
>> MSI6:           OKAY
>> root@k2g-evm:~# pcitest -m 7
>> [   67.811516] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 277
>> [   67.818623] keystone-pcie 21801000.pcie: irq: bit 0, vector 6, virq 286
>> MSI7:           OKAY
>> root@k2g-evm:~# pcitest -m 8
>> [   69.291518] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 278
>> [   69.298625] keystone-pcie 21801000.pcie: irq: bit 0, vector 7, virq 287
>> MSI8:           OKAY
>> root@k2g-evm:~# pcitest -m 9
>> MSI9:           NOT OKAY
>> root@k2g-evm:~# pcitest -m 10
>> MSI10:          NOT OKAY
>>
>> So once I disable pcieportbus, I could get the first 8 interrupts correctly.
>> But after that there are no interrupts at all.
> 
> This issues is due to the previous interrupt not acknowledged and below fixes
> the issue.

Besides this issue that you fixed with this patch, is everything working well in
your setup?

> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index 2816bd98f66c..b25e788e9828 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -58,8 +58,20 @@ static void dw_msi_unmask_irq(struct irq_data *d)
>         irq_chip_unmask_parent(d);
>  }
> 
> +static void dw_pci_ack_irq(struct irq_data *d)
> +{
> +       struct msi_desc *msi = irq_data_get_msi_desc(d);
> +       struct pcie_port *pp;
> +
> +       pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +
> +       if (pp->ops->msi_irq_ack)
> +               pp->ops->msi_irq_ack(d->irq, pp);
> +}
> +
>  static struct irq_chip dw_pcie_msi_irq_chip = {
>         .name = "PCI-MSI",
> +       .irq_ack = dw_pci_ack_irq,
>         .irq_mask = dw_msi_mask_irq,
>         .irq_unmask = dw_msi_unmask_irq,
>  };
> @@ -193,20 +205,8 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>         spin_unlock_irqrestore(&pp->lock, flags);
>  }
> 
> -static void dw_pci_bottom_ack(struct irq_data *d)
> -{
> -       struct msi_desc *msi = irq_data_get_msi_desc(d);
> -       struct pcie_port *pp;
> -
> -       pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -
> -       if (pp->ops->msi_irq_ack)
> -               pp->ops->msi_irq_ack(d->irq, pp);
> -}
> -
>  static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>         .name = "DWPCI-MSI",
> -       .irq_ack                = dw_pci_bottom_ack,
>         .irq_compose_msi_msg = dw_pci_setup_msi_msg,
>         .irq_set_affinity = dw_pci_msi_set_affinity,
>         .irq_mask = dw_pci_bottom_mask,
> @@ -240,7 +240,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>         for (i = 0; i < nr_irqs; i++)
>                 irq_domain_set_info(domain, virq + i, bit + i,
>                                     &dw_pci_msi_bottom_irq_chip,
> -                                   domain->host_data, handle_simple_irq,
> +                                   domain->host_data, handle_level_irq,
>                                     NULL, NULL);
> 
>         return 0;
> 
> Thanks
> Kishon
> 
