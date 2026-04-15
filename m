Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4613A1CF3;
	Wed, 15 Apr 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237707; cv=none; b=ODNfqP4zouAKSphh4fRqphGUBZqQRdpXUPPL8hruC3ToIrcLRSZ21d/8aAK1D65XiOYTBEsYV9bDtCTx/R7U9Am82omdADZypXEz8Uq+2xiFCg4xmiJVs7letojTx8uih7nYwTCk5kPXhk02kMp+CohyuaDo6+CpKNCxYPBYU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237707; c=relaxed/simple;
	bh=+yU3R6rh+Ql6zbbv0IE0QQGMwTLjaRVc0KqvWKtQBjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U7aK1isoPoi6ssGa1bRvGJ2As4kFBtTiNC/dFxOGF1Yw1Wfs6THaGY4BePe7imoL8hEASoxP0ZOJ5vdE1TKQrE5j8Jd7iFhxKMfJkzLG2mEZ461NfXVV9/uImYHPaMirDplGDJ9qr65JQ2ROkQdrC/9eeP0YVTJZ6qajw6RLySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=IOpGdgYO; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="IOpGdgYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8j
	gwbAr6xfv3lB+PIrd2FeZsE14YhpxG4VSK+IhOkyo=; b=IOpGdgYOPNf/dgGWV0
	+OLkkpREVUYEqnw7kO2Eeo7dvZTGWAYFZSFpYtC3LqWa31/t/bojSNUj+xU8RZEV
	Pp8c+88mH35hrwBb3G1Y0xt5v0y2hEA4Q0a+rzP3Kg8m+HwVVu0+Z8cWWviQS1dW
	qh/1uTDVZ1XeF7/fdT268d0Gg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKdPN9poSgCAA--.1324S2;
	Wed, 15 Apr 2026 15:22:05 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH v3 0/3] riscv: Add PCIe support for UltraRISC DP1000 SoC
Date: Wed, 15 Apr 2026 15:21:16 +0800
Message-Id: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGw832kC/2XN0Q6CIBgF4FdxXEdDYChd9R6tC8Tf/FupA2U15
 7sHtmqzy7Od852ZeHAInhyymTgI6LHvYhC7jNjWdBegWMdMOOOKiZzR6TY649BbOlgEKrXUuiy
 UEFqTOBocNPhYwdP5nf1UXcGOSUmNFv3Yu+f6GPLU++Bqi4ecMgoN11JBDUqXx29hb/s7SQeB/
 wjJij+CR4Ibw02uTdFUYkssy/ICIri4OwUBAAA=
X-Change-ID: 20260310-ultrarisc-pcie-494998763399
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776237679; l=3476;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=+yU3R6rh+Ql6zbbv0IE0QQGMwTLjaRVc0KqvWKtQBjI=;
 b=gka5ORGZrQQrakysJZjF6f3qoc3FxgtmWrWzKZ+icX3Yt57eP91d/X201RjIzHLabq/Lu+0c6
 bmXfZoTXS6GCF3eRbAizwLTRi9KKRlvhkHYM8JgjMAMAyrp8EQ4Yzxm
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUKdPN9poSgCAA--.1324S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fuw4kKrWUJr1fZF17GFg_yoW5urykpa
	98uF4fAF97tr13WF4ft3W8WF1SvF4kArW2qFsFgwnrtF9xuFyUXr9aga1YvF9rArn5Xr12
	kr45uw1rGay7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKE_MDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAREWncaD0AMgAFsW

This patch series adds PCIe controller support for the UltraRISC DP1000 SoC.
The DP1000 is an 8-core 64-bit RISC-V SoC based on UltraRISC CP100 cores,
supporting RV64GCBHX ISA with Hardware Virtualization and RISC-V H(v1.0)
Extension.

The PCIe controller is based on Synopsys DesignWare PCIe IP.
This series adds:
- Patch 1 adds the basic SoC family Kconfig support for UltraRISC platforms.
- Patch 2 adds the device tree bindings documentation for the PCIe controller.
- Patch 3 introduces the PCIe host controller driver.

The patches have been tested on UltraRISC DP1000 development board with
various PCIe devices including NVMe SSDs and network cards, verifying
link establishment, enumeration, and basic data transfer.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v3:
- Fold the MAINTAINERS update into the binding/driver patches and drop
  the standalone MAINTAINERS patch from v2.
- Patch 1:
   * Trim DP1000-specific ISA/feature details from the help text.
- Patch 2:
   * Simplify the description formatting and remove the redundant.
   * Drop the max-link-speed property from the binding.
   * Remove the redundant interrupts description line.
   * Clean up the example.
- Patch 3:
   * Drop unused regmap include.
   * Drop the unused irq_mask[] field.
   * Set pci->max_link_speed = 4 based on the fixed hardware capability.
- Link to v2: https://patch.msgid.link/20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com

Changes in v2:
- Rebased onto v7.0-rc7.
- Patch 1:
   * Removed unnecessary 'depends' line.
   * Fixed help text indentation.
- Patch 2:
   * No changes.
- Patch 3:
   * Updated $ref to use 'snps,dw-pcie.yaml' as the base schema.
   * Add interrupts/interrupt-names (MSI + INTx).
   * Drop properties covered by generic DWC/PCI host bindings;
     update example accordingly.
   * Verified the schema passes 'make dt_binding_check' and 'yamllint'.
- Patch 4:
   * Update commit message.
   * Kconfig: switch PCIE_ULTRARISC to tristate; simplify help text.
   * Convert suspend/resume to dev_pm_ops and called
      `dw_pcie_suspend_noirq()` / `dw_pcie_resume_noirq()`.
   * Use FIELD_MODIFY(); adjust DWC header macros/comments.
   * Added empty `.pme_turn_off()` callback for DP1000 limitation.
   * Renamed link callback to `start_link`.
   * Switched to `module_platform_driver()`.
   * Formatting cleanups (headers order, spacing, variable naming,
     function names)
- Link to v1: https://patch.msgid.link/20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com

---
Jia Wang (2):
      riscv: add UltraRISC SoC family Kconfig support
      dt-bindings: PCI: Add UltraRISC DP1000 PCIe controller

Xincheng Zhang (1):
      PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver

 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        |  93 +++++++++++
 MAINTAINERS                                        |   8 +
 arch/riscv/Kconfig.socs                            |   6 +
 drivers/pci/controller/dwc/Kconfig                 |  12 ++
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-designware.h       |  22 +++
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 186 +++++++++++++++++++++
 7 files changed, 328 insertions(+)
---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260310-ultrarisc-pcie-494998763399

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>

