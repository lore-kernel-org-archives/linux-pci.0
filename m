Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2654A4F04;
	Fri, 11 Sep 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162946; cv=none; b=s/yYMF3i0KBe5Re7Y5I6ilmeJsrKaF3mlsyD7hg0oWZ6YFLwhI+GVfBqtykAkylYcXguDRVijdNFqNG+jxZzquui/x9djf9NEKWkLFc+w92sIEP8vySReUvuZnvs+gP/OMN+PuTh6fxJxmnEp1F3NLVQEr99APwRb9nzkRxZ3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162946; c=relaxed/simple;
	bh=n3pPgtx7j0l4P9cXzwpXYLyMjwAKV21QNPFoCs2i+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0nZzUb+c1xw4CDJpBebseDwq1pou0NW/K1z9JGL/nPrGfBFhsEuhYOa4dpxFBeO1sgyyaQAhR25EJOXjHMjHj3ad2BRyyqDSTlon6y8zulurEadtZCIKPeX3nqIgcPbj9GimsTu8aiqwDGHy9JesthFSyPP3tA1l249m+Or8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=DBtSyh2T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="DBtSyh2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789162930;
	bh=mP9BImIYMo25bR2U7ro515N53S9BWIjWTdFtXfFoqGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBtSyh2TIcTcReXLFqr0fkMDW+LGSeGiaspIp93+XfoaiRsBo5310iHZRHdGOZr4C
	 zoTFlyflBd3vm//3rr6DknwQ0Utxtrvu4llkTuNGiqM9v7nMcyHRsMHbllRrRHIN1l
	 prscVgDz0Xuhk2EZPcJ9X2JWFWHb/2vNqFZQwn2Mg6tqhUXtP/9+tM2WL9OZ0nzyAg
	 FDULcttYn2bQYANkd0XSl4ZOsyw6JDwIp4/Job4yUIWVkU3gyUoDMtJSKxhJVINpJq
	 Py0ni2U3IOrtTdb6yzY/iavHmKzfBHWqKXeJvwRj29cI1ZAz43EjriS5zwwbyclTe0
	 lFo9tPMKXlWmg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hhSgP6YHtz4wbr;
	Sat, 12 Sep 2026 07:42:09 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 2/9] vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume
Date: Fri, 11 Sep 2026 22:41:50 +0100
Message-ID: <20260911214200.33793-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911214200.33793-1-matt@ozlabs.org>
References: <20260911214200.33793-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP correctly revokes
DMABUFs on entry and, when paired with a
VFIO_DEVICE_FEATURE_LOW_POWER_EXIT, vfio_pci_runtime_pm_exit()
correctly un-revokes them.

However, when vfio_pci_core_runtime_resume() signals the eventfd on
resume, the bare __vfio_pci_runtime_pm_exit() is used (which does not
un-revoke).  Add a DMABUF move(false) to the resume path, making it
similar to vfio_pci_runtime_pm_exit().

This also reorders the eventfd signal after the un-revoke and
__vfio_pci_runtime_pm_exit() to guarantee that woken threads observe
the new state.

Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7d090be8c9c1..3428322efa6e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -526,8 +526,14 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 	 */
 	down_write(&vdev->memory_lock);
 	if (vdev->pm_wake_eventfd_ctx) {
-		eventfd_signal(vdev->pm_wake_eventfd_ctx);
+		struct eventfd_ctx *ctx = vdev->pm_wake_eventfd_ctx;
+
+		vdev->pm_wake_eventfd_ctx = NULL;
 		__vfio_pci_runtime_pm_exit(vdev);
+		if (__vfio_pci_memory_enabled(vdev))
+			vfio_pci_dma_buf_move(vdev, false);
+		eventfd_signal(ctx);
+		eventfd_ctx_put(ctx);
 	}
 	up_write(&vdev->memory_lock);
 
-- 
2.50.1 (Apple Git-155)

