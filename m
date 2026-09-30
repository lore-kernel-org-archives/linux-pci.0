Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DE4AB3C0;
	Wed, 30 Sep 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779851; cv=none; b=a3TMeubEbxeorFQMEJ6Sc3l5z5qPYnvd5sQZPmUID8ovUxq0v4aCG68DlyzU3DuQt4KDY7/CdAFHksiBJvSMH0MUcuSnHTC4LqdL9Mx8KnxtFuIlXVzlLULvByFaRyyGESOecOisqwJ93ooWh/JFw5uJdMytAndYVCk3m1+kzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779851; c=relaxed/simple;
	bh=rlNDwOLzu7ttLsyeROV+rK+yucTFtmlzkPThqRA5V+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJYCLGtXxbjbYU6tacZB0YzkkbFfbx2vOmSwYF/4Kgxyae1FKZzxdVms2TfaUh5C8ZV1eSU1ub8HgipeLRXQ6G0ptYkcw6YVdN90ty7y29vc+wj8C7SkiKoIeLEtll8hsQJ6qkXeCH8GuXByjzh3PxhhQIL1BtLXANJ+CwAwnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk5ij4uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk5ij4uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02721F00898;
	Wed, 30 Sep 2026 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779838;
	bh=pLddcdeVhe5dBvuz28Kf0fu3WIAs8MgosfUWOghTQPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gk5ij4ujsCezLMd8CRsnjZtyu6WtHMKifO3zWhhWbyCcuZb1xH6plVtyyKB5xEfU2
	 czjGmI+kF7/iR51RMqdllhlUhnl15DOWTHTg5d4d+ktjJD1R6iPiauNf0yNnfyfOuG
	 nYzDjnWbEsc/vmy4DIHJWEIoHvNpW1POLHvx6Cmzr50A1HyIMCGMJac34fbjMxhdY0
	 B84UqzmA7lAfozDdGgoO3tFygGfbjQ2RDkAmgEd8xdKWIaUqOmQ/pbjQYhosj4Bd7Y
	 xDAO46+5NuN9i0Kt3/SU7AQcMBSVbxga3GpYyDySZqEuH56JqX2xA4oj3YiXu0RFqw
	 FCqcoX5bXRlKw==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yue Wang <yue.wang@Amlogic.com>,
	Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Keith Busch <kbusch@kernel.org>,
	mx2pg@pm.me,
	dlemoal@kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jon Mason <jdmason@kudzu.us>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [RFC PATCH 1/4] PCI: Update saved Max Payload Size in pcie_set_mps()
Date: Wed, 30 Sep 2026 16:50:18 +0200
Message-ID: <20260930145017.1356088-7-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930145017.1356088-6-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=cassel@kernel.org; h=from:subject; bh=rlNDwOLzu7ttLsyeROV+rK+yucTFtmlzkPThqRA5V+Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLL2Kq48tTfu/UbLknfnnk+PVxez+Tfn/E3Tlcd6TH1E4 rfH9W+f11HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJJHkyMtxY37952cWwRSpv ouRPL9nM/tK0IXbCyUbzI8Yc782TFwcwMuyf/ziqUM25YJvDnq1p32Rz16XOrq2WePze0yayadK hg5wA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

pcie_set_mps() changes the Max Payload Size (MPS) in the Device Control
register but leaves the copy saved by pci_save_state() alone, so the next
pci_restore_state() puts back the old value.

The PCI core does change the MPS of devices whose state has already been
saved: pci_configure_mps() reduces a Root Port's MPS when a device with a
smaller MPS Supported is hot-added directly below it (commit 9f0e89359775
("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")), and with
"pci=pcie_bus_safe", pcie_bus_configure_settings() can do the same when
pciehp calls it after a hot-add.  The Root Port's state was saved when it
was added and again when portdrv probed it.

Since commit 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root
Ports in a platform-specific way"), pcibios_reset_secondary_bus() restores
that saved state, without saving it first, after host->reset_root_port()
has reset the Root Port, e.g. during AER recovery or on Link Down with the
qcom and Rockchip DWC drivers.  The Root Port then goes back to the old,
larger MPS while the device below it is restored to the smaller one, so
the Root Port may send TLPs that the device treats as Malformed.

Update the saved copy of Device Control when pcie_set_mps() changes the
MPS, like commit 909f7bf9b080 ("PCI: Update saved_config_space upon
resource assignment") does for BARs.

Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports in a platform-specific way")
Assisted-by: LLM
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/pci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..5b126cd342ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1736,6 +1736,24 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
 }
 
+/*
+ * Update the saved copy of the Device Control register after changing it, so
+ * that pci_restore_state() doesn't put back a stale value.  Device Control is
+ * the first register saved by pci_save_pcie_state().
+ */
+static void pcie_update_saved_devctl(struct pci_dev *dev, u16 clear, u16 set)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *devctl;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	if (!save_state)
+		return;
+
+	devctl = (u16 *)&save_state->cap.data[0];
+	*devctl = (*devctl & ~clear) | set;
+}
+
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -5970,8 +5988,12 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
+	if (ret)
+		return pcibios_err_to_errno(ret);
 
-	return pcibios_err_to_errno(ret);
+	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_PAYLOAD, v);
+
+	return 0;
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-- 
2.55.0

