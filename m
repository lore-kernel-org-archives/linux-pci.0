Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:25042 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbbEHHaG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2015 03:30:06 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <liviu@dudau.co.uk>, <x86@kernel.org>,
	<linux-ia64@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH Part3 v11 2/9] PCI: Move pci_bus_assign_domain_nr() declaration into drivers/pci/pci.h
Date: Fri, 8 May 2015 15:22:52 +0800
Message-ID: <1431069779-29346-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1431069779-29346-1-git-send-email-wangyijing@huawei.com>
References: <1431069779-29346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_bus_assign_domain_nr() is only called in probe.c,
Move pci_bus_assign_domain_nr() declaration into
drivers/pci/pci.h.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.h   |    9 +++++++++
 include/linux/pci.h |    6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9bd762c..bc3e79a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -325,4 +325,13 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
+#else
+static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
+					struct device *parent)
+{
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 720fdbb..5ff35cb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1332,12 +1332,6 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
-#else
-static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
-					struct device *parent)
-{
-}
 #endif
 
 /* some architectures require additional setup to direct VGA traffic */
-- 
1.7.1

