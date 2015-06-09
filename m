Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Jun 2015 11:46:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 15/18] NTB: Improve performance with write combining
Message-ID: <20150609164632.GG23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <bc5eb3dd58e308b06a3a7464627704210c175394.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc5eb3dd58e308b06a3a7464627704210c175394.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:44:42AM -0400, Allen Hubbe wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Changing the memory window BAR mappings to write combining significantly
> boosts the performance.  We will also use memcpy that utilizies

s/utilizies/uses/

> non-temporal store which showed performance improement when doing

s/improement/improvement/

> non-cached memcpys.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index dc14ec81c43e..528ea0af6d54 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -58,6 +58,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/uaccess.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>  
> @@ -993,7 +994,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  		if (rc)
>  			goto err1;
>  
> -		mw->vbase = ioremap(mw->phys_addr, mw->phys_size);
> +		mw->vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
>  		if (!mw->vbase) {
>  			rc = -ENOMEM;
>  			goto err1;
> @@ -1375,7 +1376,11 @@ static void ntb_tx_copy_callback(void *data)
>  
>  static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
>  {
> -	memcpy_toio(offset, entry->buf, entry->len);
> +	/*
> +	 * Using non-temporal mov to improve performance on non-cached
> +	 * writes. Even though we aren't actually copying from user space.
> +	 */
> +	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);

__copy_from_user_inatomic_nocache() only exists on x86, but this file looks
like it's intended to be arch-agnostic?

>  
>  	/* Ensure that the data is fully copied out before setting the flags */
>  	wmb();
> -- 
> 2.4.0.rc0.43.gcf8a8c6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
