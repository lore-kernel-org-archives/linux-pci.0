Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40731 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbaAMW0e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jan 2014 17:26:34 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/2] PCI: driver function reset notification
Date: Mon, 13 Jan 2014 15:26:26 -0700
Message-Id: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's version 2 of this patch with a driver implementing the intended
use as an example.

The NVMe stuff requires using the maintainer's tree to get the newly
added nvme reset handling code. Willy's repo is located here:

git.infradead.org/users/willy/linux-nvme.git

v1->v2:

As suggested, I'm reusing the slot_reset error handler instead of defining
a new one for function_reset.

I moved invoking the callback further up the this call stack. The test
case I use resets the device via sysfs, and the pci device's command
register is cleared at the previous point, so the callback couldn't
actually do anything useful other than schedule something to handle
it after pci_dev_restore is called. The previous location would break
other driver slot_reset implementations and make my nvme implementation
a little more complicated.

Actually ... I'm a little concered to be using slot_reset instead of
defining a new callback for FLR. From looking at other device drivers,
I'm not sure they would expect to have their slot_reset invoked in
this situation.

Keith Busch (2):
  PCI: call pci reset callback to pci_driver on FLR
  NVMe: Implement pci reset callback

 drivers/block/nvme-core.c |   36 ++++++++++++++++++++++++++++++++++--
 drivers/pci/pci.c         |    6 ++++++
 include/linux/nvme.h      |    1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

-- 
1.7.10.4

