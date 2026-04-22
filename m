Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC238656C;
	Wed, 22 Apr 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874525; cv=none; b=thQo5rscszv1/x3mLLub2lgdxg/pee6rD2woQUtwKwml0Pz1v093YibS+RWArths+IGim5PYIcZHEu9v8PHIhHf3v9AKVQLPtdecFCyi31sF97P7tqKNZ+OYQ8io5ythS008JFgvsbUO9KqQd2IVdMVUzNYlM3kArCp2GBkQvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874525; c=relaxed/simple;
	bh=0C9Mo7MLnvBV7/GjuyWIR9bof3XRGtipVgY5mTNM/jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLr9vTY0ZTebnMhxNoYBEcx4NLAxXJbXfr/cSXXQAlN4hfmdWw7IXU7no/shnXEHoyCJO98w+sWhEuDSZFc4952SoPWgFhTDQwYuScq8TrYNkE+m4NlrDc+7LtUVD8aY3VqhmM1tkxRrEUgnWjMfJlIZxdpJB9dP9HYZ2K6HekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SraPM0xw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SraPM0xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE82C2BCAF;
	Wed, 22 Apr 2026 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874525;
	bh=0C9Mo7MLnvBV7/GjuyWIR9bof3XRGtipVgY5mTNM/jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SraPM0xwovu9P2laAsnVMwSdl2M7mnqOygR0AMTjI/QTFgAyNLG7TPzFsPWBRYm6/
	 6oCULG5H0eWKSXT6Zi0Q3e6kW3boT0gwkdClzm9/2XjJYfz4E5LsgBoa2EC5Ejkqt6
	 OmJGZtMcpSoFSRxQLLhZ9ybyBPRduHxjvrs28vu4M8104bOLDxkfqJseLP8qicfZsX
	 NNUsVcVVZFBlB/0Fdt4qQq491/Mq5szasP+rObzSd1n5w450A///X0Ar5GUqxm24me
	 z7BX+NqaO8LQuZqtA7NQQe9cWDuYRA6Hl4epxJOKHDMUVub4y/ZUySabQ7R5xLI6Vp
	 cEeuWECdtXeOg==
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
Subject: [PATCH v6 21/24] PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
Date: Wed, 22 Apr 2026 16:14:04 +0000
Message-ID: <20260422161407.118748-22-kwilczynski@kernel.org>
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

Currently, Alpha's sparse/dense legacy attribute handling is done via
pci_adjust_legacy_attr(), which updates dynamically allocated attributes
at runtime.  The upcoming conversion to static attributes needs a way
to determine sparse support at visibility check time.

Add a __weak pci_legacy_has_sparse() that returns false by default.
Alpha overrides it to check has_sparse() on the bus host controller.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h  | 2 ++
 arch/alpha/kernel/pci-sysfs.c | 7 +++++++
 drivers/pci/pci-sysfs.c       | 6 ++++++
 drivers/pci/pci.h             | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index ef19295f2e33..95de7ffd59e8 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -86,6 +86,8 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      enum pci_mmap_state mmap_state);
 extern void pci_adjust_legacy_attr(struct pci_bus *bus,
 				   enum pci_mmap_state mmap_type);
+extern bool pci_legacy_has_sparse(struct pci_bus *bus,
+				  enum pci_mmap_state type);
 #define HAVE_PCI_LEGACY	1
 
 extern const struct attribute_group pci_dev_resource_attr_group;
diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index b986ff1e7a82..98f81bc73660 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -191,6 +191,13 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);
 }
 
+bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return has_sparse(hose, type);
+}
+
 /**
  * pci_adjust_legacy_attr - adjustment of legacy file attributes
  * @bus: bus to create files under
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad8ee192c94b..8d4ec862c326 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1019,6 +1019,12 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
 }
 
+bool __weak pci_legacy_has_sparse(struct pci_bus *bus,
+				  enum pci_mmap_state type)
+{
+	return false;
+}
+
 /**
  * pci_adjust_legacy_attr - adjustment of legacy file attributes
  * @b: bus to create files under
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1bf165595583..f52caf7e4d13 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -390,6 +390,10 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 
 }
 
+#ifdef HAVE_PCI_LEGACY
+bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type);
+#endif
+
 #ifdef CONFIG_SYSFS
 extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
-- 
2.54.0

