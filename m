Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FA44062B;
	Fri, 21 Aug 2026 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341325; cv=none; b=Ms4gU0nIiE1JYVt5g7LmZS3TnpeDPFukFgdxjwRRth3QOvJ8ChSk0E9dwH+xYPcMr43CCdsNyj70l5X6TCXxCPrGUrAcNLHfF2mSsFmh4eCtZ7qOoG1ujzi16PyQpt/pwtXOz0iSgrc5vcpVygFqXzY8i/rlozojtUSF7E8Mp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341325; c=relaxed/simple;
	bh=Smiq9GTea3sEziCt9A+fkVPywMiCPJBIrojSSUzHR10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DI2t7ZsZbKXXEKXw1YOUniqMSwxCNCJ33rI1PUWsZgX3AsPLJebwCPT4MGbvNq365RQUJGE108ycHW0rzQjLWZGpv3PwvTV1RhtTydsedRKVkd8gnaeOOZnjmrP0qNqzHJFQCOjz94IspoZ1H706jpNbX8z/CRnXWhp/mOX5Z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMAV8Zlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMAV8Zlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC831F000E9;
	Fri, 21 Aug 2026 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341322;
	bh=K/yRBzoegTd/9dZw6t8+iPPre3vV8gjkF58CQ8H+8bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMAV8Zlvyk4hye4NSzfVP2iy1vlnVAF0hkwe6+0wSEHib5V5yosW425Ocbx3lao3z
	 2AbykVVf0ZiK/8fw119+VnZUzHVpzI5gPeVdrFwHcM4SRonLYEqFol0CQ/NlzhW5Vn
	 1qna26sIjh9p25xSe7rrkGo2JjSks4MlteS8ehMRVrgFs3r0yz2O7jAYxdT//g1jU0
	 XTRHP5j3zjzXwLt5q6cW5j/YIPnpVsuzWhv6qx6q+FWa+j4OR1p53WtSo58V26DdIO
	 a7r+Zr9Mc4U6AqwyRCLDxqlY+9ZKil3gO83iZL12wmMEYQ8kH71QwEWNWoJavj5dOF
	 MREtktCdY4X0w==
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
Subject: [PATCH v4 12/18] PCI/P2PDMA: Honor ACS egress control vectors
Date: Fri, 21 Aug 2026 22:38:43 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-12-94426b96de73@nvidia.com>
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

An enabled Egress Control bit does not by itself redirect a peer Request.
The result depends on the vector bit for the target port; a set bit without
Request Redirect is an ACS Violation, while a clear bit permits direct
routing.

Evaluate controls only at the path divergence: Request Redirect and Egress
Control on the client-side port, and Completion Redirect on the
provider-side port. Below it, traffic toward the other branch already
routes upstream.

