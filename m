Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90283C1D70;
	Tue, 25 Aug 2026 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639297; cv=none; b=YX19pdCkttP3zIi1hI+N8Q1hFxS0j1a59HhgQz/MaCyVsBWEaG3d0xGPqvZreq6IcvfEfpQf7lc+GQImGoPc0tSTn+T19iMBlLLRfsz6n9Ul95eEg6J406i7/nLufrCAnEU/qVf6ZYQrobGtPNM+4bTzwFb+Ih5U1W9znstpHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639297; c=relaxed/simple;
	bh=X+ssLOJftSrzFsbg/AgVjNQBX8PO+VSFJIe6yeVhBMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTTIvKWb5y16g5jMC19ThNrujZPgxUtqopi0cT7RBcxSonKyo4ctyhtmLmnnFzCIlGmmCyBamD2Lgrxp+L4+A4WKTCTbPc18LlAfX9cxF9diKc4RBrjT8pWtXQWUA0LsTImuZZlvOE2i65kx0x2kLLlBFMHShjq6gNPk/FgIqjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1CZwoSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1CZwoSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAF01F00A3D;
	Tue, 25 Aug 2026 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639295;
	bh=ecQDxocNxhe6h8WbRg2jY1pkJAbLQwhKP5LlEGGTfco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1CZwoShDUcMcVFat6MyVVKUti2dBkhBzfiZtrKIP2wentndbsb1zDEhq/+/IyPU7
	 zYHDTgOnbFBMNsgfJwrZ3lqEgPsAJuBkynmyJW60IZPmTdyNnKby5B1dcUNmS1Neiz
	 5/XtTgiWs4targ6k6uascEufIsAI9dPGaR95AF2JbYk8vppd2UabszovE51evl9BUn
	 f5j+rW1f8/k3TfjDmKXm/ILn1ipgcTAM3W77bmVntWKUSILJxrIpMzUDpdX7xO0qdE
	 u/0Mzbzwc5LKkrkyJ5y3I9VWo59sbcywF8hTbfCp2AhFnp0ZBVHnIkHuTebpqsV/HU
	 NbF9eyV+nzBmQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after move_notify() rename
Date: Tue, 25 Aug 2026 09:28:01 +0300
Message-ID: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
documentation pointing at move_notify(), a symbol that no longer
exists. Readers grepping for it find nothing, and this is the only
place in Documentation/ describing the revocation requirement.

Name the current function and record that importers which cannot unmap
within bounded time have to be rejected at attach time, which is what
makes the synchronous unmap on remove() achievable.

Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index d3f406cca694..63cff9e4d2c9 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
 is used to determine the mapping type. The phys_addr_t-based DMA API is used to
 establish the dma_addr_t.
 
-Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
+Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
 to remove() it must deliver an invalidation shutdown to all DMABUF importing
-drivers through move_notify() and synchronously DMA unmap all the MMIO.
+drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
+the MMIO. Importers unable to complete that unmap within bounded time have to
+be rejected when they attach, which dma_buf_attach_revocable() checks for.
 
 No importing driver can continue to have a DMA map to the MMIO after the
 exporting driver has destroyed its p2p_provider.

-- 
2.55.0

