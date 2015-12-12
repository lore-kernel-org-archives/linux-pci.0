Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35093 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbLLXAR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2015 18:00:17 -0500
MIME-Version: 1.0
In-Reply-To: <1449523949-21898-8-git-send-email-keith.busch@intel.com>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
	<1449523949-21898-8-git-send-email-keith.busch@intel.com>
Date: Sun, 13 Dec 2015 01:00:16 +0200
Message-ID: <CAHp75VcJwHk=Bo0jUTN8LpVv+i=gT5qvw_KhAyq6hAHgiNGzyw@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] pciutils: Allow 32-bit domains
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 7, 2015 at 11:32 PM, Keith Busch <keith.busch@intel.com> wrote:
> PCI-e segments will continue to use the lower 16 bits as required by
> ACPI. Special domains may use the full 32-bits.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  lib/filter.c |    2 +-
>  lib/pci.h    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/filter.c b/lib/filter.c
> index d4254a0..075dc2f 100644
> --- a/lib/filter.c
> +++ b/lib/filter.c
> @@ -45,7 +45,7 @@ pci_filter_parse_slot_v33(struct pci_filter *f, char *str)
>           if (str[0] && strcmp(str, "*"))
>             {
>               long int x = strtol(str, &e, 16);
> -             if ((e && *e) || (x < 0 || x > 0xffff))
> +             if ((e && *e) || (x < 0))
>                 return "Invalid domain number";
>               f->domain = x;
>             }
> diff --git a/lib/pci.h b/lib/pci.h
> index 10ba831..7e42765 100644
> --- a/lib/pci.h
> +++ b/lib/pci.h
> @@ -119,7 +119,7 @@ struct pci_param *pci_walk_params(struct pci_access *acc, struct pci_param *prev
>
>  struct pci_dev {
>    struct pci_dev *next;                        /* Next device in the chain */
> -  u16 domain;                          /* PCI domain (host bridge) */

> +  int32_t domain;                      /* PCI domain (host bridge) */

Why not u32 ?

>    u8 bus, dev, func;                   /* Bus inside domain, device and function */
>
>    /* These fields are set by pci_fill_info() */
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
