Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB743786E
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418296; cv=none; b=tJxLmLyx/+FEy7zPJtPZXnA5iDeQgi2Gfb3iFkdtBNaFAmyqd3EPNvfzTYzFFGTIpmnYrK7ytMdfXXt5zrd5GAWCFkLZmD0+hLvV0ym+22Z4uYHFhb4XuCaSEpXVMDdZjokVk/P4HDpRv6lwvLdrw307n1DP4PNToyrmqlRL0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418296; c=relaxed/simple;
	bh=sLZCN1fMvMG/Iy7fQF+FBadeS6f847zESP517FzZLQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfKEK6tel8exR+tCQWzSkyP45zpvuJ04LSuuL0ah4mHL1xjTmPqxv5wbwNgZV8wkIzgDgGstpwxvVWzY/hDM1Wt5U6YERvXecqLvIwSQBW4WrdciQHGmLLNE1PKukCVdTamRTRQds75vDL4Rlof5hHiIaVXz0Q7+cHWK3P0veOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX9Qd0lU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9Qd0lU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806561F00A3A;
	Thu, 30 Jul 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418295;
	bh=4QQ9IrGywbrji6ofx0oguz2UJ487vvhnj1eWYO5mFm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eX9Qd0lULOa+tWU9SJXvtPq3f8RvUpcEqfnHks3/amLQMMr5UyfQZLSrCDBw2AtaN
	 63P3SLu1Nqtr64dCPHwLJ0T2YIyT+VUcW3fQz8hBzH+J14PPmw/hcaPLkxFz3beZiu
	 uhjt1iO56g/QzYOBUBVRfJ+lSoCztizuZvlrrkCv3c7TM3Dd7Oj7PRBJm1uwD0w0AB
	 UBmIQMPfzE0cINg8/8Z01LhoI2VhMqPHVHQlbVzSOzuArn6FyOhCmrTcFt0BhlU7P2
	 RDr699j9Vx6m1xQvYsXifTmoZ4cA+Wd4+TAcX0riV4DRlefZL/9hOH+vxFFo7nyAUy
	 vnmFRo7A6d9wQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Sashiko <sashiko-bot@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: dwc: ep: Flush the cached MSI address before unmap
Date: Thu, 30 Jul 2026 15:31:25 +0200
Message-ID: <20260730133123.1420413-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730133123.1420413-4-cassel@kernel.org>
References: <20260730133123.1420413-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=cassel@kernel.org; h=from:subject; bh=sLZCN1fMvMG/Iy7fQF+FBadeS6f847zESP517FzZLQA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyg/T/rOj13Lt3afmnyY51Gm8/uaibPkoIrJnC9ltrw 7EP9aHXO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRF4wM/9RFg4w3yHKt3Z+y RcYq64zWjx9MspaJry873+w8+k1a8irDX4H0ilzL47+YNvzStDZJmXzs/TF2gev2TWulCjn25NT /4QMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While we do a flush before unmap in dw_pcie_ep_raise_msix_irq(),
see commit c22533c66cca ("PCI: dwc: ep: Flush MSI-X write before unmapping
its ATU entry"), we do not do a flush before unmap in
dw_pcie_ep_raise_msi_irq(), if the cached MSI target address changed.

Fix this by doing a flush before unmap.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-pci/20260729214859.B9E2B1F00A3A@smtp.kernel.org/
Fixes: 468711a40d5d ("PCI: dwc: ep: Refresh MSI Message Address cache on change")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..3128e7ae8c5f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1032,6 +1032,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		 * there is no unified way to check if we have operations in
 		 * flight, thus we don't know if we should WARN() or not.
 		 */
+		/* flush posted write before unmap */
+		readl(ep->msi_mem + ep->msi_iatu_mapped_offset);
 		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
 		ep->msi_iatu_mapped = false;
 	}
@@ -1044,6 +1046,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			return ret;
 
 		ep->msi_iatu_mapped = true;
+		ep->msi_iatu_mapped_offset = offset;
 		ep->msi_msg_addr = msg_addr;
 		ep->msi_map_size = map_size;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index de4b245b1758..1d2139474157 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -518,6 +518,7 @@ struct dw_pcie_ep {
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
+	size_t			msi_iatu_mapped_offset;
 	u64			msi_msg_addr;
 	size_t			msi_map_size;
 };
-- 
2.55.0

