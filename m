Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CC2D2385;
	Thu,  8 Oct 2026 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439224; cv=none; b=GMjLmpgjiFiv6ElpLIVwOMwJ7hWrtpTNkc7TlcoqTUy1UuS6Rm/jo8ktPrKfzVPnc6vM2BjcUbFZfJE76EC5j6de6ggwdzKLSm/jBqDffenXrtcSDBONiBWGRmV7j3w7qHpjNehZVsXJbldWUP3KEcmn9kBD0Hmh+sdcU5CZDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439224; c=relaxed/simple;
	bh=BEjJAxiiNWF1ZVSRG/bmM+g95ZgL09WfJD+YqAyMpPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKhRaRAt4r8aPIj/oCPQo2XzhXmiZ5/Xua3p1knhs2E4irPuvGnzxpKHRkmBObBhVWWrr8OizJhZsoHF4MKxdw3uQs8JXobKauYBdUWNudpn+Bz8hg4G1qybMIgfHs4JaDe/oXQqJtlJ19Yd+5UpWcTvHESQHT54gy9mERTQ+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9UImMUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9UImMUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E8F1F00893;
	Thu,  8 Oct 2026 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439223;
	bh=09vdsORecMf9R07NLZLGzvSGWUHz+vByZgriB/KkWl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9UImMUkB6ZBa0F624VUITeS94cpMKfiMuu5EaO3MED3RxVnqOLaVwp7WKx7GQwDZ
	 4xjbA3wxek8XKsktpGJQhwYBDUh9wxHXfgcImpQWcYQyBfOEGMn5Wl5EzrqIPWHnnM
	 kflInl1v/KR6ZELgOsVxBTwE7o4opHWHGsEcaW8NdyAWA3D+bPWE3gsRD4bqg974Rs
	 j+A8lIytq+lK6vBh/izbBj+Z6UReMVMYwJWXkUzazqs9doPCl8rAEmHFbImtD8SbBe
	 dd42fX0NRnY93iRcSV0pR4PVXDuz2E+5CNfB69KuYL8xLkgxVhOPaR+nZNq3GlK++B
	 IKAE5PneqHjpA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v7 01/16] KVM: Introduce file_to_kvm_<arch>() infrastructure
Date: Thu,  8 Oct 2026 11:29:40 +0530
Message-ID: <20261008055955.4014342-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steffen Eiden <seiden@linux.ibm.com>

Add a macro mechanism that generates an opt-in and arch-namespaced
file_to_kvm_<arch>() to convert a file reference to a kvm object if the
file handle represents a kvm handle.

Activate for x86 and for s390 (native KVM only).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 ++
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/kvm/Makefile                 |  1 +
 include/linux/kvm_host.h              | 12 ++++++++++++
 virt/kvm/kvm_main.c                   | 11 +++++++++++
 5 files changed, 28 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..8a7eed5847e1 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -27,6 +27,8 @@
 #include <asm/isc.h>
 #include <asm/guarded_storage.h>
 
+#define kvm_file_to_kvm_arch s390
+
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..e460073ff176 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -44,6 +44,8 @@
 
 #include <hyperv/hvhdk.h>
 
+#define kvm_file_to_kvm_arch x86
+
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
 /*
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 0474604ab8a1..e6d395ede9e2 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,6 +61,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
+				-e kvm_file_to_kvm_fn \
 				-e kvm_get_kvm \
 				-e kvm_get_kvm_safe \
 				-e kvm_put_kvm
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cf7fe835c4ad..bc3abfde8393 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1082,6 +1082,18 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+
+/*
+ * Architectures define kvm_file_to_kvm_arch to <arch>
+ * to get a typed, arch-namespaced helper:
+ *
+ *   struct kvm *file_to_kvm_<arch>(struct file *file)
+ */
+#ifdef kvm_file_to_kvm_arch
+#define kvm_file_to_kvm_fn CONCATENATE(file_to_kvm_, kvm_file_to_kvm_arch)
+struct kvm *kvm_file_to_kvm_fn(struct file *file);
+#endif /* kvm_file_to_kvm_arch */
+
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 85f42289748d..07fc874a38e1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5519,6 +5519,17 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+#ifdef kvm_file_to_kvm_arch
+struct kvm *kvm_file_to_kvm_fn(struct file *file)
+{
+	if (!file || file->f_op != &kvm_vm_fops)
+		return NULL;
+
+	return file->private_data;
+}
+EXPORT_SYMBOL_GPL(kvm_file_to_kvm_fn);
+#endif
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
-- 
2.43.0

