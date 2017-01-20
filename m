Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47719 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751299AbdATLLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2017 06:11:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0K7e7IW068456
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2017 02:42:05 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 283bmewscv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2017 02:42:05 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Fri, 20 Jan 2017 00:42:05 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v8 2/3] PCI: Make sure the driver could get correct BAR size from pci_resource_len()
Date: Fri, 20 Jan 2017 15:41:52 +0800
In-Reply-To: <1484898113-24939-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1484898113-24939-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1484898113-24939-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When using resource_alignment kernel parameter, the current implement
reassigns the alignment by expanding resources' size. So there exists two
kinds of *size* for one PCI BAR. One is the hardware size, the other is
the allocated size. Currently pci_resource_len() used by drivers return
the allocated size rather than the hardware size. This may potentially
break some drivers when they use the size to locate some registers whose
length is related to the hardware size. Some examples as below:

- misc\Hpilo.c:
off = pci_resource_len(pdev, bar) - 0x2000;

- net\ethernet\chelsio\cxgb4\cxgb4_uld.h:
(pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))

- infiniband\hw\nes\Nes_hw.c:
num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;

This modifies pci_resource_len() to be aware of the increased size.
So it could return the hardware size instead. And if we need the allocated
size, resource_size()(or we can introuce a new helper function) can be used
to get it.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c   |    1 +
 include/linux/pci.h |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 220c31e..04f2100 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5096,6 +5096,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 		size = resource_size(r);
 		if (size < align) {
+			dev->res_addsize[i] = align - size;
 			size = align;
 			dev_info(&dev->dev,
 				"Rounding up size of resource #%d to %#llx.\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..e4099fb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	resource_size_t res_addsize[PCI_ROM_RESOURCE + 1];
 
 	bool match_driver;		/* Skip attaching driver */
 	/* These fields are used by common fixups */
@@ -1644,7 +1645,10 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-#define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
+#define pci_resource_end(dev, bar)	(((bar) > PCI_ROM_RESOURCE) ?	\
+					(dev)->resource[(bar)].end :	\
+					((dev)->resource[(bar)].end -	\
+					(dev)->res_addsize[(bar)]))
 #define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
 #define pci_resource_len(dev,bar) \
 	((pci_resource_start((dev), (bar)) == 0 &&	\
-- 
1.7.9.5

