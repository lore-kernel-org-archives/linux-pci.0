Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB23D6473
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698434; cv=none; b=OPhbaLkoMARHRshb52Nw9h9d6Pfm781Z/HQLqcqfBY22EYvWi/c9f3WnbG+ggC4t7EQ3XESXCALDEpB1e53X0nJYRuM/EOC+j4bXZYsdfEXrEPBPI81lVLT1FMSBn2koDmI33OHfj5TUrlE3FX3NJ3Yv07R6oweYca9w6SGORSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698434; c=relaxed/simple;
	bh=y9QiwxZ3edL9Gg0WmH6rv/eq22aI/Vdoum8JUBd+Ig0=;
	h=Message-Id:From:Date:Subject:To:Cc; b=uFDwDimfYqDGrAS6i9dVy3eJY7pyOCXJbSF8d095S9el+sZktbzu6M5Dhg1WAIhdsBlAy12rwe2DlFkh5VvIZQLDjJfJk5j5jwGJFvXKDmkAxr5iLNluvFvY4Y3R83lVvNQVFUZ5o7PyF5GrWDPU0iiHn/AQOXPXCJPYvvdKjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 779D01FA3;
	Fri, 14 Aug 2026 11:07:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6856A60A8DB8; Fri, 14 Aug 2026 11:07:02 +0200 (CEST)
Message-Id: <36578f6e0829bbcdf68659ffad27b65715a97768.1786698126.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 14 Aug 2026 11:06:50 +0200
Subject: [PATCH] PCI: Add quirk for ID mutation of MSI Claw A8 cardreader
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, Matthew Schwartz <matthew.schwartz@linux.dev>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Derek reports a lockup on resume of the MSI Claw A8 if a card is inserted
into the onboard Realtek RTS525A cardreader.  He has root-caused it to a
mutation of the cardreader's Subsystem Vendor and Device ID:  Firmware
sets an MSI-specific ID on boot, but neglects to reset it on resume.
The ID thus changes to the generic Realtek Vendor and Device ID.

The firmware also incorrectly sets the Hot-Plug Capable bit on the Root
Port and the PCIe hotplug driver interprets the ID mutation as removal of
the cardreader during system sleep (see pciehp_device_replaced()).

The lockup is caused by the block layer being unaware of the hot-removal
and waiting indefinitely in sync_filesystem().  That is fixed with a
separate commit for the cardreader driver.  However despite that other
commit, the cardreader is still hot-removed and re-enumerated the first
time the system is put to sleep.  This is undesirable because it prevents
using an MMC card as root filesystem.

Avoid hot-removal of the cardreader by mutating the cached copy of the
Subsystem Vendor and Device ID.  This needs to be done before going to
sleep, not afterwards, because pci_pm_resume_noirq() is executed top-down
across the hierarchy and hence a pci_fixup_resume_early quirk of the
cardreader would run after hot-removal at its parent Root Port.

In the unlikely event that a fixed firmware becomes available, the quirk
can either be reverted or constrained to specific BIOS versions by way of
a dmi_get_date() conditional.

Reported-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Closes: https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clark@gmail.com/
Link: https://github.com/ValveSoftware/SteamOS/issues/2473
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 arch/x86/pci/fixup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c..9da7ae0 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1080,4 +1080,20 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
+
+/*
+ * MSI Claw A8 firmware initializes the onboard Realtek RTS525A cardreader
+ * with an MSI-specific Subsystem Vendor and Device ID on boot, but neglects
+ * to re-initialize it on resume.  Avoid hot-removal of the cardreader due to
+ * the spurious ID change.
+ */
+static void quirk_msi_claw_cardreader(struct pci_dev *pdev)
+{
+	if (pdev->subsystem_vendor == 0x1462 &&
+	    pdev->subsystem_device == 0x14af) {
+		pdev->subsystem_vendor = pdev->vendor;
+		pdev->subsystem_device = pdev->device;
+	}
+}
+DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_msi_claw_cardreader);
 #endif /* CONFIG_SUSPEND */
-- 
2.53.0

