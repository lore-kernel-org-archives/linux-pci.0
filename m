Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <cover.1458126755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 16 Mar 2016 15:50:35 +0100
Subject: [RFC 0/4] Runtime pm for thunderbolt.ko
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds runtime pm to the Thunderbolt driver for Macs.
Patches 1 to 3 are just preparatory material, the real action
is in patch 4.

The series fixes (at least partially) a power regression introduced in
Linux 3.17 by 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly"):
https://bugzilla.kernel.org/show_bug.cgi?id=92111

It would be good if someone could test it with Cactus Ridge or
Falcon Ridge. So far I've only tested it with the Light Ridge
controller built into older Macs.

I've also pushed the patches to GitHub to ease reviewing:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v1


I'm posting this as an RFC to get feedback in particular on 2 issues:

(1) There are 3 drivers interacting with the Thunderbolt controller:
    thunderbolt.ko (controls the NHI, Native Host Interface),
    pcieport (controls the upstream bridge) and pciehp (controls
    the downstream bridges). The Linux pm model assumes that a child
    cannot resume before its parent, yet my implementation lets the
    NHI govern runtime pm and the NHI is a child. So this is a total
    violation of the Linux pm model. There's an ascii drawing in
    patch 4 which should make this clearer.

    To let the parent (upstream bridge) govern runtime pm, I could
    maybe write a pcieport service driver specifically for Thunderbolt
    which governs the runtime pm (but does nothing else). However
    pcieport currently has no runtime pm (yes I know Mika is on it)
    and a service driver lacks the necessary runtime pm callbacks.
    So with pcieport the way it is now, that solution isn't attainable.


(2) When the system goes to sleep, it shouldn't wake the controller
    from runtime suspend. Waking the controller takes 2 seconds and
    costs energy. The ->prepare callback must return 1 to achieve that.
    However pci_pm_prepare() doesn't do so as it can't deal properly
    with devices that can be runtime suspended to D3cold even though
    they're not power manageable by the platform. This could be fixed
    with something like this:

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1918,7 +1918,8 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  */
 static pci_power_t pci_target_state(struct pci_dev *dev)
 {
-	pci_power_t target_state = PCI_D3hot;
+	pci_power_t target_state =
+		(dev->current_state == PCI_D3cold) ? PCI_D3cold : PCI_D3hot;
 
 	if (platform_pci_power_manageable(dev)) {
 		/*

    But there's another problem: pci_pm_complete() wakes up the device
    after resuming from system sleep and there's no need to do that.
    The controller may stay asleep and will be woken on hotplug by a GPE.
    We could fix that with an additional flag in struct dev_pm_info.

    Meanwhile the only solution I could find was a PCI enable fixup
    which overrides pci_pm_prepare() and pci_pm_complete() using a
    power domain. That's fairly kludgy, I can never remove and free
    the allocated struct dev_pm_domain since there is no PCI remove
    fixup section. It's also not possible to bail out of the ->probe
    callback if allocation fails since the PCI enable fixup does not
    allow return values to be passed back.

Thanks,

Lukas


Lukas Wunner (4):
  PCI: Add Thunderbolt device IDs
  thunderbolt: Fix typos and magic number
  thunderbolt: Move pm code to separate file
  thunderbolt: Support runtime pm

 drivers/pci/quirks.c          |  51 +++++++-
 drivers/thunderbolt/Kconfig   |   2 +-
 drivers/thunderbolt/Makefile  |   3 +-
 drivers/thunderbolt/ctl.c     |   2 +-
 drivers/thunderbolt/eeprom.c  |   2 +-
 drivers/thunderbolt/nhi.c     |  45 ++-----
 drivers/thunderbolt/nhi.h     |   3 +
 drivers/thunderbolt/power.c   | 288 ++++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h   |  17 +++
 drivers/thunderbolt/switch.c  |  28 ++--
 drivers/thunderbolt/tb.c      |   8 +-
 drivers/thunderbolt/tb.h      |   2 +-
 drivers/thunderbolt/tb_regs.h |   2 +-
 include/linux/pci_ids.h       |  18 +++
 14 files changed, 413 insertions(+), 58 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

-- 
2.7.0

