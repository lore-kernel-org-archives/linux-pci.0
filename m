Received: from mail-m103131191167.xmail.ntesmail.com (mail-m103131191167.xmail.ntesmail.com [103.131.191.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30237F8B6
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.131.191.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044648; cv=none; b=rRMnnCicZzFQB25lI5YbSKvUjzYj8T4xICcMdclZIjUgUHDJMMWTwSuOXSTInlSmAAsz/nhFdbG7HLpnAwUqD+VcEZnIpnOsnsB4FxTGgy6MWX8Vpk6Y24pYgaANhdqvu311+Bj8xsStpG6Cfq2gu4HZz+yrC63XNdn6EGYmqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044648; c=relaxed/simple;
	bh=7JvWI8PcTJ9tQGcuE9lY9w45IMM2KbwbpZa9VYX2h1Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PapXzrJ1znA16Rg5kX5K3CCzJe3j3euaGoq4S0QCIXWd4stPgOODKzE+5KftkhGCO7ulsIiE8dwhFI+H/1ncEJUGJm4+kubRBUWttl2S9Nw0a0knTXE9ph/DsB8oGb6tuAXBM/FhNild5KUcLAmlxIzqi/yLNNmyCDcImvUVldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HuYlQqGZ; arc=none smtp.client-ip=103.131.191.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HuYlQqGZ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea70fe9f;
	Tue, 22 Sep 2026 10:37:15 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/3] Small INTx fixes for Rockchip's dwc based PCIe controller driver
Date: Tue, 22 Sep 2026 10:36:59 +0800
Message-Id: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0c6f97de003a4kunm27853d20398d1f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUkeT1YeTUsZGB9KSk
	NJQx5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HuYlQqGZMGFos8uZejxq6IsbIXukqJmduMS1lF4/wK50bbFHO3ZrEAOTMhytKNm6RDoyehKlH7tDefhJX/ifQxqnvAZkAXjZ1aO+lgGEzkIbemmBDxZy8JEu8r20I/b5uS7rzqpbkM2HlakbRSF5VaqzyIEjjAHsCY+p1YaiKGY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=CoxwEvL89KhX1oKRDROsG9Ei4gYOQ+5iKIK5zHVnQww=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


This short series fixes the INTx handling around the newly introduced
.reset_root_port() (b376b3ff9cb0), and is split in three patches per
Niklas' suggestion:

Patch 1 stops .reset_root_port() from recreating the INTx irq domain
on every root port reset, which leaked the old domain and silently
broke INTx delivery afterwards, the downstream devices' virqs were
allocated in the previous domain and were never re-mapped. By moving
the of_irq_get_byname() lookup, the INTx irq domain creation and the
chained handler installation into rockchip_pcie_configure_rc(), right
after dw_pcie_host_init(). This leaves .init() with nothing but
idempotent register programming, so it can safely be re-run by
.reset_root_port() and dw_pcie_resume_noirq().

Patch 2 makes the irq domain and the chained handler devm-managed, so
that they are released with the device instead of leaking, which also
addresses the probe failure leak/use-after-free flagged by the Sashiko
review.

Patch 3 keeps the INTx IRQ masked while .reset_root_port() gates the
controller clocks, so the chained handler cannot read the unclocked
APB bus and raise a synchronous external abort.


Changes in v3:
- split devm-managed part into a seperate patch

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

Shawn Lin (3):
  PCI: dw-rockchip: Move the INTx irq setup to probe
  PCI: dw-rockchip: Make the INTx irq setup devm-managed
  PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are
    gated

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 77 ++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 20 deletions(-)

-- 
2.7.4

