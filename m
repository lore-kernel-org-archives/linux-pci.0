Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33589 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbbLQR1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 12:27:22 -0500
Date: Thu, 17 Dec 2015 11:27:18 -0600
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
Subject: Re: [PATCHv6 2/7] pci: child bus alloc fix on constrained resource
Message-ID: <20151217172718.GC23549@localhost>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449523949-21898-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Dec 07, 2015 at 02:32:24PM -0700, Keith Busch wrote:
> Does not allocate a child bus if the new bus number does not fit in the
> parent's bus resource window.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index edb1984..6e29f7a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -704,6 +704,12 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  	int i;
>  	int ret;
>  
> +	if (busnr > parent->busn_res.end) {
> +		dev_printk(KERN_DEBUG, &parent->dev,
> +			  "can not alloc bus:%d under %pR\n", busnr,
> +			  &parent->busn_res);
> +		return NULL;

Can you take a look at 1820ffdccb9b ("PCI: Make sure bus number resources
stay within their parents bounds") and 12d8706963f0 ("Revert "PCI: Make
sure bus number resources stay within their parents bounds"")?

This is implemented differently, but it seems like it might expose the same
problem we found with 1820ffdccb9b.

If you could take a look and confirm that "no, this does something
differently than 1820ffdccb9b did" or "yes, this might expose that problem
again," that would help.

Bjorn

> +	}
>  	/*
>  	 * Allocate a new bus, and inherit stuff from the parent..
>  	 */
> -- 
> 2.6.2.307.g37023ba
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
