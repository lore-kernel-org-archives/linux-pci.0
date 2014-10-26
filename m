Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:58739 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbaJZSF4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 26 Oct 2014 14:05:56 -0400
Message-ID: <544D37F7.2060800@web.de>
Date: Sun, 26 Oct 2014 19:05:43 +0100
From: Heiner Kallweit <heiner.kallweit@web.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: "linux-arm-kernel"@lists.infradead.org, l.stach@pengutronix.de
Subject: Setting cpu affinity for MSI-X on i.mx6 possible?
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I use a mini pc with i.mx6 dual and Intel igb based nic (I211) connected via PCIE.
igb driver uses MSI-X and creates two rx/tx queue pairs. However the IRQs of all queues are handled by the same CPU.
Changing affinity is not possible. Obvious direct reason is that irq_chip PCI-MSI doesn't implement the callback
for setting cpu affinity.
I'd appreciate a hint whether this is a general limitation of the Cortex-A9 / GICv1 / Synopsys Designware
architecture or whether just a proper implementation is missing yet.

Rgds, Heiner
