Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076843C04D;
	Tue, 11 Aug 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440729; cv=none; b=s9O6LkRHl/L+RkgAg2JjfOIISCl+ylXQ9MPOPVvdx6jwDmaLXxelCe4DNJqjWFfH6YzW2MK1kFJGMR46liiiz6A8PkeoOvUWprMbMxAeWnEO5bBiSGss4J3m7lIj69thEesIpIsL/elgfHzpuTtHnpplaCJ79IE79t9tevNk8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440729; c=relaxed/simple;
	bh=lwKvxUkh7+QlZngGOshWcJ+saAspfq0PUjvd2c6Y2/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qff8dmatIW6DnfNDWbiIRaEY+1GokcsQpLB8dCTDXaAc0Tb63Hdr1lSggYBu5lbUqdVKJt4BLjYkhN1wAOrTZRuRORwF/rk8pkUDF8pMr2RHAhhmacjhSV+7tVVshrjlJWDtTCxzGwhKyViyuipGXpuzbIIBrenHgEjbizlwr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjVgCymt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjVgCymt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5371F000E9;
	Tue, 11 Aug 2026 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440727;
	bh=a2ZO+QxTCsqdrI1xx7qw4wLfYHv6DBQMqIE+FlOHc50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AjVgCymtSHPbYOpippUg0nz5lYVEp8Y1djTsNI6oYJ7k284Rq/kHZn+n3sh9HK8Lk
	 yMm7TaZNfG1FVt6FQ1oCoEZLjSMy/omI3fXr74y8o2P8q3aYnPhiaQZGbKxFSxV47/
	 yav91bQB+V5qcuSLjjA14XOwU7kqEnbHGxY0fCSi/cP4ehrZopwwsEX1C0uQjUT/Y/
	 4UCSYrK2esMHeY9BJkXKSGJ78DohTjzRPKRmQoK+UN9v01y9GKeDbuC0skUWOReqHh
	 G0G9LQ4Me7ecrfhaTiQ0QYmcu3/jC5di//hhHtsbCOpANT+1QKEKvIYcglgH/IzXoP
	 o3fSXKEyrGYlQ==
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
Subject: [PATCH v3 14/17] PCI/P2PDMA: Extract pure ACS routing decision helpers
Date: Tue, 11 Aug 2026 12:30:56 +0300
Message-ID: <20260811-fix-p2p-acs-v3-14-efc488ee7c03@nvidia.com>
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

The ACS Egress Control routing decision (PCIe r7.0, sec 6.12.3,
table 6-11) and the Egress Control Vector Size rule were embedded in
functions that also perform config-space I/O and walk the PCIe
hierarchy.  That made the branch-heavy logic -- in particular the paths
that require an Egress Control Vector, which are unreachable on most
hardware -- difficult to exercise in isolation.

Factor the logic into two pure helpers:

  - pci_acs_p2pdma_decision() maps the ACS control word, whether the
    target port is known, and the target's Egress Control Vector bit to
    a routing state.

  - pci_acs_egress_port_valid() applies the "a vector size of 0 encodes
    256 bits" rule to decide whether a target port is within the vector.

pci_acs_p2pdma_state() and pci_acs_egress_ctrl_is_set() now call these.  No
functional change intended: pci_acs_egress_ctrl_is_set() still checks the
port range before reading the vector DWORD.

The helpers are exposed under CONFIG_KUNIT via VISIBLE_IF_KUNIT so the
following patch can unit-test them.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 60 +++++++++++++++++++++++++++++-----------------------
 drivers/pci/pci.c    | 26 +++++++++++++++++++----
 drivers/pci/pci.h    | 17 +++++++++++++++
 3 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 879c92d66f5b..2c38ed56a57b 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -538,16 +538,40 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 	return NULL;
 }
 
