Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AF30F52A;
	Fri, 10 Apr 2026 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800306; cv=none; b=Kj18TsN8Vn3HGcns/ye8oYa6XpsNWijUzry8XWBezvUhs0vj/Wt6QPONjCZzEfNwaUaLU9gTDBVk+rJcne4bHxcOpJN4IKUCQvdR7V59Mof4WVVdv0tFKT/YkUuWE7R0++jR42VOH/vmua4G1Ds++HkAA9n+/U7oHcZoIFOdFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800306; c=relaxed/simple;
	bh=RaLaicXdVd13BfmiGv2VaH4swf8eCOhEtaGCnbo0iIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k48TmxHHgG3uyiXhjGzdqC04+T3xsapgBn0viThYVftM+ha672VhcCp3GEeWnxrGIrdISu7G2ljgLi0+/MzplMJKnGPemI+wJix22iaNiS4e80QeaQy8huW46YEn0jgRTb0QCV2U+//gRFik1rbvZ4ImhjAFlXNYIA+mQOsYYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9KhOCvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9KhOCvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79227C19421;
	Fri, 10 Apr 2026 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800306;
	bh=RaLaicXdVd13BfmiGv2VaH4swf8eCOhEtaGCnbo0iIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9KhOCvwhQBtoVpNr6HLSFDBoXOpjGQuwTz5mSKRMKHFJpTYUVqBAQbaySh5U/2c6
	 SN44v4MFI2F7H8mEXNOvh7jTGhAh50/IkSeVwCDEPIPKv20uDiusCSdfc/BSpG9QHP
	 YBGH0h4FMkgUZxvnpLFjQSMJHnYmJyVLRfptvRgl1MvTA0xUpcLDWOQffjysbKv2uF
	 w+8TwLGglwIBY8Us/Km9F1tr4EGd0DKquEmHy9UcAzhCSt66wVtWFKYS/0/3m59ISp
	 AfIgqbwJDk9Wo0Aiv4q36+2MA0J24+dk5j22Lj+MFY2PXNYq/fVP/AoUdu/hVm1lCu
	 8bWvlMrIwMmpQ==
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
Subject: [PATCH 17/20] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri, 10 Apr 2026 05:50:37 +0000
Message-ID: <20260410055040.39233-18-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly from the known constants (0x100000 for
memory, 0xffff for I/O) and shift by 5 bits for sparse systems.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 27adfe6dbd5e..2da95d965e9c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,10 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? 0x100000 : 0xffff;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0

