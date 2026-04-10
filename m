Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021930F52A;
	Fri, 10 Apr 2026 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800288; cv=none; b=Wawab8VBwRhqFHt+5SW/rbIq0gnmTS7VtwpMArxlh52FSo70MY9GvefT+ICPaMpCZDmKURyH6wmvvGEri8zMlWQsDLb3gfAE6SjlACiOltVGkpumN4tVoraxg3HeA7Yb70ckntV+aKUnn1o9CfNyWnKCGFmOWVDOm4Us+/cWLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800288; c=relaxed/simple;
	bh=z4FOR4TwG8rLwyIwhKM+ZusYoPCsVz4loWx7w2LvdEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaAjK7FAV9cy+6wHoUpY843fdan7PmJWCLmzVMYO3KoyWeOia4Bm1VSvQ/f1gRnz1Z+wOMPj5rIlK5N4y3z9mmwJe2UsIIyH7k8R9DA/HU2SlwQ1JxmH/WQsJ2Bu9qVR9VGrtz1C4/QTzJfVitzCvdhwU8feMQpt35HfbDOVK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/gsQVTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/gsQVTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6316C19421;
	Fri, 10 Apr 2026 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800288;
	bh=z4FOR4TwG8rLwyIwhKM+ZusYoPCsVz4loWx7w2LvdEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/gsQVTrhEK2zXeKolaZg3jed/dcuw60fYtzbyIzIfPS1vSkpNT99H3Y0r2KTKjAG
	 R/5HH7Phn2ADasVdjYLigZjcZBBpiHpd+WMTA3hq6TWQ0VP5KTlb8g4YHbmwFa1qGH
	 DAx6z3IpeLL5yZ7UKxX07lBULizAy/sTZVCIa/YaEyyeGmsDDbExqfZ58GoZpGEBoU
	 oI4A+XugLEclYDmU++lB50ryGK4p/uvchj8nz8Jn75KJUuvxE9vdkB66O9JPdNohGb
	 xOPGDHwUt7wfgJ7Ha/Zqh9Eg0tUIP3PUigsRopVP/H6+ek824PbrWLW7YMLDWxo1Er
	 lqasQoGvadvxg==
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
Subject: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
Date: Fri, 10 Apr 2026 05:50:32 +0000
Message-ID: <20260410055040.39233-13-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index c84867ce31f5..7aac5e76dcd6 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
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
+	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
 		sparse_base = hose->sparse_mem_base;
 		dense_base = hose->dense_mem_base;
 		if (sparse_base && !sparse_mem_mmap_fits(pdev, num)) {
-- 
2.53.0

