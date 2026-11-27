Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754128;
	b=QwqtUxQS7gXzIQ8ol7jLXjVduGvp4RvCVB9c5gtswmE35Un9Q+Or/Pv90TeRcO/5VX4P
	 bYJAPof+x52m5VH6+qUCfx/b5OfndkKy3MIMy0lDQDT6UXeEMfsj4foWLBTX1Ew5RtPud
	 OoQHxTzcjwUBp9sDiy+H/iLQfIMOL4D6q8N2JB+rq4jjOMrDS0yy7EtAfGjdv41Ufl+5U
	 d0Ot1fr2ZXK/pnZW+5RjT3wRHlApeoCMytsADk2brMv+JivVGZ4tlayAPC37SPzA57ngr
	 pSnuQiTHNbsxDcelktBkm6UFlnQ3axvLOj3DLwCs5fXtth3Hk/ohcRzYG7yvPoociwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754128;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hHtgopsb3fljBvzY7IyNpMyX1Poa7FPvU5X9UOWmnEE=;
	b=L81kl6R4jyU7JqQeMiJ2jx/smyHE+3irAR3VC1tsmbBQElBKipK9BEC2d2HUXMeGCdbW
	 18FG5bqOis+AzslvYJolUKjm2Ze62GEse4yuVDcOT5fxIeCsaJYf9GBjN2JEWqn/x/qfY
	 W730Dx8d8g5W2YwwikV3lmKUXuOhZ0gN89sEjIgA7A8lUSjfUk6hbsFRgv/XXYa0i0TCY
	 frJLu8wvpVFIUjO2TyxLeq2h3sgTxOYpOdj4P65jACbhaLHiuH2A2kld48sBDFTdY6jcN
	 tVUYLINFVPz1w6J1SgepR/zi84fcaosYs8yeizqYQHsqT+16J85ChjuRG5pHnE1rKDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOhD5SPW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A243606A326;
	Fri, 27 Nov 2026 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOhD5SPW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754128;
	b=rHMgt5hXmfHVRZu1qe2YMyWUKVX4gdLp6d5b/FAwFoj+ns/z+9L+fuSaA1oE8KM2DBwg
	 zV4rf3mY2WBenU1WxkNdoktLWS9b8CrtJx9NIyNY+8Y5uJLMBlm+pin1PCA3a1oMWOGY8
	 nsy7CNnkOA/aBzXzNdiy1D1sduJ3ab5wGwZosa3vLtVJS+2H7Q8oRu4RA5+8G17ZDXOJO
	 OHgeayO/dCaTuUuYGQcaEM+aN570KY2e6xX91YELtlvCoOeMZYIr9jwY8+7YIFK2NSTKA
	 oeQBapMEsY3f0jG6YNMYDx3/lnrmZZXbLZPOjbrEUNwOYxS1NUaRrUGZxeKxT2mIO5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754128;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hHtgopsb3fljBvzY7IyNpMyX1Poa7FPvU5X9UOWmnEE=;
	b=pFKXhFqmAjAKmx5TybPR4x+8nw33Ug4UTcdefJuwrljd53eUjTed/Lj1f/PxjXXdw1Af
	 S7tw8kJ6681AXwHHb4SwJYRZaPhaHIGz2Gkz4mI3pNDiI3cd2ObWlyULvGrRnp/n50vLI
	 T4LVrOBBl/bjbpD5iYok6CiL8IrPGpKFtSw37dAS+4mh9c96kOgsIIX2Bd3BsHhjb1Ux7
	 VsX65ruoXkYlgnIm2gg7bsam+GbEkuGwvSGw6HVvPM/O04hBmJoXRlB9fDIpaUnIxbsPl
	 vVxnEPZA3i01UBICwN4WHQH7LgmWTMVA3l6VxfL5qrsLwK6av+hZVVmFw/JRk7wipuQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB9D51F00897;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754128;
	bh=hHtgopsb3fljBvzY7IyNpMyX1Poa7FPvU5X9UOWmnEE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZOhD5SPWpErnKxKjiLl6ENp1Vcx99DRnDDebSciO0nvN9jZsF/jTheb1nTN6cX03t
	 mrtXc6o3aM06jYzBYaQRxfJWc8Sa3SNuOg8xzN1f4JWFyCUWpZLzerjCeO1yNwxM9V
	 +JPtxdVmjywQgDcGxFwX6na0MAE8uTYP8OzKwFE3QLD2ZTk2HaC1kHRr2KW1SYeF47
	 iY4SeDW1yG5wQzSjirlWXDf2MCsCHeOYhsloW43yKcfJyv97ZRGaar0bEXLOGJtNLf
	 EZMzPIMDHpD+j36fq1cv1Dcm+6oc/32/crC8eDMxjSg3cpM5jIIilt0Q9Yq6XiHD8E
	 sM7yNtyTmTHmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 359164B56A;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v3 0/6] PCI: cortina: Add CS7542 PCIe host and PHY support
