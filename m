Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:54273 "EHLO
        1.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbeARXAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 18:00:40 -0500
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 73B4299FB8
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2018 23:54:35 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v4 5/7] PCI: Add vendor ID for Cadence
Date: Thu, 18 Jan 2018 23:52:50 +0100
Message-Id: <4bb236b4512336d98501210884a6118ea72defa7.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
References: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new PCI vendor ID for Cadence.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab20dc5db423..eb13e84e1fef 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2381,6 +2381,8 @@
 
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
+#define PCI_VENDOR_ID_CDNS		0x17cd
+
 #define PCI_VENDOR_ID_ARECA		0x17d3
 #define PCI_DEVICE_ID_ARECA_1110	0x1110
 #define PCI_DEVICE_ID_ARECA_1120	0x1120
-- 
2.11.0