Reject unreadable vectors and ACS Violations. Neither condition redirects
the transaction upstream, so a host-bridge mapping cannot make the path
usable.

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       | 127 +++++++++++++++++++++++++++++++--------------
 include/linux/pci-p2pdma.h |   8 +--
 2 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1eda7b2135d7..bcbbdbd8ee47 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -541,6 +541,7 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 enum pci_acs_p2pdma_state {
 	PCI_ACS_P2PDMA_DIRECT,
 	PCI_ACS_P2PDMA_REDIRECT,
+	PCI_ACS_P2PDMA_NOT_SUPPORTED,
 };
 
 enum pci_acs_p2pdma_tlp {
@@ -549,9 +550,10 @@ enum pci_acs_p2pdma_tlp {
 };
 
 static enum pci_acs_p2pdma_state
-pci_acs_p2pdma_state(struct pci_dev *pdev, enum pci_acs_p2pdma_tlp tlp)
+pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target,
+		     enum pci_acs_p2pdma_tlp tlp)
 {
-	int pos;
+	int pos, ret;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
@@ -559,14 +561,31 @@ pci_acs_p2pdma_state(struct pci_dev *pdev, enum pci_acs_p2pdma_tlp tlp)
 		return PCI_ACS_P2PDMA_DIRECT;
 
 	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
-		return PCI_ACS_P2PDMA_REDIRECT;
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
 
 	if (tlp == PCI_ACS_P2PDMA_TLP_COMPLETION)
 		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
 					   PCI_ACS_P2PDMA_DIRECT;
 
-	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?
-		PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+	/* EC applies only to Requests where the target is known. */
+	if (!target || !(ctrl & PCI_ACS_EC))
+		return ctrl & PCI_ACS_RR ?
+			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+
+	/*
+	 * PCIe r7.0, sec 6.12.3, table 6-11: a set Egress Control Vector
+	 * bit redirects the request only when Request Redirect is set.  With
+	 * Request Redirect clear, the request is handled as an ACS Violation.
+	 * A clear vector bit permits the Request to route directly.
+	 */
+	ret = pci_acs_egress_ctrl_is_set(pdev, target);
+	if (ret < 0)
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
+	if (ret)
+		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
+						PCI_ACS_P2PDMA_NOT_SUPPORTED;
+
+	return PCI_ACS_P2PDMA_DIRECT;
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
@@ -744,14 +763,14 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * then to Device B. The mapping type returned depends on the ACS
  * redirection setting of the ports along the path.
  *
- * The client initiates Requests to provider memory. Check Request Redirect
- * on the client path and Completion Redirect for read Completions on the
- * provider path.
+ * The client initiates Requests to provider memory. At the path divergence,
+ * check Request Redirect and Egress Control on the client-side port, and
+ * Completion Redirect for read Completions on the provider-side port.
  *
- * If ACS redirect is set on any port in the path, traffic between the
- * devices will go through the host bridge, so return
- * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE; otherwise return
- * PCI_P2PDMA_MAP_BUS_ADDR.
+ * If ACS redirects traffic at either divergence port, return
+ * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE. If ACS blocks the direct path or leaves
+ * its routing indeterminate, return PCI_P2PDMA_MAP_NOT_SUPPORTED. Otherwise,
+ * return PCI_P2PDMA_MAP_BUS_ADDR.
  *
  * Any two devices that have a data path that goes through the host bridge
  * will consult a whitelist. If the host bridge is in the whitelist, return
@@ -765,9 +784,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb;
+	struct pci_dev *a_child = NULL, *b_child = NULL;
+	struct pci_dev *acs_unsupported = NULL;
+	enum pci_acs_p2pdma_state state;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
-	int acs_cnt = 0;
+	int acs_redirect_cnt = 0;
 	int dist_a = 0;
 	int dist_b = 0;
 	char buf[128];
@@ -781,51 +803,66 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	 */
 	while (a) {
 		dist_b = 0;
-
-		if (pci_acs_p2pdma_state(a,
-					 PCI_ACS_P2PDMA_TLP_COMPLETION) ==
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
 
+	/*
+	 * The paths share no upstream bridge, so there is no direct path for
+	 * ACS to gate: PCI_P2PDMA_MAP_BUS_ADDR is not reachable here and the
+	 * request can only get to the peer through the host bridge.
+	 */
 	*dist = dist_a + dist_b;
 	goto map_through_host_bridge;
 
-check_b_path_acs:
-	bb = b;
-
-	while (bb) {
-		if (a == bb)
-			break;
+check_paths_acs:
+	*dist = dist_a + dist_b;
 
-		if (pci_acs_p2pdma_state(bb,
-					 PCI_ACS_P2PDMA_TLP_REQUEST) ==
-		    PCI_ACS_P2PDMA_REDIRECT) {
-			seq_buf_print_bus_devfn(&acs_list, bb);
-			acs_cnt++;
+	/*
+	 * ACS P2P routing controls apply where a TLP can route toward the peer
+	 * or upstream. Below that divergence, its only route toward the other
+	 * branch is upstream, so redirect controls do not affect the path.
+	 */
+	if (a_child && b_child) {
+		state = pci_acs_p2pdma_state(a_child, NULL,
+					     PCI_ACS_P2PDMA_TLP_COMPLETION);
+		if (state != PCI_ACS_P2PDMA_DIRECT) {
+			seq_buf_print_bus_devfn(&acs_list, a_child);
+			if (state == PCI_ACS_P2PDMA_REDIRECT)
+				acs_redirect_cnt++;
+			else if (!acs_unsupported)
+				acs_unsupported = a_child;
 		}
 
-		bb = pci_upstream_bridge(bb);
+		state = pci_acs_p2pdma_state(b_child, a_child,
+					     PCI_ACS_P2PDMA_TLP_REQUEST);
+		if (state != PCI_ACS_P2PDMA_DIRECT) {
+			seq_buf_print_bus_devfn(&acs_list, b_child);
+			if (state == PCI_ACS_P2PDMA_REDIRECT)
+				acs_redirect_cnt++;
+			else if (!acs_unsupported)
+				acs_unsupported = b_child;
+		}
 	}
 
-	*dist = dist_a + dist_b;
-
-	if (!acs_cnt) {
+	/*
+	 * Below a shared upstream bridge, a path that neither divergence port
+	 * redirects or blocks routes the request directly.
+	 */
+	if (!acs_unsupported && !acs_redirect_cnt) {
 		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
 		goto done;
 	}
@@ -834,12 +871,22 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		/* Drop the final semicolon; the list is not empty here. */
 		if (!seq_buf_has_overflowed(&acs_list))
 			acs_list.buffer[acs_list.len - 1] = '\0';
-		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
-			 pci_name(provider));
-		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
+		if (acs_unsupported)
+			pci_warn(client, "ACS leaves no usable direct P2P path to provider %s at %s\n",
+				 pci_name(provider), pci_name(acs_unsupported));
+		else
+			pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
+				 pci_name(provider));
+		pci_warn(client, "to disable ACS controls for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 seq_buf_str(&acs_list));
 	}
 
+	/* A blocked or indeterminate direct path is not an upstream redirect. */
+	if (acs_unsupported) {
+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
+		goto done;
+	}
+
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&
 	    !host_bridge_whitelist(provider, client, verbose)) {
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 873de20a2247..dd17501ba1b6 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -42,10 +42,10 @@ enum pci_p2pdma_map_type {
 	PCI_P2PDMA_MAP_NONE,
 
 	/*
-	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
-	 * traverse the host bridge and the host bridge is not in the
-	 * allowlist. DMA Mapping routines should return an error when
-	 * this is returned.
+	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates no safe mapping is available,
+	 * for example because ACS blocks the direct path or the required host
+	 * bridge is not in the allowlist. DMA Mapping routines should return an
+	 * error when this is returned.
 	 */
 	PCI_P2PDMA_MAP_NOT_SUPPORTED,
 

-- 
2.55.0

