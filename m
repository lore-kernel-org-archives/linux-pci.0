Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37788 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeFVJ6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 05:58:21 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL
Date: Fri, 22 Jun 2018 05:58:08 -0400
Message-Id: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are follow up patches for the series which modifies ERR_FATAL handling.
although there were couple of problems existed before which, itis also fixing.

patch-1:
Fixes the problem where ERR_FATAL and ERR_NONFATAL status should be cleared
taking severity mask into account.

patch-2:
Takes care of clearing error fatal status

patch-3:
Follow up patch where no more need of handling ERR_FATAL
case.

patch-4:
Fixes clearing device status in case of uncorrectable errors.
(e.g. ERR_FATAL and ERR_NONFATAL)

patch-5:
Fixes clearing device status in case of correctable errors.

patch-6:
Follow up patch where no more need of handling pci_channel_io_frozen
in pcie_portdrv_slot_reset()

Oza Pawandeep (6):
  PCI/AER: Take severity mask into account while clearing error bits
  PCI/AER: Clear uncorrectable fatal error status bits
  PCI/ERR: Cleanup ERR_FATAL of error broadcast
  PCI/AER: Clear device error status bits during ERR_FATAL and
    ERR_NONFATAL
  PCI/AER: Fix correctable status bits clearing in device register
  PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()

 drivers/pci/pcie/aer.c         | 35 +++++++++++++++++++++++------------
 drivers/pci/pcie/err.c         | 15 +++++++--------
 drivers/pci/pcie/portdrv_pci.c | 18 ------------------
 include/linux/aer.h            |  5 +++++
 4 files changed, 35 insertions(+), 38 deletions(-)

-- 
2.7.4
