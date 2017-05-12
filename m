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
Date: Fri, 12 May 2017 04:51:43 +0000
Message-ID: <BN6PR12MB12496DDEE84348A22AEA8AACECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511212051.3b802325@t450s.home>
        <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
 <20170511220113.2dfb6d3d@t450s.home>
In-Reply-To: <20170511220113.2dfb6d3d@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Williamson,

I verified the patch is working for both AMD SR-IOV GPU and Intel SR-IOV NI=
C. I don't think it is redundant to check the VF BAR valid before call srio=
v_init(), it is safe and saving boot time, also there is no a better method=
 to know if system BIOS has correctly initialized the SR-IOV capability or =
not.

I did not try to fix the issue from the kernel resource allocation perspect=
ive, it is because:
	1. I am not very familiar with the PCI resource allocation scheme in kerne=
l. For example, in sriov_init(), kernel will re-assign the PCI resource for=
 both VF and PF. I don't understand why kernel allocates resource for VF fi=
rstly, then PF. If it is PF firstly, then this issue could be avoided.
	2. I am not sure if kernel has error handler if PCI resource allocation fa=
iled. In this case, kernel cannot allocate enough resource to PF. It should=
 trigger some error handler to either just keep original BAR values set by =
system BIOS, or disable this device and log errors.

-Collins Cheng


-----Original Message-----
From: Alex Williamson [mailto:alex.williamson@redhat.com]=20
Sent: Friday, May 12, 2017 12:01 PM
To: Cheng, Collins <Collins.Cheng@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zyta=
ruk, Kelly <Kelly.Zytaruk@amd.com>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV inc=
apable platform

On Fri, 12 May 2017 03:42:46 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Williamson,
>=20
> GPU card needs more BAR aperture resource than other PCI devices. For exa=
mple, Intel SR-IOV network card only require 512KB memory resource for all =
VFs. AMD SR-IOV GPU card needs 256MB x16 VF =3D 4GB memory resource for fra=
me buffer BAR aperture.
>=20
> If the system BIOS supports SR-IOV, it will reserve enough resource for a=
ll VF BARs. If the system BIOS doesn't support SR-IOV or cannot allocate th=
e enough resource for VF BARs, only PF BAR will be assigned and VF BARs are=
 empty. Then system boots to Linux kernel and kernel doesn't check if the V=
F BARs are empty or valid. Kernel will re-assign the BAR resources for PF a=
nd all VFs. The problem I saw is that kernel will fail to allocate PF BAR r=
esource because some resources are assigned to VF, this is not expected. So=
 kernel might need to do some check before re-assign the PF/VF resource, so=
 that PF device will be correctly assigned BAR resource and user can use PF=
 device.

So the problem is that something bad happens when the kernel is trying to r=
eallocate resources in order to fulfill the requirements of the VFs, leavin=
g the PF resources incorrectly programmed?  Why not just fix that bug rathe=
r than creating special handling for this vendor/class of device which disa=
bles any attempt to fixup resources for SR-IOV?  IOW, this patch just avoid=
s the problem for your devices rather than fixing the bug.  I'd suggest fix=
ing the bug such that the PF is left in a functional state if the kernel is=
 unable to allocate sufficient resources for the VFs.  Thanks,

