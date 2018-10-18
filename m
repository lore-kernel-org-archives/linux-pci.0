Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C7ECDE45
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB221477
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCB221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJRXi5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:38:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37032 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbeJRXi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 19:38:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B1F6E208C7; Thu, 18 Oct 2018 17:37:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 875DF20618;
        Thu, 18 Oct 2018 17:37:21 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/4] PCI: emulated PCI bridge config space
Date:   Thu, 18 Oct 2018 17:37:15 +0200
Message-Id: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

The pci-mvebu driver already contains some logic to emulate a root
port PCI bridge configuration space. It turns out that we have a
similar need for the pci-aardvark driver. Instead of duplicating the
same logic in two drivers, this patch series starts by adding a small
common infrastructure that helps emulate a root port PCI bridge config
space, converts pci-mvebu to use it, and finally extends pci-aardvark
to use it as well.

Thanks to this, Marvell Armada 3720 based systems, which use the
Aarkvark PCI controller, will have better PCI support, by having a
root port PCI bridge exposed.

The emulated PCI bridge common logic is a proposal, I very much
welcome comments and suggestions. Also, if you feel that adding a
common logic for only two drivers is too early, I'm fine with
duplicating a bit of code betwen pci-mvebu and pci-aardvark.

Changes v2 -> v3:

 - Address the FIXME comment that was pointed out by Russell. In fact
   the |= pcie_devctl was not needed, because pcie_devctl is always
   zero. To fix this, an additional commit was added to the series to
   drop the use of unneeded fields in the PCI Express capability block
   emulation in pci-mvebu.

 - Drop some more code from pci-mvebu that was used to prevent messing
   up with W1C bits, because this is now already taken care of by the
   common bridge emulation logic.

 - Fixed the commit log of "PCI: mvebu: Convert to PCI emulated bridge
   config space" according to Lorenzo comments.

 - Use PCI_STD_HEADER_SIZEOF when defining PCI_BRIDGE_CONTROL, as
   suggested by Bjorn.

 - Added Bjorn Acked-by and Russell Reviewed-by on the patch adding
   the common logic.

Changes v1 -> v2:

 - Rebased to 4.19-rc1

 - The functions implementing the config space read/write emulation
   now have the knowledge of which registers/bits are read-only,
   read-write, reserved and write-1-to-clear, and behave according to
   this information.

 - I have renamed the function to use conf_read() and conf_write()
   suffixes, as suggested by Bjorn.

 - The whole thing is now named pci-bridge-emul instead of
   pci-sw-bridge (and of course all functions, types and macros were
   changed accordingly), as Bjorn wasn't happy about pci-sw-bridge.

 - The header file was moved into drivers/pci (instead of being in
   include/linux).

Thanks a lot in advance for your review and feedback.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (3):
  PCI: Introduce PCI bridge emulated config space common logic
  PCI: mvebu: Drop unused PCI express capability code
  PCI: mvebu: Convert to PCI emulated bridge config space

Zachary Zhang (1):
  PCI: aardvark: Implement emulated root PCI bridge config space

 drivers/pci/Kconfig                   |   3 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/controller/Kconfig        |   2 +
 drivers/pci/controller/pci-aardvark.c | 129 ++++++++++-
 drivers/pci/controller/pci-mvebu.c    | 384 +++++++++-----------------------
 drivers/pci/pci-bridge-emul.c         | 408 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci-bridge-emul.h         | 124 +++++++++++
 7 files changed, 764 insertions(+), 287 deletions(-)
 create mode 100644 drivers/pci/pci-bridge-emul.c
 create mode 100644 drivers/pci/pci-bridge-emul.h

-- 
2.14.4

