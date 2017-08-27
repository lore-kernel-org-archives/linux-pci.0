Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdH0RlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2017 13:41:05 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V13 4/4] PCI: Warn periodically while waiting for device to become ready
Date: Sun, 27 Aug 2017 13:40:51 -0400
Message-Id: <1503855651-17409-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
References: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a print statement in pci_bus_wait_crs() so that user observes the
progress of device polling instead of silently waiting for timeout to be
reached.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: check for timeout first so we don't print "waiting, giving up",
always print time we've slept (not the actual timeout, print a "ready"
message if we've printed a "waiting" message]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d834a20..8f7ba16 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1847,11 +1847,16 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l,
 	 */
 	while ((l & 0xffff) == 0x0001) {
 		if (delay > timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
-			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn));
+			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+
 			return false;
 		}
+		if (delay >= 1000)
+			pr_info("pci %04x:%02x:%02x.%d: not ready after %dms; waiting\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 
 		msleep(delay);
 		delay *= 2;
@@ -1860,6 +1865,11 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 l,
 			return false;
 	}
 
+	if (delay >= 1000)
+		pr_info("pci %04x:%02x:%02x.%d: ready after %dms\n",
+			pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+
 	return true;
 }
 
-- 
1.9.1
