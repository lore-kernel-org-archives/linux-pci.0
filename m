Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46831 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032046Ab2CORoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2012 13:44:14 -0400
Received: by dajr28 with SMTP id r28so4830748daj.19
        for <linux-pci@vger.kernel.org>; Thu, 15 Mar 2012 10:44:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0bec01cd0287$2b74ae40$825e0ac0$@jp.fujitsu.com>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
	<1330570837-26638-3-git-send-email-yinghai@kernel.org>
	<0bec01cd0287$2b74ae40$825e0ac0$@jp.fujitsu.com>
Date: Thu, 15 Mar 2012 10:44:14 -0700
Message-ID: <CAE9FiQWj5vv+Ff5Kd0xT3Ko01PCSTaHyxGCKn3B8ZwmXo8ZO=Q@mail.gmail.com>
Subject: Re: [PATCH 02/36] x86, PCI: Fix memleak with get_current_resources
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2012 at 1:39 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
>> Sent: Thursday, March 01, 2012 12:00 PM
>> To: Jesse Barnes; Benjamin Herrenschmidt; Tony Luck; David Miller; x86
>> Cc: Bjorn Helgaas; Dominik Brodowski; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-arch@vger.kernel.org; Yinghai Lu
>> Subject: [PATCH 02/36] x86, PCI: Fix memleak with get_current_resources
>>
>> in pci_scan_acpi_root, when pci_use_crs is set, get_current_resources is used
>> to get pci_root_info, and it will allocate name and res array.
>>
>> later if pci_create_root_bus can not create bus (could be already there...)
>> it will only free bus res list. but the name and res array is not freed.
>>
>> let get_current_resource take info pointer instead have local info.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  arch/x86/pci/acpi.c |   49 ++++++++++++++++++++++++++++++-------------------
>>  1 files changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 7cc0a44..304ccf0 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -305,49 +305,55 @@ static void add_resources(struct pci_root_info *info)
>>       }
>>  }
>>
>> +static void free_pci_root_info(struct pci_root_info *info)
>> +{
>> +     kfree(info->name);
>> +     kfree(info->res);
>> +     memset(info, 0, sizeof(struct pci_root_info));
>> +}
>> +
>
>  This function leads to misunderstanding.
>  I'm convinced that the function of the name starts with "free"
>  should free resources completely.

after patchset it will become:

static void free_pci_root_info_res(struct pci_root_info *info)
{
        kfree(info->res);
        info->res = NULL;
        info->res_num = 0;
}

static void __release_pci_root_info(struct pci_root_info *info)
{
        int i;
        struct resource *res;

        for (i = 0; i < info->res_num; i++) {
                res = &info->res[i];

                if (!res->parent)
                        continue;

                if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
                        continue;

                release_resource(res);
        }

        free_pci_root_info_res(info);

        kfree(info);
}
static void release_pci_root_info(struct pci_host_bridge *bridge)
{
        struct pci_root_info *info = bridge->release_data;

        __release_pci_root_info(info);
}

Is that still confusing?

Thanks

Yinghai
