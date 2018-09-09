Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44444 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeIINPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Sep 2018 09:15:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so34685721oih.11
        for <linux-pci@vger.kernel.org>; Sun, 09 Sep 2018 01:26:48 -0700 (PDT)
MIME-Version: 1.0
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Sun, 9 Sep 2018 16:26:37 +0800
Message-ID: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
Subject: kernel panic becase pci register more than once
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
When I enable pci msi or msix more than once, the kernel will panic.
Now we just use the WARN_ON, should we add check for that has been
enabled.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f2ef896..324840f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -958,7 +958,9 @@ static int __pci_enable_msix(struct pci_dev *dev,
struct msix_entry *entries,
                        }
                }
        }
-       WARN_ON(!!dev->msix_enabled);
+
+       if (dev->msix_enabled)
+               return -EINVAL;

        /* Check whether driver already requested for MSI irq */
        if (dev->msi_enabled) {
@@ -1028,7 +1030,8 @@ static int __pci_enable_msi_range(struct pci_dev
*dev, int minvec, int maxvec,
        if (!pci_msi_supported(dev, minvec))
                return -EINVAL;

-       WARN_ON(!!dev->msi_enabled);
+       if (dev->msi_enabled)
+               return -EINVAL;

        /* Check whether driver already requested MSI-X irqs */
        if (dev->msix_enabled) {
