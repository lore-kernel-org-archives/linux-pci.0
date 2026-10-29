Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259368;
	b=zfC1SdMg7MlIbg04hWgZjQpKzS/Ait4PNaKVSIqkS0q6/47E6P1YkAo/Gf2iZOtAzQUB
	 m2NnrEA7hZ/Hv0d/1TpLXkCn29/zu3Zl1CivYzlZIbr9zalBzgu8uWKINW0TdpDodfK68
	 6WoctUcUmrAKfN/yc79P3kvG2t3UjzhZ1gBXgdO1snlHSAxgb3egg93Ww/2tCuMbMFlP0
	 5kk7mXOs40PvNPbqZB5SFD6+imv/1ivr2DbpIx7tA8aSWbtDQNc5N5C944a3Dwb61GSj5
	 8Jzg7WruHRo2teJtBT7b8/ApybvnsNd3i9HmAMT9DgwHs+NP1wSkLPmBbaBAJm6qNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259368;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0gBUd5jJHGj2LvC1m8ir7f7MkneqJ2TxhRwTgxUGW4s=;
	b=qdZv5mhGx2RjBHA+EJdL4DhNlMA2WSW3N0cgG54ZOiY75mdOT+a1xfCbx4gydDuVxP0T
	 xDE6Hw4UG8BHCN58YGTGASNJ1Vu0KmqTT5r8UjrGA2Qapg7aylPusxeiQir7AFLsnb3N+
	 99iUo8Dh8xEFM4m85HKvnLAn6aZjnZeYkRXyi3aP7gFTW64muY8Ln7ba21mV01bJS0YWW
	 fKJf7erQUXSIJUNdjLJLbFhIwSayPn4QhzIWIIHNiQTF0ZG1ZGw3Vpkybqq7XNO9t6RBF
	 y1lDKEEqtemDYDbGo2R3fYcI4kKch3nfn1AZpRNO63qo7ee8bya+k4DUtgF4vvactcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEnPCkwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB738606A320;
	Thu, 29 Oct 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEnPCkwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE051F01825;
	Thu, 29 Oct 2026 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259367;
	bh=0gBUd5jJHGj2LvC1m8ir7f7MkneqJ2TxhRwTgxUGW4s=;
	h=From:Date:Subject:To:Cc;
	b=YEnPCkwAU2o1DTOBBoPs8ZS3s6493xl3T1xVf7fVU0LBDzMU7LFXmXZMmgcFZD35W
	 wV0Iq7lYIhKBNjeiBm+AfAg4wFiAxJw18IO+1LRrCPLnKQ+XbFcfgkpPQlFnqSBBE6
	 x8cso0m9D2/iv0/2jFlmUHVlDENej0MvwAh5owg4LEbovxjCnTYtL+uekLgROYvDGL
	 4IRgf0T3rofH6gpPn0e1gMbpz0HAQ6r9vQKFZhdPe9RnEk/DQsfk7UeusdAzUAYwOm
	 0RBKYq1Go5/jBkYwWDeLNaH7GqNJKVqxCzk5gx5tcjVndgMVroRM6ObucLraFX6f9/
	 oZ9BV411ONL7A==
From: Eugen Hristev <ehristev@kernel.org>
Date: Thu, 29 Oct 2026 09:25:19 +0200
Subject: [PATCH] PCI: iproc: Fix MSI shutdown operations
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-iproc-shutdown-v1-1-05f828561116@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN704moC/yXMOQqAMBBA0avI1AZiBEGvIhZZRh2LRDJuELy7U
 ctX/J+AMRIydEWCiAcxBZ9RlQXYWfsJBblsUFI1lVStoDUGK3jeNxdOL7QxxmItldMacrRGHOn
 6hv3wm3ezoN3eC9z3A1e4wtNyAAAA
