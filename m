Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:45538 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeDPOeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 10:34:18 -0400
MIME-Version: 1.0
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 16 Apr 2018 07:33:57 -0700
Message-ID: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
Subject: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address limits
 in resource allocation)
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
address limits in resource allocation) broke Alpha systems using
CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
into the upper addresses just below 4GB.

I can get a working kernel by ifdef'ing out the code in
drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
kernels.

How can we get Nautilus working again?
