Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:12656
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758823Ab2D0Ohy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 10:37:54 -0400
Date: Fri, 27 Apr 2012 16:37:45 +0200
From: Andreas Herrmann <andreas.herrmann3@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2][RESEND] x86/pci/amd: Enable early_fill_mp_bus_to_node on
 AMD family 15h models 0-0xf
Message-ID: <20120427143745.GD27535@alberich.amd.com>
References: <20120427143410.GB27535@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20120427143410.GB27535@alberich.amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


While at it avoid calling this function on family 11h (aka Griffin)
which was a mobile part and doesn't support NUMA.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 arch/x86/pci/amd_bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 0384e69..d552b29 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -27,7 +27,7 @@ static struct pci_hostbridge_probe pci_probes[] __initdata = {
 	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1100 },
 	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1200 },
 	{ 0xff, 0, PCI_VENDOR_ID_AMD, 0x1200 },
-	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1300 },
+	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1600 },
 };
 
 /**
-- 
1.7.8.5



