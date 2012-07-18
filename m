Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:56055 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab2GRG13 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jul 2012 02:27:29 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <liusheng@linux.vnet.ibm.com>;
	Wed, 18 Jul 2012 11:57:27 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6I6ROgx13697320
	for <linux-pci@vger.kernel.org>; Wed, 18 Jul 2012 11:57:24 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6IBuhf6025256
	for <linux-pci@vger.kernel.org>; Wed, 18 Jul 2012 21:56:43 +1000
From: Liu Sheng <liusheng@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Liu Sheng <liusheng@linux.vnet.ibm.com>
Subject: [PATCH] fix one comment on device_group function in struct iommu_ops
Date: Wed, 18 Jul 2012 14:27:18 +0800
Message-Id: <1342592838-17195-1-git-send-email-liusheng@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

this patch fix one comment on device_group function in struct iommu_ops

Signed-off-by: Liu Sheng <liusheng@linux.vnet.ibm.com>
---
 include/linux/iommu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 450293f..d25e529 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -59,7 +59,7 @@ struct iommu_domain {
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @domain_has_cap: domain capabilities query
- * @commit: commit iommu domain
+ * @device_group: get the groupid of the device
  * @pgsize_bitmap: bitmap of supported page sizes
  */
 struct iommu_ops {
-- 
1.7.1

