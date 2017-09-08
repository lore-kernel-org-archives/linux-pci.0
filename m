Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41934 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbdIHJx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2017 05:53:59 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Yehuda Yitschak <yehuday@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/7] PCI: aardvark: improve compatibility with PCI devices
Date: Fri,  8 Sep 2017 11:53:41 +0200
Message-Id: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This patch series brings a number of fixes to the pci-aardvark driver
that allows a much larger number of PCIe devices to be used.

It fixes kernel bug
https://bugzilla.kernel.org/show_bug.cgi?id=196339, and has been
tested with an IGB NIC and a Marvell SATA PCIe card, which were not
working previously.

They should be taken for the 4.14 cycle, as they are all bug fixes.

Thanks a lot!

Thomas

Evan Wang (1):
  PCI: aardvark: fix PCIe max read request size setting

Thomas Petazzoni (1):
  PCI: aardvark: define IRQ related hooks in pci_host_bridge

Victor Gu (5):
  PCI: aardvark: fix logic in PCI configuration read/write functions
  PCI: aardvark: set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
  PCI: aardvark: set host and device to the same MAX payload size
  PCI: aardvark: use isr1 instead of isr0 interrupt in legacy irq mode
  PCI: aardvark: disable LOS state by default

 drivers/pci/host/pci-aardvark.c | 116 +++++++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 24 deletions(-)

-- 
2.13.5
