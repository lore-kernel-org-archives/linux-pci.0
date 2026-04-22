Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9337DEA5;
	Wed, 22 Apr 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874507; cv=none; b=nXkmI6R4V16Pi18PJW2m45xUfk4NDLZqju5CBuYmgcdi4Zdez8aJ4JkDVLv/8UytlH2p4bhICKNICOtXr/1p2IIj0gOMQEHiKUmGVZN7NjZfYFlLKC0zjfH4qEDN8I7YRYkBLRm0GRITLllAL9P7TfuQIofP8jIT7fqtXb1su5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874507; c=relaxed/simple;
	bh=6opnfEAHa7djrPNhG4kBV3H+XRWoxL2r3NmQ1bYH8qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqw+laGudX1B3JAzlNcadNnrPJmCzemlFj8AQyiaBRZpTNLgmhDK2J/B+JPhuXKJFDahL1YijqyC4+KOsqyL/lKRdU1tg92xk9NnimH5GzdBxulfHNU8T0IbCXpV5dSLRfUb1cvoLJJ7aaaIs3o80wVh7laxmvAG7z4fo9lRtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxXjwQ1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxXjwQ1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C5DC2BCAF;
	Wed, 22 Apr 2026 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874507;
	bh=6opnfEAHa7djrPNhG4kBV3H+XRWoxL2r3NmQ1bYH8qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxXjwQ1a94c3tddnlqwNuim6d4zm7AStOYz7TQU2ZXM7O57yGSCTtIUgI5HezwJNB
	 uYS5z/o5POmmhfD8izHw+2ACWOHqu/DAkCkbODHoWVibnLYQ4EtKrSyISTaUzD0LRG
	 TfsjQ0ou7xx+E21brRquQJ2BgtN5KrgZQ9asf6Ta/mk3fqsknHfmUKaTsVif52AOI8
	 1sU5O1fJ473/Ob6vVMo0GeSH3lW+yGXSVR2vEO8R1zpopdPVRqDa0VYyn2+HSOVSCl
	 ZKtE/Bv7AshoI/ET6ZaZfR8C0v/o1SigO6fHtxbFCKNKzK529JNs5+HOoZCrxTvH6V
	 04M6gzcPi1haA==
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
Subject: [PATCH v6 16/24] alpha/PCI: Add static PCI resource attribute macros
Date: Wed, 22 Apr 2026 16:13:59 +0000
Message-ID: <20260422161407.118748-17-kwilczynski@kernel.org>
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

Add macros for declaring static binary attributes for Alpha's PCI
resource files:

  - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
  - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
  - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)

Each macro creates a const bin_attribute with the BAR index stored in
the .private property and the appropriate .mmap callback.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index f2ee737c588c..3108c165b3d8 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
+#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)		\
+static const struct bin_attribute					\
+pci_dev_resource##_bar##_suffix##_attr = {				\
+	.attr = { .name = __stringify(_name), .mode = 0600 },		\
+	.private = (void *)(unsigned long)(_bar),			\
+	.mmap = (_mmap),						\
+}
+
+#define pci_dev_resource_attr(_bar)					\
+	__pci_dev_resource_attr(_bar, resource##_bar,,			\
+			    pci_mmap_resource_dense)
+
+#define pci_dev_resource_sparse_attr(_bar)				\
+	__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,	\
+			    pci_mmap_resource_sparse)
+
+#define pci_dev_resource_dense_attr(_bar)				\
+	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
+			    pci_mmap_resource_dense)
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: pci_dev to cleanup
-- 
2.54.0

