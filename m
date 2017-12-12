Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40168 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdLLGeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 01:34:37 -0500
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/3] r8169: extend PCI core and switch to device-managed
 functions in probe
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <36fa928b-e974-c023-de3e-c2bd05f53df2@gmail.com>
Date: Tue, 12 Dec 2017 07:34:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Probe error path and remove callback can be significantly simplified
by using device-managed functions. To be able to do this in the r8169
driver we need a device-managed version of pci_set_mwi first.

v2:
Change patch 1 based on Björn's review comments and add his Acked-by.

Heiner Kallweit (3):
  PCI: Add pcim_set_mwi(), a device-managed pci_set_mwi()
  r8169: switch to device-managed functions in probe
  r8169: remove netif_napi_del in probe error path

 drivers/net/ethernet/realtek/r8169.c | 87 +++++++++---------------------------
 drivers/pci/pci.c                    | 25 +++++++++++
 include/linux/pci.h                  |  1 +
 3 files changed, 46 insertions(+), 67 deletions(-)

-- 
2.15.1
