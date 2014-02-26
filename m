Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62151 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbaBZThr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 14:37:47 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so1131934iec.9
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2014 11:37:46 -0800 (PST)
Subject: [PATCH 6/9] PCI: Check IORESOURCE_UNSET before updating BAR
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2014 12:37:44 -0700
Message-ID: <20140226193744.10125.99627.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140226192614.10125.68711.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226192614.10125.68711.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check to make sure we don't update a BAR with an address we haven't
assigned.

If we haven't assigned an address to a resource, we shouldn't write it to a
BAR.  This isn't a problem for the usual path via pci_assign_resource(),
which clears IORESOURCE_UNSET before calling pci_update_resource(), but
paths like pci_restore_bars() can call this for resources we haven't
assigned.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-res.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 725d5b28398c..7f7652176fc5 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -44,6 +44,9 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	if (!res->flags)
 		return;
 
+	if (res->flags & IORESOURCE_UNSET)
+		return;
+
 	/*
 	 * Ignore non-moveable resources.  This might be legacy resources for
 	 * which no functional BAR register exists or another important

