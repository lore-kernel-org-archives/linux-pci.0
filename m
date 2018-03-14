Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751649AbeCNQf1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 12:35:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EGXjrU007829
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 12:35:27 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq446293e-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 12:35:27 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <desnesn@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 10:35:26 -0600
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, ruscur@russell.cc, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com
Subject: [PATCH 0/2] Silent PCI realignment messages during boot
Date: Wed, 14 Mar 2018 13:34:53 -0300
Message-Id: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset introduces PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute in
pci_dev_flags which informs the pci subsystem to suppress all realignment
messages.

Powerpc has aligned all of its PCI resources to its PAGE_SIZE, and this
feature can be easily used on any other arch through the __weak
pcibios_default_alignment() interface.

However, since all PCI resources will be now realigned during boot, the
following messages will not only flood the system logs, but can be inter-
preted as a false positive for total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices ...

Thus, this patchset provides a way for drivers to silent these messages if
the PCI_DEV_FLAGS_QUIET_PCI_REALIGN is turned on. Moreover, it also
tweaks this flag during boot on powerpc.

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>

Desnes A. Nunes do Rosario (2):
  pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute to the PCI
    subsystem
  powerpc/powernv: Tweak PCI_DEV_FLAGS_QUIET_PCI_REALIGN on/off during
    boot

 arch/powerpc/platforms/powernv/pci.c | 14 ++++++++++++++
 drivers/pci/pci.c                    |  3 ++-
 drivers/pci/setup-res.c              |  3 ++-
 include/linux/pci.h                  |  2 ++
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.14.3
