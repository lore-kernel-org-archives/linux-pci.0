Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37656 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab2CMDd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 23:33:26 -0400
Received: by lbbgm6 with SMTP id gm6so39325lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 12 Mar 2012 20:33:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1331362837-10740-30-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-30-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Mar 2012 21:33:05 -0600
Message-ID: <CAErSpo6ow9Lt3p0=Q4dau3AB=+YDMGo-dG0hSqFERPKnzPWXnw@mail.gmail.com>
Subject: Re: [PATCH v2 29/37] PCI, ACPI: Add acpi_pci_root_rescan()
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> It will rescan all acpi pci root if related pci root bus get removed before.

I think this is a bad idea.  The ACPI core already walks the entire
ACPI namespace, finding devices and binding drivers to them.

Walking the whole thing again looking for "hotplug" things we can do
is just a hack.  Maybe you want it for debugging, but I don't want it
in Linux.

> Signed-off-by: Yinghai <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/pci_root_hp.c |   17 +++++++++++++++++
>  include/linux/pci-acpi.h   |    7 +++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
> index b453181..ca73d51 100644
> --- a/drivers/acpi/pci_root_hp.c
> +++ b/drivers/acpi/pci_root_hp.c
> @@ -268,3 +268,20 @@ static int __init acpi_pci_root_hp_init(void)
>  }
>
>  subsys_initcall(acpi_pci_root_hp_init);
> +
> +static acpi_status
> +rescan_root_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
> +{
> +       if (!acpi_is_root_bridge(handle))
> +               return AE_OK;
> +
> +       handle_root_bridge_insertion(handle);
> +
> +       return AE_OK;
> +}
> +
> +void acpi_pci_root_rescan(void)
> +{
> +       acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +               ACPI_UINT32_MAX, rescan_root_bridge, NULL, NULL, NULL);
> +}
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 4462350..ac93634 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -35,6 +35,13 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
>        return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
>                                              pbus->number);
>  }
> +
> +void acpi_pci_root_rescan(void);
> +
> +#else
> +
> +static inline void acpi_pci_root_rescan(void) { }
> +
>  #endif
>
>  #ifdef CONFIG_ACPI_APEI
> --
> 1.7.7
>
