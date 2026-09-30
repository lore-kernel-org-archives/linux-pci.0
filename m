Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018751E447;
	Wed, 30 Sep 2026 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804373; cv=none; b=lyZNdrS4ub3ZjggRP8uhm0tILH5t5udYrpsG9Zi7IDy0ona8aspFWo4z84RUwooJ6ZBFQ2K1bf4xWW1HjmrHLInXBUKJpLdfN1kJoCUupptRzEv6OV7nwWyYcyCi7mUFbjz1L5pjWq5EG6AFwIOxVbhMKsvvVbuLdpbyQzBGhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804373; c=relaxed/simple;
	bh=0lJDwxqCZ6D8n1pdJl3f/uF7IPKpkh7NoduCswmcY9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbz86Be+6PiX5NYRvDQ4DAfW+0s7fYSGP8qmERkvOTnBX1ujqa+eW/EDoAcGsuZdz8L/f2gYDzL5tLL2dedZjoYTnvab91UMCuZi9g/yAExCjMn9Ri2oWlE5UNhUWA9QfSWz60dnQpXUDI7NbMM8cC8376gJqTGVeOJ4CLIU5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpAPfF8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpAPfF8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58751F0089B;
	Wed, 30 Sep 2026 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804371;
	bh=tKf9VOxpzV5Ieqvq6hFE0kHe2yK2wOQK/hv2k/ZrivM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpAPfF8Q2qQCgZdKncnRtr8MlUcUrq7QwQMgDgYJ7GNTtV/4JcrGUEMeD2fHQztGL
	 Jha+2gdXPuSkNzfU2380uR+8aV7rK4TqQObYHNw842BO83bBUV0YrU28w9IRUIgbl9
	 OEBvyysnC686TQY9TOpJY4REFUVEqk1tJo/gE2raGYdo5wPSy9xJYEbOvcih+Zs1AC
	 qBq4PHEFSlDNPRg1dWI66jfe+6L6h2sh/slDeWxaQfYoJBlRCoDnWc/svtzoHqArdN
	 9WvEP6RiVdk4nSuVUgLdr+tN6ECDFUI8LxWPEaPdA2/lF/UZy4dDoBDtrypL0xQeH5
	 WHsd9n5QOS0iA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v6 2/2] PCI: Align hibernate poweroff flow with suspend flow for bridges
Date: Wed, 30 Sep 2026 16:39:23 -0500
Message-ID: <20260930213923.566846-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930213923.566846-1-superm1@kernel.org>
References: <20260930213923.566846-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
downstream devices into a low-power state (D3hot or D3cold) when the
platform allows it.  The hibernate poweroff_noirq path never did this:
it only called pci_prepare_to_sleep() for devices with no subordinate,
so bridges with active children were left in D0.

On many designs the platform firmware leaves bridges alone when the
system enters S4. This prevents being able to meet various energy
certification criteria for different parts of the world, particularly
in designs with a dGPU.

Align the hibernate flow with suspend by making pci_pm_poweroff_noirq()
use pci_pm_suspend_noirq_common() instead of the open-coded
pci_prepare_to_sleep() call.  This reuses exactly the logic the S3
suspend path uses, including the skip_bus_pm handling that keeps a
bridge in D0 when a downstream device must stay in D0 (e.g. a
configured wakeup source) and the pm_suspend_no_platform() bus-PM skip.
This alone is safe for the normal power-off-and-reboot path, since the
hibernation image is snapshotted before poweroff_noirq runs and
restoring it always goes through a full boot that re-enumerates and
retrains the PCIe links.

It isn't enough if hibernation_platform_enter() aborts after
dpm_suspend_end(PMSG_HIBERNATE) but before power-off: that recovers via
dpm_resume_start(PMSG_RESTORE) without rebooting, which calls
pci_pm_restore_noirq() instead of pci_pm_resume_noirq().  Give
pci_pm_restore_noirq() the same D3cold handling pci_pm_resume_noirq()
already has, so a bridge coming out of D3cold gets
pci_pm_bridge_power_up_actions() before its children's restore_noirq
callbacks run against a possibly untrained link.

Mirror the suspend_noirq guard for drivers as well: if a driver's
poweroff_noirq callback already left the device in a low-power state
without saving its configuration, skip pci_pm_suspend_noirq_common() and
go straight to the fixups, exactly as pci_pm_suspend_noirq() does.  This
avoids having the core call pci_save_state() on a device the driver has
already powered down, whose configuration space may no longer be
readable, which could otherwise corrupt the saved state used on a
poweroff abort.

Because the poweroff_noirq path now mirrors the already-shipping
suspend_noirq path and is guarded identically, bridges that must remain
in D0 are unaffected; only bridges that S3 suspend would have powered
down are now also powered down at hibernate.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v6:
 * Restore secondary bus wait in pci_pm_restore_noirq() on hibernate abort
   Link: https://lore.kernel.org/linux-pci/20260916210522.3A1111F00899@smtp.kernel.org/
   (Sashiko)
v5:
 * Add a guard like suspend path has
 * Add tag for Rafael
 * Reword title
 * Clarify that not all designs leave bridges alone at S4
---
 drivers/pci/pci-driver.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8334214f8c1ed..7efe808cdf0cc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,7 +818,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
  * @pci_dev: pci device
@@ -862,7 +862,7 @@ static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
 
 	return false;
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1217,6 +1217,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1259,6 +1261,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1272,16 +1275,26 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	}
 
 	if (pm->poweroff_noirq) {
+		pci_power_t prev = pci_dev->current_state;
 		int error;
 
 		error = pm->poweroff_noirq(dev);
 		suspend_report_result(dev, pm->poweroff_noirq, error);
 		if (error)
 			return error;
+
+		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
+		    && pci_dev->current_state != PCI_UNKNOWN) {
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: State of device not saved by %pS\n",
+				      pm->poweroff_noirq);
+			goto Fixup;
+		}
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1290,6 +1303,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
@@ -1299,10 +1313,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.53.0