-enum pci_acs_p2pdma_state {
-	PCI_ACS_P2PDMA_DIRECT,
-	PCI_ACS_P2PDMA_REDIRECT,
-	PCI_ACS_P2PDMA_NOT_SUPPORTED,
-};
+/*
+ * PCIe r7.0, sec 6.12.3, table 6-11: decide how a peer-to-peer request at an
+ * ACS-capable ingress port routes, given its Egress Control register @ctrl,
+ * whether the target port is known (@has_target), and that target's Egress
+ * Control Vector bit (@egress: 1 set, 0 clear, negative if it could not be
+ * read).
+ *
+ * Egress Control applies only where the target is known (the path divergence).
+ * There, a set vector bit redirects the request only when Request Redirect is
+ * set; with Request Redirect clear it is an ACS Violation.  A clear vector bit
+ * permits direct routing, subject to Completion Redirect.
+ */
+VISIBLE_IF_KUNIT enum pci_acs_p2pdma_state
+pci_acs_p2pdma_decision(u16 ctrl, bool has_target, int egress)
+{
+	if (!has_target || !(ctrl & PCI_ACS_EC))
+		return ctrl & (PCI_ACS_RR | PCI_ACS_CR) ?
+			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+
+	if (egress < 0)
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
+	if (egress)
+		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
+					   PCI_ACS_P2PDMA_NOT_SUPPORTED;
+
+	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
+				   PCI_ACS_P2PDMA_DIRECT;
+}
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_p2pdma_decision);
 
 static enum pci_acs_p2pdma_state
 pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
 {
-	int pos, ret;
+	int pos, egress = 0;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
@@ -557,27 +581,11 @@ pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
 	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
 		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
 
-	/* EC applies only at the path divergence where the target is known. */
-	if (!target || !(ctrl & PCI_ACS_EC))
-		return ctrl & (PCI_ACS_RR | PCI_ACS_CR) ?
-			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+	/* Egress Control is evaluated only where the target is known. */
+	if (target && (ctrl & PCI_ACS_EC))
+		egress = pci_acs_egress_ctrl_is_set(pdev, target);
 
-	/*
-	 * PCIe r7.0, sec 6.12.3, table 6-11: a set Egress Control Vector
-	 * bit redirects the request only when Request Redirect is set.  With
-	 * Request Redirect clear, the request is handled as an ACS Violation.
-	 * A clear vector bit permits direct routing, subject to Completion
-	 * Redirect.
-	 */
-	ret = pci_acs_egress_ctrl_is_set(pdev, target);
-	if (ret < 0)
-		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
-	if (ret)
-		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
-						PCI_ACS_P2PDMA_NOT_SUPPORTED;
-
-	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
-				    PCI_ACS_P2PDMA_DIRECT;
+	return pci_acs_p2pdma_decision(ctrl, !!target, egress);
 }
 
 static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a633f473590f..d900fdb6f37d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3562,6 +3562,26 @@ static bool pci_acs_egress_vector_port(const struct pci_dev *dev)
 	       type == PCI_EXP_TYPE_DOWNSTREAM;
 }
 
+/**
+ * pci_acs_egress_port_valid - Is a target port within the Egress Control Vector
+ * @acs_caps: the ingress port's ACS Capability register
+ * @target_port: the target Downstream Port number
+ *
+ * The Egress Control Vector Size occupies bits 15:8 of the ACS Capability
+ * register (PCIe r7.0, sec 7.7.12).  A size of 0 encodes 256 bits, so
+ * every port number is addressable.
+ *
+ * Return: %true if @target_port has a bit in the Egress Control Vector.
+ */
+VISIBLE_IF_KUNIT
+bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port)
+{
+	unsigned int vector_size = acs_caps >> 8;
+
+	return !vector_size || target_port < vector_size;
+}
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_egress_port_valid);
+
 /**
  * pci_acs_egress_ctrl_is_set - Read an ACS Egress Control Vector bit
  * @pdev: ingress Root or Switch Downstream Port
@@ -3572,7 +3592,6 @@ static bool pci_acs_egress_vector_port(const struct pci_dev *dev)
  */
 int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target)
 {
-	unsigned int vector_size;
 	u32 lnkcap, vector;
 	u8 target_port;
 	int ret;
@@ -3597,10 +3616,8 @@ int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target)
 		return pcibios_err_to_errno(ret);
 
 	target_port = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	vector_size = pdev->acs_capabilities >> 8;
 
-	/* An Egress Control Vector Size of 0 encodes 256 bits. */
-	if (vector_size && target_port >= vector_size)
+	if (!pci_acs_egress_port_valid(pdev->acs_capabilities, target_port))
 		return -ERANGE;
 
 	ret = pci_read_config_dword(pdev,
@@ -3612,6 +3629,7 @@ int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target)
 
 	return !!(vector & BIT(target_port % 32));
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_egress_ctrl_is_set);
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
 				  enum pci_acs_scope scope)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 32394e349766..06a18aa663bc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,7 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <kunit/visibility.h>
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/pci.h>
@@ -1079,6 +1080,22 @@ static inline bool pci_acs_rr_ineffective(u32 ctrl, u16 acs_flags,
 }
 
 int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target);
+
+/*
+ * Peer-to-peer routing decision for an ACS-capable ingress port, per
+ * PCIe r7.0, sec 6.12.3, table 6-11.
+ */
+enum pci_acs_p2pdma_state {
+	PCI_ACS_P2PDMA_DIRECT,		/* peer-to-peer permitted directly */
+	PCI_ACS_P2PDMA_REDIRECT,	/* redirected upstream to host bridge */
+	PCI_ACS_P2PDMA_NOT_SUPPORTED,	/* no usable peer-to-peer route */
+};
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
+enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
+						  int egress);
+#endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
 				 enum pci_acs_scope scope);

-- 
2.55.0

