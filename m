Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47294 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbaDYRQf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 13:16:35 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so3407661pab.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 10:16:35 -0700 (PDT)
Subject: [PATCH 1/4] x86/PCI: Don't try to move IORESOURCE_PCI_FIXED
 resources
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, Bodo Eggert <7eggert@gmx.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Apr 2014 11:16:31 -0600
Message-ID: <20140425171631.312.6079.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140425171144.312.9601.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140425171144.312.9601.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Don't attempt to move resource marked IORESOURCE_PCI_FIXED, even if
pci_claim_resource() fails.  In some cases, these are legacy resources that
cannot be moved.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/i386.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index db6b1ab43255..6db58d68feb5 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -271,11 +271,16 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 					"BAR %d: reserving %pr (d=%d, p=%d)\n",
 					idx, r, disabled, pass);
 				if (pci_claim_resource(dev, idx) < 0) {
-					/* We'll assign a new address later */
-					pcibios_save_fw_addr(dev,
-							idx, r->start);
-					r->end -= r->start;
-					r->start = 0;
+					if (r->flags & IORESOURCE_PCI_FIXED) {
+						dev_info(&dev->dev, "BAR %d %pR is immovable\n",
+							 idx, r);
+					} else {
+						/* We'll assign a new address later */
+						pcibios_save_fw_addr(dev,
+								idx, r->start);
+						r->end -= r->start;
+						r->start = 0;
+					}
 				}
 			}
 		}

