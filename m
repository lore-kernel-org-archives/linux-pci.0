Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27091191F91;
	Thu, 16 Apr 2026 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362518; cv=none; b=u1gv9O5NIHvZm7iANRWd2ajjSEjBWM52VLoafrIy7PoZ5NeCz1wANI8xEgs88nRmwizTvjHaCdVj7Xjmk6cX5Zielkh+7RUxSY52d0kzKq7qDS4xpvx4s7YuWRjdZs5XIV5n9ao17m2flliqpkxKvmNJkyP0ziNfpJY9j72enps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362518; c=relaxed/simple;
	bh=RnJpCjE7Q+Cz5gLfhuPI4aXF0NyoVhuEIoGAkwXA5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoX1kHceUtupJNqBnjqXx5+vh0ZDkj3Msd0mneS+lSLaUel19h3rT9qry5pZYO2dXBpweGYa/KBIsSVOwe544oIB/jBqc0oEtItMgs/UiC0zA7Pd7ARq+wlvrMXC0vwABUBPdcipf8F/QyVzpBzPWYu7+gARkoT6IynY7E0vS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxnW1p0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxnW1p0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A7FC2BCAF;
	Thu, 16 Apr 2026 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362517;
	bh=RnJpCjE7Q+Cz5gLfhuPI4aXF0NyoVhuEIoGAkwXA5ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxnW1p0urI+O5qr7Z0zglyRfAGglr5AQy/cTAcaAtUydpguea4iMqz7RjmIQIWNSY
	 0S+TKPVcajwNcZzLcEDVLzIwtX1teKHFma8LBaEvdx5ADxIRv6o5PdapwoaTw/NKA2
	 Oc+zk5ZBIYYMZESrMEhUAiQR4rsYwRuivpP3pYFlI0NUZux9FWSoFAX2BApZymhtmp
	 CHYRmcg/0xY+esHsSNvlexQwe9HlYawEw3kzdGXQhRiptZ2WfHnO8wox8fcXcr/Pyw
	 X8R/01q579lXQo7roXSXblbysmXdbqkklexcb9436dDST9M3vS5pJO08Py4BJ3RRMM
	 C7ZZYLuiXD0yQ==
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
Subject: [PATCH v5 13/23] alpha/PCI: Use PCI resource accessor macros
Date: Thu, 16 Apr 2026 18:00:57 +0000
Message-ID: <20260416180107.777065-14-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

Also, replace open-coded res->flags type checks with new
pci_resource_is_mem() and pci_resource_start() helpers.

While at it, move the pci_resource_n() call directly into
pcibios_resource_to_bus() and drop the local struct
resource pointer.

No functional changes intended.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2330ab84d59c..5c29f1d2821c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -70,7 +70,6 @@ static int pci_mmap_resource(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int barno = (unsigned long)attr->private;
-	struct resource *res = pci_resource_n(pdev, barno);
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
 	int ret;
@@ -79,15 +78,16 @@ static int pci_mmap_resource(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (pci_resource_is_mem(pdev, barno) &&
+	    iomem_is_exclusive(pci_resource_start(pdev, barno)))
 		return -EINVAL;
 
 	if (!__pci_mmap_fits(pdev, barno, vma, sparse))
 		return -EINVAL;
 
-	pcibios_resource_to_bus(pdev->bus, &bar, res);
+	pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, barno));
 	vma->vm_pgoff += bar.start >> (PAGE_SHIFT - (sparse ? 5 : 0));
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = pci_resource_is_mem(pdev, barno) ? pci_mmap_mem : pci_mmap_io;
 
 	return hose_mmap_page_range(pdev->sysdata, vma, mmap_type, sparse);
 }
@@ -141,7 +141,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 	long dense_offset;
 	unsigned long sparse_size;
 
-	pcibios_resource_to_bus(pdev->bus, &bar, &pdev->resource[num]);
+	pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, num));
 
 	/* All core logic chips have 4G sparse address space, except
 	   CIA which has 16G (see xxx_SPARSE_MEM and xxx_DENSE_MEM
@@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num)
 	suffix = "";	/* Assume bwx machine, normal resourceN files. */
 	nlen1 = 10;
 
-	if (pdev->resource[num].flags & IORESOURCE_MEM) {
+	if (pci_resource_is_mem(pdev, num)) {
 		sparse_base = hose->sparse_mem_base;
 		dense_base = hose->dense_mem_base;
 		if (sparse_base && !sparse_mem_mmap_fits(pdev, num)) {
-- 
2.53.0

