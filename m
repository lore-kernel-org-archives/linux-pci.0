Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782369;
	b=WAcXtD8YkzvVIEKHdk/Onkw15VCUQkZuoNHYW7euPevK/8/YHsKzV44EqXcA2WAOh/Bw
	 lrAR7qp0eKJ8e63N0RW4DavVWHTEJoXahriMkLLtnntxWOxtdThYpfMhM1Dja0SoGvUzr
	 ZBoWY3NWVMlmIhU2CvgrfwKAgXNZQCKAIDV1dWfvIoUIXZ88L/3DALOvwh61gaoA19RAR
	 cynCxBp03r4P9rKUuomPnNgssr6ixUWuYzZdZzgk2jkH03MdRaqRmxL5iPIW1xL0F1UOP
	 j5INdEgcUeGvOhoa0I9ZMiSMRSE033TwEkz2W4l43d7QxZMLA8bJegN2RYSzBJhIJ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=75kKPzvsdMlgmlPcHulcGoHaZEGP7r10gYVkY3tBkZo=;
	b=OcL58An0qQaEn7TrVbHS5Bu3gqLXdc7UiYR2NR67tCCQHMWSmijPO9KcAcERXdm0DGUB
	 g7XpKC4w88AR+lGCzWTZwHpXWh6dhoxHu5/sV+mtqjPmeynXfruoOXDn5H+Fv4qxRQOqi
	 9gUz83O7WsmK57+aqEnjyZODx5yACyQ39yP9Ufru2UKLZ8B2VjXFuef2wmA1w2pum90ti
	 b51YM8K5gZD19ucZggv74jtv3cFesmFmDvV6BPbJPgb1IiYzq++9FyNI4uaC1VCy2ueh3
	 zXWeWByqPrds/MHxrQRvdJ8cYyzE43h5pmQt9sXMmj6iCfcCOHw2LvzTunj+sJx9hDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8QpTmvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80C606A339;
	Fri, 27 Nov 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8QpTmvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136911F0089A;
	Fri, 27 Nov 2026 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782368;
	bh=75kKPzvsdMlgmlPcHulcGoHaZEGP7r10gYVkY3tBkZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8QpTmvZiK0wxgukaP82PoaUJV9KSkEPe8hR9/n0t45x0yoja6sGvUlEKdXYd94H9
	 cBYtfJaP7iOIcee8+9eETlZ/Gmqj9ijRoN1j9/PE5Xx5OoqT+SHNtmcDpz6+meH1qx
	 JXfxFtV6NcGPCT38HRmFKBnny+8kTBGa2ce+0AszmskMfLGqt/r+mdtmfnbkINb1Xh
	 WC5b3ykpU6M8mNrY+veveaaOqPJFnlt2bWyEWGej+lBoEyxQMZrSmpL8HXyLt5ApzA
	 gnmEecpZ4JThgjK1qM6II+l7qeNwwBoyIVBrw3nDZXXsJS08LvqwF3RjLmRTz9rz+U
	 QYAYHjfLIafEA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/6] kho: don't reference subtree blobs as FDTs
Date: Fri, 27 Nov 2026 12:25:32 +0000
Message-ID: <20261127122536.3708770-7-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

