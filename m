Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2454398E6;
	Thu,  6 Aug 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015540; cv=none; b=sR4bolD/5BwLRGVhtCeuWhKvSrBhfYARfYsH3WZOgocaDXez/Qvp1fzuxH0DOgvIBvwyRwINf1//7NVew+9wlNP7tUKDu2yFywFmje2f1ZnM83P2BdVp2TlNFIK4TE2W3VJV+OsOcFksm5BFOzZi8iaiI43FjQR25Z3xmLPrMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015540; c=relaxed/simple;
	bh=YcTPNaanc4zi3EnHUuMUJFdaiYNjCbvS3ExEPIrRpRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2SGD8NpIgl8/X0uadfPIFl4LtNsF06WBZsq/ZAnhIvbad8WJyV9vTK1MAA69bggnHhI/qNwaFd8V7cS3xTQXNF/ONohTPzScWezgNjwfhc2u+a4DXhon1lRGQIMW/aC3mEz90vvHnCA7nVVWsBMRTUSPiaUglT6TXGSLU/nGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ8X2W6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ8X2W6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C02D1F000E9;
	Thu,  6 Aug 2026 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015539;
	bh=Hdl2AAiA9M9dHtxvXCxfpdCmuaqrjic2cUmo6rODBtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ8X2W6CIhAD+pQo2WQ/n+aOpBoQp7CdhWisQLJxG9kuti9J2MgeiF2S813rrZIyS
	 FHOuLHmR3XydZH7SozbXbW0oeJsm/GAxj/Yh7UeoTIJi3GVgZv/qzmDMVq93D2L2g/
	 0Kpil/cklu1h8fg6U/X8wOY3ycU+XuuLadIFzv9rA86sLnnt6N96rxtqZfY+AI5geN
	 aGo26EYMK1bNUJyKfSswxuQF2FDSYEmZwERcGZP1ER4eOj+Hra7mnmXng4suH1fcCw
	 mt4HElacJq79Ydrc62x22iAYB/abFcWKoafbP8QwmKa8OScOETK9wEahnRJab5ge5M
	 CHLKrW6AHNaSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 04/13] PCI: Account for Direct Translated P2P in ACS isolation checks
Date: Thu,  6 Aug 2026 14:24:11 +0300
Message-ID: <20260806-fix-p2p-acs-v2-4-0cec14812965@nvidia.com>
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

PCIe r7.0, sec 6.12.3:

  peer-to-peer Memory Requests whose Address Type (AT) field indicates a
  Translated address must be routed to the peer Port/Function without
  redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
  Control settings.

Request Redirect therefore does not isolate devices below a Port with
ACS Direct Translated P2P enabled.

Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
Blocking is enabled, and that error "must take precedence over ... ACS
P2P control mechanisms". Report isolation only in that case. Without
Translation Blocking, devices below such a Port now share an IOMMU
group.

Fixes: ad805758c0eb ("PCI: add ACS validation utility")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c    | 10 ++++++++++
 drivers/pci/quirks.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..c586481949dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3547,6 +3547,7 @@ void pci_configure_ari(struct pci_dev *dev)
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
+	bool request_redirect = acs_flags & PCI_ACS_RR;
 	int pos;
 	u16 ctrl;
 
@@ -3562,6 +3563,15 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/*
+	 * Direct Translated P2P routes a Translated Request to the peer
+	 * regardless of Request Redirect, so Request Redirect does not
+	 * isolate unless Translation Blocking rejects the request first.
+	 */
+	if (request_redirect && (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB))
+		return false;
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..bb4c09cbbd10 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4978,6 +4978,7 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
 
 static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 {
+	bool request_redirect = acs_flags & PCI_ACS_RR;
 	int pos;
 	u32 cap, ctrl;
 
@@ -4994,6 +4995,10 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 
 	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
 
+	/* Direct Translated P2P may bypass Request Redirect. */
+	if (request_redirect && (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB))
+		return 0;
+
 	return pci_acs_ctrl_enabled(acs_flags, ctrl);
 }
 

-- 
2.55.0

