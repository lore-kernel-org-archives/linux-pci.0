Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-am1on0082.outbound.protection.outlook.com ([157.56.112.82]:30624
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751456AbcAEL4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jan 2016 06:56:49 -0500
Subject: Re: [RFC 0/2] VFIO SRIOV support
To: Alex Williamson <alex.williamson@redhat.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1450791734-3907-1-git-send-email-ilyal@mellanox.com>
 <1450798558.22385.7.camel@redhat.com>
 <VI1PR05MB1119CACA2E294B58EDB54A9AD4E60@VI1PR05MB1119.eurprd05.prod.outlook.com>
 <1450888100.2950.87.camel@redhat.com>
 <VI1PR05MB1119DD3ED0EB74A259D157A8D4E70@VI1PR05MB1119.eurprd05.prod.outlook.com>
 <1450965103.2950.92.camel@redhat.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
From: Haggai Eran <haggaie@mellanox.com>
Message-ID: <568BA777.6090707@mellanox.com>
Date: Tue, 5 Jan 2016 13:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <1450965103.2950.92.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/12/2015 15:51, Alex Williamson wrote:
> No.  A privileged entity needs to grant a user ownership of a group and
> sufficient locked memory limits to make it useful, but then use of the
> group does not require root permission.

So we're thinking how we can force the VFs in these cases to be in the same
IOMMU group with the PF, and make sure it is vfio-pci that probes them. We
thought about the following:

We could add a flag to pci_dev->dev_flags on the PF, that says that the PF's
VFs must be in the same IOMMU group with it. Modify
iommu_group_get_for_pci_dev() so that it will return the PFs group for VFs
whose PF has that flag set.

In the vfio_group_nb_add_dev() function set driver_override to "vfio-pci" for
PCI devices that are added to a live group. That would prevent the host from
probing these devices with the default driver.

What do you think?

Regards,
Haggai and Ilya
