Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46603 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbBXIdE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:33:04 -0500
Received: by pabkx10 with SMTP id kx10so34321311pab.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:33:04 -0800 (PST)
Subject: [PATCH v12 01/21] PCI: Print more info in sriov_enable() error
 message
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:33:02 -0600
Message-ID: <20150224083302.32124.13369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we don't have space for all the bus numbers required to enable VFs,
print the largest bus number required and the range available.

No functional change; improved error message only.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4b3a4eaad996..c4c33ead03bc 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -180,6 +180,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
+	u8 bus;
 
 	if (!nr_virtfn)
 		return 0;
@@ -216,8 +217,10 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->offset = offset;
 	iov->stride = stride;
 
-	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
-		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
+	bus = virtfn_bus(dev, nr_virtfn - 1);
+	if (bus > dev->bus->busn_res.end) {
+		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
+			nr_virtfn, bus, &dev->bus->busn_res);
 		return -ENOMEM;
 	}
 

