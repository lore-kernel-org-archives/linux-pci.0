Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33209 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3E1Efr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 00:35:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so19453745ied.5
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 21:35:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
References: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
Date: Mon, 27 May 2013 21:35:47 -0700
Message-ID: <CAE9FiQXkwoRfFbcEn15MRGv6fVeOM5WC1Gh2NAhWj7yTda3G+g@mail.gmail.com>
Subject: Re: [PATCH] PCI/X86: increase info->res_num before checking
 pci_use_crs return
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 27, 2013 at 7:55 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> I separate this patch from patchset "Add hostbridge resource release to
> support root bus hotplug in IA64", because it's a Separate issue.
>
> We should increase info->res_num before we checking pci_use_crs return
> when pci=nocrs set.

there is no function change or issue here.

>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Jiang Liu <liuj97@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/pci/acpi.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 3e72425..662dfdf 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -324,14 +324,11 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>         res->start = start;
>         res->end = end;
>         info->res_offset[info->res_num] = addr.translation_offset;
> +       info->res_num++;
>
> -       if (!pci_use_crs) {
> +       if (!pci_use_crs)
>                 dev_printk(KERN_DEBUG, &info->bridge->dev,
>                            "host bridge window %pR (ignored)\n", res);
> -               return AE_OK;
> -       }
> -
> -       info->res_num++;
>
>         return AE_OK;
>  }

info->res_num is not used after probe_pci_root_info for pci_nocrs case.

Thanks

Yinghai
