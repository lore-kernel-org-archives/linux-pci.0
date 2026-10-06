Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C954A92D7;
	Tue,  6 Oct 2026 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315430; cv=none; b=dIQKVSBnc18r2N2UjlEuyMg8EMwGlzmiTbfnDN1bzBMLRyqSICDiM1fUiP7HZIP37/XntsuBkgUaDP1aFERL7BFh4LWsbRZvqVR02hR5bFsDEWxtFfeNHe2TSQEuY6qpc112axGmdm1kBaPMLyWzruQLa3vvzrLnu5NOARFS3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315430; c=relaxed/simple;
	bh=v/ZVQJUgbJkCo7qUyTmNtjiiCLKelnOjnGJdrAmvgGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qimvzAHkneetjdMYBXozXiU/GqkEZcB49QjpZvN/eXuwEyVu8f9E23WAO9qfGXsWNXCCY+pp53DYzrwczEh4TmmQpE9+tYhqRb8igJ1NrfefGwn2g+E2yDOAdgKlp0mOnweG87DvADdpxa2jZnwkoq9t7tTLBGgTF/T/CiWidLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=A5le6S1J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="A5le6S1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791315423;
	bh=M/W/BiVALDUXicJsuh5vAsHsaKskSkebJfPEWlccO3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5le6S1Jq9BCCbF3s4ty2SsDFVV3uj3cF72D3mg5Gx6RqTn+PJcQJU6cMM/hSClRL
	 wOUSFngX/bEZzS/ZuHto34q1xq7FZ6uTkrxOqc5mhUB5FV6TGvpKNrCNKr/XLTJLgA
	 sClw+HydR0xxySsRYpWDs5gXRLR9zwfxW6GSBlUDEFiTrWo3sa8N7eu42nmUFLgysz
	 LLkJb8WJRm9XGiNiQGHGLWX5d/VJKqkZD9NNNPW/32kkcZrbSfiKQ6gt2VZUdVaSza
	 c1HIV5tmVTm3EfrIW9OXn6TOQsr8MAi9aKXdvt+YcP7uDQWceX8YKeIwrZ49cI2Vl4
	 94/9kyqTBqTnw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmjW2dcKz4wJQ;
	Wed, 07 Oct 2026 06:37:03 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
Subject: [PATCH v8 2/9] vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume
Date: Tue,  6 Oct 2026 20:36:30 +0100
Message-ID: <20261006193643.76330-3-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006193643.76330-1-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
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
2.47.3

