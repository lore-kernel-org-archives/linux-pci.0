Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD33E8C52
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039046; cv=none; b=PdrRxQvroL251D0UMPyX9EVvdrB4E6EboYrjQf07lT9d2bxUpVdzfkcs4mLvdTXsbTly2ubJnKFQceUCPS/A/jajVydXvOtiC4TZ7A6gjkZL82Sv1gf6KfTU5NlOiAFc60G0wde8L4NUeTmFWJ1TOwEEObLj0V8iwSrxw1vpPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039046; c=relaxed/simple;
	bh=BiZdYZ10oL1f55oVAP47WgrRQOSSvegymMz9vjIkBHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDm3osIbRNi8Tchbph7YiyTEdG+zax22WL6tRtcxySeptCDsAcv4G56/UzJMy1NI34dmt5ettrvpfl2r3pQ7pTbVjVW9PPo+GqD5xzP5sz7Tt/P0Pr1NnGj5oNb4Zy24sGmdfxo5YnquXl7ryzGLZG7DPOmUUwkMtWmuEVbDeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4dPdGKI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4dPdGKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ECCC2BC87;
	Wed, 25 Feb 2026 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039045;
	bh=BiZdYZ10oL1f55oVAP47WgrRQOSSvegymMz9vjIkBHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4dPdGKIjdGulNPoRTOZgr8I+1+b89i/gavoJ9mRYh2AYJJMoZN1krGYS+qbe+fjc
	 yBEz7swwRJip3jJx/S8yhJ72IEst3fzp4fDbYefmNTO83pr/kdeYSWYTzU4BRH2kbG
	 xw7i9iwsAOl90tZFHoCKt5il7gUGReSmz58eSGlJ1LqwhGVKbzaRQAMylTkR6nFO4V
	 xy3rTyxpfYLOtP2emQOESOwNos/EhIOeK7KKp8D4wXqg/vYxdqruJDEMbN68eB8A61
	 zo5KtC1JdtqstsWK0zKmQ2dLLtVDa+Is869hQEkZDpdeLJh0X3VokdHyU2joIVyJtT
	 mbU1WrtjI2vow==
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
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
Date: Wed, 25 Feb 2026 18:03:26 +0100
Message-ID: <20260225170324.4033466-14-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=cassel@kernel.org; h=from:subject; bh=Zg6ckjc98vCLhAPfUK/ZqioFk2nlRbszSHiX5dxQx4c=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLnaycxpCv5P7Nd+GeB97HgT6IG6dzBV2U8y5efMUlvN bj1ZuuhjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWwIF6cATOSlPSPDA+kFnZeKF7cazjIK mle24CZ/+5f3d+/3z3pvFiodyCR2luF/3Y1Gy0WGrbu5Li6cE52ZHq/c+WJ7+vUry9Wyz3y4Yxn BAgA=
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

