Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:9903 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbJGKtz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 06:49:55 -0400
From: Pavel Fedin <p.fedin@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] PCI: of: Fix handling 64-bit PCI resources on non-LPAE
 kernels
Date: Wed, 07 Oct 2015 13:49:19 +0300
Message-id: <cover.1444214119.git.p.fedin@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The initial aim of this series is to fix long-standing problem with generic
PCI host controller, triggered by ARM "virt" machine in the recent qemu.
Since v2.4.50 qemu adds support for the second, large PCI MMIO window,
which resides in 64-bit address space. This series addresses problems,
which are triggered on non-LPAE kernels by this configuration.

These patches do not depend on each other and can be applied individually.
The first adds missing recognition of 64-bit resources (which is actually
a bug). The second one changes the code to ignore unaccessible resources
instead of completely bailing out. Since it touches generic of_pci code,
the fix is expected to be applied to all drivers which use
of_pci_get_host_bridge_resources().

Pavel Fedin (2):
  PCI: of: Add 64-bit address recognition without LPAE support
  PCI: of: Ignore resources with failed translation

 drivers/of/address.c | 6 ++++++
 drivers/of/of_pci.c  | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.4.4
