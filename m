Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com [117.135.214.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E38262808;
	Mon, 23 Feb 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862906; cv=none; b=Lh8DQm7BIMvNz9uQu9V2A+7EibGYcsTWf3MzDIOkepI7RnG6j53l+MAg96MR82o/+Pntzl3tsYcAQyLCswOtsz0weBaVSH5Rcsvb/LHKN2ws1zUhHBSCnp+/HwO3kpo9ABXnyG3HxADkRZ+yejx2IzgjqXfGsMOGDROasdb7HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862906; c=relaxed/simple;
	bh=CbgkTnVxraWTJlz4FyYkIv775xl13Zs7SwxGNo6FbjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qsLOsr0LV2G3D0ueyyQPgUSHwRcffWUvuO63UpNalE6pIKKpwgNM58rDz7U/qyWoB+b2blqX+pe/2ID9EFypE98Lem67iGn85UwoXzA0l5/WbHpHSVh8jAvCgbIc9ZQdXWIxxggxn3XQNUJZuU/slbtJsDKmw0YFCIn7cP7Zh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=a5oOYvjV; arc=none smtp.client-ip=117.135.214.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="a5oOYvjV"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404597;
	Mon, 23 Feb 2026 23:52:59 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 19/37] cxl/pci: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:52:47 +0800
Message-Id: <1771861967-88542-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b342ffa09cckunma46d5a1e987b7b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpOQ1ZLTxpDQkNMHRlPS0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=a5oOYvjVY3D2Ens6kUyT9m7aGHh9Lo3mW6a5jZEhiXuIaTS5uOSZj2RY5R5FefooCPcS2YixeCtghE8zHTiGuQm0ZE0lTkCZSiBpdbB0o1TDogLyvMmS5E0Zs3If6FLospWSGZ6UTQ2ks0SqFuiqmCApKhVPTkCI5pyslHRU46c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9CHq4oSqv2IBBu/XtrOePRjKx9bmO/YWUZA6SCgYqHw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/cxl/pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fbb300a..de5c9ff 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -565,13 +565,9 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	 * Per CXL 3.0 3.1.1 CXL.io Endpoint a function on a CXL device must
 	 * not generate INTx messages if that function participates in
 	 * CXL.cache or CXL.mem.
-	 *
-	 * Additionally pci_alloc_irq_vectors() handles calling
-	 * pci_free_irq_vectors() automatically despite not being called
-	 * pcim_*.  See pci_setup_msi_context().
 	 */
-	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	nvecs = pcim_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
+				       PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nvecs < 1) {
 		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
 		return false;
-- 
2.7.4

