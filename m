Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750987AbeBYPUv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Feb 2018 10:20:51 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [virtio-dev] [RFC PATCH V2] virtio_pci: Add SR-IOV support
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
Date: Sun, 25 Feb 2018 17:20:47 +0200
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com,
        alexander.duyck@gmail.com, mst@redhat.com
Message-Id: <7B7DC8E0-9F6A-403F-8077-39FC3939482E@redhat.com>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
To: Mark Rustad <mark.d.rustad@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> On 22 Feb 2018, at 19:52, Mark Rustad <mark.d.rustad@intel.com> wrote:
> 
> Hardware-realized virtio-pci devices can implement SR-IOV, so this
> patch enables its use. The device in question is an upcoming Intel
> NIC that implements both a virtio-net PF and virtio-net VFs. These
> are hardware realizations of what has been up to now been a software
> interface.
> 
> The device in question has the following 4-part PCI IDs:
> 
> PF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 15fe
> VF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 05fe

Small mistake in the commit message. Red Hat (Qumranet) vendor ID is 1af4, virtio-net device ID is 1041.
Should be:
PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

Best regards,
Yan.

> 
> The patch needs no check for device ID, because the callback will
> never be made for devices that do not assert the capability or
> when run on a platform incapable of SR-IOV.
> 
> One reason for this patch is because the hardware requires the
> vendor ID of a VF to be the same as the vendor ID of the PF that
> created it. So it seemed logical to simply have a fully-functioning
> virtio-net PF create the VFs. This patch makes that possible.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> Changes in V2:
> - Simplified logic from previous version, removed added driver variable
> - Disable SR-IOV on driver removal excapt when VFs are assigned
> - Sent as RFC to virtio-dev, linux-pci, netdev, lkml and others
> ---
> drivers/virtio/virtio_pci_common.c |   47 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 48d4d1cf1cb6..78b53ffc4cee 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -572,6 +572,47 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> 	return rc;
> }
> 
> +#ifdef CONFIG_PCI_IOV
> +static int virtio_pci_sriov_disable(struct pci_dev *pci_dev)
> +{
> +	/* If vfs are assigned we cannot shut down SR-IOV without causing
> +	 * issues, so just leave the hardware available.
> +	 */
> +	if (pci_vfs_assigned(pci_dev)) {
> +		dev_warn(&pci_dev->dev,
> +			 "Unloading driver while VFs are assigned - VFs will not be deallocated\n");
> +		return -EPERM;
> +	}
> +	pci_disable_sriov(pci_dev);
> +	return 0;
> +}
> +
> +static int virtio_pci_sriov_enable(struct pci_dev *pci_dev, int num_vfs)
> +{
> +	int rc = 0;
> +
> +	if (pci_num_vf(pci_dev))
> +		return -EINVAL;
> +
> +	rc = pci_enable_sriov(pci_dev, num_vfs);
> +	if (rc) {
> +		dev_warn(&pci_dev->dev, "Failed to enable PCI sriov: %d\n", rc);
> +		return rc;
> +	}
> +	dev_info(&pci_dev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
> +	return num_vfs;
> +}
> +
> +static int virtio_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
> +{
> +	if (num_vfs)
> +		return virtio_pci_sriov_enable(dev, num_vfs);
> +	if (!pci_num_vf(dev))
> +		return -EINVAL;
> +	return virtio_pci_sriov_disable(dev);
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
> static void virtio_pci_remove(struct pci_dev *pci_dev)
> {
> 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> @@ -584,6 +625,9 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
> 	else
> 		virtio_pci_modern_remove(vp_dev);
> 
> +#ifdef CONFIG_PCI_IOV
> +	virtio_pci_sriov_disable(pci_dev);
> +#endif
> 	pci_disable_device(pci_dev);
> 	put_device(dev);
> }
> @@ -596,6 +640,9 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
> #ifdef CONFIG_PM_SLEEP
> 	.driver.pm	= &virtio_pci_pm_ops,
> #endif
> +#ifdef CONFIG_PCI_IOV
> +	.sriov_configure = virtio_pci_sriov_configure,
> +#endif
> };
> 
> module_pci_driver(virtio_pci_driver);
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
