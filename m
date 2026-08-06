Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EEF3D47DD;
	Thu,  6 Aug 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015561; cv=none; b=fxPBohkPc+0Nh9TS/xGeacaYLJWvMfByxH1dJ8G7aO4AYwFTf2NHoouSykyBbtIhTrEWVygZpoYqTxMpiUfDNkJ1DECIdR9bkBfiwRPQWQHiBD2F9v1KfZg+fzzH6CJTISqRKLr671iqoWEz01xcBF37yQO3PCqUuO3pDSXwoFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015561; c=relaxed/simple;
	bh=7o98YhqKMcoXCho5RulWmmSOddxkpcdNjx2CaHaXgso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp8UCfCR/1AjmslvL2d0KdGIQR9mEWoM0FiHsbIlZDjBtxnfTj4bwn9MEBMSDfk2m9PJ0lbF/NXzle3lzYxYWSTZHyRuMiB7FbzOhb3GF55/5a7mn7fp21/zWb0tc8eQro42pI+ajwLgWl5o9q5QG3XHFGYTy7BiMblhewVLyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwBGYLD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwBGYLD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB501F000E9;
	Thu,  6 Aug 2026 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015560;
	bh=szizLkZEdfCMxYc6R09G8coDVy8b9sJOXHQ1jnLYqaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwBGYLD56wL7CQv3KFsEOTEfIOzGHi5++PZq7vRpgZFXi8MihLnbnhzFomYphKG1p
	 H3jrDzMfUThBJyXE3Xae4tmKcZCP2yAZIc/pTduQca6u8QeQ1oKZWC1El5FxE2S0qg
	 nYTpfHOzKAXr9jtf+VJgjPzuw5p6gyQRhc0EtuVA7IU+I31OrcDN1L/mJuDKafIevk
	 CHGqtwD9lAsd9CBFrDSv1FloKnWlxgLiQjlh2BnOyKIVS/fuAHe9h9rOypYfarBJQP
	 OpinxL+CcRnjNs4TXC/0rzAYni3Osw1cygFmp8jkt51mz9zlHssF5ipsHZH+leAteV
	 VUFrgUb2+Zt8w==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 08/13] PCI/P2PDMA: Honor ACS egress control vectors
Date: Thu,  6 Aug 2026 14:24:15 +0300
Message-ID: <20260806-fix-p2p-acs-v2-8-0cec14812965@nvidia.com>
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

An enabled Egress Control bit does not itself send a peer request
upstream. PCIe r7.0, sec 6.12.3, table 6-11 makes the outcome depend on
the Egress Control Vector bit for the target port: a clear bit routes the
request directly regardless of P2P Request Redirect.

Read the vector where the paths diverge below their common upstream port.
Keep a clear vector bit on the direct path, subject to P2P Completion
Redirect.

