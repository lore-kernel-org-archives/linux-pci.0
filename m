Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2231B80D;
	Fri, 19 Jun 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859198; cv=none; b=eIFMVOh7LiyLpEmw0bwq7zp+GKW0iukxyC2uEtVSDmwm57hRyo0YypHH0A+O4CsA87J/7vaPTJq8wM5vJNugs0stBbUDS8YhxnnEnzG4p0dtOeJPTgzy0CE3TrxAWP5IM+6nOXPpgbFAP305Fr0quv1+xnZmOqTW75UPa6uciow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859198; c=relaxed/simple;
	bh=9nsneCVwEGuN6oQPt/2KSesL4c+Du9HSg08gFDKOmxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u66J+8HzgqQBIqr+MkYISUjpu4u1tzgV14htSTD4QM6/z8reitP2A0H1rZ8ooGi7FskYFJMJcvRRO5AgDdn/GhZTcHyCF9QgrxBbq5F1adcZpMY1oT+0oYovnN6oYj1oLh2p7RuqNDWHS5+0JGM4P6cndW9NXfnzlk94e7hOB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPnZvpxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPnZvpxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD481F00A3A;
	Fri, 19 Jun 2026 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859197;
	bh=OD/K6TYwB6VdvSorvIdmiNjHyV31bpjL+a9MaOCS49I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPnZvpxYsWFr3rnk5L32yO8HYtKAsK9nDXcmtPbu+MdHKCtypFslNgrP4uRW778Y6
	 lCj4T1rGsej83Mvin/yJOkpjbiVh+c8rZ9sZ4Z9+e5rxJwLfh1YGmjUiXW4EkhH3UU
	 JFyD0yN8rsWHl/fvRCaay5HFYo+yil6tW/i3BoSHdp4LmeskaizOl753pBp5wb5Wk0
	 7qt/3uTvUbItEolF4wlZvVcEmKOuVEB425pLJPYh+dRdaH5uxnL+UElvrX1Yz8lMbl
	 +L1vEDQCjNmMYzRrGxd9HGhoxIM2bf79ZICu4ZNbV85IdQV0ZJ9ZnBbyQUUDAtcXJ+
	 GCGmYY+W84Vgg==
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
Subject: [PATCH v8 20/25] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri, 19 Jun 2026 08:51:55 +0000
Message-ID: <20260619085200.3729431-21-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly using PCI_LEGACY_MEM_SIZE (0x100000) and
PCI_LEGACY_IO_SIZE (0xffff) macros, and shift by 5 bits for sparse
systems.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index ae448a2e40c5..74c9145e0253 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -173,8 +173,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(vma, res_size))
 		return -EINVAL;
 
-- 
2.54.0

