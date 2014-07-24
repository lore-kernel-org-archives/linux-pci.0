Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:57134 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727AbaGXGXm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:23:42 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 16:23:34 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 279B72BB0052
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O65dXn17039366
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:05:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6MZoq000749
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:36 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 02/17] PCI/IOV: Get VF BAR size from hardware directly when platform needs
Date: Thu, 24 Jul 2014 14:22:12 +0800
Message-Id: <1406182947-11302-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current implementation calculates VF BAR size from dividing the total size of
IOV BAR by total VF number. It won't work on PowerNV platform because we're
going to expand IOV BAR size for finely alignment.

The patch enforces getting IOV BAR size from hardware and then calculate
the VF BAR size based on that when platform wants so.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c      |   28 ++++++++++++++++++++++++----
 include/linux/ioport.h |    1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 7566238..ef1c546 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -55,6 +55,9 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
+	struct resource tmp;
+	enum pci_bar_type type;
+	int reg;
 
 	mutex_lock(&iov->dev->sriov->lock);
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
@@ -80,12 +83,29 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = resource_size(res);
-		do_div(size, iov->total_VFs);
+		/* When res has IORESOURCE_ARCH, retrieve the IOV BAR size
+		 * from hardware directly.
+		 */
+		if (res->flags & IORESOURCE_ARCH) {
+			reg = pci_iov_resource_bar(dev, i + PCI_IOV_RESOURCES, &type);
+			__pci_read_base(dev, type, &tmp, reg);
+			size = resource_size(&tmp);
+			/* When __pci_read_base fails, flags is set to 0.
+			 * In this case, reset size to 0, which means the VF
+			 * will not be enabled.
+			 */
+			if (!tmp.flags)
+				size = 0;
+		} else {
+			size = resource_size(res);
+			do_div(size, iov->total_VFs);
+		}
 		virtfn->resource[i].start = res->start + size * id;
 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
-		rc = request_resource(res, &virtfn->resource[i]);
-		BUG_ON(rc);
+		if (resource_size(&virtfn->resource[i])) {
+			rc = request_resource(res, &virtfn->resource[i]);
+			BUG_ON(rc);
+		}
 	}
 
 	if (reset)
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5e3a906..de8b57c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -48,6 +48,7 @@ struct resource {
 #define IORESOURCE_MEM_64	0x00100000
 #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
 #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
+#define IORESOURCE_ARCH		0x00800000	/* Resource arch tagged */
 
 #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
 #define IORESOURCE_DISABLED	0x10000000
-- 
1.7.9.5

