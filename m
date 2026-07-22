Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A204582E3
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762137; cv=none; b=h3PvPl+a08kvmQbzuSqaUWBb6EKJ+9h272D8CsVvfFkKgoUd73o4Xfdb31UVJaN2uO5OkJAT1YFfWLOCbGkv6SyKk+x3sH+7m4/ejUqKTHw9UQ723c6wpB8mLiFfowmW268ULeiAxFA/ldWZxLtk+tTHbpwnppdElbrYzjEk9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762137; c=relaxed/simple;
	bh=aCDnq0qzyxDiam31Skj1l/Kd6ie5IpEFzLKucDi3yrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcPxsLl7Nwm2swHBMP8rzgUv40dYHzMwVWfferbrmjHLumz/XMfbHz21890PDnBX9Z65zjuZdHk9EUfYnBlLnI00RrWDCcnTnhDSuHDqoNBPTY+8SIx8s5aHiaM0p/UlwMJQW2JwmoNn+Mol5uCE9ZgHJ3AMkRtyBS6dPVZAM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeaBA8bo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeaBA8bo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso35854a12.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784762135; x=1785366935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A666YiddBzubQJ14vmQH66RggGZrJM+23a2vA9KOgG0=;
        b=oeaBA8boReeT8VPMFDh/3VwVLpsvTHVSt66+brxhE0u9j1FfNa+0rR698i9OGhOOtX
         70hTcqQRorbXWWw2EFAkmq4osfMKWFYOIZtqN/Xm1tSSKC5yot0zyrnvpqe4O2D6510n
         O6Y9svfr/seANZIYC/F1Y5pSKyo7yDxjclrVt2qZ0Hed/oO4UlyQbxyPddAWOCZQonus
         /vXVzxmLQwJADshA1ld1re1GYQ1P9ScTiB8xZj15cLl/gsf3KcvJWvyL2V6pQXbFXqtP
         fSCY8PCjKqed4anid3m6Hbm98CDJuAHQ4pYtcJ+XVVUERht/IhfbzhzTnRrN2fvuV6eC
         4VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762135; x=1785366935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A666YiddBzubQJ14vmQH66RggGZrJM+23a2vA9KOgG0=;
        b=ZQMy2HkyzZzbjH/eQfeNhQSqd57VRmlIvg+uTIgQPKdZR/KKQMf2QoqksLx6wN27Os
         YxZXHJB1GmITHSXxSsccZ9coW0iOplL2hUnzUhDAO4lkzz2mm6axZqnn6lz9YwZh7rwb
         kvCB+/zZyuV0mhk6U9tdLFv3nw2+kPsrMTz+TsBrLNi9AefiufKrEaEItImjyZ64u8Mf
         go5iNoL47NHlO/y5rZBnykPCa8yrqI15ySSOCtlQVXS1oFB7o37xLeZo+rcAMoLLvVj+
         J6TehOflOeN7AAeRjicKYVrtHt5om3tPiicsY9o10AZYhkEQlutjN3M1yV72rxxiucZM
         fU/A==
X-Gm-Message-State: AOJu0YxSeLFqCFBTpauvLU7sySnLm+brrdETosc9exgls7d43JOvo/6k
	etSe9qbDER85ADeuMMxokCB4wulz3p1to46RdFzyCLkACHLYzCne84Ds3/Sh3nV3
