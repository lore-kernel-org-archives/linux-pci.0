Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC823C8C7;
	Sat, 11 Apr 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894569; cv=none; b=P7kJTIxhcYv5R3XckeE+vnW4tR1ka/jBBfyT5eArGpBl/AaYGr13OCDVDMIIahgQERQgx7ff1ICj8+RiHr6NchFehVEq/a0EhFW8dCzKlAvfR8jvVSUUica0JGjTMmGxVeAUA1ML37CQeRGiEWU5EjNrPTwEm/t1z8ewpC6PKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894569; c=relaxed/simple;
	bh=Gr3+4m6Cj77hdjiMr0OAiQ4tavCjVjkmMUYZBycpZFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjbmxBQZytI0JSGB5LTFrbF0C2/cs0D6QR/BJtZi/mj5Nb9KcmK62o5zichbyVN0H2g+zp4kGVNPGTLNIYroZAmCuGyBR+YFX4zQtQ7pPIJZR0Qxy7QLs6hCYp1kEPRmcaQCTILQqWh5xpIDwGG1lP0kiqoVrMDagtSVZnlrPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb0avEzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb0avEzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47332C4CEF7;
	Sat, 11 Apr 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894569;
	bh=Gr3+4m6Cj77hdjiMr0OAiQ4tavCjVjkmMUYZBycpZFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kb0avEzV9ox7btRhxNy1G7gzEzelfJWiEJ9F56x+rcuE1cqzexUGOjxzBJ4YOVg2c
	 MpDB1ywE6aBdC0PvGpkhA6lNsLEfytObgJMyBVp/afL7mzo3c60vayh8ClyRk2s95U
	 1uLu6aTssGggNBfzh/R5v6ljup5C+RagRnX7oYN+ImDGdO1n3qQKdzoB4TKzUfgDIc
	 63u5K8Gy70/B8mdWiVdlwr9VUG3dcDm83owr0uX6Otkv403mb40rVZW2g88Dk78931
	 9CKg9RTGXi9aLO22p1Ghzyooa6dXg6T1Dblff+34t7FWTOSLi3fUcPnolIL2DuNhbq
	 +Vm5oTkT1rehQ==
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
Subject: [PATCH v4 16/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
Date: Sat, 11 Apr 2026 08:01:40 +0000
Message-ID: <20260411080148.471335-17-kwilczynski@kernel.org>
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

Remove the WARN() that fires when userspace attempts to mmap beyond
the BAR bounds.  The check still returns 0 to reject the mapping,
but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2748000a7486..c136603ddf2c 100644
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
-- 
2.53.0

