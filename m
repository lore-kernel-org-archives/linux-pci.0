Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:48035 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598Ab2FUARF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:17:05 -0400
Received: by yenl3 with SMTP id l3so9519yen.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:17:04 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id C94AB100047
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:17:04 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 86318180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:17:04 -0700 (PDT)
Subject: [PATCH 6/6] PCI: remove useless pcix_set_mmrbc() dev->bus check
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:17:04 -0600
Message-ID: <20120621001704.4834.58131.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For a valid pci_dev, dev->bus != NULL always, so remove this
unnecessary test.

Found by Coverity (CID 101680).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9e93cf..7f1310e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3395,8 +3395,7 @@ int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
 
 	o = (cmd & PCI_X_CMD_MAX_READ) >> 2;
 	if (o != v) {
-		if (v > o && dev->bus &&
-		   (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MMRBC))
+		if (v > o && (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MMRBC))
 			return -EIO;
 
 		cmd &= ~PCI_X_CMD_MAX_READ;

