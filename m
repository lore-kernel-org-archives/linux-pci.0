Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA561514F8;
	Thu, 16 Apr 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362537; cv=none; b=jtXXjZaO0uQ5N2tneiOY7JBpt1GJSY7A4zMyPkm6f53w4SOoF75U0v4bxu2AqfsWdrikkvQCwC7R+NfaKAYWNFTiadcbHhRd52x1yiZzpaIRri5qLz9TRULfoA1sjxNTyTuFk6DgoC58ptuzpSs9SHCiMfRQxhJb46oGxIo019c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362537; c=relaxed/simple;
	bh=weHFBz7i//6ML6QGLBL0RoSrKCxIntD99zUOmvv58+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhMVXI9z4Xh9WQ8Gk4qfJ/ywiIfm+bLs+b1eJDuzomQlkJX4lcFRpzia3YzaWfD5MMjNWDbC0gXt6C3GXxc4ALh/AXB52ua1ixPFduCLW1wny5lIPX3j24Ym4YBcSmpytA4IELNnQ77jAiUXYMJubXhp9c2ZTgJijEAKQe9FPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9URtz43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9URtz43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A4C2BCB0;
	Thu, 16 Apr 2026 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362536;
	bh=weHFBz7i//6ML6QGLBL0RoSrKCxIntD99zUOmvv58+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9URtz43U6btvNAYdtVJsXRHhJIDnzir5u04KuQnG374e3fMR1+VqWryxydChD/Hd
	 T/bv5sBhxKhijvWVC2lgpUnYCmTiEyTvFH5HOhTXwPnmrRrSLPipv+lz2ROAqdZ4fU
	 cYnxuVSstCptMRBOmBkMAn8tl2JfdG2ghXbLCQbvSzSPOINOWJJB/6/IN8YPuXBD8D
	 aMtMIuMMB7f3dGFjFlUCmM8iYjmw+rrPiT3k0/Wu+XdjPN8riFrGi0ujfpiH393V1i
	 0JZ3YEo/aiVBGILeo0oYlViiezl6djifeWN7y9EuZ5WSK0KdK3B8msqLruDPo0DE6B
	 2fJ2KeDiAIbHg==
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
Subject: [PATCH v5 18/23] PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
Date: Thu, 16 Apr 2026 18:01:02 +0000
Message-ID: <20260416180107.777065-19-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
2.53.0

