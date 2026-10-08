Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128B6DCE1;
	Thu,  8 Oct 2026 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439299; cv=none; b=dPCoSqmO6eXJQwj+sGnxN27RyX+1wF4KdF/0Md/oXkMvSrOjoN5AdkFq3wBQOBEWEPaP+Y00nzJl88t40iBRY3bChjYY0w8duSQB2H3s6kNhndUys8PcI9tD/w4ifhxCGbxhW63VKHGI7avyVS/8xDygSt+8SR2E92d1SZN7Lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439299; c=relaxed/simple;
	bh=b+eRxjvQUXu+7yrFvCFb4wCcIvV3GnnrCT5qAel3L7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5Wzfwu+UK9TenXHqgilt5dINmJyACbcvFEcMmSjQET450nldbidv8FuduECNMPaUdS+njhw2PUkmNSwiPwatjqGpIGlJo9OycA7gnapDPI8ZieNhrC9sMvE589w+ziPFfXUfpvrVdgqb56ffO4vgAd9ygX/ANmi1FBIg/iRRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIqCJia7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIqCJia7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B31F00893;
	Thu,  8 Oct 2026 06:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439297;
	bh=yTQQuV4psRKvxDzTdLOJZ4uuToh0Wf4kSUXnRgYJ2U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIqCJia77E1xwebKyTUEfNu5o1GRv3n6EjQP/mTqcVZMaMmZwPXF1cKbiFsq746ar
	 EiHkTqLWyb7yC7LuYx63O+hFO1Xffql/3qNAtg1T9g4MmwWA7+gBCYnsMov0Y15oYm
	 W25HgD6qvVEQ0pjEMvl+x1RZ+d5WofEDNT7j9uMCiwS4u56NRcpOh6OXK7jXhvxJF5
	 c1xBlvXpYh9v8EgHRbIBoiUeYHCgrxpqL6Cgb1anryjErZSF7FWxNKLbdLu8h3TE39
	 28bEemiip6lnOivD4nPZjpdEur0KirrtpyMjz677wUIpOahlOsWTbnDgYs/jidk+1R
	 /nwxRcCoD4eyA==
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
Subject: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI teardown
Date: Thu,  8 Oct 2026 11:29:48 +0530
Message-ID: <20261008055955.4014342-10-aneesh.kumar@kernel.org>
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

PCI connect looks up a TSM by ID under pci_tsm_rwsem. Previously,
tsm_unregister() released that lock after tearing down PCI state while
the TSM was still in the class lookup. A racing connect could then
attach a new PCI context that the teardown would never see.

Remove the device from the class lookup first, then take the PCI write
lock to drain in-flight operations and destroy their contexts. Drop the
device reference only after PCI teardown completes.

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

