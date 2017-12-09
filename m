Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44023 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdLIXaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Dec 2017 18:30:16 -0500
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] r8169: extend PCI core and switch to device-managed
 functions in probe
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
Date: Sun, 10 Dec 2017 00:30:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Probe error path and remove callback can be significantly simplified
by using device-managed functions. To be able to do this in the r8169
driver we need a device-managed version of pci_set_mwi first.

Heiner Kallweit (3):
  PCI: introduce device-managed version of pci_set_mwi
  r8169: switch to device-managed functions in probe
  r8169: remove netif_napi_del in probe error path

 drivers/net/ethernet/realtek/r8169.c | 87 +++++++++---------------------------
 drivers/pci/pci.c                    | 29 ++++++++++++
 include/linux/pci.h                  |  1 +
 3 files changed, 50 insertions(+), 67 deletions(-)

-- 
2.15.1
