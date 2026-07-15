Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC863043CE
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077907; cv=none; b=umCtQJqZYw7jWFduCGxRoMfJ7wdy/hvJw9j/soXV6Kw1ZqjpovnwTTCvF/ujWMekEH/it0+I1jPk0LpPrEj2jQ8z3Bj3qySZgK5FV59P5aL4CA4R9TxWENI6dSs9B5ADGOwDpeVckVqm1wF+qdUZ5IEWPHnXshVkwulVfFUnsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077907; c=relaxed/simple;
	bh=9PAzvIUeGeWlH6fTPvnNN6J8nWpRGsBqz4064BPR1Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iz7GjT9WWY1QWIU1i1OB7ZJ7IfvkvTCEoDBQfV97zaUoTsf6VS/B6iks+3G3wMJs5WvQ25URNpwAmbaBvhHOgcfGEQaKEUVoXwQHlyBBG+6e61VjnyAfRP+zIBH8Go4oWwvMPISS8yRPnCIKjgY21RgVQd02OLJvSw9V6iI533g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5GHTzYD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5GHTzYD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacb8416a1so15598885ad.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784077904; x=1784682704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7t3rulmgzdudnQm0VJU/fmU5yA2DaWNz98HbbPrWp/M=;
        b=Q5GHTzYD/6QvjdRw8uSNQB7uvGd0X36ePYbXBpMEsY5pp2QLdZXH24I8L0Zl7et5Lv
         +Icfkcu2g+RWhoxv3PUoA3fak4tN0S5kbyB9161J9tOMl6zJ4S2nFdtsgBVpXS9UsdSZ
         U/72Lut+eZtRvorGw4x5MnkS8gUQ9cnaSydijIjET6ua4y8iN9O84eHDb6K8UcLRVEkZ
         ktFoQBKq/wXE27h6o0qSEHTpWrVutbyn1KSOUkDTY049LCyWTSuW9iToJ6UXKQwKkWXB
         3ghkRBi8vHdnDkOXJR864OcSjlspEjx5392UeHEyLCB1mecGiStkMkq8MnymyqWQ57nH
         OeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077904; x=1784682704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7t3rulmgzdudnQm0VJU/fmU5yA2DaWNz98HbbPrWp/M=;
        b=hp5XtEi8/ExOdBp0rQ/lbnkraON/mRgay1kqeGXFBn9+eCCfk8d9p+ofYz+REH/NU+
         Nl6jD97FxSj91c74PDbtsKPwIJUEGSxl8HRPV0PLf0AIyFGVVFCh2Bkvea6FjAfohy4+
         Y67bfbKKuF4huLgOZhS/CVO3FynLpdMhxE0EggQNU49t+u0w0/GpaolCO6GD9ulA8sSA
         oFcSezvOsblwJ6LIkz9pR4D+sq86cysz6ny2Rt7iYi88dbCDG+Pv0dsFe0d29OJ1p8g0
         Y1N1y/dS36eSeQQ65oUK8pDYjdqxYdaZA9q4XtvAdvUAh0/Ur3rmzao6RSCSYH14gN9S
         x2QQ==
X-Gm-Message-State: AOJu0YzEr1SX5KSXWouqrESSv2oRutpdxyrW052me/NR58SUYkJefE6U
	OQ03MCAmoJvo9KXt2RRsf9LrFZW01xCofMzRLAV2AFySl7U/1oeouUBtPYijYvKh
X-Gm-Gg: AfdE7ckTJrbveR+Os8Gs5XrAjTLVKp0JipNhFUI2pOLtDWp7n98Dp0MfLJGU4JZOMjD
	g5yVqplqd2ulenLHxuDLtml6VEOoW/8p15TzJOOl1pUfTUSbddU/Sf6T+lYIgmzYI7HAhsfaQqN
	tQOZaVccxdADwcyedj/kClEQznIqLOii5KRQFdEfHSsHx95uwUbwBweUJqRu5brKk3bgGWhnl40
	mnGKLazHSmOOw5RzFX08gEVfzKqhMRilw0StSJEZ6jhUm9pC5c7qofEbxUMPAarUlVUfiPJdiic
	Fgpdxp4E4OE/kWRfHbjdCqdJeSHQwDB3SplYKGnwe7p1XnxE+A+PuIqKRyxA1WKEzmN7LMANDPl
	B1PxjRI2uZpnDmkoO9BGJrGJxquM9PO5hlwNdWMs7RKFhJczDaszgoMEPfJ+lwjOQnPMAyHnDha
	WCs2v0kLyykIvHMFAO6qDmsJCowAulMzG6aqQADaA8IqP7D6ZQRyKhEaibT1BwTjo0YPwbG09Xo
	DZh2zs+GanZ9pkPGLEfKhIr3VkC+GrG2OJ/7wLpcJIdoPJSM/oLNWYzFFR9pzNMkg==
X-Received: by 2002:a17:902:f706:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2ce9f3c2c44mr142226605ad.40.1784077904158;
        Tue, 14 Jul 2026 18:11:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cee5ccb579sm26357165ad.52.2026.07.14.18.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:11:43 -0700 (PDT)
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
Subject: [PATCH] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
Date: Tue, 14 Jul 2026 18:11:41 -0700
Message-ID: <20260715011142.1261469-1-rosenp@gmail.com>
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
 drivers/pci/controller/pcie-xilinx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 4aa139abac16..a7b069f7673a 100644
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
-- 
2.55.0

