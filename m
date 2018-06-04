Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Jun 2018 19:32:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: bhelgaas@google.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        linux-pci@vger.kernel.org, dan.daly@intel.com,
        mark.d.rustad@intel.com, alexander.h.duyck@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH v3] virtio_pci: support enabling VFs
Message-ID: <20180604192222-mutt-send-email-mst@kernel.org>
References: <20180601040239.1151-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601040239.1151-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 12:02:39PM +0800, Tiwei Bie wrote:
> There is a new feature bit allocated in virtio spec to
> support SR-IOV (Single Root I/O Virtualization):
> 
> https://github.com/oasis-tcs/virtio-spec/issues/11
> 
> This patch enables the support for this feature bit in
> virtio driver.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---

OK but what about freeze/restore functions?

I also wonder about kexec - virtio.c currently does:

        /* We always start by resetting the device, in case a previous
         * driver messed it up.  This also tests that code path a little. */
        dev->config->reset(dev);

Do we need to do something like this for sriov?

I also wonder whether PCI core should disable sriov for us.


I wish there was a patch emulating this without vDPA for QEMU,
would make it easy to test your patches. Do you happen
to have something like this?

Thanks,


> v3:
> - Drop the acks;
> 
> v2:
> - Disable VFs when unbinding the driver (Alex, MST);
> - Don't use pci_sriov_configure_simple (Alex);
> 
>  drivers/virtio/virtio_pci_common.c | 30 ++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
>  include/uapi/linux/virtio_config.h |  7 ++++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 48d4d1cf1cb6..1d4467b2dc31 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -577,6 +577,8 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> +	pci_disable_sriov(pci_dev);
> +
>  	unregister_virtio_device(&vp_dev->vdev);
>  
>  	if (vp_dev->ioaddr)
> @@ -588,6 +590,33 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	put_device(dev);
>  }
>  
> +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
> +{
> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> +	struct virtio_device *vdev = &vp_dev->vdev;
> +	int ret;
> +
> +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return -EBUSY;
> +
> +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> +		return -EINVAL;
> +
> +	if (pci_vfs_assigned(pci_dev))
> +		return -EPERM;
> +
> +	if (num_vfs == 0) {
> +		pci_disable_sriov(pci_dev);
> +		return 0;
> +	}
> +
> +	ret = pci_enable_sriov(pci_dev, num_vfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	return num_vfs;
> +}
> +
>  static struct pci_driver virtio_pci_driver = {
>  	.name		= "virtio-pci",
>  	.id_table	= virtio_pci_id_table,
> @@ -596,6 +625,7 @@ static struct pci_driver virtio_pci_driver = {
>  #ifdef CONFIG_PM_SLEEP
>  	.driver.pm	= &virtio_pci_pm_ops,
>  #endif
> +	.sriov_configure = virtio_pci_sriov_configure,
>  };
>  
>  module_pci_driver(virtio_pci_driver);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 2555d80f6eec..07571daccfec 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -153,14 +153,28 @@ static u64 vp_get_features(struct virtio_device *vdev)
>  	return features;
>  }
>  
> +static void vp_transport_features(struct virtio_device *vdev, u64 features)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +
> +	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> +			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> +		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> +}
> +
>  /* virtio config->finalize_features() implementation */
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	u64 features = vdev->features;
>  
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
>  
> +	/* Give virtio_pci a chance to accept features. */
> +	vp_transport_features(vdev, features);
> +
>  	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
>  		dev_err(&vdev->dev, "virtio: device uses modern interface "
>  			"but does not have VIRTIO_F_VERSION_1\n");
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 308e2096291f..b7c1f4e7d59e 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -49,7 +49,7 @@
>   * transport being used (eg. virtio_ring), the rest are per-device feature
>   * bits. */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		34
> +#define VIRTIO_TRANSPORT_F_END		38
>  
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -71,4 +71,9 @@
>   * this is for compatibility with legacy systems.
>   */
>  #define VIRTIO_F_IOMMU_PLATFORM		33
> +
> +/*
> + * Does the device support Single Root I/O Virtualization?
> + */
> +#define VIRTIO_F_SR_IOV			37
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> -- 
> 2.17.0
