Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34627 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbLKCa0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 21:30:26 -0500
Received: by pfbg73 with SMTP id g73so58929270pfb.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Dec 2015 18:30:26 -0800 (PST)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 2/2] PCI: Limit config space size for Netronome NFP4000
Date: Fri, 11 Dec 2015 11:30:12 +0900
Message-Id: <1449801012-10432-3-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
References: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Like the NFP6000 the NFP4000 as an erratum where reading/writing to PCI
config space addresses above 0x600 can cause the NFP to generate PCIe
completion timeouts.

Limit the NFP4000's PF's config space size to 0x600 bytes as is already
done for the NFP6000.

The NFP4000's VF is 0x6004 (PCI_DEVICE_ID_NETRONOME_NFP6000_VF), the same
device ID as the NFP6000's VF. Thus its config space is already limited
by the existing use of quirk_nfp6000.

Signed-off-by: Simon Horman <simon.horman@netronome.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 83e93d7ca4b9..8b13b41257b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -295,6 +295,7 @@ static void quirk_nfp6000(struct pci_dev *dev)
 {
 	dev->cfg_size = 0x600;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP4000,	quirk_nfp6000);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000,	quirk_nfp6000);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000_VF,	quirk_nfp6000);
 
-- 
2.1.4

