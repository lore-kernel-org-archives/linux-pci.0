Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdELDUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 May 2017 23:20:53 -0400
Date: Thu, 11 May 2017 21:20:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Cheng, Collins" <Collins.Cheng@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Message-ID: <20170511212051.3b802325@t450s.home>
In-Reply-To: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 12 May 2017 02:50:32 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Helgaas,
> 
> Some AMD GPUs have hardware support for graphics SR-IOV.
> If the SR-IOV capable GPU is plugged into the SR-IOV incapable
> platform. It would cause a problem on PCI resource allocation in
> current Linux kernel.
> 
> Therefore in order to allow the PF (Physical Function) device of
> SR-IOV capable GPU to work on the SR-IOV incapable platform,
> it is required to verify conditions for initializing BAR resources
> on AMD SR-IOV capable GPUs.
> 
> If the device is an AMD graphics device and it supports
> SR-IOV it will require a large amount of resources.
> Before calling sriov_init() must ensure that the system
> BIOS also supports SR-IOV and that system BIOS has been
> able to allocate enough resources.
> If the VF BARs are zero then the system BIOS does not
> support SR-IOV or it could not allocate the resources
> and this platform will not support AMD graphics SR-IOV.
> Therefore do not call sriov_init().
> If the system BIOS does support SR-IOV then the VF BARs
> will be properly initialized to non-zero values.
> 
> Below is the patch against to Kernel 4.8 & 4.9. Please review.
> 
> I checked the drivers/pci/quirks.c, it looks the workarounds/fixes in
> quirks.c are for specific devices and one or more device ID are defined
> for the specific devices. However my patch is for all AMD SR-IOV
> capable GPUs, that includes all existing and future AMD server GPUs.
> So it doesn't seem like a good fit to put the fix in quirks.c.


Why is an AMD graphics card unique here?  Doesn't sriov_init() always
need to be able to deal with devices of any type where the BIOS hasn't
initialized the SR-IOV capability?  Some SR-IOV devices can fit their
VFs within a minimum bridge aperture, most cannot.  I don't understand
why the VF resource requirements being exceptionally large dictates
that they receive special handling.  Thanks,

Alex

> Signed-off-by: Collins Cheng <collins.cheng@amd.com>
> ---
>  drivers/pci/iov.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index e30f05c..e4f1405 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -523,6 +523,45 @@ static void sriov_restore_state(struct pci_dev *dev)
>  		msleep(100);
>  }
>  
> +/*
> + * pci_vf_bar_valid - check if VF BARs have resource allocated
> + * @dev: the PCI device
> + * @pos: register offset of SR-IOV capability in PCI config space
> + * Returns true any VF BAR has resource allocated, false
> + * if all VF BARs are empty.
> + */
> +static bool pci_vf_bar_valid(struct pci_dev *dev, int pos)
> +{
> +	int i;
> +	u32 bar_value;
> +	u32 bar_size_mask = ~(PCI_BASE_ADDRESS_SPACE |
> +			PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +			PCI_BASE_ADDRESS_MEM_PREFETCH);
> +
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +		pci_read_config_dword(dev, pos + PCI_SRIOV_BAR + i * 4, &bar_value);
> +		if (bar_value & bar_size_mask)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * is_amd_display_adapter - check if it is an AMD/ATI GPU device
> + * @dev: the PCI device
> + *
> + * Returns true if device is an AMD/ATI display adapter,
> + * otherwise return false.
> + */
> +
> +static bool is_amd_display_adapter(struct pci_dev *dev)
> +{
> +	return (((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
> +		(dev->vendor == PCI_VENDOR_ID_ATI ||
> +		dev->vendor == PCI_VENDOR_ID_AMD));
> +}
> +
>  /**
>   * pci_iov_init - initialize the IOV capability
>   * @dev: the PCI device
> @@ -537,9 +576,27 @@ int pci_iov_init(struct pci_dev *dev)
>  		return -ENODEV;
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> -	if (pos)
> -		return sriov_init(dev, pos);
> -
> +	if (pos) {
> +	/*
> +	 * If the device is an AMD graphics device and it supports
> +	 * SR-IOV it will require a large amount of resources.
> +	 * Before calling sriov_init() must ensure that the system
> +	 * BIOS also supports SR-IOV and that system BIOS has been
> +	 * able to allocate enough resources.
> +	 * If the VF BARs are zero then the system BIOS does not
> +	 * support SR-IOV or it could not allocate the resources
> +	 * and this platform will not support AMD graphics SR-IOV.
> +	 * Therefore do not call sriov_init().
> +	 * If the system BIOS does support SR-IOV then the VF BARs
> +	 * will be properly initialized to non-zero values.
> +	 */
> +		if (is_amd_display_adapter(dev)) {
> +			if (pci_vf_bar_valid(dev, pos))
> +				return sriov_init(dev, pos);
> +		} else {
> +			return sriov_init(dev, pos);
> +		}
> +	}
>  	return -ENODEV;
>  }
>  
