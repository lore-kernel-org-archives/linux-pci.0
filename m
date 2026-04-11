Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8952459E5;
	Sat, 11 Apr 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894520; cv=none; b=jnmRZk/l47I5Vu+LoJFiykxq9onRJwZGNMDlj9JgPpmyh72vfYD1p9rgM135OtzrMlQ3uZhxjuLNnyR2lx7n4kEB63DkhLAOgZEyLVlKjBTrlIpiKXHTiuGesA5U4BjJvIM7R+H8LsLsS4vRrtJuuQs45LRsMwvIqet2ztikgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894520; c=relaxed/simple;
	bh=M4LBexol3vWd4MZjwunSYPnTSRksW2HSkNMaScnPtII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIhuHO/F8gBeHBp0AAvhBqPLzJU0LU5aX3e/MmTFNaYI6nzT9Dsh3je+A35d9LrqPQ47txR0M3MRRgSjafYk5jpfsEOTay1yPxSJXfocrPN3y0tr6NHgDcn2FPlVTlAChXYW2S5bdWJQ3d5/9DVf8I74Kap63t0EYA2ZcQPaftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDyenqYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDyenqYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA0C4CEF7;
	Sat, 11 Apr 2026 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894520;
	bh=M4LBexol3vWd4MZjwunSYPnTSRksW2HSkNMaScnPtII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDyenqYhmb3sg1Sk7rCtOdP+KJ/KomcwfTCFj0l3eBTWiUDAWAOTOZysGSOcziUmP
	 Vwabmjnksn5WcPK9TAY8dWQd9eAITjKdJUxRzZWOzOZXK6+rXUlWZ4IWi4P7VrWmxF
	 vFSXUm6V4VMdSv4iosNzSZ2dF1zOK3/cnJSBGNgIAuC4mdq8cX8BZx3v0rv6GxuHUu
	 EXbSO7+DTCb2AEFz4Is1ibAjjYm2J8Io+7J+wjHqXsJmBuQcAP4XNLRGwyH9e/4BZi
	 UK+mjsbcp7nkmJUIOPs/i0zNyZRELYN7jGlca5yJjEJ9EYIO+U2XaBI8QS4zKrUsvE
	 RVYB7jxYZ2hYQ==
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
Subject: [PATCH v4 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Sat, 11 Apr 2026 08:01:26 +0000
Message-ID: <20260411080148.471335-3-kwilczynski@kernel.org>
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

Add helpers to check whether a PCI resource is of I/O port or
memory type.  These replace the open-coded pci_resource_flags()
with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
tree.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..05aceb7f1f37 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2295,6 +2295,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
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
2.53.0

