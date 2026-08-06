Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8C43BDCD;
	Thu,  6 Aug 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015545; cv=none; b=AQM8rVrbqWlQujwZpngfSrO7hGm4m2sR+mnoTAx/WdEM06HXxQBT0v2OfMxLAAWQMyBi6B9SvmSNKqIJyEyqR343/qdsXZEhscF+K5/wjYos9HuKdjsyZCvSrjkVFftSdfEL6h0YaNGzVRT8vT2yQ/CBBvlHT77WTyoZUXgfc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015545; c=relaxed/simple;
	bh=nynccnadfP7oBkpYJx7nlv1LiYLH9K/Ri7uFu4DBtzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/hjEjOfbTmo+kT0FhHw7EAtygEUYy/qjGLYMTupgyQA1jFERwh0aaEitNXQ7OWk6Sy7XAfzkb/DTF5+VknZS8qkDwyGyTYok0eJdL6hBz9bjMyc4VV7tAwn18bcpfNyjjSs0QrzT5T7lwv2OHbmoDjw+xoEc06eGWkeNS5pO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnMpCbhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnMpCbhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3471F000E9;
	Thu,  6 Aug 2026 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015544;
	bh=Xf1hpnFV1gAlg+YZ6rAGiEiOotBe5WvmqLB9CnbDV3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnMpCbhCThGD1Qf5sXU6UL90VqBh+J/Wpssa160kng1wZPpUelpZreCor2JX7MtIS
	 JkbrLOpTNMQGx1HpwTzln/+ZiFCgn8Pv4pz99aHicFP0v33xeCBdCmdNXYpMP23vCc
	 AeLYgE+XSl7tqZTzuxDU4zg9HD61MCc9wkAtehPFxVEZ/Hq1nynpvKTSmRX84BviMM
	 OXG71GsInGVnAildrHEi06luFoQXQUhtPSuNVu0IAL8mKbrrA45X9dvaA+Vd2y0I2c
	 1W8AHFuFMLUfHdBSSkrcQXCjCwKYijNuWe+DlcwVVJAYEn3bjZ++GkiuVLSbtxRrcc
	 vsgzd60KnOrYQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 05/13] PCI: Add ACS egress control vector accessor
Date: Thu,  6 Aug 2026 14:24:12 +0300
Message-ID: <20260806-fix-p2p-acs-v2-5-0cec14812965@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
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

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c586481949dc..154eb08036ad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3545,6 +3545,64 @@ void pci_configure_ari(struct pci_dev *dev)
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
+ * pci_acs_egress_ctrl_set - Read an ACS Egress Control Vector bit
+ * @pdev: ingress Root or Switch Downstream Port
+ * @target: target Root or Switch Downstream Port
+ *
+ * Return: 1 if @pdev's Egress Control Vector bit for @target is set, 0 if
+ * it is clear, or a negative errno if the bit cannot be determined.
+ */
+int pci_acs_egress_ctrl_set(struct pci_dev *pdev, struct pci_dev *target)
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
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	bool request_redirect = acs_flags & PCI_ACS_RR;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..5da067f8abc3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1045,6 +1045,7 @@ resource_size_t pci_min_window_alignment(struct pci_bus *bus,
 
 void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
+int pci_acs_egress_ctrl_set(struct pci_dev *pdev, struct pci_dev *target);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);

-- 
2.55.0

