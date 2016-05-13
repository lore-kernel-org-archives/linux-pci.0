Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:52112 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcEMLYK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:24:10 -0400
Message-Id: <20ccb6cc38f872c3d56b44cc2b9776a4a39c7dc5.1463134232.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system
 sleep
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are devices wich are not power-managed by the platform, yet can be
runtime suspended to D3cold with some other mechanism.  When putting the
system to sleep, we currently handle such devices improperly by trying
to transition them from D3cold to D3hot (the default power state defined
at the beginning of pci_target_state()).  Avoid that.

An example for devices affected by this are Thunderbolt controllers
built into Macs which can be put into D3cold with nonstandard ACPI
methods.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 791dfe7..6af9911 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1943,6 +1943,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
 			      && !(dev->pme_support & (1 << target_state)))
 				target_state--;
 		}
+	} else if (dev->current_state == PCI_D3cold) {
+		target_state = PCI_D3cold;
 	}
 
 	return target_state;
-- 
2.8.1

