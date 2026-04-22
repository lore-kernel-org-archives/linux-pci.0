Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536337E2E0;
	Wed, 22 Apr 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874519; cv=none; b=DmXU9mH3GpGn5lLinsGNjkWEs0L/UR7VaHeY9hB9yRTChYym3BfBaiEb35+tk0AvasQMhQyND5jOpgE6Fzs1SgPBNNKNMG4/Oi7ZJOXLU4DxFy54Rqmj/ZCJ8PGbHeciuorx3Op3xqKc4bYMttSHSuytuyz8jcBHgxXpMp5y1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874519; c=relaxed/simple;
	bh=dijWWutmL7JHzGDHtujgmiIt1pal0+qTFGDBt404M9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkd7pJxtcIncKE5Y6HGmqqfEwNZsLhwp1mkiN/rci+av0Zb6XrD/4E9ByFAgb2w26OqdiS9Hu20dacfxyorFwJWmLMDOif4+yCsHu9JFfYNAKRiyRvPnIP1eyEObCFqzMt2eYSU4YzC9bEVZik0l4wqGy7mfOrlU76dX1EyOAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5CcSfMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5CcSfMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21CC19425;
	Wed, 22 Apr 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874518;
	bh=dijWWutmL7JHzGDHtujgmiIt1pal0+qTFGDBt404M9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5CcSfMHYCKVSxhdvGoAFxTAB3raXTVVyvqAkhMcNEcUyBzMCPOuAML6zE5POqQjk
	 +C6Oi6Rz9HMP4+964KHpXS8PSMEvo9qn/cxW75QNkJt/s2znl4b4lrZku29O42/AVD
	 pk4GGDiqhjSo8CLN1kSxG3VSN72chC7cd7TmhL9g+KbIWBtScDUcXwsYDqwd74TtmO
	 rHceuuE6GWaXMdYW+nirk6x4J1U4WArg0Nz1HYruqRTm89YPyFf74rtjMqEypkT6GP
	 S9YG3MPy0eoObeOOneh+wS1gAJNNcvURBBHBTxY0GIyRyMDG4iaPMJNu0v8iFLfPVV
	 S9Xr8i1MxTAyw==
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
Subject: [PATCH v6 19/24] PCI: Add macros for legacy I/O and memory address space sizes
Date: Wed, 22 Apr 2026 16:14:02 +0000
Message-ID: <20260422161407.118748-20-kwilczynski@kernel.org>
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

Add defines for the standard PCI legacy address space sizes,
replacing the raw literals used by the legacy sysfs attributes.

Then, replace open-coded values with the newly added macros.

No functional changes intended.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 include/linux/pci.h     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3a7bbb00ca60..ad8ee192c94b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1055,7 +1055,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 
 	sysfs_bin_attr_init(b->legacy_io);
 	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
+	b->legacy_io->size = PCI_LEGACY_IO_SIZE;
 	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
@@ -1072,7 +1072,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem = b->legacy_io + 1;
 	sysfs_bin_attr_init(b->legacy_mem);
 	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
+	b->legacy_mem->size = PCI_LEGACY_MEM_SIZE;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	/* See pci_create_attr() for motivation */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6f55005f82d..6b630bac8c08 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -27,6 +27,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -1167,6 +1168,10 @@ enum {
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+/* PCI legacy I/O port and memory address space sizes. */
+#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
+#define PCI_LEGACY_MEM_SIZE	SZ_1M
+
 extern unsigned int pci_flags;
 
 static inline void pci_set_flags(int flags) { pci_flags = flags; }
-- 
2.54.0

