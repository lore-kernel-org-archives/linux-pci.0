Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627522E5B19
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363672; cv=none; b=VXx6j+DuQwgzVD+ILhgQBfEpW3l+1rDLCAoe5z2bJlGz0eAg9sZfXk6gkqnHUi31sbeW39t1NK8/J8etoNiQ0S6epGMT0lStSDT/ylrU3Nvm4ZX8fg2sJtrl02/aNxW3IDfpvyrvscdhHb+kd/5/5TbIEU7nKZZuVeoYpuaNsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363672; c=relaxed/simple;
	bh=mw3yNaEjiLtrT+L0HuG+D9JSTgzEPCjD3Q6jq3Ta/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwECaTr3Gyc87ysbTHDfpFC8Vu6muFk7j+JL+180UNjZ++1Fgud4zyCUscKgp6DRVK4wP87sAbFh2K3dUXwnzR6h4vIhQEF/AlaMjxollih319JQqjgJsthq1LrqOPsn6+PCZ4KiNE3CyiA1IEWk2bbWYNRF135VJWVxXxFtHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4vEbJfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4vEbJfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C804C4CEF7;
	Tue, 17 Feb 2026 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363672;
	bh=mw3yNaEjiLtrT+L0HuG+D9JSTgzEPCjD3Q6jq3Ta/zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4vEbJfhBZh5Mu3Ukf4bStCjxqIVZpMwCP7i0eZkWAzdWbqIsn6wYCvusyCv42TIV
	 h9iiPyBaByjSiQd43Ga0Q2o5UFzA6FLrEJe8yw2Z7FDP2G3kjT1o+l7R1E6LMNZIT4
	 /zQAO8RmY4cTpxTpgNbnxN0kgg/pZwYCQXhDrq4X+1PJfSHqcJJ8j2xzuqUPsCQnwh
	 Uaee65Ze6NVs0BiV4lD0duu+33y2DQfQBVPJ7BpHwOv4kojktIj9CGC3z9xf/cBOJZ
	 TM9dHNCVg8cLoToJFw84Bu+epqrOETGYok5ISrP665nWUg9+d8T0CvHRi0GzYMMqjO
	 pGP6C1XMfuufg==
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
Subject: [PATCH 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
Date: Tue, 17 Feb 2026 22:27:09 +0100
Message-ID: <20260217212707.2450423-14-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=cassel@kernel.org; h=from:subject; bh=gHLF5xu0z81u0rODJeorxHOpp/bwOtW5+Ab5x6tbCsE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3NWV3P3moBvTzTueX4qLl5jpnjBblfdB2tfkTrMZ8 8+N0zg1O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAROXWG/3WRvxnVWf+/aPj9 sZAjVPkIa6hfbJSHzvE59r7JCdNSPjMyXIv7fshYQLayZpv97OknDmz9Y/+uuWb58/p1QXkV16b oMAEA
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

