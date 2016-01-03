Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:59503 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbcACOL2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jan 2016 09:11:28 -0500
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id AEF61542C38
	for <linux-pci@vger.kernel.org>; Sun,  3 Jan 2016 15:11:24 +0100 (CET)
Date: Sun, 3 Jan 2016 15:11:24 +0100
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 7/7] pciutils: Allow 32-bit domains
Message-ID: <mj+md-20160103.140612.56316.camelot@ucw.cz>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-8-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449523949-21898-8-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

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

This is definitely not enough. Try grepping the source for "domain" :-)

At least the following places need updating, too:

  o  struct pci_filter and operations on it

  o  Format strings for printing domains at various places

  o  ABI compability ... changing a field in the middle of struct pci_dev
     (or pci_filter) is going to break ABI, so you either need to change the
     structures in a backward-compatible way, or to use ABI versioning.

Also, we should decide on what type the domain should have -- currently, some
places use "int", others use u16, and your patch introduces int32_t. I would
prefer u32 myself, but especially in the filters we should be careful about
how to encode "any domain".

			Have a nice new year
						Martin
