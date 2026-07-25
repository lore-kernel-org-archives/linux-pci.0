Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB021327BFB;
	Sat, 25 Jul 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013564; cv=none; b=UqRTtDSWV9zajT7w0H1yIEdfRz2N7NYjrzJuASy0e5HwHfxQ/e0i8ohEMxmRC3Yzw5YOVXQwE44t6AmpJmoMdl+FyWthTwuvYuCL6pd/x+uDw69mwSFDFkc1IBrxw1Ny/6Q0VEn1eWh5DyHOG+dPkKEXPj6lYQ2xnHbjeSQoK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013564; c=relaxed/simple;
	bh=B5Pq9++XsW99sXcMbfjY10sI4MpaEJaAIafiFz1a9Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkXxwy/g08WX8MZB5RLIfTJxHIbMkUz7oFHtRDB2kNn7bQOlM9bu0Et9EkCRMkSzPRMireeqXl0BA9lqMxxvqv7sCj+sbDEGfGLOtPqKk2GrNaOkLwM/OOjuO8XtvBvJQy+nFDbKF6adOR7JdDZdgyLLMBhdNGOW+ByqBXtFc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx53A1oD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx53A1oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C41F01558;
	Sat, 25 Jul 2026 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013562;
	bh=aPa/LsrTp3hYJdTLzZYHVqwcc+ik3K0gwTpILC+a88c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qx53A1oDvALciaFuFZCSSzhSlAz/InNoUWnSh/Gm5zNnNDFwrP2ubUYudxorFmIZ8
	 7zEIFtByOjtavUSHsMvApD7vD4GBbbBZ01esE+wg5sPWNTKs/+gt2cyZMdOV+UfNyB
	 GhqmCpoYIW4VHpQkIkngfd7iRMJAUjiV4C9aM74c3W8vOj+ntcwdGTREkVPCVA6Avr
	 qHdaGVv0kn9+MfiHmWQe8iz/+hbFJUASZfScyxqob2Rx+S5IFMVrQfSrTNtueszMAu
	 vKdnfxeTOPtQVYJsZOHmXU20gLd2UcFmXX2j+Jf0km+iLaw1Y9SMUcfySmRzl1/sU7
	 qSLDsH6/40CsA==
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
Subject: [PATCH v2 2/3] kernfs: Unmap mmaps of removed files via file->f_mapping
Date: Sat, 25 Jul 2026 21:05:48 +0000
Message-ID: <20260725210549.3716546-3-kwilczynski@kernel.org>
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

Currently, kernfs_drain_open_files() unmaps the mapping of the sysfs
inode, file_inode(of->file)->i_mapping, when a node with mmapped open
files is removed.  Since commit 636b21b50152 ("PCI: Revoke mappings
like devmem"), PCI resource and legacy sysfs files swap their
f_mapping to iomem_get_mapping() at open time, so their VMAs are
attached to the shared iomem address space, which the drain never
unmaps.

As a result, userspace mappings of PCI BARs survive device removal
and BAR resize, keeping stale PTEs into physical address space that
the kernel may have reassigned since.

Thus, use unmap_mapping_file() for every open file, so that only the
VMAs of the node being removed are zapped, while unrelated mappings
are left intact.  The same helper also covers files without a swapped
f_mapping, and the driver-claim revocation through revoke_iomem() is
unaffected, as those VMAs remain on the shared address space.

This restores the behaviour these files had before the f_mapping swap
was introduced.  A read through a stale mapping after removal now
raises SIGBUS instead of returning stale data.

Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 fs/kernfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e0e90c93372..eb04439e9c3e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -815,10 +815,8 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	}
 
 	list_for_each_entry(of, &on->files, list) {
-		struct inode *inode = file_inode(of->file);
-
 		if (of->mmapped) {
-			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+			unmap_mapping_file(of->file);
 			of->mmapped = false;
 			on->nr_mmapped--;
 		}
-- 
2.55.0

