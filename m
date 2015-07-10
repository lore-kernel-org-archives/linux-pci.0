Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32961 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001AbbGJT4V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 15:56:21 -0400
MIME-Version: 1.0
In-Reply-To: <1436518099-98633-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1436518099-98633-1-git-send-email-gabriele.paoloni@huawei.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 10 Jul 2015 14:56:01 -0500
Message-ID: <CAL_JsqJA9WEWK+ywv7ou+88U3cQ7z6GHDTDjxOxRC9X4_K88FQ@mail.gmail.com>
Subject: Re: [PATCH] Store PCIe controllers address in struct of_pci_range
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	wangzhou1@hisilicon.com, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, james.morse@arm.com,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	yuanzhichang@hisilicon.com, zhudacai@hisilicon.com,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liguozhu@hisilicon.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 10, 2015 at 3:48 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patch is needed port PCIe designware to new DT parsing API
> As discussed in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317743.html
> in designware we have a problem as the PCI addresses in the PCIe controller
> address space are required in order to perform correct HW operation.
>
> In order to solve this problem commit
> f4c55c5a3f7f68c06cc559ed7af8b2d017cbb0a7 "PCI: designware:

Please abbreviate hashs to 12 characters.

> Program ATU with untranslated address" added code to read the PCIe
> controller start address directly from the DT ranges.
>
> In the new DT parsing API of_pci_get_host_bridge_resources() hides the
> DT parser from the host controller drivers, so it is not possible
> for drivers to parse values directly from the DT.
>
> In http://www.spinics.net/lists/linux-pci/msg42540.html we already tried
> to use the new DT parsing API but there is a bug (obviously) in setting
> the <*>_mod_base addresses
> Applying this patch we can easily set "<*>_mod_base = win->__res.start"
>
> This patch adds a new field in "struct of_pci_range" to store the
> pci controller start address; it fills the field in of_pci_range_parser_one();
> in of_pci_get_host_bridge_resources() it retrieve the resource entry
> after it is created and added to the resource list and uses
> entry->__res.start to store the pci controller address
>
> the patch is based on 4.2-rc1
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/of/address.c               | 1 +
>  drivers/of/of_pci.c                | 4 ++++
>  drivers/pci/host/pcie-designware.c | 9 +++------
>  include/linux/of_address.h         | 1 +
>  4 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 8bfda6a..52f9321 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -265,6 +265,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>         range->pci_addr = of_read_number(parser->range + 1, ns);
>         range->cpu_addr = of_translate_address(parser->node,
>                                 parser->range + na);
> +       range->pci_ctrl_addr = of_read_number(parser->range + na, ns);

This is wrong as the correct size to read is not "ns", but the parent
bus #size-cells value.

I think "bus_addr" would be a better name. It is not the PCI
controller's address (i.e. what is in reg prop). No "pci" because it
has nothing to do with PCI bus addresses.

In general, this seems fragile as the dt address ranges/translation
may not align with the h/w ranges. For example, what if you have 2
levels of translations and you happen to need it translated with just
1 level of translation. That said, I don't really have a better
suggestion and I guess we can deal with that case if needed later.

>         range->size = of_read_number(parser->range + parser->pna + na, ns);
>
>         parser->range += parser->np;
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..2ccc749 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -198,6 +198,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>
>         pr_debug("Parsing ranges property...\n");
>         for_each_of_pci_range(&parser, &range) {
> +               struct resource_entry *entry;
>                 /* Read next ranges element */
>                 if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
>                         snprintf(range_type, 4, " IO");
> @@ -240,6 +241,9 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>                 }
>
>                 pci_add_resource_offset(resources, res, res->start - range.pci_addr);
> +               entry = list_last_entry(resources, struct resource_entry, node);
> +               /*we are using __res for storing the PCI controller address*/
> +               entry->__res.start = range.pci_ctrl_addr;

You will use this in a follow-up patch? I'd like to see this just
split into core changes and DW changes. This looks like you are making
intermediate DW changes which will be removed in subsequent patches.

Rob
