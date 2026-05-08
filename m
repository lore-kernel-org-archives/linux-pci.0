Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F082571B8;
	Fri,  8 May 2026 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214981; cv=none; b=rs5jNB5UsFqWmtUqmZp623WbBAqV5wsUbYxkKKTclVqLDjeJK8Bcmu9j7mFTUxFFsHeryycYZd/JdD3l2fzYlapI9rGb75lBcye//YyYS1zr3pPgHnwDfAHHgG8xu2k5GYkHqfwEJxTdGQwtSdipjl8G1mCGXjohAFdpgnW+PLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214981; c=relaxed/simple;
	bh=Ew4oMNbnD8ia1TjtEFnnPOCDhh0UnWgZ8/ajVBdz8Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAr55VdGOfJey/fCxVY36x/sqvM8wwxnSdDsPHrLge7LaeCBGbI5w7RQBNGZsw+FffgwmxS5xi+nCRiE9aGwkXJeadOUHcOONO9Qd/91olrmaV0dJA+ZRDqlmbstuH/8it5cTwyFUL1kwYxKJtb/84X2v/weo8j/p2TigBoI9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxOthkBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxOthkBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441EFC2BCB0;
	Fri,  8 May 2026 04:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214981;
	bh=Ew4oMNbnD8ia1TjtEFnnPOCDhh0UnWgZ8/ajVBdz8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxOthkBj5rg2x+ly9mDbKmZWCrVE3aShmLOl8pnETDp8SD//7Grkaf54TXZHTcj+M
	 kYEwLwGHsn4ug0iz6F4wz8CrZ7XncknGp9LYOGmwOtwa0mVc8aT/AAr2LC5bmEPeYs
	 VNNs9xF5IHwywcJGE0LnRfuEO17POLNu2WMMxywada0TsF4QU75ANi/W1JlDpj2w3f
	 jD1872owyDSdkEn73zJVaz5yD6qSVU38b2mE1ow5NZqgNaZynM16KqoK+71j/h2SJV
	 lwglyPQoajiAIWBRIad2lGx2daz9q9j2bXxgpniWTGJa0xk2Dxhh3BqrO9Y9f0TBZG
	 c0+rDFeYRqMLQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: [PATCH v7 09/24] PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
Date: Fri,  8 May 2026 04:35:28 +0000
Message-ID: <20260508043543.217179-10-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 15 ++++++++++++---
 include/linux/pci.h     |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f34415a401ec..b2a2de622f39 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1370,10 +1370,9 @@ static const struct attribute_group *pci_dev_resource_attr_groups[] = {
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
@@ -1742,6 +1741,10 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+#else
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1763,9 +1766,15 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
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
@@ -1778,7 +1787,7 @@ static int __init pci_sysfs_init(void)
 			return retval;
 		}
 	}
-
+#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 974605c9fce2..b998a56f6010 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,8 +515,10 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
@@ -2531,8 +2533,10 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
 extern void pci_remove_resource_files(struct pci_dev *dev);
+#endif
 
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
-- 
2.54.0

