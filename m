Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDDC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B88F2146E
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBTKAs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:00:48 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36152 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfBTKAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2019 05:00:48 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 55FC53A7134
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2019 09:48:50 +0000 (UTC)
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 534AB200015;
        Wed, 20 Feb 2019 09:48:46 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge emul code
Date:   Wed, 20 Feb 2019 10:48:39 +0100
Message-Id: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This set of two patches aim at fixing some regression reported by two
users (Luis and Leigh), that were introduced by the conversion of the
pci-mvebu driver to the common PCI bridge emulation code shared
between pci-aardvark and pci-mvebu.

Due to this conversion, some registers of the PCI configuration that
used to be read-only are now read-write, making the Linux PCI core
believe that some features are implemented by the PCI bridge. Namely
in the case of pci-mvebu, the prefetchable memory base/limit registers
were read-only, while they are now read-write. Due to this, the Linux
PCI core now believes it can configure a prefetchable memory area, but
this is not supported by pci-mvebu, which does not have the logic to
create the appropriate MBUs windows.

This set of two commits allow PCI controller code to tell the PCI
bridge emulation logic about their capabilities. Because we envision
that other capabilities than prefetchable memory support might need to
be communicated from the PCI controller code to the PCI bridge
emulation code in the future, we introduce a "flags" argument, even if
for now only one flag is supported.

Lorenzo, let me know what you think about this approach. I am open to
suggestions if the proposed approach is not satisfying.

Both patches have been confirmed by Luis and Leigh to fix the
regression, but I'll let them give a formal Tested-by.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (2):
  PCI: pci-bridge-emul: Create per-bridge copy of register behavior
  PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags

 drivers/pci/controller/pci-aardvark.c |  2 +-
 drivers/pci/controller/pci-mvebu.c    |  2 +-
 drivers/pci/pci-bridge-emul.c         | 86 ++++++++++++++++++---------
 drivers/pci/pci-bridge-emul.h         | 13 +++-
 4 files changed, 73 insertions(+), 30 deletions(-)

-- 
2.20.1