A set bit with Request Redirect clear is an ACS Violation. ACS acts only
on peer-to-peer Requests, so route it, and an indeterminate vector,
through the host bridge.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 105 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 079cec6c0509..dbccc1d0c4e3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -494,12 +494,13 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 enum pci_acs_p2pdma_state {
 	PCI_ACS_P2PDMA_DIRECT,
 	PCI_ACS_P2PDMA_REDIRECT,
+	PCI_ACS_P2PDMA_NOT_SUPPORTED,
 };
 
 static enum pci_acs_p2pdma_state
 pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
 {
-	int pos;
+	int pos, ret;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
@@ -507,26 +508,26 @@ pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
 		return PCI_ACS_P2PDMA_DIRECT;
 
 	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
-		return PCI_ACS_P2PDMA_REDIRECT;
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
 
-	if (!(ctrl & PCI_ACS_EC))
+	/* EC applies only at the path divergence where the target is known. */
+	if (!target || !(ctrl & PCI_ACS_EC))
 		return ctrl & (PCI_ACS_RR | PCI_ACS_CR) ?
 			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
 
 	/*
-	 * The vector cannot be read without the peer target, so redirect
-	 * upstream until the paths diverge.
+	 * PCIe r7.0, sec 6.12.3, table 6-11: a set Egress Control Vector
+	 * bit redirects the request only when Request Redirect is set.  With
+	 * Request Redirect clear, the request is handled as an ACS Violation.
+	 * A clear vector bit permits direct routing, subject to Completion
+	 * Redirect.
 	 */
-	if (!target)
-		return PCI_ACS_P2PDMA_REDIRECT;
-
-	/*
-	 * PCIe r7.0, sec 6.12.3, table 6-11: a set or indeterminate egress
-	 * control vector bit keeps the request off the direct path; a clear
-	 * bit permits it, subject only to completion redirect.
-	 */
-	if (pci_acs_egress_ctrl_set(pdev, target))
-		return PCI_ACS_P2PDMA_REDIRECT;
+	ret = pci_acs_egress_ctrl_set(pdev, target);
+	if (ret < 0)
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
+	if (ret)
+		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
+						PCI_ACS_P2PDMA_NOT_SUPPORTED;
 
 	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
 				    PCI_ACS_P2PDMA_DIRECT;
@@ -707,9 +708,9 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * then to Device B. The mapping type returned depends on the ACS
  * redirection setting of the ports along the path.
  *
- * If ACS redirect is set on any port in the path, traffic between the
- * devices will go through the host bridge, so return
- * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE; otherwise return
+ * If ACS redirects traffic on any port in the path, or blocks the direct
+ * path or leaves its routing indeterminate, return
+ * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE. Otherwise, return
  * PCI_P2PDMA_MAP_BUS_ADDR.
  *
  * Any two devices that have a data path that goes through the host bridge
@@ -723,12 +724,15 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-	struct pci_dev *a = provider, *b = client, *bb;
+	struct pci_dev *a = provider, *b = client, *bb, *target;
+	struct pci_dev *a_child = NULL, *b_child = NULL;
+	struct pci_dev *acs_unsupported = NULL;
+	enum pci_acs_p2pdma_state state;
 	bool no_common_upstream = false;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
-	int acs_cnt = 0;
+	int acs_redirect_cnt = 0;
 	int dist_a = 0;
 	int dist_b = 0;
 	char buf[128];
@@ -742,23 +746,19 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 */
 	while (a) {
 		dist_b = 0;
-
-		if (pci_acs_p2pdma_state(a, NULL) ==
-		    PCI_ACS_P2PDMA_REDIRECT) {
-			seq_buf_print_bus_devfn(&acs_list, a);
-			acs_cnt++;
-		}
-
+		b_child = NULL;
 		bb = b;
 
 		while (bb) {
 			if (a == bb)
-				goto check_b_path_acs;
+				goto check_paths_acs;
 
+			b_child = bb;
 			bb = pci_upstream_bridge(bb);
 			dist_b++;
 		}
 
+		a_child = a;
 		a = pci_upstream_bridge(a);
 		dist_a++;
 	}
@@ -770,25 +770,44 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 */
 	no_common_upstream = true;
 
-check_b_path_acs:
-	bb = b;
+check_paths_acs:
+	*dist = dist_a + dist_b;
+	bb = provider;
 
 	while (bb) {
+		target = bb == a_child ? b_child : NULL;
+		state = pci_acs_p2pdma_state(bb, target);
+		if (state != PCI_ACS_P2PDMA_DIRECT) {
+			seq_buf_print_bus_devfn(&acs_list, bb);
+			if (state == PCI_ACS_P2PDMA_REDIRECT)
+				acs_redirect_cnt++;
+			else if (!acs_unsupported)
+				acs_unsupported = bb;
+		}
+
 		if (a == bb)
 			break;
 
-		if (pci_acs_p2pdma_state(bb, NULL) ==
-		    PCI_ACS_P2PDMA_REDIRECT) {
+		bb = pci_upstream_bridge(bb);
+	}
+
+	bb = client;
+
+	while (bb && a != bb) {
+		target = bb == b_child ? a_child : NULL;
+		state = pci_acs_p2pdma_state(bb, target);
+		if (state != PCI_ACS_P2PDMA_DIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, bb);
-			acs_cnt++;
+			if (state == PCI_ACS_P2PDMA_REDIRECT)
+				acs_redirect_cnt++;
+			else if (!acs_unsupported)
+				acs_unsupported = bb;
 		}
 
 		bb = pci_upstream_bridge(bb);
 	}
 
-	*dist = dist_a + dist_b;
-
-	if (!acs_cnt) {
+	if (!acs_unsupported && !acs_redirect_cnt) {
 		if (no_common_upstream)
 			goto map_through_host_bridge;
 
@@ -796,13 +815,21 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		goto done;
 	}
 
+	/*
+	 * ACS controls only act on Requests routed peer-to-peer, so a blocked
+	 * or indeterminate direct path still leaves the host-bridge route.
+	 */
 	if (verbose) {
 		/* Drop the final semicolon; the list is not empty here. */
 		if (!seq_buf_has_overflowed(&acs_list))
 			acs_list.buffer[acs_list.len - 1] = '\0';
-		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
-			 pci_name(provider));
-		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
+		if (acs_unsupported)
+			pci_warn(client, "ACS blocks the direct P2P path to provider %s at %s\n",
+				 pci_name(provider), pci_name(acs_unsupported));
+		else
+			pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
+				 pci_name(provider));
+		pci_warn(client, "to disable ACS controls for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 seq_buf_str(&acs_list));
 	}
 	acs_redirects = true;

-- 
2.55.0

