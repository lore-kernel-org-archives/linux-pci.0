Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD3331202
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735876; cv=none; b=VOix5cUaBYSvq9QPAHl1hevSUMnhNb5PIQY5seIwLt/YEJf33biYnjZrA4JiBun2QRl0OhDkQS4mjt8MUIHUbQOVqFICELffyQL60dv31lJ/4Dj9TX83JDwl5dWxu4oH+UFKhoXr6fJWVlp45V880NPRg08cByfpfY6i0FXp2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735876; c=relaxed/simple;
	bh=IYEi7rOKnpTN6/hhqx/EzA9USZK9EkEef9xnvzeakGc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LSFZ9A4JAwrK6O6km/bLSLHjSmxcXFUCUHfypU09uHjK5knWlbF8rc6VMWVIOeOGWHqlcePIc9o2A37GuhuL5XW6axdHu2KPD7nhg/P+epF60f7wMfIaZ3j0hxCE/rBcaqYIX9kpojTg+PRaB9oPd2aeXAxG/aMljusT7YUervw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Pm9C+a/i; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pm9C+a/i"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f91c8ff0;
	Wed, 30 Sep 2026 10:22:23 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] PCI: dwc: Make the MSI domain naming explicit
Date: Wed, 30 Sep 2026 10:22:08 +0800
Message-Id: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0f01ec4c503a4kunmb069125d8a7d74
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh5PTFZPQh1MTEpITh
	1IHx5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Pm9C+a/iCc4nDD7Gub2Mg1ZkjB7PNKUKn6Z6KgGfz+HkuVNC6bXXw9juSknNI9uImDylS56oJUFNwFAzGvxadqqmYxZdm6Qq984fhcR/IGyxldCH/SA/DTwDQxE5D6cQkVenmQKcOQQz1J0F/8UxeCQobTlJRU4wDkD2LwBLEMg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/Srq4VVHm377tPRqrvyNjKwXnhsHOvuQRG3AAtiL88c=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


I was looking into whether the DWC core provides a common INTx irq
domain registration and handling flow, as several glue drivers owning
a legacy interrupt controller copy-paste the same code (get the
"legacy-interrupt-controller" child node, create a linear domain with
a one-line .map callback, install a chained handler).

The DWC core has no INTx equivalent at all: dw_pcie_allocate_domains()
looks like it could be that helper at first glance, but it only
creates the MSI parent irq domain (msi_create_parent_irq_domain() with
DOMAIN_BUS_PCI_MSI). Likewise, struct dw_pcie_rp::irq_domain only
serves the MSI parent domain.

So make the naming explicit:

patch 1 renames dw_pcie_allocate_domains() to
dw_pcie_allocate_msi_domains().

patch 2 renames struct dw_pcie_rp::irq_domain to ::msi_irq_domain.



Shawn Lin (2):
  PCI: dwc: Rename dw_pcie_allocate_domains to
    dw_pcie_allocate_msi_domains
  PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain

 drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c         |  4 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++-------
 drivers/pci/controller/dwc/pcie-designware.h      |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.7.4

