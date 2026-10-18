Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25C3DAABE;
	Sun, 18 Oct 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341589; cv=none; b=EY2tXgcFWD+rzERsUB01EJtr0CgjtV8I1LM4AydvjRqc2FJkUq6LKOitzGNM8a2hguq0S1zuvWL8Ej52MXuH/hIirn/hcyWzZJqCDGMeODR1Abb/0eLPAd66cTqH7S/YJcu+PR4OBBbjH/I8MIO2xpMlwJKZViFr3zHM0D7btas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341589; c=relaxed/simple;
	bh=wiuqhKDFFiN/prD7X1V5jprsERJYlwxTTS2oLB9lPbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaMMswfp4BJEun7tfegGPAuKF4+bMisNI7nF4EIkuuim4h1+zYKOAluq8PjI4nYZXfdVXxP0fZheY/6/Z09xQPf8ImZ7yBn5hOI065xLiAr+DNBKtFV+F5p0s2Kj76t+0bZvxz4pyZ9UzTWgI+hn519GI15slsGVynTgLy14JYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=dfecKDUd; dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=OXnkvEXL; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="dfecKDUd";
	dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="OXnkvEXL"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341582; bh=NEa26fheps
	46uhHUomRCw+7tK+W+HuxA+vMg5443bKo=; b=dfecKDUdOpmbZYE6RyjCHRDCAOcz2n3AlM2Ii
	rne8cUZ85J7E7oQTcc8GjKr9KUiHuWgV5hjMwnAlKPHEVHKMQipEIHWEFANseX6pvsnxD24aIz/
	69oi6nN2cktlTpf6kz5JJHU0JrI6skCy7H6FViAtCNnPwBP0MQE0wl7KHM62c+XFNzjP8li4ply
	EhsferO1e60ZxzqnmJG5aF96k8ZvUHvoRB5N5ylA7gFBNS/1DFkyceH0SP9RiWjkdegVKSXwnLB
	7a70EArkZYhYSkbyTLmW8tyogzriq2rJ+94JPHXDufHAFWp9twzNkFuyY/ZCJRiUZqAa54+2UiW
	cH4kQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341582; bh=NEa26fheps
	46uhHUomRCw+7tK+W+HuxA+vMg5443bKo=; b=OXnkvEXLnj86PAvznWd2I5kUZaZvJisJ+Z54v
	TP5AukTKI8au5Qt34FZZ9DSq0xOH1tCX/R55fRJweE4+QFXCQ==;
From: Cole Leavitt <cole@unwrap.rs>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>
Cc: Cole Leavitt <cole@unwrap.rs>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: pciehp: Defer device replacement handling until ->resume()
Date: Sun, 18 Oct 2026 12:39:07 -0400
Message-ID: <20261018163910.132231-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018163750.130470-1-cole@unwrap.rs>
References: <20261018163750.130470-1-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Lenovo ThinkPad P16 Gen3 with a discrete Thunderbolt 5 host
controller (Intel JHL9580 "Barlow Ridge") below Root Port 0000:80:1b.4,
resume from suspend-to-idle intermittently hangs with a black screen:

  pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
  pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
  thunderbolt 0000:8a:00.0: RX ring 0 already stopped
  ...
  Oops: general protection fault, kernel NULL pointer dereference 0x32b
  Workqueue: async async_run_entry_fn
  RIP: 0010:tb_resume_noirq+0x3f/0x2e0 [thunderbolt]
  Call Trace:
   tb_domain_resume_noirq+0x42/0x60 [thunderbolt]
   dpm_run_callback+0x4b/0x140
   device_resume_noirq+0x16d/0x2c0
   async_resume_noirq+0x21/0x30
   async_run_entry_fn+0x36/0x160

The link to Barlow Ridge is not up in time when the Root Port returns
from D3cold, so the devices below it are marked disconnected and
pciehp_resume_noirq() considers the device in the slot replaced.  It
then synthesizes a Presence Detect Changed event with pciehp_request(),
which wakes the IRQ thread through irq_wake_thread().  Unlike hardirq
delivery, irq_wake_thread() is not inhibited by suspend_device_irqs(),
so the IRQ thread starts bringing down the slot immediately, in the
middle of the noirq phase.

