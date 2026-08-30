Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1103B27D5;
	Sun, 30 Aug 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788093130; cv=none; b=i0MmA+1uKsCkGl5UWvZGvFMDCnPSomuSCnbW1QrM7DwpvKsexMwox9aabRdcjzGC9HyR/3XZ3QZjIJFXKdMFJwf0759s/y7dRP1Qx6e1KKEbLD2FSu3n5WIE1dOor73kmupd2wrDR1XA9UcLfV8GoZebP+pbV9uqf95eFLCVMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788093130; c=relaxed/simple;
	bh=9X8cSbd2RK5O+XQYVHGEEKoG3nnAz/8Dc6No6o4JIms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7qahNbjLRBmS0NVLor3WJVNiaJUaDb7rOVCt4h6nuhoMyA2+sOkdqjacQe5CiE5hTt35fEIk6n7eNP9+5+7v5doo9MKs9KuONEwsFEXLmMoL98BDl4qRRvX+qtx1x/bXVMVAm/ixEGuwqpdSK1BoKKQi76KRLkgeuY/qFTdm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5l1n6Hv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5l1n6Hv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8EC1F00A3D;
	Sun, 30 Aug 2026 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788093129;
	bh=RJCuZGSUvPJzHcbaWQPIPczOFaB/IqmH+bcUMXp3qcw=;
	h=From:To:Cc:Subject:Date;
	b=c5l1n6HvFsKAm+es+LT/Sp0OuF+wMkeLphXmtcLdrKuGD9n4eCwwg/CCFrnk2CiC7
	 +UX4roDbEf413wvhu/6pdxWB0+jbqYafwQXHBmO0iQ+jACzCVIPUgaJIo9r7IbHN3x
	 VCQsrZdbbO44MuehW6kVIN1jIryskahixHBVBqNyeObDcluElWrnnT76qeuhLyt5Tp
	 yoqnG2IDIDYQzX8qjP4XXg23egbHg7q1+UBq6Q34lfHy3PmuzRtjxi+cbqa/8S7qvk
	 lS1isaZXlpSxS24V5JO4bs4IkwvtS7CxWfFLOlyYxWN9m/aC5t6H9Ee9JWliAqySst
	 k1r1XqEzE2BWw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Update DMABUF lifecycle docs after move_notify() rename
Date: Sun, 30 Aug 2026 15:31:49 +0300
Message-ID: <20260830-doc-p2p-move-v1-1-61a388620588@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260830-doc-p2p-move-05aad5de1ec1
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to=0D
dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA=0D
documentation pointing at move_notify(), a symbol that no longer=0D
exists. Readers grepping for it find nothing, and this is the only=0D
place in Documentation/ describing the revocation requirement.=0D
=0D
Name the current function and record that importers which cannot unmap=0D
within bounded time have to be rejected at attach time, which is what=0D
makes the synchronous unmap on remove() achievable.=0D
=0D
Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_inva=
lidate_mappings()")=0D
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>=0D
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 * Split from https://lore.kernel.org/all/20260825-document-dma-buf-v1-0-5e=
cfb3e1371c@nvidia.com=0D
---=0D
 Documentation/driver-api/pci/p2pdma.rst | 6 ++++--=0D
 1 file changed, 4 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver=
-api/pci/p2pdma.rst=0D
index d3f406cca694..63cff9e4d2c9 100644=0D
--- a/Documentation/driver-api/pci/p2pdma.rst=0D
+++ b/Documentation/driver-api/pci/p2pdma.rst=0D
@@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are =
known and the P2P subsyste=0D
 is used to determine the mapping type. The phys_addr_t-based DMA API is us=
ed to=0D
 establish the dma_addr_t.=0D
 =0D
-Lifecycle is controlled by DMABUF move_notify(). When the exporting driver=
 wants=0D
+Lifecycle is controlled by DMABUF revocation. When the exporting driver wa=
nts=0D
 to remove() it must deliver an invalidation shutdown to all DMABUF importi=
ng=0D
-drivers through move_notify() and synchronously DMA unmap all the MMIO.=0D
+drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap =
all=0D
+the MMIO. Importers unable to complete that unmap within bounded time have=
 to=0D
+be rejected when they attach, which dma_buf_attach_revocable() checks for.=
=0D
 =0D
 No importing driver can continue to have a DMA map to the MMIO after the=0D
 exporting driver has destroyed its p2p_provider.=0D
=0D
---=0D
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72=0D
change-id: 20260830-doc-p2p-move-05aad5de1ec1=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D
