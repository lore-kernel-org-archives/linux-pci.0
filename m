Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574439AD3B;
	Mon, 10 Aug 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402219; cv=none; b=ACikwXA1ImdgDiVMdeKr5VJN7RM79uS5/On6KoXeGOT39LInAp2FUf6bnkoD0F3vaiqk/kLv9W013RbZ+4Mk5vKAAHE371aQvSEZ9mQtEvFzvRizFEEd2GWFdbGwgUmphF+SOI+YxaaGB25VD5oxy3qnj0Toj/N1zXbL2W514kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402219; c=relaxed/simple;
	bh=gP/fNVBFjn0Rdf4qPPe94sujlET025pmS/jkSNT7CXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAlwIuH/5cVwS6FdfDtzB27Q5/oYK81zfUanNtLxnNbLiWHOypSIggAd7QKjQ12fNi72rccg6NfihAkp938OcV65j358aghv3DGGbAMvCUuQKxY2pkkP09oNVwDl2T/KGgsvqiqVEOa+RR3W7h9Fzox1EkswxLWsucNXQXBm5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX90LC4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX90LC4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE01F00A3A;
	Mon, 10 Aug 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402217;
	bh=+D4M/uHINnEQaeAisENwcFYZdRyOd0W8ZlKKo1bHHe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX90LC4JDSOGj/m4G6MJBm87B083EOWD/lEMpNFvsFMP8+D1aJ4ujqlGPMB7SzjfJ
	 BpKYfsrVBXJl5k/dugHYt2niL/COIDKQ61wzEtuHlMcrBE16rLatdpyJ4SKfDLcyu8
	 Ooc/IGPl2RzOZhrmzs6dLDyRgO1br6CdIMUo127xkxhaOYEG4Aqm4f+6kBlXMBY/cl
	 P9Y+Wjr39uv5l9JokCI0fXvEueUAJpw8V5MWVIEcko45nQSYkfTKeg5jP2/IMzqCGj
	 PM9vYpVGnWuVutmmMWD1v3+EwvTDauRwRcnv/m8MHeOoI1YJADEJiLM6sGPufPW35c
	 vQwlnl55l4whA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	dakr@kernel.org,
	kwilczynski@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com,
	ttabi@nvidia.com,
	apopple@nvidia.com,
	ecourtney@nvidia.com,
	shashanks@nvidia.com,
	zhiw@nvidia.com
Cc: driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] PCI: add pci_irq_type() to query the allocated interrupt type
Date: Tue, 11 Aug 2026 00:47:43 +0200
Message-ID: <20260810224800.2314458-5-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810224800.2314458-1-dakr@kernel.org>
References: <20260810224800.2314458-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper that returns PCI_IRQ_MSIX, PCI_IRQ_MSI, or PCI_IRQ_INTX
based on the interrupt type the PCI core selected after
pci_alloc_irq_vectors().

Several drivers already open-code this check against pdev->msix_enabled
and pdev->msi_enabled, or even open code this helper [1].

A common helper avoids the duplication and keeps drivers from accessing
the bitfield directly (see also [2]).

Link: https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196 [1]
Inspired-by: John Hubbard <jhubbard@nvidia.com>
Link: https://lore.kernel.org/all/DKKG2QM3YJYB.Z2H2B2UXJ75N@kernel.org/ [2]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 include/linux/pci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..80b8561b5be0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1783,6 +1783,26 @@ void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
 
+/**
+ * pci_irq_type - Get the interrupt type of a PCI device
+ * @pdev: the PCI device to operate on
+ *
+ * Discriminate the interrupt type the PCI core selected for this device
+ * after a successful pci_alloc_irq_vectors() call.
+ *
+ * Return: %PCI_IRQ_MSIX, %PCI_IRQ_MSI, or %PCI_IRQ_INTX.
+ */
+static inline unsigned int pci_irq_type(struct pci_dev *pdev)
+{
+	if (pdev->msix_enabled)
+		return PCI_IRQ_MSIX;
+
+	if (pdev->msi_enabled)
+		return PCI_IRQ_MSI;
+
+	return PCI_IRQ_INTX;
+}
+
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_disable_msi(struct pci_dev *dev) { }
@@ -1845,6 +1865,11 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
+
+static inline unsigned int pci_irq_type(struct pci_dev *pdev)
+{
+	return PCI_IRQ_INTX;
+}
 #endif
 
 /**
-- 
2.55.0

