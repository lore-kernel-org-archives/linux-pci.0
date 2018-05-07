Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI ACPI: Avoid panic when PCI IO resource's size
 is not page aligned
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1522480343-37669-1-git-send-email-xieyisheng1@huawei.com>
 <3699960.UXjPS91TgB@aspire.rjw.lan>
CC: <bhelgaas@google.com>, <lenb@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <jcm@redhat.com>, <toshi.kani@hpe.com>, <tanxiaojun@huawei.com>,
        <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <a8398da8-2f69-5694-69d6-224b547a378a@huawei.com>
Date: Mon, 7 May 2018 16:06:13 +0800
MIME-Version: 1.0
In-Reply-To: <3699960.UXjPS91TgB@aspire.rjw.lan>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/5/1 17:28, Rafael J. Wysocki wrote:
>>  drivers/acpi/pci_root.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> > index 6fc204a..b758ca3 100644
>> > --- a/drivers/acpi/pci_root.c
>> > +++ b/drivers/acpi/pci_root.c
>> > @@ -746,7 +746,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
>> >  		goto err;
>> >  
>> >  	res->start = port;
>> > -	res->end = port + length - 1;
>> > +	res->end = PAGE_ALIGN(port + length) - 1;
> Shouldn't pci_remap_iospace() sanitize its arguments instead?

Yeah, I thought that pci_remap_iospace() will be called at many place, and presently I
had not seen any problem at other place except acpi_pci_root_remap_iospace(). Anyway,
sanitize arguments in pci_remap_iospace() can resolve the problem more thoroughly, but
should more common, right?

Therefore, is the follow change ok from your point of view?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e597655..8607298 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3527,6 +3527,9 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
        if (res->end > IO_SPACE_LIMIT)
                return -EINVAL;

+       if (!PAGE_ALIGNED(vaddr) || !PAGE_ALIGNED(resource_size(res)))
+               return -EINVAL;
+
        return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
                                  pgprot_device(PAGE_KERNEL));
 #else

Thanks
Yisheng

> 
>> >  	entry->offset = port - pci_addr;
>> >  
>> >  	if (pci_remap_iospace(res, cpu_addr) < 0)

