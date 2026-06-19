Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906231B80D;
	Fri, 19 Jun 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859184; cv=none; b=bG+z9DQeBEKUInEH3OJgQrhF8U0a4qEhu0YwZrCziTico5loLbLofByR3tHhbu6gshXmUQJFfBIQwJL8EMvFQdhbgAtsh8fOy+3KkerOQiv5Vln9REBJnu/qRTv9kYFuAC3nUstvlN405y4EcyUPqnxLgQvKJjDdYv9Z+7K0up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859184; c=relaxed/simple;
	bh=SRMPoPgjxL5JvXFUTwmxDqfjh4Nqr3qQt6Ymg370KFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv32fiqCut49UXPrP5NuQL/zAIxmFHpb9ck8rJOVYvnQIjj+1UQEDTLrnpnSA414peM8T/yB45dbbGVacCVoR4j2xFh4f0jwHvSUXbQZd70ngjKuMWt00s5jiFv56P7xisRNCnpBDglc93kzUtE1y2kTaqQcbyHG/aYH86+7YDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSfPZIj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSfPZIj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C731F1F000E9;
	Fri, 19 Jun 2026 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859183;
	bh=9sgcf1DSRPQqZX1hJyBxVhrzLb4eks7N1xlH6ALCiqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSfPZIj7jLxCLOm6qmN+B3DzLNs1aQeeAUxwAshyVyw4JkscaNuppoIh6fuEs7Vqs
	 twLQ2K0LbwAxWKlJ+/5sdqWG8pwNJoFoaYK1vg380rpGd9brVvxhZUlQenvKltAfGE
	 m/9T9EAklWwXztieI1OACTAQl3b68Ah+Y/m5o2O7bZD72Ygap6yts1R/Ar2qDnA3qO
	 j8KORpRFLa6Y8o9CdzOTbD9cdqClcTo9ICbWjIn9lsIcn9kayEm3NLY2a+9fC8kjhT
	 RPO/eadnwgqPp3L3umeqxQ9+1A0Zb/UzjUefbcAOUG625WQXOJZLcqwuX+4DT44JFz
	 Ew2NsVCJu1I5g==
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
Subject: [PATCH v8 16/25] alpha/PCI: Add static PCI resource attribute macros
Date: Fri, 19 Jun 2026 08:51:51 +0000
Message-ID: <20260619085200.3729431-17-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 6cf688621ea9..650f7795cc40 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
+#define __pci_dev_resource_attr(_suffix, _bar, _name, _mmap)	\
+static const struct bin_attribute				\
+pci_dev_resource##_bar##_suffix##_attr = {			\
+	.attr = { .name = __stringify(_name), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),		\
+	.mmap = (_mmap),					\
+}
+
+#define pci_dev_resource_attr(_bar)			\
+	__pci_dev_resource_attr(, _bar, resource##_bar,	\
+				pci_mmap_resource_dense)
+
+#define pci_dev_resource_sparse_attr(_bar)				\
+	__pci_dev_resource_attr(_sparse, _bar, resource##_bar##_sparse,	\
+				pci_mmap_resource_sparse)
+
+#define pci_dev_resource_dense_attr(_bar)				\
+	__pci_dev_resource_attr(_dense, _bar, resource##_bar##_dense,	\
+				pci_mmap_resource_dense)
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: pci_dev to cleanup
-- 
2.54.0

