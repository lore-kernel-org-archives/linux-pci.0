Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B818FDBD;
	Fri, 19 Jun 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859133; cv=none; b=F+Hcs+Fqlt+XxN0peXpjDNxjVkl4GL3nY1ScMC0GDW6jBWPtU4XaeGtHR0VIJKxbbGYz01iw6H0PFM2Lfq1DhKMBvn8nbGBxQIfs9KbThoOmEIwxqr2gjf9Ix+hdE9sAjHVdq2TzWKdY1qSA78IEIHYgB8tVfc7pf0X+6kvOsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859133; c=relaxed/simple;
	bh=h+kJQeLZVqnSeeiwM2bc1dXa4IpY6mXgTH7Yn+fO0vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUJ/qYGggQAXe2bngU5dAzLjAN99Z3eom5B0G24wqgUT3rcWTL39au5gobQD01L3Z5S99I4ME3XM2y6nP57G6eQUcR3Ai060TiACkDruwtSIjdHpMR4cz0DjD/pb4lywK/T23ATAcznqgNVmounONdVJ/IN9Kcq5QnMpM03v/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxblK0TO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxblK0TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A41F00A3D;
	Fri, 19 Jun 2026 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859132;
	bh=J0zsLA5ryToNAxAxjQD54oSfvFP26rqE2yjtK6eduNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxblK0TOn4bdXlw02y2LSJlKBmz55vqoszPIyo2wScT9SEaCVMALNErCNIHU/x8cW
	 5QDql3kwgR6b5J3c5PGbOKl7izAejKIySikHILgUg8fKsWay4B2ob57K5VqS5IHjmE
	 /5sAAvWBib8AKzAbp7cFItA3AN4tK0n4VIVpo+mFSuHjnFcd84rEZ/eQe1+i4GBCZp
	 TlCIPhhqE6AEhOMb7IKPq8yBVRPr4jVrmomdy2A2bUOkCXUhlgV3EqHWGDXfxx9BgW
	 jOW8ci+SaDl3HCxnSZKrA67oQPWPD71n1gSyDE1w61LXNpoL/yv7xgxSztTT6FwQOF
	 cNIzqHMrBRPEw==
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
Subject: [PATCH v8 02/25] PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
Date: Fri, 19 Jun 2026 08:51:37 +0000
Message-ID: <20260619085200.3729431-3-kwilczynski@kernel.org>
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

