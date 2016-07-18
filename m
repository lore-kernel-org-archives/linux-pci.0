Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbcGRVe3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jul 2016 17:34:29 -0400
Date: Mon, 18 Jul 2016 15:34:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Haggai Eran <haggaie@mellanox.com>
Cc: Ilya Lesokhin <ilyal@mellanox.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
Message-ID: <20160718153428.6b988539@t450s.home>
In-Reply-To: <fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
	<20160620113728.74ed79f3@ul30vt.home>
	<VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160621094537.4416cbce@t450s.home>
	<VI1PR0501MB1968544B2529B96832DC673CD4320@VI1PR0501MB1968.eurprd05.prod.outlook.com>
	<20160714110341.7716c619@t450s.home>
	<fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 17 Jul 2016 13:05:21 +0300
Haggai Eran <haggaie@mellanox.com> wrote:

> On 7/14/2016 8:03 PM, Alex Williamson wrote:
> >> 2. Add an owner_pid to struct vfio_group and make sure in vfio_group_get_device_fd that  
> >> > the PFs  vfio_group is owned by the same process as the one that is trying to get a fd for a VF.  
> > This only solves a very specific use case, it doesn't address any of
> > the issues where the VF struct device in the host kernel might get
> > bound to another driver.    
> The current patch uses driver_override to make the kernel use VFIO for
> all the new VFs. It still allows the host kernel to bind them to another
> driver, but that would require an explicit action on the part of the
> administrator. Don't you think that is enough?

Binding the VFs to vfio-pci with driver_override just prevents any sort
of initial use by native host drivers, it doesn't in any way tie them to
the user that created them or prevent any normal operations on the
device.  The entire concept of a user-created device is new and
entirely separate from a user-owned device as typically used with
vfio.  We currently have an assumption with VF assignment that the PF
is trusted in the host, that's broken here and I have a hard time
blaming it on the admin or management tool for allowing such a thing
when it previously hasn't been a possibility.  If nothing else, it
seems like we're opening the system for phishing attempts where a user
of a PF creates VFs hoping they might be assigned to a victim VM, or
worse the host.

> Do you think we should
> also take a reference on the VFIO devices to prevent an administrator
> from unbinding them?

Who would be taking this reference?  It would need to be the host
kernel, we couldn't rely on the user to do it.  Wouldn't we be racing
other users to get that reference?  How would we bestow that reference
to a user?  How does this lead to a VF that can actually be used?

> > Also is the pid really what we want to attach
> > ownership to?  What if the owner of the PF wants to assign the VF to a
> > peer VM, not to a nested VM?  It seems like there's an entire aspect of
> > owning and being able to grant ownership of a device to a user or group
> > missing.  
> In order to support assigning to a peer VM, maybe we can do something a
> little different. What if we add a ioctl to enable SR-IOV, and the new
> ioctl would return an open fd for the VFIO group of each VF? Other
> attempts to open these groups by other processes would fail because the
> groups would already be open. The process that enabled SR-IOV could
> still pass these fds to other processes if needed, allowing other VMs to
> use them.

It's a good thought, but what happens when the user simply closes the VF
group(s)?  Are we back to a state that's any different from above?  We
cannot base the security of the host on the assumption that our user is
not malicious.  I'm also not sure how that enables any interesting use
cases.  One QEMU instance cannot spawn another, so what good is it if
QEMU has a group fd open?  Seems like that only facilitates exposing
the VF within the same process, but without understanding how close()
works, I don't see what that adds.

I really don't know what the ownership model looks like for
user-created devices and how we allow that ownership to be transferred
to other contexts, perhaps even back to a system context, but handling
them as just another device, perhaps only with an initial driver
binding is a scary proposition to me.  Thanks,

Alex
