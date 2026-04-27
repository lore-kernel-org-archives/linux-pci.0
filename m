Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB337D128;
	Mon, 27 Apr 2026 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262031; cv=none; b=phN/CcjVzNWKVAXOmdyfLcesmAnPsGyIzJQZLRkO+1vgIVdRcvAu+G84hwRPhtMVbJj/A/X1d1JgwFgFr8/dDU4bjBbnvrMyB7slBUm4ikGbcAWz9UvCOLboDVTGr9zDGhsGkN5KwzQb+QZlYMObvzvaDaLZHs0CqTED7vkPTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262031; c=relaxed/simple;
	bh=rDQRwElc9pcyQqxjF3uXG5jwNZhWPNxCd8O+CxwRzzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owNgliEg0oOhqpImyIzm1mGaIOmZBb41N3Yd0rhclDQYqr58bOc2YAs7fooNm8cC6hqlodSR8X3zmhDHCIiLmxwRzYT7sMdcR4b3DSj1IPNghQB4yMwOQo2+AS5m2PZeCzpwMZpx/GQZfPLijcYy+dO+I/DhHOY9+Ts6wKDMjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD2N8vtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD2N8vtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9955CC19425;
	Mon, 27 Apr 2026 03:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262031;
	bh=rDQRwElc9pcyQqxjF3uXG5jwNZhWPNxCd8O+CxwRzzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KD2N8vtAH4AcEyM0BXTiDJdVtfuPB/rqEFS/zuyJs5tUUpEs3276Ub67lom9NffX+
	 TtZyzxcd4EBRpRooIsa0YnbSlsFEwN4jiiDVzGVEQ37fNbTHoNs1iORDjOeP1AC+3H
	 iEvngni64LRhH3IbbS37M9b4nYszAvn5de7K9y7Cy1P4B3f7NH/SwGaRgAnHQ0wKnk
	 SDsmdDQq6Ll95pp+K+oVI1LCxQzhgEx+ivmy2MGITCCKNgtP8ao28RCNRPsUpbZdPb
	 NJBuc2/hmTmN1Sd/cwS6nE0u3Sa17BfOsGv4l/I17gyIdJy///wxNqUu2H8ihB+OIs
	 plRruHg2FzmtQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 5/5] PCI: Put PCIe bridges with downstream devices into D3 at hibernate
Date: Sun, 26 Apr 2026 22:53:41 -0500
Message-ID: <20260427035341.1425576-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035341.1425576-1-superm1@kernel.org>
References: <20260427035341.1425576-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During suspend, PCIe bridges with downstream devices are transitioned into
a low power state (D3hot or D3cold) depending on platform capabilities.
However, during hibernate, these bridges remain in D0, which can lead to
unnecessary power consumption.

Align the hibernate flow with suspend by updating pci_pm_poweroff_noirq()
to use pci_pm_suspend_noirq_common(). This ensures that PCIe bridges with
active downstream devices are properly transitioned to a low power state
during hibernate.

This change introduces a functional update: the hibernate path will now
invoke pci_save_state(), and — unless bus-level power management is
skipped — will transition the bridge into D3hot or D3cold as appropriate.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3c82d818ee15b..50eca518493b8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -788,7 +788,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common
  * @pci_dev: pci device
@@ -834,7 +834,7 @@ static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *skip_bus_
 
 	pci_pm_set_unknown_state(pci_dev);
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1191,6 +1191,8 @@ static int pci_pm_poweroff(struct device *dev)
 	if (device_may_wakeup(dev) && system_state == SYSTEM_POWER_OFF)
 		device_set_wakeup_enable(dev, false);
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1233,6 +1235,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm = false;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1254,8 +1257,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1264,6 +1268,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.43.0

