Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465961;
	b=w+9iEoMgmhvp0b5PJzbDst8kMlbAa4OLosfRLQRMYlveEy4zzkNKS7IPo7aLGDytXlB9
	 zmvNRDG0449aItWhacPCa6qlwjUgrzLyWEB7KM2+YUFbIz3OaeKmV6FMkYg4l7MZvCdWP
	 neI/LbShTSvemyjrzjpK3SuCGrUyPmHFJorM5guw0xIsi1187haYFPYEq3IG1yKTYyDeQ
	 NSQvqvqD/sqwFsMssNqswnctxDVHZcm1EPDkvE1yTywRhARTo0hno8OXXv9j0jDSwUIeL
	 z3ifu3pcK8zEsCafU/kcpFvtLq3UUpK2OkdwEnfmadOdgI0eD8Mk19c/VFFZ64LlghA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465961;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9r3Pre0r4NItXk0EkmkIa/89K2E/lW0nEW1wW9AtDoE=;
	b=MttLJmRqjToTTq1Rao3Ed4aom9Rrc8jn+p30WEw54EA7vSn8sWsIUat+xEDuxPxaQypx
	 H1T3zTe/F39AKQyiD/avEa6ZYTIfqAhnPVC0OH4qc1mgI7SZvdSQcY2P1hFbB7t/z5srx
	 WPWfzU/7Jjhrmt5EbYiwq2YPoZtTXP2TRTVmxVmo+XFcbQftPmADGI78XtwbwSL7rp0yC
	 ESXCr3SalIJiy9vTjMe+VjI8ioNTPszIU6VYjHWVdU4dwPayXykDDz6BvYcQDazbs9dQO
	 dH8MKJ0A4bT++/z5CK6Lt9pN15IWv0AuBRjd8d0DEnCrxuswB1sB1K2wDn5a4Zn3f9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6DV9Eo4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A4606A691;
	Mon, 23 Nov 2026 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6DV9Eo4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465960;
	b=Bvgoipplmy6fHs134UIKd7PviolEA8gTTthn3spTpWWUO1HCbHnfaluhjyiVf3MdxY5x
	 3VQJgKKhM5HtbbmNkck/Xl8DY3014DxC3Xrx/IPZDHFfjuWzXRGX3cKyswtW9ziz+FcmM
	 FOQayMrIJvUDpG+egvUr5jbEEbd5p7d4nKaWR1Mz9PCZj1DLKzmbsuW55geQqIxNsKcWG
	 EGVvUIOGQUDCFkR8CrkJL1mr2ppOVxoR6aIeSxm/k9OCnu3vCouvgby2yGhZ24LPuFraS
	 TevwmB5zh8xKKjeGz4QCQwlfj0d5C9J4CdN/OHW7TSpXMuAwK90OSqivn7tQEbSdhkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465960;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9r3Pre0r4NItXk0EkmkIa/89K2E/lW0nEW1wW9AtDoE=;
	b=2tnZXJlD+yBf3KMSkMOs88VyQcI9W4JOp/1x2aRQkXz/JG//PCRGP8XZCfeIqzPFSbYl
	 TBhUD1PpPBZHsDxq5pqb5AdoEfNYcdJBRBj0Z0ZtQaQ3j9MJagHVDGdhTYT5bbvIlhUET
	 TJOOjU+t46W72if3agZc8YSfHi+oigotjwE7nluuHQ2HYzPO8rAOomGtZwghT1zPm0gzR
	 wpDlEYSizM1zb6pxe3lnMWRnEo3cIizAIU/FVXV3AgQhfHNKZj10Oqb0tT8uwPfSk4XY4
	 6I4ltjKs93hyMqWOJtxeJy/7mJHpHnizUlPQuDUdNQxCIfvVyQQHi/E0IgIsMHcqn/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC8A91F000D2;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465960;
	bh=9r3Pre0r4NItXk0EkmkIa/89K2E/lW0nEW1wW9AtDoE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=g6DV9Eo4aL8d1WcuLCWX2DfrNUowmhw4eP+/MBJ4Dme2B2qrNC2Xfprd804iBUs2M
	 VQGasSGjPQMCPr77El5+K5okDIReh24SjYGmTk8uthc3Ni4RIGXleUAs0lHBGjx/Rj
	 nE95+nYyG0a+OA9sYAkeBkcvCzZmEv6xkN8K6Eua7Mc2vs8q0c9evoD1OZz/HCjQTJ
	 VQ8ObagBId55ynynPnKQ1xxhxMJ0tLe83IcyIjOWHHNnFCyOURrdVxKQLUtIC1RwM/
	 TIFWloUPOwbbzMpAj76SEeIkB3pwYJPsyJsf9Vf4ZplUXbooWdrqYv5WI8PofQ8FiV
	 jkZcFwID9HrRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A8834C6E9;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v2 0/8] soc: cortina: Add CS7542 PCIe control, SerDes and
 host support
Date: Mon, 23 Nov 2026 23:32:14 +0300
Message-Id: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPQW6DMBBFr4K8ris82GCy6j2qLuzxOHFVIPEQ1
 Cji7jUklbrp8kt/3n9zF0w5EYtDdReZlsRpGkuAl0rgyY1HkimULKCGVilopNcSuTMa5BkTSQB
 NjenRtr0V5eicKabvHfj+8ch89Z+E80Z5NjJdrmVpftSEd0wSp2FI86HyreujazSSVrZD3/ahQ
 WOt097HiI1CMsHbuKEGYna7YjH+FXza8Y1xGuUCspYKQ6c9GIDYvx0Hl75ey5zY/E6J5ynf9v8
 Xtev89+qiCkpjIAO1CrrWf1Hruv4AIYoFQEwBAAA=
