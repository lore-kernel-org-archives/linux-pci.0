Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcALWGL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 17:06:11 -0500
Message-ID: <1452636370.9674.47.camel@redhat.com>
Subject: Re: [PATCH] don't allow vfio drivers to bind on driver_attach
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>, linux-pci@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	Arjan van de Ven <arjan@linux.intel.com>
Date: Tue, 12 Jan 2016 15:06:10 -0700
In-Reply-To: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
References: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-12 at 13:33 -0800, Jacob Keller wrote:
> This patch is an attempt to resolve an issue which can occur when using
> vfio-pci (and vfio-platform) with IOMMU direct assignment.
> 
> When attempting to directly assign a device to a virtual machine, the
> normal flow is something like the following:
> 
> echo  > /sys/bus/pci/drivers//unbind
> echo  > /sys/bus/pci/drivers/vfio-pci/new_id
> echo  > /sys/bus/pci/drivers/vfio-pci/bind
> 
> This process results in the device being bound to the vfio-pci stub
> driver, and then this device can be safely given to a virtual machine.
> 
> The issue can occur, that if  doesn't currently have a driver
> loaded, (like say the module was removed), the process of adding
>  can result in *all* devices which match that id being bound to
> vfio-pci. This may not seem like a problem, but it can be confusing when
> you have a dual-port device, such as a networking card. In some use
> cases, you only want to assign a single port to a VM and not all the
> ports. If you happen to not have the driver loaded already, the result
> is that even loading the driver later will not gain control of the 2nd
> port, because the device is already bound to vfio-pci. The solution (if
> you know this is the case) would be to unbind that particular device
> from vfio and bind it to the real driver.
> 
> This patch fixes the issue by instead requiring vfio-pci and
> vfio-platform to only bind to devices given via the sysfs bind route,
> and prevents bind to any devices in other scenarios. The result is that
> vfio-pci will never bind a device unless explicitly requested. Given the
> nature of what vfio-pci does, I think this is a much better solution.
> 
> I've tried to Cc several people who've made changes to this area of th
> kernel for more feedback.

We already have a solution in the kernel for this, it's the
driver_override interface.  Rather than your above example of adding a
new ID to the dynamic list for the driver, such that it will
automatically probe the device, we reverse the process to allow the
device to match the driver.  The sequence becomes:

echo vfio-pci > /sys/bus/pci/devices/<pci address>/driver_override
echo <pci address> > /sys/bus/pci/drivers/<old driver>/unbind
echo <pci address> /sys/bus/pci/drivers_probe

The old interface is kept around because there are quite a few users of
it, some of which would be broken by the proposed manual_bind_only code
change, including the example of using driver_override above.  This
also avoids even the need for pci-stub (which has the same issue),
since we can simply put a dummy name in driver_override to avoid a
device from matching any driver.  Thanks,

Alex