X-Change-ID: 20261029-iproc-shutdown-abbbce302daa
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Marc Zyngier <maz@kernel.org>, Vikram Prakash <vikramp@broadcom.com>
Cc: Anup Patel <anup.patel@broadcom.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Eugen Hristev <ehristev@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=ehristev@kernel.org;
 h=from:subject:message-id; bh=e5i4rIOHYC9b5xjEEnkOG0yjqcJV2VKbsARhJj7+xXg=;
 b=owGbwMvMwCXWkjcnuXne3fmMp9WSGLIefY8vLihv/frkyqmaySpJRtLzut+4mM5RenRkzcJfk
 R8aatnudJSwMIhxMciKKbJUm/yrFe7f4X7S1VIFZg4rE8gQBi5OAZhIgyMjQ5v/ndtBcqW17+be
 mHlir6L0O/N/H5pm93+bcP+4zOVfctsYvukFLTzJ9q+Gz+iMx56yXUKPv0ppzZ7A0lWytdcxpHc
 rPwA=
X-Developer-Key: i=ehristev@kernel.org; a=openpgp;
 fpr=AB184498D27A77B65D7852C81EB31E020EAC2FC8

On reboot, shutting down iPROC leaves MSI irqs enabled and not
cleaned up. This can lead to IRQs being served after the iPROC
was shutdown.
Fix it by implementing an MSI shutdown procedure, and call it
before the iPROC shutdown.

Assisted-by: Github Copilot
Fixes: 3bc2b2348835 ("PCI: iproc: Add iProc PCIe MSI support")
Signed-off-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c     |  3 +++
 drivers/pci/controller/pcie-iproc.h     |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 9ba242ab9596..1d19db67f314 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -651,6 +651,22 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 }
 EXPORT_SYMBOL(iproc_msi_init);
 
+void iproc_msi_shutdown(struct iproc_pcie *pcie)
+{
+	struct iproc_msi *msi = pcie->msi;
+	unsigned int index;
+
+	if (!msi)
+		return;
+
+	iproc_msi_disable(msi);
+	iproc_msi_read_reg(msi, IPROC_MSI_CTRL, msi->nr_irqs - 1);
+
+	for (index = 0; index < msi->nr_irqs; index++)
+		disable_irq(msi->grps[index].gic_irq);
+}
+EXPORT_SYMBOL(iproc_msi_shutdown);
+
 void iproc_msi_exit(struct iproc_pcie *pcie)
 {
 	struct iproc_msi *msi = pcie->msi;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index afb3aa38ac6b..6f3dc2f81a1c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -756,8 +756,11 @@ static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
 
 int iproc_pcie_shutdown(struct iproc_pcie *pcie)
 {
+	dev_dbg(pcie->dev, "quiescing MSI before PCIe reset\n");
+	iproc_msi_shutdown(pcie);
 	iproc_pcie_perst_ctrl(pcie, true);
 	msleep(500);
+	dev_dbg(pcie->dev, "PCIe shutdown complete\n");
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index c4443f236ca3..54e6e365774e 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -114,6 +114,7 @@ int iproc_pcie_shutdown(struct iproc_pcie *pcie);
 
 #ifdef CONFIG_PCIE_IPROC_MSI
 int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
+void iproc_msi_shutdown(struct iproc_pcie *pcie);
 void iproc_msi_exit(struct iproc_pcie *pcie);
 #else
 static inline int iproc_msi_init(struct iproc_pcie *pcie,
@@ -121,6 +122,9 @@ static inline int iproc_msi_init(struct iproc_pcie *pcie,
 {
 	return -ENODEV;
 }
+static inline void iproc_msi_shutdown(struct iproc_pcie *pcie)
+{
+}
 static inline void iproc_msi_exit(struct iproc_pcie *pcie)
 {
 }

---
base-commit: 6d0933ae9d46674a6ea63a87e9e9ab4e662670c9
change-id: 20261029-iproc-shutdown-abbbce302daa

Best regards,
--  
Eugen Hristev <ehristev@kernel.org>

