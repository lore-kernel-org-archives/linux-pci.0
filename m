Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0A43441C;
	Tue, 11 Aug 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440716; cv=none; b=RwfV2M9dEpH9n4AuW0Ktgsrmr8sHoJgl66TYWqWaChayW8mv06H5P2oeV+kVQ9JLlSA1gYBeqQ2ZvyAgEWxRIf1IcfT1Hi3Qnfe5si5XCfiUVo8Qvxkzn9lcmI4kWG5OT/TLGGpM4N/u2xIM0T89SVeEpaGO0HMdG7D/FRPd71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440716; c=relaxed/simple;
	bh=lV4jEK4svh+6UshbsA84C+hjExtusy0e+WQBHxPePYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9IL7VjbE8nxt8LfO6dXdGAHve30M5IAVRULAFXWI1QnTHbsvOrDQtD9zvkLAa21JYoFRaKfJ3OiQnFY5VnhXHLfzMnLl0ouZyb+nbftWOk/bxFMKdG9WVv1Yf1JsPPQuG710QUatIIHHsJq4kFSRQ7NjF7LFWpJyct7p5plp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULF6cKOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULF6cKOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CEC1F000E9;
	Tue, 11 Aug 2026 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440712;
	bh=048mN//99k0AQtFFFqqA1UJMkxuCpS/5Uf5l8gCWCE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULF6cKOty2zW/8CWeek7MWqZ/kw0rxjSkjR/t6Y2BiN25Zx7Th62pZB9QPugcw0zd
	 1rHVU81ITwu2VIfURWR9g8LGbpBrQaK0UUrxGMzf6DmpkTxmQpKAcrKRl30uDoai1f
	 NcUlPUiyCv87EQOX0RCV3LBjrPz+JnJGhLvCPV0aVu63EvqBw+FZCL4va/O72hgurF
	 2IkYdhcyyDZGxwSAZqK4k/8G5nkVRZVhrNr42ECD9p6QMCJgHI1gA2B10KFpEfD1d6
	 N8O8s8BiNN1i1hb8b8yfTdW4CR3IXsKAMgITKxd89tfC0LruopkidkHKe4s1NF12qr
	 u19FRa5Nn8dOw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 09/17] PCI: Add ACS egress control vector accessor
Date: Tue, 11 Aug 2026 12:30:51 +0300
Message-ID: <20260811-fix-p2p-acs-v3-9-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Whether ACS P2P Egress Control routes, redirects, or blocks a peer-to-peer
request depends on the Egress Control Vector bit for the target port, not
on the enable bit alone (PCIe r7.0, sec 6.12.3).

Provide a helper to read that bit for a peer Root or Switch Downstream
Port. Report an unreadable or uncovered vector as an error rather than as
a clear bit, so callers do not mistake it for permission to route
directly.

Each bit corresponds to a Port Number within one Switch or Root Complex
(sec 7.7.12.4), so both ports have to number their ports in the same
place. Downstream Ports of one Switch share its internal bus, and Root
Ports of one Root Complex share a root bus, so require a shared bus and
reject anything else. A target numbered elsewhere has no bit in this
vector and would select an unrelated one.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 492bb26a99de..8d165c9534ff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3545,6 +3545,74 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
+/*
+ * PCIe r7.0, sec 7.7.12: only for Root Ports and Switch Downstream Ports does
+ * each Egress Control Vector bit correspond to a Port Number.  Elsewhere the
+ * vector is indexed by Function or Function Group Number, so a Link
+ * Capabilities Port Number must not be used to select a bit.
+ *
+ * pcie_downstream_port() is too permissive here because it also accepts a
+ * PCI/PCI-X to PCIe Bridge.
+ */
+static bool pci_acs_egress_vector_port(const struct pci_dev *dev)
+{
+	int type = pci_pcie_type(dev);
+
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
+	       type == PCI_EXP_TYPE_DOWNSTREAM;
+}
+
+/**
+ * pci_acs_egress_ctrl_is_set - Read an ACS Egress Control Vector bit
+ * @pdev: ingress Root or Switch Downstream Port
+ * @target: target Root or Switch Downstream Port
+ *
+ * Return: 1 if @pdev's Egress Control Vector bit for @target is set, 0 if
+ * it is clear, or a negative errno if the bit cannot be determined.
+ */
+int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target)
+{
+	unsigned int vector_size;
+	u32 lnkcap, vector;
+	u8 target_port;
+	int ret;
+
+	if (!(pdev->acs_capabilities & PCI_ACS_EC) ||
+	    !pci_acs_egress_vector_port(pdev) ||
+	    !pci_acs_egress_vector_port(target))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Each vector bit corresponds to a Port Number within one Switch or
+	 * Root Complex (PCIe r7.0, sec 7.7.12.4). Downstream Ports of one
+	 * Switch share its internal bus and Root Ports of one Root Complex
+	 * share a root bus, so anything else numbers its ports elsewhere and
+	 * would index an unrelated bit here.
+	 */
+	if (pdev->bus != target->bus)
+		return -EOPNOTSUPP;
+
+	ret = pcie_capability_read_dword(target, PCI_EXP_LNKCAP, &lnkcap);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	target_port = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	vector_size = pdev->acs_capabilities >> 8;
+
+	/* An Egress Control Vector Size of 0 encodes 256 bits. */
+	if (vector_size && target_port >= vector_size)
+		return -ERANGE;
+
+	ret = pci_read_config_dword(pdev,
+				    pdev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+				    (target_port / 32) * sizeof(vector),
+				    &vector);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	return !!(vector & BIT(target_port % 32));
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
 				  enum pci_acs_scope scope)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6230adb39166..d3ea9b2bb7fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1069,6 +1069,7 @@ static inline bool pci_acs_rr_ineffective(u32 ctrl, u16 acs_flags,
 	       (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB);
 }
 
+int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
 				 enum pci_acs_scope scope);

-- 
2.55.0

