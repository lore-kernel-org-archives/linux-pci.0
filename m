Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6E3BE646;
	Thu,  8 Oct 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439263; cv=none; b=ZcxFzGIjW45y8g2PjOd0cWlp7rQefZNcudQUUDyU+7hmju6gJWE9revcHw2Z2g1J22T9cZ0bAO7tyuxh2RfUq0NoQ4HEAXMebJgt6H08Mkfn/+Xq4MlgqXBgReiG3Dv7Tg53sjHhzeGNmZcvEb+F00FjmXeOQdA1wb1ygxa6QCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439263; c=relaxed/simple;
	bh=HXF20B/0/1Wzm6qEC0EeqgKprlBQWRoActntKC8FzKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmOm97tyZf49e9N8qvMTriK9t7XGYti9Bnv0VXX/dkjqBtaJvCepWWUuTsgPNgyl95gcammOll1Q/1t23SZgN9gUZlWEIifPZQjCmGXYJRpeFZsx6fFTD01ZITJ13d1AP/KWPYCL9GApSuMJ2H6+iZtfzWZw2NuKJY9uBtrHTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj/nVBp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj/nVBp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74E81F000FF;
	Thu,  8 Oct 2026 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439261;
	bh=ZatjWyYpzWno/oJhpn1a9fOMDTmp8fJRPbr6FECUuF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xj/nVBp/6TYRNHO2bxXIrIzVxTJas36sUS2jESk6cCH03ZXTOV/8jLMjU/mlxlOzC
	 L9AJYD7OKIWaRxh4SR1DaTN2Y6DGUHWz7p9BX491wlwL22VgNW+l1dwT5uIGRZu0En
	 doQcxXp7zW98Lh7afYiuvmJVKKIBhLPkuPspnUWEMnDoUl4oPPkzygkoYBKyXcP4ka
	 WWq7MRVCrigC2Zs9wCUPecObW5Wd1uJw2F18Rx3lcjyd+JOTXj3bIsLA+NKAvTGulZ
	 BTAUXQ1KeSTH2YQjymQG/4idE/7x7froUwpLFs3ZdtDRq579A9FAecsobbN2Os0wGH
	 V6sOxPGv04aGA==
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
Subject: [PATCH v7 05/16] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
Date: Thu,  8 Oct 2026 11:29:44 +0530
Message-ID: <20261008055955.4014342-6-aneesh.kumar@kernel.org>
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

Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
now only used within KVM itself. No external module needs them now that
VFIO uses file-based reference counting. Remove the corresponding
exemptions from the x86 KVM Makefile exports check.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/x86/kvm/Makefile | 5 +----
 virt/kvm/kvm_main.c   | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index e6d395ede9e2..c6bf463f5032 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,10 +61,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
-				-e kvm_file_to_kvm_fn \
-				-e kvm_get_kvm \
-				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_file_to_kvm_fn
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8e49ea809528..ff4fab9753ca 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
 
 /*
  * Make sure the vm is not during destruction, which is a safe version of
@@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
 {
 	return refcount_inc_not_zero(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
 
 void kvm_put_kvm(struct kvm *kvm)
 {
 	if (refcount_dec_and_test(&kvm->users_count))
 		kvm_destroy_vm(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);
 
 /*
  * Used to put a reference that was taken on behalf of an object associated
-- 
2.43.0

