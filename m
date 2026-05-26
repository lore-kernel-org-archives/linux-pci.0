Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBE3939B2
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779770436; cv=none; b=vA6mdV8IsbZMStt9szC/k/M7FGM1LCCdccNcmUx9Lp2MCcVf3lhAqW6ltIeE6CXvz0W6s/xLUja0dC7l1koXmcCb9ko7pLdfrTqQq0g9/lNcQcT8rBcAt7X0PbpHTOjrTEe9OygM3u33yWXU2XILH32GCWcZBgfMfw2SWIuOkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779770436; c=relaxed/simple;
	bh=zvzSwkeql8zkbL4UMswwNiiZ74wZ49TFyQ9yAe65MeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NM768X8dHPJDzYZmwdS2K4jzXP4RREYoixFMM+psFccxiazwP2hQhi+z/sNCqy5EuPnbTiKavbVGn8YJ66DyEd80Y1aD9r+LCEGsHgsskRltHECu8HEvgApgQkUpCzEbJQodYSEwdFFXF/fQmGXuylPwDn3Oub/ghQHSLlWbjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7cCd2ge; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7cCd2ge"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba856db1c0so74429955ad.3
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779770434; x=1780375234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCdgiZ1TyX/pYhFXNqPTJ8AhKmze2m6Q5BqIjBmo8ps=;
        b=b7cCd2ge6bO9f1pco4ejfvMTP5IesiJZbC5B9iaDJsYKQjmx0OPatSoKvR8MS5XWHG
         bAv76ccpuTauROHTdZ++MhDxnr2nKakWIneTtFedD37wwxLPquOKI0rZAf1TrsepHR+d
         rY64jOnvUpwXs9/3eOfuHpEXz8zXyjMBinAwS45zT8UvO36F1+G3wxKv2SHupkNdL1SG
         Dhurd4c1l8/sekNQHxYrWZbFvrnyqwiZuE2Wh/jn6VYYSGLpHX4fSIqi7m7jV6J+jJc6
         Wxjqcj+cg4koOkC0TuFLDfhRVTOigyO9V8FgaegId50UE7D8vQfj6XnLJAokiirPRSZt
         RFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779770434; x=1780375234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCdgiZ1TyX/pYhFXNqPTJ8AhKmze2m6Q5BqIjBmo8ps=;
        b=Ls6NNXexD94ExaBCHDX060HyHYqmUI7eTY8jkmvAP0ZXpLQ9jJZvJANRTq6GJ86jNS
         M/pkttZuDO6/aJUCyX2K4qrNM0sC9jljszGtxLWQ02VXQ3JRQOS+l3IedfoFHgYr48RF
         r7P8pUL+f2q6ech21K6eNXzJZ9qE+LfTSSjj9Cm9LThgqvMylEr2dFmoQ57hz5N7GX7A
         koXJlh/rBW5STUPulD9qayRO73huaGsHbhpgC7f0OfS05EMQQeSFNzvE0XINjxb46UAd
         a5zwe/SgctixQrzqlMARMp+Bq5mmIHKNTgBDBR65jv3bkiB2wzGFtcgnC4d/Bn1lFMve
         fRWQ==
X-Gm-Message-State: AOJu0YyxLJdSWkWpw5qOPkOMuTsuOhRlSjERIBcdx0KLMSQmYiKgOsZ9
	VEvsT6frUTOiIGfNnam518fRAebgCny5KL8SXlnhaX4hW8nV2i9gizWxaP/r1jfS
X-Gm-Gg: Acq92OG0J6FY4E+RbdDTN+o2scjPIyw8xWDqcK7KOrpM/aCNaiikrHS/NdxdDJRsFlw
	hx4sw0JSQNpoPKsUqZq+PMINhh2iiboMjOfL5wSrp51Kn1c5zcbna2nTMwvWFEqVUlvA8/VQ/Df
	qzQau4Rfeni4BregnSg+HQaN2sHFK6QMyqneMU3ZATjHFr0/pwJIDAuhbCyBkmjpZDz77gPihtA
	vFG00vVdKUtO7rLGPSBJy0RWeyufzgXkLEHSdVgFaDKVqvBmVCGf1tf4EtEycTYeZExXt/eTTTp
	pwD22KsgUrG3mQVKpuvGzR/o7nrGAe1+sssUkU5ZQOSeresrci23ldXszJEI7l2rhsogwBBAjnG
	lxVtRU52jLZwgaGDVXHEpyBq0dynSs6Jm0p8u0wgWmPgYBI9Z+sTHlLaDP6x0V35FZL+v9zm4hj
	DqIvQET27j17nX8CcrgSOfA0YTFuL4VEt2lFEU8XK7uCdpmzH4lUBEc2ZAUvxtq3dJ3vUyjVDeW
	ur6TAEwoKSc/PCGk/8MrygoI3YdQreqpOM=
X-Received: by 2002:a17:902:c951:b0:2b4:5aff:de60 with SMTP id d9443c01a7336-2beb06fc2c0mr203575625ad.22.1779770434350;
        Mon, 25 May 2026 21:40:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c4f20sm107692285ad.61.2026.05.25.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 21:40:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linusw@kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR MVEBU (Marvell Armada 370 and Ar...),linusw@kernel.org),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] PCI: mvebu: Use fixed-width interrupt masks
Date: Mon, 25 May 2026 21:40:16 -0700
Message-ID: <20260526044016.1025613-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use u32-typed BIT and GENMASK helpers for PCIe interrupt register
masks.  This keeps inverted masks in the same width as the registers
and avoids truncation warnings on 64-bit compile-test builds.

Fixes this and similar warnings:

drivers/pci/controller/pci-mvebu.c:316:21: error: implicit conversion from
'unsigned long' to 'u32' (aka 'unsigned int') changes value from
18446744069414584320 to 0 [-Werror,-Wconstant-conversion]
  316 |         mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove sys_to_pcie change
 drivers/pci/controller/pci-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index e568528bad85..f5a3f7370552 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -57,9 +57,9 @@
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
 #define PCIE_INT_UNMASK_OFF	0x1910
-#define  PCIE_INT_INTX(i)		BIT(24+i)
-#define  PCIE_INT_PM_PME		BIT(28)
-#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
+#define  PCIE_INT_INTX(i)		BIT_U32(24 + (i))
+#define  PCIE_INT_PM_PME		BIT_U32(28)
+#define  PCIE_INT_ALL_MASK		GENMASK_U32(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
-- 
2.54.0

