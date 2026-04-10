Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF030BF5C;
	Fri, 10 Apr 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800291; cv=none; b=dSHNacMgJ9arRKIoNhwU7eIRpkZXKsoHDYfn8ShMRt5f5bGteref4H5rqQW7M0T/FN0l7IoOpssIXEhvOl/v3/BYZSnYD37STF1qtkkD/2A6KrfiZcZL2ijDLJzeYaurLcRYZMc9ISn7V/0qhGh8rmBoPn6clBIczRlG+gAOpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800291; c=relaxed/simple;
	bh=Nh7a1ArkRQeNDsZQ4G4s7B27zHMA9oeNqUUdRhEq7Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qix79xH0QKkxAgJUtiotDwhFRVdcH3hLFc/RTmEVib0aiXPuRhyr6PbHZ8IankUw1EyzdM7bvboQeslFd4vMb1pHsWZ3wgRSUXG9QQT2/z36TdpMlpD5kK6bml9c6wSqoRj2vjxEi6RtUP95b78245IhkvXdOKEZrJlG7e4tT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGDauH65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGDauH65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F7C19421;
	Fri, 10 Apr 2026 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800291;
	bh=Nh7a1ArkRQeNDsZQ4G4s7B27zHMA9oeNqUUdRhEq7Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGDauH65tg4bJ9ruSw7Z6gY2FgZvSRdoiVLxHgO6FHnL6maslO7dpOby3VlujfHY6
	 lp71qjGPI9FnJ+YkDygQZLF5ftlEhT8uDDo3MIf7YZBN6Itnjwxnhzm72KF4k+HFD0
	 GpQmeT9QHiDMxTrn+nKdUqMsIwo+qI9jQVMvVAYuN333KZPyYMJovH9pMhkBeIGf2V
	 5iyGh6zq4JQKEamShug3eT7CotSXt3MqJ+1Tg0qxcotMGh+oKGvTXX7Cs6ugCuVz52
	 aLYqZNvCXjb5KJX1U93HTRBGcVdyqotqEjICJRYp1s9beAn1C1ORBRpyLbEfda9fm/
	 Li3fkgG20rMiw==
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
Subject: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
Date: Fri, 10 Apr 2026 05:50:33 +0000
Message-ID: <20260410055040.39233-14-kwilczynski@kernel.org>
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

Currently, __pci_mmap_fits() computes the BAR size using
pci_resource_len() - 1, which wraps to a large value when the
BAR length is zero, causing the bounds check to incorrectly
succeed.

Thus, add an early return for empty resources.

Also, remove the WARN() that fires when userspace attempts to
mmap beyond the BAR bounds.  The check still returns 0 to reject
the mapping, but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 7aac5e76dcd6..867199b988de 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -37,20 +37,18 @@ static int hose_mmap_page_range(struct pci_controller *hose,
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

