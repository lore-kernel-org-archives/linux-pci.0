Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC083815C7;
	Wed, 22 Apr 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874515; cv=none; b=jBVxdjPKexXEpX2L1ioSVANf+u7UQtUCvIGCqCDbgCvI/KjokeyCQ4ok2vngIkRxiR8kcH4nzUIgh4J+R2FXwnQiHI5xkmFXvXXsQAh6SC4YX+90u43Kwwmwn64h2sNocDeWvHo7xtgOeJf/96ZijxgaW6NO1KmhChR8W7T+26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874515; c=relaxed/simple;
	bh=7ESpY/ci2/QoGHPloYeSwtMzBC3YJtfti1qemYpYGWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyY3T6ALqSV/3FLaQW5ebLC5WnOU64NJljHneDsvWOlWN5oAGH5XII/LMe4zCM4MzQuFjHtzH9oN16II07PB2hMjw9MZe5BxYykwdGEzZNYVBFE89sYDpfvEsX3PfzjBD7lVIyNJ56M7k24V/FSWeJxQ8ZHZu5XdDbpKsWmqUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIhQ6xey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIhQ6xey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F98C2BCB2;
	Wed, 22 Apr 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874515;
	bh=7ESpY/ci2/QoGHPloYeSwtMzBC3YJtfti1qemYpYGWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIhQ6xeye8W71LQdQScHQTjwk6sfVxy0BDM9+poypjbmW1vTDT/WFEJ9QaB3Hs407
	 MigwA8SIJXdxjGuTnlKVZ8ByumvTd1oEtzws/ebuBYKMtN0h6VYSs4CVJvoxtMt0zf
	 PIfiDdsIytwLbr9EKElFOgpiCoBrZRFraZ1JgJFNligSOUPG9137mM/q04CznbksDb
	 1jEUQnc9dNEtcr1mK9sNlKeDtavqIVk2BCo99Ul/fuzHbtTvaxuQX3fucpWl+HXGe1
	 5HZ0q1La7bnjBMIU8XPPDk271FrGz5ZKTUFL1MdX5/572woCf75lu1T/R0w2YhpcRC
	 p3DcLh/Q4iTkg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 18/24] PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
Date: Wed, 22 Apr 2026 16:14:01 +0000
Message-ID: <20260422161407.118748-19-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, pci_create_sysfs_dev_files() and pci_remove_sysfs_dev_files()
are no-op stubs.  With both the generic and Alpha resource files now
handled by static attribute groups, no platform needs dynamic per-device
sysfs file creation.

Thus, remove both functions, their declarations, and the call sites in
pci_bus_add_device() and pci_stop_bus_device().

Remove __weak pci_create_resource_files() and pci_remove_resource_files()
stubs and their declarations in pci.h, as no architecture overrides them
anymore.

Remove the res_attr[] and res_attr_wc[] fields from struct pci_dev
which were used to track dynamically allocated resource attributes.

Finally, simplify pci_sysfs_init() to only handle legacy file creation
under HAVE_PCI_LEGACY, removing the per-device loop and the
HAVE_PCI_SYSFS_INIT helper added earlier.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/bus.c       |  1 -
 drivers/pci/pci-sysfs.c | 52 ++---------------------------------------
 drivers/pci/pci.h       |  4 ----
 drivers/pci/remove.c    |  1 -
 include/linux/pci.h     |  9 -------
 5 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6c1ad1f542d9..655ed53436d3 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -354,7 +354,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_fixup_device(pci_fixup_final, dev);
 	if (pci_is_bridge(dev))
 		of_pci_make_dev_node(dev);
-	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d22bc5c48bc0..3a7bbb00ca60 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,12 +37,7 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
-#if defined(HAVE_PCI_LEGACY) || \
-	!defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
-#define HAVE_PCI_SYSFS_INIT
-#endif
-
-#ifdef HAVE_PCI_SYSFS_INIT
+#ifdef HAVE_PCI_LEGACY
 static int sysfs_initialized;	/* = 0 */
 #endif
 
@@ -1401,8 +1396,6 @@ static const struct attribute_group *pci_dev_resource_attr_groups[] = {
 };
 #else
 #define pci_dev_resource_attr_groups NULL
-int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
-void __weak pci_remove_resource_files(struct pci_dev *dev) { }
 #endif
 
 /**
@@ -1772,54 +1765,13 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
-#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
-int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
-void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
-#else
-int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
-{
-	if (!sysfs_initialized)
-		return -EACCES;
-
-	return pci_create_resource_files(pdev);
-}
-
-/**
- * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
- * @pdev: device whose entries we should free
- *
- * Cleanup when @pdev is removed from sysfs.
- */
-void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
-{
-	if (!sysfs_initialized)
-		return;
-
-	pci_remove_resource_files(pdev);
-}
-#endif
-
-#ifdef HAVE_PCI_SYSFS_INIT
+#ifdef HAVE_PCI_LEGACY
 static int __init pci_sysfs_init(void)
 {
-#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 	struct pci_bus *pbus = NULL;
 
 	sysfs_initialized = 1;
-#else
-	struct pci_dev *pdev = NULL;
-	struct pci_bus *pbus = NULL;
-	int retval;
 
-	sysfs_initialized = 1;
-	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
-		if (retval) {
-			pci_dev_put(pdev);
-			return retval;
-		}
-	}
-#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..1bf165595583 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -391,16 +391,12 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_SYSFS
-int pci_create_sysfs_dev_files(struct pci_dev *pdev);
-void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct attribute_group *pci_bus_groups[];
 extern const struct attribute_group pci_doe_sysfs_group;
 #else
-static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
-static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #define pci_dev_groups NULL
 #define pci_dev_attr_groups NULL
 #define pcibus_groups NULL
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e9d519993853..6e796dbc5b29 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -26,7 +26,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 
 	device_release_driver(&dev->dev);
 	pci_proc_detach_device(dev);
-	pci_remove_sysfs_dev_files(dev);
 	of_pci_remove_node(dev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 30aeb8e02b7b..f6f55005f82d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -507,10 +507,6 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
-	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
-	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
-#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
@@ -2528,11 +2524,6 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
-#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
-extern int pci_create_resource_files(struct pci_dev *dev);
-extern void pci_remove_resource_files(struct pci_dev *dev);
-#endif
-
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
-- 
2.54.0

