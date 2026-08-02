Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1A3C063F;
	Sun,  2 Aug 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683431; cv=none; b=s02afwpYTa5qo/QZMC0MqQR7+1FWWRVx/ROEYlX88bhvqsvnlV5FNLnhOf/ooDuckYeQGNiAxeOk9/yCkgnMJLeXZK/vHV0gdwaSbHT18A0boy8jDhXvNfXb1Ut2bNvDXAX8MRjDFSnmNuqMLWeLN5vklUdzQLGEc6ZqlUQFO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683431; c=relaxed/simple;
	bh=3EjmAD6WZzBqrLlZgIqsHCi5B9pZSCUq4PIN3d+ZOEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHobmyRDQ/6+IbB7OZdbgVDIrtV0m0ShKIounWlaukTf3kYuvvlJxI2qz2nOl5PW9I7/k1MMf4YEDkM4Ze0NfMDlstHycSD8+e9S2reIafNacX3sQlJYyZA1PQmp4+sjZnppukCh2VBwJgZN5eoZgGaq3rA5+Og/f0pu/p8qpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXQe3SEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXQe3SEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF771F00A3A;
	Sun,  2 Aug 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683428;
	bh=/nM5S+RYDU9TqP+U5JEQl7dfKr6n6Rrk2qQVm2Z0OQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXQe3SEh+wKKE273dHVypIqIBwzFRjEKRvGtUueoZ0cyAzGmfRReUKskoc5njtXeK
	 cD0miJvq65svSkR1GRmzyn7+XOYjhutd9JiVyxX/5/3kFmMsobRMNZQRmYDVS0OZ6Y
	 gKBauOh+ZGMh3Ntt2CdaVXuUErFZEBJ55HkhLKfCM8kD+Xz1saTIhyeSK4WBzE6M+p
	 9gnlSR/v3Nsu2BVKs+sKOkwPFokQIKhQV+v1MQZfhmYlIdZRXXCUFzpabtVDk7jnmp
	 fJhy9PY5H/pn5nA3N8tAi5f17Y4tm/os8TbmKVayQP3LaVL+x6DB0RX+Kbn9Xq2caF
	 ZcdhmFndc7X9A==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 07/13] PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
Date: Sun,  2 Aug 2026 18:09:45 +0300
Message-ID: <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
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

The redirect test reports an upstream redirect for any ACS redirect or
egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
the control bits and the target vector, and an enabled egress control bit
alone does not redirect. Compute the result from the control bits so the
vector can be honored next, using the host-bridge route while the peer
target is unknown.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 801c183ae6b7..079cec6c0509 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#include "pci.h"
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -489,26 +491,45 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
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
+static enum pci_acs_p2pdma_state
+pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
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
+	if (!(ctrl & PCI_ACS_EC))
+		return ctrl & (PCI_ACS_RR | PCI_ACS_CR) ?
+			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
 
-	return 0;
+	/*
+	 * The vector cannot be read without the peer target, so redirect
+	 * upstream until the paths diverge.
+	 */
+	if (!target)
+		return PCI_ACS_P2PDMA_REDIRECT;
+
+	/*
+	 * PCIe r7.0, sec 6.12.3, table 6-11: a set or indeterminate egress
+	 * control vector bit keeps the request off the direct path; a clear
+	 * bit permits it, subject only to completion redirect.
+	 */
+	if (pci_acs_egress_ctrl_set(pdev, target))
+		return PCI_ACS_P2PDMA_REDIRECT;
+
+	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
+				    PCI_ACS_P2PDMA_DIRECT;
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
@@ -722,7 +743,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	while (a) {
 		dist_b = 0;
 
-		if (pci_bridge_has_acs_redir(a)) {
+		if (pci_acs_p2pdma_state(a, NULL) ==
+		    PCI_ACS_P2PDMA_REDIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
@@ -755,7 +777,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		if (a == bb)
 			break;
 
-		if (pci_bridge_has_acs_redir(bb)) {
+		if (pci_acs_p2pdma_state(bb, NULL) ==
+		    PCI_ACS_P2PDMA_REDIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, bb);
 			acs_cnt++;
 		}

-- 
2.55.0

