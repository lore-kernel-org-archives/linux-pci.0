Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992604AbeAUVOe3KU-G (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:14:34 +0100
Date: Sun, 21 Jan 2018 22:14:32 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC 0/5] Add managed ioremap function for shared resources
Message-ID: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Many drivers can simplified by using devm_ioremap_resource()
instead of open coding its functionality. However, as pointed
by Wei Yongjun, that function cannot be used when memory region
is already taken. See previous discussion here:
https://www.spinics.net/lists/linux-pci/msg68495.html

To ease job of driver developers, new function for that
purpose is implemented and its usage shown.

Also, there are few cleanup patches, which may bring some
controversy, but seemed usefull to do along the way.

Feel free to object or suggest something else. Thank you.

Ladislav Michl (5):
  devres: Move managed io function declarations into device.h
  PCI: Move managed resource alloc to devres
  devres: Make devm_ioremap_release() static
  devres: Add devm_ioremap_shared_resource()
  mtd: nand: davinci: Use devm_ioremap_shared_resource()

 drivers/mtd/nand/davinci_nand.c |  24 +++------
 drivers/pci/pci.c               |  82 -------------------------------
 include/linux/device.h          |  65 +++++++++++++++++++++++-
 include/linux/io.h              |  39 ---------------
 include/linux/ioport.h          |  23 ---------
 lib/devres.c                    | 106 ++++++++++++++++++++++++++++++++++++----
 6 files changed, 168 insertions(+), 171 deletions(-)

-- 
2.15.1
