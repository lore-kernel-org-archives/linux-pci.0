Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:36483
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751434AbdEPIqB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 May 2017 04:46:01 -0400
From: "Cheng, Collins" <Collins.Cheng@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: RE: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Date: Tue, 16 May 2017 08:45:57 +0000
Message-ID: <BN6PR12MB124961A5F6AEA3EE526556B6ECE60@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511212051.3b802325@t450s.home>
        <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511220113.2dfb6d3d@t450s.home>
        <BN6PR12MB12496DDEE84348A22AEA8AACECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170512084304.3cf10653@t450s.home>
        <BN6PR12MB1249DA8407F452C407A7E2F2ECE10@BN6PR12MB1249.namprd12.prod.outlook.com>
 <20170515115332.0077753c@w520.home>
In-Reply-To: <20170515115332.0077753c@w520.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Williamson,

Sorry I am busy on other task, I will look if I can get the dmesg log tomor=
row.

My submitted patch is try to disable the possibility of the OS reallocating=
 resources for VF device in sriov_init(), if VF BAR is empty at BIOS/OS han=
d-off.

-Collins Cheng


-----Original Message-----
From: Alex Williamson [mailto:alex.williamson@redhat.com]=20
Sent: Tuesday, May 16, 2017 1:54 AM
To: Cheng, Collins <Collins.Cheng@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zyta=
ruk, Kelly <Kelly.Zytaruk@amd.com>; Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV inc=
apable platform

On Mon, 15 May 2017 08:19:28 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Williamson,
>=20
> We cannot assume BIOS supports SR-IOV, actually only newer server motherb=
oard BIOS supports SR-IOV. Normal desktop motherboard BIOS or older server =
motherboard BIOS doesn't support SR-IOV. This issue would happen if an user=
 plugs our AMD SR-IOV capable GPU card to a normal desktop motherboard.

Servers should be supporting SR-IOV for a long time now.  What really is th=
ere to a BIOS supporting SR-IOV anyway, it's simply reserving sufficient bu=
s number and MMIO resources such that we can enable the VFs.  This process =
isn't exclusively reserved for the BIOS.  Some platforms may choose to only=
 initialize boot devices, leaving the rest for the OS to program.  The init=
ial proposal here to disable SR-IOV if not programmed at OS hand-off disabl=
es even the possibility of the OS reallocating resources for this device.

> I agree that failure to allocate VF resources should leave the device in =
no worse condition than before it tried. I hope kernel could allocate PF de=
vice resource before allocating VF device resource, and keep PF device reso=
urce valid and functional if failed to allocate VF device resource.
>=20
> I will send out dmesg log lspci info tomorrow. Thanks.

Thanks,
Alex

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, May 12, 2017 10:43 PM
> To: Cheng, Collins <Collins.Cheng@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;=20
> linux-kernel@vger.kernel.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>;=20
> Yinghai Lu <yinghai@kernel.org>
> Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the=20
> SR-IOV incapable platform
>=20
> On Fri, 12 May 2017 04:51:43 +0000
> "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
>=20
> > Hi Williamson,
> >=20
> > I verified the patch is working for both AMD SR-IOV GPU and Intel SR-IO=
V NIC. I don't think it is redundant to check the VF BAR valid before call =
sriov_init(), it is safe and saving boot time, also there is no a better me=
thod to know if system BIOS has correctly initialized the SR-IOV capability=
 or not. =20
>=20
> It also masks an underlying bug and creates a maintenance issue that we w=
on't know when it's safe to remove this workaround.  I don't think faster b=
oot is valid rationale, in one case SR-IOV is completely disabled, the othe=
r we attempt to allocate the resources the BIOS failed to provide.  I expec=
t this is also a corner case, the BIOS should typically support SR-IOV, the=
refore this situation should be an exception.
> =20
> > I did not try to fix the issue from the kernel resource allocation pers=
pective, it is because:
> > 	1. I am not very familiar with the PCI resource allocation scheme in k=
ernel. For example, in sriov_init(), kernel will re-assign the PCI resource=
 for both VF and PF. I don't understand why kernel allocates resource for V=
F firstly, then PF. If it is PF firstly, then this issue could be avoided.
> > 	2. I am not sure if kernel has error handler if PCI resource allocatio=
n failed. In this case, kernel cannot allocate enough resource to PF. It sh=
ould trigger some error handler to either just keep original BAR values set=
 by system BIOS, or disable this device and log errors. =20
