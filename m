Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424AbbCDUCi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 15:02:38 -0500
Subject: [PATCH 0/5] vfio-pci: Misc enhancements
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 13:02:37 -0700
Message-ID: <20150304194711.26766.75450.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Each of these patches stands on it's own, but they all touch the
same file and therefore build on each other to some extent.  The first
patch allows vfio-pci to accept a list of IDs as a module parameter,
exactly like pci-stub.  This is really useful to get vfio-pci bound to
devices that are intended to be used exclusively by userspace without
more complex scripts (particuarly with modprobe.d softdep, pre
loading).

The 2nd patch allows a module option to disable VGA access if vfio-pci
is configured with VGA support.  By itself this doesn't do much, but
with patch 5, we add a VGA arbiter client that will opt-out devices
from arbitration if the user cannot access VGA regions of the device.
If you have extra GPUs in your system exclusively for use via vfio-pci
and don't depend on VGA resource access, this opt-out can allow host
graphics to enable DRI2 support as if the additional GPUs weren't
there.  This depends on https://lkml.org/lkml/2015/2/24/430 or else
vga arbiter support gets ugly (still looking for an Ack there).

The other interesting feature here is idle power management.  It's
possible that there are extra devices in a host that are used
exclusively via vfio-pci and that those devices are not used 100% of
the time.  To be power conscious we can put devices into a low power
state when they're not actively being used.  This doesn't always save
much, or necessarily any power, but we can at least try.

I'll also note that the last patch makes use of pci_bus_max_busnr()
which seems to be in flux with some current upstream patches.  I don't
really care if we use pci_bus_max_busnr() or some replacement for it,
so long as pci-core allows a way to determine the bus number range
below a bridge so I can determine if there's more than one VGA device
below it.  Comments welcome.  Thanks,

Alex

---

Alex Williamson (5):
      vfio-pci: Allow PCI IDs to be specified as module options
      vfio-pci: Add module option to disable VGA region access
      vfio-pci: Remove warning if try-reset fails
      vfio-pci: Move idle devices to D3hot power state
      vfio-pci: Add VGA arbiter client


 drivers/vfio/pci/vfio_pci.c |  174 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 157 insertions(+), 17 deletions(-)
