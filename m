Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DD40DFA7
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777815291; cv=none; b=P81PdBo/tWGDW3KYszn54dg34pdNTWvNqCmzJnRQzlf/IWEfxvNVmrb8P9ZXg8j5Z/H9h5YXD7ScziiDACQs7k6Acd226BYYnUv/YWCRM4uAFsPZM1znCqThpAD7qPDC/JKJrCeVvblTcmBXdlPBCCFfFrZwqi/h9jzdTDga+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777815291; c=relaxed/simple;
	bh=qIjIHC5+FujueOg7NuhmFe3oOOhObRieh18z5GOs5tg=;
	h=Message-Id:From:Date:Subject:To:Cc; b=MOSLOk4sGhCQabZ8L2BNDP4PGmce/7hfCq6PNRs6GIJ7T21UZ1W0kO0APDAoFL766/0xnIlBy1KcvQ9KR5+2Irh7SnT4elKir7cigo7e/ua3BvIeTWJsU7bSOc/lT8ZpxLMuED2StyoWvFmjE37Zd3HaAHCs26VHdJolaYGS5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B7C9CF7D;
	Sun, 03 May 2026 15:34:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9B4D3600D3A1; Sun,  3 May 2026 15:34:45 +0200 (CEST)
Message-Id: <785c98b50a7a00d0698848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 3 May 2026 15:34:46 +0200
Subject: [PATCH] PCI: Drop unnecessary retries when restoring BARs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Marco Nenciarini <mnencia@kcore.it>, Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>, Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

In 2012, commit 26f41062f28d ("PCI: check for pci bar restore completion
and retry") amended pci_restore_state() to attempt BAR restoration up to
10 times.  This was necessary because back in the day, only a 100 msec
delay was observed after pcie_flr() carried out a Function Level Reset.
The retries ensured that BARs were restored even if devices needed more
time to come out of reset.

In 2016, commit 5adecf817dd6 ("PCI: Wait for up to 1000ms after FLR
reset") extended the delay to 1 sec.  Commit a2758b6b8fdb ("PCI: Rename
pci_flr_wait() to pci_dev_wait() and make it generic") subsequently
extended it further to 60 sec.

The lengthened delay makes it unnecessary to retry BAR restoration, so
drop it.

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Closes: https://lore.kernel.org/r/20260416225745.GA41850@bhelgaas/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Jesse did ask "why we don't do this delay/check when we perform the FLR
in the first place" when he applied the patch, but nobody followed up
with a patch until Alex did four years later:

https://lore.kernel.org/r/003AAFE53969E14CB1F09B6FD68C3CD409A8B4F2@ORSMSX105.amr.corp.intel.com/

 drivers/pci/pci.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc..1e386df 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1764,7 +1764,7 @@ int pci_save_state(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_save_state);
 
 static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
-				     u32 saved_val, int retry, bool force)
+				     u32 saved_val, bool force)
 {
 	u32 val;
 
@@ -1772,52 +1772,42 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
 	if (!force && val == saved_val)
 		return;
 
-	for (;;) {
-		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
-			offset, val, saved_val);
-		pci_write_config_dword(pdev, offset, saved_val);
-		if (retry-- <= 0)
-			return;
+	pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n", offset, val,
+		saved_val);
 
-		pci_read_config_dword(pdev, offset, &val);
-		if (val == saved_val)
-			return;
-
-		mdelay(1);
-	}
+	pci_write_config_dword(pdev, offset, saved_val);
 }
 
 static void pci_restore_config_space_range(struct pci_dev *pdev,
-					   int start, int end, int retry,
-					   bool force)
+					   int start, int end, bool force)
 {
 	int index;
 
 	for (index = end; index >= start; index--)
 		pci_restore_config_dword(pdev, 4 * index,
 					 pdev->saved_config_space[index],
-					 retry, force);
+					 force);
 }
 
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-		pci_restore_config_space_range(pdev, 10, 15, 0, false);
+		pci_restore_config_space_range(pdev, 10, 15, false);
 		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10, false);
-		pci_restore_config_space_range(pdev, 0, 3, 0, false);
+		pci_restore_config_space_range(pdev, 4, 9, false);
+		pci_restore_config_space_range(pdev, 0, 3, false);
 	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_restore_config_space_range(pdev, 12, 15, 0, false);
+		pci_restore_config_space_range(pdev, 12, 15, false);
 
 		/*
 		 * Force rewriting of prefetch registers to avoid S3 resume
 		 * issues on Intel PCI bridges that occur when these
 		 * registers are not explicitly written.
 		 */
-		pci_restore_config_space_range(pdev, 9, 11, 0, true);
-		pci_restore_config_space_range(pdev, 0, 8, 0, false);
+		pci_restore_config_space_range(pdev, 9, 11, true);
+		pci_restore_config_space_range(pdev, 0, 8, false);
 	} else {
-		pci_restore_config_space_range(pdev, 0, 15, 0, false);
+		pci_restore_config_space_range(pdev, 0, 15, false);
 	}
 }
 
-- 
2.51.0

