Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49376 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbcALVdO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 16:33:14 -0500
From: Jacob Keller <jacob.e.keller@intel.com>
To: linux-pci@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kay Sievers <kay.sievers@vrfy.org>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] don't allow vfio drivers to bind on driver_attach
Date: Tue, 12 Jan 2016 13:33:09 -0800
Message-Id: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is an attempt to resolve an issue which can occur when using
vfio-pci (and vfio-platform) with IOMMU direct assignment.

When attempting to directly assign a device to a virtual machine, the
normal flow is something like the following:

echo <pci address> > /sys/bus/pci/drivers/<old driver>/unbind
echo <device id> > /sys/bus/pci/drivers/vfio-pci/new_id
echo <pci address> > /sys/bus/pci/drivers/vfio-pci/bind

This process results in the device being bound to the vfio-pci stub
driver, and then this device can be safely given to a virtual machine.

The issue can occur, that if <device id> doesn't currently have a driver
loaded, (like say the module was removed), the process of adding
<new_id> can result in *all* devices which match that id being bound to
vfio-pci. This may not seem like a problem, but it can be confusing when
you have a dual-port device, such as a networking card. In some use
cases, you only want to assign a single port to a VM and not all the
ports. If you happen to not have the driver loaded already, the result
is that even loading the driver later will not gain control of the 2nd
port, because the device is already bound to vfio-pci. The solution (if
you know this is the case) would be to unbind that particular device
from vfio and bind it to the real driver.

This patch fixes the issue by instead requiring vfio-pci and
vfio-platform to only bind to devices given via the sysfs bind route,
and prevents bind to any devices in other scenarios. The result is that
vfio-pci will never bind a device unless explicitly requested. Given the
nature of what vfio-pci does, I think this is a much better solution.

I've tried to Cc several people who've made changes to this area of th
kernel for more feedback.

Jacob Keller (1):
  driver: add manual_bind_only option for virtual stub drivers

 drivers/base/dd.c                     | 6 ++++++
 drivers/vfio/pci/vfio_pci.c           | 3 +++
 drivers/vfio/platform/vfio_platform.c | 1 +
 include/linux/device.h                | 1 +
 4 files changed, 11 insertions(+)

-- 
2.6.3.505.g5cc1fd1

