Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971904A3861;
	Tue,  6 Oct 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315431; cv=none; b=olGJqn5Pu+4U95I+neddpXAstTI6sFXEOt76a2EMPq0r5OgT7vsbqisRZPKQGmuX66eP+S1YXABrnRNdsbUsU69exCuxsC3o2VH9FzAwBA6tyOo28gUvir7Y8ZazFl0wAy3XNyj0MIJPixCG+lT+JKjSOpHnW45Cv2CTOAJtBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315431; c=relaxed/simple;
	bh=owNLFkvjKUOuGLpd5zV0qxNLjjfTsowGKS9KEULJYi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCla/BGBkp/jU2nYsqqDbbWFihfMuINN6vXxxuuBhwqFkfNLnlRHMgDAghSGFSVOcNNTilGEQpqX1Lzi3VG+9yGsY1vVgQA+6Gf+H6Gki41I/YN5FFa1Q6Hj9W0T83kW/Ct6+/F+klNgrDAkNOcLeTApUdoTTigH9fFMXpkmQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=MqwFrd4z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="MqwFrd4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791315427;
	bh=8rxvgEeZLcfza+wwmpRgXHZUwfgaEsmAZYNjZh3wgsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqwFrd4zL2G0LfPUE1Asrb6uRzOmYqKjYc3zSlDkw9wiDOrzPbXpmxZWU11M9QIQA
	 qx/XuuAmmCi4IN7z66sPcT9NIDxmAv+DKxafEcgyoYpBi54JnAL5CpmcYi+kt83eDm
	 Vk/9gCQDBK88s4RdP4HBjp4MVv9ChcD8yZoPtDpZQuhOezEt2ahHtrMV/lipsyxgfW
	 BNTgZHpG8dZIG8ro76xG/UPBj5Kwh/KShTnmaMhS9etU/k2JyR03FI6YhVLts9SBYq
	 BB1mdv9lsZheYtIIVQ/jTtx1rx3PlYyIDhVVxkxcbrYrciNpSFe3T/LqzYVzQqLWcX
	 Q84PUX+ZUKLQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmjb2bdMz4wJS;
	Wed, 07 Oct 2026 06:37:07 +1100 (AEDT)
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
Subject: [PATCH v8 3/9] dma-buf: Provide dma_buf_set_name()
Date: Tue,  6 Oct 2026 20:36:31 +0100
Message-ID: <20261006193643.76330-4-matt@ozlabs.org>
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

Allow exporters to set the name of buffers, during export or for
subsequent updates.  This is useful to express buffer-specific debug
information, indicate state particular to the exporter's usage, etc.
Only exporters and userspace are expected to set names; it isn't
sensible for importers to do it.

Originally, the static dma_buf_set_name() was used for
DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
this function as a generic set-name helper, taking a kernel-allocated
string.  The SET_NAME ioctls now locally duplicate the __user string,
and use the new function to set the name.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/dma-buf/dma-buf.c | 84 +++++++++++++++++++++++++--------------
 include/linux/dma-buf.h   | 16 +++++---
 2 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 4c9add51f9ef..b99da4ff2ef6 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -404,34 +404,6 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	return events;
 }
 
-/**
- * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
- * It could support changing the name of the dma-buf if the same
- * piece of memory is used for multiple purpose between different devices.
- *
- * @dmabuf: [in]     dmabuf buffer that will be renamed.
- * @buf:    [in]     A piece of userspace memory that contains the name of
- *                   the dma-buf.
- *
- * Returns 0 on success. If the dma-buf buffer is already attached to
- * devices, return -EBUSY.
- *
- */
-static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
-{
-	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
-
-	if (IS_ERR(name))
-		return PTR_ERR(name);
-
-	spin_lock(&dmabuf->name_lock);
-	kfree(dmabuf->name);
-	dmabuf->name = name;
-	spin_unlock(&dmabuf->name_lock);
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_SYNC_FILE)
 static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
 				     void __user *user_data)
@@ -577,8 +549,19 @@ static long dma_buf_ioctl(struct file *file,
 		return ret;
 
 	case DMA_BUF_SET_NAME_A:
-	case DMA_BUF_SET_NAME_B:
-		return dma_buf_set_name(dmabuf, (const char __user *)arg);
+	case DMA_BUF_SET_NAME_B: {
+		char *name = strndup_user((const char __user *)arg,
+					  DMA_BUF_NAME_LEN);
+
+		if (IS_ERR(name))
+			return PTR_ERR(name);
+
+		ret = dma_buf_set_name(dmabuf, name);
+		if (ret)
+			kfree(name);
+
+		return ret;
+	}
 
 #if IS_ENABLED(CONFIG_SYNC_FILE)
 	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
@@ -874,6 +857,42 @@ void dma_buf_put(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
+/**
+ * dma_buf_set_name - Set a dmabuf's name
+ * @dmabuf: [in]     dmabuf buffer that will be renamed.
+ * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
+ *                   similar.  This takes ownership of the allocation
+ *                   on success, which will be kfree()d when the
+ *                   dmabuf is released or a new name assigned.
+ *
+ * Intended to be used by the exporter to set a name for debug
+ * purposes.  This can also change an existing name if the same piece
+ * of memory is used for multiple purposes over time.  Importers
+ * should NOT use this function to overwrite the name.
+ *
+ * Return: 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
+ * name (including terminator) exceeds DMA_BUF_NAME_LEN.
+ */
+int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
+{
+	if (!name)
+		return -EINVAL;
+
+	/* dmabuffs_dname() won't use the string if the length
+	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
+	 */
+	if (strlen(name) >= DMA_BUF_NAME_LEN)
+		return -E2BIG;
+
+	spin_lock(&dmabuf->name_lock);
+	kfree(dmabuf->name);
+	dmabuf->name = name;
+	spin_unlock(&dmabuf->name_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
+
 static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 {
 	struct scatterlist *to_sg, *from_sg;
@@ -1004,6 +1023,11 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *    functions:
  *
  *     - dma_buf_invalidate_mappings()
+ *
+ * 4. Exporters must not hold the dma-buf reservation lock when calling these
+ *    functions:
+ *
+ *     - dma_buf_set_name()
  */
 
 /**
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..0f88132c0654 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -342,12 +342,14 @@ struct dma_buf {
 	/**
 	 * @name:
 	 *
-	 * Userspace-provided name. Default value is NULL. If not NULL,
-	 * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
-	 * char. Useful for accounting and debugging. Read/Write accesses
-	 * are protected by @name_lock
-	 *
-	 * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
+	 * Exporter or userspace-provided name. Default value is
+	 * NULL. If not NULL, length cannot be longer than
+	 * DMA_BUF_NAME_LEN, including NIL char. Useful for accounting
+	 * and debugging. Read/Write accesses are protected by
+	 * @name_lock
+	 *
+	 * See dma_buf_set_name(), and the IOCTLs DMA_BUF_SET_NAME or
+	 * DMA_BUF_SET_NAME_A/B
 	 */
 	const char *name;
 
@@ -571,6 +573,8 @@ void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
+int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
+
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 					enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
-- 
2.47.3

