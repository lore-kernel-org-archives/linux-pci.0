Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435B15539A;
	Fri,  8 May 2026 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215003; cv=none; b=rXcteunWh+uCes1QLQg1CM1ft04WXA9/Xcbq+i8wzQ39wM8uoIATUycSPhuUyNS+sN6EehBZ9+VtpJMldoQXeLQyMDz5pslzg4DCrDkz68RT6RzLGRrPlNJXSIv65VMcil8ujHWQvgfd9vTq0EJeQdkkdg9UP1I4A51FcwDtIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215003; c=relaxed/simple;
	bh=RvhmeHPggHFvnpvKsNMm4x+OKY6vAIZNY1FNS7XUoxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Odq4qUvYP5zo52tXbqE2UYDtt2V+whTSVHNoISi5Yr6z2JOqO5TXGTj3i98HgXIoHFY/fccHHcDLwPe5HHvAyejtnAyQ3n2ZdnL/DXrtXn28ZDSaeU1Ey1Mvu7VSxfgyUAX6gL+YhYBeptbeRLyFXFkRxSmmkpfZQQJwHV+8kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6HBL0pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6HBL0pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF0C2BCB4;
	Fri,  8 May 2026 04:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215003;
	bh=RvhmeHPggHFvnpvKsNMm4x+OKY6vAIZNY1FNS7XUoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6HBL0pinAWktnoLCLexrXMErdJxfRI3rqc0tRU23vmwpMZG2iZWBFQiawvwdama7
	 invyEx99A5op8QyhD40MMD/JRw1YfS5fMjapZ3HM3cThGZ00Xf9h4l4VV57lK4Vi78
	 IS83/FicH4dpT7UBDUCjWXj2F+ANaJ82RldQ1UUqAzJq25dtHOv7RqTfeABdNoZ+cb
	 0UFEA5Irs8HN0SSZO3odQp/QJ1wtZZCG0QaqnigEJFbnjrs+AhxM7LLVw2av/xWfJu
	 YDIflHsAtCCxTMFzyXtuNCKBsL6scKYhv8VYhRgR4rj/2L50xgbv1v8Tn3jBvOuCzr
	 W4DsRyW/AmuzA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
Date: Fri,  8 May 2026 04:35:34 +0000
Message-ID: <20260508043543.217179-16-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the WARN() that fires when userspace attempts to mmap beyond
the BAR bounds.  The check still returns 0 to reject the mapping,
but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..a8dade7d084b 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -48,13 +48,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int num,
 	start = vma->vm_pgoff;
 	size = ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
 
-	if (start < size && size - start >= nr)
-		return 1;
-	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on %s BAR %d "
-		"(size 0x%08lx)\n",
-		current->comm, sparse ? " sparse" : "", start, start + nr,
-		pci_name(pdev), num, size);
-	return 0;
+	return start < size && size - start >= nr;
 }
 
 /**
@@ -259,7 +253,7 @@ int pci_create_resource_files(struct pci_dev *pdev)
 
 static int __legacy_mmap_fits(struct pci_controller *hose,
 			      struct vm_area_struct *vma,
-			      unsigned long res_size, int sparse)
+			      unsigned long res_size)
 {
 	unsigned long nr, start, size;
 
@@ -267,13 +261,7 @@ static int __legacy_mmap_fits(struct pci_controller *hose,
 	start = vma->vm_pgoff;
 	size = ((res_size - 1) >> PAGE_SHIFT) + 1;
 
-	if (start < size && size - start >= nr)
-		return 1;
-	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on hose %d "
-		"(size 0x%08lx)\n",
-		current->comm, sparse ? " sparse" : "", start, start + nr,
-		hose->index, size);
-	return 0;
+	return start < size && size - start >= nr;
 }
 
 static inline int has_sparse(struct pci_controller *hose,
@@ -296,7 +284,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 
 	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
 						 bus->legacy_io->size;
-	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
+	if (!__legacy_mmap_fits(hose, vma, res_size))
 		return -EINVAL;
 
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
-- 
2.54.0

