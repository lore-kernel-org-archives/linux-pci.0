Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE418FDBD;
	Fri, 19 Jun 2026 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859202; cv=none; b=Ck9O4ff0IQKh2C6tvxiH+qJMOorXIjkNsIwLehRcT1nFaWcnrBzueVvcokof5dgSRdn1Z+BRRF+jImjNWgM3Hc8LrBPJYliWDt/wOTO13iUC0bRaNWhRWOomjFQ3KzjO4LNxKVKSTPmh1vvo+WPIqr5btEp7yu81GCD9Yw8DsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859202; c=relaxed/simple;
	bh=IR+kdg8DA879xObUJ/G5FhwH/FxjJXX9j7agSuVPoi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfaAbym2OCMlY8s/1sqPflJUElfQpLMA8av5kG99k8V4fjDrClm+KgGDJ7CuXQ0oo5hL+00UEZ7Vm2mCXc+MSRrGc5gZALkNsOPLj90KD31r0UOXYJmsJqIADb49RKSe3OKqXwhRU7LnU7WFi84EwOyywMBAHrnOfdaMadYjla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIU94N26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIU94N26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6DE1F00A3D;
	Fri, 19 Jun 2026 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859201;
	bh=ZtExgl18k1w/oxRcDRexEZu+AmUEBl9WvzTUZuXPKUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIU94N26OFj14yaKOeXQ0CYvtS0FGm4xOxAxpX2CVg2BrSeNwPdwO5mRslwGyTAcw
	 Rqkq9eqndDEHEIQFued8aOjVJfHfjytldnew8BFe0tiFZ7d5sPL3VhREQPcaRl0y4O
	 TB+s8lITse4bF5Xz/CRTn0GMODcYCGmDXJcJqI0Pl0TV6Wv2I6HsTfKCE9w6gNvkLH
	 wsQ7btk4rcaFKxjHdw+bfzfTcv23lfqB4pVzkITh7v08Q1q3ATSYwiU9xsctsPnFK6
	 yu9P/WsdbtfJ+O09iK4chj2fBxKKCk4qYUT1Dx7sPixXaZTRg4Qvc5/TSHjFd4g2nc
	 hYcmS7/ahB94g==
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
Subject: [PATCH v8 21/25] PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
Date: Fri, 19 Jun 2026 08:51:56 +0000
Message-ID: <20260619085200.3729431-22-kwilczynski@kernel.org>
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

Currently, Alpha's sparse/dense legacy attribute handling is done via
pci_adjust_legacy_attr(), which updates dynamically allocated attributes
at runtime.  The upcoming conversion to static attributes needs a way
to determine sparse support at visibility check time.

Add a __weak pci_legacy_has_sparse() that returns false by default.
Alpha overrides it to check has_sparse() on the bus host controller.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
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
index 74c9145e0253..2d878b310629 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -184,6 +184,13 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
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
index b8986a735a46..a861484ac0c0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -983,6 +983,12 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
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
index 71a1fde1e505..c64c7f5f0bcf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -392,6 +392,10 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 
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

