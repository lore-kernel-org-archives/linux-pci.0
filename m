Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Cheng, Collins" <Collins.Cheng@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Subject: RE: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Date: Fri, 12 May 2017 03:42:46 +0000
Message-ID: <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
 <20170511212051.3b802325@t450s.home>
In-Reply-To: <20170511212051.3b802325@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Williamson,

GPU card needs more BAR aperture resource than other PCI devices. For examp=
le, Intel SR-IOV network card only require 512KB memory resource for all VF=
s. AMD SR-IOV GPU card needs 256MB x16 VF =3D 4GB memory resource for frame=
 buffer BAR aperture.

If the system BIOS supports SR-IOV, it will reserve enough resource for all=
 VF BARs. If the system BIOS doesn't support SR-IOV or cannot allocate the =
enough resource for VF BARs, only PF BAR will be assigned and VF BARs are e=
mpty. Then system boots to Linux kernel and kernel doesn't check if the VF =
BARs are empty or valid. Kernel will re-assign the BAR resources for PF and=
 all VFs. The problem I saw is that kernel will fail to allocate PF BAR res=
ource because some resources are assigned to VF, this is not expected. So k=
ernel might need to do some check before re-assign the PF/VF resource, so t=
hat PF device will be correctly assigned BAR resource and user can use PF d=
evice.

-Collins Cheng

-----Original Message-----
From: Alex Williamson [mailto:alex.williamson@redhat.com]=20
Sent: Friday, May 12, 2017 11:21 AM
To: Cheng, Collins <Collins.Cheng@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zyta=
ruk, Kelly <Kelly.Zytaruk@amd.com>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV inc=
apable platform

On Fri, 12 May 2017 02:50:32 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Helgaas,
>=20
> Some AMD GPUs have hardware support for graphics SR-IOV.
> If the SR-IOV capable GPU is plugged into the SR-IOV incapable=20
> platform. It would cause a problem on PCI resource allocation in=20
> current Linux kernel.
>=20
> Therefore in order to allow the PF (Physical Function) device of=20
> SR-IOV capable GPU to work on the SR-IOV incapable platform, it is=20
> required to verify conditions for initializing BAR resources on AMD=20
> SR-IOV capable GPUs.
>=20
> If the device is an AMD graphics device and it supports SR-IOV it will=20
> require a large amount of resources.
> Before calling sriov_init() must ensure that the system BIOS also=20
> supports SR-IOV and that system BIOS has been able to allocate enough=20
> resources.
> If the VF BARs are zero then the system BIOS does not support SR-IOV=20
> or it could not allocate the resources and this platform will not=20
> support AMD graphics SR-IOV.
> Therefore do not call sriov_init().
> If the system BIOS does support SR-IOV then the VF BARs will be=20
> properly initialized to non-zero values.
>=20
> Below is the patch against to Kernel 4.8 & 4.9. Please review.
>=20
> I checked the drivers/pci/quirks.c, it looks the workarounds/fixes in=20
> quirks.c are for specific devices and one or more device ID are=20
> defined for the specific devices. However my patch is for all AMD=20
> SR-IOV capable GPUs, that includes all existing and future AMD server GPU=
s.
> So it doesn't seem like a good fit to put the fix in quirks.c.


Why is an AMD graphics card unique here?  Doesn't sriov_init() always need =
to be able to deal with devices of any type where the BIOS hasn't initializ=
ed the SR-IOV capability?  Some SR-IOV devices can fit their VFs within a m=
inimum bridge aperture, most cannot.  I don't understand why the VF resourc=
e requirements being exceptionally large dictates that they receive special=
 handling.  Thanks,

Alex

> Signed-off-by: Collins Cheng <collins.cheng@amd.com>
> ---
>  drivers/pci/iov.c | 63=20
> ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index=20
> e30f05c..e4f1405 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -523,6 +523,45 @@ static void sriov_restore_state(struct pci_dev *dev)
>  		msleep(100);
>  }
> =20
> +/*
> + * pci_vf_bar_valid - check if VF BARs have resource allocated
> + * @dev: the PCI device
> + * @pos: register offset of SR-IOV capability in PCI config space
> + * Returns true any VF BAR has resource allocated, false
> + * if all VF BARs are empty.
> + */
> +static bool pci_vf_bar_valid(struct pci_dev *dev, int pos) {
> +	int i;
> +	u32 bar_value;
> +	u32 bar_size_mask =3D ~(PCI_BASE_ADDRESS_SPACE |
> +			PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +			PCI_BASE_ADDRESS_MEM_PREFETCH);
> +
> +	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
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
> +static bool is_amd_display_adapter(struct pci_dev *dev) {
> +	return (((dev->class >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY) &&
> +		(dev->vendor =3D=3D PCI_VENDOR_ID_ATI ||
> +		dev->vendor =3D=3D PCI_VENDOR_ID_AMD)); }
> +
>  /**
>   * pci_iov_init - initialize the IOV capability
>   * @dev: the PCI device
> @@ -537,9 +576,27 @@ int pci_iov_init(struct pci_dev *dev)
>  		return -ENODEV;
> =20
>  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
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
> =20
