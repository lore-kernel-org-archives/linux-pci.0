Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:47035 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbbCTDJa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 23:09:30 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 20 Mar 2015 13:09:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5DE942CE804E
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:09:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2K39HCY47317198
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:09:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2K38pJl003053
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:08:51 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V14 03/21] PCI: Print more info in sriov_enable() error message
Date: Fri, 20 Mar 2015 11:06:19 +0800
Message-Id: <1426820797-6267-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

