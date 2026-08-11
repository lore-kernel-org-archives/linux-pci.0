Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256F434E50;
	Tue, 11 Aug 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440718; cv=none; b=qffg8S/GLNyVYRN75bKjUNQX5XuGV7qthyD3CKVGUM7WvuTgWiDjF4LT3wZ5dUqjG9bY90EFzgCVWy0easy9M/ie7zWMVfUrNQeX9geHu2g1jltqSjdYInUTOy3eH6Wua9nO5U88DrdzaRPC4KVg7jmbQIeFsFzCm1w6DBKQ7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440718; c=relaxed/simple;
	bh=wAGPi+FQZKFYHbcujproushB6aoFKHI2znb3lKf16pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hqk7Ez86wphwalKXuBes0ahQ+8iGPAY3qXewRciWDulHh8s3J6USxPx/OJVFKZIsO50VBgDRcFan8BzqeN+yMhzh0ta6wYKsL79QqEr5UXa4IqJ3eCRcJfd0viE0eb+LLpgaYFZ7+fbpWiqVU4cBypDmAmI/byGwtLSZCyPn6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYRz8Q4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYRz8Q4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2CB1F00A3D;
	Tue, 11 Aug 2026 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440715;
	bh=0uxyPV/6i8QHnH03dgNAW09i5KijziMNkEBo8lvxSrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYRz8Q4tZ6qpPRETvt37gVxbB/jlB1QHzM8KOHSo4gr2LIsjFWjASBLM8BPRcvHT8
	 vhxqog7eQYnP3lPpbEujx7Ty9+BMAx1tEpho7eSsRe35tl8A5Q+zVt7ChQACBOBbt1
	 3+00Re6aI2OA/PvaR2VptQO2bpRcMUzwX+udxh5M2qQazL6LAq6wKIDvpg6S9dZk6a
	 1uzw+68mon4W0ioGAElHs+CJo+5aR+LywsaGLwbqsokjzPVEp/1RGs+Bz0scp5dtb8
	 dNJDIrsmJzglHIqV/oFYewJRQHor2IkZogUBGcB18sbFrPzJyY/JUo8fqlL6K9YlSL
	 N/tqkbD/6fcjg==
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
	iommu@lists.linux.dev
Subject: [PATCH v3 10/17] PCI: Account for ACS egress control in isolation checks
Date: Tue, 11 Aug 2026 12:30:52 +0300
Message-ID: <20260811-fix-p2p-acs-v3-10-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
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

