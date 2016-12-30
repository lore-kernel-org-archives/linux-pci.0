Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v2 0/3] PCI: designware/dra7xx: misc fixes and cleanups
Date: Fri, 30 Dec 2016 15:26:11 +0530
Message-ID: <1483091774-8332-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series contains
        *) a patch to cleanup dra7xx probe
        *) a patch to force DRA7xx controller to work in GEN1 mode
        *) a patch to fix dra7xx driver so that even if CONFIG_PCI_MSI
           is enabled, dra7xx driver can service legacy interrupts
           (provided the device support only legacy interrupts).

Changes from v1:
*) rebased to 4.10-rc1 (and [1])
*) use existing dt property "max-link-speed" instead of creating a new
   TI specific dt property.

[1] -> https://lkml.org/lkml/2016/12/28/34

Kishon Vijay Abraham I (3):
  PCI: dra7xx: simplify the probe code
  PCI: dra7xx: Add support to force RC to work in GEN1 mode
  PCI: dra7xx: Enable MSI and legacy interrupts simultaneously

 drivers/pci/controller/pci-dra7xx.c |   81 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 34 deletions(-)

-- 
1.7.9.5
