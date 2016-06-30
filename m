Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 7/7] PCI: Add a macro to set default alignment for all PCI devices
Date: Thu, 30 Jun 2016 18:53:13 +0800
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1467283993-3185-8-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we can use something like "pci=resource_alignment=*:*:*.*:noresize"
to enforce the alignment of all MMIO BARs to be at least PAGE_SIZE so
that we can passthrough sub-page(size < PAGE_SIZE) BARs to guest in
VFIO module.

But sometimes we may want to enable this feature by default on
some platforms such as PowerNV platform which would easily see those
sub-page BARs because of its 64K page. To achieve that, we add a
macro PCIBIOS_DEFAULT_ALIGNMENT to set default alignment for all
PCI devices and define it on PowerNV platform.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index a6f3ac0..b0d76b8 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -28,6 +28,10 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#ifdef CONFIG_PPC_POWERNV
+#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
+#endif
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2e15ac8..dde0cce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4761,6 +4761,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	char *p;
 	bool invalid = false;
 
+#ifdef PCIBIOS_DEFAULT_ALIGNMENT
+	align = PCIBIOS_DEFAULT_ALIGNMENT;
+	*resize = false;
+#endif
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
-- 
1.7.9.5
