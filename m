Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D44746B9
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714887; cv=none; b=kuL7yBIqoXKLfR2ngrldEr0MC6MB4vW3OX+FUH/HjP2Shq69ylgRAlusSxOimeIooOivHT+EZ9zTx6iou4M2kbev8EG3e423WWRPJeyYwBcumlVFKPHPE1ndaOzu8GIZWfwtt+hZ2o474U1iuvtaVTyWTKdBel52McVW8T+8LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714887; c=relaxed/simple;
	bh=Hnh+B6I/E5Sb7idrJpw5doXhtoa+PDZgS3mAXBJ8cZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Wf+LMPB+0xBqc3BiXH1mYZQES0lKd1JUxJc4iyll7Sq4cd8Aa+PFUJ23jaYIGLWx5nxDb6zz0gk/5QG7VsEQ+pVskt1ZiJQjTZhdQlst9jF8xw0UpNIi04hePv4nnfgXFzuULy76WfZ6ISS9nFHVFp6zRA1pEak/Q9PIr6lWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg9hkXkr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg9hkXkr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d53197d8b5so2068005ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714885; x=1787319685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQJMGbWRZOZBiV4wbORCXaxh+L+ZkfgBfsK0yvrgZEY=;
        b=Jg9hkXkrSy617yAqSzQ3Xpnbh2a7goBUtZV2lDdv1OxlXeZpUQlbQK5GXGR8DaO4uM
         Kc0mG+tSiVShpny6SYCRWqn8DpxkkNOQhHgSbNG1bAtTXly+QeQz6cf5gkLQYfECem3I
         krtE+yW0eTnrtlIy0JF2WJASuGeH+OPKdGy89yYPhDfW1XPTs29E6Z8sYO/dH4JuglYy
         zcHO4dDLmkx7HZc+I+FHvcDadgaAzmpiedJuFZFyWqexw5pvnRBZdFrgmPnr6xBms3M5
         Y0BQZlPQ3VxbBkiUnluIaW+Zor8mI7EavoRP1CEFNf0UaheWxqFWTvJ9yuddaZ7pc5+I
         UhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714885; x=1787319685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQJMGbWRZOZBiV4wbORCXaxh+L+ZkfgBfsK0yvrgZEY=;
        b=JNSsgdxk+0qdQ00I554IaITz1Y8TKT79auh02mT/dsutqqDaN+/Xm3zz5Gu32h+J5c
         isNbjPp+qBhW1qvIvCKfPwsMvR0zJgJfZhG3LRZX0GjiEfAyzZ06NgRo1mb81+iR9g/H
         qGnW97GKW9eD8O+sO57IK1uk0KRsddzIai3Crw88JFZMTPqvrJCJGYtN4SUihWdv5wAi
         RvKUmjriBYm70lywL8b1HWmkGG2wtPO7CwhxoyJ4qnsfRAnNLGC/mZsINJyWyz9h19Jj
         FqxNPGGBQ+m0SI7x2L8vK48NZai8NQ7axRL8xKPDfY0IEfOmUNRQu2YElZZW7EGk3AjP
         NnuQ==
X-Gm-Message-State: AOJu0YyW/kWE4Ouad9nUMpzqQr9gYERaCKNoW/X8gQs46ZKjdb9PJdIu
	eUG7Y+vBJxdeZ4cyjfP5SqKjsB0aMpWZhN9HEZuSl5g97qRsZDNapOL0
X-Gm-Gg: AR+sD11WqFGsAYeDROO/ly2dPlzYY+/3C2pzzohoBDXj0e0U3qaeIDwqCYeIeY3xYPw
	joFf+XR+2tNryzk+Ro6jrGGHihCclTaf6BP4mWNvCCYoxVEiSe8IJ1EXuJDFDY7ecMce2J29x4E
	+nySE3YIf1GmdZYJu7hrQNsQ4TE5WLoRgpmsJfuq/kE9i/ecv1WnkSGMeN+Uq+bcZ4luuibBhbJ
	rifZK2HbVNQrd42nhOtfF1U3+cHA5oW0Ct3qT6ZZjlpqpf0ByEtSSLD5XVkpkMIbFj1s4YgzHk1
	ntWEPjOE7ST2A5axXQCxQe6r+aPXbcWZ4gSqdRvkHiGBrLQFPhP5jt8wlQveuViaP0DWyql0XMX
	reoou6ecF6J9p452MXeKVSWaLmwVYiwfasE4SlZbNpdx4XItlRm+ZBHgr3RiAPapn9fa8/Y1yUV
	V7J5AJuf4+ZjeJKPvAKCNBYZCDXrbC4D+2TDlujTilaILhQdFozficJl7qmy/e/1ixsnGrpebNx
	vPPo5lG
X-Received: by 2002:a05:6a21:d86:b0:3bf:a7d5:df38 with SMTP id adf61e73a8af0-3cc71b41dcbmr7176522637.9.1786714885326;
        Fri, 14 Aug 2026 06:41:25 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a33f34sm642128a12.22.2026.08.14.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:41:25 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] PCI: xgene: Fix device node reference leak in xgene_pcie_probe()
Date: Fri, 14 Aug 2026 21:41:18 +0800
Message-ID: <20260814134118.1387742-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgene_pcie_probe() takes an extra reference to the platform device's OF
node and stores it in port->node. The driver never drops the reference,
so every probe attempt that reaches this point leaks it, including when
CSR mapping or a later initialization step fails.

The platform device already holds the node reference, and port->node is
only dereferenced synchronously by xgene_pcie_setup() before probe
returns. Store the borrowed pointer instead of taking another reference.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index b95afa35201d0..cf9760f3a008e 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -627,7 +627,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	port = pci_host_bridge_priv(bridge);
 
-	port->node = of_node_get(dn);
+	port->node = dn;
 	port->dev = dev;
 	port->version = XGENE_PCIE_IP_VER_1;
 
-- 
2.51.0

