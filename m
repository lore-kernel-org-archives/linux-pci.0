Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:41312 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeD3FtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 01:49:09 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/10] PCI: Make pci_get_new_domain_nr() static
Date: Mon, 30 Apr 2018 07:48:35 +0200
Message-Id: <7e10d1bd6ca988c9deca593588e5b7fdd72a8de4.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The only user of pci_get_new_domain_nr() is of_pci_bus_find_domain_nr().
Since they are defined in the same compilation unit,
pci_get_new_domain_nr() can be made static, which also simplifies
preprocessor conditionals.

No functional change intended.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/pci.c   | 6 ++----
 include/linux/pci.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a04197ce767d..811d71e7ee05 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5702,15 +5702,14 @@ static void pci_no_domains(void)
 #endif
 }
 
-#ifdef CONFIG_PCI_DOMAINS
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
 static atomic_t __domain_nr = ATOMIC_INIT(-1);
 
-int pci_get_new_domain_nr(void)
+static int pci_get_new_domain_nr(void)
 {
 	return atomic_inc_return(&__domain_nr);
 }
 
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
 static int of_pci_bus_find_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
@@ -5765,7 +5764,6 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 			       acpi_pci_bus_find_domain_nr(bus);
 }
 #endif
-#endif
 
 /**
  * pci_ext_cfg_avail - can we access extended PCI config space?
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..963232a6cd2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1510,12 +1510,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
  */
 #ifdef CONFIG_PCI_DOMAINS
 extern int pci_domains_supported;
-int pci_get_new_domain_nr(void);
 #else
 enum { pci_domains_supported = 0 };
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /*
@@ -1670,7 +1668,6 @@ static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
-- 
2.13.6
