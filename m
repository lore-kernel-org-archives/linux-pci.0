Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1573B8BA5;
	Sun,  2 Aug 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683418; cv=none; b=UJAq6p5kF4cTiGahYLMf/bGGDhX86KK7sLxHQvq6P0nxDL+qWNng3feiMQJVRpiW0Hy5TkUED4N9KGhUrb9ivVGDituekBWPDsLph7efJxySfMDaB8RDmNkudN+Xyj5cZcN099Q8meIHrABHU0i9L8fJ6inXWesUT7Hdz94Cvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683418; c=relaxed/simple;
	bh=QIn51PBe4F3qbFqErtrhQVaNaMqR4v8oZ3NCV6UHk9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFbVCcqXl9FhL0TN4auaeoiHU5ISaQ3afsWPYnsQ6vsqAJxJnwPCezAkdVGXcwohtO/5Wj/bwynGsP3hCXOhVnWjzospfZnag8yQx2eAMa9iKPwNUVtQ8gJyrzsZfWahCfPAsJ4mH8QlvqfwXYGWm4fR9/4hofgyh1fWUlwtzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOtlmOpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOtlmOpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3645F1F000E9;
	Sun,  2 Aug 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683414;
	bh=fRj143jgUPW88jFD2yowRZvlsut0lLiYHSAK2WguMUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOtlmOpcBlVphrd81vtnryZOaBNdAbbnoAxGCASntnO29xL3EDfuud7p/AC9IlRPC
	 w+vjLz2+uZ2tJpuUJHv2WU/Wzmf/tJKf+RbFN1FAOomdRoax8wE6EPDwV3DOfgG8lT
	 v+YYlfPnK4PKvLGI2fLKBpeEsZZVVb2s44Wq4vhoioly5jenlYARvvG3lMKoKRBZ2L
	 3552aE+izl8J8fmoCkAq2eyR8bUxChsHQV2e+W3fSWvbjnmgnU/TwmnReVThlATqJM
	 JpiJC0s8wndNGrIhTktgy17gDrIjPzYlXgm7bcGrczXjXlWjhqskRPoPhRrZjO7P07
	 z3tZGVeUVvO9A==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 04/13] PCI: Account for Direct Translated P2P in ACS isolation checks
Date: Sun,  2 Aug 2026 18:09:42 +0300
Message-ID: <20260802-fix-p2p-acs-v1-4-a7c5eb64fff6@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
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

