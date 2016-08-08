Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54756 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcHHVJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 17:09:06 -0400
Date: Mon, 8 Aug 2016 16:08:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hariprasad Shenai <hariprasad@chelsio.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, leedom@chelsio.com,
	swise@opengridcomputing.com, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] pci: Use same logic in pci_vpd_read as that of
 pci_vpd_write
Message-ID: <20160808210858.GC6129@localhost>
References: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Hannes]

Hi Hariprasad,

On Sat, Jun 25, 2016 at 09:38:42AM +0530, Hariprasad Shenai wrote:
> The new implementation of pci_read_vpd() silently fails to perform a VPD
> read and allows the caller to use random stack garbage in the read buffer
> without knowing that it's not really VPD contents. If any portion of the
> VPD read isn't going to be performed, we should signal that back to the
> caller.  We could either return an error or we could return the number of
> bytes actually read. The problem with the latter is that it would require
> changing every single caller to check for Requested Read Length == Actual
> Read Length. Returning an error is the more conservative fix and allows
> for rapid diagnosis of problems.

By "the new implementation of pci_read_vpd()", are you referring to
104daa71b396 ("PCI: Determine actual VPD size on first access")?
Please be explicit about which change you mean because it helps people
review the change and figure out whether it should be backported.

I think the existing semantics are the same as for the read(2)
syscall: we return the number of bytes read, which may be less than
the size requested, and callers may use random garbage if they don't
check for short reads.

If we make pci_read_vpd() return error instead of a short read, how do
callers figure out how much to request?

In the current tree, I think the following callers don't handle short
reads correctly:

  cxl_pci_read_adapter_vpd() (cxl, used via read_vpd())
  eeprom_rd_phys() (cxgb4)
  t4_get_raw_vpd_params() (cxgb4)
  sky2_show_vpd() (sky2)
  efx_probe_vpd_strings() (efx)
  vfio_vpd_config_write() (vfio)

That's not a very long list, so we could certainly fix them.

> Signed-off-by: Casey Leedom <leedom@chelsio.com>
> Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
> ---
>  drivers/pci/access.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb8fba3..113637de79bf 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -405,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	if (vpd->len == 0)
>  		return -EIO;
>  
> -	if (pos > vpd->len)
> -		return 0;
> -
> -	if (end > vpd->len) {
> -		end = vpd->len;
> -		count = end - pos;
> -	}
> +	if (end > vpd->len)
> +		return -EINVAL;
>  
>  	if (mutex_lock_killable(&vpd->lock))
>  		return -EINTR;
> -- 
> 2.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
