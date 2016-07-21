Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56844 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcGUFvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2016 01:51:22 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Haggai Eran <haggaie@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	"Liran Liss" <liranl@mellanox.com>
Subject: RE: [PATCH v2 0/2] VFIO SRIOV support
Date: Thu, 21 Jul 2016 05:51:18 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F90FD25@SHSMSX101.ccr.corp.intel.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
	<20160620113728.74ed79f3@ul30vt.home>
	<VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160621094537.4416cbce@t450s.home>
	<VI1PR0501MB1968544B2529B96832DC673CD4320@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160714110341.7716c619@t450s.home>
	<fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
	<20160718153428.6b988539@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F90960A@SHSMSX101.ccr.corp.intel.com>
	<20160719091017.4c23244f@t450s.home> <20160719134336.79d24af9@t450s.home>
In-Reply-To: <20160719134336.79d24af9@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, July 20, 2016 3:44 AM
> 
> On Tue, 19 Jul 2016 09:10:17 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Tue, 19 Jul 2016 07:06:34 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >
> > > > From: Alex Williamson
> > > > Sent: Tuesday, July 19, 2016 5:34 AM
> > > >
> > > > On Sun, 17 Jul 2016 13:05:21 +0300
> > > > Haggai Eran <haggaie@mellanox.com> wrote:
> > > >
> > > > > On 7/14/2016 8:03 PM, Alex Williamson wrote:
> > > > > >> 2. Add an owner_pid to struct vfio_group and make sure in
> > > > vfio_group_get_device_fd that
> > > > > >> > the PFs  vfio_group is owned by the same process as the one that is trying
> to get
> > > > a fd for a VF.
> > > > > > This only solves a very specific use case, it doesn't address any of
> > > > > > the issues where the VF struct device in the host kernel might get
> > > > > > bound to another driver.
> > > > > The current patch uses driver_override to make the kernel use VFIO for
> > > > > all the new VFs. It still allows the host kernel to bind them to another
> > > > > driver, but that would require an explicit action on the part of the
> > > > > administrator. Don't you think that is enough?
> > > >
> > > > Binding the VFs to vfio-pci with driver_override just prevents any sort
> > > > of initial use by native host drivers, it doesn't in any way tie them to
> > > > the user that created them or prevent any normal operations on the
> > > > device.  The entire concept of a user-created device is new and
> > > > entirely separate from a user-owned device as typically used with
> > > > vfio.  We currently have an assumption with VF assignment that the PF
> > > > is trusted in the host, that's broken here and I have a hard time
> > > > blaming it on the admin or management tool for allowing such a thing
> > > > when it previously hasn't been a possibility.  If nothing else, it
> > > > seems like we're opening the system for phishing attempts where a user
> > > > of a PF creates VFs hoping they might be assigned to a victim VM, or
> > > > worse the host.
> > > >
> > >
> > > What about fully virtualizing the SR-IOV capability? The VM is not allowed
> > > to touch physical SR-IOV capability directly so there would not be a problem
> > > of user-created devices. Physical SR-IOV is always enabled by admin at
> > > the host side. Admin can combine any number of VFs (even cross multiple
> > > compatible devices) in the virtual SR-IOV capability on any passthrough
> > > device...
> > >
> > > The limitation is that the VM can initially access only PF resource which is
> > > usually less than what the entire device provides, so not that efficient
> > > when the VM doesn't want to enable SR-IOV at all.
> >
> > Are you suggesting a scenario where we have one PF with SR-IOV disabled
> > assigned to the user and another PF owned by the host with SR-IOV
> > enable, we virtualize SR-IOV to the user and use the VFs from the other
> > PF to act as a "pool" of VFs to be exposed to the user depending on
> > SR-IOV manipulation?  Something like that could work with existing
> > vfio, just requiring the QEMU bits to virtualize SR-IOV and mange the
> > VFs, but I expect it's not a useful model for Mellanox.  I believe it
> > was Ilya that stated the purpose in exposing SR-IOV was for
> > development, so I'm assuming they actually want to do development of
> > the PF SR-IOV enabling in a VM, not just give the illusion of SR-IOV to
> > the VM.  Thanks,
> 
> 
> Thinking about this further, it seems that trying to create this IOV
> enablement interface through a channel which is explicitly designed to
> interact with an untrusted and potentially malicious user is the wrong
> approach.  We already have an interface for a trusted entity to enable
> VFs, it's through pci-sysfs.  Therefore if we were to use something like
> libvirt to orchestrate the lifecycle of the VFs, I think we remove a
> lot of the problems.  In this case QEMU would virtualize the SR-IOV
> capability (maybe this is along the lines of what Kevin was thinking),
> but that virtualization would take a path out through the QEMU QMP
> interface to execute the SR-IOV change on the device rather than going
> through the vfio kernel interface.  A management tool like libvirt
> would then need to translate that into sysfs operations to create the
> VFs and do whatever we're going to do with them (device_add them back
> to the VM, make them available to a peer VM, make them available to
> the host *gasp*).  VFIO in the kernel would need to add SR-IOV
> support, but the only automatic SR-IOV path would be to disable IOV
> when the PF is released, enabling would only occur through sysfs.  We
> would probably need a new pci-sysfs interface to manage the driver for
> newly created VFs though to avoid default host drivers
> (sriov_driver_override?).  In this model QEMU is essentially just
> making requests to other userspace entities to perform actions and how
> those actions are performed can be left to userspace policy, not kernel
> policy.  I think this would still satisfy the development use case, the
> enabling path just takes a different route where privileged userspace
> is more intimately involved in the process.  Thoughts?  Thanks,
> 

A sound direction to me. Thanks
