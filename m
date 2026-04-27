Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595A33ADA9;
	Mon, 27 Apr 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323034; cv=none; b=FTKJZGhtl5Azb63NWy5caOLsyM8DvLoPWv9yRrpL8GENGhXs7CP1nq4dvE+TRBcbFw+Xlf2UqMAr+7qVOTP3CG89aPwR7VP1/E8NUJe9GfKnz5+Xd9MUv7oQx1160Jsgbk2EmarO7gDAkU9WY9OFOGW4JYCTiYVWCeIi8F8msBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323034; c=relaxed/simple;
	bh=+Nec97Tui9c9Iet178LuyVfsDVIn5g6EVyth9hJ5hvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOmwq/Hj3gOw6AikCDxeni0IR2YqJbR/xrj4SccDgqktGBhwabePR8xGCB2y4IRAXWppimnXbdZibSyo3U2uQnBnsnF00rzveYHGDZYmiYiZqpHA2yxQ6n1LofaQ6eZ/rRzJT43PaeyU9CQJ/xgmWcYCi49m0spJHh0OgUZtcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm1n4ziy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm1n4ziy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F4DC2BCB5;
	Mon, 27 Apr 2026 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323034;
	bh=+Nec97Tui9c9Iet178LuyVfsDVIn5g6EVyth9hJ5hvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sm1n4ziyAPzZniBzAm5GdF/KWAc7Z/k6w1bTdPGrTfjosSnamXxEEAEGH0FdMg08E
	 pkdTa6jwC5iPFqj3SADBTk6P/UAp+tT+sA0psE4U5Hhs5wwHalN63PapHGujmtFa/n
	 mrnFa5UWx4cuPnh5KEhnr+t6/54LZI7bo6mm97QkdzPMdE7EBC+zyP+3vwx7Tzclry
	 HUpXGR8hXek4sRPts+fSkphIhDMY+b1RVuofH1LyA51KHqhRTvkygnjUARmq15UR66
	 DExFGjDQ9iA1vnOTA2RIMvuxGu6lw9Yt9LA4D+FPy4HIysWMCjdzzZI8h2UZsH/ket
	 DQbAsjG6U77ow==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 1/6] PCI: Stop setting cached power state to "unknown" on unbind
Date: Mon, 27 Apr 2026 15:50:19 -0500
Message-ID: <20260427205024.254677-2-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427205024.254677-1-superm1@kernel.org>
References: <20260427205024.254677-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

When a PCI device is unbound from its driver, pci_device_remove() sets the
cached power state in pci_dev->current_state to PCI_UNKNOWN.  This was
introduced by commit 2449e06a5696 ("PCI: reset pci device state to unknown
state for resume") to invalidate the cached power state in case the system
is subsequently put to sleep.

For bound devices, the cached power state is set to PCI_UNKNOWN in
pci_pm_suspend_noirq(), immediately before entering system sleep.

Extend to unbound devices for consistency.

This obviates the need to change the cached power state on unbind, so stop
doing so.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0f..2bfefd8db5260 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -512,13 +512,6 @@ static void pci_device_remove(struct device *dev)
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
 
-	/*
-	 * If the device is still on, set the power state as "unknown",
-	 * since it might change by the next time we load the driver.
-	 */
-	if (pci_dev->current_state == PCI_D0)
-		pci_dev->current_state = PCI_UNKNOWN;
-
 	/*
 	 * We would love to complain here if pci_dev->is_enabled is set, that
 	 * the driver should have called pci_disable_device(), but the
@@ -893,7 +886,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pm) {
 		pci_save_state(pci_dev);
-		goto Fixup;
+		goto set_unknown;
 	}
 
 	if (pm->suspend_noirq) {
@@ -945,6 +938,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		goto Fixup;
 	}
 
+set_unknown:
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
-- 
2.53.0

