Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
From: Peter Wu <peter@lekensteyn.nl>
To: Dave Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/4] nouveau RPM fixes for Optimus (final)
Date: Fri, 15 Jul 2016 15:12:14 +0200
Message-Id: <20160715131218.2416-1-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

Hi,

Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
due to unchecked function) and a more important fix to fix hanging Optimus
machines when runtime PM is enabled (with pm/pci patches).

These are the final patches targeting v4.8. Changes compared to v2[1]:
collected R-b from Hans and Mika and fixed a minor comment style issue.

I recommend it to be merged before the pci/pm patches[2], otherwise there is a
window where newer Nvidia Optimus laptops might fail to runtime resume and/or
lock up.  Once the pci/pm branch is merged I will propose another patch to
improve reliability[3].

Known issue with patch 4: when a Nvidia HDMI audio function is present, the
bridge will not suspend and hence the Nvidia card will still be powered. Fixing
this properly will require more work[4], until then you can kill the audio
device and make runtime PM work properly:

    echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove

Kind regards,
Peter

 [1]: https://lists.freedesktop.org/archives/nouveau/2016-July/025519.html
 [2]: https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/?h=pci/pm
 [3]: http://www.spinics.net/lists/linux-pci/msg52601.html
 [4]: https://lists.freedesktop.org/archives/dri-devel/2016-July/112759.html

Peter Wu (4):
  drm/nouveau/acpi: ensure matching ACPI handle and supported functions
  drm/nouveau/acpi: return supported DSM functions
  drm/nouveau/acpi: check for function 0x1B before using it
  drm/nouveau/acpi: fix lockup with PCIe runtime PM

 drivers/gpu/drm/nouveau/nouveau_acpi.c | 105 +++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 37 deletions(-)

-- 
2.9.0
