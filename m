Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA6BA45;
	Sun,  5 Apr 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775403766; cv=pass; b=RT35fv0Gm9i90SmBRFwj37mrBN80Fj5R4Kegw3aWNuF4E6ZxkjFyZLejagim/UjQJ97qmCXX+qYiSH38Oq/KerORAq1SSoqtnOGVXJ9GBcGwNb/peLtxkKjnHsEF00ZmVNSrVaSGICjlrZgslqat/3D/pFZJ9L66AvydnHY2fH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775403766; c=relaxed/simple;
	bh=ocON1VQDAffjSTN+FN6PCUJPWpGqHythNb1L45yxuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9CMZ/FJW/4SOR4vf4TSuPfY0KX+B6fgQRFEmnxloMmIl23Odviw/Mroc4XJ361CY2/3rArun3X1LN9KCrXME0BO2BqnfZRKwcLyr+PDJk+uuaM65Y5gjXoHbhGlcTGngcBRYVR9KoZKHR5dJ6B5Q3rEOcAgSe2uX49rCv/qT/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Tfnf3itI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Tfnf3itI"
ARC-Seal: i=1; a=rsa-sha256; t=1775403742; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=abFWnnI5IKtdxUzhs3hKGhaKHjDJVVUI5+fV13TD4hRXpl7xGFT/vv+3NdFb/mBeIzRZqwrYKrwml9t3h8Q89OsgdIONDD2pw9bb8/MVeOOuoBlUVPvt4q54ri0yzZmk45YA1xjPGmwz5a7Jo1PXTxdQ/qzlGXKK+0rBkHiYT1Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775403742; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=24hyvMXW0XjpNbHAgW3h4Frtz4FpSP6l+QFo6AkVhNk=; 
	b=TfCzjcc3r5QgnBlM/I2/3JpmCNBPPzLxvDA1lQWrZsVzLwkMdggDwkro937Tko/POyeOXEB/PT27tUkXMhGFiPfQT276Nb1ai4KQreJE/ZNGdC1zAUOBO8LKRCVPwDuj65CmE+4UAvaKTvNThr2Ztl7hyXsT5xHdbF3H/v8Feq4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775403742;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=24hyvMXW0XjpNbHAgW3h4Frtz4FpSP6l+QFo6AkVhNk=;
	b=Tfnf3itIpo4p0ml7SKsXdn25GKavEnONi7lnCHgXBTZIziobb5mFq82OhJtgDpiP
	NvUVyC0mAeBX9iga/VsSRPVOcWvd+M8eC4HdHrHCJH1xOw2WcyllgbUTc9aBTdzoYUF
	XnSPT0IrtNPuy9nnVEgsEhZf4I4peoibzHE/6y7c=
Received: by mx.zohomail.com with SMTPS id 1775403739380128.47049292255883;
	Sun, 5 Apr 2026 08:42:19 -0700 (PDT)
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
Subject: [PATCH v3 0/2] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
Date: Sun,  5 Apr 2026 15:41:52 +0000
Message-ID: <20260405154154.46829-1-me@ziyao.cc>
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

This series defines quirk flags for Cadence PCIe host driver to allow
disabling advertisement of ASPM L0s/L1 states by overriding LNKCAP
register, and set them in SG2042 PCIe driver since SG2042's
implementation is broken.

I've considered to re-write LNKCAP after cdns_pcie_host_setup() in
SG2042 platform glue, like what has been done in the v1 of patch.
However, cdns_pcie_host_setup() performs pci_host_probe(), which finally
invokes set_pcie_port_type() on the root port. It reads ASPM-related
LNKCAP, which might lead to dangling pci_dev.aspm_{l0s,l1}_support
values. Early PCI device fixup won't work for similar reasons, since the
fixup is performed in pci_setup_device() after calling
set_pcie_port_type().

It's hard to fix up the LNKCAP earlier than invokation of
cdns_pcie_host_setup() in SG2042's platform glue, either, since
the function also performs resource allocation/mapping, and we have no
access to the RC registers before it returns.

The safest solution which also depends on no PCI subsystem
implementation detail is to have the LNKCAP fixed up right before
informing the PCI subsystem of the device through pci_host_probe(), so
here come the quirk flags and the ASPM advertisement disabling logic
in the core Cadence PCIe driver.

This series is based on next-20260403, thanks for your time and review.

Changed from v2:
- Use flags to allow platform glues to inform the core driver that
  ASPM implementation is broken and should be disabled, instead of
  introducing platform-specific hooks to do so.
- Fix Co-developed-by tag in patch 2
- Link to v2: https://lore.kernel.org/linux-pci/20260227181925.52475-1-me@ziyao.cc/

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
  PCI: cadence: Add flags for disabling ASPM support advertisement
  PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports

 .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-sg2042.c  |  2 ++
 3 files changed, 28 insertions(+)

-- 
2.53.0