>=20
> I think these are the issues we should be trying to solve and I'm sure=20
> folks on the linux-pci list can help us identify the bug.  Minimally,=20
> failure to allocate VF resources should leave the device in no worse=20
> condition than before it tried.  Perhaps you could post more details=20
> about the issue, boot with pci=3Dearlydump, post dmesg of a boot where=20
> the PF resources are incorrectly re-allocated, and include lspci -vvv=20
> for the SR-IOV device.  Also, please test with the latest upstream=20
> kernel, upstream only patches old kernels through stable backports of=20
> commits to the latest kernel.  Adding Yinghai as a resource allocation=20
> expert. Thanks,
>=20
> Alex
>=20
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, May 12, 2017 12:01 PM
> > To: Cheng, Collins <Collins.Cheng@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;=20
> > linux-kernel@vger.kernel.org; Deucher, Alexander=20
> > <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>
> > Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the=20
> > SR-IOV incapable platform
> >=20
> > On Fri, 12 May 2017 03:42:46 +0000
> > "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
> >  =20
> > > Hi Williamson,
> > >=20
> > > GPU card needs more BAR aperture resource than other PCI devices. For=
 example, Intel SR-IOV network card only require 512KB memory resource for =
all VFs. AMD SR-IOV GPU card needs 256MB x16 VF =3D 4GB memory resource for=
 frame buffer BAR aperture.
> > >=20
> > > If the system BIOS supports SR-IOV, it will reserve enough resource f=
or all VF BARs. If the system BIOS doesn't support SR-IOV or cannot allocat=
e the enough resource for VF BARs, only PF BAR will be assigned and VF BARs=
 are empty. Then system boots to Linux kernel and kernel doesn't check if t=
he VF BARs are empty or valid. Kernel will re-assign the BAR resources for =
PF and all VFs. The problem I saw is that kernel will fail to allocate PF B=
AR resource because some resources are assigned to VF, this is not expected=
. So kernel might need to do some check before re-assign the PF/VF resource=
, so that PF device will be correctly assigned BAR resource and user can us=
e PF device.   =20
> >=20
> > So the problem is that something bad happens when the kernel is=20
> > trying to reallocate resources in order to fulfill the requirements=20
> > of the VFs, leaving the PF resources incorrectly programmed?  Why=20
> > not just fix that bug rather than creating special handling for this=20
> > vendor/class of device which disables any attempt to fixup resources=20
> > for SR-IOV?  IOW, this patch just avoids the problem for your=20
> > devices rather than fixing the bug.  I'd suggest fixing the bug such=20
> > that the PF is left in a functional state if the kernel is unable to=20
> > allocate sufficient resources for the VFs.  Thanks,
> >=20
> > Alex
> >  =20
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Friday, May 12, 2017 11:21 AM
> > > To: Cheng, Collins <Collins.Cheng@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>;=20
> > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Deucher,=20
> > > Alexander <Alexander.Deucher@amd.com>; Zytaruk, Kelly=20
> > > <Kelly.Zytaruk@amd.com>
> > > Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the=20
> > > SR-IOV incapable platform
> > >=20
> > > On Fri, 12 May 2017 02:50:32 +0000 "Cheng, Collins"=20
> > > <Collins.Cheng@amd.com> wrote:
> > >    =20
> > > > Hi Helgaas,
> > > >=20
> > > > Some AMD GPUs have hardware support for graphics SR-IOV.
> > > > If the SR-IOV capable GPU is plugged into the SR-IOV incapable=20
> > > > platform. It would cause a problem on PCI resource allocation in=20
> > > > current Linux kernel.
> > > >=20
> > > > Therefore in order to allow the PF (Physical Function) device of=20
> > > > SR-IOV capable GPU to work on the SR-IOV incapable platform, it=20
> > > > is required to verify conditions for initializing BAR resources=20
> > > > on AMD SR-IOV capable GPUs.
> > > >=20
> > > > If the device is an AMD graphics device and it supports SR-IOV=20
> > > > it will require a large amount of resources.
> > > > Before calling sriov_init() must ensure that the system BIOS=20
> > > > also supports SR-IOV and that system BIOS has been able to=20
> > > > allocate enough resources.
> > > > If the VF BARs are zero then the system BIOS does not support=20
> > > > SR-IOV or it could not allocate the resources and this platform=20
> > > > will not support AMD graphics SR-IOV.
> > > > Therefore do not call sriov_init().
> > > > If the system BIOS does support SR-IOV then the VF BARs will be=20
> > > > properly initialized to non-zero values.
> > > >=20
> > > > Below is the patch against to Kernel 4.8 & 4.9. Please review.
> > > >=20
> > > > I checked the drivers/pci/quirks.c, it looks the=20
> > > > workarounds/fixes in quirks.c are for specific devices and one=20
> > > > or more device ID are defined for the specific devices. However=20
> > > > my patch is for all AMD SR-IOV capable GPUs, that includes all exis=
ting and future AMD server GPUs.
> > > > So it doesn't seem like a good fit to put the fix in quirks.c.     =
=20
> > >=20
> > >=20
> > > Why is an AMD graphics card unique here?  Doesn't sriov_init()=20
> > > always need to be able to deal with devices of any type where the=20
> > > BIOS hasn't initialized the SR-IOV capability?  Some SR-IOV=20
> > > devices can fit their VFs within a minimum bridge aperture, most=20
> > > cannot.  I don't understand why the VF resource requirements being=20
> > > exceptionally large dictates that they receive special handling.
> > > Thanks,
> > >=20
> > > Alex
> > >    =20
> > > > Signed-off-by: Collins Cheng <collins.cheng@amd.com>
> > > > ---
> > > >  drivers/pci/iov.c | 63
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 60 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > > > e30f05c..e4f1405 100644
> > > > --- a/drivers/pci/iov.c
> > > > +++ b/drivers/pci/iov.c
> > > > @@ -523,6 +523,45 @@ static void sriov_restore_state(struct pci_dev=
 *dev)
