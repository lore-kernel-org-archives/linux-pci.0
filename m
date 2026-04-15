Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5F3E314D
	for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268569; cv=none; b=b0EL2YxIESpfnNanrH0ncGbxDR7jilGg25Z1fX6ykk4kAJ79QqCARFLMOv0dLz/kWhxOoiO5DJk9TviOc5X4eY1X+aGIIC/VG+OKzjfSHNAiENAo6S4DDDEzfM4GtocWEJcZIqDbE4hvqnwpXOqksyVM20fqjdQth24UjPE5S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268569; c=relaxed/simple;
	bh=d1UU5ZXPZHtItb3fz+Vnqm12sYKrz0Zq+3sQFJsVmxQ=;
	h=Message-Id:From:Date:Subject:To:Cc; b=ks2UI3h+QQcpi/j8Zy/zO6sA+QJXLwdp97TDCYJFy++Y5Inmo1SI5sFBfqNP53J1gvbcdabd4N/hPu+Vh/uJ11DpaWCF7xuvulyV2XfTw1JNCF82xOYWotcKUmjesJ0ETI1wvH2IxsEZjtY4oTi9OuZcjNQsr5dGx88CnUXObmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 6CE23C81;
	Wed, 15 Apr 2026 17:56:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 422B06017606; Wed, 15 Apr 2026 17:56:03 +0200 (CEST)
Message-Id: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 15 Apr 2026 17:56:06 +0200
Subject: [PATCH] PCI: Update saved_config_space upon resource assignment
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bernd Schumacher <bernd@bschu.de>, "Alexandre N." <an.tech@mailo.com>, Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org, Uwe Kleine-Koenig <ukleinek@debian.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, Alex Williamson <alex@shazbot.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, regressions@lists.linux.dev, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
adapter plugged into an ASRock X570S PG Riptide board with BIOS version
P5.41 (09/07/2023):

  ddbridge 0000:05:00.0: detected Digital Devices Cine S2 V6 DVB adapter
  ddbridge 0000:05:00.0: cannot read registers
  ddbridge 0000:05:00.0: fail

BIOS assigns an incorrect BAR to the DVB adapter which doesn't fit into
the upstream bridge window.  The kernel corrects the BAR assignment:

  pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
  pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned

Correction of the BAR assignment happens in an x86-specific fs_initcall,
pcibios_assign_resources(), after device enumeration in a subsys_initcall.
This order was introduced at the behest of Linus in 2004:

    https://git.kernel.org/tglx/history/c/a06a30144bbc

No other architecture performs such a late BAR correction.

Bernd bisected the issue to commit a2f1e22390ac ("PCI/ERR: Ensure error
recoverability at all times"), but it only occurs in the absence of commit
4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").
This combination exists in stable kernel v6.12.70, but not in mainline,
hence Bernd cannot reproduce the issue with mainline.

Since a2f1e22390ac, config space is saved on enumeration, prior to BAR
correction.  Upon passthrough, the corrected BAR is overwritten with the
incorrect saved value by:

  vfio_pci_core_register_device()
    vfio_pci_set_power_state()
      pci_restore_state()

But only if the device's current_state is PCI_UNKNOWN, as it was prior to
commit 4d4c10f763d7.  Since the commit, it is PCI_D0, which changes the
behavior of vfio_pci_set_power_state() to no longer restore the state
without saving it first.

Alexandre is reporting the same issue as Bernd, but in his case, mainline
is affected as well.  The difference is that on Alexandre's system, the
host kernel binds a driver to the device which is unbound prior to
passthrough, whereas on Bernd's system no driver gets bound by the host
kernel.

Unbinding sets current_state to PCI_UNKNOWN in pci_device_remove(), so
when vfio-pci is subsequently bound to the device, pci_restore_state() is
once again called without invoking pci_save_state() first.

To robustly fix the issue, always update saved_config_space upon resource
assignment.

Reported-by: Bernd Schumacher <bernd@bschu.de>
Tested-by: Bernd Schumacher <bernd@bschu.de>
Closes: https://lore.kernel.org/r/acfZrlP0Ua_5D3U4@eldamar.lan/
Reported-by: Alexandre N. <an.tech@mailo.com>
Tested-by: Alexandre N. <an.tech@mailo.com>
Closes: https://lore.kernel.org/r/dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com/
Fixes: a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.12+
---
 drivers/pci/setup-res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e5fcadf..1769ba9 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -102,6 +102,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	pci_write_config_dword(dev, reg, new);
+	dev->saved_config_space[reg / 4] = new;
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
@@ -112,6 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	if (res->flags & IORESOURCE_MEM_64) {
 		new = region.start >> 16 >> 16;
 		pci_write_config_dword(dev, reg + 4, new);
+		dev->saved_config_space[(reg + 4) / 4] = new;
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
 			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",
-- 
2.51.0

