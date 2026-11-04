Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809052;
	b=DK1P6h6wu0ZMEt+8d8IH6jBMyDgIiIOrH7Fi0alVtIQh8LSLDidIRrCnJ7/eVVfeJwDt
	 je0XEzT9W+3hOHRQpeU8d8lfgjE3oRk6H2xluKac31cEkStP1akzxVM9oePu3BJfgXA4p
	 blKAutGtPRwDpvqUt//Qqp1nY4MeXCAFnCICHXpGxSeIbcc6+Ufu5ngkw1hPbLlJ7zFlU
	 AsUHsKDlX7G54AcTK9+zE1Mn0U0cTfG3CIK0L3eApQbIu+K2o7hnEg9aVa9Rr0JVlLgbl
	 kw3iETeJa4gsPdAepDN841JQ1Xyh6M3Bxu8dsBOdD+QH/H3BuZzCW420rRW152JVR4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P/AkNQwfphMcdFB+D7s/aBW66xKWMUQ8Q7dzQy7UJpE=;
	b=m3J4oV+EN1YE3bwMweE9grfJTnx5ZoV/EdjVRB9tCC77Yd3jbzJthgS5zKvKnPzd7Ass
	 w8f3fRpA+qy076zhc2uYFtiz2jxcwcoJ1pEOaJX8n6q2Lde9XaYk9zAJq4XZF04CD8otR
	 OjIrKVGWAudEP0A3TC/jHR1xQ712nSM9QqlD3X91nNrZ836NWAiIsw4addubxX9SIXKhJ
	 fL9xRZG5QkonuhEZFXz4VnYqNjH/xbEqvoim1lCCWAtxdXItGub+ZyGsDz1xIVOxxLSDW
	 zTt4tsrobu5IhjOS3B7Et1TPMuNUBbu9jXlZ9/gpb4GFzHx+fPbaAoDxtKT8RmD5/hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0znDxqh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF09606A33B;
	Wed,  4 Nov 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0znDxqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CC81F00A17;
	Wed,  4 Nov 2026 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809052;
	bh=P/AkNQwfphMcdFB+D7s/aBW66xKWMUQ8Q7dzQy7UJpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0znDxqhlUZW1AMXKOYcAnB2EfAAEqvL1OkxoPqAKDXudVi06Vx6a0L7OQg41dKKX
	 LN368MIol11IXpbt6wd0CJlcGZQsSBpxCCuQoRQ2nDsauTjKpPPQsEQCRkv3BsnmUd
	 1s6Zup2fGZCzcUtgUYMUBnSTpGnbAz669dBwAwrvQnCGIc8UU7w0EwhwdExs+PVavR
	 oWM/517qNBq/wBKBipsgrta6dPzaoTgF7ASNrWxBDTyxGyswGCJRUCv7zwRDX6Z8lz
	 OJCDa29MRSQtAGaUo5cSqavNCagmTZ2eVpsle6lXl57i8Lq0lU194azhHTg/LzXWUu
	 wU1nz8vOCmk1w==
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
Subject: [PATCH v8 04/15] virt: coco: tsm: Require PCI operations when registering a TSM
Date: Wed,  4 Nov 2026 21:46:21 +0530
Message-ID: <20261104161632.3547423-5-aneesh.kumar@kernel.org>
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

Reject a NULL pci_ops argument in tsm_register(). Every registered TSM
then has PCI operations, so registration no longer needs separate paths
for TSMs without them.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/tsm-core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e370806d8436..e7807dc94807 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -60,9 +60,6 @@ static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops
 {
 	int rc;
 
-	if (!pci_ops)
-		return 0;
-
 	tsm_dev->pci_ops = pci_ops;
 	rc = pci_tsm_register(tsm_dev);
 	if (rc) {
@@ -80,6 +77,9 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 	struct device *dev;
 	int rc;
 
+	if (!pci_ops)
+		return ERR_PTR(-EINVAL);
+
 	if (IS_ERR(tsm_dev))
 		return tsm_dev;
 
@@ -95,14 +95,12 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 
 	rc = device_add(dev);
 	if (rc) {
-		if (pci_ops)
-			pci_tsm_unregister(tsm_dev);
+		pci_tsm_unregister(tsm_dev);
 		return ERR_PTR(rc);
 	}
 
 	/* Notify TSM userspace that PCI/TSM operations are now possible. */
-	if (pci_ops)
-		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 
 	return no_free_ptr(tsm_dev);
 }
-- 
2.43.0

