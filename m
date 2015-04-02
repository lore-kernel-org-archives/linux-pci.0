Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Apr 2015 11:55:32 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 06/10] virtio_pci: drop msi_off on probe
Message-ID: <20150402035532.GI15412@fam-t430.nay.redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-7-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-7-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
> pci core now disables msi on probe automatically,
> drop this from device-specific code.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index e894eb2..806bb2c 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -501,9 +501,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	INIT_LIST_HEAD(&vp_dev->virtqueues);
>  	spin_lock_init(&vp_dev->lock);
>  
> -	/* Disable MSI/MSIX to bring device to a known good state. */
> -	pci_msi_off(pci_dev);
> -
>  	/* enable the device */
>  	rc = pci_enable_device(pci_dev);
>  	if (rc)
> -- 
> MST
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
