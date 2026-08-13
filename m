Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2339734A;
	Thu, 13 Aug 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639986; cv=none; b=MPGLrtIpHRg080BET+9ypjrVDWQCSUZNpjug8lLyyxwLNRfTb3gjkZnjK0hD8S4xjTY955x7ffd857O67EaJ1+UJxSl+ooHNwlRYvS3VN5/Rv1nUVnHhRkYqZp1mRHBc03rwhR1OVp9yERmTnMUan7mUBth32rG3OzCU7YwV+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639986; c=relaxed/simple;
	bh=SxRFUhUU5h1XP2YbXa+kEdngzcJUW/wc1Ts5GbKE2Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQAg8pnF4+kpjswgUVqquv0mLGzM4X4M1ltWOJ/iEWf1syTaI/xToFQjLiNcCp8MPmQD5zAsRWmFoIiHsDjqfMoXAv4gL9+1GjfxXNYPIyLPBwJdIN2Qk8c38s94yENSo8ZwoarWudG/D96osX4a65hpYkQg0SQVuD7BvpVa4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M75wEAso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M75wEAso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F9A1F00A3A;
	Thu, 13 Aug 2026 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639981;
	bh=Kxof0d8W6WGj+wx5sWeP30W7ePh20mC1cgGL98Rry/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M75wEAsotmSi4SfTkZCHlzd4j0X80af8OVd0MwvgRh300+qTOVN/UIIXSekYv962+
	 7NZ8NBGKn5GWX8eCl0p+NnWtKISOWWLWiC5720FJSmzsLGq0/3V1r17P9U4IuROgv/
	 9j/7tPANeOe7qaW5IDO+Tt5tO4rOAqsHeKuZvugxw1ruXtgCGoJ0WjPFhW8jaFZlL2
	 GkSSnboBkHWGE/qQeAa2kyxVYDZZIBjSnR1+tVj6yM3gaDk/yrAgf+7WwCyOXeMQzh
	 jAa5F3CLL2g8OvjH+6x5KNOWrz/FL9hkb13Q6GsB8FQwo137UbzQmSOIEACfswWVKX
	 q8DxLCVyc3N5Q==
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
Subject: [PATCH v3 4/5] PCI: Add pci_irq_type() to query the allocated interrupt type
Date: Thu, 13 Aug 2026 18:52:04 +0200
Message-ID: <20260813165234.620555-5-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813165234.620555-1-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: John Hubbard <jhubbard@nvidia.com>
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

