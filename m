Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755682AbcJaSSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Oct 2016 14:18:53 -0400
Date: Mon, 31 Oct 2016 13:18:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org,
        david.vrabel@citrix.com, boris.ostrovsky@oracle.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 08/12] xen: make use of xenbus_read_unsigned() in
 xen-pcifront
Message-ID: <20161031181849.GA11486@bhelgaas-glaptop.roam.corp.google.com>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
 <1477932510-28594-9-git-send-email-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477932510-28594-9-git-send-email-jgross@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 05:48:26PM +0100, Juergen Gross wrote:
> Use xenbus_read_unsigned() instead of xenbus_scanf() when possible.
> This requires to change the type of the read from int to unsigned,
> but this case has been wrong before: negative values are not allowed
> for the modified case.
> 
> Cc: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will be merged with the rest of the series via some tree
other than mine.

> ---
>  drivers/pci/xen-pcifront.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index d6ff5e8..8fc2e95 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -1038,10 +1038,8 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
>  			err = -ENOMEM;
>  			goto out;
>  		}
> -		err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend, str, "%d",
> -				   &state);
> -		if (err != 1)
> -			state = XenbusStateUnknown;
> +		state = xenbus_read_unsigned(pdev->xdev->otherend, str,
> +					     XenbusStateUnknown);
>  
>  		if (state != XenbusStateClosing)
>  			continue;
> -- 
> 2.6.6
> 
