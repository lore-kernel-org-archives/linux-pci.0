Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36467 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbFPQzq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2015 12:55:46 -0400
Received: by igbiq7 with SMTP id iq7so47469751igb.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2015 09:55:45 -0700 (PDT)
Subject: [PATCH 1/2] x86/PCI: Use host bridge _CRS info on Foxconn
 K8M890-8237A
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	dayer3@gmail.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Date: Tue, 16 Jun 2015 11:55:43 -0500
Message-ID: <20150616165543.9306.88230.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Foxconn K8M890-8237A has two PCI host bridges, and we can't assign
resources correctly without the information from _CRS that tells us which
address ranges are claimed by which bridge.  In the bugs mentioned below,
we incorrectly assign a sound card address (this example is from 1033299):

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  pci_root PNP0A08:00: host bridge window [mem 0x80000000-0xbfefffff] (ignored)
  pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff] (ignored)
  pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfebfffff] (ignored)
  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
  pci_root PNP0A08:01: host bridge window [mem 0xbff00000-0xbfffffff] (ignored)
  pci 0000:80:01.0: [1106:3288] type 0 class 0x000403
  pci 0000:80:01.0: reg 10: [mem 0xbfffc000-0xbfffffff 64bit]
  pci 0000:80:01.0: address space collision: [mem 0xbfffc000-0xbfffffff 64bit] conflicts with PCI Bus #00 [mem 0x80000000-0xfcffffffff]
  pci 0000:80:01.0: BAR 0: assigned [mem 0xfd00000000-0xfd00003fff 64bit]
  BUG: unable to handle kernel paging request at ffffc90000378000
  IP: [<ffffffffa0345f63>] azx_create+0x37c/0x822 [snd_hda_intel]

Turn on pci=use_crs automatically for this system.

Link: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/931368
Link: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1033299
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index e469598..d8e2258 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -81,6 +81,17 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies, LTD"),
 		},
 	},
+	/* https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/931368 */
+	/* https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1033299 */
+	{
+		.callback = set_use_crs,
+		.ident = "Foxconn K8M890-8237A",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Foxconn"),
+			DMI_MATCH(DMI_BOARD_NAME, "K8M890-8237A"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies, LTD"),
+		},
+	},
 
 	/* Now for the blacklist.. */
 

