Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11E1EE01A;
	Fri,  8 May 2026 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214956; cv=none; b=IgnNYGNDDdxGqvl3gK57WxnFhx/d5czmor6ND8rY6x28IR7Bg6Ycvb4lzPL5NQ7vyFRKc8tKgxREhdQnSqvN39Fap91rbI3YUcW5J0qYW+eEPF0myGRFYYSL76XuK2X0Paem8B5iQ6OBf8VfBtugs1T/9DkOGxDp3Hmd42Tv2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214956; c=relaxed/simple;
	bh=h+kJQeLZVqnSeeiwM2bc1dXa4IpY6mXgTH7Yn+fO0vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVMbEv76R8BEnSJc0mbKxgzQMg0P0bnOpLbVt6ut4ntUCVC3YQqHFuRBD0WvCm8Fcr65Cz8O0cCP/66bCZ9AzpkuOc4qHFe5knsQ6lsdPwqLdEkobBHsINYS0syxiAezkN6HgDWpvEbYy2pn3TVYHcUvREiyTluo9Qy4u2pMQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC8img3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC8img3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9440C2BCB0;
	Fri,  8 May 2026 04:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214956;
	bh=h+kJQeLZVqnSeeiwM2bc1dXa4IpY6mXgTH7Yn+fO0vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MC8img3fZcoaufhCUHIjlXV78rrNtXBpZ+N+uy5+7qUzuQbCLewwJwHFiUaftpt5g
	 LQjTggA6Mc1fJr8ckvs748ORbJ0NIw/Bqs6pS3FJ38ubwO6DVE1//XBEXr8bHndFVU
	 pAJ3/4UASkP+vsfyDt2KLDLILYchQWVIvjlrcdoeb3Q98Od69syCOERuu6+bdY8vKZ
	 92sHhJjKfRPyAOJPUWEqEJE5g1VgHjlsYhdXhvoN2LvwHrSmjcMN8uusU94oiaC/eu
	 HHNyYsa/J257vDG1DYYX3gVI0gfb9mR4CE9NURHOBL5QKSRN4T1kpq2nWqah/eh+j4
	 7YWsi91POa/nA==
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
Subject: [PATCH v7 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Fri,  8 May 2026 04:35:21 +0000
Message-ID: <20260508043543.217179-3-kwilczynski@kernel.org>
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

Add helpers to check whether a PCI resource is of I/O port or
memory type.  These replace the open-coded pci_resource_flags()
with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
tree.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..e93fbe6b57fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2300,6 +2300,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 	CONCATENATE(__pci_dev_for_each_res, COUNT_ARGS(__VA_ARGS__)) 	\
 		    (dev, res, __VA_ARGS__)
 
+/**
+ * pci_resource_is_io - check if a PCI resource is of I/O port type.
+ * @dev: PCI device to check.
+ * @resno: The resource number (BAR index) to check.
+ *
+ * Returns true if the resource type is I/O port.
+ */
+static inline bool pci_resource_is_io(const struct pci_dev *dev, int resno)
+{
+	return resource_type(pci_resource_n(dev, resno)) == IORESOURCE_IO;
+}
+
+/**
+ * pci_resource_is_mem - check if a PCI resource is of memory type.
+ * @dev: PCI device to check.
+ * @resno: The resource number (BAR index) to check.
+ *
+ * Returns true if the resource type is memory, including
+ * prefetchable memory.
+ */
+static inline bool pci_resource_is_mem(const struct pci_dev *dev, int resno)
+{
+	return resource_type(pci_resource_n(dev, resno)) == IORESOURCE_MEM;
+}
+
 /*
  * Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
-- 
2.54.0

