Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdALUe6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jan 2017 15:34:58 -0500
Subject: [PATCH] x86/PCI: Ignore _CRS on Supermicro X8DTH-i/6/iF/6F
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Martin Burnicki <martin.burnicki@meinberg.de>
Date: Thu, 12 Jan 2017 14:34:01 -0600
Message-ID: <20170112203401.17735.39968.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin reported that the Supermicro X8DTH-i/6/iF/6F advertises incorrect
host bridge windows via _CRS:

  pci_root PNP0A08:00: host bridge window [io  0xf000-0xffff]
  pci_root PNP0A08:01: host bridge window [io  0xf000-0xffff]

Both bridges advertise the 0xf000-0xffff window, which cannot be correct.

Work around this by ignoring _CRS on this system.  The downside is that we
may not assign resources correctly to hot-added PCI devices (if they are
possible on this system).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=42606
Reported-by: Martin Burnicki <martin.burnicki@meinberg.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org
---
 arch/x86/pci/acpi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 3cd69832d7f4..3961103e9176 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -114,6 +114,16 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VERSION, "6JET85WW (1.43 )"),
 		},
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=42606 */
+	{
+		.callback = set_nouse_crs,
+		.ident = "Supermicro X8DTH",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Supermicro"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X8DTH-i/6/iF/6F"),
+			DMI_MATCH(DMI_BIOS_VERSION, "2.0a"),
+		},
+	},
 
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15362 */
 	{

