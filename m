Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CF413D8F;
	Fri, 21 Aug 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341335; cv=none; b=U2wkkd8e1ePNKxqLaPXAHU6N8fYEaAt2pmWnqSAjkyHmN4b9Y1fAWtiY4ZbZruk+VhsfReVNwDQa937CG7FXuXCGEc4fHLuG8XtI8zymO5vQdXN2W/crIXdx+0L1BpbyBgVFpF8juH4xoykou2vRMlv2fiLakB6P632w1v0Wez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341335; c=relaxed/simple;
	bh=v2lT8gnZmcN0RMwNsrBCqLIYYwVw42o56xMYXEiRSuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/Q059vxwMp2fQw8O2EnT0HO6wHJE1u2pMDBEe/KaSeDiURsmafx07FhKnDKFBwMFylIR333EfJQPUTdk4+h88OwDJti9D2XBBmlckuPjvggFu86xYknuFBiBMJkVxmdTIQZpVB2QAoIzYHU7JMil1RHW+BndGG9tcS1/0IGF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofhuvKUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofhuvKUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FF41F000E9;
	Fri, 21 Aug 2026 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341333;
	bh=3TPsUfDOOa44a6VaX6hgCc67m6LJmfj2zzjdx5orqEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofhuvKUfhdiJgaM6mUkYMpkxzwCAbF77JPxajjEyfIVRXsTMr1weuK6Y2oJSeJ3Se
	 jWWlwLNAWmWLbBFMCbp4dkakenyZcXr/ExFpjng55X6VrSGxEIzbyTkW4SWZ56jzMh
	 xl55EfTObM00vEuHa79D0gbvzgqBP6MZSRLOSAONa6XbdvY+UzvtCFVBYu951O/sXa
	 FPn8cgwzhncDkTGswhr/yoJuQRMe5M/VS/WeTJLBDNMaylHUkTns4mfNpil0baF2rb
	 TeGHx0bBXXQMEW5vhKZVtrIqa/a1Sm2ze+zcUtc8jg7dAYdMZiSAagYVwpr+lRXwmQ
	 8gPdV92KNISoQ==
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
Subject: [PATCH v4 14/18] PCI/P2PDMA: Extract pure ACS routing decision helpers
Date: Fri, 21 Aug 2026 22:38:45 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-14-94426b96de73@nvidia.com>
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

The ACS routing decision and Egress Control Vector size calculation are
mixed with config-space I/O, which makes their branch-heavy behavior
difficult to exercise independently.

Extract pci_acs_p2pdma_decision() with explicit Request or Completion type,
target availability, and vector state inputs. Extract
pci_acs_egress_port_valid() for the encoded vector-size boundary. Keep
config access in their callers and expose only the pure helpers under
CONFIG_KUNIT.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 70 ++++++++++++++++++++++++++++------------------------
 drivers/pci/pci.c    | 26 ++++++++++++++++---
 drivers/pci/pci.h    | 23 +++++++++++++++++
 3 files changed, 83 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index bcbbdbd8ee47..632f2d8c51e0 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -538,22 +538,45 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 	return NULL;
 }
 
-enum pci_acs_p2pdma_state {
-	PCI_ACS_P2PDMA_DIRECT,
-	PCI_ACS_P2PDMA_REDIRECT,
-	PCI_ACS_P2PDMA_NOT_SUPPORTED,
-};
+/*
+ * PCIe r7.0, sec 6.12.3, table 6-11: decide how a peer-to-peer TLP at an
+ * ACS-capable ingress port routes, given its ACS Control register @ctrl and
+ * whether it is a Request or Completion (@tlp).
+ *
+ * Egress Control applies only to Requests where the target is known (the path
+ * divergence). There, a set vector bit redirects the Request only when Request
+ * Redirect is set; with Request Redirect clear it is an ACS Violation. A clear
+ * vector bit permits the Request to route directly. @has_target and @egress
+ * describe that target and its Egress Control Vector bit. Completion routing
+ * depends only on Completion Redirect.
+ */
+VISIBLE_IF_KUNIT enum pci_acs_p2pdma_state
+pci_acs_p2pdma_decision(u16 ctrl, enum pci_acs_p2pdma_tlp tlp,
+			bool has_target, int egress)
+{
+	if (tlp == PCI_ACS_P2PDMA_TLP_COMPLETION)
+		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
+					   PCI_ACS_P2PDMA_DIRECT;
 
-enum pci_acs_p2pdma_tlp {
-	PCI_ACS_P2PDMA_TLP_REQUEST,
-	PCI_ACS_P2PDMA_TLP_COMPLETION,
-};
+	if (!has_target || !(ctrl & PCI_ACS_EC))
+		return ctrl & PCI_ACS_RR ?
+			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+
+	if (egress < 0)
+		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
+	if (egress)
+		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
+					   PCI_ACS_P2PDMA_NOT_SUPPORTED;
+
+	return PCI_ACS_P2PDMA_DIRECT;
+}
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_p2pdma_decision);
 
 static enum pci_acs_p2pdma_state
 pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target,
 		     enum pci_acs_p2pdma_tlp tlp)
 {
-	int pos, ret;
+	int pos, egress = 0;
 	u16 ctrl;
 
 	pos = pdev->acs_cap;
@@ -563,29 +586,12 @@ pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target,
 	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
 		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
 
-	if (tlp == PCI_ACS_P2PDMA_TLP_COMPLETION)
-		return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
-					   PCI_ACS_P2PDMA_DIRECT;
-
-	/* EC applies only to Requests where the target is known. */
-	if (!target || !(ctrl & PCI_ACS_EC))
-		return ctrl & PCI_ACS_RR ?
-			PCI_ACS_P2PDMA_REDIRECT : PCI_ACS_P2PDMA_DIRECT;
+	/* Egress Control applies only to Requests with a known target. */
+	if (tlp == PCI_ACS_P2PDMA_TLP_REQUEST && target &&
+	    (ctrl & PCI_ACS_EC))
+		egress = pci_acs_egress_ctrl_is_set(pdev, target);
 
-	/*
-	 * PCIe r7.0, sec 6.12.3, table 6-11: a set Egress Control Vector
-	 * bit redirects the request only when Request Redirect is set.  With
-	 * Request Redirect clear, the request is handled as an ACS Violation.
-	 * A clear vector bit permits the Request to route directly.
-	 */
-	ret = pci_acs_egress_ctrl_is_set(pdev, target);
-	if (ret < 0)
-		return PCI_ACS_P2PDMA_NOT_SUPPORTED;
-	if (ret)
-		return ctrl & PCI_ACS_RR ? PCI_ACS_P2PDMA_REDIRECT :
-						PCI_ACS_P2PDMA_NOT_SUPPORTED;
-
-	return PCI_ACS_P2PDMA_DIRECT;
+	return pci_acs_p2pdma_decision(ctrl, tlp, !!target, egress);
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
index 32394e349766..4593fb43f96c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,7 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <kunit/visibility.h>
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/pci.h>
@@ -1079,6 +1080,28 @@ static inline bool pci_acs_rr_ineffective(u32 ctrl, u16 acs_flags,
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
+enum pci_acs_p2pdma_tlp {
+	PCI_ACS_P2PDMA_TLP_REQUEST,
+	PCI_ACS_P2PDMA_TLP_COMPLETION,
+};
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
+enum pci_acs_p2pdma_state
+pci_acs_p2pdma_decision(u16 ctrl, enum pci_acs_p2pdma_tlp tlp,
+			bool has_target, int egress);
+#endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
 				 enum pci_acs_scope scope);

-- 
2.55.0

