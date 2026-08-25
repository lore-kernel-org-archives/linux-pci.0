Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C73C415E;
	Tue, 25 Aug 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639300; cv=none; b=SGqI80eLVWIoIjBnnGQB1oULZ5jSX1C1WDTCP+MA9pQK21pdnztQKC6Z3loP28b0Rw08Lnh8ZGsLIgTbsM3Sp5xwpk2jMZNXiAZ6aypl0hQH7IgMfHkpTSN+4MaorCp86jH7HuTaJDDuWfAhbJ7LDtH7akR6OmGsznRlAPv22k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639300; c=relaxed/simple;
	bh=jjVC3JP04upbBzoUSKnY3KZu4HU3ytMl8vbRsWmCelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEGXQ84vp/htlE3qG7ZHl2ggpCq1xSVtB9eNjjvfijm36ICyz9HG2Zwljdn0x8lAP8/8qALrIrzaHFfFMpZ+6SsEvZXeOIGl83t6Es5+6gNoYhKRISdtD8ZRAIW87zET+uPzcCeK3oC11AIvo6T8mBw9FAaC61QTJxxzyfegzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfvz7Clp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfvz7Clp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7615A1F00A3D;
	Tue, 25 Aug 2026 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639299;
	bh=BlwleWV/uM78vI5MbKrNh1IKsiWkE1YcBR3cR0ULuII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cfvz7ClpCAD61o+H9Atbd0uGg30z/IpJ8LlnLu14wyAoZiNHUBG1icdvaAaAYxptw
	 2CJARgbZSPfi8Ehha3VRkwwkYReESDCltPOSYZr0WajgziSPjP1DMQqhKvsWO0zAnS
	 muoI8uPsaFPWCMTqXZ3x4JNEkc5Bz9xUiQv/Gx3jaI7sxpjt9e3pm1oo/cNVTliPPj
	 iUU5ncCKB4qW3smQxLMzC18xb+VbApbaAsOJrAom04h6vaO2dXcwdo1kQW5KDTOeLt
	 Hflr6CdcQes0Jgl91GTjUPzysWIJezSJNnLKg1F4AbwRGCxhZYXXvljBzbx6fNm3Pn
	 kV5qiL+fetkVQ==
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
Subject: [PATCH 2/2] dma-buf: Document how exporters and importers agree on mapping lifetime
Date: Tue, 25 Aug 2026 09:28:02 +0300
Message-ID: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
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

Pinned, revoked and movable mappings are selected by which optional
callbacks each side implements and by whether dma_buf_pin() succeeds,
not by any flag or enum. Nothing in Documentation/ says so, and the
rules are spread over the kdoc of dma_buf_ops.pin,
dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
so a driver author has to know the symbol names before finding them.

Name, per flow, the callbacks both sides have to implement to end up in
it, describe dma_buf_pin() as the runtime negotiation, and record that
the pin is what tells a revoke from a move.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/driver-api/dma-buf.rst |  6 +++
 drivers/dma-buf/dma-buf.c            | 85 +++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 2f36c21d9948..39c201f38aa6 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
 .. kernel-doc:: drivers/dma-buf/dma-buf.c
    :doc: dma buf device access
 
+Mapping Lifetime Negotiation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/dma-buf/dma-buf.c
+   :doc: mapping lifetime negotiation
+
 CPU Access to DMA Buffer Objects
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..30afec7365bc 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size, int flags)
  *    reference acquired with dma_buf_get() by calling dma_buf_put().
  *
  * For the detailed semantics exporters are expected to implement see
- * &dma_buf_ops.
+ * &dma_buf_ops. Whether the exporter may still move or destroy the backing
+ * storage after step 3 depends on what exporter and importer implement, see
+ * the mapping lifetime negotiation section below.
+ */
+
+/**
+ * DOC: mapping lifetime negotiation
+ *
+ * No flag or enum says whether the exporter may move or take away the backing
+ * storage while an importer holds a mapping. Each side implements a set of
+ * optional callbacks, and dma_buf_pin() settles the result at runtime. Three
+ * flows come out of it:
+ *
+ * - Pinned: the storage never moves and is never taken away.
+ * - Revoked: the storage never moves, but the exporter may take it away.
+ * - Movable: the exporter may relocate the storage at any time.
+ *
+ * Every exporter implements &dma_buf_ops.map_dma_buf,
+ * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release. dma_buf_export()
+ * rejects an exporter missing any of them.
+ *
+ * An importer reaches its flow like this:
+ *
+ * 1. Attach with dma_buf_dynamic_attach(). Leaving
+ *    &dma_buf_attach_ops.invalidate_mappings NULL rules out everything but the
+ *    pinned flow, because the importer can then never be told anything.
+ * 2. Call dma_buf_pin() under the reservation lock.
+ * 3. On failure run the movable flow, or give up.
+ * 4. On success the storage stays put. Whether the exporter may still take it
+ *    away, which makes this the revoked flow instead of the pinned one, is the
+ *    exporter's choice and is not reported back.
+ *
+ * dma_buf_attach() is the shorthand for an importer which only ever wants the
+ * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then pins around
+ * every dma_buf_map_attachment() and waits for the DMA_RESV_USAGE_KERNEL
+ * fences on the importer's behalf. Peer to peer needs
+ * dma_buf_dynamic_attach(), because &dma_buf_attach_ops.allow_peer2peer lives
+ * in the attach ops.
+ *
+ * Pinned flow:
+ *
+ * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold the
+ *   storage still on request. An exporter whose storage never moves implements
+ *   neither, and dma_buf_pin() then succeeds on its own. An exporter which
+ *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
+ * - Importer: nothing more. The mapping stays valid until it unmaps.
+ *
+ * Revoked flow:
+ *
+ * - Exporter: answer dma_buf_pin() as above. Call
+ *   dma_buf_invalidate_mappings() when the storage goes away and fail
+ *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which complete a
+ *   revocation are described in dma_buf_invalidate_mappings().
+ * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within
+ *   bounded time and drop the pin.
+ *
+ * Movable flow:
+ *
+ * - Exporter: call dma_buf_invalidate_mappings() before each move, then wait
+ *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin play
+ *   no part here.
+ * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops the
+ *   cached mapping and has to lead to dma_buf_unmap_attachment() within
+ *   bounded time. It need not stop the hardware, because access runs until the
+ *   importer's &dma_buf.resv fences retire. Map again before the next DMA.
+ *
+ * The pin tells a revoke from a move.
+ * &dma_buf_attach_ops.invalidate_mappings carries no reason, and both flows
+ * ask for the same unmap. An importer holding a pin can only be seeing a
+ * revoke, because the exporter promised not to move. An importer without a pin
+ * treats every call as a move and maps again.
+ *
+ * A revoke need not be forever. An exporter revoking around a temporary loss
+ * of access takes mappings again afterwards. Giving up for good is the
+ * importer's own choice, so an exporter must not wait for one to come back.
+ *
+ * &dma_buf_ops.attach is the only place where an exporter can turn an importer
+ * away. An exporter which revokes rejects the importers for which
+ * dma_buf_attach_revocable() returns false. An exporter of memory without
+ * struct page rejects the importers which left
+ * &dma_buf_attach_ops.allow_peer2peer clear.
+ *
+ * Userspace sees none of this. The two drivers negotiate the flow between
+ * themselves, and the DMA-buf file descriptor shows no trace of the result.
  */
 
 /**

-- 
2.55.0