> > > >  		msleep(100);
> > > >  }
> > > > =20
> > > > +/*
> > > > + * pci_vf_bar_valid - check if VF BARs have resource allocated
> > > > + * @dev: the PCI device
> > > > + * @pos: register offset of SR-IOV capability in PCI config=20
> > > > +space
> > > > + * Returns true any VF BAR has resource allocated, false
> > > > + * if all VF BARs are empty.
> > > > + */
> > > > +static bool pci_vf_bar_valid(struct pci_dev *dev, int pos) {
> > > > +	int i;
> > > > +	u32 bar_value;
> > > > +	u32 bar_size_mask =3D ~(PCI_BASE_ADDRESS_SPACE |
> > > > +			PCI_BASE_ADDRESS_MEM_TYPE_64 |
> > > > +			PCI_BASE_ADDRESS_MEM_PREFETCH);
> > > > +
> > > > +	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > > +		pci_read_config_dword(dev, pos + PCI_SRIOV_BAR + i * 4, &bar_val=
ue);
> > > > +		if (bar_value & bar_size_mask)
> > > > +			return true;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > > +/*
> > > > + * is_amd_display_adapter - check if it is an AMD/ATI GPU=20
> > > > +device
> > > > + * @dev: the PCI device
> > > > + *
> > > > + * Returns true if device is an AMD/ATI display adapter,
> > > > + * otherwise return false.
> > > > + */
> > > > +
> > > > +static bool is_amd_display_adapter(struct pci_dev *dev) {
> > > > +	return (((dev->class >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY) &&
> > > > +		(dev->vendor =3D=3D PCI_VENDOR_ID_ATI ||
> > > > +		dev->vendor =3D=3D PCI_VENDOR_ID_AMD)); }
> > > > +
> > > >  /**
> > > >   * pci_iov_init - initialize the IOV capability
> > > >   * @dev: the PCI device
> > > > @@ -537,9 +576,27 @@ int pci_iov_init(struct pci_dev *dev)
> > > >  		return -ENODEV;
> > > > =20
> > > >  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> > > > -	if (pos)
> > > > -		return sriov_init(dev, pos);
> > > > -
> > > > +	if (pos) {
> > > > +	/*
> > > > +	 * If the device is an AMD graphics device and it supports
> > > > +	 * SR-IOV it will require a large amount of resources.
> > > > +	 * Before calling sriov_init() must ensure that the system
> > > > +	 * BIOS also supports SR-IOV and that system BIOS has been
> > > > +	 * able to allocate enough resources.
> > > > +	 * If the VF BARs are zero then the system BIOS does not
> > > > +	 * support SR-IOV or it could not allocate the resources
> > > > +	 * and this platform will not support AMD graphics SR-IOV.
> > > > +	 * Therefore do not call sriov_init().
> > > > +	 * If the system BIOS does support SR-IOV then the VF BARs
> > > > +	 * will be properly initialized to non-zero values.
> > > > +	 */
> > > > +		if (is_amd_display_adapter(dev)) {
> > > > +			if (pci_vf_bar_valid(dev, pos))
> > > > +				return sriov_init(dev, pos);
> > > > +		} else {
> > > > +			return sriov_init(dev, pos);
> > > > +		}
> > > > +	}
> > > >  	return -ENODEV;
> > > >  }
> > > >       =20
> > >    =20
> >  =20
>=20
