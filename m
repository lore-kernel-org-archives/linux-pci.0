Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A218FDBD;
	Fri, 19 Jun 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859176; cv=none; b=ZLr78aDbcC9co/G7793jM4kREJzkFivQIvx4+x8wXVghvE/AUlP/dEijGuGkLqHGHF+fsYCOtCW03N4wAAE2FTvIJRl25Ir9B5kpOc2nx1oxhEMEQzuHNXSHorB5V6OhdPKDy9H3YBf4j1qlkVHwO2HBZT6Nlw/tBeQFcQaqRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859176; c=relaxed/simple;
	bh=4JWGb0h1kPyv8PmHZcxIucA20RtT8+EdLkS2uS/1Kn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZoaNUA57ei9cOIsUuGypdI5Icptd4tnJSrYNkzC8PDVpts/+dUfi7kAbcpVPTNNaIRMPtm7f8amQqU+MgZSE6FLRJVoD8/O3HkfctwXa41PLFYcEEjW6ZSGvFs6YRYSvfOIr63RrycPvhNUwthIdKBXu2MdnrKg31z5FA6AQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwc1jwvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwc1jwvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927341F000E9;
	Fri, 19 Jun 2026 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859175;
	bh=P3BNww0MIQWHgiDqm6I3OydM0AXlT2dwxg9N+aqoSvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hwc1jwvYHPp6vWYxt56G+85Za1i8S+y17Eh7vdimb4eH2mD0rMV7veUCOqDw4l1sa
	 8orRl2QsApQt9pnuhNCN9G/sjkP1A1YUYCYJLf2NrTKq2yRRcEbDfCXsm+dLq4EIXY
	 bIJ4ui8Aq4GZxxD8dBhHCxJ3ATkjNgwiQHO48YOJVsA3xmYb0RUmRr39/1SpXPgCXO
	 vBXt/JHQ5FE83R3MVp7LTEazID3kiR9omAi2AhN3y5UGmIiNtVEs7WfYX687KfPrP1
	 1gJ2QQ+D6gtYIvm3UAG28kVv0Km6Pk0pJBSyVOsmqSWyw1Up18mnGxioBHiNCFWX2E
	 +IwTUGqUgMtRQ==
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
Subject: [PATCH v8 14/25] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Fri, 19 Jun 2026 08:51:49 +0000
Message-ID: <20260619085200.3729431-15-kwilczynski@kernel.org>
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

Currently, __pci_mmap_fits() computes the BAR size using
pci_resource_len() - 1, which wraps to a large value when the
BAR length is zero, causing the bounds check to incorrectly
succeed.

Thus, add an early return for empty resources.

Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 5c29f1d2821c..8802f955256e 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -37,12 +37,16 @@ static int hose_mmap_page_range(struct pci_controller *hose,
 static int __pci_mmap_fits(struct pci_dev *pdev, int num,
 			   struct vm_area_struct *vma, int sparse)
 {
+	resource_size_t len = pci_resource_len(pdev, num);
 	unsigned long nr, start, size;
 	int shift = sparse ? 5 : 0;
 
+	if (!len)
+		return 0;
+
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
-	size = ((pci_resource_len(pdev, num) - 1) >> (PAGE_SHIFT - shift)) + 1;
+	size = ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
 
 	if (start < size && size - start >= nr)
 		return 1;
-- 
2.54.0

