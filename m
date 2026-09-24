Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A24A1DF1;
	Thu, 24 Sep 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263353; cv=none; b=RE4/2VtyI0ar4z1rshiG4OpilhfyBqJPzHPCTBrgZytYnZftQV2zB0iS5VZDoxiYTUIYayOr7KBhP3IRuj3J/BvavuHr1t7sBLcFht/wHaoMXaM8QoU0Tk+lgBIfDNtsNroQLDS5QJfeao4UrKbOyMhHWa3ApKSPyOhVLRN/Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263353; c=relaxed/simple;
	bh=l8gn2s8GqlHfJ5yCkCuB/VncRK6pXD0DLtr15uwwQnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss+QxjKGjs8L6j5k3kZyD2lGTGqQnBUThgA2dCOdlJkEv+sgID17tqmR2XLauJz68l6I6GbSZc4f9nHx3JM/Z81Eke0M4Vl7vmtxGTBhS2U2llBNC01F4eENm1yOPH6LvPH96o2X+2q29bwlWL6LYhXrqsOq4UAXiIQsbnrIvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=h/+dGqOQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h/+dGqOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263319;
	bh=9hpaLa2+INWP3vqHDGtmMPxWwc0UhU3YYJ+m/heD+BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/+dGqOQsvDc0m1fW2WiasHQtkIf2OZqIsbjtBan7Ob1yTA1Hr+jcFWq4y2lKO7jR
	 7uo+NLC8fiSEB/NVGNgaUv9kUdSwtqic0KuvHHblfUAHBTBljNo4XSnKZn3rbT7ndo
	 kabiTc07/Qo/2tXOQaHiA8nE2Y32Z6ir03fcoT72P4Q8gIrTkGMqjNp7W5LmtL28ic
	 14wECNTO33knq4rTY1SZAchbFoY0xhhoKxIyoMWXFw/1hMbKIZB+t2YVwWCfCOLBDw
	 9DlkcwryRb6Y3q5XGXsPIBhGVbZWPlKsDC9d+Y3L2bqdmoC6bKY54tIBk/kxQzury0
	 oj2rIF/Lo0E1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHck6FZRz4w9T;
	Fri, 25 Sep 2026 01:21:58 +1000 (AEST)
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
Subject: [PATCH v7 2/9] vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume
Date: Thu, 24 Sep 2026 16:21:45 +0100
Message-ID: <20260924152159.49702-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924152159.49702-1-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
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
un-revoke).  Add vfio_pci_dma_buf_move(false) to the resume path,
making it similar to vfio_pci_runtime_pm_exit().

This also reorders the eventfd signal after the un-revoke and
__vfio_pci_runtime_pm_exit() to guarantee that woken threads observe
the new state.

Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1f6066107831..e170cdc7ac92 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -527,8 +527,14 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
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

