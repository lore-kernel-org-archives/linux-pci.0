Return-Path: <linux-kernel-owner@vger.kernel.org>
From: aik@ozlabs.ru
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	David Gibson <david@gibson.dropbear.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/5] KVM: PPC: iommu: Add missing kvm_iommu_map_pages/kvm_iommu_unmap_pages
Date: Mon,  6 May 2013 17:21:58 +1000
Message-Id: <51875a36.25ac440a.50d9.ffffe90d@mx.google.com>
In-Reply-To: <1367824921-27151-1-git-send-email-y>
References: <1367824921-27151-1-git-send-email-y>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The IOMMU API implements groups creating/deletion, device binding
and IOMMU map/unmap operations.

The PowerPC implementation uses most of the API except map/unmap
operations, which are implemented on POWER using hypercalls.

However, in order to link a kernel with the CONFIG_IOMMU_API enabled,
the empty kvm_iommu_map_pages/kvm_iommu_unmap_pages have to be
defined, so this defines them.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index b6a047e..c025d91 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -603,4 +603,18 @@ struct kvm_vcpu_arch {
 
 #define __KVM_HAVE_ARCH_WQP
 
+#ifdef CONFIG_IOMMU_API
+/* POWERPC does not use IOMMU API for mapping/unmapping */
+static inline int kvm_iommu_map_pages(struct kvm *kvm,
+		struct kvm_memory_slot *slot)
+{
+	return 0;
+}
+
+static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
+		struct kvm_memory_slot *slot)
+{
+}
+#endif /* CONFIG_IOMMU_API */
+
 #endif /* __POWERPC_KVM_HOST_H__ */
-- 
1.7.10.4

