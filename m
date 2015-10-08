Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:46477 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbJHHYf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 03:24:35 -0400
From: Pavel Fedin <p.fedin@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>
Subject: [PATCH v2 1/2] PCI: of: Add 64-bit address recognition without LPAE
 support
Date: Thu, 08 Oct 2015 10:24:25 +0300
Message-id: <858110a5c4fb0b2094417cc8429560bdaae81c66.1444288748.git.p.fedin@samsung.com>
In-reply-to: <cover.1444288748.git.p.fedin@samsung.com>
References: <cover.1444288748.git.p.fedin@samsung.com>
In-reply-to: <cover.1444288748.git.p.fedin@samsung.com>
References: <cover.1444288748.git.p.fedin@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If non-LPAE kernel is booted up on a machine with 64-bit PCI resources,
PCI controller probe fails with:

PCI host bridge /pcie@10000000 ranges:
   IO 0x3eff0000..0x3effffff -> 0x00000000
  MEM 0x10000000..0x3efeffff -> 0x10000000
  MEM 0x8000000000..0xffffffffff -> 0x8000000000
pci-host-generic 3f000000.pcie: resource collision: [mem 0x00000000-0xffffffff] conflicts with /pl011@9000000 [mem 0x09000000-0x09000fff]
pci-host-generic: probe of 3f000000.pcie failed with error -16

This happens because res->start assignment in of_pci_range_to_resource()
truncates the upper part of the address, because res->start is of
phys_addr_t type, which is 32-bit on non-LPAE kernels.

This patch adds explicit recognition of 64-bit resources, preventing from
potential problems when e. g. 0x8000001234 would be converted to
0x00001234.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 drivers/of/address.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 384574c..cd53fe4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -330,6 +330,12 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 		}
 		res->start = port;
 	} else {
+		if ((sizeof(resource_size_t) < 8) &&
+		    upper_32_bits(range->cpu_addr)) {
+			err = -EINVAL;
+			goto invalid_range;
+		}
+
 		res->start = range->cpu_addr;
 	}
 	res->end = res->start + range->size - 1;
-- 
2.4.4

