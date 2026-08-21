Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44542E40A;
	Fri, 21 Aug 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341319; cv=none; b=LWhNN1bmXtRc5lGEnYcV/CTRAWIt3tVKuWSLm5JT6emGfuYaUCxyGvFP8HGWZkQ4G5UrAqPhjsWQYiFbLYK8DImSuX+SWRPxQouu3mZGBR/yikQiTOoywHllmy7ONYYBA7U7VKQT6aZi7q39KuqskLwq8riFJMP7xMfp/S2bANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341319; c=relaxed/simple;
	bh=37jSSbm2nVtVmoDtbbEiRFf6OcaXcLJF6gH31zKnUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XicRCUpXe7CoK62DKwziDTdA8Iqzf5DZnMhxaASpKMAH8oetsxS+t6tsKfD6L/eTOPg6DIWTh+xjsMudJj1XsqNqfOVzDQw11Qc8B32C0zJypHYQ/BmJ39FagJMRyWwg5YC2B/bOYb7k7zhNPi71KPK8WQ9wWJMtg5OGQzwJrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRfofSRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRfofSRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1041F00A3A;
	Fri, 21 Aug 2026 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341317;
	bh=MMSsUY9laQUTMjjXd6DM2zHQp8gV8xWukL+sQr70vUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRfofSRsEO9KfcBvnexdu3AL/ZXJoVXTs9eGiLAup74X1l0sjQyqCz+8PxOp5Gwqi
	 tly0EgMZ7y9zMu4b8aON65hpgUkCz83G0rISmJpQpwwOCxWm2IawL40Qdqo83DV2NB
	 AOGK9/ctS8zDCRcufmuJzqTigPlumoyHzdu5Y740MCK8n+8C+qFk+MMb7qTarVFMPM
	 brsLgVbNuqwWtLJb/pHPrs8yt7nDZvZ8X2n/4iod9iFOKkD7TTpo++dbvcwcOEp9vM
	 EX2medv8vK1q0Bv9F1ifrb5myyo7O3TDFYLuLMe+mz+Zj3tauLIh7KetcBTcTizlGr
	 ylzyEl7DagDIQ==
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
Subject: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
Date: Fri, 21 Aug 2026 22:38:42 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
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

pci_bridge_has_acs_redir() treats Request Redirect and Completion Redirect
as interchangeable for a P2PDMA transaction. On asymmetric fabrics this
sends an otherwise direct mapping through the host bridge.

The client issues Requests to provider memory, while the provider emits
read Completions. Evaluate Request Redirect for the former and Completion
Redirect for the latter. Leave Egress Control conservative until the target
vector is available.

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a364008bbf50..1eda7b2135d7 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#include "pci.h"
+
 /*
  * Lifetime and RCU usage
  *
@@ -536,26 +538,35 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 	return NULL;
 }
 
-/*
- * Check if a PCI bridge has its ACS redirection bits set to redirect P2P
- * TLPs upstream via ACS. Returns 1 if the packets will be redirected
- * upstream, 0 otherwise.
- */
-static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
+enum pci_acs_p2pdma_state {
+	PCI_ACS_P2PDMA_DIRECT,
+	PCI_ACS_P2PDMA_REDIRECT,
+};
+
+enum pci_acs_p2pdma_tlp {
+	PCI_ACS_P2PDMA_TLP_REQUEST,
+	PCI_ACS_P2PDMA_TLP_COMPLETION,
+};
+
+static enum pci_acs_p2pdma_state
+pci_acs_p2pdma_state(struct pci_dev *pdev, enum pci_acs_p2pdma_tlp tlp)
 {
 	int pos;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
 	if (!pos)
-		return 0;
+		return PCI_ACS_P2PDMA_DIRECT;
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
+		return PCI_ACS_P2PDMA_REDIRECT;
 
-	if (ctrl & (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC))
-		return 1;
+	if (tlp == PCI_ACS_P2PDMA_TLP_COMPLETION)
+		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
+					   PCI_ACS_P2PDMA_DIRECT;
 
-	return 0;
+	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?
+		PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
@@ -733,6 +744,10 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * then to Device B. The mapping type returned depends on the ACS
  * redirection setting of the ports along the path.
  *
+ * The client initiates Requests to provider memory. Check Request Redirect
+ * on the client path and Completion Redirect for read Completions on the
+ * provider path.
+ *
  * If ACS redirect is set on any port in the path, traffic between the
  * devices will go through the host bridge, so return
  * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE; otherwise return
@@ -767,7 +782,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	while (a) {
 		dist_b = 0;
 
-		if (pci_bridge_has_acs_redir(a)) {
+		if (pci_acs_p2pdma_state(a,
+					 PCI_ACS_P2PDMA_TLP_COMPLETION) ==
+		    PCI_ACS_P2PDMA_REDIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
@@ -796,7 +813,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		if (a == bb)
 			break;
 
-		if (pci_bridge_has_acs_redir(bb)) {
+		if (pci_acs_p2pdma_state(bb,
+					 PCI_ACS_P2PDMA_TLP_REQUEST) ==
+		    PCI_ACS_P2PDMA_REDIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, bb);
 			acs_cnt++;
 		}
@@ -1150,10 +1169,10 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 /**
  * pci_p2pdma_map_type - Determine the mapping type for P2PDMA transfers
  * @provider: P2PDMA provider structure
- * @dev: Target device for the transfer
+ * @dev: Client device that initiates the transfer
  *
  * Determines how peer-to-peer DMA transfers should be mapped between
- * the provider and the target device. The mapping type indicates whether
+ * the provider and the client device. The mapping type indicates whether
  * the transfer can be done directly through PCI switches or must go
  * through the host bridge.
  */

-- 
2.55.0

