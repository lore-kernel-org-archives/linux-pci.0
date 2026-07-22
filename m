Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D94582CD
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761939; cv=none; b=uwIjJ7YlGYrgClrrbXlMHRxfhPFeu/RBCtTU/CBN19ZUL9OEk0sKEx9tIAz2eh1w4UryXIoryqdO/X/zMDpMKHvBrK15AtljTGLNQLenXl4eToFnLPrVmQ+ugZBgYsYDz7zfENTIR8ZNloNckC76pjiPRXHwQBovPKPYRYUHhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761939; c=relaxed/simple;
	bh=8mJEiqWpJ3Uy4dQUJYF07RJY9w1WOi0WCyECqoz+Mms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jtx9NWvU3bGwDN9vwCL55kWHmi6BCa/XF3OepmSvYOKTZQziaWm4ywqcGMcX31k1CjVM15akwxVhe4VF/OmzOocZxGtL09Q7iw93Qw3uqw+oot7CwWL9e954cqQ4UKZFTyzMAuZQfxn8mOhXGNqmUuxk3M4QBdrF7ZfVRqkhOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roPvz2mQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roPvz2mQ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb973e6749so76517a12.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784761938; x=1785366738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zi7GSMqA7QuxsTCwMKttd2kWd+CObdR4i6iXZa5Nm8Q=;
        b=roPvz2mQYG9nYiP1F4Tj862+S/Hjgz6IfQ69BNgujol3n7pcKLVVc8cnusqtXO6g9F
         JP+K+vvIYSgwWWAsga1l+MlcsT8YQQpQX7Ns1ynekiJBP0Sui//Jfdbpj7lXMZt1e8iW
         DN5loyexHpSM7f5Q/U7f1B+HdRbqPT6zmm0sutmw/cw5vDaq8DBLBjd4Zs6WW91e25a0
         pWJYEYOYwmd45xES45If5MAoSOTSxwDhMtsLfAfk9Hyenp3MQm0o5I863zQ2XAH8GoZ2
         FY4Qa8Dja4gFKkR5+idZs9lnBEBSbM+KxNVM88iI2i2btPpnfMA3tavfpM0BPpfKSdye
         vrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784761938; x=1785366738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zi7GSMqA7QuxsTCwMKttd2kWd+CObdR4i6iXZa5Nm8Q=;
        b=MZbpVGS/sxOzM4UHnmDglpmsmABjinHSSUz8quY8gOQDmpMAGs+laW9/rD/CHyOMVf
         rwikp9+WYx3k1i2gH/37hMpgeP8y4r2mj7vG/EggQYWImyrc6yYBwZjyWk4OjfPcjKoK
         ynvAXBGyu4iu11VgRxRArKSfKn8q4P/kPuFqBo4cYP0C83nUaPao045I5UOerjRmeeSG
         b6d8YPhvqnI7KNn6vgyYp2O4boYNpT5eEIxpoPMzgvfc1VHqGwJUI0AFjRIXngfc8GDh
         /2rkOyfilTlL6GoaXgC/yohZVIhYP3GsDNMWymYMCiU/9zZsYpArnMUl94nGk8nrhLo4
         SNOw==
X-Gm-Message-State: AOJu0YxY/w5AQWDOlrZGPO+8HmciM822iK5vVca9oDPzc1geVwUzILLM
	rOeymaKDDhxw0R0unZiKx4G2lj5OoPzcUECEMtqyk6332mVzSoVDhjmwDEc7MA==
X-Gm-Gg: AR+sD1352Krtrmx6k/0LREyXrgI/3jakwhzWDnbgqA2JzaOAcCTyySWhACjxfRSw3dt
	gmWbABXjW2iYf22uEAh/WbiV+HW4kXFBA2WeUbTzyCqn9jxvWRuDpqbj5RSllkEy5qYrfwrLftb
	lTXGYUNP071E6rl0iOZZzYahIV5uAMvwpUdkHcnxbwvw0Fpve0CJ/F0lwTd8n6MS9M4Tnwv448p
	4PWV4dkVrP9r+1hKJ+NyEm3sNfN5dsWlB/Jd3JF7CpVLfhpngmwDVlBzYiXmyTqkYf3z3KIL/Ve
	ZdZIE/6A87AbGm8GvWy6iyNj4tKkSAgD4E2H5bV9XhKED7hism8fcCYo9cyi1sFa5BL74lzH1Ea
	sgoHMFLvovSim/DCvgdq+YYOIZfzyUBGrqJFLhI2+8F5UrB0/ruNAtyYIwhISHkhY1wuQrDohtb
	hoBCg4xlyh225m4ElFjLFhQxjQ/IQFSSlQNQ+ISWOqIK72NwaojxVLeZWyLR8SiE+UDlUpt2MCL
	3XCvxWFLF28BbLMrhfPhQO4W/F4ikf2Xj1BlZhBux2NtH910Q6iXTE=
X-Received: by 2002:a05:6a20:e290:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3c44b18a0bfmr515631637.36.1784761937803;
        Wed, 22 Jul 2026 16:12:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb9656c076sm695300a12.19.2026.07.22.16.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 16:12:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] PCI: apple: use fwnode_irq_get() for port IRQ lookup
Date: Wed, 22 Jul 2026 16:12:14 -0700
Message-ID: <20260722231214.857760-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with fwnode_irq_get() on the PCIe
controller device's fwnode, indexed by port->idx. This is equivalent
for an OF-backed fwnode but uses the generic firmware-node API.

Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ
or a negative errno and never 0 (it rewrites 0 to -EINVAL). So store
the result in an int and check for irq < 0, propagating the error
(including -EPROBE_DEFER) instead of the previous unsigned int with an
`if (!irq)` check that could never catch a negative failure.

Built for arm64 (defconfig + CONFIG_PCIE_APPLE) with LLVM=1;
drivers/pci/controller/pcie-apple.o compiles cleanly.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/controller/pcie-apple.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index c2cffc0659f4..535acf274b78 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -400,14 +400,13 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 {
 	struct fwnode_handle *fwnode = &port->np->fwnode;
 	struct apple_pcie *pcie = port->pcie;
-	unsigned int irq;
+	int irq;
 	u32 val = 0;
 
 	/* FIXME: consider moving each interrupt under each port */
-	irq = irq_of_parse_and_map(to_of_node(dev_fwnode(port->pcie->dev)),
-				   port->idx);
-	if (!irq)
-		return -ENXIO;
+	irq = fwnode_irq_get(dev_fwnode(pcie->dev), port->idx);
+	if (irq < 0)
+		return irq;
 
 	port->domain = irq_domain_create_linear(fwnode, 32,
 						&apple_port_irq_domain_ops,
-- 
2.55.0

