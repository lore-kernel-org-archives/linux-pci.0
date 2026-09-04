Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A52EB0F
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485032; cv=none; b=dcqb2HpDUVnKPRtuDn88B7AsNLPAhVwBCEmG5UD8CSZZpEBC9GN+jS8D9nhX7F/UZgrStdypmzoEsSXGNDLpaKpMzk8PMb0MBxgXfYV+c6KrdZmsYXabRvRzMqLxJrdGXnd0t93WVTUIQJUc15vCTkPqlC4yiG6aKTfbRtMdd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485032; c=relaxed/simple;
	bh=5KRuidI61x5Xn10kgUtAvdnBMwxK1jBfIfrBpHig07s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J+TZXG1cRboS6AJaxvQhyyZlM7fEoOlu2+Mo508e2/f21QHUEygveiTBuIJWSIvyY71rE5PTxZ+ufy6IVCRXpqxThg75bLKh+egKCq7isLPBX19Gn+O+9/o3vyizTfQh3BdanVzCMyVM2UMGy66tiHvuqEmp9jt3i6F/e3OUgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b0D08dED; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b0D08dED"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c7b37536;
	Fri, 4 Sep 2026 09:18:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/2] Small INTx fixes for Rockchip's dwc based PCIe controller driver
Date: Fri,  4 Sep 2026 09:18:27 +0800
Message-Id: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa069ff03b803a4kunm9a952c5910a91f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkwaHlZCHUlDShgaGE
	pMS0pWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=b0D08dEDNSXmTg3sPQ1bTGx9OB0mLt9praK1SjcNM3Ify72uOwx9Yfa14DCD+2+11IP/28sIqRITewbpCwlxL35sfwPxywvSm0czDpU83jsITV/KP7drEIUDK2LOjSZjVJCw+NtUxAt/lllPOqI3lNBis4wkP8/fVlvZy4jGx6o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ROTLj6fPCz77hVdZ7jCZX91HY49Q/uQv7uzwaMq3URA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


This short series fixes the INTx handling around the newly introduced
.reset_root_port() (b376b3ff9cb0):

Patch 1 stops .reset_root_port() from recreating the INTx irq domain
on every root port reset, which leaked the old domain and silently
broke INTx delivery afterwards, by moving the of_irq_get_byname()
lookup, the INTx irq domain creation and the chained handler
installation into rockchip_pcie_configure_rc(), right after
dw_pcie_host_init(), per Niklas' suggestion. The irq domain is made
devm-managed and the chained handler is uninstalled through a devres
action, which also addresses the probe failure leak/use-after-free
flagged by the Sashiko review.

Patch 2 keeps the INTx IRQ masked while .reset_root_port() gates the
controller clocks, so the chained handler cannot read the unclocked
APB bus and raise a synchronous external abort.

This series supersedes the v1 series:
https://lore.kernel.org/linux-pci/1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com/


Changes in v2:
- Moved the of_irq_get_byname() lookup, the INTx irq domain creation
  and the chained handler installation out of the host ops .init()
  callback into rockchip_pcie_configure_rc(), right after
  dw_pcie_host_init(), as suggested by Niklas Cassel. This supersedes
  v1 patch 1/2, as .init() no longer creates the irq domain, and
  removes the rockchip_pcie_host_hw_init() helper from v1.
- Made the INTx irq domain devm-managed with
  devm_irq_domain_instantiate() and uninstall the chained handler
  through a devres action, addressing the probe failure leak and
  use-after-free flagged by the Sashiko review.
- keep the INTx IRQ masked while .reset_root_port()
  gates the controller clocks, responding to the Sashiko review
  finding about accessing the unclocked APB bus.

Shawn Lin (2):
  PCI: dw-rockchip: Move the INTx irq setup to probe and make it
    devm-managed
  PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are
    gated

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 77 ++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 20 deletions(-)

-- 
2.7.4

