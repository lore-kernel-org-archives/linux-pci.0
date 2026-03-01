Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10311EDA0F;
	Sun,  1 Mar 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328638; cv=none; b=a+SgP0Q+flKf6WT+3s21R/uk1jR83xG1NH3LjP8WZ9ZfBd614VecIiROTVAP5T/a32h2mrFarmYvC4JnOm0OFFiYjcv1JETCJPHb5vkS1+18qopMt6g9m/xtvCi6Z1EAD2fc3i88ezDW/dm4Nl/HMS7BD2LpDHWVoDSWma+tEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328638; c=relaxed/simple;
	bh=DIa2z7C57otaZFMYrdXFGJmpnPIdqE3uqKAIdrysHYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgS18Cb+9Vg/YwwFWcFyu1Fw52O8lrubkjszk/S/iDQh4dUlJ6ZofB5MRE+jnLH18dKwQTHAHYFyN4Chqg+Fbt09R2SDCm5BqsbUTSHVm8+SGXBH858rTD/js0WdANaLJyh3UZXBp0i9ksp/tXCToxmZC8WpXuRgh1gf9xYviAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggo2jY1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggo2jY1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9284C19421;
	Sun,  1 Mar 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328637;
	bh=DIa2z7C57otaZFMYrdXFGJmpnPIdqE3uqKAIdrysHYM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ggo2jY1CgoE5VRcTH28KHsL9eQ9hzX5cbKWuXUtJkOJcnYGiRfGQ/x7fcUe/vgQ4x
	 np10sOV1MHN+q50jCIJamuWp1rXXKl8QG+Ba6lcKnuCDMDRmZQVmz3Hp7F8l2TxK/m
	 NH3YbEJM2nsN+NcYinFL9jwNEoFpzdtDB0ltiEdp/ANx6+L2p9y0DvjGMf0qWjQk3V
	 ka0ebI4p2T4xuyzly1PhkAmXQw8gPPkzFjUXTmzUhZzmkDdTliAm2Opx+TFXp3KI7s
	 lBegd/MDhOw/hAhI26jAwBjYpR+/1wXOaPXeoB80K86c1a+S8a8SaKuqNjdb6vxvcg
	 QgW8jZh8wMZuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "Revert "PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported"" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:35 -0500
Message-ID: <20260301013035.1688793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7ebdefb87942073679e56cfbc5a72e8fc5441bfc Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 22 Dec 2025 07:42:11 +0100
Subject: [PATCH] Revert "PCI: qcom: Enable MSI interrupts together with Link
 up if 'Global IRQ' is supported"

This reverts commit ba4a2e2317b9faeca9193ed6d3193ddc3cf2aba3.

Since the Link up IRQ support is going away, revert the MSI logic that got
added for it too.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
[mani: reworded the description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251222064207.3246632-12-cassel@kernel.org
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e87ec6779d44f..c5fcb87972e91 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -136,7 +136,6 @@
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_UP			BIT(13)
-#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
 
 /* PARF_NO_SNOOP_OVERRIDE register fields */
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
@@ -1982,8 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_host_deinit;
 		}
 
-		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
-			       pcie->parf + PARF_INT_ALL_MASK);
+		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
 	}
 
 	qcom_pcie_icc_opp_update(pcie);
-- 
2.51.0




