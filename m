Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172030EF9A
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415909; cv=none; b=l6HVxyj3Z0aK8diJPY9+jG3gTdz3evHqiHcYB378EU6mQERg839Bpeu+aH/FGtnZjYzn1zgBeUHsYRO3Din7gqd1cwaV/h1SbRQ6btZXpudsAmJulDOOGN1UNDkatakQG7y17/7UEc2zbHuRTiGo/Jcz1q8uOoMCPQE9bzsp0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415909; c=relaxed/simple;
	bh=13QWmgexTjKgPWUs92J+iLyxUFTvlmZV6JzYUygNFuE=;
	h=Message-Id:From:Date:Subject:To:Cc; b=bnJJNyS6w6WDfVc56Mt6C1YhBiCKoAfwn5t5OSyB87OUa9JzL8c0303VG4UcBNTvhU4MuDvH8mDADTgQI7UFZv5ZHrw6HVrXubjV4w12LuIj4ofcf8Ytq7vwT3shfgyGTjXbbSgMXqWJ1dEIiOmbu9qWEh3i0ssrW3SiECHOXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 53C4AC27;
	Fri, 17 Apr 2026 10:51:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 388FE6015A92; Fri, 17 Apr 2026 10:51:45 +0200 (CEST)
Message-Id: <af7d11d3ceb231acc90829f7a5c8400c2446744f.1776415510.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 17 Apr 2026 10:51:46 +0200
Subject: [PATCH] PCI: Stop setting cached power state to "unknown" on unbind
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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
---
 drivers/pci/pci-driver.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d5..774892d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -482,13 +482,6 @@ static void pci_device_remove(struct device *dev)
 	pm_runtime_put_sync(dev);
 
 	/*
-	 * If the device is still on, set the power state as "unknown",
-	 * since it might change by the next time we load the driver.
-	 */
-	if (pci_dev->current_state == PCI_D0)
-		pci_dev->current_state = PCI_UNKNOWN;
-
-	/*
 	 * We would love to complain here if pci_dev->is_enabled is set, that
 	 * the driver should have called pci_disable_device(), but the
 	 * unfortunate fact is there are too many odd BIOS and bridge setups
@@ -862,7 +855,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pm) {
 		pci_save_state(pci_dev);
-		goto Fixup;
+		goto set_unknown;
 	}
 
 	if (pm->suspend_noirq) {
@@ -914,6 +907,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		goto Fixup;
 	}
 
+set_unknown:
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
-- 
2.51.0

