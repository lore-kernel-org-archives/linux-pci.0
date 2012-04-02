Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:20906
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753739Ab2DBRVu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2012 13:21:50 -0400
Date: Mon, 2 Apr 2012 19:21:39 +0200
From: Andreas Herrmann <andreas.herrmann3@amd.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Ingo Molnar <mingo@kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] [resend]  x86/amd: Enable early_fill_mp_bus_to_node on
 AMD family 15h models 0-0xf
Message-ID: <20120402172139.GB27777@alberich.amd.com>
References: <20120227094406.GB10078@elte.hu>
 <20120227122240.778bcc5b@jbarnes-desktop>
 <20120402172008.GA27777@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120402172008.GA27777@alberich.amd.com>
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



