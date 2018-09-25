Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC9EC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEC92086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttLkvLla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEC92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZDDe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeIZDDe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 23:03:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAF320877;
        Tue, 25 Sep 2018 20:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537908850;
        bh=1ml6EAnagJSqSlHpimClO5YOHV/0/YCAYxuYYaarPeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttLkvLlauyg24iYhqyXOiAytPCCyKZ3UgeVatvUWLaVnfYIm/tsekZ0ov4b6yQMDj
         qPqaeVMO40fZRkgUrbzrAzn9+e9dU5+m31MmanCQdBexiugdX7wTVUWtSCR/pHhG0/
         0EB8r2w69R55UiBt/PBkJTNj+ZeyelyxSv5r6NnA=
Date:   Tue, 25 Sep 2018 15:54:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v4 6/6] PCI: Expose reset type to users of pci_reset_bus()
Message-ID: <20180925205408.GD80129@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919163037.13497-7-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 04:30:37PM +0000, Sinan Kaya wrote:
> Looking to have more control between the users of the API vs. what the API
> can do internally. The new reset_type tells the PCI core about the bounds
> of the request.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci.c           | 18 +++++++++++++++---
>  drivers/vfio/pci/vfio_pci.c |  6 ++++--
>  include/linux/pci.h         |  2 +-
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b4f14419bd51..f11d29f32119 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5232,13 +5232,25 @@ static int __pci_reset_bus(struct pci_bus *bus)
>  /**
>   * pci_reset_bus - Try to reset a PCI bus
>   * @pdev: top level PCI device to reset via slot/bus
> + * @reset_type: resets to try
>   *
>   * Same as above except return -EAGAIN if the bus cannot be locked
>   */
> -int pci_reset_bus(struct pci_dev *pdev)
> +int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
>  {
> -	return (!pci_probe_reset_slot(pdev->slot)) ?
> -	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> +	if (reset_type & PCI_RESET_LINK) {
> +		return (!pci_probe_reset_slot(pdev->slot)) ?
> +				__pci_reset_slot(pdev->slot) :
> +				__pci_reset_bus(pdev->bus);
> +	}
> +
> +	if (reset_type & PCI_RESET_BUS)
> +		return __pci_reset_bus(pdev->bus);
> +
> +	if (reset_type & PCI_RESET_SLOT)
> +		return __pci_reset_slot(pdev->slot);

I don't understand this code.  We have

  #define PCI_RESET_LINK         (PCI_RESET_SLOT | PCI_RESET_BUS)

so if either PCI_RESET_BUS or PCI_RESET_SLOT is set, we should take
the first "if" above, which always returns, and the last two should
never be reached.  What am I missing?

> +
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bus);
>  
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index fe7ada997c51..0e80c72b1eaa 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1015,7 +1015,8 @@ static long vfio_pci_ioctl(void *device_data,
>  						    &info, slot);
>  		if (!ret)
>  			/* User has access, do the reset */
> -			ret = pci_reset_bus(vdev->pdev);
> +			ret = pci_reset_bus(vdev->pdev,
> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);

This is the only place in the whole series where a caller uses
something other than PCI_RESET_ANY.  Inquiring minds want to know why.
I'm sure it's the right thing to do, it's just that we'll need to know
how to choose in future cases.

>  
>  hot_reset_release:
>  		for (i--; i >= 0; i--)
> @@ -1390,7 +1391,8 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
>  	}
>  
>  	if (needs_reset)
> -		ret = pci_reset_bus(vdev->pdev);
> +		ret = pci_reset_bus(vdev->pdev,
> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
>  
>  put_devs:
>  	for (i = 0; i < devs.cur_index; i++) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4fdddcb85066..85f48e156753 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1128,7 +1128,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
>  int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
>  int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
> -int pci_reset_bus(struct pci_dev *dev);
> +int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
> -- 
> 2.18.0
> 
