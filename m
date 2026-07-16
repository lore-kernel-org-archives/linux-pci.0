Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429963B14CD
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235499; cv=none; b=FiU+mDIcOGFlnf53FydUQOVUcLt2pt8yALHmuMgfU98LxoS1icaTRNT0g9xnYtV/NngbOKe7HcZrfX8A8mQCxMkd/XzIs6ARp3AuqheBDR+UVkFokofoSFSBfKAg/tPy4pe+EsnI/kAHmTybuCuE4Yl7X4n/i/zUSgPLzISToAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235499; c=relaxed/simple;
	bh=VOvAMvfYeW8jwurQgtx2Ch7WysVlLW2oA9Xl1uUCbDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH9nkObymmYFVNMshLe8KCXiJ8NPkMx41LRXgsnz1ihpenj+IJYPGqYPQsoRR71Vl6/jAp71UhLhVU4Od80XbcpzebvEZ2xKSNIM6dQaCT9tiUBk/3og8BmZ+fixFn8Wr1DdUspWnLLtQSse7xtnOViF5Ino/iUfJNqxLEbQItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuEHmmo8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuEHmmo8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e1a9d9105so3068964a91.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784235494; x=1784840294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkicxomHbCJpRgQf830JSQitBFyDcDau5PyT3QSlyao=;
        b=AuEHmmo8ho0AjFo+Bhh5r89kcxAAAKHrUPOby67wdGz2wYRBTs5iC2zrxDc7X+LfHa
         TlSM4uxxLJVCy5RfqJ+f/exFBCn408gkgr+DtB4ni6SvSOqqbHz8zALbVmGau7cVrD9g
         EzqNbc3YkEBW/LCYFkJDBtakoUwQxWz2zBiOeK5fw9T0yd3DeNutKDvkyKYEXiE6k3TG
         O4+LZXEWwoT1yGxB3IL7iuOVU0+4Gw0n/7D1692AyeGMEVfG+Mi5BCeg7GbPruXP+si+
         BEu0KhrmROR5iN69sF6fi2Woo0Pq2YnGuNca9kZxKfiCovBTWblPARefS3ChRc8u+AtF
         PFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784235494; x=1784840294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkicxomHbCJpRgQf830JSQitBFyDcDau5PyT3QSlyao=;
        b=XFIScvevRZxCCFjVQwlwB7aZo7M4bzC4KfbyAZ7gFBzFNqCUYhnTyj0DcmOStqwdXl
         rbo2evGwc+evhnPUWuu00QWX6PqZIGx3lbju27ZNV0bpWboVVQ9oS5KNC6QewR4D+rz9
         KXb5DcRMJqgmeCCfhfNVhgQcxbBaHN/LVO34vNhF/q7odV2fW4QQfLJx1woMU/yDwKWn
         vJOe7Ae6fS5LBTcTV6LTF0K7oNoE3P2qBCXHXcPnDrZmMPwELjOU/eCDzaKd9V0OlEAX
         cPsDCc2SkifoKI9ysGYZp6TOkEXMPJMdRLjxYvnd/aPhboFfFQOI3ya76jWzgnRRUypE
         sksA==
X-Gm-Message-State: AOJu0YykAR0OUEXp0kkvzHrWX34PEDFzevzoKoAfyQiIgE6nRWDaFmg0
	/yfgpbjN6lJ3H2N5qn6pb/E+1KSFoF6SdYnvy6emjFO2nTyKTG1llzDc9Ll+mg==
X-Gm-Gg: AfdE7cnJeUdcT8QJKmpM9qEfymuMpovsPsAzDp5SFtkrqfEzHDGBfrOt8l9+YUQ83p2
	FPwUdn7qEXSZHQ0iDefw8erjVaJWFyZprqu/m/0H3i3xNa5yYiI0mDC2iks4gxSDHNXOak6T6cV
	8uI3ZW7+7WPgP/8UuCLuHv2AbIn/cPgN2Cf7H0QfXCdjfNXsm29fQ1L2oZD1hUps8aDiAfh1610
	+NC26XQ8tD8xnA/wzBCiqVTSAhhAUYSxGNb2Pp7BInJykuV94mtPD6wkhb+ejzUzANjLdTGVeKr
	gnGJcMh+5F5tygSLBGN8AWZDukm/7aCtoJRyx6cVl2J968QzkoXoWTjWkUTUZout0RXsVc705C4
	7r1Y94Imqvsv4oj4kijFzgTeOYy7RCejR2t2NcLsK36o5Ve72CI/x4Rc9E+bObhLJAUoTqo9+kj
	RtnnvpYXwZAzQ/9cuYScS46AIbu0kR2TdaAwz+rpg/+w9VbI0LRKHRmkDWsTC/RIjB8ncoSD3ir
	7OxCDujsineisI4M9ZX8x0xK9nfz4qVm4cv9+vwfchcWHzT3y0EPAs=
X-Received: by 2002:a17:90b:510a:b0:387:e0bb:57ff with SMTP id 98e67ed59e1d1-38e2a10a4b0mr7707701a91.38.1784235493976;
        Thu, 16 Jul 2026 13:58:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39dee6a9sm1849749a91.2.2026.07.16.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:58:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Date: Thu, 16 Jul 2026 13:58:11 -0700
Message-ID: <20260716205811.800920-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent to
the previous call, but uses the generic firmware-node API.

Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ or
a negative errno and never 0 (it rewrites 0 to -EINVAL). Store the result
in an int and check for irq < 0, returning the error (including
-EPROBE_DEFER). This also adds the error handling the previous code
lacked, where irq_of_parse_and_map() failures were passed straight into
devm_request_irq().

Built for ARM (multi_v7_defconfig + CONFIG_PCIE_XILINX) with LLVM=1;
drivers/pci/controller/pcie-xilinx.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use dev_err_probe to handle EPROBE_DEFER.
 drivers/pci/controller/pcie-xilinx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 4aa139abac16..58532296182f 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -20,10 +20,10 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "../pci.h"
 
@@ -535,7 +535,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
-	unsigned int irq;
+	int irq;
 	int err;
 
 	err = of_address_to_resource(node, 0, &regs);
@@ -548,7 +548,10 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
 	if (IS_ERR(pcie->reg_base))
 		return PTR_ERR(pcie->reg_base);
 
-	irq = irq_of_parse_and_map(node, 0);
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (irq < 0)
+		return irq;
+
 	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "xilinx-pcie", pcie);
@@ -585,10 +588,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 
 	err = xilinx_pcie_parse_dt(pcie);
-	if (err) {
-		dev_err(dev, "Parsing DT failed\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Parsing DT failed\n");
 
 	xilinx_pcie_init_port(pcie);
 
-- 
2.55.0

