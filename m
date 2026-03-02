Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AA327BEC
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445615; cv=none; b=IPh4I820OJuXGLk1D3WRvZpJIhJMkjxBv94hWswT3Vr44ODw47Jb7GpCkziRktCFFi++/0/VzPsLoiySWYpyNYqfZcWsSHulCLrrKFL588zX1CcaCWqx/p7MK9fX104kTGKgKcRaqSBOTvuyjg6Z2l0GZHdTTYra+bakVsNHQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445615; c=relaxed/simple;
	bh=cEWEtVNxn7YA4HCPF4joB80toxgCA1BCz1lWZNuQ6rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKDbK71r60nl9hwZROWqIG26zUmaGXxxhhCvBeYobQjYBJFPcxilOfhUSUXT6IWogC7N+BnRRiDToxPF+JznX1z1K04s2Tc8GLatlpth4X9ZsGK7SEWKMOtad05Q4Z8f8i/id3RS2ef7E3WW/WpOSnd9USgG26a/YnIXvbdGrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTDwAe1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTDwAe1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B26C2BCAF;
	Mon,  2 Mar 2026 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445615;
	bh=cEWEtVNxn7YA4HCPF4joB80toxgCA1BCz1lWZNuQ6rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTDwAe1v2ZkW2nGqpCTCuPNlC9C9ftx3HPlAgFZlwnGGJDyszFY7SIDaybSjtq7Nf
	 XZ7gEmHZYhzDReIGLEAtuEF6+CALvINSnJoQZB4nwfkQiG/jh6+WTs6YRQCPpy+3Up
	 WplMbb/rQWLR2nalka98Hl3k7hiNin8D78E+u/EfD0N5FczRMsDVUniR+xaNM3KrlJ
	 j/XfuyjzOSsnW1eEQISptXJ/eEWdGMLdmLTdcgmG6TqfR9LAcGYli48laBbAOB2+/Y
	 I0Zo5eUhfGGi/srYgTotctdrdHthT4YbomzJgzlZtAT2MSCmSOM8/JYfZgBrqocFy4
	 v3xTW4hduua5A==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
Date: Mon,  2 Mar 2026 10:59:15 +0100
Message-ID: <20260302095913.48155-14-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=cassel@kernel.org; h=from:subject; bh=f1LYtE3q/j0+VWpsNcU5CJsbxfsJPELN/5WncWLOpCY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxlesbHV73Xgm5fYcaz7h7pg4tVkiActWCTh/DT7oc 9XAjUuuo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOJmc7wP6TojyyTYvr2VRHK uyYKLdXo3FQ0x4415cIGjfyLvDtbLjEyvOWcGbtW03epg7v61AdXTz98uv2OlzjXwT/B23+ecWZ zZwUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
are permanently mapped to BAR4 and must not be repurposed by EPF
drivers.

When the remote peer needs to access these registers, it must use the
fixed BAR4 window instead of creating another inbound mapping in a
different BAR. Mixing the fixed window with an additional mapping can
lead to incorrect behavior.

Advertise the DMA controller MMIO window as a reserved BAR subregion so
EPF drivers can reuse it safely.

Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..ecc28093c589 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
+static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = 0x2000,
+	},
+};
+
 /*
  * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
  * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
@@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
-	.bar[BAR_4] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
+		.rsvd_regions = rk3588_bar4_rsvd,
+	},
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
-- 
2.53.0

