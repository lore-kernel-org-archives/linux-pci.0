Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59549 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3C0I4L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 04:56:11 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 02:56:11 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 59E6719D8041
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:56:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2R8u8Fd121744
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:56:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2R8u76P020707
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:56:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 1/4] PCI: Cache MSI/MSIX structure in pci_msi_check_device()
Date: Wed, 27 Mar 2013 16:56:01 +0800
Message-Id: <1364374564-19096-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch introduces additional parameter to pci_msi_check_device()
to trace the address of MSI or MSI-X capability structure so that
we needn't retrieve that again while enabling MSI or MSI-X based
interrupts for specific PCI device.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 00cc78c..05e9604 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -758,12 +758,14 @@ error:
  * @dev: pointer to the pci_dev data structure of MSI device function
  * @nvec: how many MSIs have been requested ?
  * @type: are we checking for MSI or MSI-X ?
+ * @pos: address of MSI or MSI-X capability structure
  *
  * Look at global flags, the device itself, and its parent busses
  * to determine if MSI/-X are supported for the device. If MSI/-X is
  * supported return 0, else return an error code.
  **/
-static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
+static int pci_msi_check_device(struct pci_dev *dev,
+				int nvec, int type, int *pos)
 {
 	struct pci_bus *bus;
 	int ret;
@@ -795,7 +797,8 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (ret)
 		return ret;
 
-	if (!pci_find_capability(dev, type))
+	*pos = pci_find_capability(dev, type);
+	if (!*pos)
 		return -EINVAL;
 
 	return 0;
@@ -816,7 +819,7 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
  */
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 {
-	int status, pos, maxvec;
+	int pos, status, maxvec;
 	u16 msgctl;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
@@ -827,7 +830,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 	if (nvec > maxvec)
 		return maxvec;
 
-	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
+	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI, &pos);
 	if (status)
 		return status;
 
@@ -945,13 +948,13 @@ int pci_msix_table_size(struct pci_dev *dev)
  **/
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 {
-	int status, nr_entries;
+	int pos, status, nr_entries;
 	int i, j;
 
 	if (!entries)
 		return -EINVAL;
 
-	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
+	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX, &pos);
 	if (status)
 		return status;
 
-- 
1.7.5.4

