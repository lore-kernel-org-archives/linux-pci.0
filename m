Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77B37D12E;
	Wed, 22 Apr 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874504; cv=none; b=p3gZNB8OnylWevGYL+yL1RWYeyZmj0cUNlWFlOU/xCWaBzGR8gjOtBd/g4qRBKxcncxizrAV0VnDAPoMJUIA6D7kg1EhUAIePxbcAhr5cdxUqk+Ywp41MgD3QR2RhFeOmI89k2WkZssHV4pP+PLAKWYWJr+ulAj5ANyjgapp+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874504; c=relaxed/simple;
	bh=ltS0CwScmU/7W/k23zstFp4KU0BXOTAMQrPkEPzvQfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/tldm7x2eSN/hYMl+mbp9syVpeBUcG98N/CLjWNK12Rpuw37JqKcvQHjhdi0YvEXBNoHAYu8bhmqiYczEVZbWSYeNQTQuF8BhpI20QO0kuIuNmrrBzRxDndHTcqRuv6nZ9ZYG4v741tauhKANu/4PRnV/hI+P0SaItIpLkd+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjky3Qp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjky3Qp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AA7C2BCB7;
	Wed, 22 Apr 2026 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874504;
	bh=ltS0CwScmU/7W/k23zstFp4KU0BXOTAMQrPkEPzvQfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kjky3Qp8t/knDHFwKUrhkLsr0qZD1jVYl/+BCV7F+W+jC/KDfwIwNzz29ILZHaA/C
	 HZ5KEAOYmSea9bjuLxdcD6qsHryQtfiMSRnZW4RGtftLFRVvSXoTxjmWCpIqM00eXN
	 prkYb78V/oaGACAGNylcOckDGDBsVR8VBuRQ3yPD2nqO++JbVa9lR0XtwV//dlwZap
	 HwEm989HL8MTZdSEG0sOgYUO4VgUrf3T+emm9Efr8j2hn9lGoPYEm1PP2ykvChmDKo
	 04nJU4mKd3V6C8Zgg05BljN42NfWYNuvT2p4E0YZiPa8BeMN47WCr696udq7NFuadi
	 gDZw9G9IBljag==
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
Subject: [PATCH v6 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
Date: Wed, 22 Apr 2026 16:13:58 +0000
Message-ID: <20260422161407.118748-16-kwilczynski@kernel.org>
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

Remove the WARN() that fires when userspace attempts to mmap beyond
the BAR bounds.  The check still returns 0 to reject the mapping,
but the warning is excessive for normal operation.

A similar warning was removed from the PCI core in the commit
3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 8802f955256e..f2ee737c588c 100644
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
2.54.0

