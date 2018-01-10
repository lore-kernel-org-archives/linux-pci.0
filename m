Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:51071 "EHLO
        8.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeAJW4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jan 2018 17:56:35 -0500
Received: from player690.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2D2E590432
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2018 23:49:01 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v3 4/6] PCI: Add vendor ID for Cadence
Date: Wed, 10 Jan 2018 23:47:33 +0100
Message-Id: <fc146d33849fc3143866249254fbcc82c1823775.1515621150.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
References: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
References: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
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
