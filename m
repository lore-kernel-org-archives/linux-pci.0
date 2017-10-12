Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1507812623-12598-1-git-send-email-bhumirks@gmail.com>
References: <1507812623-12598-1-git-send-email-bhumirks@gmail.com>
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 12 Oct 2017 17:03:32 +0200
Message-ID: <CAOH+1jHNG-b39kDZN5TgUBYrAt4pGB01WcCG70bERkJ1BN7HSQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: make config_item_type const
To: Julia Lawall <julia.lawall@lip6.fr>, kishon@ti.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 2:50 PM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> This is a followup patch for:
> https://patchwork.kernel.org/patch/9999649/ and
> https://lkml.org/lkml/2017/10/11/375
>
> Make config_item_type structures const as they are either passed to a
> function having the argument as const or stored in the const "ci_type"
> field of a config_item structure.
>
> Done using Coccinelle.
>

Actually, this patch is dependent on the patches in the links
https://lkml.org/lkml/2017/10/11/375 and
https://patchwork.kernel.org/patch/9999649/. Therefore, this patch
won't be correct unless the patches in these links gets applied.

> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 424fdd6..4f74386 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -150,7 +150,7 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
>         .drop_link      = pci_epc_epf_unlink,
>  };
>
> -static struct config_item_type pci_epc_type = {
> +static const struct config_item_type pci_epc_type = {
>         .ct_item_ops    = &pci_epc_item_ops,
>         .ct_attrs       = pci_epc_attrs,
>         .ct_owner       = THIS_MODULE,
> @@ -361,7 +361,7 @@ static void pci_epf_release(struct config_item *item)
>         .release                = pci_epf_release,
>  };
>
> -static struct config_item_type pci_epf_type = {
> +static const struct config_item_type pci_epf_type = {
>         .ct_item_ops    = &pci_epf_ops,
>         .ct_attrs       = pci_epf_attrs,
>         .ct_owner       = THIS_MODULE,
> @@ -400,7 +400,7 @@ static void pci_epf_drop(struct config_group *group, struct config_item *item)
>         .drop_item      = &pci_epf_drop,
>  };
>
> -static struct config_item_type pci_epf_group_type = {
> +static const struct config_item_type pci_epf_group_type = {
>         .ct_group_ops   = &pci_epf_group_ops,
>         .ct_owner       = THIS_MODULE,
>  };
> @@ -428,15 +428,15 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
>  }
>  EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
>
> -static struct config_item_type pci_functions_type = {
> +static const struct config_item_type pci_functions_type = {
>         .ct_owner       = THIS_MODULE,
>  };
>
> -static struct config_item_type pci_controllers_type = {
> +static const struct config_item_type pci_controllers_type = {
>         .ct_owner       = THIS_MODULE,
>  };
>
> -static struct config_item_type pci_ep_type = {
> +static const struct config_item_type pci_ep_type = {
>         .ct_owner       = THIS_MODULE,
>  };
>
> --
> 1.9.1
>
