Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6862EDD58;
	Sun,  5 Apr 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775403777; cv=pass; b=SGnvuiziwJ67+Nn5zgYr33RfnMeaQMcQpSnY3NYix1KVe14mW4SJQBpSLEApGZKCFwPgJUbMSgLPQssWc5TIFHwj5qzpAx9s2p6MjpK/rlAySRN9Dm/F1zTcDXF01GW/QQZS86mgrWddvmEADjt4MQoQrWCZuNfQrd+EkTP7Gxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775403777; c=relaxed/simple;
	bh=z9ptgfV9D20kl6YhyEWxCPMg7cDxLySE4Dml3f2/GGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9hGNaw9Z17/tlnxlpSNSPTJ42SZdYzP9rKQTqP3bjJ745VhSiKlgOA9x0c6Z8e9fs2VXVK9a9XSLwI+53prwnm6Yzqzx3eAIpbrY6Df1DRI5Om4qvqsH3owoAEsvUMHF+2uim6psoUOMcneJEJERQOT6lpaOs7oqdtcpIHf47c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=OE3t4X7j; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="OE3t4X7j"
ARC-Seal: i=1; a=rsa-sha256; t=1775403754; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FC1xK/8hHzUfLmn1uHUSmIFq8Lg+fzkOdzg5NEnNCu1Bs0mZiNMgYoVGar9ywgLYRnqkLwLcxDCnsFL92GQYVdWwS4/BFS/5nWV4Umn+v7qdvC5fs/I10C+iW9qNR8MBmh25IrxJ2UvNuEzuljBlcoIeS+yX3FndRKtorrof4aE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775403754; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1PVEcOp97E5tLdQMKMMvg6mvW4Dcd/k5d5K5tE7bKKg=; 
	b=Ni393RsUzL4BoOGA3aMdj+XBVURn96AmqNCP/153FUrL2ypgGt7PAiNvqyxKjPnD35VnVabcTe88j8LiygnoFK2iDYaQ6TylvIsqFekCIzZeDDyJSv5d4RQ7mNZ3jwPVyHr1ZnlLnapM6eKy06EVru4TqKCUYstowq6HiGlin08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775403753;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1PVEcOp97E5tLdQMKMMvg6mvW4Dcd/k5d5K5tE7bKKg=;
	b=OE3t4X7j0mWqeHfTN+gQ2lxn08PU8iaaIXCal1VFExyrcXBrpNOHedo0i1AEnD/D
	cZq6qk5YcReOYy0wHoGyYeFd1Np+Ns0wdKSqgfqGpQD502ke/0f4LSr3HsEJ9iod53y
	beDmubHo3BGzzPe0KpELV9m4SNZWXcB5CTIMLDbI=
Received: by mx.zohomail.com with SMTPS id 1775403752125826.3576500241301;
	Sun, 5 Apr 2026 08:42:32 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <me@ziyao.cc>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH v3 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
Date: Sun,  5 Apr 2026 15:41:54 +0000
Message-ID: <20260405154154.46829-3-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405154154.46829-1-me@ziyao.cc>
References: <20260405154154.46829-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2042 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Set ASPM quirks to disable advertisement of L0s and L1 support, so
it doesn't try to enable those states.

Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/pci/controller/cadence/pcie-sg2042.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
index 0c50c74d03ee..4a2af4d0713e 100644
--- a/drivers/pci/controller/cadence/pcie-sg2042.c
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -48,6 +48,8 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
 	bridge->child_ops = &sg2042_pcie_child_ops;
 
 	rc = pci_host_bridge_priv(bridge);
+	rc->quirk_broken_aspm_l0s = 1;
+	rc->quirk_broken_aspm_l1 = 1;
 	pcie = &rc->pcie;
 	pcie->dev = dev;
 
-- 
2.53.0

