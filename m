Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32964 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbbLQRPs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 12:15:48 -0500
Date: Thu, 17 Dec 2015 11:15:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 7/7] pciutils: Allow 32-bit domains
Message-ID: <20151217171545.GB23549@localhost>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-8-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449523949-21898-8-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Dec 07, 2015 at 02:32:29PM -0700, Keith Busch wrote:
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
>  	  if (str[0] && strcmp(str, "*"))
>  	    {
>  	      long int x = strtol(str, &e, 16);
> -	      if ((e && *e) || (x < 0 || x > 0xffff))
> +	      if ((e && *e) || (x < 0))

Just out of curiosity (I don't maintain pciutils; Martin would apply
this one), is there some part of the PCI or PCI firmware spec that is
relevant to this change?  Maybe this is connected to parsing things
exported by the kernel and not directly tied to PCI at the spec level.

Whatever it is, a pointer to the producer of the information you're
consuming here would help us understand and review the patch.

>  		return "Invalid domain number";
>  	      f->domain = x;
>  	    }
> diff --git a/lib/pci.h b/lib/pci.h
> index 10ba831..7e42765 100644
> --- a/lib/pci.h
> +++ b/lib/pci.h
> @@ -119,7 +119,7 @@ struct pci_param *pci_walk_params(struct pci_access *acc, struct pci_param *prev
>  
>  struct pci_dev {
>    struct pci_dev *next;			/* Next device in the chain */
> -  u16 domain;				/* PCI domain (host bridge) */
> +  int32_t domain;			/* PCI domain (host bridge) */
>    u8 bus, dev, func;			/* Bus inside domain, device and function */
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
