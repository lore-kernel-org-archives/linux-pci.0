Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B02D2385;
	Thu,  8 Oct 2026 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439243; cv=none; b=BgON6G/aER6ZyMmryICUUpKEdjdN38OFWFv8OVn4lftezXsTWCdeylJ9do+gxYxQ5Kt/laxpYaT3R4M11mIrS1bp8F0DsG9LdsuMPtGVERUJIS7sFfOC9Qaj4jhO2vzv0s0v/EYVpZC4+4rxiBPWFrW5dRiCmJP6QFYprFxNsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439243; c=relaxed/simple;
	bh=cBC0FqXNk7JOGpZPen1LBK9FyO7uDvEsPZhZBGyiVY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igehFTOtzpUpZKD6JVfKv8z9FNRWJA0xFduLINiBuwsPk/YN5t0sV7hViqGvK4xdFT6FYX76S8xx/TBFkhCi2r0fuVMna96lA7ZkxTIxNJXhvIDAZGKwKidf+PWSWqO73rVBrdV179goMg6vHQfBf6V5a1BsGaVNrUkHoTbsbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Ch799H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Ch799H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831EA1F00893;
	Thu,  8 Oct 2026 06:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439242;
	bh=j8n6g3nvcngcoPNN0SShwUlJQijtEN4srpNypdC6xYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2Ch799HZwbqwWIM+wx6F/RkeqpyhwFzaBY98zxVNueSZvM0YFzvM2WiyZlkZ0Q+i
	 cISPlJQDEvZGRQ5buwJTP3Pj5hLQpWId9+xIIiItTEtEEXQEik5hzAe19Z08mSGTd+
	 JXY4I5fNMJOxZYmRKCKZKUUlW22H+r2+zBKroijjqkmmN+UBjRd8zyps0e7e8BYKU5
	 9If/PocKm+Zor/sx7e6ev7lJhuWCKMWStWEA4v4HWse+1R+61wx527b/pVOVh4PN8j
	 8W/iaE+w4TrhR3eqdRezxjPSISwcjWICSFUCQFsiILAPdvXql0N1NNqDQelkfFCOuc
	 srll11Lo2kzMQ==
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
Subject: [PATCH v7 03/16] KVM: x86: Use file_to_kvm_x86() in SEV
Date: Thu,  8 Oct 2026 11:29:42 +0530
Message-ID: <20261008055955.4014342-4-aneesh.kumar@kernel.org>
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

Use the new arch-namespaced helper instead of open-coding the file check
and private_data cast separately.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 63eb2155a774..db7ed11e9056 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2151,10 +2151,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
@@ -2876,10 +2876,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
-- 
2.43.0

