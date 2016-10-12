Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbcJLNEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:04:20 -0400
Subject: [PATCH v2 0/2] PCI: rockchip: Cleanup
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:04:16 -0500
Message-ID: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

Nothing here should change the behavior of the driver.

Changes from v1:
  Added Dan's indentation fix.
  I dropped the following patches because they were a lot of churn for
  questionable benefit:
    PCI: rockchip: Rename accessors
    PCI: rockchip: Swap order of rockchip_writel() reg/val arguments

---

Bjorn Helgaas (1):
      PCI: rockchip: Remove unused platform data

Dan Carpenter (1):
      PCI: rockchip: Indent "if" statement body


 drivers/pci/host/pcie-rockchip.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
