Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342A29D273;
	Thu, 16 Apr 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362544; cv=none; b=O/1xu0gKfDWrWTyrxEEAeaKo08KZGSoAJTQchQwz+h2Hsd2q/bVXlPVXhw9vR0SmazV8d6ys0nN1hbgCItqFd1Oz1i6MqLoK6sjk7JXka9R0+12gGWNponjx5WDnKcTZ/8vk4JF2xNuJA49O2pCSHjTLfpARrT8fcUzX61v50XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362544; c=relaxed/simple;
	bh=3y3q4SKWG8uBCQVxES1VtyO8TFOC6cRnNz4hWDgP87I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxmA01+WirceJ7X0N2CJMjCnYKYxrZvIxihzA1ejSUdnNZslFAP1fw8l37Z1Q7DlIHKIVpcrtKD+KRoqJPwzvBb55G35dGSVG8ILuutd7PhF3lMpzsX759YhvrgARherFOszfyEJarjs/pNp8pi+0HZbAl9/82cLM5dFFfktjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZROWxYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZROWxYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E97C2BCB4;
	Thu, 16 Apr 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362543;
	bh=3y3q4SKWG8uBCQVxES1VtyO8TFOC6cRnNz4hWDgP87I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZROWxYMyZnpkJ0LQfB/oZHknpvcDP9f05j4Zye6NbiSSEieB0+XAtLHztwXaLNQP
	 zUXBh6dafQRhY1r9+qHucHSisgWRn/svKtQzC6xjKzBb6Jsa2kAR1jl3w1z1f3iZ7Z
	 Bk7P0gGLjPJOWm/yFifbnORGr0npbqP7+2sSSgUnOT4EEPKaMOa/7AynmfHVPxLPg5
	 1yrGSEq59p/RT7qDszGEmJEexbKvIRE6sFMZ4Bss8kyrphry6iaYnWRkdnqOEJxq7E
	 i0ZEa4KlWRTFmL8jNDEMLXdwVB20c9lVSn55q2g5W7PFSYQ2RR2SY/m2omgxCctDqH
	 Ru0xO0Y0zcMYQ==
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
Subject: [PATCH v5 20/23] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Thu, 16 Apr 2026 18:01:04 +0000
Message-ID: <20260416180107.777065-21-kwilczynski@kernel.org>
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

Currently, pci_mmap_legacy_page_range() reads the legacy resource
size from bus->legacy_mem->size or bus->legacy_io->size.  This
couples the mmap bounds check to the struct pci_bus fields that
will be removed when legacy attributes are converted to static
definitions.

Compute the size directly using PCI_LEGACY_MEM_SIZE (0x100000) and
PCI_LEGACY_IO_SIZE (0xffff) macros, and shift by 5 bits for sparse
systems.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2e9693e5abe1..b986ff1e7a82 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -180,8 +180,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size, sparse))
 		return -EINVAL;
 
-- 
2.53.0

