Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:35004 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbCDFUv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 00:20:51 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 4 Mar 2015 15:20:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id F0D2C2BB0040
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2015 16:20:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t245KcvA19267648
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:20:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t245KCpv024961
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:20:13 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V13 01/21] PCI: Print more info in sriov_enable() error message
Date: Wed,  4 Mar 2015 13:18:53 +0800
Message-Id: <1425446353-30513-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

If we don't have space for all the bus numbers required to enable VFs,
print the largest bus number required and the range available.

No functional change; improved error message only.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4b3a4ea..c4c33ea 100644
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
 
-- 
1.7.9.5

