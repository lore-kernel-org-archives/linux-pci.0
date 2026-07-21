Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F292D8376;
	Tue, 21 Jul 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659983; cv=none; b=UOo8ojaXe5KM0zusliNsdIt27DLqIr36LhMMkQUEiu5Z3nWnM7pzMHo7ZMy16ogd5rl/aS/0f+qQLMe64RrZHLur7joU0V5bOEDn2jEDNuys+asK4XVcET/GNBehyFsb16ClHF9/jAty7AzWNX7UUHOT8jF+x3hhgdheMk3ME7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659983; c=relaxed/simple;
	bh=6xbdLVxdh4HQJrGchJAstx3Cq8704KSa6qKVBkpMYUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8DUkRXZg9udkWKu2keFfEOHyvaixVpIF3F//OZc7N3q52JS6l1FfhXws60eCyLYeX1qwCr0Cnaep7TqA+R2837smzg4IGmn8ZqVmAGq6nne+a7PXrTythYAsPgcTJ/B8Y2hMQgrJKZ5/tyN/++jzNT/DZ2qiXdLxlrNKnF4/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYWNVhqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYWNVhqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771671F00A3A;
	Tue, 21 Jul 2026 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659982;
	bh=jMLxNPT+alN3B9d358mO+K91kmoDqoyAF9P1cZ9RVr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYWNVhqBZ/wCCKbxKgWojGthduYZlKb8YzS6t+6VwY1NE0XU530OA5B6pabktkVGe
	 KAU5pbZSgUuU/D/pg2NXJqFxaAft/6e6MryY7P6SeFiFNlwTEaFPe3O7yv95I2cGNP
	 8MCjywYcJ3HGaILSq/QUWXGsEbhRhXBDC3Z2O4xA+w18dVaEBLKj7cbynrzkrR4Fam
	 +kYmipw2mLYTvu13onPE47RkqF+vU5mF7wnQWTbLgQsrnk5dVrZ6SmhE1HJqkLqZ68
	 HE0kSxDIbfZEnJr7GGGBY6ILaTbyY8vlCjaPwVBpqUCgnEQ9B2LgA8ntbIW2k0Y11l
	 IU22Zjjlj39fQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Dan Williams <djbw@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev
Subject: [PATCH 1/2] mm: Add unmap_mapping_file() helper
Date: Tue, 21 Jul 2026 18:52:51 +0000
Message-ID: <20260721185252.1670958-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185252.1670958-1-kwilczynski@kernel.org>
References: <20260721185252.1670958-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, unmap_mapping_pages() and unmap_mapping_range() unmap
a page offset window of an address_space, and teardown paths such
as kernfs_drain_open_files() rely on them to remove the mappings
of a file that is going away.

Files with f_mapping swapped to a shared address space at open time,
such as PCI resource files using iomem_get_mapping(), have their
VMAs attached to the shared mapping instead of the file's own inode
mapping, so a teardown that unmaps the inode's address space cannot
reach them, and they stay live after the file is removed.  As such,
the only correct discriminator for these VMAs is the originating
struct file recorded in vma->vm_file.

Add unmap_mapping_file(), which walks the VMA interval tree of the
file's f_mapping under i_mmap_lock_read() and zaps every VMA with
vm_file set to the given file, using the same per-VMA zap teardown
as unmap_mapping_pages().

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..e882a03eaddd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3183,6 +3183,7 @@ extern int fixup_user_fault(struct mm_struct *mm,
 			    bool *unlocked);
 void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows);
+void unmap_mapping_file(struct file *file);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
 #else
@@ -3203,6 +3204,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 }
 static inline void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows) { }
+static inline void unmap_mapping_file(struct file *file) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows) { }
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..f9cfb88ac4f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4423,6 +4423,32 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 }
 EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 
+/**
+ * unmap_mapping_file() - Unmap all mmaps of an open file.
+ * @file: The file to unmap.
+ *
+ * Unmap every VMA with vm_file set to @file, regardless of the address
+ * space it is attached to.  This also covers files with f_mapping
+ * swapped to a different address space at open time, since such VMAs
+ * cannot be found through the file's own inode mapping.
+ */
+void unmap_mapping_file(struct file *file)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct vm_area_struct *vma;
+
+	i_mmap_lock_read(mapping);
+	if (unlikely(mapping_mapped(mapping))) {
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, ULONG_MAX) {
+			if (vma->vm_file != file)
+				continue;
+			zap_vma(vma);
+		}
+	}
+	i_mmap_unlock_read(mapping);
+}
+EXPORT_SYMBOL_GPL(unmap_mapping_file);
+
 /**
  * unmap_mapping_range - unmap the portion of all mmaps in the specified
  * address_space corresponding to the specified byte range in the underlying
-- 
2.55.0

