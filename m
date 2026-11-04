Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809033;
	b=Rp/xDKNSmW3zQ0yI4iG3T9FKJijnTceZQrM/3sUq94u/Iyfoow8PRpkHpyJsm07xKMFL
	 MvjH0p6gz3dfDy64RavJ2oB0w5YNTn80ui/He7Q9KCgRd4Cn1cHLc5kZqpclGoyR0gg1f
	 +HezPlYkDOC+6GXejxeVJDZOvBsYll9xJ0HnPYl3LXSYiVtIdbPpvMC2MfBSxhKL0rdQW
	 X6rGipLg20pqAMot+QZJtgnJ2IngoDr9SfunHfaflKTN701MB8uslZUs9nwqHjB3t+Hp7
	 IIfamOLMiA+Viymt/NabIutajrAELxGPeMAmGetPK69RnBfZ2v7HVAkEFbz+Gzb0IbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fyZRV4J6nax35QOw1ljlSPVHtJnA1c//c2H2SMY2yT0=;
	b=icTInD49/jOvTWWBVZ2LYgIfQQLB1bcXdVGishjMWEJavhHgXtXQApNgJevg+vsWBKSO
	 9lEJ1C7CXYNbOvaAFQtvHJeJLjRHikce3Yk0IyN87xYqfwwhaJNa9niB8iaZYJlV1ylAf
	 0KNwkOY5CDK/Dx1dx54blWhQK3mx7wVMWN5WHYB8rDhgfHhA15ViU58ZeVOoSH8mHsc3n
	 85F7BL9pFytU7CKm/v75nBotrgOMt9eH9UCv3VUuH/yRIwIPKNUjSZUzkdq4TMWTaycPC
	 avZ7vRFoWzIaGuAE91wvv5hDfj5cQ+urdvCeG+77ePbL5MDrtmFhhfoRb/nQ73txJsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFJS4SbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F61606D808;
	Wed,  4 Nov 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFJS4SbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87091F000C1;
	Wed,  4 Nov 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809032;
	bh=fyZRV4J6nax35QOw1ljlSPVHtJnA1c//c2H2SMY2yT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YFJS4SbEKuKwWiS76FBgOfVN9Pfo2nzfGuDF0zKiZyVtvf6Vuz4FHI2dpsXgHsqo6
	 KAzYakMrl2inh6VQXAS4AMPEG0Qr5Qr7qG3dEUlNTo98MPyyx3IBe6SaL3nM7ZN2Xu
	 ct7dEbNT/sqUneuGXFuHKe8JfDyFQ0e57rZT/wvx6yvbk5FfFJupyNX1DZHXP0nBQL
	 hPxJGbZ4Bl1OxjVL1SS+M7wyoHNFQNeO6s++uVCtlbXo3VHStg528CRGALMW7C7mf9
	 AlY0Z2fEbET/uz8OfsjXmutVtpIuzje6bxZcwDOfZ6RWWKCyqhYoobZ5/5/PxlyKrK
	 M/GqFlnhSO4dQ==
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
	linux-tegra@vger.kernel.org
Subject: [PATCH v8 02/15] virt: coco: tsm: Remove the device from lookup before PCI teardown
Date: Wed,  4 Nov 2026 21:46:19 +0530
Message-ID: <20261104161632.3547423-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI connect looks up a TSM by ID under pci_tsm_rwsem. Previously,
tsm_unregister() released that lock after tearing down PCI state while
the TSM was still in the class lookup. A racing connect could then
attach a new PCI context that the teardown would never see.

Remove the device from the class lookup first, then take the PCI write
lock to drain in-flight operations and destroy their contexts. Drop the
device reference only after PCI teardown completes.

Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/tsm-core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e784993353d8..f79135986102 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 	return no_free_ptr(tsm_dev);
 }
 
-static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
-						 struct pci_tsm_ops *pci_ops)
+static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
 {
 	int rc;
 
 	if (!pci_ops)
-		return tsm_dev;
+		return 0;
 
 	tsm_dev->pci_ops = pci_ops;
 	rc = pci_tsm_register(tsm_dev);
 	if (rc) {
+		tsm_dev->pci_ops = NULL;
 		dev_err(tsm_dev->dev.parent,
 			"PCI/TSM registration failure: %d\n", rc);
-		device_unregister(&tsm_dev->dev);
-		return ERR_PTR(rc);
+		return rc;
 	}
 
 	/* Notify TSM userspace that PCI/TSM operations are now possible */
 	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
-	return tsm_dev;
+	return 0;
 }
 
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
@@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
+	rc = tsm_register_pci(tsm_dev, pci_ops);
+	if (rc) {
+		device_del(dev);
+		return ERR_PTR(rc);
+	}
+	return no_free_ptr(tsm_dev);
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_dev *tsm_dev)
 {
+	/* Remove the class lookup first. */
+	device_del(&tsm_dev->dev);
 	if (tsm_dev->pci_ops)
 		pci_tsm_unregister(tsm_dev);
-	device_unregister(&tsm_dev->dev);
+	put_device(&tsm_dev->dev);
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
-- 
2.43.0

