Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA6363C51;
	Sat, 25 Jul 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013559; cv=none; b=UKnaGHii/B4WUjzhvv2NgDOjF+8GQOYPF6vji2H54sY2e1QFyP8Gn9IACOGL4FUnhwWc0Fm2a+XVol9r+AbVIhfCuBMwyXw84Ai/+VtobLgppZ62g27V1mRpzL/TTTQeCoXbf4WHZHG/++hRkKa2gKAsyxjhGXVFZP0lSkXPRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013559; c=relaxed/simple;
	bh=KCZ71eFyhqdXsZYLGi8TRgrLuGEB7zdkr0KA/R9qL9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQsYeG9/SVSQg1Kg7Eej8Y48N9WLeld10js0+oi9WS3r7wW5XL2cFexupoG6Hs3UHidPZKrfiNShsf6a7DblAKpAeDhXjkzvkLcmccCCcH27laikKYzJjee6f7ZS7/dHgs96CvG2v7FAxyAfxCsMHqAsQ3Qb+U1Gn9ZRznx9QFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhWkmOY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhWkmOY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A395F1F00A3A;
	Sat, 25 Jul 2026 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013558;
	bh=RSa+weKwTyM0tp9L5Vf4KtyDgEuS9BC6cM9EMAxoRr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AhWkmOY/Nt9hXs0PlFDC/LdXs3RyB/46uNC3kLVqCNpDb2QuE175EsdNmAHSSfBtg
	 XcVtmxd/7eyenYWRqZac3QyWpgaT07s0i9i+tvpC8UkVIu4BgKp433wV95gIRGJLpM
	 YjgLVHk2FxsFR1zTC2WGcomHmhfqbqDbDm6VuZK3UTH3nfiMrgv8HxUcP30V7/sdQZ
	 pWeNalEdqSEybche3/DHuKeTZ59gqvf7xyIB31mhCnU0OKQ2E48Rl8Ue5xVK8STMR7
	 1UvetkXS9bfvzTVKUckrGaJ4C8eekChSPPZTVXvz6JHLcquiWj7iYughAE/NCbZdM/
	 T9x/oOfMw20jQ==
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
	Baoquan He <baoquan.he@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kexec@lists.infradead.org,
	driver-core@lists.linux.dev
Subject: [PATCH v2 1/3] mm: Add unmap_mapping_file() helper
Date: Sat, 25 Jul 2026 21:05:47 +0000
Message-ID: <20260725210549.3716546-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725210549.3716546-1-kwilczynski@kernel.org>
References: <20260725210549.3716546-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, unmap_mapping_pages() and unmap_mapping_range() unmap a
page offset window of an address_space, and code that removes a file,
such as kernfs_drain_open_files(), relies on them to unmap the pages
of a file that is going away.

Files with f_mapping swapped to a shared address space at open time,
such as PCI resource files using iomem_get_mapping(), have their VMAs
attached to the shared mapping instead of the file's own inode mapping,
so unmapping the inode's address space cannot reach them, and they stay
live after the file is removed.  These VMAs can only be selected by the
struct file they were created through, which is recorded in
vma->vm_file.

Thus, add unmap_mapping_file(), which walks the VMA interval tree of the
file's f_mapping under i_mmap_lock_read() and unmaps the pages of the
VMAs selected by should_zap_file_vma(), using the same per-VMA zap as
unmap_mapping_pages().  When f_mapping is the file's own inode mapping,
every VMA is zapped, as unmap_mapping_range() does today.  When f_mapping
was swapped, only the VMAs with vm_file set to that file are zapped, so
callers do not need to tell the two apart.

HugeTLB VMAs are skipped with a WARN_ON_ONCE(), as zapping those takes
i_mmap_rwsem for write in hugetlb_zap_begin() and would deadlock against
the read lock held over the walk.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index ff338c2abe92..4a09d7b6aa6b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4423,6 +4423,54 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 }
 EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 
+static inline bool should_zap_file_vma(struct file *file,
+				       struct vm_area_struct *vma)
+{
+	/* On the file's own inode mapping, zap every VMA */
+	if (file->f_mapping == file_inode(file)->i_mapping)
+		return true;
+
+	/* A swapped mapping also holds VMAs of unrelated files, zap only ours */
+	return vma->vm_file == file;
+}
+
+/**
+ * unmap_mapping_file() - Unmap folios from all mmaps of a file.
+ * @file: The file to unmap.
+ *
+ * Unmap the folios of @file from every process that has them mapped.
+ *
+ * If f_mapping is the file's own inode mapping, they are unmapped
+ * from every VMA on that mapping, as unmap_mapping_range() would do.
+ *
+ * However, if f_mapping was swapped to a different address space at
+ * open time, only the VMAs with vm_file set to @file are considered,
+ * since that address space also holds mappings of unrelated files.
+ *
+ * Must not be used on HugeTLB files.  HugeTLB VMAs are skipped with
+ * a warning.
+ */
+void unmap_mapping_file(struct file *file)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct vm_area_struct *vma;
+
+	i_mmap_lock_read(mapping);
+	if (unlikely(mapping_mapped(mapping))) {
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, ULONG_MAX) {
+			cond_resched();
+
+			if (!should_zap_file_vma(file, vma))
+				continue;
+			/* Zapping HugeTLB VMAs needs i_mmap_rwsem held for write */
+			if (WARN_ON_ONCE(is_vm_hugetlb_page(vma)))
+				continue;
+			zap_vma(vma);
+		}
+	}
+	i_mmap_unlock_read(mapping);
+}
+
 /**
  * unmap_mapping_range - unmap the portion of all mmaps in the specified
  * address_space corresponding to the specified byte range in the underlying
-- 
2.55.0

