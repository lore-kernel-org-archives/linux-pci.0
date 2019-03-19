Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F633C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CDA20854
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 15:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfCSPsK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbfCSPsK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 11:48:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD537ACE1;
        Tue, 19 Mar 2019 15:48:08 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Date:   Tue, 19 Mar 2019 16:47:49 +0100
Message-Id: <20190319154755.31049-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
architecture and share some hardware (ioc3/bridge). To share
the software parts this patchset reworks SGI IP27 interrupt
and pci bridge code. By using features Linux gained during the
many years since SGI IP27 code was integrated this even results
in code reduction and IMHO cleaner code.

Tests have been done on a two module O200 (4 CPUs) and an
Origin 2000 (8 CPUs).

My next step in integrating SGI IP30 support is splitting ioc3eth
into a MFD and subdevice drivers, which will be submitted soon.

Changes in v3:

- dropped patches accepted by Paul
- moved IP27 specific __phys_to_dma/__dma_to_phys into its own file
- moved pcibios_to_node into IP27 specific file
- moved PCI bus address resources setup out of pci-xtalk code into
  IP27 specific code
- dropped bit from hub_irq_data and use hwirq from irq_data
- introduced intr_addr for setting up bridge interrupts (IP30 preperation)

Changes in v2:

- replaced HUB_L/HUB_S by __raw_readq/__raw_writeq
- removed union bridge_ate
- replaced remaing fields in slice_data by per_cpu data
- use generic_handle_irq instead of do_IRQ
- use hierarchy irq domain for stacking bridge and hub interrupt
- moved __dma_to_phys/__phy_to_dma to mach-ip27/dma-direct.h
- use dev_to_node() for pcibus_to_node() implementation

Thomas Bogendoerfer (3):
  MIPS: SGI-IP27: move IP27 specific code out of pci-ip27.c into new
    file
  MIPS: SGI-IP27: use generic PCI driver
  MIPS: SGI-IP27: abstract chipset irq from bridge

 arch/mips/Kconfig                          |   3 +
 arch/mips/include/asm/mach-ip27/topology.h |  11 +-
 arch/mips/include/asm/pci/bridge.h         |  14 +-
 arch/mips/include/asm/sn/irq_alloc.h       |  11 +
 arch/mips/include/asm/xtalk/xtalk.h        |   9 -
 arch/mips/pci/Makefile                     |   1 -
 arch/mips/pci/ops-bridge.c                 | 302 --------------
 arch/mips/pci/pci-ip27.c                   | 214 ----------
 arch/mips/sgi-ip27/Makefile                |   4 +-
 arch/mips/sgi-ip27/ip27-init.c             |   2 +
 arch/mips/sgi-ip27/ip27-irq.c              | 191 ++++-----
 arch/mips/sgi-ip27/ip27-pci.c              |  30 ++
 arch/mips/sgi-ip27/ip27-xtalk.c            |  61 ++-
 drivers/pci/controller/Kconfig             |   3 +
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pci-xtalk-bridge.c  | 610 +++++++++++++++++++++++++++++
 include/linux/platform_data/xtalk-bridge.h |  22 ++
 17 files changed, 822 insertions(+), 667 deletions(-)
 create mode 100644 arch/mips/include/asm/sn/irq_alloc.h
 delete mode 100644 arch/mips/pci/ops-bridge.c
 delete mode 100644 arch/mips/pci/pci-ip27.c
 create mode 100644 arch/mips/sgi-ip27/ip27-pci.c
 create mode 100644 drivers/pci/controller/pci-xtalk-bridge.c
 create mode 100644 include/linux/platform_data/xtalk-bridge.h

-- 
2.13.7

