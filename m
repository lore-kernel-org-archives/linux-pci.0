Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43305 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeDTWKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Apr 2018 18:10:17 -0400
Subject: Re: [pci PATCH v8 2/4] ena: Migrate over to unmanaged SR-IOV support
To: Alexander Duyck <alexander.h.duyck@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420162841.46077.17967.stgit@ahduyck-green-test.jf.intel.com>
From: Gregory Rose <gvrose8192@gmail.com>
Message-ID: <411245b6-fb34-0494-aa5d-1ed5bc69a18c@gmail.com>
Date: Fri, 20 Apr 2018 15:10:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180420162841.46077.17967.stgit@ahduyck-green-test.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/20/2018 9:30 AM, Alexander Duyck wrote:
> Instead of implementing our own version of a SR-IOV configuration stub in
> the ena driver we can just reuse the existing
> pci_sriov_configure_simple function.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>
> v5: Replaced call to pci_sriov_configure_unmanaged with
>          pci_sriov_configure_simple
> v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
> v7: No change
>
>   drivers/net/ethernet/amazon/ena/ena_netdev.c |   28 +-------------------------
>   1 file changed, 1 insertion(+), 27 deletions(-)
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index a822e70..f2af87d 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -3386,32 +3386,6 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   }
>   
>   /*****************************************************************************/
> -static int ena_sriov_configure(struct pci_dev *dev, int numvfs)
> -{
> -	int rc;
> -
> -	if (numvfs > 0) {
> -		rc = pci_enable_sriov(dev, numvfs);
> -		if (rc != 0) {
> -			dev_err(&dev->dev,
> -				"pci_enable_sriov failed to enable: %d vfs with the error: %d\n",
> -				numvfs, rc);
> -			return rc;
> -		}
> -
> -		return numvfs;
> -	}
> -
> -	if (numvfs == 0) {
> -		pci_disable_sriov(dev);
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -/*****************************************************************************/
> -/*****************************************************************************/
>   
>   /* ena_remove - Device Removal Routine
>    * @pdev: PCI device information struct
> @@ -3526,7 +3500,7 @@ static int ena_resume(struct pci_dev *pdev)
>   	.suspend    = ena_suspend,
>   	.resume     = ena_resume,
>   #endif
> -	.sriov_configure = ena_sriov_configure,
> +	.sriov_configure = pci_sriov_configure_simple,
>   };
>   
>   static int __init ena_init(void)
>

Reviewed-by: Greg Rose <gvrose8192@gmail.com>
