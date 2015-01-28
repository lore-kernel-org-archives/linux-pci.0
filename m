Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:50666 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761581AbbA2D3M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 22:29:12 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so22799983oig.9
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 19:29:12 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] Versatile PCI host DT support
Date: Wed, 28 Jan 2015 10:16:15 -0600
Message-Id: <1422461778-6769-1-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm not going to get the rest of the Versatile series wrapped up for
3.20, but I think the PCI support is ready and would like to get it in.

I have not fixed the resource registration for /proc/iomem and irq
fixup as those issues are being worked on for a common fix.

Bjorn, Can you please take the whole series unless you prefer arm-soc
to.

v2:
- Added MAINTAINERS entry
- Based on generic PCI config accessors
- Module license fix
- Comment whitespace fix

Rob

Rob Herring (3):
  dt/bindings: add versatile PCI binding
  dts: versatile: add PCI controller binding
  PCI: add DT based ARM Versatile PCI host driver

 .../devicetree/bindings/pci/versatile.txt          |  59 +++++
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/versatile-pb.dts                 |  37 ++++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-versatile.c                   | 237 +++++++++++++++++++++
 6 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 create mode 100644 drivers/pci/host/pci-versatile.c

-- 
2.1.0

