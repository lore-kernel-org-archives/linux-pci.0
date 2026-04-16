Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65D1D5CC6;
	Thu, 16 Apr 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362525; cv=none; b=UJkFJXWF7aGQWpqNx1MlnbGMMBVQL0byqLf4+2VjUHlwiv7gOanH8XMBEPmW5J2DdF5yFgod0wgaIvKqLqGVZIe8C061IgEwTkm1QaSGXcVoWwRWH8qYaqKUX+PQKnTuHLG6j0VGmHtcnuB9ypgY8uuzHM7uEEhItaI8KL3MX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362525; c=relaxed/simple;
	bh=hgdLCn3GR7rdEsn4XPXwIRAUu3lfUvkyKZP9W2tZ9DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFBggKeipKW4nTsTugXo61qg5lbZZlGXe53uU5rOyQ7Lg6JZfa+XuAGLZW6iS02neW8gg/Uy+0nTBwfq0XO0JeR2miAmXHHIci85yb/gnHFP868eEqY4Ej+jTITqzQt7sv1GGhQY5MBAd7ttWnP0ZnecZ3u/mP9EnrMjNyi94Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAOaoPkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAOaoPkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A193DC2BCB7;
	Thu, 16 Apr 2026 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362524;
	bh=hgdLCn3GR7rdEsn4XPXwIRAUu3lfUvkyKZP9W2tZ9DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAOaoPkzMh/4vHIGkCH4nNcdBBPEEUjk8XIc6w4Y1mZFUaGJrRCQnXJXFW+BikZM3
	 ps/CyoBlKt/2yjF2ApdaiQJX/xS3Kac5yH2d5G/6X7WUcVaZ7uut46gYlRiFluS8IO
	 UL4UTYJXBCinNmcwWi8NF2bqsT5JvgQ/8bIgRW7Z6Y6kZ/J+8iYqT3+vJ/zE1V5/1U
	 iMfMXasZx/VtIz1iLVPA1LJ7UIB9MrXiuDe/6lKUqkny5uea2rHW8pmZH697Cl/LDY
	 T0GKcD4FFwaLOR5wpGse0X2JFYeOFZpiPsuqKQsxtORvFpNUSZ6CGXKtjMjlBpdP8y
	 vYq9Ow+fvQ+/w==
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
Subject: [PATCH v5 15/23] alpha/PCI: Remove WARN from __pci_mmap_fits()
Date: Thu, 16 Apr 2026 18:00:59 +0000
Message-ID: <20260416180107.777065-16-kwilczynski@kernel.org>
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
2.53.0

