Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeCTXCF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:05 -0400
Date: Tue, 20 Mar 2018 18:02:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>
Subject: Re: [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not
 supported
Message-ID: <20180320230201.GC137590@bhelgaas-glaptop.roam.corp.google.com>
References: <20171219210643.24615-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219210643.24615-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 02:06:40PM -0700, Keith Busch wrote:
> Getting the AER information is documented to return 0 when it failed to
> get the information.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Keith, I'm sorry, but I lost track of where we're at with this series.
Can you repost a fresh version if it's still applicable?

Don't worry about rebasing it to anything other than v4.16-rc1 (my
"master" branch).  I might have added some conflicting things, but
I'll take care of resolving any conflicts.

> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 744805232155..ea0dc1cc7fc7 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -660,7 +660,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	/* The device might not support AER */
>  	if (!pos)
> -		return 1;
> +		return 0;
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
> -- 
> 2.13.6
> 
