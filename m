Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57326 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaANRP3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 12:15:29 -0500
Received: by mail-ie0-f175.google.com with SMTP id tp5so737427ieb.34
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 09:15:29 -0800 (PST)
Received: from localhost ([172.29.122.186])
        by mx.google.com with ESMTPSA id c10sm24815545igx.4.2014.01.14.09.15.28
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jan 2014 09:15:28 -0800 (PST)
Subject: [PATCH 2/2] PCI: Cleanup pci.h whitespace
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Jan 2014 10:15:27 -0700
Message-ID: <20140114171527.9148.35364.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140114171308.9148.47907.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140114171308.9148.47907.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Put empty or trivial inline stub functions on one line when they fit.  No
functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |  238 ++++++++++++---------------------------------------
 1 file changed, 54 insertions(+), 184 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 39a3609c8cda..9e3ec8b951b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1165,56 +1165,26 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 			  int minvec, int maxvec);
 #else
-static inline int pci_msi_vec_count(struct pci_dev *dev)
-{
-	return -ENOSYS;
-}
-
+static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline int pci_enable_msi_block(struct pci_dev *dev, int nvec)
-{
-	return -ENOSYS;
-}
-
-static inline void pci_msi_shutdown(struct pci_dev *dev)
-{ }
-static inline void pci_disable_msi(struct pci_dev *dev)
-{ }
-
-static inline int pci_msix_vec_count(struct pci_dev *dev)
-{
-	return -ENOSYS;
-}
+{ return -ENOSYS; }
+static inline void pci_msi_shutdown(struct pci_dev *dev) { }
+static inline void pci_disable_msi(struct pci_dev *dev) { }
+static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline int pci_enable_msix(struct pci_dev *dev,
 				  struct msix_entry *entries, int nvec)
-{
-	return -ENOSYS;
-}
-
-static inline void pci_msix_shutdown(struct pci_dev *dev)
-{ }
-static inline void pci_disable_msix(struct pci_dev *dev)
-{ }
-
-static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev)
-{ }
-
-static inline void pci_restore_msi_state(struct pci_dev *dev)
-{ }
-static inline int pci_msi_enabled(void)
-{
-	return 0;
-}
-
+{ return -ENOSYS; }
+static inline void pci_msix_shutdown(struct pci_dev *dev) { }
+static inline void pci_disable_msix(struct pci_dev *dev) { }
+static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) { }
+static inline void pci_restore_msi_state(struct pci_dev *dev) { }
+static inline int pci_msi_enabled(void) { return 0; }
 static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
 				       int maxvec)
-{
-	return -ENOSYS;
-}
+{ return -ENOSYS; }
 static inline int pci_enable_msix_range(struct pci_dev *dev,
 		      struct msix_entry *entries, int minvec, int maxvec)
-{
-	return -ENOSYS;
-}
+{ return -ENOSYS; }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -1243,11 +1213,8 @@ static inline bool pci_aer_available(void) { return false; }
 void pcie_set_ecrc_checking(struct pci_dev *dev);
 void pcie_ecrc_get_policy(char *str);
 #else
-static inline void pcie_set_ecrc_checking(struct pci_dev *dev)
-{
-	return;
-}
-static inline void pcie_ecrc_get_policy(char *str) {};
+static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
+static inline void pcie_ecrc_get_policy(char *str) { }
 #endif
 
 #define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
@@ -1271,15 +1238,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 extern int pci_domains_supported;
 #else
 enum { pci_domains_supported = 0 };
-static inline int pci_domain_nr(struct pci_bus *bus)
-{
-	return 0;
-}
-
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 0;
-}
+static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /* some architectures require additional setup to direct VGA traffic */
@@ -1308,163 +1268,88 @@ _PCI_NOP_ALL(write,)
 static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     unsigned int device,
 					     struct pci_dev *from)
-{
-	return NULL;
-}
+{ return NULL; }
 
 static inline struct pci_dev *pci_get_subsys(unsigned int vendor,
 					     unsigned int device,
 					     unsigned int ss_vendor,
 					     unsigned int ss_device,
 					     struct pci_dev *from)
-{
-	return NULL;
-}
+{ return NULL; }
 
 static inline struct pci_dev *pci_get_class(unsigned int class,
 					    struct pci_dev *from)
