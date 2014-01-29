Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39151 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaA2Vg7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 16:36:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id tp5so2595019ieb.5
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 13:36:59 -0800 (PST)
Date: Wed, 29 Jan 2014 14:36:55 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/9] vfio: Use pci_enable_msi_range() and
 pci_enable_msix_range()
Message-ID: <20140129213655.GC16825@google.com>
References: <cover.1389904166.git.agordeev@redhat.com>
 <c6523b6507c3aa0ab911e111f501699dce99c3f4.1389904167.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c6523b6507c3aa0ab911e111f501699dce99c3f4.1389904167.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 17, 2014 at 05:02:21PM +0100, Alexander Gordeev wrote:
> As result deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range() and pci_enable_msix_range()
> interfaces.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Applied to my pci/msi branch, thanks!

> ---
>  drivers/vfio/pci/vfio_pci_intrs.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 641bc87..4a9db1d 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -482,15 +482,19 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
>  		for (i = 0; i < nvec; i++)
>  			vdev->msix[i].entry = i;
>  
> -		ret = pci_enable_msix(pdev, vdev->msix, nvec);
> -		if (ret) {
> +		ret = pci_enable_msix_range(pdev, vdev->msix, 1, nvec);
> +		if (ret < nvec) {
> +			if (ret > 0)
> +				pci_disable_msix(pdev);
>  			kfree(vdev->msix);
>  			kfree(vdev->ctx);
>  			return ret;
>  		}
>  	} else {
> -		ret = pci_enable_msi_block(pdev, nvec);
> -		if (ret) {
> +		ret = pci_enable_msi_range(pdev, 1, nvec);
> +		if (ret < nvec) {
> +			if (ret > 0)
> +				pci_disable_msi(pdev);
>  			kfree(vdev->ctx);
>  			return ret;
>  		}
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
