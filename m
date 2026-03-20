Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CE346A00;
	Fri, 20 Mar 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999753; cv=none; b=K2iHUyDUKRjOl4EMaGZEcFrcLFjEpuftnTG+9pnjNdeLsp1ruR0m0sG/c88l7wDteWJP6mN3xtntNsTbCOcPaLOEBltMLyWBhjm4/c1rpPzE3nFLPIZbKcpaUvMt+zTqyd6vlShJE4PUsuUTpoujWo4RRNW+soKAbbD7ZEoWd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999753; c=relaxed/simple;
	bh=NsAeI/tJVp0o3XoadyYFRyR2ZSjxg6gmOIW5x4tBLmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNu3R+C9snYDWN7yqK+gCN7Ux1SXFRBILDVkS5NM8XvGlc2bSTxuunOS92ma9XdTnPaqnhmqIL5NrMUzPC/Qwskbf3I+anTkH1a/XqpCizVmuhLR5nBUnJ9K8EjN0Ab7pPk7AYUoiR50KIOBiX72Ds4JMU/ZcQBcSLrHr4JaHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=kIr8YWm4; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="kIr8YWm4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2085B360308;
	Fri, 20 Mar 2026 10:42:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1773999743; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=A/j3iAJkz4+vJeSH2EikPAPD06j5Xk+pcUsj1+dSTNw=;
	b=kIr8YWm4e/n+GCCbeIGTzpHtBJmn8iFZ2U3DnCwJ9+ZIEcAH3w2gMcEVQMW3wPGjtLzrC6
	FpiJuv3ReG7IMwWI+Are3ZFCThI6Fej4FjXfe7I03goggrDywINwcsn6HEA6djLDRA/+Ct
	ePOmM0lwH5VHszF7aIrZAJShhFtUlk8LGEceP3AoEBv2Nou/aeR0w6bG405vvsdEzeu4Pt
	3BZfF1+l9KKkXOculDmv6MaLCuy6MNxdZ3Xl6qFkJVhjiIPNIDmV32iE676gaIYYO+LWps
	siWhk5I3w1WsojPU9mcEDB6DgBE3dFdaD9pFHNPhEUvq+3GnXV1/nCZ3lYBBdA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	naseefkm@gmail.com,
	ryder.lee@mediatek.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ansuelsmth@gmail.com,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v3 0/2] PCI: mediatek: Add support for EcoNet SoCs
Date: Fri, 20 Mar 2026 09:42:10 +0000
Message-Id: <20260320094212.696671-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add EcoNet EN7528 (and EN751221) PCIe support.

Changes from v2:
* mediatek-pcie.yaml -> s/power-domain/power-domains/ and drop example
* Patch 3 dropped as it has been applied (Thanks!)
* v2: https://lore.kernel.org/linux-mips/20260316155157.679533-1-cjd@cjdns.fr/

Changes from v1:
* mediatek-pcie.yaml slot0 needs device-type = "pci", fix dt_binding_check
Link: https://lore.kernel.org/linux-mips/177334026016.3889069.9474337544951486443.robh@kernel.org
* v1: https://lore.kernel.org/linux-mips/20260312165332.569772-1-cjd@cjdns.fr/

This was split from a larger PCIe patchset which crossed multiple
subsystems. I'm not labeling this a v3 because it's a new patchset, but
I'm keeping the historical record anyway.

Changes from econet-pcie v2:
* mediatek-pcie.yaml add missing constraints to PCI node properties
* econet-pcie v2: https://lore.kernel.org/linux-mips/20260309131818.74467-1-cjd@cjdns.fr

Changes from econet-pcie v1:
* pcie-mediatek.c Exclude pcie_retrain_link() when building as a module
* econet-pcie v1: https://lore.kernel.org/linux-mips/20260303190948.694783-1-cjd@cjdns.fr/

Caleb James DeLisle (2):
  dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
  PCI: mediatek: Add support for EcoNet EN7528 SoC

 .../bindings/pci/mediatek-pcie.yaml           |  26 ++++
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek.c        | 118 ++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)


base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
-- 
2.39.5

