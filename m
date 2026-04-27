Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511836BCED;
	Mon, 27 Apr 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262028; cv=none; b=XAjUBbWixJsBDCtQcDx64goyrDY3xj+OmcT1C+FgJtB4v8Sjju1I3z1o7yHAAUgWirerTGtzefyjyb5zW/ew5ZiGlQnBSyxo4fEtQVA/+k6AsZXU1OmPegxAfhqtcJRY+7XDNCatTEb5x0pbq2oj3MuvykGRlUADwK+LsdbMfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262028; c=relaxed/simple;
	bh=y9lTOCLHLo2JLs/Ccj8IJcEeaNjA1o66+3L4hubTkuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NESIFVUdkBUDRZXUjRuOQaEPirNyyfIHXWbuIt55vpesxwJ4lFqDHDnJKsDU/G6VwooCqjPwX/ePKsBL3DB5xWhMPhe0w4bxs4wpAlRu9xntHwBrwz5HCb5pZebF5Ckurw35IAhlrJQoSogy+V94Od4ErsDMZzMPrZi5A3c0Ml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIGg2Sut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIGg2Sut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C255DC19425;
	Mon, 27 Apr 2026 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262028;
	bh=y9lTOCLHLo2JLs/Ccj8IJcEeaNjA1o66+3L4hubTkuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIGg2SutsfGar2eR0trwg7Chl+tDY5tPxtBkRB4jXu2GXcSSf7+mM+lxLKKf8YbvL
	 OGSITi9ZCRh2MdAnGqtTaz2UMkT4YSNQ9UWSoP/oWJ5aETHdP5CK3BMTNabW9pdwYZ
	 ikhGRgW0hqNZcuoSNIcF1ikb3+lHQfHJ0m4YvzzAOLHRR6q8RGPELFMdT2tmv30dBu
	 mXRnnpcd6CbvBsJwIVpT41mu8RnQHOvhzu/4iLMlEnHsD0R95fjraXxhLLlDYd1k3K
	 r1xOlnIaaiIis7ZaVBkrfEI1s0dCrd9LX/WcDCEjsNgIk8f3oOolHGco3WPj1cwgtn
	 03NKv422300Mw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 2/5] PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
Date: Sun, 26 Apr 2026 22:53:38 -0500
Message-ID: <20260427035341.1425576-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035341.1425576-1-superm1@kernel.org>
References: <20260427035341.1425576-1-superm1@kernel.org>
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

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 86 +++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a43ee7bbfb3f5..bfb521eb0eed7 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -788,6 +788,54 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#if defined(CONFIG_SUSPEND)
+/**
+ * pci_pm_suspend_noirq_common
+ * @pci_dev: pci device
+ * @skip_bus_pm: pointer to a boolean indicating whether to skip bus PM
+ *
+ * Prepare the device to go into a low power state by saving state and
+ * deciding whether to skip bus PM.
+ *
+ */
+static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *skip_bus_pm)
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
+		*skip_bus_pm = true;
+		return;
+	}
+
+	pci_pm_set_unknown_state(pci_dev);
+}
+#endif /* CONFIG_SUSPEND */
+
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
 {
@@ -877,6 +925,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm = false;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -886,7 +935,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pm) {
 		pci_save_state(pci_dev);
-		goto set_unknown;
+		pci_pm_set_unknown_state(pci_dev);
+		goto Ehci_workaround;
 	}
 
 	if (pm->suspend_noirq) {
@@ -907,40 +957,12 @@ static int pci_pm_suspend_noirq(struct device *dev)
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
-
-	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
-		pci_power_name(pci_dev->current_state));
+	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
 
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
-
-set_unknown:
-	pci_pm_set_unknown_state(pci_dev);
 
+Ehci_workaround:
 	/*
 	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
 	 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
-- 
2.43.0

