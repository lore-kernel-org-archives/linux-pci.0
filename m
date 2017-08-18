Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751867AbdHRVc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Aug 2017 17:32:26 -0400
Subject: [PATCH v11 4/4] PCI: Warn periodically while waiting for device to
 become ready
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 18 Aug 2017 16:32:24 -0500
Message-ID: <20170818213224.15145.34617.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>

Add a print statement in pci_bus_wait_crs() so that user observes the
progress of device polling instead of silently waiting for timeout to be
reached.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: check for timeout first so we don't print "waiting, giving up",
always print time we've slept (not the actual timeout, print a "ready"
message if we've printed a "waiting" message]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 342a86640c6b..99799cc1de22 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1844,16 +1844,25 @@ bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 		delay *= 2;
 
 		if (delay > timeout) {
-			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
-			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			       PCI_FUNC(devfn));
+			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 			return false;
 		}
 
+		if (delay >= 1000)
+			pr_info("pci %04x:%02x:%02x.%d: not ready after %dms; waiting\n",
+				pci_domain_nr(bus), bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
+
 		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
 			return false;
 	}
 
+	if (delay >= 1000)
+		pr_info("pci %04x:%02x:%02x.%d: ready after %dms\n",
+			pci_domain_nr(bus), bus->number,
+			PCI_SLOT(devfn), PCI_FUNC(devfn), delay - 1);
 	return true;
 }
 
