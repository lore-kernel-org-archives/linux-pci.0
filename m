Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ACAC32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11EE2075C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11EE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJKXB3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeJKXB3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EA85308125E;
        Thu, 11 Oct 2018 15:33:48 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5F478BB13;
        Thu, 11 Oct 2018 15:33:45 +0000 (UTC)
Date:   Thu, 11 Oct 2018 09:33:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v5 06/11] PCI: Expose reset type to users of
 pci_reset_bus()
Message-ID: <20181011093344.76725f36@w520.home>
In-Reply-To: <20181011045008.32212-6-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
        <20181011045008.32212-6-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 11 Oct 2018 15:33:48 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Oct 2018 04:49:58 +0000
Sinan Kaya <okaya@kernel.org> wrote:

> Looking to have more control between the users of the API vs. what the API
> can do internally. The new reset_type tells the PCI core about the bounds
> of the request.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci.c           | 17 ++++++++++++++---
>  drivers/vfio/pci/vfio_pci.c |  6 ++++--
>  include/linux/pci.h         |  2 +-
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a1a7dd6988be..a3a1c2a5e0cf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5236,13 +5236,24 @@ static int __pci_reset_bus(struct pci_bus *bus)
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
> +	if ((reset_type & PCI_RESET_LINK) == PCI_RESET_LINK)
> +		return (!pci_probe_reset_slot(pdev->slot)) ?
> +				__pci_reset_slot(pdev->slot) :
> +				__pci_reset_bus(pdev->bus);
> +
> +	if ((reset_type & PCI_RESET_BUS) == PCI_RESET_BUS)
> +		return __pci_reset_bus(pdev->bus);
> +
> +	if ((reset_type & PCI_RESET_SLOT) == PCI_RESET_SLOT)
> +		return __pci_reset_slot(pdev->slot);
> +
> +	return -EINVAL;


Having three cases here still seems strange.  The below still has some
duplicate probing but doesn't it do the same thing with less redundancy?

if ((reset_type & PCI_RESET_SLOT) && !pci_probe_reset_slot(pdev->slot))
	return __pci_reset_slot(pdev->slot);

if ((reset_type & PCI_RESET_BUS) && !pci_probe_reset_bus(pdev->slot))
	return __pci_reset_bus(pdev->bus);

return -EINVAL;

Thanks,
Alex

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
> index 1c120cf00dd8..cf1e847ea02e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1171,7 +1171,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
>  int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
>  int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
> -int pci_reset_bus(struct pci_dev *dev);
> +int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);