Date: Fri, 27 Nov 2026 07:35:18 +0300
Message-Id: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PQW7DIBBFr2KxLpUZwAaveo8qCxiGhKq2E+NYi
 SLfvcSJqmza5Zf++/PmxjJNiTLrqhubaEk5jUMJ8q1ieHDDnngKJTOooRECJPeKY261An7ERBx
 AkdQWTWMNK9Bxopgu2+Dn7pHz2X8RzveVZ2Oi07lcmh815l0mjmPfp7mrfONsdFIhKWFa9I0NE
 rUxTnkfI0qBpIM3kb0adtWv31MuXzOOA4dWBq00ti5Ctyh2VzqkPI/TdXt5EZvBX98tgtdcYSA
 NtQiqVh/73qXv9yK7TS3wPw4Fj9pYZzHUnuIrvq7rD33C+JB+AQAA
X-Change-ID: 20261123-b4-cs7542-pcie-224e359c8698
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=6590;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=He1ygiNhn7MuHnxW34XgN+E9O0v4Q9fVoe3AiJDzQXE=;
 b=22W0Np/U1X6ZDmEhM0+PZPEuqLYYVK5u4JM70zQIU41+UKnLxLycjNOf9hEMorqC2tDIwwUcQ
 yt57bMiTG5FARb5lz6srAoimHiwce6pjLL7lWcnyBf/+f+3vQDBXCif
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

Add a Snow Bush PCIe SerDes PHY and DesignWare host glue for CS7542.
The combined global-controls prerequisite supplies PCIe gates and resets;
this series contains no separate or duplicate global-control driver.

Prerequisite on Linux v7.4-rc4: the combined clock/reset/pinctrl v4,
posted on 25 November:
https://lore.kernel.org/all/20261125-cs7542-syscon-v4-0-3337bb0d3b48@gmail.com/
Brian's review places the early clock and separately probing reset
providers in that prerequisite. Local v5 error-path corrections are
included in the current integration tests; they keep its PCIe clock/reset
IDs and consumer interface unchanged. Binding review remains ongoing.
Board DTS enablement is separate. Ethernet is not a prerequisite.

The host protects its 512-byte root configuration limit, owns the
combined INTx/MSI lifecycle and reads link status from the application
wrapper. Unused SATA mode, hotplug and suspend remain outside this support.

Before the reset timing change, an Almond+ Linux v7.4-rc4 RAM run passed with
all three Root Ports/endpoints and Root Port MSI enabled after enumeration.
xHCI serviced MSI-X interrupts with three vectors, then forced legacy INTx
with no MSI vectors, then restored MSI-X. Complete host unload/reload,
repeated enumeration, real PCI OF nodes and factory calibration/MAC NVMEM
lookups all passed. Two NE load/unload cycles and external LAN1 traffic
ran alongside the live PCIe hosts without changing their reset bits.
The watchdog automatically returned to the installed firmware; no flash
writes were performed.

The updated host compiled for ARM with reset-controller support enabled
and disabled. Its framework-disabled object has no unresolved reset
symbols. The current reset sequence also passed the error-path tests.

Earlier independent ARM GCC14.2 W=1 vmlinux/modules with PHY/host=m and
COMPILE_TEST=n, full combined multi_v7 built-in/module builds, binding
examples and actual-source config/DBI/probe/Root-Port/MSI tests passed.
Two expected reset-core WARN/-EBUSY traces came from the fixture's
intentional duplicate-exclusive NE reset requests, not PCIe operations.
The fixture did not reset an active NE DMA consumer.

