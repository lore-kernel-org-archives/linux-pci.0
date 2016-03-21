Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36150 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcCUH0p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2016 03:26:45 -0400
Date: Mon, 21 Mar 2016 09:26:41 +0200 (EET)
From: Tero Roponen <tero.roponen@gmail.com>
To: bhelgaas@google.com
cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Restore inclusion of pci/hotplug Kconfig
Message-ID: <alpine.LFD.2.20.1603210924030.16682@terrop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit e7e127e3c767 ("PCI: Include pci/hotplug Kconfig directly
from pci/Kconfig") added one line to pci/Kconfig. However, for
some mysterious reason it isn't there now, even though there
are no traces of removing it in the git log.

I detected this issue when 'make oldconfig' removed all the
options that depended on HOTPLUG_PCI.

Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a1f37db..209292e 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -128,4 +128,5 @@ config PCI_HYPERV
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
 
+source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/host/Kconfig"

