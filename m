Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8130FC282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B63218AF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfAXRrq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:47:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:51284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbfAXRrq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 311A9AF7E;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/7] MIPS: SGI-IP27 rework
Date:   Thu, 24 Jan 2019 18:47:21 +0100
Message-Id: <20190124174728.28812-1-tbogendoerfer@suse.de>
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
into a MFD and subdevice drivers. Prototype is working, but needs
still more clean ups.


Thomas Bogendoerfer (7):
  MIPS: SGI-IP27: get rid of volatile and hubreg_t
  MIPS: SGI-IP27: clean up bridge access and header files
  MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont to fix output
  MIPS: SGI-IP27: do xtalk scanning later
  MIPS: SGI-IP27: rework HUB interrupts
  MIPS: SGI-IP27: use generic PCI driver
  MIPS: SGI-IP27: abstract chipset irq from bridge

 arch/mips/Kconfig                          |   3 +
 arch/mips/include/asm/mach-ip27/irq.h      |  12 +-
 arch/mips/include/asm/mach-ip27/mmzone.h   |   2 -
 arch/mips/include/asm/pci/bridge.h         | 225 ++++++------
 arch/mips/include/asm/sn/addrs.h           |  63 +---
 arch/mips/include/asm/sn/arch.h            |   2 -
 arch/mips/include/asm/sn/intr.h            |   7 +
 arch/mips/include/asm/sn/sn0/addrs.h       |   5 -
 arch/mips/include/asm/xtalk/xtalk.h        |   9 -
 arch/mips/pci/Makefile                     |   1 -
 arch/mips/pci/ops-bridge.c                 | 322 -----------------
 arch/mips/pci/pci-ip27.c                   | 233 ------------
 arch/mips/sgi-ip27/Makefile                |   3 +-
 arch/mips/sgi-ip27/ip27-hubio.c            |   2 +-
 arch/mips/sgi-ip27/ip27-init.c             |  33 +-
 arch/mips/sgi-ip27/ip27-irq-pci.c          | 266 --------------
 arch/mips/sgi-ip27/ip27-irq.c              | 297 ++++++++++-----
 arch/mips/sgi-ip27/ip27-irqno.c            |  48 ---
 arch/mips/sgi-ip27/ip27-memory.c           |  34 +-
 arch/mips/sgi-ip27/ip27-nmi.c              |  64 ++--
 arch/mips/sgi-ip27/ip27-timer.c            |  42 +--
 arch/mips/sgi-ip27/ip27-xtalk.c            |  44 ++-
 drivers/pci/controller/Kconfig             |   3 +
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pci-xtalk-bridge.c  | 558 +++++++++++++++++++++++++++++
 include/linux/platform_data/xtalk-bridge.h |  17 +
 26 files changed, 997 insertions(+), 1299 deletions(-)
 delete mode 100644 arch/mips/pci/ops-bridge.c
 delete mode 100644 arch/mips/pci/pci-ip27.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irq-pci.c
 delete mode 100644 arch/mips/sgi-ip27/ip27-irqno.c
 create mode 100644 drivers/pci/controller/pci-xtalk-bridge.c
 create mode 100644 include/linux/platform_data/xtalk-bridge.h

-- 
2.13.7

