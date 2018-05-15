Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH v3 1/8] PCI: Make pci_get_new_domain_nr() static
Date: Tue, 15 May 2018 07:58:09 +0200
Message-Id: <80a86454baa7a240c859d6623a6e498d4003e417.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index dbfe7c4f3776..fe28cd76eacd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5719,15 +5719,14 @@ static void pci_no_domains(void)
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
@@ -5782,7 +5781,6 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
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