X-Gm-Gg: AR+sD12YLEhoneBph43wPpgx3R+6DZTdQWFhIiBxWyM73TZYbdgWsdAOSz8iibP0gMF
	XxOcpIvDmkQiJj/dw+wsiwLgBSGayJ9p8x0EY5VKhE7sBqwxfmJ+JN3sPgxv3FPxnP2UR03gdbf
	5n4P/ypLJdZj8A1KBisHCNkzkqQnO99r9dXqYtQIemFz0sBZgRvex77fZxDNB4AzH/mqsXBIGul
	43snuZhxHcC4/h08vQgi0lDKnNSkSNV7+/WwMD/+nnbD+ilLIGGS0HMFcVLSEPXcA/B0nk05W0a
	BMOEC8KUsh5uMN3achb0bp2M4xZLqzpn7Ev3tuNDfN2/239/dEA87oSs0fAxIMOH3bITGI5Dr/F
	hdv1bZdj2FVJXpJn8YMZ3wG3f4U2Q5xC+XS74ZZyLlCs1FCB9UqlrM+D7pSlRkGQgRjlNhA/tnZ
	rKVwRAykwwTWgGR1NO8PaglGD1xWB0Gk0SoCl2wtdrW0rBFBHS6i7gpg6W5T4bY9JTr5P2FpQAE
	OO8EYl6XDlk3Wbc83A8RM5ZrGa3jOe2p95bWoh53uoovoAZxvcIx+HkvyoIEbWVPA==
X-Received: by 2002:a05:6a21:d82:b0:3c3:9557:3b47 with SMTP id adf61e73a8af0-3c44b202c16mr432634637.51.1784762135338;
        Wed, 22 Jul 2026 16:15:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a2bsm1798981a12.22.2026.07.22.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 16:15:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv2] PCI: dwc: uniphier: use fwnode API for legacy-interrupt-controller
Date: Wed, 22 Jul 2026 16:15:32 -0700
Message-ID: <20260722231532.872962-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert uniphier_pcie_config_intx_irq() from the OF-specific to the
generic firmware-node API: of_get_child_by_name() to
device_get_named_child_node(), irq_of_parse_and_map() to
fwnode_irq_get(), of_fwnode_handle() on the child node to passing the
fwnode directly, and of_node_put() to fwnode_handle_put().

Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ
or a negative errno and never 0 (it rewrites 0 to -EINVAL), so check
pp->irq < 0 and propagate the error. pp->irq is an int, so the negative
value is preserved. Drop the now-unused np / dev_fwnode() locals, since
device_get_named_child_node() operates on the device directly.

Built for arm64 (defconfig + CONFIG_PCIE_UNIPHIER) with LLVM=1;
drivers/pci/controller/dwc/pcie-uniphier.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix fwnode_irq_get() error propagation.
 drivers/pci/controller/dwc/pcie-uniphier.c | 25 +++++++++++-----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 297e7a3d9b36..29eb1b9abd26 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -14,7 +14,6 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -262,27 +261,27 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie *pcie = to_uniphier_pcie(pci);
-	struct device_node *np = pci->dev->of_node;
-	struct device_node *np_intc;
+	struct device *dev = pci->dev;
+	struct fwnode_handle *fw_intc;
 	int ret = 0;
 
-	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
-	if (!np_intc) {
-		dev_err(pci->dev, "Failed to get legacy-interrupt-controller node\n");
+	fw_intc = device_get_named_child_node(dev, "legacy-interrupt-controller");
+	if (!fw_intc) {
+		dev_err(dev, "Failed to get legacy-interrupt-controller node\n");
 		return -EINVAL;
 	}
 
-	pp->irq = irq_of_parse_and_map(np_intc, 0);
-	if (!pp->irq) {
-		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
-		ret = -EINVAL;
+	pp->irq = fwnode_irq_get(fw_intc, 0);
+	if (pp->irq < 0) {
+		dev_err(dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
+		ret = pp->irq;
 		goto out_put_node;
 	}
 
-	pcie->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(np_intc), PCI_NUM_INTX,
+	pcie->intx_irq_domain = irq_domain_create_linear(fw_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!pcie->intx_irq_domain) {
-		dev_err(pci->dev, "Failed to get INTx domain\n");
+		dev_err(dev, "Failed to get INTx domain\n");
 		ret = -ENODEV;
 		goto out_put_node;
 	}
@@ -291,7 +290,7 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 					 pp);
 
 out_put_node:
-	of_node_put(np_intc);
+	fwnode_handle_put(fw_intc);
 	return ret;
 }
 
-- 
2.55.0

