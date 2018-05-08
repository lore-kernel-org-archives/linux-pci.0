Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a8398da8-2f69-5694-69d6-224b547a378a@huawei.com>
References: <1522480343-37669-1-git-send-email-xieyisheng1@huawei.com>
 <3699960.UXjPS91TgB@aspire.rjw.lan> <a8398da8-2f69-5694-69d6-224b547a378a@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 May 2018 23:20:23 +0200
Message-ID: <CAJZ5v0h4DLNBJz1QmgmCitj2_UfMBLxboZ2i9rpFZ4+qZPf+eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI ACPI: Avoid panic when PCI IO resource's size
 is not page aligned
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jon Masters <jcm@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        tanxiaojun@huawei.com, Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 7, 2018 at 10:06 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>
>
> On 2018/5/1 17:28, Rafael J. Wysocki wrote:
>>>  drivers/acpi/pci_root.c | 2 +-
>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >
>>> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>> > index 6fc204a..b758ca3 100644
>>> > --- a/drivers/acpi/pci_root.c
>>> > +++ b/drivers/acpi/pci_root.c
>>> > @@ -746,7 +746,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
>>> >            goto err;
>>> >
>>> >    res->start = port;
>>> > -  res->end = port + length - 1;
>>> > +  res->end = PAGE_ALIGN(port + length) - 1;
>> Shouldn't pci_remap_iospace() sanitize its arguments instead?
>
> Yeah, I thought that pci_remap_iospace() will be called at many place, and presently I
> had not seen any problem at other place except acpi_pci_root_remap_iospace(). Anyway,
> sanitize arguments in pci_remap_iospace() can resolve the problem more thoroughly, but
> should more common, right?
>
> Therefore, is the follow change ok from your point of view?
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e597655..8607298 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3527,6 +3527,9 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>         if (res->end > IO_SPACE_LIMIT)
>                 return -EINVAL;
>
> +       if (!PAGE_ALIGNED(vaddr) || !PAGE_ALIGNED(resource_size(res)))
> +               return -EINVAL;
> +
>         return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
>                                   pgprot_device(PAGE_KERNEL));
>  #else

I'd rather apply PAGE_ALIGN() to the arguments of ioremap_page_range()
and call it anyway.  It will fail if the mapping cannot be created.
