Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933567AbeCBX7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 18:59:23 -0500
Date: Fri, 2 Mar 2018 16:59:19 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, dwmw@amazon.co.uk
Subject: Re: [PATCH 1/3] pci-iov: Add support for unmanaged SR-IOV
Message-ID: <20180302165919.423cd45b@t450s.home>
In-Reply-To: <20180302234412.3337.71321.stgit@localhost.localdomain>
References: <20180302234218.3337.16486.stgit@localhost.localdomain>
        <20180302234412.3337.71321.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 02 Mar 2018 15:44:25 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to add some basic functionality to support for SR-IOV
> on devices when the VFs are not managed by the kernel. The functions
> provided here can be used by drivers such as vfio-pci and virtio to enable
> SR-IOV on devices that are either managed by userspace, or by some sort of
> firmware entity respectively.
> 
> A new sysfs value called sriov_unmanaged_autoprobe has been added. This
> value is used as the drivers_autoprobe setting of the VFs when they are
> being managed by an external entity such as userspace or device firmware
> instead of being managed by the kernel.
> 
> One side effect of this change is that the sriov_drivers_autoprobe and
> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV is
> disabled. Attempts to update them when SR-IOV is in use will only update
> the local value and will not update sriov->autoprobe.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |   17 ++++++++++++++
>  drivers/pci/iov.c                       |   37 +++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c                |    2 +-
>  drivers/pci/pci-sysfs.c                 |   29 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |    4 +++
>  include/linux/pci.h                     |    1 +
>  6 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 44d4b2be92fd..ff0b6c19cb1a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -323,3 +323,20 @@ Description:
>  
>  		This is similar to /sys/bus/pci/drivers_autoprobe, but
>  		affects only the VFs associated with a specific PF.
> +
> +What:		/sys/bus/pci/devices/.../sriov_unmanaged_autoprobe
> +Date:		March 2018
> +Contact:	Alexander Duyck <alexander.h.duyck@intel.com>
> +Description:
> +		This file is associated with the PF of a device that
> +		supports SR-IOV.  It determines whether newly-enabled VFs
> +		are immediately bound to a driver when the PF driver does
> +		not manage the VFs itself.  It initially contains 0, which
> +		means the kernel will not automatically bind VFs to a driver.
> +		If an application writes 1 to the file before enabling VFs,
> +		the kernel will bind VFs to a compatible driver immediately
> +		after they are enabled.
> +
> +		This overrides /sys/bus/pci/devices/.../sriov_drivers_autoprobe
> +		when a PF driver is not present to manage a device, or the PF
> +		driver does not provide functionality to support SR-IOV.


Given a pf, how does a user determine whether it is managed or unmanaged
and therefore which autoprobe attributes are in effect?  Thanks,

Alex
