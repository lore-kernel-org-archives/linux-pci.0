Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2053ED3A2
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198822; cv=none; b=eSajWNbhpm57VeGgQTXzuy/VI6Tmy05tbLMHJU5vvwSRXx9671K1HdRuZ6ithm0eE1AMBMW72M1O0zrKQyqFYt8l3kb3tsL8vziHONerSp0RouoRHdPhk5IzAmTsFjU5tiCRtSdsRvD/OnCo2Pkp/Xy3BVZ0c7UJBVYtg8ds3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198822; c=relaxed/simple;
	bh=zisMfHN73tuPRwFcoV7TbbAo3+dnyAi0k2jAminAKFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsCLyVVClagFnaEpXL/z1IcL7e4nu8e6ecrD2mium3OhZqE7U4E3XasMhGxMT2/vMvz0n+rdBuAmkUmT1MQjiHgs5fWAEgTPfMbysbjsxLOASvHUWsUWis0MIErKqBzvVYwU0cFl8uUzvz5APoTkYtKVRaH4N5QUZGGNKjI7aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJBObtlR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJBObtlR"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828659ecd4so1588879a12.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198820; x=1779803620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJfwjdPBl8oaUu0dELFBlMvcSvTYrNQxvVumaB0NKLc=;
        b=DJBObtlRIYGeLef8VtG9pYNU6mYQpQAQ/qHEZcIaPTCkM7+MFy6DEtVYpw7rpJ20vZ
         a4STjxFNpBjeV1YjM5L7W+fwy+I6h31mXcgFSNQ2zsbNErpIzJzogPtF7ts58Kh8cwwC
         pyTu0dtRpKg/Ywf7TOYMTAJei+teVO+Y/u08GeqWJj3p1CCVdwaFIQ9d5n4rYDMAiYpr
         bbKDu/EzZnvA+tjiAqR4CbC+Z25Ob+SITTh7IglvDQ4z19A5Xa8VcgKIIH+V9JEM8WW8
         MyeTcAbZ1E5AX0IsnXjxTzJZIAna5CI/OlKyBIkPjVtFc/YLxhhtbDalJ0p4f93JsCEY
         n6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198820; x=1779803620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJfwjdPBl8oaUu0dELFBlMvcSvTYrNQxvVumaB0NKLc=;
        b=J3sEApTZ/pvJXDMjlgdSH20n4E2oWirdJVc+TrSfBng8KlT2Bs2018b4eNp7vdcii8
         XXwYacfuUqmSBsKKo7cb67qdhsHq2qP8fKD7rF1WVv+vdV1QDQvQ7E1rnnlyw5vMTSi6
         iyrJLVd7IIqYbHmbu65IosZhR7bFfWyR6eHMhzXw+Ytn/koVMFP2AHqmjjpLXE11G9/8
         LK8PAo3p4u2d1tgaOhWDvw6XMTzQB9MtrEHsSLCvUmvnsP2mVFhnyCGUuJMXnhPk6Y90
         XLMWcdI2UKbSSn9CcxP96CdZbdigP1odhpjX/l5XudLeDb1zcVS4T72IKaa2NlRuahoK
         YsCw==
X-Forwarded-Encrypted: i=1; AFNElJ8CcEKvt1eEBzVqDwnCzaC8BNl0VVD4nFJjHtVrGK5E5rQ1MLxzfo3f6oXJVJR7WX04ih9gCdeLKLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdJ4Ips+xpyCfwvPEL153Hp1UUwaOqTGDdhUIxs+EuGR0wZ8h
	lOV6O/yQXpHkcD8HdMOP1OLcgJH6xBn+LdwtdXHges4Qxg9T4q2fJ44LZKHZU8MrOl550b6NjYn
	GYw==
X-Received: from pfbdw11.prod.google.com ([2002:a05:6a00:368b:b0:836:55e:c2f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad5:b0:823:cbb:a484
 with SMTP id d2e1a72fcca58-83f33cbf6abmr19189318b3a.14.1779198820130; Tue, 19
 May 2026 06:53:40 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:22 +0000
In-Reply-To: <20260519135323.1558777-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519135323.1558777-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-4-praan@google.com>
Subject: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The SMMUv3 driver currently has a two-phase commit in its ATS enablement
flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
enabled using arm_smmu_ats_supported() and accordingly increments
nr_ats_masters and merges ATS invalidations into the domain's invs array.

However, the actual hardware enablement via pci_enable_ats() happens
later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails
the SMMU driver's ATS state tracking remains polluted, i.e. the driver
tracks ATS enabled on a master that is not actually using ATS. This leads
to an incorrect nr_ats_masters and triggers a warning in the PCI core
during detach:

[  127.925080] ------------[ cut here ]------------
[  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8, CPU#42: iova_stress/12240
[  127.949761] Modules linked in: vfat fat dummy bridge stp llc cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd
[  127.961760] CPU: 42 UID: 0 PID: 12240 Comm: iova_stress Not tainted 7.1.0-smp-DEV #4 PREEMPTLAZY
[  127.970619] Hardware name: <REDACTED>
[  127.977655] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  127.984603] pc : pci_disable_ats+0x94/0xa8
[  127.988687] lr : arm_smmu_attach_prepare+0x104/0x310
...
[  128.068169] Call trace:
[  128.070603]  pci_disable_ats+0x94/0xa8 (P)
[  128.074688]  arm_smmu_attach_prepare+0x104/0x310
[  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
[  128.083899]  arm_smmu_attach_dev_blocked+0x50/0x88
[  128.088677]  __iommu_attach_device+0x30/0x138
[  128.093026]  __iommu_group_set_domain_internal+0xdc/0x228
[  128.098412]  __iommu_take_dma_ownership+0x118/0x150
[  128.103278]  iommu_group_claim_dma_owner+0x48/0x80
[  128.108056]  vfio_container_attach_group+0xc8/0x1b0
[  128.112927]  vfio_group_fops_unl_ioctl+0x578/0x968
[  128.117706]  __arm64_sys_ioctl+0x90/0xe8

The issue was exposed under heavy load when running a VFIO-based DMA
map stress test (iova_stress).

Introduce an 'ats_prepared' flag in struct arm_smmu_master.
This flag is only set during arm_smmu_probe_device() if the initial
pci_prepare_ats() configuration (which sets the STU) succeeds.

Update arm_smmu_attach_prepare() to gate ats_enabled on this new flag.
This ensures that if a master failed its initial ATS configuration, the
driver gracefully falls back to a non-ATS mode, skipping all ATS-related
resource allocation for the domain. This syncs the driver state with the
HW state.

Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 811d859291e9..af39bf8d2774 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3718,7 +3718,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		 * Disable ATS if we are going to create a normal 0b100 bypass
 		 * STE.
 		 */
-		state->ats_enabled = !state->disable_ats &&
+		state->ats_enabled = !state->disable_ats && master->ats_prepared &&
 				     arm_smmu_ats_supported(master);
 	}
 
@@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (dev_is_pci(dev)) {
 		unsigned int stu = __ffs(smmu->pgsize_bitmap);
 
-		pci_prepare_ats(to_pci_dev(dev), stu);
+		if (!pci_prepare_ats(to_pci_dev(dev), stu))
+			master->ats_prepared = true;
 	}
 
 	device_link_add(dev, smmu->dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a697fa3c457b..1fc1c420613f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -947,6 +947,7 @@ struct arm_smmu_master {
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
 	bool				ats_enabled : 1;
+	bool				ats_prepared : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	unsigned int			ssid_bits;
-- 
2.54.0.563.g4f69b47b94-goog

