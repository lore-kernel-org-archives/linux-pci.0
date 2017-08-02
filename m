Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751181AbdHBEol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 00:44:41 -0400
Date: Tue, 1 Aug 2017 22:44:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/2] PCI: handle CRS returned by device after FLR
Message-ID: <20170801224440.3f677a8d@w520.home>
In-Reply-To: <1501645453-22842-2-git-send-email-okaya@codeaurora.org>
References: <1501645453-22842-1-git-send-email-okaya@codeaurora.org>
        <1501645453-22842-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue,  1 Aug 2017 23:44:13 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
> following a Function Level Reset (FLR) request to indicate that it is
> not ready to accept new requests. CRS is defined in PCIe r3.1, sec 2.3.1.
> Request Handling Rules and CRS usage in FLR context is mentioned in
> PCIe r3.1, sec 6.6.2. Function-Level Reset.
> 
> Adding a vendor ID read if this is a physical function before attempting
> to read any other registers on the endpoint. A CRS indication will only
> be given if the address to be read is vendor ID register.
> pci_bus_read_dev_vendor_id() knows how to deal with CRS returned values.
> 
> If pci_bus_read_dev_vendor_id() fails, it prints a user visible warning
> after provided 1 second timeout is reached. pci_flr_wait() will keep
> calling this function 60 times to allow up to 60 seconds to be consistent
> with the rest of the kernel CRS timeout handling.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2ed604a..25c7a83 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3813,14 +3813,16 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  
>  /*
>   * We should only need to wait 100ms after FLR for virtual functions.
> - * Wait for up to 1000ms for config space to return something other than -1.
> - * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
> - * dword because VFs don't implement the 1st dword.
> + * Wait for up to 60s for config space to return something other than -1.
> + * Intel IGD requires 1s when an LCD panel is attached.  We use
> + * pci_bus_read_dev_vendor_id() for reading the vendor ID as it handles
> + * CRS gracefully.

nit, stating that IGD requires 1s with an LCD panel is a
misinterpretation of the previous comment.  In fact the original commit
only mentions 300ms.  I think perhaps 1s was simply a nice round
interval.

>   */
>  static void pci_flr_wait(struct pci_dev *dev)
>  {
>  	int i = 0;
>  	u32 id;
> +	bool ret;
>  
>  	if (dev->is_virtfn) {
>  		msleep(100);
> @@ -3828,15 +3830,15 @@ static void pci_flr_wait(struct pci_dev *dev)
>  	}
>  
>  	do {
> -		msleep(100);
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	} while (i++ < 10 && id == ~0);
> +		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
> +						 1000);

Is it a problem that there's now zero delay between the FLR and first
attempt to read config space?  Seems like there should be a 100ms
delay before we start trying.  This is also going to print a kernel
warning 60 times in the course of getting to a 60s timeout, why not let
pci_bus_read_dev_vendor_id() manage the entire timeout?  Are we only
trying to preserve the dev_info() below?  Thanks,

Alex

> +	} while (i++ < 60 && !ret);
>  
> -	if (id == ~0)
> +	if (!ret)
>  		dev_warn(&dev->dev, "Failed to return from FLR\n");
>  	else if (i > 1)
> -		dev_info(&dev->dev, "Required additional %dms to
> return from FLR\n",
> -			 (i - 1) * 100);
> +		dev_info(&dev->dev, "Required additional %ds to
> return from FLR\n",
> +			 (i - 1));
>  }
>  
>  /**
