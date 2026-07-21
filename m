Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED003EEAE2;
	Tue, 21 Jul 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659987; cv=none; b=DT5C1nsGfkoODwxqpujKiqyTRFV3rVnx13IU0fSlXp8p7UqpmwqnRT17mZl1R2I7XbQEXwKEIhluU3tbJ2sG8L5entiynoklC/F/KIGpM+VVGACXKxj+9M9pBi4wZ4odrit3U874Dl4FXRxF3ILvBfSseeX5gPbRdwBkbmYyvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659987; c=relaxed/simple;
	bh=Lk+trxXxqNkM9iwyGCiBRhejc42JJCWEwkBtqZeIwrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiE3kRjHuCroVHmk1S/fRsgaSrg9rs9/qBd5x1ZySN59/K6dgqc9VxV4z2jR6FTYnyxAi916jCiBuUjTY+KxqDIcVuPwZKANTFOr0xXBYJ+g1FcNN9+/xk3Mq+zBiapBd0IE/wmAJMGPHeV47upyQkwltVrY/+y1FEm9jfW4a6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO2MpO3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO2MpO3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A782A1F00A3F;
	Tue, 21 Jul 2026 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659986;
	bh=x2fxgWVfhVcDmmyCVbD7ycsWuJeu20Oz3iI8akrC0uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mO2MpO3I7S2kPQkzxpVqQA6FmRmQugz1QqsWE72UVlYDgo/AAZZ3OfXbH547dVQ+M
	 Wu+6Js2Bk2J3tX4Po2gMlLLKtmQHJiPTQy+KW4s2ta2tRhd/V02Y/kMAVTz9ckWCzp
	 wAZPjIooxlViBjlEK/b+a3zem4aIDpOHiBuWrmbxJlTjFQeyPMY8hHahAbAOPn/Qvi
	 VGGZ3ELvNsvE4WaCL5pNc/Uv5SYZDZpsnHOAXMg5Q09j7Gzo2wpIO5hvL0Jl+iYN3o
	 88LhGLhGkN98oPXcp+Kmww1kHLtrGZS9mLlqENmhsX3K2u1jxZju60+KG6T3fondS4
	 WgF5NiFKPTplw==
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
Subject: [PATCH 2/2] kernfs: Unmap mmaps of removed files via file->f_mapping
Date: Tue, 21 Jul 2026 18:52:52 +0000
Message-ID: <20260721185252.1670958-3-kwilczynski@kernel.org>
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

Currently, kernfs_drain_open_files() unmaps file_inode(of->file)->i_mapping
when a node with mmapped open files is removed.  Since commit 636b21b50152
("PCI: Revoke mappings like devmem"), PCI resource and legacy sysfs files
swap their f_mapping to iomem_get_mapping() at open time, so their VMAs
are attached to the shared iomem address space, and the drain walks the
empty sysfs inode interval tree instead.

As a result, userspace mappings of PCI BARs survive device removal
and BAR resize, keeping stale PTEs into physical address space that
the kernel may have reassigned since.

Thus, use unmap_mapping_file() when the file's f_mapping no longer
points at its own inode mapping, so the drain zaps exactly the VMAs
created through the removed file, while unrelated mappings on the
shared address space are left intact.  Files with an unmodified inode
mapping keep the existing unmap_mapping_range() behaviour, and the
driver-claim revocation through revoke_iomem() is unaffected because
the VMAs stay on the shared mapping.

This restores the teardown behaviour these files had before the
f_mapping swap was introduced.  A read through a stale mapping
after removal now raises SIGBUS instead of returning stale data.

Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 fs/kernfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e0e90c93372..8d1e4acc6716 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -818,7 +818,10 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 		struct inode *inode = file_inode(of->file);
 
 		if (of->mmapped) {
-			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+			if (of->file->f_mapping != inode->i_mapping)
+				unmap_mapping_file(of->file);
+			else
+				unmap_mapping_range(inode->i_mapping, 0, 0, 1);
 			of->mmapped = false;
 			on->nr_mmapped--;
 		}
-- 
2.55.0

