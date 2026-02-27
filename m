Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C636EA93;
	Fri, 27 Feb 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216411; cv=pass; b=rzshS5skGWIg3tUJ7lNIbX71gPfP8mHYGQiuZEOoYndt5kHuIfBnP2KZ4jjcRmDGa+2MpI51iP/f8EL+lB3Edc7x4xaJB/VHYVswryde2296qmgK9QspJR/Q5ACNooT3BmlWG+0DPapT5XZJRhX4Hw8xGxQDA3dpqBm40SdNt3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216411; c=relaxed/simple;
	bh=dTicyHKk+McSfpxEeZN0vSk+Xryaq0ZOArBbB3BN5dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jz4AbwwkFlVKsLeibeaTECEfYJ0FGL1uoWBbAB08YmcL7ZJBAOE5n+X2tEllytOwD+c//hVn/CyVuQUCdFtqPAA0Lpob9dUX4xsybfOKHk3F2yNaaiUzETe9nb7kKmCFSXIOMJmihACZDQIkJo14k9OZKcJhtPftlfB8q+NXx5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=jA9viMYR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="jA9viMYR"
ARC-Seal: i=1; a=rsa-sha256; t=1772216387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UiYoH/z0W8BnpfNkMeB3QdwZrVCke4wlPXFl7O5uQigNgGu/qUUYZIbnspczE1kCdP4+7QCrr+z4m9QpTrTBv4xEYXHG1jCa9gHhgKWnciGXFdVAxZAy962wnu8P4RcP8KMVcBZ4DWm+//qI/nAyQmtGqydI9etrLEE0nU6QIaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772216387; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+T7bP85E5zPnMI829R0Q1ILAaLJkVoa523XyYyDXKJM=; 
	b=L1gwreoyzC2wlBCNEdMge0bbncv8sC1bxLngRWWQfQc1oqZExT6FxBMy5YXb2e1DlNMAC9YgojE5sNUPOnrVSzWHcPutHypVFY3QiZjDq0p/MnTE1REW/71kj7z/VyCjUT33bxDyN7aNxAMhtQ7kF1CzITVP+9Fa0poYUnjHcBI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772216387;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+T7bP85E5zPnMI829R0Q1ILAaLJkVoa523XyYyDXKJM=;
	b=jA9viMYRIi5zhfSIIJZQ046ls2P+vF0TI0zUGclaIed4o6A2nfKTQgcB3VtF8pfE
	m7JqRniArj5OjEGeLZMriKYaqkzGLxtBUsqw20YFHnvpLqk8PU7S4tb0ktWsbuGNGi8
	sHfS/rVVf/QSWpV421z08/y5lQYdK9rEKNNM5FiY=
Received: by mx.zohomail.com with SMTPS id 1772216383532234.26718016226664;
	Fri, 27 Feb 2026 10:19:43 -0800 (PST)
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
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 0/2] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
Date: Fri, 27 Feb 2026 18:19:23 +0000
Message-ID: <20260227181925.52475-1-me@ziyao.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

After talking to Inochi privately, I'll take the patch instead.

This series defines initialization/de-initialization hooks for Cadence
PCIe host driver to allow platform drivers to override RC ports
properties, and provides such an initialization hook in SG2042 PCIe
driver to clear PCI_EXP_LNKCAP_ASPMS since SG2042's implementation is
broken.

I've considered to re-write LNKCAP after cdns_pcie_host_setup(), like
what has been done in the previous version of patch. However,
cdns_pcie_host_setup() performs pci_host_probe(), which finally invokes
set_pcie_port_type() on the root port. It reads ASPM-related LNKCAP,
which might lead to dangling pci_dev.aspm_{l0s,l1}_support values.
Early PCI device fixup won't work for similar reasons, since the fixup
is performed in pci_setup_device() after calling set_pcie_port_type().

It's hard to fix up the LNKCAP earlier than invokation of
cdns_pcie_host_setup() in SG2042's PCIe driver, either, since
the function also performs resource allocation/mapping, and we have no
access to the RC registers before it returns.

The safest solution which also depends on no PCI subsystem
implementation detail is to have the LNKCAP fixed up right before
informing the PCI subsystem of the device through pci_host_probe(), so
here come the platform-specific hooks.

Changed from v1:
- Disable L0s/L1 capabilities through LNKCAP instead of LNKCTL
- Introduce platform-specific init/deinit hooks (new PATCH 1) to
  realiably overwrite PCIe RC properties
- Link to v1: https://lore.kernel.org/all/20260109040756.731169-2-inochiama@gmail.com/

Changed from the original patch:
- Use driver to mask the ASPM advertisement
- Separate from the following patch
  https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com

Yao Zi (2):
  PCI: cadence: Support platform-specific hooks for RC init/deinit
  PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports

 .../controller/cadence/pcie-cadence-host.c    |  8 +++++++-
 drivers/pci/controller/cadence/pcie-cadence.h |  7 +++++++
 drivers/pci/controller/cadence/pcie-sg2042.c  | 20 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.53.0

