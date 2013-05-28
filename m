Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:60430 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934735Ab3E1RYx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 13:24:53 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so10219380oag.41
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 10:24:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
References: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 11:24:32 -0600
Message-ID: <CAErSpo5+K41XE8yMOaf6RJN=1oyv=z_Fi-vaXJLDaDxvgdq+QA@mail.gmail.com>
Subject: Re: [PATCH] PCI/X86: increase info->res_num before checking
 pci_use_crs return
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 27, 2013 at 8:55 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> I separate this patch from patchset "Add hostbridge resource release to
> support root bus hotplug in IA64", because it's a Separate issue.
>
> We should increase info->res_num before we checking pci_use_crs return
> when pci=nocrs set.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Jiang Liu <liuj97@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/pci/acpi.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)

Applied to pci/misc for v3.11, thanks!

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
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
