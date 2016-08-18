Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754358AbcHSBSM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:18:12 -0400
Date: Thu, 18 Aug 2016 14:32:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, noaos@mellanox.com, haggaie@mellanox.com,
        ogerlitz@mellanox.com, liranl@mellanox.com
Subject: Re: [PATCH V3 3/3] vfio/pci: Add support for SR-IOV extended
 capablity
Message-ID: <20160818143200.13d9d0e5@t450s.home>
In-Reply-To: <1471505357-78110-4-git-send-email-ilyal@mellanox.com>
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
        <1471505357-78110-4-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 18 Aug 2016 10:29:17 +0300
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Add support for PCIE SR-IOV extended capability.
> The capability gives the VFIO user the following abilities:
> 1. Detect that the device has an SR-IOV capability
> 2. Change sriov_numvfs and read the corresponding changes in
> sriov_vf_offset and sriov_vf_stride
> 3. Probe vf bar sizes
> 
> Enabling and disable sriov is still done through the sysfs interface
> 
> Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
> Signed-off-by: Noa Osherovich <noaos@mellanox.com>
> Signed-off-by: Haggai Eran <haggaie@mellanox.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |  23 +++++-
>  drivers/vfio/pci/vfio_pci_config.c  | 151 ++++++++++++++++++++++++++++++++----
>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>  3 files changed, 157 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 6a203a7..807caf2c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1229,6 +1229,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
> +	mutex_init(&vdev->sriov_mutex);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {
> @@ -1317,14 +1318,32 @@ static const struct pci_error_handlers vfio_err_handlers = {
>  
>  static int vfio_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  {
> +	struct vfio_pci_device *vdev;
> +	struct vfio_device *device;
> +	int ret = 0;
> +
> +	device = vfio_device_get_from_dev(&pdev->dev);
> +	if (!device)
> +		return -EINVAL;
> +
> +	vdev = vfio_device_data(device);
> +	if (!vdev) {
> +		vfio_device_put(device);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&vdev->sriov_mutex);
>  	if (!num_vfs) {
>  		pci_disable_sriov(pdev);
> -		return 0;
> +		goto out;
>  	}
>  
> -	return pci_enable_sriov_with_override(pdev,
> +	ret =  pci_enable_sriov_with_override(pdev,
>  					      num_vfs,
>  					     "vfio-pci");
> +out:
> +	mutex_unlock(&vdev->sriov_mutex);

vfio_device_put(device);

> +	return ret;
>  }
>  
>  static struct pci_driver vfio_pci_driver = {
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 688691d..6c813d3 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -448,6 +448,35 @@ static __le32 vfio_generate_bar_flags(struct pci_dev *pdev, int bar)
>  	return cpu_to_le32(val);
>  }
>  
> +static void vfio_sriov_bar_fixup(struct vfio_pci_device *vdev,
> +				 int sriov_cap_start)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +	__le32 *bar;
> +	u64 mask;
> +
> +	bar = (__le32 *)&vdev->vconfig[sriov_cap_start + PCI_SRIOV_BAR];
> +
> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++, bar++) {

These are only defined when CONFIG_PCI_IOV

> +		if (!pci_resource_start(pdev, i)) {
> +			*bar = 0; /* Unmapped by host = unimplemented to user */
> +			continue;
> +		}
> +
> +		mask = ~(pci_iov_resource_size(pdev, i) - 1);
> +
> +		*bar &= cpu_to_le32((u32)mask);
> +		*bar |= vfio_generate_bar_flags(pdev, i);
> +
> +		if (*bar & cpu_to_le32(PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> +			bar++;
> +			*bar &= cpu_to_le32((u32)(mask >> 32));
> +			i++;
> +		}
> +	}
> +}
> +
>  /*
>   * Pretend we're hardware and tweak the values of the *virtual* PCI BARs
>   * to reflect the hardware capabilities.  This implements BAR sizing.
> @@ -901,6 +930,106 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
>  	return 0;
>  }
>  
> +static int __init init_pci_ext_cap_sriov_perm(struct perm_bits *perm)
> +{
> +	int i;
> +
> +	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_SRIOV]))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Virtualize the first dword of all express capabilities
> +	 * because it includes the next pointer.  This lets us later
> +	 * remove capabilities from the chain if we need to.
> +	 */
> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
> +
> +	/* VF Enable - Virtualized and writable

nit, comment style - multi-line comments as above.

Comment doesn't seem to match the code, VFE is neither virtualized nor
writable.

> +	 * Memory Space Enable - Non-virtualized and writable
> +	 */
> +	p_setw(perm, PCI_SRIOV_CTRL, NO_VIRT,
> +	       PCI_SRIOV_CTRL_MSE);
> +
> +	p_setw(perm, PCI_SRIOV_NUM_VF, (u16)NO_VIRT, (u16)ALL_WRITE);
> +	p_setw(perm, PCI_SRIOV_SUP_PGSIZE, (u16)ALL_VIRT, NO_WRITE);

Is this necessary?  What's the purpose in virtualizing it?  Per the
spec, it's read-only in hardware.

> +
> +	/* We cannot let user space application change the page size
> +	 * so we mark it as read only and trust the user application
> +	 * (e.g. qemu) to virtualize this correctly for the guest
> +	 */
> +	p_setw(perm, PCI_SRIOV_SYS_PGSIZE, (u16)ALL_VIRT, NO_WRITE);

But why do we virtualize it?

> +
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> +		p_setd(perm, PCI_SRIOV_BAR + 4 * i, ALL_VIRT, ALL_WRITE);
> +
> +	return 0;
> +}
> +
> +static int vfio_find_cap_start(struct vfio_pci_device *vdev, int pos)
> +{
> +	u8 cap;
> +	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
> +						 PCI_STD_HEADER_SIZEOF;
> +	cap = vdev->pci_config_map[pos];
> +
> +	if (cap == PCI_CAP_ID_BASIC)
> +		return 0;
> +
> +	/* XXX Can we have to abutting capabilities of the same type? */
> +	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
> +		pos--;
> +
> +	return pos;
> +}
> +
> +static int vfio_sriov_cap_config_read(struct vfio_pci_device *vdev, int pos,
> +				      int count, struct perm_bits *perm,
> +				      int offset, __le32 *val)
> +{
> +	int cap_start = vfio_find_cap_start(vdev, pos);
> +
> +	vfio_sriov_bar_fixup(vdev, cap_start);

Should we make an is_iov_bar() function for at least a little bit of
filtering?

> +	return vfio_default_config_read(vdev, pos, count, perm, offset, val);
> +}
> +
> +static int vfio_sriov_cap_config_write(struct vfio_pci_device *vdev, int pos,
> +				       int count, struct perm_bits *perm,
> +				       int offset, __le32 val)
> +{
> +	switch (offset) {
> +	case  PCI_SRIOV_NUM_VF:
> +	/* Per SR-IOV spec sec 3.3.10 and 3.3.11, First VF Offset
> +	 * and VF Stride may change when NumVFs changes.

This really seems more complicated than set forth here to virtualize.
For instance offset and stride are also affected by ARI, so if the ARI
settings between host and VM don't match, a user like QEMU is going to
need to virtualize offset, stride, and maybe even TotalVFs to
something appropriate for the VM.  There's also the question of why
the physical offset/stride matter at all to a VM when these devices
aren't being initialized in the VM address space and the user/hypervisor
is free to manage them however they see fit.  So I think the only
purpose of virtualizing any of this is so that a VM can potentially
match the bare hardware in the case where the VM and physical system are
sufficiently similar.  Is that correct?

nit, comment stule, blank line within the comment block below.

> +	 *
> +	 * Therefore we should pass valid writes to the hardware.
> +	 *
> +	 * Per SR-IOV spec sec 3.3.7
> +	 * The results are undefined if NumVFs is set to a value greater
> +	 * than TotalVFs.
> +	 * NumVFs may only be written while VF Enable is Clear.
> +	 * If NumVFs is written when VF Enable is Set, the results
> +	 * are undefined.
> +
> +	 * Avoid passing such writes to the Hardware just in case.
> +	 */
> +		mutex_lock(&vdev->sriov_mutex);
> +		if (pci_num_vf(vdev->pdev) ||
> +		    val > pci_sriov_get_totalvfs(vdev->pdev)) {
> +			mutex_unlock(&vdev->sriov_mutex);
> +			return count;
> +		}
> +
> +		pci_iov_set_numvfs(vdev->pdev, val);
> +		mutex_unlock(&vdev->sriov_mutex);
> +		break;
> +	default:
> +		break;
> +	}

Seems unnecessary to have a switch statement for a single case, can't
we just wrap this in a "if (offset == PCI_SRIOV_NUM_VF)" block?

> +
> +	return vfio_default_config_write(vdev, pos, count, perm,
> +					 offset, val);
> +}
> +
>  /*
>   * Initialize the shared permission tables
>   */
> @@ -916,6 +1045,7 @@ void vfio_pci_uninit_perm_bits(void)
>  
>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> +	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
>  }
>  
>  int __init vfio_pci_init_perm_bits(void)
> @@ -938,29 +1068,16 @@ int __init vfio_pci_init_perm_bits(void)
>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
>  
> +	ret |= init_pci_ext_cap_sriov_perm(&ecap_perms[PCI_EXT_CAP_ID_SRIOV]);
> +	ecap_perms[PCI_EXT_CAP_ID_SRIOV].readfn = vfio_sriov_cap_config_read;
> +	ecap_perms[PCI_EXT_CAP_ID_SRIOV].writefn = vfio_sriov_cap_config_write;
> +
>  	if (ret)
>  		vfio_pci_uninit_perm_bits();
>  
>  	return ret;
>  }
>  
> -static int vfio_find_cap_start(struct vfio_pci_device *vdev, int pos)
> -{
> -	u8 cap;
> -	int base = (pos >= PCI_CFG_SPACE_SIZE) ? PCI_CFG_SPACE_SIZE :
> -						 PCI_STD_HEADER_SIZEOF;
> -	cap = vdev->pci_config_map[pos];
> -
> -	if (cap == PCI_CAP_ID_BASIC)
> -		return 0;
> -
> -	/* XXX Can we have to abutting capabilities of the same type? */
> -	while (pos - 1 >= base && vdev->pci_config_map[pos - 1] == cap)
> -		pos--;
> -
> -	return pos;
> -}
> -
>  static int vfio_msi_config_read(struct vfio_pci_device *vdev, int pos,
>  				int count, struct perm_bits *perm,
>  				int offset, __le32 *val)
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 2128de8..02732eb 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -96,6 +96,8 @@ struct vfio_pci_device {
>  	struct eventfd_ctx	*err_trigger;
>  	struct eventfd_ctx	*req_trigger;
>  	struct list_head	dummy_resources_list;
> +	struct mutex		sriov_mutex;
> +

whitespace

>  };
>  
>  #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)

