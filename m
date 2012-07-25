Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57018 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab2GYTp0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jul 2012 15:45:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI / PM: Fix messages printed by acpi_pci_set_power_state()
Date: Wed, 25 Jul 2012 21:51:13 +0200
Cc: huang ying <huang.ying.caritas@gmail.com>,
	=?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
	Huang Ying <ying.huang@intel.com>,
	Zheng Yan <zheng.z.yan@intel.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org> <87k3xskvqq.fsf@nemi.mork.no> <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
In-Reply-To: <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201207252151.14069.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


If a PCI device is put into D3_cold by acpi_bus_set_power(),
the message printed by acpi_pci_set_power_state() says that its
power state has been changed to D4, which doesn't make sense.
In turn, if the device is put into D3_hot, the message says just
"D3" without specifying which variant of D3 it is.

Fix that by using an array of state names corresponding to the
PCI device power states instead of building the state name from
the numeric value corresponding to the given state directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux/drivers/pci/pci-acpi.c
===================================================================
--- linux.orig/drivers/pci/pci-acpi.c
+++ linux/drivers/pci/pci-acpi.c
@@ -265,9 +265,17 @@ static int acpi_pci_set_power_state(stru
 		error = acpi_bus_set_power(handle, state_conv[state]);
 	}
 
-	if (!error)
-		dev_printk(KERN_INFO, &dev->dev,
-				"power state changed by ACPI to D%d\n", state);
+	if (!error) {
+		static const char *state_name[] = {
+			[PCI_D0] = "D0",
+			[PCI_D1] = "D1",
+			[PCI_D2] = "D2",
+			[PCI_D3hot] = "D3hot",
+			[PCI_D3cold] = "D3cold"
+		};
+		dev_info(&dev->dev, "power state changed by ACPI to %s\n",
+			 state_name[state]);
+	}
 
 	return error;
 }