Alex

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, May 12, 2017 11:21 AM
> To: Cheng, Collins <Collins.Cheng@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;=20
> linux-kernel@vger.kernel.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>
> Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the=20
> SR-IOV incapable platform
>=20
> On Fri, 12 May 2017 02:50:32 +0000
> "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
>=20
> > Hi Helgaas,
> >=20
> > Some AMD GPUs have hardware support for graphics SR-IOV.
> > If the SR-IOV capable GPU is plugged into the SR-IOV incapable=20
> > platform. It would cause a problem on PCI resource allocation in=20
> > current Linux kernel.
> >=20
> > Therefore in order to allow the PF (Physical Function) device of=20
> > SR-IOV capable GPU to work on the SR-IOV incapable platform, it is=20
> > required to verify conditions for initializing BAR resources on AMD=20
> > SR-IOV capable GPUs.
> >=20
> > If the device is an AMD graphics device and it supports SR-IOV it=20
> > will require a large amount of resources.
> > Before calling sriov_init() must ensure that the system BIOS also=20
> > supports SR-IOV and that system BIOS has been able to allocate=20
> > enough resources.
> > If the VF BARs are zero then the system BIOS does not support SR-IOV=20
> > or it could not allocate the resources and this platform will not=20
> > support AMD graphics SR-IOV.
> > Therefore do not call sriov_init().
> > If the system BIOS does support SR-IOV then the VF BARs will be=20
> > properly initialized to non-zero values.
> >=20
> > Below is the patch against to Kernel 4.8 & 4.9. Please review.
> >=20
> > I checked the drivers/pci/quirks.c, it looks the workarounds/fixes=20
> > in quirks.c are for specific devices and one or more device ID are=20
> > defined for the specific devices. However my patch is for all AMD=20
> > SR-IOV capable GPUs, that includes all existing and future AMD server G=
PUs.
> > So it doesn't seem like a good fit to put the fix in quirks.c. =20
>=20
>=20
> Why is an AMD graphics card unique here?  Doesn't sriov_init() always=20
> need to be able to deal with devices of any type where the BIOS hasn't=20
> initialized the SR-IOV capability?  Some SR-IOV devices can fit their=20
> VFs within a minimum bridge aperture, most cannot.  I don't understand=20
> why the VF resource requirements being exceptionally large dictates=20
> that they receive special handling.  Thanks,
>=20
> Alex
>=20
> > Signed-off-by: Collins Cheng <collins.cheng@amd.com>
> > ---
> >  drivers/pci/iov.c | 63
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 60 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > e30f05c..e4f1405 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -523,6 +523,45 @@ static void sriov_restore_state(struct pci_dev *de=
v)
> >  		msleep(100);
> >  }
> > =20
> > +/*
> > + * pci_vf_bar_valid - check if VF BARs have resource allocated
> > + * @dev: the PCI device
> > + * @pos: register offset of SR-IOV capability in PCI config space
> > + * Returns true any VF BAR has resource allocated, false
> > + * if all VF BARs are empty.
> > + */
> > +static bool pci_vf_bar_valid(struct pci_dev *dev, int pos) {
> > +	int i;
> > +	u32 bar_value;
> > +	u32 bar_size_mask =3D ~(PCI_BASE_ADDRESS_SPACE |
> > +			PCI_BASE_ADDRESS_MEM_TYPE_64 |
> > +			PCI_BASE_ADDRESS_MEM_PREFETCH);
> > +
> > +	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > +		pci_read_config_dword(dev, pos + PCI_SRIOV_BAR + i * 4, &bar_value);
> > +		if (bar_value & bar_size_mask)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * is_amd_display_adapter - check if it is an AMD/ATI GPU device
> > + * @dev: the PCI device
> > + *
> > + * Returns true if device is an AMD/ATI display adapter,
> > + * otherwise return false.
> > + */
> > +
> > +static bool is_amd_display_adapter(struct pci_dev *dev) {
> > +	return (((dev->class >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY) &&
> > +		(dev->vendor =3D=3D PCI_VENDOR_ID_ATI ||
> > +		dev->vendor =3D=3D PCI_VENDOR_ID_AMD)); }
> > +
> >  /**
> >   * pci_iov_init - initialize the IOV capability
> >   * @dev: the PCI device
> > @@ -537,9 +576,27 @@ int pci_iov_init(struct pci_dev *dev)
> >  		return -ENODEV;
> > =20
> >  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> > -	if (pos)
> > -		return sriov_init(dev, pos);
> > -
> > +	if (pos) {
> > +	/*
> > +	 * If the device is an AMD graphics device and it supports
> > +	 * SR-IOV it will require a large amount of resources.
> > +	 * Before calling sriov_init() must ensure that the system
> > +	 * BIOS also supports SR-IOV and that system BIOS has been
> > +	 * able to allocate enough resources.
> > +	 * If the VF BARs are zero then the system BIOS does not
> > +	 * support SR-IOV or it could not allocate the resources
> > +	 * and this platform will not support AMD graphics SR-IOV.
> > +	 * Therefore do not call sriov_init().
> > +	 * If the system BIOS does support SR-IOV then the VF BARs
> > +	 * will be properly initialized to non-zero values.
> > +	 */
> > +		if (is_amd_display_adapter(dev)) {
> > +			if (pci_vf_bar_valid(dev, pos))
> > +				return sriov_init(dev, pos);
> > +		} else {
> > +			return sriov_init(dev, pos);
> > +		}
> > +	}
> >  	return -ENODEV;
> >  }
> >   =20
>=20
