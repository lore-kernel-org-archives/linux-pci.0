Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49745 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754972AbcIAPiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2016 11:38:17 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>, Victor Gu <xigu@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/3] pci: remove msi_controller registration API
Date: Thu,  1 Sep 2016 17:38:01 +0200
Message-Id: <1472744284-18305-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This small patch series aims at removing the small msi_controller
registration API implemented in drivers/of/of_pci.c.

In order to do so, it moves the last two users of this API to the
generic MSI support:

 - The pci-aardvark driver is moved to use the generic MSI
   support. This driver is both the provider of the MSI capability and
   the consumer of this capability.

 - The pci-mvebu driver is cleaned up from using the msi_controller
   registration API. This driver is only consuming MSI capabilies from
   another driver (irq-armada-370-xp) which was migrated to the
   generic MSI support some time ago. Therefore, this patch is simply
   removing dead code.

Finally, the last commit removed the now unused API.

Thanks,

Thomas

Thomas Petazzoni (3):
  pci: pci-aardvark: move to MSI handling using generic MSI support
  pci: pci-mvebu: remove useless MSI enabling code
  of: pci: remove unused MSI controller helpers

 drivers/of/of_pci.c             |  45 -----------
 drivers/pci/host/pci-aardvark.c | 172 ++++++++++++++++------------------------
 drivers/pci/host/pci-mvebu.c    |  17 ----
 include/linux/of_pci.h          |  11 ---
 4 files changed, 67 insertions(+), 178 deletions(-)

-- 
2.7.4

