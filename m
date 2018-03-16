Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752219AbeCPQez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 12:34:55 -0400
Date: Fri, 16 Mar 2018 18:34:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Subject: Re: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
Message-ID: <20180316183042-mutt-send-email-mst@kernel.org>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315184132.3102.90947.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:42:41AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Hardware-realized virtio_pci devices can implement SR-IOV, so this
> patch enables its use. The device in question is an upcoming Intel
> NIC that implements both a virtio_net PF and virtio_net VFs. These
> are hardware realizations of what has been up to now been a software
> interface.
> 
> The device in question has the following 4-part PCI IDs:
> 
> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe
> 
> The patch currently needs no check for device ID, because the callback
> will never be made for devices that do not assert the capability or
> when run on a platform incapable of SR-IOV.
> 
> One reason for this patch is because the hardware requires the
> vendor ID of a VF to be the same as the vendor ID of the PF that
> created it. So it seemed logical to simply have a fully-functioning
> virtio_net PF create the VFs. This patch makes that possible.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

So if and when virtio PFs can manage the VFs, then we can
add a feature bit for that?
Seems reasonable.

Also, I am guessing that hardware implementations will want
to add things like stong memory barriers - I guess we
will add new feature bits for that too down the road?


> ---
> 
> v4: Dropped call to pci_disable_sriov in virtio_pci_remove function
> v5: Replaced call to pci_sriov_configure_unmanaged with
>         pci_sriov_configure_simple
> v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
> v7: No code change, added Reviewed-by
> 
>  drivers/virtio/virtio_pci_common.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 48d4d1cf1cb6..67a227fd7aa0 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -596,6 +596,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  #ifdef CONFIG_PM_SLEEP
>  	.driver.pm	= &virtio_pci_pm_ops,
>  #endif
> +	.sriov_configure = pci_sriov_configure_simple,
>  };
>  
>  module_pci_driver(virtio_pci_driver);
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
