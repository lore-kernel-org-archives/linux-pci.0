Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:36766 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcBIJy4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 04:54:56 -0500
Date: Tue, 9 Feb 2016 10:54:53 +0100
From: Martin Mares <mj@ucw.cz>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, david.daney@cavium.com
Subject: Re: [PATCH v3 2/2] Add support for enhanced allocation regions
Message-ID: <mj+md-20160209.095136.61181.nikam@ucw.cz>
References: <1454702345-4014-1-git-send-email-sean.stalley@intel.com>
 <1454702345-4014-3-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454702345-4014-3-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> diff --git a/lib/header.h b/lib/header.h
> index b8f7dc1..7b9a803 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -1235,3 +1235,7 @@
>  
>  #define PCI_VENDOR_ID_INTEL		0x8086
>  #define PCI_VENDOR_ID_COMPAQ		0x0e11
> +
> +/* taken from <include/linux/ioport.h> */
> +
> +#define IORESOURCE_PCI_EA_BEI          (1<<5)
> diff --git a/lib/pci.h b/lib/pci.h
> index 9c1e281..a88e156 100644
> --- a/lib/pci.h
> +++ b/lib/pci.h
> @@ -129,8 +129,10 @@ struct pci_dev {
>    int irq;				/* IRQ number */
>    pciaddr_t base_addr[6];		/* Base addresses including flags in lower bits */
>    pciaddr_t size[6];			/* Region sizes */
> +  pciaddr_t flags[6];			/* Region flags */
>    pciaddr_t rom_base_addr;		/* Expansion ROM base address */
>    pciaddr_t rom_size;			/* Expansion ROM size */
> +  pciaddr_t rom_flags;			/* Expansion ROM flags */

First, please explain in comments how does this thing work.

Second, please try not to break binary compatibility. New fields should
be added at the end of the public part of the structure. You also have to
define a new version of pci_fill_info(), so that applications using the
new layout of the structure will require a new version of libpci.

> +      if (p->flags[i] & IORESOURCE_PCI_EA_BEI)
> +	{
> +	  printf("[enhanced] ");
> +	}

Please follow the style of the rest of the code. One-statement conditions
do not have braces.

				Martin