The lock serializes MMIO against the IRQ latch and teardown; it cannot
eliminate a physical link transition before IRQ delivery. Link-loss gating
remains conservative no-retrain policy, not a newly established silicon
requirement for upstream RC configuration. Non-identity MSI bus-window
arithmetic has host-test coverage; the hardware run used this board's
existing windows and unchanged comparator tokens.

Final self-review also exercised the actual MSI/GPIO policy helpers in
12 GCC and Clang ASan/UBSan cases each. The independent ARM build of
vmlinux and modules with host/PHY=m, COMPILE_TEST=n and no platform series
passed again after those fixes. Exact Linux 6.18 ARM W=1 Werror objects
and the combined personal image build pass. An actual normal-image RAM
boot enumerated the three Root Ports and endpoints and reached its root
filesystem with 432844 KiB available to Linux, then the watchdog returned
automatically to unchanged NAND OpenWrt. This boot is not hardware fault
injection or a new non-identity DMA-window test. The two Wi-Fi Root Ports
share one physical PERST# GPIO; independent hotplug is not qualified.

Changes in v3:
- Hold the host reset through PHY preparation. Wait 10 ms before
  deasserting it and 10 ms afterwards before accessing the host.
- Drop the PCIe consumer's Kconfig select of RESET_CONTROLLER.
- Balance the PHY reference clock if power-on and its cleanup both fail.
- Put PERST# on the Root Port child; retain three independent hosts and
  acquire the board's shared Wi-Fi reset GPIO only once.
- Assert the core before clock/PHY setup and release endpoint PERST#
  after Root Port setup, using the standard reset configuration wait.
- Describe MSI addresses as internal PCI bus match tokens, preserve their
  tested values and reject overlap with translated PCI memory windows.
- Keep v2 config/DBI/IRQ serialization; describe the no-retrain latch as
  conservative software policy, with no physical link-loss race claim.
- Preserve pci=nomsi in post-enumeration setup; an uninitialized receiver
  must not be enabled. Skip the optional PERST# lookup when the Root Port
  has no reset-gpios, including builds with GPIOLIB disabled.
- Address Kconfig/include ordering, bounded polling constants, error
  response helper, block comments, formatting and cleanup labels.
- Move the global binding, clock gates and reset provider into the
  independent shared-controls prerequisite; drop former patches 2 and 3.
- Keep only DWC export, PHY, host and their ownership in this series.
- Preserve existing PCIe reset IDs 0..2 and clock IDs 3..5.
- Link to v2: https://patch.msgid.link/20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com

---
Fil Dunsky (6):
      PCI: dwc: Export the multiplexed MSI interrupt handler
      dt-bindings: phy: Describe CS7542 PCIe SerDes
      phy: Add CS7542 PCIe SerDes support
      dt-bindings: PCI: Describe the CS7542 host controller
      PCI: cs7542: Add CS7542 PCIe host support
      MAINTAINERS: Add CS7542 PCIe support

 .../bindings/pci/cortina,cs7542-pcie.yaml          | 157 +++++
 .../bindings/phy/cortina,cs7542-pcie-phy.yaml      |  67 +++
 MAINTAINERS                                        |   6 +-
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-cs7542.c           | 658 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c  |   1 +
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-cs7542-pcie.c                      | 236 ++++++++
 10 files changed, 1150 insertions(+), 1 deletion(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-cs7542-pcie-224e359c8698
prerequisite-change-id: 20261123-cs7542-syscon-273d545c7af2:v4
prerequisite-patch-id: a9208276c628f8741a807d0e5c5945d4bf211c8a
prerequisite-patch-id: 65d46bb3caaa8518ee561f65d3f603ade396fff9
prerequisite-patch-id: a0ed5fbcfa308b16eaf265371a6697ad0aea6802
prerequisite-patch-id: bb8ffd99cb30e5a0b47881f6ba19a36329d5f4f2
prerequisite-patch-id: 7fbe9405265ef3d1ec62811415a46c0061afd7c8
prerequisite-patch-id: 01ece2c91e080d5cae6af81944159373776484ca

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


