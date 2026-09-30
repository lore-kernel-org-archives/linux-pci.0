Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161851CF41;
	Wed, 30 Sep 2026 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804371; cv=none; b=Od0tnMIEDH7+Atw2qlTsqUTAmV8MVOMmghM/V8TPbFhuEHg4j8RnZTdoPE5gYLZPFnf7b0NaKpbrr1IsHRKxfk7/hV5gpMEhxqFsX/d2YN9FI2QHBlXKoAQxXcBg/PcNRs32fHHWTzpuNyFdxlRhe4G8X1GUCyzt6vaVHlMn3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804371; c=relaxed/simple;
	bh=UH9Ca6Qla/mC8wHWFTlBt3E3KVq9cCrrzunoId5ojx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFoGqLdTS2M56nZFKW2JLYo4OULhBH+bbb+JaRWpt5CAsAFaCyQKedAFugKhozaofJPY+Gk/uedV9n8aXeuEd8Pnmys3s2RpAJPWYWIbvt8xXhwVNkcPJqyqsn2T9yIIDuvzY5uY23p3FdQxEaCSahndltdhjnsZoqo9q/B7bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6KstfXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6KstfXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C662B1F00899;
	Wed, 30 Sep 2026 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804370;
	bh=KdBV+MC/VlZlbAsm4y93pycFSEj+ci+tSgTjQcaP3Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q6KstfXXQGupHBKGg4wacy4vrQamhbR7xhZanjrX/O7Nvsu+TOZek64N4WfAW7h0U
	 Mz4XLLK2bMSGonY8eMKyJgZvVfSsnfvq/84XmXP4sOl21pLS+DWHpzvwBVV1udv90E
	 Z7KbKpo6IcmxZc7yxlcoJyMF3d7FQpJrZv5nMyaf5F2rqto1o+0c13Cn6Y1DJIqrpn
	 1EpTqKYPkEK9vBUljIeEkKQlf75O719MKrs90hzssnvD46KC3ixq8Zf5/a+mPgYhZp
	 IwzXyx96hfz86obb0cyb52RgHdnxoxt0y16D+OEiCAKM6OkwjFk6HvPc9TDL91993W
	 rEOLYNjh2e5Ow==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH v6 1/2] PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
Date: Wed, 30 Sep 2026 16:39:22 -0500
Message-ID: <20260930213923.566846-2-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930213923.566846-1-superm1@kernel.org>
References: <20260930213923.566846-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to unify suspend and hibernate codepaths without code duplication
the common code should be in common helpers.  Move it from
pci_pm_suspend_noirq() into a helper.  No intended functional changes.

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add tag
v4:
 * Make pci_pm_suspend_noirq_common() bool instead (Rafael)
---
 drivers/pci/pci-driver.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac8..8334214f8c1ed 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,6 +818,52 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#if defined(CONFIG_SUSPEND)
+/**
+ * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
+ * @pci_dev: pci device
+ *
+ * Save the device state and decide whether bus-level power management should
+ * skipped. Returns true if bus-level power management should be skipped,
+ * false otherwise.
+ */
+static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
+{
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
+
+		/*
+		 * If the device is a bridge with a child in D0 below it,
+		 * it needs to stay in D0, so check skip_bus_pm to avoid
+		 * putting it into a low-power state in that case.
+		 */
+		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
+			pci_prepare_to_sleep(pci_dev);
+	}
+
+	pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
+		pci_power_name(pci_dev->current_state));
+
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
+		 * downstream device is in D0, so avoid changing the power state
+		 * of the parent bridge by setting the skip_bus_pm flag for it.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
+	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
+		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_SUSPEND */
+
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
 {
@@ -907,6 +953,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -937,36 +984,10 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (!pci_dev->state_saved) {
-		pci_save_state(pci_dev);
-
-		/*
-		 * If the device is a bridge with a child in D0 below it,
-		 * it needs to stay in D0, so check skip_bus_pm to avoid
-		 * putting it into a low-power state in that case.
-		 */
-		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
-			pci_prepare_to_sleep(pci_dev);
-	}
+	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
 
-	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
-		pci_power_name(pci_dev->current_state));
-
-	if (pci_dev->current_state == PCI_D0) {
-		pci_dev->skip_bus_pm = true;
-		/*
-		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
-		 * downstream device is in D0, so avoid changing the power state
-		 * of the parent bridge by setting the skip_bus_pm flag for it.
-		 */
-		if (pci_dev->bus->self)
-			pci_dev->bus->self->skip_bus_pm = true;
-	}
-
-	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
-		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+	if (skip_bus_pm)
 		goto Fixup;
-	}
 
 set_unknown:
 	pci_pm_set_unknown_state(pci_dev);
-- 
2.53.0