-{
-	return NULL;
-}
+{ return NULL; }
 
 #define pci_dev_present(ids)	(0)
 #define no_pci_devices()	(1)
 #define pci_dev_put(dev)	do { } while (0)
 
-static inline void pci_set_master(struct pci_dev *dev)
-{ }
-
-static inline int pci_enable_device(struct pci_dev *dev)
-{
-	return -EIO;
-}
-
-static inline void pci_disable_device(struct pci_dev *dev)
-{ }
-
+static inline void pci_set_master(struct pci_dev *dev) { }
+static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
+static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	return -EIO;
-}
-
+{ return -EIO; }
 static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	return -EIO;
-}
-
+{ return -EIO; }
 static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
 					unsigned int size)
-{
-	return -EIO;
-}
-
+{ return -EIO; }
 static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
 					unsigned long mask)
-{
-	return -EIO;
-}
-
+{ return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
-{
-	return -EBUSY;
-}
-
+{ return -EBUSY; }
 static inline int __pci_register_driver(struct pci_driver *drv,
 					struct module *owner)
-{
-	return 0;
-}
-
+{ return 0; }
 static inline int pci_register_driver(struct pci_driver *drv)
-{
-	return 0;
-}
-
-static inline void pci_unregister_driver(struct pci_driver *drv)
-{ }
-
+{ return 0; }
+static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability(struct pci_dev *dev, int cap)
-{
-	return 0;
-}
-
+{ return 0; }
 static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
 					   int cap)
-{
-	return 0;
-}
-
+{ return 0; }
 static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
-{
-	return 0;
-}
+{ return 0; }
 
 /* Power management related routines */
-static inline int pci_save_state(struct pci_dev *dev)
-{
-	return 0;
-}
-
-static inline void pci_restore_state(struct pci_dev *dev)
-{ }
-
+static inline int pci_save_state(struct pci_dev *dev) { return 0; }
+static inline void pci_restore_state(struct pci_dev *dev) { }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-{
-	return 0;
-}
-
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
-{
-	return 0;
-}
-
+{ return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
 					   pm_message_t state)
-{
-	return PCI_D0;
-}
-
+{ return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 				  int enable)
-{
-	return 0;
-}
+{ return 0; }
 
 static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
-{
-	return -EIO;
-}
-
-static inline void pci_release_regions(struct pci_dev *dev)
-{ }
+{ return -EIO; }
+static inline void pci_release_regions(struct pci_dev *dev) { }
 
 #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
 
-static inline void pci_block_cfg_access(struct pci_dev *dev)
-{ }
-
+static inline void pci_block_cfg_access(struct pci_dev *dev) { }
 static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
 { return 0; }
-
-static inline void pci_unblock_cfg_access(struct pci_dev *dev)
-{ }
+static inline void pci_unblock_cfg_access(struct pci_dev *dev) { }
 
 static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 { return NULL; }
-
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-
 static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 						unsigned int devfn)
 { return NULL; }
 
-static inline int pci_domain_nr(struct pci_bus *bus)
-{ return 0; }
-
-static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
-{ return NULL; }
+static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
@@ -1620,7 +1505,7 @@ struct pci_dev *pci_get_dma_source(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
-				    struct pci_dev *dev) {}
+				    struct pci_dev *dev) { }
 static inline struct pci_dev *pci_get_dma_source(struct pci_dev *dev)
 {
 	return pci_dev_get(dev);
@@ -1692,32 +1577,17 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 #else
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
-{
-	return -ENODEV;
-}
-static inline void pci_disable_sriov(struct pci_dev *dev)
-{
-}
+{ return -ENODEV; }
+static inline void pci_disable_sriov(struct pci_dev *dev) { }
 static inline irqreturn_t pci_sriov_migration(struct pci_dev *dev)
-{
-	return IRQ_NONE;
-}
-static inline int pci_num_vf(struct pci_dev *dev)
-{
-	return 0;
-}
+{ return IRQ_NONE; }
+static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
-{
-	return 0;
-}
+{ return 0; }
 static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
-{
-	return 0;
-}
+{ return 0; }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
-{
-	return 0;
-}
+{ return 0; }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)

