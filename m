Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:35792 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbCJLej (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 07:34:39 -0400
Received: by lams18 with SMTP id s18so992727lam.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 04:34:38 -0700 (PDT)
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v3 2/9] x86, pci: Abstract PCI config accessors and use AMD Fam10h workaround exclusively.
Date: Tue, 10 Mar 2015 12:35:13 +0100
Message-Id: <1425987320-15020-3-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From now on, readb()/writeb()/etc. generic calls are used as default
approach. Special MMIO accessors are registered for AMD Fam10h CPUs only.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/include/asm/pci_x86.h |   8 +++
 arch/x86/pci/mmconfig-shared.c | 114 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/pci/mmconfig_32.c     |  24 +--------
 arch/x86/pci/mmconfig_64.c     |  24 +--------
 arch/x86/pci/numachip.c        |  24 +--------
 5 files changed, 128 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index d024f4d..c57c225 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -137,6 +137,11 @@ struct pci_mmcfg_region {
 	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
 };
 
+struct pci_mmcfg_mmio_ops {
+	u32 (*read)(int len, void __iomem *addr);
+	void (*write)(int len, void __iomem *addr, u32 value);
+};
+
 extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
 extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
@@ -145,6 +150,9 @@ extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
 extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
+extern u32 pci_mmio_read(int len, void __iomem *addr);
+extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
+extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
 
 extern struct list_head pci_mmcfg_list;
 
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index dd30b7e..8b3bc4f 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -31,6 +31,118 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+static u32
+pci_mmconfig_generic_read(int len, void __iomem *addr)
+{
+	u32 data = 0;
+
+	switch (len) {
+	case 1:
+		data = readb(addr);
+		break;
+	case 2:
+		data = readw(addr);
+		break;
+	case 4:
+		data = readl(addr);
+		break;
+	}
+
+	return data;
+}
+
+static void
+pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
+{
+	switch (len) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		writew(value, addr);
+		break;
+	case 4:
+		writel(value, addr);
+		break;
+	}
+}
+
+static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_default = {
+	.read = pci_mmconfig_generic_read,
+	.write = pci_mmconfig_generic_write,
+};
+
+static struct pci_mmcfg_mmio_ops *pci_mmcfg_mmio = &pci_mmcfg_mmio_default;
+
+static u32
+pci_mmconfig_amd_read(int len, void __iomem *addr)
+{
+	u32 data = 0;
+
+	switch (len) {
+	case 1:
+		data = mmio_config_readb(addr);
+		break;
+	case 2:
+		data = mmio_config_readw(addr);
+		break;
+	case 4:
+		data = mmio_config_readl(addr);
+		break;
+	}
+
+	return data;
+}
+
+static void
+pci_mmconfig_amd_write(int len, void __iomem *addr, u32 value)
+{
+	switch (len) {
+	case 1:
+		mmio_config_writeb(addr, value);
+		break;
+	case 2:
+		mmio_config_writew(addr, value);
+		break;
+	case 4:
+		mmio_config_writel(addr, value);
+		break;
+	}
+}
+
+static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_amd_fam10h = {
+	.read = pci_mmconfig_amd_read,
+	.write = pci_mmconfig_amd_write,
+};
+
+void
+pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops)
+{
+	pci_mmcfg_mmio = ops;
+}
+
+u32
+pci_mmio_read(int len, void __iomem *addr)
+{
+	if (!pci_mmcfg_mmio) {
+		pr_err("PCI config space has no accessors !");
+		return 0;
+	}
+
+	return pci_mmcfg_mmio->read(len, addr);
+}
+
+void
+pci_mmio_write(int len, void __iomem *addr, u32 value)
+{
+	if (!pci_mmcfg_mmio) {
+		pr_err("PCI config space has no accessors !");
+		return;
+	}
+
+	pci_mmcfg_mmio->write(len, addr, value);
+}
+
 static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 {
 	if (cfg->res.parent)
@@ -231,6 +343,8 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
 			return NULL;
 		}
 
+	pci_mmconfig_register_mmio(&pci_mmcfg_mmio_amd_fam10h);
+
 	return "AMD Family 10h NB";
 }
 
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 43984bc..4b3d025 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -71,17 +71,7 @@ err:		*value = -1;
 
 	pci_exp_set_dev_base(base, bus, devfn);
 
-	switch (len) {
-	case 1:
-		*value = mmio_config_readb(mmcfg_virt_addr + reg);
-		break;
-	case 2:
-		*value = mmio_config_readw(mmcfg_virt_addr + reg);
-		break;
-	case 4:
-		*value = mmio_config_readl(mmcfg_virt_addr + reg);
-		break;
-	}
+	*value = pci_mmio_read(len, mmcfg_virt_addr + reg);
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 	rcu_read_unlock();
 
@@ -108,17 +98,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 
 	pci_exp_set_dev_base(base, bus, devfn);
 
-	switch (len) {
-	case 1:
-		mmio_config_writeb(mmcfg_virt_addr + reg, value);
-		break;
-	case 2:
-		mmio_config_writew(mmcfg_virt_addr + reg, value);
-		break;
-	case 4:
-		mmio_config_writel(mmcfg_virt_addr + reg, value);
-		break;
-	}
+	pci_mmio_write(len, mmcfg_virt_addr + reg, value);
 	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
 	rcu_read_unlock();
 
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index bea5249..032593d 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -42,17 +42,7 @@ err:		*value = -1;
 		goto err;
 	}
 
-	switch (len) {
-	case 1:
-		*value = mmio_config_readb(addr + reg);
-		break;
-	case 2:
-		*value = mmio_config_readw(addr + reg);
-		break;
-	case 4:
-		*value = mmio_config_readl(addr + reg);
-		break;
-	}
+	*value = pci_mmio_read(len, addr + reg);
 	rcu_read_unlock();
 
 	return 0;
@@ -74,17 +64,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 		return -EINVAL;
 	}
 
-	switch (len) {
-	case 1:
-		mmio_config_writeb(addr + reg, value);
-		break;
-	case 2:
-		mmio_config_writew(addr + reg, value);
-		break;
-	case 4:
-		mmio_config_writel(addr + reg, value);
-		break;
-	}
+	pci_mmio_write(len, addr + reg, value);
 	rcu_read_unlock();
 
 	return 0;
diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 2e565e6..5047e9b 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -51,17 +51,7 @@ err:		*value = -1;
 		goto err;
 	}
 
-	switch (len) {
-	case 1:
-		*value = mmio_config_readb(addr + reg);
-		break;
-	case 2:
-		*value = mmio_config_readw(addr + reg);
-		break;
-	case 4:
-		*value = mmio_config_readl(addr + reg);
-		break;
-	}
+	*value = pci_mmio_read(len, addr + reg);
 	rcu_read_unlock();
 
 	return 0;
@@ -87,17 +77,7 @@ static int pci_mmcfg_write_numachip(unsigned int seg, unsigned int bus,
 		return -EINVAL;
 	}
 
-	switch (len) {
-	case 1:
-		mmio_config_writeb(addr + reg, value);
-		break;
-	case 2:
-		mmio_config_writew(addr + reg, value);
-		break;
-	case 4:
-		mmio_config_writel(addr + reg, value);
-		break;
-	}
+	pci_mmio_write(len, addr + reg, value);
 	rcu_read_unlock();
 
 	return 0;
-- 
1.9.1

