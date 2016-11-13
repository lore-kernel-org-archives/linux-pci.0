Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55046 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933689AbcKMOWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 09:22:02 -0500
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
        majd@mellanox.com, noaos@mellanox.com
Subject: [PATCH 0/4] Cover letter
Date: Sun, 13 Nov 2016 16:21:38 +0200
Message-Id: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
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

Noa Osherovich (3):
  PCI: Use FINAL fixup to mark broken INTx masking
  PCI: Convert Mellanox quirks to be for listed devices only
  PCI: Add checks to mellanox_check_broken_intx_masking

 drivers/pci/quirks.c | 172 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 136 insertions(+), 36 deletions(-)

-- 
1.8.3.1

