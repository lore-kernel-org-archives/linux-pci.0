Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2C327BEC
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077941; cv=none; b=ZCk8/Khas61P0PhLUIPkiGoCIuCQjgTBvd0fblN2/Sq6aUeUThu4O/r1NUB9R/2dJ87NFVdu9uBixUVV9rBad53IwYl7adD/vWgJg+ZtcxRiIyKpPQ5kBNxWXFHmO8vIiDIJPBBdDVUYGTIOExMUNz2JLHRkE4GcuGCMY8nRGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077941; c=relaxed/simple;
	bh=Y0hr3eibh9wzp7acg7/DbBtlU/G4AyrRZaiGVnITVR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KudPTlmwlD/OPHbAPvSlpvdD4kLAOS9z0abaeSeXswMN4tnfLLc2UdfNPB5ieDgPhXtvC2Fr1NcEmkOp4HOdcRbVTtK78T39UBuSDGnZPTUJ1YiZchUru0/5xb/CcpeqYHkOcVdaV05gg/W5NgYyVs2nL6XxddnQCQsclwp956A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnIZg6Qh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnIZg6Qh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4593213a91.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784077938; x=1784682738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCUYlxb6BsnAbaXQaOLOynpXjnyMHB9hBKlRYLAY5As=;
        b=LnIZg6QhNGTNvz0CwltbMeg1McRYXE/Fs4Qq4hjy4G1Ur0Oa0nbdPMUsVOPUahHObK
         KNLFNhkwS1NCslR/XUvqzXlCndtUOYlgz50+VLqCsew6r5dVD7kW5kfN+xeZ12lhh9cQ
         uNkc0m1rkhLbHuPEBkC9MFgygG0tACcBgRYuErLAU+tyHxR1o3Tq6buKntPmKQjn2qoi
         4TAXwsX98wedU1/udV4+cCAiCKFzSDqClx8mzc9RdQIzVN6jC6M/HbU+FyznCWqSnvx7
         Clq20F1X9L2Hu6+hVM97NtS7r+Fcpgyb5NCyP2VdzUbvN6WTkvYrf2X/KEvKVfPPW+AC
         aD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077938; x=1784682738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCUYlxb6BsnAbaXQaOLOynpXjnyMHB9hBKlRYLAY5As=;
        b=jok/XbHA4B5MIPQZg6fLnJHpTXLMoGT68uXfqCYvdoCB3sVMbn4IUQQb9R1y7ZbOib
         WGugacLqAoyUgl8zkTZVhNzZ8BDqqVSxv0sNhoBq6nHxQByJaBUG4O7d4pi6lz/tNNJA
         m4BFnib4qdKckTrUYdlj1+a4FpwcLanBzer9gFCXuzSEYhKsZzR1MSKjhI9yaVXHb8mM
         Ab9LtzzEkSlZPd7wv5tQ0EqGPFDGteJMUPKdWRIIB6AkG3vwf7hgzoYbnob5MFkNiXPZ
         9LH49kQEaOmxOuEdd8MuKobJDpsfuks/En8ILicPiddbTTvbuBQvCsNOgBYzMHwCw1k+
         NLbQ==
X-Gm-Message-State: AOJu0YxL8LaePnDMMoQPgG0Nh7wEDnHBoY8YDzU5fFxDgQPZ0lFsrPM3
	TRB4hA7b4SYlpk2Y+xlMk0a2CB5LxMLXB/ScIYuVpBY9taY8rS1fAlXjiVF3h5mw
X-Gm-Gg: AfdE7cnhvazV8WgYjADSg6NNcAMb7mZ1dyM483aMx5GYmI//wd4AnUMtsoLe6YocEH4
	l48EcL8DeFE7RGnphK82KpnoviE+PCP6AsubF0jojiSsA6f0p0eKsGEqNy8V2UOc4DmgQBu4F6y
	A3G1DRhAt8bxTj/iw2MDetFKsNW87eTvcY+PRoeqrCD0Y7a653mtmSt4hCrsQDFxrO8HGOopkZx
	TQwV+ZlZ1rA/4umBo7BbNgtk6bJ5+D9r41JGXapsVPxKJ1acFa0GR3hl14zMsufbuYWySIjBduT
	hz6migLDkQelYKbNIbga4GDjf7a1kJ54oYHucchS0EAI9gtJpEneXLEIDx1PHM+eDxRtlpwFXQJ
	DRG+BKaup0VekNyDvj6yJHUiL7/gEe1+BoQX3TAhQrItQVOncy0bY7Upf+ObmEEk4NtU4ramyrr
	NkooGTYULu+koTuwkM/SjOE0W6F856hq/ytg7VsnJv2HJmekgIziiPthDL5Guru/VqaxNxp4JYh
	tvcyMrvjTXpRUBqm4l5Hrtzubkqnln5gBINRD186D7eFbVY30TmrmUIgTTyxUPPsA==
X-Received: by 2002:a17:90b:51cb:b0:38e:7eb:d07b with SMTP id 98e67ed59e1d1-38e2a06179cmr845415a91.34.1784077937648;
        Tue, 14 Jul 2026 18:12:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1730accesm2235481a91.15.2026.07.14.18.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:12:17 -0700 (PDT)
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
Subject: [PATCH] PCI: dwc: uniphier: use fwnode API for legacy-interrupt-controller
Date: Tue, 14 Jul 2026 18:12:15 -0700
Message-ID: <20260715011215.1263935-1-rosenp@gmail.com>
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
 drivers/pci/controller/dwc/pcie-uniphier.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 297e7a3d9b36..6516264fdfc1 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -262,27 +262,27 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
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
+	pp->irq = fwnode_irq_get(fw_intc, 0);
+	if (pp->irq < 0) {
+		dev_err(dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
 		ret = -EINVAL;
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
@@ -291,7 +291,7 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 					 pp);
 
 out_put_node:
-	of_node_put(np_intc);
+	fwnode_handle_put(fw_intc);
 	return ret;
 }
 
-- 
2.55.0

