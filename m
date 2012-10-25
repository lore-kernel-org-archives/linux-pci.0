Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760027Ab2JYSil (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 14:38:41 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [RFC] SRIOV device enable and disable via sysfs
Date: Thu, 25 Oct 2012 14:38:22 -0400
Message-Id: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, VF enablement by SRIOV-capable PCIe devices is done
in driver-specific module parameters.  If not setup in modprobe files,
it requires admin to unload & reload PF drivers with number of desired
VFs to enable.  Additionally, the enablement is system wide: all
devices controlled by the same driver have the same number of VFs
enabled.  Although the latter is probably desired, there are PCI
configurations setup by system BIOS that may not enable that to occur.

Two files are created if a PCIe device has SRIOV support:
sriov_totalvfs -- cat-ing this file returns the maximum number
                  of VFs a PCIe device supports.
sriov_numvfs -- echo'ing a positive number to this file enables 
                & configures this number of VFs for this given PCIe
                device.
	     -- echo'ing 0 to this file disables and deconfigures
                all VFs for this given PCIe device.
             -- cat-ing this file will return the number of VFs
                currently enabled on this PCIe device.

VF enable and disablement is invoked much like other PCIe
configuration functions -- via a registered callback in the driver,
i.e., probe, release, etc.  In this case, sriov_configure

Patches 1 & 2 are copies of Yinghai's patches to change
the PCI device attribute 'vga' to a visible attribute,
and showed me how to do it for SRIOV attributes.

Patches 3 & 4 are the heart of this patch.

Patches 5 through 7 are refactoring of the ixgbe modules
to use the sysfs-based sriov enable/disable feature, provided
by Greg Rose; I modified the last patch when going from v2->v3.

Patch 8 is using a new method that allows a driver to change
the sriov sysfs core code to use a differnt max-supported-numvfs
than what totalvfs reports in the SRIOV capability structure.
ixgbe is one of these devices; igb is as well.  This patch could
be excluded and rely on the drivers to do the numvfs filtering, but
this patch set tries to remove this dependency on the drivers,
and does so in the core code. 

Two other proposals for this core logic have been made:
(1) Move the pci_sriov_[enable,disable]() calls out of the drivers 
    and into this framework. Looking at the ixgbe driver,
    the calls would be made prior to invoking the driver's 
    sriov_configure() interface.  If one reviews the ixgbe driver,
    to implement this proposal, the second proposal would have to
    be adopted....
(2) Add a check to prevent a VF from being unconfigured
    if it is assigned to a virtual machine (VM).  This is currently
    tracked by the PCI_DEV_FLAGS_ASSIGNED bit in the pdev's dev_flags
    field. KVM & Xen currently set this flag when a PCI device
    (PF or VF) is assigned to a VM.

v2->v3:
-- change the file names to reflect the names used in the SRIOV spec
-- change to a single file for enable & disable; 
   change driver interface to a single interface.
-- add more informative messages on failures
-- add a core method that a driver can invoke to modify
   the totalvfs reported & supported by a driver.
-- a set of patches for ixgbe provided by Greg Rose to use the
   new interfaces; the last patch modified from the original
   two file, enable/disable interface to the current single file
   enable/disable. Greg will eventually post the final version
   of these patches via Intel's usual process for driver patches.
   Provided here as an example, and enable other SRIOV drivers
   to see how adoption of the interface can be added.

v1->v2:
This patch is based on previous 2 patches by Yinghai Lu
that cleaned up the vga attributes for PCI devices under sysfs,
and uses visibility-checking group attributes as recommended by
Greg K-H.

Signed-off-by: Donald Dutile <ddutile@redhat.com>

>From Donald Dutile <ddutile@redhat.com> # This line is ignored.
From: Donald Dutile <ddutile@redhat.com>
Subject: [RFC] SRIOV device enable and disable via sysfs
In-Reply-To: 

