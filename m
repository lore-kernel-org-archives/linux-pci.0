Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47566 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbbLJTuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Dec 2015 14:50:04 -0500
Subject: [PATCH] lspci: Decode DevCap SlotPowerLimit for all components with
 Upstream Ports
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 10 Dec 2015 13:50:01 -0600
Message-ID: <20151210195001.8111.55134.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SlotPowerLimit in the Slot Capability indicates how much power the slot
can supply to a downstream device.  A Root Port or Switch Downstream Port
communicates the limit via a Set_Slot_Power_Limit Message on the link.  The
component on the other end of the link copies the limit from the message to
the Captured Slot Power Limit in its Device Capability [see PCIe r3.0, sec
2.2.8.5].

The Captured SlotPowerLimit is relevant for all devices on the downstream
end of a Link.  This includes Endpoints and Bridges as well as
Switch Upstream Ports.

Decode the DevCap Captured SlotPowerLimit for Endpoints and Bridges as well
as Switch Upstream Ports.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index c145ed6..639f931 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -678,7 +678,8 @@ static void cap_express_dev(struct device *d, int where, int type)
   if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END))
     printf(" FLReset%c",
 	FLAG(t, PCI_EXP_DEVCAP_FLRESET));
-  if (type == PCI_EXP_TYPE_UPSTREAM)
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
+      (type == PCI_EXP_TYPE_PCI_BRIDGE))
     printf(" SlotPowerLimit %.3fW",
 	power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
 		    (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));

