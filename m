Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbcGYP67 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 11:58:59 -0400
Date: Mon, 25 Jul 2016 09:58:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	"Liran Liss" <liranl@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
Message-ID: <20160725095857.30f7d92e@t450s.home>
In-Reply-To: <VI1PR0501MB196895DE941D34A5ECC966F8D40D0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
	<20160620113728.74ed79f3@ul30vt.home>
	<VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160621094537.4416cbce@t450s.home>
	<VI1PR0501MB1968544B2529B96832DC673CD4320@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160714110341.7716c619@t450s.home>
	<fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
	<20160718153428.6b988539@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F90960A@SHSMSX101.ccr.corp.intel.com>
	<20160719091017.4c23244f@t450s.home>
	<20160719134336.79d24af9@t450s.home>
	<613c4470-d899-2698-dfe5-9dbb2388787e@mellanox.com>
	<20160725090750.2786ab5f@t450s.home>
	<VI1PR0501MB196895DE941D34A5ECC966F8D40D0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 25 Jul 2016 15:34:34 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Hi Alex,
> It seems that I'm missing something because I fail to see how the sysfs interface solves
> any of the problems you've pointed out in the current code.

If the kernel allows a user who owns a PF to spawn VFs then it becomes
the kernel's problem how to define and enforce the policy around those
devices (ie. who is allowed to use them, how does ownership get
transferred, what do we consider secure vs insecure, etc).  On the
other hand if we do not allow a user that direct path and they need to
interact through a trusted channel to create those VFs, then it becomes
the problem of the entity creating them how to address those policy
questions.  That's a big difference.  In general I think it's a bad
idea to implement policy in the kernel, the kernel should provide the
tools to allow userspace to manage the policy.
 
> Can you please clarify what you want us to do on the kernel side besides moving to the sysfs interface?
> How do we prevent the administrator from unbinding the VFs from vfio and binding them to the default driver?
> How does the new model prevent the administrator from assigning the VFs to other VM?

In both cases the answer is "we don't".  Those are questions that would
need to be addressed if the kernel was implementing the policy.  The
kernel already has an interface for creating SRIOV VFs and it's up to
userspace how to manage that in a secure way.  If someone has a use
case where a user owned PF spawns a host kernel owned VF, that's for
userspace to determine whether it's valid.  sriov_driver_override is
only a suggestion towards facilitating user managed VFs, allowing the
creator of the VFs to more concisely control the driver binding for
those VFs.  Thanks,

Alex

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com] 
> Sent: Monday, July 25, 2016 6:08 PM
> To: Haggai Eran <haggaie@mellanox.com>
> Cc: Tian, Kevin <kevin.tian@intel.com>; Ilya Lesokhin <ilyal@mellanox.com>; kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com; Noa Osherovich <noaos@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss <liranl@mellanox.com>
> Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
> 
> On Mon, 25 Jul 2016 10:53:56 +0300
> Haggai Eran <haggaie@mellanox.com> wrote:
> 
> > On 7/19/2016 10:43 PM, Alex Williamson wrote:  
> > > Thinking about this further, it seems that trying to create this IOV 
> > > enablement interface through a channel which is explicitly designed 
> > > to interact with an untrusted and potentially malicious user is the 
> > > wrong approach.  We already have an interface for a trusted entity 
> > > to enable VFs, it's through pci-sysfs.  Therefore if we were to use 
> > > something like libvirt to orchestrate the lifecycle of the VFs, I 
> > > think we remove a lot of the problems.  In this case QEMU would 
> > > virtualize the SR-IOV capability (maybe this is along the lines of 
> > > what Kevin was thinking), but that virtualization would take a path 
> > > out through the QEMU QMP interface to execute the SR-IOV change on 
> > > the device rather than going through the vfio kernel interface.  A 
> > > management tool like libvirt would then need to translate that into 
> > > sysfs operations to create the VFs and do whatever we're going to do 
> > > with them (device_add them back to the VM, make them available to a 
> > > peer VM, make them available to the host *gasp*).  VFIO in the 
> > > kernel would need to add SR-IOV support, but the only automatic 
> > > SR-IOV path would be to disable IOV when the PF is released, 
> > > enabling would only occur through sysfs.  We would probably need a 
> > > new pci-sysfs interface to manage the driver for newly created VFs 
> > > though to avoid default host drivers (sriov_driver_override?).  In 
> > > this model QEMU is essentially just making requests to other 
> > > userspace entities to perform actions and how those actions are 
> > > performed can be left to userspace policy, not kernel policy.  I 
> > > think this would still satisfy the development use case, the 
> > > enabling path just takes a different route where privileged 
> > > userspace is more intimately involved in the process.  Thoughts?  
> > > Thanks,  
> > 
> > I understand the desire to use a different interface such as sysfs for 
> > the trusted user-space component. I'm not sure though how using 
> > sriov_driver_override solves the issues we have been discussing. After 
> > SR-IOV is enabled by libvirt, it is still possible for the 
> > administrator (or another trusted daemon racing with libvirt) to open 
> > the VFs with VFIO before libvirt had a chance to open them and send them to QEMU.
> > 
> > Are you okay with that?  
> 
> If a privileged entity like libvirt is creating VFs on behalf of a user, it's going to be that entity's responsibility to claim ownership of all those created VFs.  sriov_driver_override is just one suggestion that might help facilitate that.  Others might be necessary, but ultimately it's not the kernel's problem to work out which entity gets to take ownership of those devices, that's a userspace problem, just as it is already today.  Thanks,
> 
> Alex

