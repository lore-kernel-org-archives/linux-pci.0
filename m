Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A14448B84;
	Thu,  6 Aug 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015550; cv=none; b=njsAaENBV/MYbPr4scKNMtpQaCRzPG/dwqYOqS2Ieuh9IgPJ3UUMtobQIqqFGxaMATtQeNQ/2SAqDBugwA63O71ZOKs60j3vDqKBs6QksD4gSFXdcP2dpFyXAXL0iROD7b3bk+zh6MDeaZhlBG9EzEWUxLwnC/1bZJiwjQ/C09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015550; c=relaxed/simple;
	bh=r38pIzC0p+LQUUpxadctWU7eSlja8Oao0spWZDX3pTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3I/Iatz/GmiVOzEwTvCxxCBWfLEHQ/2w93Gh+39Fu0sqgkD+VrvyyoUFFoDtHHKD5F0Ie0j1IK9/ft3bS8U+lTd6FeP1w7ihC4FzFJDB7cGCMLDMd+yRSEytVcwU00sqdDYhjoiODn6ywygRtBrORD5qk6ADLTEedDzQ+kWBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH+Q5NuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH+Q5NuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3B1F00A3A;
	Thu,  6 Aug 2026 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015549;
	bh=8qB2IxVto5TkweZOPktEIgL7ELDxeJGNd3yvs7+VilI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KH+Q5NuG7c/74UeyxzObqoS9owWjYw2KrL9zl5RsLTt7zfN4+bZJDL6ANku8FBh1C
	 ZxPcG0Pg4K4XhcczcN9iFYFd9Kz9Zivr6gUAjDHzDodMUhrnmB3LtAmsMo6VXuRm24
	 Mi28+DkasIJ2wDNd/m272Pt1HzlRUCfG8yZNxwWFzQyJuxFcbnk8Y2wOWRCGYYPjKk
	 AqnXsehZ2wSU7Nw+/VsDn6yj9lJSyAAzu5gdSjrE0ET2uGi2sLuePAootfUegspvpZ
	 GwdmJ17FS+c4NHDRheotdwPvBpSwlnzKjXVGyDzbkn8C30PBldKTIFB5Mim5udZxPw
	 GqN4Z9Hg9SJ1g==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 06/13] PCI: Account for ACS egress control in isolation checks
Date: Thu,  6 Aug 2026 14:24:13 +0300
Message-ID: <20260806-fix-p2p-acs-v2-6-0cec14812965@nvidia.com>
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

pci_acs_enabled() treats P2P Request Redirect as effective whenever its
control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
Egress Control Vector override it: a clear vector bit routes the request
directly.

IOMMU grouping uses this check to prove peer requests cannot bypass the
IOMMU, but cannot know every applicable vector bit, so Request Redirect
gives no such guarantee while Egress Control is enabled.

Report Request Redirect as ineffective there, merging the devices into
one IOMMU group, and report no isolation when the register cannot be
read. Apply the same rule to the Intel SPT PCH quirk.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c    | 12 +++++++++++-
 drivers/pci/quirks.c | 10 ++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 154eb08036ad..bc1c3b68c131 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3620,7 +3620,8 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
+		return false;
 
 	/*
 	 * Direct Translated P2P routes a Translated Request to the peer
@@ -3630,6 +3631,15 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	if (request_redirect && (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB))
 		return false;
 
+	/*
+	 * Egress Control can override Request Redirect for peer requests.
+	 * This target-independent check cannot prove that every applicable
+	 * Egress Control Vector bit is set, so RR does not guarantee isolation
+	 * while EC is enabled.
+	 */
+	if (request_redirect && (ctrl & PCI_ACS_EC))
+		return false;
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bb4c09cbbd10..ebfe902b0118 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4990,15 +4990,21 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 		return -ENOTTY;
 
 	/* see pci_acs_flags_enabled() */
-	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap))
+		return 0;
 	acs_flags &= (cap | PCI_ACS_EC);
 
-	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl))
+		return 0;
 
 	/* Direct Translated P2P may bypass Request Redirect. */
 	if (request_redirect && (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB))
 		return 0;
 
+	/* Egress Control may override Request Redirect for peer requests. */
+	if (request_redirect && (ctrl & PCI_ACS_EC))
+		return 0;
+
 	return pci_acs_ctrl_enabled(acs_flags, ctrl);
 }
 

-- 
2.55.0

