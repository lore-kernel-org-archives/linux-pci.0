Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091142EEA4;
	Tue, 11 Aug 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440741; cv=none; b=rSNDKbWy/r+zEOaA5BZkRuqV4EDMFl5LKLPeiisq11AmEluMTxiUB6TwlsoPboQjwvPDCE7Oq1bg3HC3sbYWX5q7nqEZI/c2SFVpeSAngYZVZ77SO/s2c8h7K3RODs7C8rSv6CBeUiCst8Q7/O/JroCrbew1s4aGXuI+MM68xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440741; c=relaxed/simple;
	bh=Pt1nevMTgJ0hyu2UqYgqPOmzI5fgDrwSDPKbuwPAmCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfy4VyIy1Zg9CoegB2AcreQdaKv93LtMBpA3gD+EVOknE/1o2Gfgs6oQ8CA0ElVds57MytuswdUAD+QWihSUzBRpgFMCS/ypdICRdMPSA0y/DpzbUR9ejMcg1mPAFmWlgOosH/U6JF6nZoSyZOw+7Fl6vW9eq8D3SktnRhSqu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlu1PxGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlu1PxGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29A51F000E9;
	Tue, 11 Aug 2026 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440740;
	bh=ffLJzyWnTCRIbRrdEkbpXBdeTZ14TQNfRzt8dE7+yJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlu1PxGu9/0mtIhIrSV+P7xR0aFEX7dwbF6vhlhkIB1O8Ir/xgO7B1fAitns/Jnna
	 shEhZE/fhKwBdk2m7dMDrGT4Z9eE0rBA9CQjNmPIwVZ584tYt9FqcfrOdFkntKME0c
	 x7aSIduzqio2g76hiJAFrpyiqgJLTB4WL00IliYlOO0S3prZPjY4Fhvnt+53BDsdNN
	 QswvCXJZjssnMG7tOAt49/BufIk4djnqLYV8LkgyfbJTBATv50F07XnMtZDadHKTsq
	 exHydF58F5IbFnbPhQNgVz20k4+jed5On+QAszjrzpe2v6iuRW+/YabYHWFzFUlaEx
	 w9wimDwGrio5Q==
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
Subject: [PATCH v3 11/17] PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
Date: Tue, 11 Aug 2026 12:30:53 +0300
Message-ID: <20260811-fix-p2p-acs-v3-11-efc488ee7c03@nvidia.com>
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

The redirect test reports an upstream redirect for any ACS redirect or
egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
the control bits and the target vector, and an enabled egress control bit
alone does not redirect. Compute the result from the control bits so the
vector can be honored next, using the host-bridge route while the peer
target is unknown.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a364008bbf50..69cef8ca9557 100644
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
@@ -536,26 +538,45 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
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
+	if (pci_acs_egress_ctrl_is_set(pdev, target))
+		return PCI_ACS_P2PDMA_REDIRECT;
+
+	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
+				    PCI_ACS_P2PDMA_DIRECT;
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
@@ -767,7 +788,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	while (a) {
 		dist_b = 0;
 
-		if (pci_bridge_has_acs_redir(a)) {
+		if (pci_acs_p2pdma_state(a, NULL) ==
+		    PCI_ACS_P2PDMA_REDIRECT) {
 			seq_buf_print_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
@@ -796,7 +818,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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

