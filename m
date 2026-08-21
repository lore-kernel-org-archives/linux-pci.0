Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EB40DB4B;
	Fri, 21 Aug 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341309; cv=none; b=h0/lMWvdfmMwXR/SbJMFaY4AKOA73gmlU3eJBvlLT4qZGpflne4U/3jp8SpMf7swseMDvFrEnPMVYmNOFtghmxR5dI6MzEnVzRH/U1CXWDKkvBgGqezqhTifdHiHkvubqIE6pGbQNBZpaW//SHszx7D4z1Ue/DXwiEhi/mJdt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341309; c=relaxed/simple;
	bh=Y5V56ajxmRifR4NicXb0rKhGluu16o6pU4cMkSQhlcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOOItC5dHQMRU0QtECViXGzXmRjcg6+T9RZG1s61JdofObwzr9zPPBi/Tjq6h+ZW63JUGGT0zTvJwgWCy4NKi+AF38bMgJEbuE61H07qJ6HqR+nMfyKNw42FamfS3F6/p5VMQp1W6Xod6Pfdf0Vj141wG93YuOS8+SGJU6kfW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G15SIM3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G15SIM3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236E1F000E9;
	Fri, 21 Aug 2026 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341307;
	bh=ReUKprhm5GJXxLLftQMXJc1jgg0gVzxELtWjMYrWXOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G15SIM3D+kP5FmDt0NMFMF+oLZEYxnI4NjGgJzrMKxAXf4xu8NCsIZFWqWo2QLt2G
	 rMjsp7oMIFwbMz21tUrRdrPqcIKlQg8uAHaKdEPWaHJ5YMfi+hJkVBny1nFM74p9lZ
	 jVGidtKoakV4XXA5EHbxsz5PnkYWj8Wmdl/6ZOAH76ob85M9TcBKX+/w1VMTFpeI1n
	 J1bHG4j7N6ZobG4/9orbWUMo0f3/mgB8nfrTVef8fR3TU5oL2boL90afMuRrZhPPCG
	 KsPeOIAiOeO+sxQkh5yHu+rV0vU6eAjeAvnByBNrKociagd5Gm0QVWSQnZB7IHyCzx
	 9LN2idDxXhBgQ==
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
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 09/18] PCI: Add ACS egress control vector accessor
Date: Fri, 21 Aug 2026 22:38:40 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-9-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

Tested-by: Tushar Dave <tdave@nvidia.com>
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

