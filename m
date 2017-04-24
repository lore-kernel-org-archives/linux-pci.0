Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:40085 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977803AbdDXUmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2017 16:42:18 -0400
Date: Mon, 24 Apr 2017 22:42:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI / PM: Add needs_resume flag to avoid suspend
 complete optimization
Message-ID: <20170424204242.GA9933@wunner.de>
References: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
 <20170424200230.GA9910@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170424200230.GA9910@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 24, 2017 at 10:02:30PM +0200, Lukas Wunner wrote:
> On Mon, Apr 24, 2017 at 05:27:42PM +0300, Imre Deak wrote:
> > Some drivers - like i915 - may not support the system suspend direct
> > complete optimization due to differences in their runtime and system
> > suspend sequence. Add a flag that when set resumes the device before
> > calling the driver's system suspend handlers which effectively disables
> > the optimization.
> 
> FWIW, there are at least two alternative solutions to this problem which
> do not require changes to the PCI core:
> 
> (1) Add a ->prepare hook to i915_pm_ops which calls pm_runtime_get_sync()
>     and a ->complete hook which calls pm_runtime_put().

Thinking a bit more about this, it's even simpler:  The PM core acquires
a runtime PM ref in device_prepare() and releases it in device_complete(),
so it's sufficient to just call pm_runtime_resume() in a ->prepare hook
that's newly added to i915.  No ->complete hook necessary.  Tentative
patch below, based on drm-intel-fixes, would replace both of your patches.

Thanks,

Lukas

-- >8 --
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 5c089b3..6ef156b 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1820,6 +1820,11 @@ void i915_reset(struct drm_i915_private *dev_priv)
 	goto wakeup;
 }
 
+static int i915_pm_prepare(struct device *kdev)
+{
+	pm_runtime_resume(kdev);
+}
+
 static int i915_pm_suspend(struct device *kdev)
 {
 	struct pci_dev *pdev = to_pci_dev(kdev);
@@ -2451,6 +2456,7 @@ static int intel_runtime_resume(struct device *kdev)
 	 * S0ix (via system suspend) and S3 event handlers [PMSG_SUSPEND,
 	 * PMSG_RESUME]
 	 */
+	.prepare = i915_pm_prepare,
 	.suspend = i915_pm_suspend,
 	.suspend_late = i915_pm_suspend_late,
 	.resume_early = i915_pm_resume_early,
