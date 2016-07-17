Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0048.outbound.protection.outlook.com ([104.47.2.48]:55427
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751071AbcGQQhf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 17 Jul 2016 12:37:35 -0400
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
To: Alex Williamson <alex.williamson@redhat.com>,
	Ilya Lesokhin <ilyal@mellanox.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
 <20160620113728.74ed79f3@ul30vt.home>
 <VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
 <20160621094537.4416cbce@t450s.home>
 <VI1PR0501MB1968544B2529B96832DC673CD4320@VI1PR0501MB1968.eurprd05.prod.outlook.com>
 <20160714110341.7716c619@t450s.home>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Noa Osherovich" <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	"Liran Liss" <liranl@mellanox.com>
From: Haggai Eran <haggaie@mellanox.com>
Message-ID: <fad4625f-9507-388d-910c-295578e34f33@mellanox.com>
Date: Sun, 17 Jul 2016 13:05:21 +0300
MIME-Version: 1.0
In-Reply-To: <20160714110341.7716c619@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/14/2016 8:03 PM, Alex Williamson wrote:
>> 2. Add an owner_pid to struct vfio_group and make sure in vfio_group_get_device_fd that
>> > the PFs  vfio_group is owned by the same process as the one that is trying to get a fd for a VF.
> This only solves a very specific use case, it doesn't address any of
> the issues where the VF struct device in the host kernel might get
> bound to another driver.  
The current patch uses driver_override to make the kernel use VFIO for
all the new VFs. It still allows the host kernel to bind them to another
driver, but that would require an explicit action on the part of the
administrator. Don't you think that is enough? Do you think we should
also take a reference on the VFIO devices to prevent an administrator
from unbinding them?

> Also is the pid really what we want to attach
> ownership to?  What if the owner of the PF wants to assign the VF to a
> peer VM, not to a nested VM?  It seems like there's an entire aspect of
> owning and being able to grant ownership of a device to a user or group
> missing.
In order to support assigning to a peer VM, maybe we can do something a
little different. What if we add a ioctl to enable SR-IOV, and the new
ioctl would return an open fd for the VFIO group of each VF? Other
attempts to open these groups by other processes would fail because the
groups would already be open. The process that enabled SR-IOV could
still pass these fds to other processes if needed, allowing other VMs to
use them.

What do you think?

Haggai

