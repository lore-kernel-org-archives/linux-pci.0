Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414F3A7821;
	Mon, 16 Mar 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676347; cv=none; b=WWF4ggurx0tWKMxDA8NFCSQBC5WLHgAcQLGuMm8Hg26rZ0eEZZKQ99bKwze02fZQlHF/jYObDleHksM8kbso48REQJn186oJxyadnSPSluUeiO5RLsHOTADKlpzmoXKzoq4Q8o/39dtWiu9rJE2p46SY25kpD5WHGprTNQGPGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676347; c=relaxed/simple;
	bh=uUXNMZYluYxDTZUEM+CIKLtifIX4NVIKuEd3JX+jz1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BfoqLkivCNDjHhvr90sWs0bprwKO/ZMZ+6kmejHwfL/82JfBXOw3RN/kw1uhMwjNy3UK730Y4A4DyKRJs6MpdxYnh+oATUHkRNAUj3ZnEFRLL+iBN1MWQVqIQJLQ9ikrmTwhTxsEIDepqzHQfEKVl5+tnuYy9V0YZmO9ZLYolHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=r8UOBjjD; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="r8UOBjjD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BADB302EB3;
	Mon, 16 Mar 2026 16:52:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1773676334; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Q11hnzTKrbJQfR59sChwy59iNTTXeocJ+Lmy3WVGuHU=;
	b=r8UOBjjDoVmxU+sPlo88yabF/Mg1DAzDSQHVocQGzeE1FKHIyY3uan5sdVc13u7FKMjQDO
	cisBH+YubhmFq9UHP8YNddsBPAtUicq25lCqPoqnwlQc0N83uWY87IkKFelWWyuXs6+4rV
	0HXANlpP9U1H+qEQC3cDfaSGBIp/CYHzV/Hr/rBeWdgv1NKG3J7+upIO+F3QVhw1F1ABri
	0PegtrcI62pXDFtWq0lumkKHeeW5rntXJdYW/HuC1hjDNDy/bWYVksyghcDz8li+ObOZBs
	9gXfRDUnBq9aqa19HaxYD+kI86NaLdjLal/96GzFgiSJi6LUkaEZ6r1fNwVrZg==
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
Subject: [PATCH v2 0/3] PCI: mediatek: Add support for EcoNet SoCs
Date: Mon, 16 Mar 2026 15:51:54 +0000
Message-Id: <20260316155157.679533-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add EcoNet EN7528 (and EN751221) PCIe support.

Changes from v1:
* mediatek-pcie.yaml slot0 needs device-type = "pci", fix dt_binding_check
Link: https://lore.kernel.org/linux-mips/177334026016.3889069.9474337544951486443.robh@kernel.org

This was split from a larger PCIe patchset which crossed multiple
subsystems. I'm not labeling this a v3 because it's a new patchset, but
I'm keeping the historical record anyway.

Changes from econet-pcie v2:
* mediatek-pcie.yaml add missing constraints to PCI node properties
* econet-pcie v2: https://lore.kernel.org/linux-mips/20260309131818.74467-1-cjd@cjdns.fr

Changes from econet-pcie v1:
* pcie-mediatek.c Exclude pcie_retrain_link() when building as a module
* econet-pcie v1: https://lore.kernel.org/linux-mips/20260303190948.694783-1-cjd@cjdns.fr/


Caleb James DeLisle (3):
  dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
  PCI: mediatek: Add support for EcoNet EN7528 SoC
  PCI: Skip bridge window reads when window is not supported

 .../bindings/pci/mediatek-pcie.yaml           |  82 ++++++++++++
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek.c        | 118 ++++++++++++++++++
 drivers/pci/probe.c                           |   6 +
 4 files changed, 207 insertions(+), 1 deletion(-)


base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
-- 
2.39.5

