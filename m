Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36339 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbGQVcn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:43 -0400
Received: by obnw1 with SMTP id w1so73164125obn.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:42 -0700 (PDT)
Subject: [PATCH 7/8] PCI: Clean up ATS error handling
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:40 -0500
Message-ID: <20150717213240.18379.42110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no need to BUG() if we enable ATS when it's already enabled.  We
don't need to BUG() when disabling ATS on a device that doesn't support ATS
or if it's already disabled.  If ATS is enabled, certainly we found an ATS
capability in the past, so it should still be there now.

Clean up these error paths.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c35de8e..9069126 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,8 +43,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	BUG_ON(dev->ats_cap && dev->ats_enabled);
-
 	if (!dev->ats_cap)
 		return -EINVAL;
 
@@ -74,7 +72,8 @@ void pci_disable_ats(struct pci_dev *dev)
 {
 	u16 ctrl;
 
-	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
+	if (!dev->ats_cap)
+		return;
 
 	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
@@ -90,8 +89,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	if (!pci_ats_enabled(dev))
 		return;
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS))
-		BUG();
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)