X-Change-ID: 20261123-b4-cs7542-pcie-224e359c8698
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=5529;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=R3MajGKj6VJAQnzG5H4txrr1+B19HSrtNKMUWSyBtcQ=;
 b=kM2sUfrYHm8idroYzoX+8G2g8KmPVRJD2fBFdfZ/MqMeeqLwVrZi3bQ5hlRnLtTAgNgsSWxAA
 vCcYz5D+N82ApsCDSaf+bEe7ANJX51Ca3/9MWIHCNrx3HQrJQmoZrkU
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

Add CS7542 PCIe support with global gate/reset controls, a Snow Bush
SerDes PHY and DesignWare host glue. The global syscon already provides
the APB/CPU/AXI clocks; extend that same provider with three PCIe gates
and controller resets. No resource-less pcie-control child is created.
The existing clock indices remain unchanged; PCIe gets named specifiers.

This series depends on the posted global clock/pinctrl v2:
https://lore.kernel.org/all/20261123-cs7542-syscon-v2-0-1cd74b2522f9@gmail.com/
The complete prerequisite and this series apply to Linux v7.4-rc4.
Board DTS changes are prepared separately.

The host protects its 512-byte root configuration limit, owns the
combined INTx/MSI interrupt lifecycle and reads link status from the
application wrapper. Unused SATA mode, hotplug and suspend are outside
this initial support. Gate source rates are not assumed.

Validation of v2:
- Full independent ARM GCC14.2 vmlinux/modules builds with PHY/host=y
  and=m, COMPILE_TEST=n and no Cortina platform series. The early global
  provider is built in because the APB timer clock must be available early.
- Updated schemas/examples and strict global-driver checkpatch pass.
- Actual parent-provider source: 461 cases and 23309 assertions under
  ASan/UBSan, including all strap modes, six clock outputs, unrelated
  bits and every allocation/registration failure path.
- Combined ARM multi_v7 vmlinux/modules and board DT build pass.

The revised parent provider and PCIe host booted Linux 7.4 on Almond+
in RAM. Enumeration, all 3 root ports' post-enumeration MSI enable bits,
MSI-X/INTx xHCI completions and host unload/reload passed. The INTx
mapping count returned to its pre-probe baseline after unload. Final
result: failures=0, followed by automatic return to installed OpenWrt.
No flash writes were performed. Actual config/DBI tests cover 49298
cases, including zero hardware accesses after link loss; lifecycle tests
check locked masking, IRQ draining and sparse mapping disposal.

---
Changes in v2:
- Expose PCIe gates/resets on the existing global syscon provider.
- Remove the virtual child binding and separate gate/reset driver.
- Preserve early strap clocks and unwind partial registration failures.
- Put clocks before interrupts in the host binding and example.
- Enable root-port MSI after enumeration; dispose INTx mappings on teardown.
- Return 0 for lost-link DBI reads to fail iATU polling; serialize quiesce,
  config/DBI access and IRQ draining before reset.
- Link to v1: https://patch.msgid.link/20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com

To: Jingoo Han <jingoohan1@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney+clk@redhat.com>
To: Jerome Brunet <jbrunet+clk@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-phy@lists.infradead.org

---
Fil Dunsky (8):
      PCI: dwc: Export the multiplexed MSI interrupt handler
      dt-bindings: soc: Describe CS7542 PCIe clocks and resets
      clk: cs7542: Add PCIe gates and resets to the global provider
      dt-bindings: phy: Describe CS7542 PCIe SerDes
      phy: Add CS7542 PCIe SerDes support
      dt-bindings: PCI: Describe the CS7542 host controller
      PCI: cs7542: Add CS7542 PCIe host support
      MAINTAINERS: Add CS7542 PCIe support

 .../bindings/pci/cortina,cs7542-pcie.yaml          | 129 +++++
 .../bindings/phy/cortina,cs7542-pcie-phy.yaml      |  67 +++
 .../soc/cortina/cortina,cs7542-syscon.yaml         |  10 +-
 MAINTAINERS                                        |   7 +-
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-cs7542.c                           | 183 ++++++-
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   2 +
 drivers/pci/controller/dwc/pcie-cs7542.c           | 551 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c  |   1 +
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-cs7542-pcie.c                      | 232 +++++++++
 include/dt-bindings/clock/cortina,cs7542-clock.h   |   4 +
 include/dt-bindings/reset/cortina,cs7542-reset.h   |   9 +
 15 files changed, 1200 insertions(+), 26 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-cs7542-pcie-224e359c8698
prerequisite-message-id: 20261123-cs7542-syscon-v2-0-1cd74b2522f9@gmail.com
prerequisite-patch-id: 4b568d742095f1a61312c911d2b6e81c8e754312
prerequisite-patch-id: a4bba26a3aac57e4e4229a727fdf94677373493a
prerequisite-patch-id: f8a2ba71717f71ca2bedda986f8b861995cdc586
prerequisite-patch-id: 7fbe9405265ef3d1ec62811415a46c0061afd7c8
prerequisite-patch-id: 25220835f5d2506a01ba652d86f9b9ac3ad5121a

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


