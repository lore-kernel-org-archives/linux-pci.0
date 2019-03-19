Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D2CC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98ED20854
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 15:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfCSPsW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:48:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727824AbfCSPsT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 11:48:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5EBCB127;
        Tue, 19 Mar 2019 15:48:16 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Date:   Tue, 19 Mar 2019 16:47:53 +0100
Message-Id: <20190319154755.31049-5-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190319154755.31049-1-tbogendoerfer@suse.de>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
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

Thomas Bogendoerfer (10):
  MIPS: SGI-IP27: get rid of volatile and hubreg_t
  MIPS: SGI-IP27: clean up bridge access and header files
  MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont to fix output
  MIPS: SGI-IP27: do xtalk scanning later
  MIPS: SGI-IP27: do boot CPU init later
  MIPS: SGI-IP27: rework HUB interrupts
  PCI: call add_bus method also for root bus
  MIPS: SGI-IP27: use generic PCI driver
  genirq/irqdomain: fall back to default domain when creating hierarchy
    domain
  MIPS: SGI-IP27: abstract chipset irq from bridge

 arch/mips/Kconfig                               |   4 +
 arch/mips/include/asm/dma-direct.h              |   2 +
 arch/mips/include/asm/mach-generic/dma-direct.h |   7 +
 arch/mips/include/asm/mach-ip27/dma-direct.h    |  20 +
 arch/mips/include/asm/mach-ip27/irq.h           |  12 +-
 arch/mips/include/asm/mach-ip27/mmzone.h        |   9 -
 arch/mips/include/asm/mach-ip27/topology.h      |  13 +-
 arch/mips/include/asm/pci.h                     |   8 +
 arch/mips/include/asm/pci/bridge.h              | 211 ++++----
 arch/mips/include/asm/smp-ops.h                 |   1 +
 arch/mips/include/asm/sn/addrs.h                |  72 +--
 arch/mips/include/asm/sn/arch.h                 |   2 -
 arch/mips/include/asm/sn/intr.h                 |   6 +
 arch/mips/include/asm/sn/io.h                   |   2 +-
 arch/mips/include/asm/sn/sn0/addrs.h            |   5 -
 arch/mips/include/asm/xtalk/xtalk.h             |   9 -
 arch/mips/kernel/smp.c                          |   2 +
 arch/mips/pci/Makefile                          |   1 -
 arch/mips/pci/ops-bridge.c                      | 322 ------------
 arch/mips/pci/pci-ip27.c                        | 233 ---------
 arch/mips/sgi-ip27/Makefile                     |   3 +-
 arch/mips/sgi-ip27/ip27-hubio.c                 |   4 +-
 arch/mips/sgi-ip27/ip27-init.c                  |  41 +-
 arch/mips/sgi-ip27/ip27-irq-pci.c               | 266 ----------
 arch/mips/sgi-ip27/ip27-irq.c                   | 331 ++++++++-----
 arch/mips/sgi-ip27/ip27-irqno.c                 |  48 --
 arch/mips/sgi-ip27/ip27-memory.c                |  34 +-
 arch/mips/sgi-ip27/ip27-nmi.c                   |  64 +--
 arch/mips/sgi-ip27/ip27-smp.c                   |   5 +-
 arch/mips/sgi-ip27/ip27-timer.c                 |  42 +-
 arch/mips/sgi-ip27/ip27-xtalk.c                 |  44 +-
 drivers/pci/controller/Kconfig                  |   3 +
 drivers/pci/controller/Makefile                 |   1 +
 drivers/pci/controller/pci-xtalk-bridge.c       | 623 ++++++++++++++++++++++++
 drivers/pci/probe.c                             |   6 +
 include/linux/platform_data/xtalk-bridge.h      |  17 +
 kernel/irq/irqdomain.c                          |   5 +-
 37 files changed, 1126 insertions(+), 1352 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-generic/dma-direct.h
 create mode 100644 arch/mips/include/asm/mach-ip27/dma-direct.h
 delete mode 100644 arch/mips/pci/ops-bridge.c
 delete mode 100644 arch/mips/pci/pci-ip27.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irq-pci.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irqno.c
 create mode 100644 drivers/pci/controller/pci-xtalk-bridge.c
 create mode 100644 include/linux/platform_data/xtalk-bridge.h

-- 
2.13.7

