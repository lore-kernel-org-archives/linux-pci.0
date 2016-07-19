Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbcGSPKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jul 2016 11:10:19 -0400
Date: Tue, 19 Jul 2016 09:10:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Haggai Eran <haggaie@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	"Liran Liss" <liranl@mellanox.com>
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
Message-ID: <20160719091017.4c23244f@t450s.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F90960A@SHSMSX101.ccr.corp.intel.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
	<20160620113728.74ed79f3@ul30vt.home>
	<VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160621094537.4416cbce@t450s.home>
	<VI1PR0501MB1968544B2529B96832DC673CD4320@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160714110341.7716c619@t450s.home>
	<fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
	<20160718153428.6b988539@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F90960A@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Jul 2016 07:06:34 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Tuesday, July 19, 2016 5:34 AM
> > 
> > On Sun, 17 Jul 2016 13:05:21 +0300
> > Haggai Eran <haggaie@mellanox.com> wrote:
> >   
> > > On 7/14/2016 8:03 PM, Alex Williamson wrote:  
> > > >> 2. Add an owner_pid to struct vfio_group and make sure in  
> > vfio_group_get_device_fd that  
> > > >> > the PFs  vfio_group is owned by the same process as the one that is trying to get  
> > a fd for a VF.  
> > > > This only solves a very specific use case, it doesn't address any of
> > > > the issues where the VF struct device in the host kernel might get
> > > > bound to another driver.  
> > > The current patch uses driver_override to make the kernel use VFIO for
> > > all the new VFs. It still allows the host kernel to bind them to another
> > > driver, but that would require an explicit action on the part of the
> > > administrator. Don't you think that is enough?  
> > 
> > Binding the VFs to vfio-pci with driver_override just prevents any sort
> > of initial use by native host drivers, it doesn't in any way tie them to
> > the user that created them or prevent any normal operations on the
> > device.  The entire concept of a user-created device is new and
> > entirely separate from a user-owned device as typically used with
> > vfio.  We currently have an assumption with VF assignment that the PF
> > is trusted in the host, that's broken here and I have a hard time
> > blaming it on the admin or management tool for allowing such a thing
> > when it previously hasn't been a possibility.  If nothing else, it
> > seems like we're opening the system for phishing attempts where a user
> > of a PF creates VFs hoping they might be assigned to a victim VM, or
> > worse the host.
> >   
> 
> What about fully virtualizing the SR-IOV capability? The VM is not allowed
> to touch physical SR-IOV capability directly so there would not be a problem
> of user-created devices. Physical SR-IOV is always enabled by admin at
> the host side. Admin can combine any number of VFs (even cross multiple
> compatible devices) in the virtual SR-IOV capability on any passthrough
> device...
> 
> The limitation is that the VM can initially access only PF resource which is 
> usually less than what the entire device provides, so not that efficient
> when the VM doesn't want to enable SR-IOV at all.

Are you suggesting a scenario where we have one PF with SR-IOV disabled
assigned to the user and another PF owned by the host with SR-IOV
enable, we virtualize SR-IOV to the user and use the VFs from the other
PF to act as a "pool" of VFs to be exposed to the user depending on
SR-IOV manipulation?  Something like that could work with existing
vfio, just requiring the QEMU bits to virtualize SR-IOV and mange the
VFs, but I expect it's not a useful model for Mellanox.  I believe it
was Ilya that stated the purpose in exposing SR-IOV was for
development, so I'm assuming they actually want to do development of
the PF SR-IOV enabling in a VM, not just give the illusion of SR-IOV to
the VM.  Thanks,

Alex
