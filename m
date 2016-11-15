Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56927 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965914AbcKOIA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 03:00:28 -0500
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com, noaos@mellanox.com
Subject: [PATCH v1 0/3] Unmarking Mellanox devices with broken INTx masking
Date: Tue, 15 Nov 2016 09:59:57 +0200
Message-Id: <1479196800-32191-1-git-send-email-noaos@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following 3 patches unmark some Mellanox devices as having broken
INTx masking.

The first patch moves all broken INTx masking to FINAL instead of
HEADER so that the fixup can execute on all archs.
The second fixup changes the Mellanox marking to be according to a
list of devices rather than a general fixup by vendor.
The third patch excludes some Mellanox devices from the INTx broken
marking according to device ID / firmware version.

v0 -> v1
Fixes according to Gavin Shan's comments:
- Patch numbering was wrong
- Fixed logic of mellanox_check_broken_intx_masking

Noa Osherovich (3):
  PCI: Use FINAL fixup to mark broken INTx masking
  PCI: Convert Mellanox quirks to be for listed devices only
  PCI: Add checks to mellanox_check_broken_intx_masking

 drivers/pci/quirks.c | 175 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 139 insertions(+), 36 deletions(-)

-- 
1.8.3.1

