Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32794 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2B1Vbn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 16:31:43 -0500
Received: by iagj37 with SMTP id j37so1704159iag.19
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2012 13:31:43 -0800 (PST)
Date: Tue, 28 Feb 2012 15:31:35 -0600
From: Jonathan Nieder <jrnieder@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>
Subject: [PATCH] x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS version
Message-ID: <20120228213135.GA30986@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Carlos was getting

	WARNING: at drivers/pci/pci.c:118 pci_ioremap_bar+0x24/0x52()

when probing his sound card, and sound did not work.  After adding
pci=use_crs to the kernel command line, no more trouble.

Ok, we can add a quirk.  dmidecode output reveals that this is an MSI
MS-7253, for which we already have a quirk, but the short-sighted
author tied the quirk to a single BIOS version, making it not kick in
on Carlos's machine with BIOS V1.2.  If a later BIOS update makes it
no longer necessary to look at the _CRS info it will still be
harmless, so let's stop trying to guess which versions have and don't
have accurate _CRS tables.

Addresses https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5533
Also see <https://bugzilla.kernel.org/show_bug.cgi?id=42619>.

Reported-by: Carlos Luna <caralu74@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Could you squash this into the patch "x86/PCI: use host bridge _CRS
info on MSI MS-7253", if it's not too late?  Sorry for the thinko.

Thanks,
Jonathan

 arch/x86/pci/acpi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2c5cbdb5d602..d066e11159f3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -68,7 +68,6 @@ static const struct dmi_system_id pci_use_crs_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
 			DMI_MATCH(DMI_BOARD_NAME, "MS-7253"),
 			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies, LTD"),
-			DMI_MATCH(DMI_BIOS_VERSION, "V1.6"),
 		},
 	},
 
-- 
1.7.9.2

