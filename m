Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61673 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab3GZQne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jul 2013 12:43:34 -0400
Message-ID: <51F2A735.2010405@intel.com>
Date: Fri, 26 Jul 2013 09:43:33 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com, yu.zhao@intel.com
Subject: Re: return value for "if (!dev->is_physfn)"
References: <51F24788.6010505@kpanic.de>
In-Reply-To: <51F24788.6010505@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2013 02:55 AM, Stefan Assmann wrote:
> Looking at drivers/pci/iov.c I see at least 3 different return values
> for if (!dev->is_physfn).
>
> sriov_enable() and pci_enable_sriov()
> [...]
> 	if (!dev->is_physfn)
> 		return -ENODEV;
> pci_num_vf() and pci_vfs_assigned()
> [...]
> 	if (!dev->is_physfn)
> 		return 0;
> pci_sriov_set_totalvfs() and pci_sriov_get_totalvfs()
> [...]
> 	if (!dev->is_physfn)
> 		return -EINVAL;
>
> I'd like to make this consistently return one of the above. Question is,
> which one should it be? I'd lean towards -ENODEV, other opinions?
>
>   Stefan

It all depends on how the results are meant to be interpreted.

In the case of pci_num_vf and pci_vfs_assigned the return of 0 is
preferred since there are no VFs if the device is not a physical
function.  I really think pci_sriov_get_totalvfs should probably just
return 0 as well since it is simply supposed to return the total number
of VFs supported on the device and 0 would be valid in this case.  Also
that way the behavior is consistent if CONFIG_PCI_IOV is enabled or
disabled in the kernel.

As for the rest my preference is ENOSYS rather than EINVAL or ENODEV. 
The issue is that the SR-IOV functionality is not implemented for the
device or in the OS when we return the error so it would make sense to
return that as an error code in these cases.

Thanks,

Alex




