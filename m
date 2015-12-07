Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4465 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933373AbbLGVch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 16:32:37 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 2/7] pci: child bus alloc fix on constrained resource
Date: Mon,  7 Dec 2015 14:32:24 -0700
Message-Id: <1449523949-21898-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Does not allocate a child bus if the new bus number does not fit in the
parent's bus resource window.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..6e29f7a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -704,6 +704,12 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	int i;
 	int ret;
 
+	if (busnr > parent->busn_res.end) {
+		dev_printk(KERN_DEBUG, &parent->dev,
+			  "can not alloc bus:%d under %pR\n", busnr,
+			  &parent->busn_res);
+		return NULL;
+	}
 	/*
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
-- 
2.6.2.307.g37023ba

