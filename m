Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbcFUPrm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 11:47:42 -0400
Date: Tue, 21 Jun 2016 09:45:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	"Or Gerlitz" <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
Message-ID: <20160621094537.4416cbce@t450s.home>
In-Reply-To: <VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
	<20160620113728.74ed79f3@ul30vt.home>
	<VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 21 Jun 2016 07:19:14 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Why is the need for admin privileges not enough to make it safe?

Seems like an opportunity for a phishing attempt, an exploited VM
generates VFs and hopes that they get assigned to other VMs or put to
other uses.  It simply allows one VM to create resources that are
really not tied to that VM and can easily be mis-used in other ways,
potentially even with the assumption that it's secure.

> What's the difference between the following?
> 	1. A PF is assigned to one user and the admin assigns one of it VFs to a different user.
> 	2. The admin assign the main network interface of the machine to a VM and bring down all the connectivity of the host.

In case 1. does the admin realize what they've done?  How?  Maybe they
just start filing bugs when they shutdown the PF assigned VM or even
just reboot it and the VF assigned VM no longer has connectivity.  A  
typical user might just think "hey cool, now I can assign PFs and VFs"
w/o considering the implications of that.  There are aspects of
the host that we need to trust, allowing another VM to hold some
of that trust is not such an obvious thing.  Clearly in case 2. the
admin is going to pretty quickly figure out that they've done something
terribly wrong.
 
> Indeed we don't address clean up, but we didn't see any adverse effect from the VFs remaining probed by the VFIO driver after the VM is shutdown.

Yet that's clearly not the state the PF was in when assigned and those
VFs have no cleanup mechanism.  This is a big problem.

> Would you be willing to accept this feature under some kconfig option or if it was allowed only for Privileged processes?
> I would hate to throw this feature away just because we can't address every corner case.

I'm not willing to accept half baked features and letting them bitrot
under a config option that doesn't get regular use doesn't help.  If
this is really that useful to you then make it safe and predictable.  I
don't have answers to all the issues this generates, it might require
extensions to driver APIs or new mechanisms for vfio to associate device
ownership.  There might be valid use cases for a user owned PF sourcing
VFs owned by other users, but obviously to me it sounds like a rats
nest of security issues and "because we can" and "useful development
tool" are not resounding motives for me to sign up trying to support
it.  Thanks,

Alex
