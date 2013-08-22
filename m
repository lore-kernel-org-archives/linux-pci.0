Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:50255 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab3HVVrd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 17:47:33 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so4773895obb.32
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 14:47:33 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 22 Aug 2013 15:47:13 -0600
Message-ID: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
Subject: VIA chipset with Root Port under a bridge
To: Shaohua Li <shaohua.li@intel.com>, Wolfgang Denk <wd@denx.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Shaohua, your commit 8e822df700 references a VIA chipset with a Root
Port under a bridge, and that commit adds a special case to disable
ASPM for that situation.

I know this is pretty old (the commit is from 2009), but do you have
any more details about that system?  A pointer to the original problem
report, lspci output, dmesg output, etc.?

I'm concerned because other parts of PCI make assumptions about Root
Port topology, e.g., in MPS configuration, and we might need to make
similar changes elsewhere.

Bjorn
