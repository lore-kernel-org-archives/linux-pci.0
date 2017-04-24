Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1172432AbdDXO1v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Apr 2017 10:27:51 -0400
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marta Lofstedt <marta.lofstedt@intel.com>,
        David Weinehall <david.weinehall@linux.intel.com>,
        Tomi Sarvela <tomi.p.sarvela@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/i915: Prevent the system suspend complete optimization
Date: Mon, 24 Apr 2017 17:27:43 +0300
Message-Id: <1493044063-2095-2-git-send-email-imre.deak@intel.com>
In-Reply-To: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
References: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since

commit bac2a909a096c9110525c18cbb8ce73c660d5f71
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Wed Jan 21 02:17:42 2015 +0100

    PCI / PM: Avoid resuming PCI devices during system suspend

PCI devices will default to allowing the system suspend complete
optimization where devices are not woken up during system suspend if
they were already runtime suspended. This however breaks the i915/HDA
drivers for two reasons:

- The i915 driver has system suspend specific steps that it needs to
  run, that bring the device to a different state than its runtime
  suspended state.

- The HDA driver's suspend handler requires power that it will request
  from the i915 driver's power domain handler. This in turn requires the
  i915 driver to runtime resume itself, but this won't be possible if the
  suspend complete optimization is in effect: in this case the i915
  runtime PM is disabled and trying to get an RPM reference returns
  -EACCESS.

Solve this by requiring the PCI/PM core to resume the device during
system suspend which in effect disables the suspend complete optimization.

One possibility for this bug staying hidden for so long is that the
optimization for a device is disabled if it's disabled for any of its
children devices. i915 may have a backlight device as its child which
doesn't support runtime PM and so doesn't allow the optimization either.
So if this backlight device got registered the bug stayed hidden.

Credits to Marta, Tomi and David who enabled pstore logging,
that caught one instance of this issue across a suspend/
resume-to-ram and Ville who rememberd that the optimization was enabled
for some devices at one point.

The first WARN triggered by the problem:

[ 6250.746445] WARNING: CPU: 2 PID: 17384 at drivers/gpu/drm/i915/intel_runtime_pm.c:2846 intel_runtime_pm_get+0x6b/0xd0 [i915]
[ 6250.746448] pm_runtime_get_sync() failed: -13
[ 6250.746451] Modules linked in: snd_hda_intel i915 vgem snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul
snd_hda_codec_realtek snd_hda_codec_generic ghash_clmulni_intel e1000e snd_hda_codec snd_hwdep snd_hda_core ptp mei_me pps_core snd_pcm lpc_ich mei prime_
numbers i2c_hid i2c_designware_platform i2c_designware_core [last unloaded: i915]
[ 6250.746512] CPU: 2 PID: 17384 Comm: kworker/u8:0 Tainted: G     U  W       4.11.0-rc5-CI-CI_DRM_334+ #1
[ 6250.746515] Hardware name:                  /NUC5i5RYB, BIOS RYBDWi35.86A.0362.2017.0118.0940 01/18/2017
[ 6250.746521] Workqueue: events_unbound async_run_entry_fn
[ 6250.746525] Call Trace:
[ 6250.746530]  dump_stack+0x67/0x92
[ 6250.746536]  __warn+0xc6/0xe0
[ 6250.746542]  ? pci_restore_standard_config+0x40/0x40
[ 6250.746546]  warn_slowpath_fmt+0x46/0x50
[ 6250.746553]  ? __pm_runtime_resume+0x56/0x80
[ 6250.746584]  intel_runtime_pm_get+0x6b/0xd0 [i915]
[ 6250.746610]  intel_display_power_get+0x1b/0x40 [i915]
[ 6250.746646]  i915_audio_component_get_power+0x15/0x20 [i915]
[ 6250.746654]  snd_hdac_display_power+0xc8/0x110 [snd_hda_core]
[ 6250.746661]  azx_runtime_resume+0x218/0x280 [snd_hda_intel]
[ 6250.746667]  pci_pm_runtime_resume+0x76/0xa0
[ 6250.746672]  __rpm_callback+0xb4/0x1f0
[ 6250.746677]  ? pci_restore_standard_config+0x40/0x40
[ 6250.746682]  rpm_callback+0x1f/0x80
[ 6250.746686]  ? pci_restore_standard_config+0x40/0x40
[ 6250.746690]  rpm_resume+0x4ba/0x740
[ 6250.746698]  __pm_runtime_resume+0x49/0x80
[ 6250.746703]  pci_pm_suspend+0x57/0x140
[ 6250.746709]  dpm_run_callback+0x6f/0x330
[ 6250.746713]  ? pci_pm_freeze+0xe0/0xe0
[ 6250.746718]  __device_suspend+0xf9/0x370
[ 6250.746724]  ? dpm_watchdog_set+0x60/0x60
[ 6250.746730]  async_suspend+0x1a/0x90
[ 6250.746735]  async_run_entry_fn+0x34/0x160
[ 6250.746741]  process_one_work+0x1f2/0x6d0
[ 6250.746749]  worker_thread+0x49/0x4a0
[ 6250.746755]  kthread+0x107/0x140
[ 6250.746759]  ? process_one_work+0x6d0/0x6d0
[ 6250.746763]  ? kthread_create_on_node+0x40/0x40
[ 6250.746768]  ret_from_fork+0x2e/0x40
[ 6250.746778] ---[ end trace 102a62fd2160f5e6 ]---

v2:
- Use the new pci_dev->needs_resume flag, to avoid any overhead during
  the ->pm_prepare hook. (Rafael)

Fixes: bac2a909a096 ("PCI / PM: Avoid resuming PCI devices during system suspend")
References: https://bugs.freedesktop.org/show_bug.cgi?id=100378
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Marta Lofstedt <marta.lofstedt@intel.com>
Cc: David Weinehall <david.weinehall@linux.intel.com>
Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk> (v1)
---
 drivers/gpu/drm/i915/i915_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 8be958f..dd7ce69 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1207,6 +1207,15 @@ int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_free_priv;
 
 	pci_set_drvdata(pdev, &dev_priv->drm);
+	/*
+	 * Disable the system suspend direct complete optimization, which can
+	 * leave the device suspended skipping the driver's suspend handlers
+	 * if the device was already runtime suspended. This is needed due to
+	 * the difference in our runtime and system suspend sequence and
+	 * becaue the HDA driver may require us to enable the audio power
+	 * domain during system suspend.
+	 */
+	pci_resume_before_suspend(pdev, true);
 
 	ret = i915_driver_init_early(dev_priv, ent);
 	if (ret < 0)
-- 
2.5.0
