Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB41C5D7D;
	Sat, 11 Apr 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894545; cv=none; b=U7rLKZNMLuAUswe3lO8jbrBVWhlqCwsm2FZ9Ri5Lfsft5eJ9azxil93vo+wQv0cLXbBVTluRUI850F4ZIpB3tcyRCIVc3xfZzRcdJEZd18iTO/Hv673Gsy1puxbKk4YMRV0WgT3dCyZclUkG8ImgMJ2mJgdLvRl+GZuZKYwAMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894545; c=relaxed/simple;
	bh=9a670pxaN5vTIVp/eoWyGpfgnbFQKJPHCQ1Ff885QlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7fNgLpzJDHyXzle+BRGBPRG1RJSaXKxuKtnpN1MkfZlq0HVdkoJkV8uzGFB0t8hGYJ0TVyCyCZn5klH3oTZnkuJJwudvyhqA0fZ9B2Iyom0PiI8lh//a/I10ROYf04Sg8OVD5Cj8iabB86H0iJpzs/Jbwzjo5mzNEAmZ68qoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPbVv9Wh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPbVv9Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA349C2BCAF;
	Sat, 11 Apr 2026 08:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894545;
	bh=9a670pxaN5vTIVp/eoWyGpfgnbFQKJPHCQ1Ff885QlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPbVv9WhBWox7dr5g2vDAopTc0X5xiboVRjNJI7LgeLqKNeHmTJIaxt46Qsegle1V
	 TQYTe3PylOWfk0W+/ZIL1esZUo0g/+vGfjSrMGBjXxj1hQRNS3VL/J2YcKwtsQkOHw
	 6vHy/QDfdxvmyftuVA+RE2NJwzQbtAjaos6yMMPZS4F++g4IM+8xDq44cB6otAgApJ
	 kA8uGay4UDihkvQBTrGTdN/4iJE3G9c0zaKNZAlfSgLyZnLHaHj46BnNoOkaHMnsY+
	 NtqORr+Q4O5W2Ta9XdvrW36MFjJ2OLUVeGQK5YRJ0ADsH6deWQBQb/PLj2tpDZQWkD
	 yIyt8Fanmua3g==
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
Subject: [PATCH v4 09/24] PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
Date: Sat, 11 Apr 2026 08:01:33 +0000
Message-ID: <20260411080148.471335-10-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On platforms with HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE,
resource files are now handled by static attribute groups registered
via pci_dev_groups[].

Thus, the pci_create_sysfs_dev_files() and pci_remove_sysfs_dev_files()
can now be stubbed out, as the dynamic resource file creation is no
longer needed.

Also, simplify pci_sysfs_init() on these platforms to only iterate
buses for legacy attributes creation, skipping the per-device loop.

Move the __weak stubs for pci_create_resource_files() and
pci_remove_resource_files() into the #else branch since only platforms
without HAVE_PCI_MMAP (such as Alpha architecture) still need them.
Guard the res_attr[] and res_attr_wc[] fields in struct pci_dev the
same way.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 15 ++++++++++++---
 include/linux/pci.h     |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c0925bdc9ecd..517efb6d71cc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1394,10 +1394,9 @@ static const struct attribute_group *pci_dev_resource_attr_groups[] = {
 };
 #else
 #define pci_dev_resource_attr_groups NULL
-#endif
-
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { }
+#endif
 
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
@@ -1766,6 +1765,10 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+#else
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1787,9 +1790,15 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_resource_files(pdev);
 }
+#endif
 
 static int __init pci_sysfs_init(void)
 {
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+	struct pci_bus *pbus = NULL;
+
+	sysfs_initialized = 1;
+#else
 	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
 	int retval;
@@ -1802,7 +1811,7 @@ static int __init pci_sysfs_init(void)
 			return retval;
 		}
 	}
-
+#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9c0782899ef9..30aeb8e02b7b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -507,8 +507,10 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
@@ -2526,8 +2528,10 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
 extern void pci_remove_resource_files(struct pci_dev *dev);
+#endif
 
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
-- 
2.53.0

