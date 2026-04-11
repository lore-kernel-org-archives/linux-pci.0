Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206113D8B1;
	Sat, 11 Apr 2026 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894588; cv=none; b=et09YR1Qp/elmNDAekXaO599grQiIZa/h1E8DYQwy5cx3VhpD+o2OGNOu/gSSFt8uGIzvKs9ro0Pf9wf4MsWd/KexnmWyvZNlDOo2UdqwE+/wMYkAG7VRUdGCJ+R5NnG5PbBw3xh1hUzMsrLjylILnUym9ZPwFTR29YOmYOFhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894588; c=relaxed/simple;
	bh=zSxumLDhzl/GXuL/vxCq5TbNSO065j7mWpkMfmgLc8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uC9z5TLgGFZ46MvmAegvxaJpa4vFCfgp+DU0247TIM1oWgu3LpxbwZsaYOhG3Ubrj7gK61NBehI2QatV7wAm761jmpde7al8LZ9InCHyzHciTB2t3NJXDRduhlkYQZynGkd6uu8GJDv5fPC0RCmu6c8JBCJFWM22jtXa1lxGpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8NEYhhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8NEYhhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C61C19425;
	Sat, 11 Apr 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894587;
	bh=zSxumLDhzl/GXuL/vxCq5TbNSO065j7mWpkMfmgLc8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8NEYhhq6D8W6aFmYfs/BzPuBeHU9YkT8aICazqPgenLqFEffyJIXEsTcGBwRGffm
	 ZOCGP1llYQkF7hIklBiiS9wz+9Wl4stAdeqDdQ1EPoRT2S8Z2quciSpc3VfYsu37Wa
	 gSuR1wTJ1DmzMUPVTfR7MzVvhoxxHg+JG7zQxHoJBFfWhhDu4O44SzkUqHKyTFo00a
	 AIaVxOLERCJcltbMq67MdL9AYOE8zLzR7EbujGs/KsYD4OmqCd/KNFq9D8xBerMF6H
	 iRUqVmdN1Ic3XqqXtWQ8eymzyF0zG9saApjbGnAvhzqBJFmDy8U6Dh3Amkykvkb6Bs
	 qVDfTdOLUlsSg==
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
Subject: [PATCH v4 21/24] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Sat, 11 Apr 2026 08:01:45 +0000
Message-ID: <20260411080148.471335-22-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2e9693e5abe1..a9dea147528d 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE : \
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0

