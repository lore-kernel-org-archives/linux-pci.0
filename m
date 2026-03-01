Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9E1E4AF;
	Sun,  1 Mar 2026 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327921; cv=none; b=IEE1H80ptY/ggDRS6zHUbNBukmfEu1U7a1eDGDgvvpzV1gpGyIoXyqyFixE5mgkOwxat2HMCt/ophjShH1INRj0Sr/FEAE1YfmA6g8uT0FidhiJLanf49sqY4fh49iDoUA4Z6CIG5VjfEXSrZ5MEo/hmQjBvOL6mdq+IMAfYtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327921; c=relaxed/simple;
	bh=Azvw4qdyjkxFA7XLpZS+79i/nX3i1SUO+MF/PkhXQs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kykmz6rVnxbutWadAQZgzFwRnxWaQWCcCLY7H6XKRu4Go2lnHVUC+NsZm0YTz09GMTro6JT7psK28L75IboYXdpYoji6zUJuUFe4+YDCNWzCh/o7e7BJ/e2psQvqDAmlXYlbUFUADTcVwdDf3ESa4nAurMANwqttYP2bwaPAprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVT91QZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVT91QZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF84C19421;
	Sun,  1 Mar 2026 01:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327921;
	bh=Azvw4qdyjkxFA7XLpZS+79i/nX3i1SUO+MF/PkhXQs0=;
	h=From:To:Cc:Subject:Date:From;
	b=XVT91QZTVAaCL5SOMNA6Bi0aKpl+e70z12kX5+xu0yzVXk4XRBebnIJ/PjlmRGojN
	 0H8izsQJaW+o1lu3gXunW7f1fnkIUZRBIHLvwBhNmJhNEF0EJ8zoQcg9UKnKCFxD/s
	 SFVJ4iMZjpoZgqM3LZQjtjlVHvKsXCmEpKDl6ke+n6/8TFYrtt/gj240LgfdMxYFPZ
	 Tatj7Ca/DTerbvX6jq9T71P2hyo1JxhQ1tG/gH5nByzHf2RZXiZVxnmM1DXsth2mqL
	 jGOpExXVujZDL3A1pd07QyuwurTRCQP0oTFfTVeFc/2rOdBdHGC6S5jpfEqAI4Dq0d
	 QbQg22jI9KGQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "Revert "PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported"" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:18:39 -0500
Message-ID: <20260301011839.1673093-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




