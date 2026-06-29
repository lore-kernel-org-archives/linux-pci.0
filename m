Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F0280CD2;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712803; cv=none; b=BhnCxpB4BCDgUTZyeeu0zWWlTB791kwpEnCqCPmrTFSwD2mJASZAdRvYsiMi2Ps3aHS4cPzH8Zheo6LJPKjFbzxqfsnPKbXrJAZgDZuKvNXvJQF8A/3oGsS6R0VJOaNqu+39q7ql04M8gTRe3BxxxWr2clAXE9MjhrG1w5VJuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712803; c=relaxed/simple;
	bh=I2rovNTFCnQGV7yVPJLdnI5nWXDV0HPkDuEeWfEqjY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=phqimSv3g46mJfIocZU7ahfWkDw42iSgokk0rOlkPTXfCpu4Rl2s+EU4U3A9LBlDKjFF22P5eYuomPex4zexaGihoNxPaGVOENmWgKd/dxQUD/u1WvVrR0yDhgxp02xTa2mmVFMyPfTJD3C8OQEEJJrZC/IbHvNwSP3BvJKlWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDPgXBAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDPgXBAn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C35C19425;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782712803;
	bh=I2rovNTFCnQGV7yVPJLdnI5nWXDV0HPkDuEeWfEqjY8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JDPgXBAnkdIbPCLc7Cg8aCUtxiEDtaYiJjpmPJudar/wb0xdIxQuTpWdXXbC9BalK
	 fXr9jOZQZIrRMFhEc/9g6UkSwDDa1PfJrV4mOhku+DlH+HnTj3GZTVyuhpKH3A9OuC
	 dTXjXukouJ/iVycAv1paY5ANnpJJziuoAbO4O3djGG3bp6+x8EJK7eVaxsWbH9Lxsn
	 SVfwmSoHvzdf7GG/ij9gm/2Tr/LNvKLz2Qu9ifFxrjIzd7YTQCZfoERbD8HecnSfjG
	 /loU8xY3DktYxaX6QidnYpf+fRSfjW5fxmKJelbwRrg+I69LH5H1raxuxWxEVu/Lva
	 9OQBnA1muTsQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B56C43458;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Subject: [PATCH 0/2] PCI: ultrarisc: Add DP1000 PCIe clock support
Date: Mon, 29 Jun 2026 13:59:49 +0800
Message-Id: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUJQmoC/yXMQQqDQAxA0atI1gZmpCj1KuIiprFNKyqJUwri3
 Tu2y7f4fwcXU3Foix1M3uq6zBmxLIAfNN8F9ZYNVajqUMcG07QZmTrjyoo8vZA4XsOloTEKQe5
 Wk1E/v2fX/+1peApv5wiO4wsWHP8VdQAAAA==
X-Change-ID: 20260617-ultrarisc-pci-clk-ac19047af1ea
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782712801; l=1358;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=I2rovNTFCnQGV7yVPJLdnI5nWXDV0HPkDuEeWfEqjY8=;
 b=eKf6kc1lr6911TENYLvqSzu6t+q65lQ4mXFQ+QSVohXQFtfJeRcTkYl6Mx2tCoCG4f064Atm0
 9dcuTnh39eoDLh3gbxQbQMDl+aSkKk7TYe46OsMybDrdvtZa/snonFV
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

Add clock handling for the UltraRISC DP1000 DesignWare PCIe host
controller.

The DP1000 PCIe controller depends on three input clocks: core, dbi, and
aux. The driver accesses DBI registers during host initialization, so the
clocks must be enabled before the controller registers are touched.

This series documents the required clocks in the device tree binding and
updates the driver to get and enable them during probe. The driver keeps
the clock data alongside struct dw_pcie, uses the bulk clock API to
acquire and enable the clocks, and registers a managed cleanup action to
disable them on failure or detach.

Testing:
- Build and module build tested with ARCH=riscv.
- Boot tested on UltraRISC DP1000.
- Validated the PCIe binding with dt_binding_check and dtbs_check.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Jia Wang (2):
      dt-bindings: pci: ultrarisc: add required DP1000 PCIe clocks
      PCI: ultrarisc: get and enable DP1000 PCIe clocks

 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 16 +++++
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 74 ++++++++++++++++++++--
 2 files changed, 83 insertions(+), 7 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260617-ultrarisc-pci-clk-ac19047af1ea

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>


