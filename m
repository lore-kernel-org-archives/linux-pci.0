Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0637CD54;
	Wed, 22 Apr 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874501; cv=none; b=XK6IhyKwqkk7CHDQpvE1uXkTLdQBhZbAVJnQeoLeA+VGfFUpvzFFiDNVsnc6Ieuxqjv9gWEF8dx2uERgq1OmtX8QFl1iqiqnQ1EY5x6RTCa/rXUIBP4QCkFJ5OXp3IbD5tyXeM2++xsy3EBfIHwqelT6TnqH4ENifq7fyWOvTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874501; c=relaxed/simple;
	bh=dkenDLAyAT+KiwXEFM4WIJAXbFTQKkHWTcI169/tbfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWWkN4eRXBnn1inhZJYWDLojCn01aAhpnM+FnM3btAr3PuQg4JvmuRY8BjuRyz5lju1vQXPLriDSj638BTT85ka38wXJEDwQr/txMo0Hq9NRR4THr833txJsRpuPjPq6mrdK3U6xRdIMKt/YJlZ+mwMEdg8ilCh/DHP5j14c9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrE1j7uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrE1j7uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D06BC2BCB4;
	Wed, 22 Apr 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874500;
	bh=dkenDLAyAT+KiwXEFM4WIJAXbFTQKkHWTcI169/tbfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrE1j7uyIswhjn2yhrQSx3VK/tgsSMYjSTaeOjMIf6xQaDlUfI/U2ig03JKGS0G73
	 3z72S4W+GaTnOdwG+Q6AtZKdOt1fowfIdzK0ctGVLkUu6ej1jsNtlvhfYyKSeBN4b1
	 GO0/sXri35yNoYsoLhmqaue3t5lYJeQqukI7z9COrJb3gbzUz0xZIsxu5UwPCGKX3a
	 UJg8HyWTzAUExXlkKb1DGD3EZtVZ+S71QT7V8aB5wxpPgAM4lRdrgGnSCo9eE8+hdG
	 dr3jT9Z90eVH8cCS/aKFoFaIfZi0J8oc95v6zs3ThvvkSSQCPzb6VUxnpm5pj+5/PG
	 DI1b/hxppuyBw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v6 14/24] alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
Date: Wed, 22 Apr 2026 16:13:57 +0000
Message-ID: <20260422161407.118748-15-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
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

