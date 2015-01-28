Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51087 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbbA1Uay (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 15:30:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Halasa <khalasa@piap.pl>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
Date: Wed, 28 Jan 2015 14:53:07 +0100
Message-ID: <2000255.rnmr9HfSOg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The recent patch to convert the cns3xxx PCI code added an
extraneous opening bracket, which makes the build fail,
so remove this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
---

Hi Bjorn,

The broken patch just showed up in linux-next. Please apply this one on top,
or fold it into the original patch if you don't mind rebasing.

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index e41fc339d100..c622c306c390 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -101,7 +101,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		 * for a PCIe bridge. So we must fixup the class code
 		 * to 0x604 here.
 		 */
-		*val = (((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
+		*val = ((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
 
 	return ret;
 }

