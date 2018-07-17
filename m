Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Logan Gunthorpe <logang@deltatree.com>,
	Stephen Bates <sbates@raithlin.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 0/3] PCI: Granular hotplug memory/io reservation
Date: Tue, 17 Jul 2018 15:39:44 -0600
Message-Id: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This series granularizes hotplug memory/io reservations to allow different
reservations by-id/by-path. It does this by expanding the kernel boot
parameters pci=hpmemsize= and pci=hpiosize=.

Patch 1/3:
	Changes the hpmemsize behavior between occupied and non-occupied slots,
	where occupied slots were being reserved their current allocation size
	in addition to the hpmemsize parameter. Following this patch, both
	occupied and non-occupied slots receive the same reservation and the
	current allocation size of the occupied slots is considered as part of
	the hotplug reservation.

	I have an additional patch which does this for hpiosize, however I
	don't have any compatible hotplug hardware requiring IO. I could
	synthesize it to test, but I am also not aware of requirements other
	users may have for additional IO.

Patch 2/3:
	Adds the format parsing for hpmemsize and hpiosize. Please see the log
	and 3/3 for documentation.

	Additionally I've noticed there's some overlap in Logan's ACS set with
	respect to format and device matching. Maybe this is something that can
	be refactored into common code once one is accepted.

Patch 3/3:
	Documents the new expanded formats


Jon Derrick (3):
  PCI: Equalize hotplug memory for non/occupied slots
  PCI: Granularize hpmemsize and hpiosize per-id/path
  docs: Document the expanded hp{io,mem}size interface

 Documentation/admin-guide/kernel-parameters.txt |  21 +-
 drivers/pci/pci.c                               | 253 +++++++++++++++++++++++-
 drivers/pci/setup-bus.c                         |  44 +++--
 include/linux/pci.h                             |  21 +-
 4 files changed, 309 insertions(+), 30 deletions(-)

-- 
1.8.3.1
