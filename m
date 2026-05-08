Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1815539A;
	Fri,  8 May 2026 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215007; cv=none; b=MSaqAy5TdZYqYdYV2j5xqs1WlbtQ6UmYhBKHz+1oN16VBGTn+pgG6z0xKe2YaImgutD1S+9Qox18jliIZyT5NCUKnh9ahQDgOI/zHdLFexQmF7yc6+1CIzbxo9R4x+rw6Hx2dmlz8KBxXozUf+Oj2v/sPtyV1JOvusIApBY6JmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215007; c=relaxed/simple;
	bh=/RwghHanAn6lsGhprPzwE0OVa63WsjjjMpcAfzd54OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtTXrrTLVq1/5M+8Ovm4XhCIBckR2DiGRcEBvmzOr6EyGFkbiasfLDUMelcHOZh1i5KHk2lpyIl32acqZGTd3B2ToaEUB99MqKdgyGMyEBNDs6HJJZvIIAbP/KSScftPTGORhkDWbB9e/JTKdAeJ2Cddxi1lv+6tjICr0rKsRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is6VcbmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is6VcbmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7695C2BCB0;
	Fri,  8 May 2026 04:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215007;
	bh=/RwghHanAn6lsGhprPzwE0OVa63WsjjjMpcAfzd54OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is6VcbmItJK+wucHOxI/Rzr8eobabubSF05p3tb3KkUVquAazMA+HCH+pqKrzyi6J
	 LIM+sGXuVJbO0WGzX39AFq/k3JgzGlbRfy18JkP4g3H8Lx2Uv7QqxzOSYkb4hYVnra
	 VhG0673LrTjdaj9L3s0/rpQOH/T17V9FTQyP9IcHLk0pqxas1s0CBP3YUUrTW5jpP+
	 qzdxzU5UIGvroExRr7fJ4z/jaj35FTGLuqTM6fEGUH7MC7zgFF9IzoBoQTvydoWQAV
	 seZNeVhyB7mTeI+qei0XPNfygRmSQyOxQODg4Zq9q1J7UuWbD1aTFmk5+BAV05ab4Y
	 Qw/tLwZp5GYVA==
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
Subject: [PATCH v7 16/24] alpha/PCI: Add static PCI resource attribute macros
Date: Fri,  8 May 2026 04:35:35 +0000
Message-ID: <20260508043543.217179-17-kwilczynski@kernel.org>
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
index a8dade7d084b..b537313d1717 100644
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