The PM core resumes the devices below the hotplug port asynchronously
and holds no device_lock in the noirq and early phases, so the removal
is not serialized against their ->resume_noirq() callbacks:  The IRQ
thread unbinds the NHI (nhi_pci_remove() -> tb_domain_remove() ->
tb_stop(), which sets tb->root_switch to NULL) while nhi_resume_noirq()
-> tb_resume_noirq() runs concurrently on another CPU and dereferences
tb->root_switch.  Before commit e56249d8a68e ("thunderbolt: Set
tb->root_switch to NULL when domain is stopped") the pointer was left
dangling instead.  Any other driver below a hotplug port is exposed to
the same race.

Only record the synthesized event in pciehp_resume_noirq() and wake the
IRQ thread from pciehp_system_resume(), the ->resume() callback used for
system sleep transitions.  By then all noirq and early callbacks have
completed, and device_resume() holds the device_lock across each
driver's ->resume() callback, which the removal path acquires in
device_release_driver().  This is also where pciehp_check_presence()
already requests bringing down slots vacated during system sleep.
Runtime resume is left alone.

The old devices are still marked disconnected in the noirq phase, so
that their drivers and any nested hotplug ports (see commit e3260237aaad
("PCI: pciehp: Avoid unnecessary device replacement check")) keep
seeing them as gone.

A real hotplug interrupt cannot consume the deferred event earlier
either, as long as PME is native:  pciehp_suspend() then masks the
hotplug interrupt and only pciehp_resume() unmasks it again.  Without
native PME the interrupt stays enabled across system sleep, and an event
latched after resume_device_irqs() can still run the IRQ thread during
the early phase, but no longer during the noirq phase.

pciehp_resume_noirq() also serves as ->restore_noirq() and is likewise
followed by ->resume(), so resume from hibernation is fixed as well.

Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---

Notes:
    Tested on a Lenovo ThinkPad P16 Gen 3 (Core Ultra 9 275HX, JHL9580
    Barlow Ridge host, I226 Ethernet), in daily use with s2idle since
    2026-09-17.

 drivers/pci/hotplug/pciehp_core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 2cafd3b26f34..850a6d3bb08a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -302,12 +302,19 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 		 * during system sleep, mark the old device disconnected
 		 * (to prevent its driver from accessing the new device)
 		 * and synthesize a Presence Detect Changed event.
+		 *
+		 * Don't wake the IRQ thread yet:  The PM core resumes the
+		 * devices below asynchronously and without holding their
+		 * device_lock in the noirq and early phases, so bringing
+		 * the slot down now would race with their ->resume_noirq()
+		 * and ->resume_early() callbacks.  pciehp_system_resume()
+		 * wakes the IRQ thread once those have completed.
 		 */
 		if (pciehp_device_replaced(ctrl)) {
 			ctrl_dbg(ctrl, "device replaced during system sleep\n");
 			pci_walk_bus(ctrl->pcie->port->subordinate,
 				     pci_dev_set_disconnected, NULL);
-			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+			atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events);
 		}
 	}
 
@@ -327,6 +334,21 @@ static int pciehp_resume(struct pcie_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pciehp_system_resume(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	pciehp_resume(dev);
+
+	/* Act on events deferred by pciehp_resume_noirq() */
+	if (atomic_read(&ctrl->pending_events))
+		pciehp_request(ctrl, 0);
+
+	return 0;
+}
+#endif
+
 static int pciehp_runtime_suspend(struct pcie_device *dev)
 {
 	pciehp_disable_interrupt(dev);
@@ -362,7 +384,7 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 #ifdef	CONFIG_PM_SLEEP
 	.suspend	= pciehp_suspend,
 	.resume_noirq	= pciehp_resume_noirq,
-	.resume		= pciehp_resume,
+	.resume		= pciehp_system_resume,
 #endif
 	.runtime_suspend = pciehp_runtime_suspend,
 	.runtime_resume	= pciehp_runtime_resume,
-- 
2.54.0

