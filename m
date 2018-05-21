Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:44016 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeEULLw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 07:11:52 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI / PM: Clean up outdated comments in pci_target_state()
Date: Mon, 21 May 2018 13:11:12 +0200
Message-ID: <2360046.ecez94sF1Y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two comments in pci_target_state() are outdated, as the function
doesn't set the target power state for the device any more, only
finds one for it, so fix them accordingly.

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2025,8 +2025,7 @@ static pci_power_t pci_target_state(stru
 
 	if (platform_pci_power_manageable(dev)) {
 		/*
-		 * Call the platform to choose the target state of the device
-		 * and enable wake-up from this state if supported.
+		 * Call the platform to find the target state for the device.
 		 */
 		pci_power_t state = platform_pci_choose_state(dev);
 
@@ -2059,8 +2058,7 @@ static pci_power_t pci_target_state(stru
 	if (wakeup) {
 		/*
 		 * Find the deepest state from which the device can generate
-		 * wake-up events, make it the target state and enable device
-		 * to generate PME#.
+		 * PME#.
 		 */
 		if (dev->pme_support) {
 			while (target_state
