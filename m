Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdFSUgG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 16:36:06 -0400
Subject: [PATCH] PCI: vmd: Correct comment: VMD domains start at 0x10000,
 not 0x1000
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 19 Jun 2017 15:36:01 -0500
Message-ID: <20170619203601.2396.80335.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VMD domains are allocated starting at 0x10000, not 0x1000 as the comment
said.  Correct the comment and add a reference to the ACPI spec for _SEG.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/vmd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index e27ad2a3bd33..53aa1d4b17e8 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -539,7 +539,10 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 }
 
 /*
- * VMD domains start at 0x1000 to not clash with ACPI _SEG domains.
+ * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
+ * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
+ * 16 bits are the PCI Segment Group (domain) number.  Other bits are
+ * currently reserved.
  */
 static int vmd_find_free_domain(void)
 {
