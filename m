Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10318FDBD;
	Fri, 19 Jun 2026 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859180; cv=none; b=rTzUj2H78UUKzNNrkY4ae4a02MFb12wdbYS6sLPl6itZQbUkcv8rMQZtWVv1clOFjAypM3do4XbB1brTwjQBcebOyNm309KH5F2XGaPS79m8eu7blE8hzhohKXy2g9goWL6S3VMQOsuSBXZH10TixTK/3Kle3sMmvd7l64to98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859180; c=relaxed/simple;
	bh=y99fN/cQKRyEYDWWCpQ2lVKoqoVdxi/AVPgsKPiAO0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHhtxXgyPyJcUej6fh0WFAv7QclBGuuTWmmc6CjZBR+eGagsCeJr5Qn7t0JzSl2UGnZzo3LuuwP8NU1LLL5BYnxHXKvU9XcRvypistIZKFgpYFnu0mmsW0WwGmsFYUz1hhtRIC4FTC33znJnE9Hs482LSalfifaDhetJABAr1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay+xccoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay+xccoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321D81F00A3D;
	Fri, 19 Jun 2026 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859179;
	bh=MeaEEnmBG3oFKgCGg6n5aGYQQrjBqtYm3M3kvW7MyfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ay+xccoWO5XnpgZk1oKZFJZZeGhQSJMAzeBZw+eAH5wtWwFtcm04l52kNpAlovzhk
	 h7RrSXfuwshrgk9JMSOa5gswG8TeTnxcou7rigMbDDeB0SW/Fnf+XQ7bMdoRUO7AzC
	 kH2oGAAgqooZoxxPQfdLaAyfJiBS8h0viAjuYG7lQF5/jboYz4oAG4UvIQ2OUt3ANw
	 AkF9pmG+SZqPyW7W7GSm24iHM2bIzzq5VWixm1DWtcPvzBT3U4Lup5r3WJSwvTI52R
	 cssdI3PSpGYUYYQ2UMqMyXxQ7Jye4oYOLxLPF17yTko7m+T8E2II4VjOZff1QPPDFw
	 d6houki/oEC5g==
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
Subject: [PATCH v8 15/25] alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
Date: Fri, 19 Jun 2026 08:51:50 +0000
Message-ID: <20260619085200.3729431-16-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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
 arch/alpha/kernel/pci-sysfs.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..6cf688621ea9 100644
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
@@ -257,9 +251,8 @@ int pci_create_resource_files(struct pci_dev *pdev)
 
 /* Legacy I/O bus mapping stuff. */
 
-static int __legacy_mmap_fits(struct pci_controller *hose,
-			      struct vm_area_struct *vma,
-			      unsigned long res_size, int sparse)
+static int __legacy_mmap_fits(struct vm_area_struct *vma,
+			      unsigned long res_size)
 {
 	unsigned long nr, start, size;
 
@@ -267,13 +260,7 @@ static int __legacy_mmap_fits(struct pci_controller *hose,
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
@@ -296,7 +283,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 
 	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
 						 bus->legacy_io->size;
-	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
+	if (!__legacy_mmap_fits(vma, res_size))
 		return -EINVAL;
 
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
-- 
2.54.0

