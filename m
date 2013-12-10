Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:44188 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3LJXXu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 18:23:50 -0500
Received: by mail-we0-f178.google.com with SMTP id u57so5625304wes.23
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2013 15:23:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001101cef5f6$4347c520$c9d74f60$%han@samsung.com>
References: <20131205050424.GA2298@pratyush-vbox>
	<201312061546.23981.arnd@arndb.de>
	<20131209071241.GA5760@pratyush-vbox>
	<201312101426.40614.marex@denx.de>
	<001101cef5f6$4347c520$c9d74f60$%han@samsung.com>
Date: Tue, 10 Dec 2013 15:23:47 -0800
Message-ID: <CAJ+vNU1LCeSKBjr8ryrJZcPt2+6Xcv0de19FttdpTvSEmr1k_w@mail.gmail.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe controller
From: Tim Harvey <tharvey@gateworks.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Marek Vasut <marex@denx.de>,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 10, 2013 at 2:22 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Tuesday, December 10, 2013 10:27 PM, Marek Vasut wrote:
>> On Monday, December 09, 2013 at 08:12:42 AM, Pratyush Anand wrote:
>
> [.....]
>
>> >
>> > diff --git a/drivers/pci/host/pcie-designware.c
>> > b/drivers/pci/host/pcie-designware.c index be6ce30..cf68632 100644
>> > --- a/drivers/pci/host/pcie-designware.c
>> > +++ b/drivers/pci/host/pcie-designware.c
>> > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>> >                                        + global_io_offset);
>> >                     pp->config.io_size = resource_size(&pp->io);
>> >                     pp->config.io_bus_addr = range.pci_addr;
>> > +                   pp->io_base = range.cpu_addr;
>> >             }
>> >             if (restype == IORESOURCE_MEM) {
>> >                     of_pci_range_to_resource(&range, np, &pp->mem);
>> > @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>> >
>> >     pp->cfg0_base = pp->cfg.start;
>> >     pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
>> > -   pp->io_base = pp->io.start;
>> >     pp->mem_base = pp->mem.start;
>> >
>> >     pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
>> > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data
>> > *sys)
>> >
>> >     if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>> >             sys->io_offset = global_io_offset - pp->config.io_bus_addr;
>> > -           pci_ioremap_io(sys->io_offset, pp->io.start);
>> > +           pci_ioremap_io(sys->io_offset, pp->io_base);
>> >             global_io_offset += SZ_64K;
>> >             pci_add_resource_offset(&sys->resources, &pp->io,
>> >                                     sys->io_offset);
>>
>> Tim, can you test if this patch fixes your SKY2 IOspace problem please ?
>
> Above mentioned patch is NOT the latest patch.
> Pratyush Anand already submitted the next patch as below.
>
> Tim,
> Would you test the following patch on i.MX6 platform?
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index be6ce30..b83f5e8 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>                                            + global_io_offset);
>                         pp->config.io_size = resource_size(&pp->io);
>                         pp->config.io_bus_addr = range.pci_addr;
> +                       pp->io_base = range.cpu_addr;
>                 }
>                 if (restype == IORESOURCE_MEM) {
>                         of_pci_range_to_resource(&range, np, &pp->mem);
> @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>
>         pp->cfg0_base = pp->cfg.start;
>         pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> -       pp->io_base = pp->io.start;
>         pp->mem_base = pp->mem.start;
>
>         pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>
>         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>                 sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> -               pci_ioremap_io(sys->io_offset, pp->io.start);
> +               pci_ioremap_io(global_io_offset, pp->io_base);
>                 global_io_offset += SZ_64K;
>                 pci_add_resource_offset(&sys->resources, &pp->io,
>                                         sys->io_offset);
>
>
> Best regards,
> Jingoo Han
>

Yes, this patch resolves the issue and now I can use devices with io
resources behind a bridge attached to the IMX6.

Thanks everyone for your efforts!

Tim