KHO started out with using FDT for all subtrees. This is why debugfs
used "sub_fdts" as the directory name and in the code. Since then, KHO
subtrees started also using raw C structs for serialization. Commit
4916ae386760 ("kho: rename fdt parameter to blob in
kho_add/remove_subtree()") updated some of the code to match this
reality.

Still, references to sub FDTs were left around. The data structure to
track the blobs is still called fdt_debugfs, the list of blobs is called
"fdt_list", and most importantly, the subdirectory holding them in
debugfs is called "sub_fdts".

Update all this to use blob in the naming.

The only functional change is the rename of the debugfs subdirectory
from "sub_fdts" to "sub_blobs". Everything else is a pure rename.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kho_debugfs.c  | 50 ++++++++++++++++----------------
 kernel/liveupdate/kho_internal.h |  4 +--
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/liveupdate/kho_debugfs.c b/kernel/liveupdate/kho_debugfs.c
index 8d04368c1978..1580e1a27566 100644
--- a/kernel/liveupdate/kho_debugfs.c
+++ b/kernel/liveupdate/kho_debugfs.c
@@ -17,7 +17,7 @@
 
 static struct dentry *debugfs_root;
 
-struct fdt_debugfs {
+struct kho_debugfs_blob {
 	struct list_head list;
 	struct debugfs_blob_wrapper wrapper;
 	struct dentry *file;
@@ -27,24 +27,24 @@ static int __kho_debugfs_blob_add(struct list_head *list, struct dentry *dir,
 				  const char *name, const void *blob,
 				  size_t size)
 {
-	struct fdt_debugfs *f;
+	struct kho_debugfs_blob *b;
 	struct dentry *file;
 
-	f = kmalloc_obj(*f);
-	if (!f)
+	b = kmalloc_obj(*b);
+	if (!b)
 		return -ENOMEM;
 
-	f->wrapper.data = (void *)blob;
-	f->wrapper.size = size;
+	b->wrapper.data = (void *)blob;
+	b->wrapper.size = size;
 
-	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
+	file = debugfs_create_blob(name, 0400, dir, &b->wrapper);
 	if (IS_ERR(file)) {
-		kfree(f);
+		kfree(b);
 		return PTR_ERR(file);
 	}
 
-	f->file = file;
-	list_add(&f->list, list);
+	b->file = file;
+	list_add(&b->list, list);
 
 	return 0;
 }
@@ -57,20 +57,20 @@ int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
 	if (root)
 		dir = dbg->dir;
 	else
-		dir = dbg->sub_fdt_dir;
+		dir = dbg->sub_blob_dir;
 
-	return __kho_debugfs_blob_add(&dbg->fdt_list, dir, name, blob, size);
+	return __kho_debugfs_blob_add(&dbg->blob_list, dir, name, blob, size);
 }
 
 void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob)
 {
-	struct fdt_debugfs *ff;
+	struct kho_debugfs_blob *b;
 
-	list_for_each_entry(ff, &dbg->fdt_list, list) {
-		if (ff->wrapper.data == blob) {
-			debugfs_remove(ff->file);
-			list_del(&ff->list);
-			kfree(ff);
+	list_for_each_entry(b, &dbg->blob_list, list) {
+		if (b->wrapper.data == blob) {
+			debugfs_remove(b->file);
+			list_del(&b->list);
+			kfree(b);
 			break;
 		}
 	}
@@ -99,7 +99,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	struct dentry *dir;
 	int err;
 
-	INIT_LIST_HEAD(&dbg->fdt_list);
+	INIT_LIST_HEAD(&dbg->blob_list);
 
 	dir = debugfs_create_dir("in", debugfs_root);
 	if (IS_ERR(dir)) {
@@ -107,7 +107,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		goto err_out;
 	}
 
-	err = __kho_debugfs_blob_add(&dbg->fdt_list, dir, "fdt", fdt,
+	err = __kho_debugfs_blob_add(&dbg->blob_list, dir, "fdt", fdt,
 				     fdt_totalsize(fdt));
 	if (err)
 		goto err_rmdir;
@@ -131,16 +131,16 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 {
-	struct dentry *dir, *f, *sub_fdt_dir;
+	struct dentry *dir, *f, *sub_blob_dir;
 
-	INIT_LIST_HEAD(&dbg->fdt_list);
+	INIT_LIST_HEAD(&dbg->blob_list);
 
 	dir = debugfs_create_dir("out", debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
-	if (IS_ERR(sub_fdt_dir))
+	sub_blob_dir = debugfs_create_dir("sub_blobs", dir);
+	if (IS_ERR(sub_blob_dir))
 		goto err_rmdir;
 
 	f = debugfs_create_file("bootmem_phys", 0400, dir, NULL,
@@ -154,7 +154,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 		goto err_rmdir;
 
 	dbg->dir = dir;
-	dbg->sub_fdt_dir = sub_fdt_dir;
+	dbg->sub_blob_dir = sub_blob_dir;
 	return 0;
 
 err_rmdir:
diff --git a/kernel/liveupdate/kho_internal.h b/kernel/liveupdate/kho_internal.h
index 5b349f451cf6..22950fe3bcc8 100644
--- a/kernel/liveupdate/kho_internal.h
+++ b/kernel/liveupdate/kho_internal.h
@@ -11,8 +11,8 @@
 
 struct kho_debugfs {
 	struct dentry *dir;
-	struct dentry *sub_fdt_dir;
-	struct list_head fdt_list;
+	struct dentry *sub_blob_dir;
+	struct list_head blob_list;
 };
 
 #else
-- 
2.56.1.839.g22a8290db9-goog

