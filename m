Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D354704A;
	Thu,  8 Oct 2026 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439272; cv=none; b=LR8iWzrifvpQGfTsFbUJFJh/Uub4C3yhvIZq7vhRjEnGwkFt82MN5TWyCwFRsoTf93qqW4RwPg5tDERkWr9rtjk0bHHjWiBaljdAdz2yqPHuajE9GDiwYaUBsEDBUctLHaj9XCElTCJa4mu/LFaZJujkoHXFSrxUQgKOyGUX/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439272; c=relaxed/simple;
	bh=7iB7h1lGApeO708cvfrrf09jFOYXgkfJ0rLlpQPcaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=absE9ZmB1QiT1Aonxx1ICgH/U4ItFPxFhrw5ySYP45473NRJKMvCxyDR5jmbtYRk4+L25qvouBq1i1KTqY3KxzQ9czP5m0kjwvcpvhsurH7S2Yufcm/DlCqUeFMnooRZY16hXCXxkNNW5ThbmRtG7ReREirHe5DCCsRPX4w7LQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3g3JYtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3g3JYtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630801F00893;
	Thu,  8 Oct 2026 06:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439271;
	bh=R+zl3nAXL+EyGLgki8rh3fu7i1/takcs2cpm2L+B+co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3g3JYtcIyBzdvox31W6b+TsIRQL1hsZajFPo0wk+e5Ez2Uk4c/I/aSrDkEQ+X5qv
	 v9PcUI4v5JKBa7U/wFj/It3xCdQmnWopj/IzLoL1MxBq79y5FJl/ZmQ8Qa3++dFUCF
	 QIEsTfyOn3W+BPzPEv4tJ/r+mJOUZLnHDqhDRVR5fqHWVS1Iqy6tDtWfgLpUKZd+z/
	 962CdnQJOKy3D+WEjgwsW/4iOclbCZlsjFTpz285RE4nH/Ko/Cx3HglLE+0DaHuPHy
	 7vnST6tv4jkCH/7hJJyIbhwpOELZmEpsSN3tHQg6fZISxcpJ7pFthofbMjD1Eb+w1z
	 aw9F427KJ0jvQ==
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
Subject: [PATCH v7 06/16] KVM: Remove unused file_is_kvm
Date: Thu,  8 Oct 2026 11:29:45 +0530
Message-ID: <20261008055955.4014342-7-aneesh.kumar@kernel.org>
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

Remove the now unused file_is_kvm function.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3c5a389361c6..586f6e8bb81b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1087,7 +1087,6 @@ void kvm_exit(void);
 void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
-bool file_is_kvm(struct file *file);
 
 /*
  * Architectures define kvm_file_to_kvm_arch to <arch>
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ff4fab9753ca..60e614795a36 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5515,12 +5515,6 @@ static struct file_operations kvm_vm_fops = {
 	KVM_COMPAT(kvm_vm_compat_ioctl),
 };
 
-bool file_is_kvm(struct file *file)
-{
-	return file && file->f_op == &kvm_vm_fops;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
-
 #ifdef kvm_file_to_kvm_arch
 struct kvm *kvm_file_to_kvm_fn(struct file *file)
 {
-- 
2.43.0

