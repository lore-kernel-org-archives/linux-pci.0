Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161115AbdEXWwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 18:52:07 -0400
Subject: [PATCH 1/2] PCI: Add Mellanox device IDs
From: Myron Stowe <myron.stowe@redhat.com>
To: linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc: bhelgaas@google.com, saeedm@mellanox.com, noaos@mellanox.com,
        tariqt@mellanox.com
Date: Wed, 24 May 2017 16:47:43 -0600
Message-ID: <20170524224743.24221.77298.stgit@amt.stowe>
In-Reply-To: <20170524224734.24221.33787.stgit@amt.stowe>
References: <20170524224734.24221.33787.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Mellanox device IDs for controllers covered by the mlx5 driver.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---
 include/linux/pci_ids.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5f6b71d..5626d5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2266,6 +2266,9 @@
 #define PCI_DEVICE_ID_MELLANOX_CONNECTIB	0x1011
 #define PCI_DEVICE_ID_MELLANOX_CONNECTX4	0x1013
 #define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX	0x1015
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX5	0x1017
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX5_EX	0x1019
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX6	0x101b
 #define PCI_DEVICE_ID_MELLANOX_TAVOR		0x5a44
 #define PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE	0x5a46
 #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD	0x5e8c
