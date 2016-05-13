Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:41869 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcEMLXY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:23:24 -0400
Message-Id: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series powers Thunderbolt controllers on Macs down when nothing is
plugged in, saving 1.7 W on machines with a Light Ridge controller and
reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.

Briefly, a custom ACPI method provided by Apple is used to cut power to
the controller.  A GPE is enabled while the controller is powered down
which side-band signals a plug event, whereupon power is reinstated using
the ACPI method.  Note that even though this mechanism is ACPI-based,
it does not use _PSx methods and is thus entirely nonstandard.


A Thunderbolt controller appears to the OS as a set of PCI devices:  One
NHI (Native Host Interface) and multiple bridges.  Power is cut to the
entire set of devices:

  (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
                                     +-- Downstream Bridge 1 --
                                     +-- Downstream Bridge 2 --
                                     ...

v1 of this series shoehorned power control into the NHI driver.  This
violated the Linux pm model which assumes that a child cannot resume
before its parent. As seen above, the NHI is a child, so the child cut
power to the bridges above it.

v2 resolves this by positioning power control on the controller's
topmost device, which is the upstream bridge.  That is achieved by
binding to it as a Thunderbolt port service driver.  portdrv already
calls down to each service driver on ->suspend and ->resume and I
extended that scheme to further PM callbacks.  E.g. when the upstream
bridge is runtime suspended, portdrv invokes the ->runtime_suspend
callback of each attached service driver, and the Thunderbolt service
driver's callback in turn invokes the ACPI method to cut power to the
controller.


For such a nonstandard ACPI-based PM mechanism one would normally assign
a dev_pm_domain to the upstream bridge which overrides the PCI subsystem
PM callbacks.  But that's not an option here because dev_pm_domain_set()
can only be called during driver probe.  The driver is portdrv and
obviously loads earlier than the thunderbolt port service driver.
So one has to make do with the PCI subsystem PM callbacks.

The PCI core currently assumes that devices can only be put into D3cold
by the platform, i.e. using the standard ACPI _PSx methods.  I extended
the PCI core so that it can deal with devices which are put into D3cold
by the driver callbacks.  It turns out only two changes are needed to
make this work, and they are in patches [09/13] and [10/13].  Runtime
suspend works out of the box, but runtime resume tries to set the device
power state *before* invoking the driver callback, and this goes awry
since the device is still in D3cold.  I solved this by returning an error
in pci_raw_set_power_state() if the device's current_state is D3cold
(patch [09/13]).

Theoretically it would also be possible to patch the missing _PSx methods
into the ACPI namespace at runtime but I suspect it wouldn't be pretty:
I think I'd have to include pre-compiled AML methods in the kernel and
modify those blobs at runtime (adjust GPE number etc) before patching
them into the namespace.


To make direct-complete work for such non-platform-power-managed devices,
I also had to modify pci_target_state() (patch [10/13]).

Finally, I wanted to avoid the mandatory runtime resume after direct-
complete which was introduced by Rafael with 58a1fbbb2ee8 ("PM / PCI /
ACPI: Kick devices that might have been reset by firmware"), so I added
the possibility to opt out of it (patch [11/13]).


I've pushed these patches to GitHub where they can be reviewed more
comfortably with green/red highlighting:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v2

For reference, here's a link to v1:
http://thread.gmane.org/gmane.linux.power-management.general/73197

Thanks in advance for your comments.

Lukas


Lukas Wunner (13):
  PCI: Recognize Thunderbolt devices
  PCI: Allow D3 for Thunderbolt ports
  PCI: Add Thunderbolt portdrv service type
  PCI: Generalize portdrv pm iterator
  PCI: Use portdrv pm iterator on further callbacks
  PCI: pciehp: Support runtime pm
  PCI: pciehp: Ignore interrupts during D3cold
  PCI: Allow runtime PM for Thunderbolt hotplug ports on Macs
  PCI: Do not write to PM control register while in D3cold
  PCI: Avoid going from D3cold to D3hot for system sleep
  PM / sleep: Allow opt-out from runtime resume after direct-complete
  thunderbolt: Support runtime pm on upstream bridge
  thunderbolt: Support runtime pm on NHI

 drivers/base/power/generic_ops.c  |   3 +-
 drivers/pci/hotplug/pciehp_ctrl.c |   9 +-
 drivers/pci/hotplug/pciehp_hpc.c  |   4 +
 drivers/pci/pci.c                 |  50 ++----
 drivers/pci/pci.h                 |   2 +
 drivers/pci/pcie/portdrv.h        |   6 +-
 drivers/pci/pcie/portdrv_core.c   |  47 +-----
 drivers/pci/pcie/portdrv_pci.c    |  88 ++++++++--
 drivers/pci/probe.c               |  17 ++
 drivers/thunderbolt/Kconfig       |   4 +-
 drivers/thunderbolt/Makefile      |   4 +-
 drivers/thunderbolt/nhi.c         |  32 +++-
 drivers/thunderbolt/switch.c      |   9 +
 drivers/thunderbolt/tb.c          |  13 ++
 drivers/thunderbolt/upstream.c    | 345 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h               |   1 +
 include/linux/pcieport_if.h       |   7 +
 include/linux/pm.h                |   1 +
 18 files changed, 539 insertions(+), 103 deletions(-)
 create mode 100644 drivers/thunderbolt/upstream.c

-- 
2.8.1

