Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:48794 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966074Ab2B1SvN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 13:51:13 -0500
Received: by laai8 with SMTP id i8so92180laa.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2012 10:51:11 -0800 (PST)
Subject: [PATCH] x86/PCI: use host bridge _CRS info on MSI MS-7253
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>
Date: Tue, 28 Feb 2012 11:51:10 -0700
Message-ID: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jonathan Nieder <jrnieder@gmail.com>

In the spirit of commit 29cf7a30f8a0 ("x86/PCI: use host bridge _CRS
info on ASUS M2V-MX SE"), this DMI quirk turns on "pci_use_crs" by
default on a board that needs it.

This fixes boot failures and oopses introduced in 3e3da00c01d0
("x86/pci: AMD one chain system to use pci read out res").  The quirk
is quite targetted (to a specific board and BIOS version) for two
reasons:

 (1) to emphasize that this method of tackling the problem one quirk
     at a time is a little insane

 (2) to give BIOS vendors an opportunity to use simpler tables and
     allow us to return to generic behavior (whatever that happens to
     be) with a later BIOS update

In other words, I am not at all happy with having quirks like this.
But it is even worse for the kernel not to work out of the box on
these machines, so...

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=42619
Reported-by: Svante Signell <svante.signell@telia.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a312e76..2c5cbdb 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -60,6 +60,17 @@ static const struct dmi_system_id pci_use_crs_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 		},
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=42619 */
+	{
+		.callback = set_use_crs,
+		.ident = "MSI MS-7253",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-7253"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies, LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION, "V1.6"),
+		},
+	},
 
 	/* Now for the blacklist.. */
 

