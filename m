Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16343 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754653AbcE3Nhz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 09:37:55 -0400
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4UDY3W2026702
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:37:54 -0400
Message-Id: <201605301337.u4UDY3W2026702@mx0a-001b2d01.pphosted.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 238jhvp7mm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 09:37:54 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 30 May 2016 23:37:50 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ remapping
Date: Mon, 30 May 2016 21:32:09 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On ARM HW the capability of IRQ remapping is abstracted on
MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
this [1].

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when MSI_FLAG_IRQ_REMAPPING is set.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/msi.c   |   15 +++++++++++++++
 drivers/pci/probe.c |    3 +++
 include/linux/msi.h |    5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..dbdb5c3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1134,6 +1134,21 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 }
 EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
 
+int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain)
+{
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	struct msi_domain_info *info;
+
+	if (!domain)
+		return 0;
+
+	info = msi_get_domain_info(domain);
+	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
+		return 1;
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 /**
  * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67..2b9e3ba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -713,6 +713,9 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	if (!d)
 		d = pci_host_bridge_msi_domain(b);
 
+	if (b == bus && pci_bus_msi_isolated(bus, d))
+		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+
 	dev_set_msi_domain(&bus->dev, d);
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 08441b1..04cc749 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -15,6 +15,8 @@ extern int pci_msi_ignore_mask;
 struct irq_data;
 struct msi_desc;
 struct pci_dev;
+struct pci_bus;
+struct irq_domain;
 struct platform_msi_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -164,6 +166,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
+int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain);
+
 struct msi_controller {
 	struct module *owner;
 	struct device *dev;
@@ -182,7 +186,6 @@ struct msi_controller {
 #include <linux/irqhandler.h>
 #include <asm/msi.h>
 
-struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
 struct device_node;
-- 
1.7.9.5

