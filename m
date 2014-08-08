Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.163.143] ([207.46.163.143]:11749 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751588AbaHHXTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Aug 2014 19:19:40 -0400
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>
CC: <pawel.moll@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <tglx@linutronix.de>,
	<Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization
Date: Fri, 8 Aug 2014 18:17:12 -0500
Message-ID: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set reworks the GICv2m initialization based on Marc Zyngier
review comments.

* Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/gic-v2m

Suravee Suthikulpanit (1):
  irqchip/gic-v2m: Restructure the initalization code for v2m

 Documentation/devicetree/bindings/arm/gic.txt |  37 +++++++--
 drivers/irqchip/irq-gic-v2m.c                 | 115 +++++++++-----------------
 drivers/irqchip/irq-gic.c                     |  30 +++----
 drivers/irqchip/irq-gic.h                     |  10 +--
 4 files changed, 91 insertions(+), 101 deletions(-)

-- 
1.9.0

