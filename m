Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbbLWQ2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Dec 2015 11:28:21 -0500
Message-ID: <1450888100.2950.87.camel@redhat.com>
Subject: Re: [RFC 0/2] VFIO SRIOV support
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Date: Wed, 23 Dec 2015 09:28:20 -0700
In-Reply-To: <VI1PR05MB1119CACA2E294B58EDB54A9AD4E60@VI1PR05MB1119.eurprd05.prod.outlook.com>
References: <1450791734-3907-1-git-send-email-ilyal@mellanox.com>
	 <1450798558.22385.7.camel@redhat.com>
	 <VI1PR05MB1119CACA2E294B58EDB54A9AD4E60@VI1PR05MB1119.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-12-23 at 07:43 +0000, Ilya Lesokhin wrote:
> Hi Alex,
> Regarding driver_override, as far as I know you can only use it on
> devices that were already discovered. Since the devices do not exist
> before the call to pci_enable_sriov(...)
> and are already probed after the call  it wouldn't really help us. I
> would have to unbind them from their default driver and bind them to
> VFIO like solution a in my original mail.

If you allow them to be bound to their default driver, then you've
already created the scenario of a user own PF creating host own VFs,
which I think is unacceptable.  The driver_override can be set before
drivers are probed, the fact that pci_enable_sriov() doesn't enable a
hook for that is something that could be fixed.

> You are right about the ownership problem and we would like to
> receive input regarding what is the correct way of solving this. 
> But in the meantime I think our solution is quite useful even though
> if it requires root privileges. We hacked libvirt so that it would
> run qemu as root and without device cgroup.
> 
> In any case, don't you think that assigning those devices to VFIO
> should be safe? Does the VFIO driver makes any unsafe assumptions on
> the VF's that might allow a guest to crash the hypervisor?
> 
> I am somewhat concerned that the VM  could trigger some backdoor
> reset while the hypervisor is running pci_enable_sriov(...). But I'm
> not really sure how to solve it.
> I guess you have to either stop the guest entirely to enable sriov or
> make it privileged.
> 
> Regarding having the PF controlled by one user while the other VFs
> are controlled by other user, I actually think it might be an
> interesting use case.

It may be, but it needs to be an opt-in, not a security accident.  The
interface between a PF and a VF is essential device specific and we
don't know exactly how isolated each VF is from the PF.  In the typical
scenario of the PF being owned by the host, we have a certain degree of
trust in the host, it's running the VM after all, if it wanted to
compromise it, it could.  We have no implicit reason to trust a PF
running in a guest though.  Can the snoop VF traffic, can they generate
DMA outside of the container of the PF using the VF?  We can't be sure.
 So unless you can make the default scenario be that VFs created by a
user own PF are only available for use by that user, without relying on
userspace to intervene, it seems like any potential usefulness is
trumped by a giant security issue.  Thanks,

Alex
