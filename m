Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375F1EE01A;
	Fri,  8 May 2026 04:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215021; cv=none; b=YX4UUzt3ShmoWtJisr1FXU6dAx04jXYFNX/M6Y+IxWuFqCjqSq4cIJ54K1ikTlDJj2RmVxoaub7saDpG7qof0cRzIJ/tdh4ueWTU1vigrIN+4bgEdjfcD0PvFxjDNe9zpaYKg40fq3sxyGWwXWIbG1x/YdTk9HCm1W68GPY02B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215021; c=relaxed/simple;
	bh=79vPpWeuwl76jaz34iY/J6HyO6/6tH4ao0+c7EMnbMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhGvYg6yDozi5Wt6Ec1v3H+6cnVlbPTiZw58LZSnYdVFgN4S1Hdk/xhwT91CQZTPAB2HFAbHGtt73bPv/PdINFUwAEudbLcC10b0rThTrX75cwB9DHQAX9LkuaGAVlSmshUMBHGdlW0kU2pB4MuRP0LovLouB9bj3J1D1fWtLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHz1FCRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHz1FCRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53081C2BCC9;
	Fri,  8 May 2026 04:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215021;
	bh=79vPpWeuwl76jaz34iY/J6HyO6/6tH4ao0+c7EMnbMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHz1FCRUoHZFoS13vfeHM9gmE+SRBentgLzxS3Z7PuJ5J/b21bEUW+s9aDPIvU1H/
	 qkAVbRF7MBlhT2f2XwbRrCKDZrTHFrt00aao3Il3HqylLNwI6L1NN+0Ax3iQXJNwE6
	 GtBy3veqo+SN4FzfTXkvHOsrPcPmFPGiNZBw51W+6PUqDFrX0uPNTD7+g1cDLqazvc
	 vrKZeCpRTm4F7B1mh7G4kz+roO80RgtCDtYK9rnGH+nfqIShQIWK+xRbmjOmR2fWMr
	 GlsRMomvV+S0qzx5Iwqotb6pwmeiiSThmqV1tyW3casm/AmIKDHFReBKWwBfPbcAQD
	 bnKLHX5E7j9Pw==
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
Subject: [PATCH v7 20/24] alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
Date: Fri,  8 May 2026 04:35:39 +0000
Message-ID: <20260508043543.217179-21-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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
index 20c97c06d755..89329910b890 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -174,8 +174,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	int sparse = has_sparse(hose, mmap_type);
 	unsigned long res_size;
 
-	res_size = (mmap_type == pci_mmap_mem) ? bus->legacy_mem->size :
-						 bus->legacy_io->size;
+	res_size = (mmap_type == pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
+						 PCI_LEGACY_IO_SIZE;
+	if (sparse)
+		res_size <<= 5;
+
 	if (!__legacy_mmap_fits(hose, vma, res_size))
 		return -EINVAL;
 
-- 
2.54.0

