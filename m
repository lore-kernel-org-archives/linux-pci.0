Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
From: Peter Wu <peter@lekensteyn.nl>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] nouveau fixes for RPM/Optimus-related hangs
Date: Wed, 25 May 2016 00:52:57 +0200
Message-Id: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

Hi,

Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
due to unchecked function) and a more important fix to fix hanging Optimus
machines when runtime PM is enabled (with pm/pci patches).

An older (obsolete) patch for the first issue was tested by the reporter:
https://bugzilla.kernel.org/show_bug.cgi?id=104791#c11
(it is replaced by "check for function 0x1B before using it").

The second issue will occur when:
 - A modern Optimus laptop is in use (designed for Windows 8 or newer).
 - nouveau runtime PM is enabled (1 or the default -1).
 - The patch "PCI: Add runtime PM support for PCIe ports" from Mika is pulled
   into v4.7 (or v4.8[1]?) via the pci/pm branch,
   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pm&id=8b71f5652eeac561acf883da01ab4810f763ee42
(see also the discussion for "[PATCH] PCI: Power on bridges before scanning new
devices" at http://article.gmane.org/gmane.linux.power-management.general/76411)

The first two patches are just refactoring to reduce code duplication (and
scratch an itch) and make the following patches possible. The next two patches
fix the problems reported above.

I intend to get these patches in 4.7 (or the first version where pci/pm gets
merged) to avoid a lockup when runpm is enabled. Note:
 - If the fourth patch is merged before/without Mika's PCIe port patch, then
   those modern Optimus machines above will not be put into D3cold.
 - If the fourth patch is not merged (or merged after Mika's patch), then under
   the above conditions the affected machine can lock up.
 - The three other patches are unrelated to this issue and can safely be merged.

Tested with:
 - Linux v4.6 + pci/pm + these four patches
 - Hardware: Clevo P651RA with acpi_osi="!Windows 2015" (the latter is a
   workaround for another PCIe issue).
 - Card is asleep, woke up with lspci, waited a bit and retried/suspended:
   - # lspci -xxxxnnvvvv >/dev/null; sleep 5
   - # lspci -xxxxnnvvvv >/dev/null; sleep 5; systemctl suspend
   - # lspci -xxxxnnvvvv >/dev/null; systemctl suspend

Kind regards,
Peter

 [1]: https://lkml.kernel.org/r/20160524211309.GH1789@lahna.fi.intel.com

Peter Wu (4):
  drm/nouveau/acpi: ensure matching ACPI handle and supported functions
  drm/nouveau/acpi: return supported DSM functions
  drm/nouveau/acpi: check for function 0x1B before using it
  drm/nouveau/acpi: fix lockup with PCIe runtime PM

 drivers/gpu/drm/nouveau/nouveau_acpi.c | 100 +++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 37 deletions(-)

-- 
2.8.2
