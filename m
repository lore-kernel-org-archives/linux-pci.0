Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:61103 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbaE0Wl0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 18:41:26 -0400
Date: Tue, 27 May 2014 23:40:51 +0100
From: Will Deacon <will.deacon@arm.com>
To: bhelgaas@google.com, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	jgunthorpe@obsidianresearch.com
Subject: [GIT PULL] Generic PCI host controller driver for 3.16
Message-ID: <20140527224051.GA13786@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Please can you pull my generic PCI host controller driver for 3.16?

It's been doing the rounds on the lists for some time and things have
settled down now, despite a recent failed attempt at factoring out the
configuration space accessors.

Cheers,

Will

--->8

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-bjorn/pci-host-generic

for you to fetch changes up to 97725ee5aef64b2056c10eabafc92ff89994733d:

  MAINTAINERS: add entry for generic PCI host controller driver (2014-05-27 23:18:09 +0100)

----------------------------------------------------------------
Will Deacon (2):
      PCI: ARM: add support for generic PCI host controller
      MAINTAINERS: add entry for generic PCI host controller driver

 .../devicetree/bindings/pci/host-generic-pci.txt   | 100 ++++++
 MAINTAINERS                                        |   8 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 388 +++++++++++++++++++++
 5 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c
