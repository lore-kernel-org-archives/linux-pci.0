Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB930F52A;
	Fri, 10 Apr 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800295; cv=none; b=lhiyhgSBcO/x9xq65pakWjxWV2gMbYh8j+iqOIxkMgHFSuugtrsOuLAoaQYmo8fi5dGzTXBmUhPU4mv+NOSJ4x2v67S2kjxu+APGdktpNN9p95XvWK0sTdcT9gCeVywcimhJ0efMdkhy5JWxjl81i+2cyLomwpDZymNGPJPwfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800295; c=relaxed/simple;
	bh=M5WivLrx5zMSeSOunSyFVbnHwqD866ZMVHSIPs7ARX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP4qSI6rI8rWtLG8yCmbmWDR/ApvzOmUhclUMWcd5GBbBKoKSEnh9mtoXWagHznAz4lpobErwN7fS+rq82ri//6WDnEIr1T2RoXsfHOeAwNs98RidCwh355TKLVoQA5qhDfNh338jR6+xJXo0qhGEorAZ2k0cMUQV//TkJCRMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBBFlP/A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBBFlP/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD8FC2BCAF;
	Fri, 10 Apr 2026 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800295;
	bh=M5WivLrx5zMSeSOunSyFVbnHwqD866ZMVHSIPs7ARX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBBFlP/AIYXWrEyUV2Ue68uGFxLTG1U/qoHhkhvTFyvBn/16qyVbml2XNylfy6a0y
	 kkalXA5pkYAkCy8zykaSRoDvyPDNoE3+QZtGGLB8GszsES/sf4O+igjAf3a+9l7bgE
	 vivhjk+Dc+YHrsoMTnUfx7m9BzDL/I5St/f5grWP72wm7V98ZYt7b2CX5RxjvJNbvl
	 pE8ZnUm7x+5datNMf+NXQW3DdfC6uXHX1yTi1S5/XijwYakxfrI45HHa89B993dR49
	 aGWzT4JaiWBQzRN1qDva0eC+TITK12ZCX12ivpiS1EEeib4n3YIpQv3ACUDCEgG/qI
	 QyfK8OyXhEtUA==
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
Subject: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute macros
Date: Fri, 10 Apr 2026 05:50:34 +0000
Message-ID: <20260410055040.39233-15-kwilczynski@kernel.org>
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

Add macros for declaring static binary attributes for Alpha's PCI
resource files:

  - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
  - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
  - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)

Each macro creates a const bin_attribute with the BAR index stored in
the .private property and the appropriate .mmap callback.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 867199b988de..0e016b597b06 100644
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
2.53.0

