Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:59744 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbaH0WEH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Aug 2014 18:04:07 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so140591qae.22
        for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2014 15:04:04 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Aug 2014 16:03:43 -0600
Message-ID: <CAErSpo5KBNmeh+pjZXyk47w28tHr95kO64KJKBKSky9ODWuM2w@mail.gmail.com>
Subject: pciehp PCI_BASE_CLASS_DISPLAY check
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,

In 9789ac979b6b ("PCI: pciehp: cleanup flow in
pciehp_configure_device") [1], you added a check that prevents us from
calling pci_configure_slot() for PCI_BASE_CLASS_DISPLAY devices.

Do you remember why we need that check?  I would like to configure
devices in the pci_device_add() path instead of doing it in the
hotplug drivers.  pci_configure_device() is currently called from:

  acpiphp_set_hpp_values()
  pciehp_configure_device()
  shpchp_configure_device()

Only pciehp_configure_device() has the PCI_BASE_CLASS_DISPLAY check.

Bjorn

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9789ac979b6b
