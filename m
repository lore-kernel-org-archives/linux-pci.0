Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44640DB3C;
	Fri, 21 Aug 2026 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341314; cv=none; b=rdhRQixaalRMyA2rtgmjJ2qCyw9S/OzYd3e1ONgpEtVOZTbD7AByg8FrDeF5i2jA8j6/tCkBhPuUWQ4kH5Q9EUD4MT3ek7K92YyMpQ5Oc40EUUSDWuh/GMWlAndmGGcDR9/VlMSEAErfNGeyT7HiIykiG6MnOTZATO8VWfYYFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341314; c=relaxed/simple;
	bh=HTlCS36Jw5LBbsu+pbhYKbNTATGEkiRF5U2KzrGPR90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjX/p2dKo174o4EgatwHWvpsSCWpn00u+ITpbN0BSP7OBuJaXZC6lW3hEJDrcrtkb7oOOEcM1O/xR8HOmtXuR3DhxU0diUKwA7IkyHv6tuOA7YlHqQp9KkmGl7C4+FP0AhEGtbp7mioHSDwCH1LNSG715BEs6bXb1Q2s3XBoiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2CqL3C3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2CqL3C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956E1F000E9;
	Fri, 21 Aug 2026 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341312;
	bh=pM/8CIQiHWzcaqML80GUQPNx0F5GBdopWHz7HkSMkgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2CqL3C3NCNfU3uEzY2aen1Bo8MFe3jDzUcd5MxJvPju0i7PIqbb8YT38L9N/Hego
	 NfIhTK3duCYBFu1wD8pI2SvjaqS14KZI8Hvj1fE2RC+qaF/mWDaCcqRrolYcldJktA
	 pDWbhCgm4uxVJZJaS3tCD6oBMZRvlh9riwGTLe5TRfmQTMOYzEXyvvee0jJO3G9rfl
	 CH/WTb+CoRbxRor/SZ4zYmsvtJy0K008Ovn+3qwUS4bCN3YNhYaTTmu8yp/Wv8u+rA
	 Bh1BjdWwUNuZHaIwfVEXLEEBzGZJAW1dK4QtlDYU0EACOJgj9Sl53o1pZh6BZTCAr3
	 +LQqafG9+IAuw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 10/18] PCI: Account for ACS egress control in isolation checks
Date: Fri, 21 Aug 2026 22:38:41 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

Unlike Direct Translated P2P this holds for an Untranslated Request too,
so it applies in both scopes. pci_enable_pasid() therefore fails on a
path where a port has Egress Control enabled, because Request Redirect
no longer shows that a Request carrying a PASID reaches the translation
agent.

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: ad805758c0eb ("PCI: add ACS validation utility")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c    |  3 ++-
 drivers/pci/pci.h    | 13 +++++++++++--
 drivers/pci/quirks.c |  7 +++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8d165c9534ff..a633f473590f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3623,7 +3623,8 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
 	if (!pos)
 		return false;
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
+		return false;
 
 	if (pci_acs_rr_ineffective(ctrl, acs_flags, scope))
 		return false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d3ea9b2bb7fc..32394e349766 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1056,6 +1056,12 @@ void pci_enable_acs(struct pci_dev *dev);
  * says nothing about an Untranslated Request, so a caller asking only about
  * those is unaffected.
  *
+ * Egress Control can override Request Redirect for any peer Request,
+ * Untranslated ones included, so it applies in either scope.  This
+ * target-independent test cannot prove that every applicable Egress Control
+ * Vector bit is set, so Request Redirect does not guarantee that the Request
+ * leaves the direct path while Egress Control is enabled.
+ *
  * @ctrl is the ACS Control register, @acs_flags the controls the caller asked
  * for, and @scope the Requests its answer has to cover.
  */
@@ -1065,8 +1071,11 @@ static inline bool pci_acs_rr_ineffective(u32 ctrl, u16 acs_flags,
 	if (!(acs_flags & PCI_ACS_RR))
 		return false;
 
-	return scope == PCI_ACS_SCOPE_ALL &&
-	       (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB);
+	if (scope == PCI_ACS_SCOPE_ALL &&
+	    (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB))
+		return true;
+
+	return ctrl & PCI_ACS_EC;
 }
 
 int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b50cd0e5114..cee6be63cadd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4998,8 +4998,11 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags,
 		return -ENOTTY;
 
 	/* see pci_acs_flags_enabled() */
-	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
-	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap))
+		return 0;
+
+	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl))
+		return 0;
 
 	if (pci_acs_rr_ineffective(ctrl, acs_flags, scope))
 		return 0;

-- 
2.55.0

