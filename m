Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712913D8B1;
	Sat, 11 Apr 2026 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894591; cv=none; b=SN7TAE0lAvHMv72c6RIfulRFipQKo7FhbiQJ6Ye4W+bmJZtO1H3j+C8s3aZyb02DaI9ZxmS+a5/bRTvVBnghlFJSRsw57gZXL9MDX4aU4wlPVZOkZGjyVgVnCoSYLjABim2pE01QNaUa6weoLX4RzKZX/q0lZIg98lVWb99dHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894591; c=relaxed/simple;
	bh=6TdFxnj/XF9dGvehexRWCwNHzJWM7dA99CTM42Uhd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E55imJFK6xew51cOBbDUNXKMX4i4oUfDvvaBPYow0IaGTLpdpymDB4URNP0CGxi0gFpbpYF6j5kITz2XkTdxAaktdHIvb2rc3/uLaGdDPiJ4d99zp4k3d5a54qiNcOinGXHTZ7rVkLiAdrW0scoooL7pfcOyTNDSbsHocik6nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMP/y7W1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMP/y7W1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB68C2BC9E;
	Sat, 11 Apr 2026 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894591;
	bh=6TdFxnj/XF9dGvehexRWCwNHzJWM7dA99CTM42Uhd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMP/y7W1Fkw+9eXey4NyQYjxyZUxA+Yrl9JuSmZzLWwI0/YEs+9gbjnmbTLa8uiOj
	 VIVR3BMkLl8BGjI5OlPWzFOXDNvXwk3nm0O1g+N7SDm8EVpFl/30kSTYtB9W4zMn8j
	 mWG/Ia/YDTHfKqZXfMqkxSma1lyTIYLLHvPmhDkyv7uCNuh6OZddiPeRVJj0UyhjXt
	 t8NR3IYUfEtqFmn1OztDwngHcOleIWaUrUOkPvkzfgghm4fm2yrYAth1yZ5F0hKV3E
	 xr84uvy8fYf3tO4P6s2Zce7kYvvWfSwUplBXyKwsAmc3fUwnjbrp0kMO9RKQy8jw21
	 HDrtdQHNb6MQA==
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
Subject: [PATCH v4 22/24] PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
Date: Sat, 11 Apr 2026 08:01:46 +0000
Message-ID: <20260411080148.471335-23-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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
index a9dea147528d..ea51f6b20458 100644
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
index 3a7bbb00ca60..ce004b349594 100644
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
2.53.0

