Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:30250 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCOKnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 06:43:46 -0400
Received: from [192.168.1.134] (ppp-188-174-84-121.dynamic.mnet-online.de [188.174.84.121])
        by smtp.strato.de (RZmta 42.18 DYNA|AUTH)
        with ESMTPSA id f061ebu2FAeQvW5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <linux-pci@vger.kernel.org>;
        Thu, 15 Mar 2018 11:40:26 +0100 (CET)
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: PASEMI: PCI_SCAN_ALL_PCIE_DEVS
Message-ID: <e6083bae-42a0-c598-5040-fb0089c53d3f@xenosoft.de>
Date: Thu, 15 Mar 2018 11:40:25 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9A15101ABDC0C1C9E1618167"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------9A15101ABDC0C1C9E1618167
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

We always have to add 'pci=pcie_scan_all' to the kernel boot arguments 
for our P.A. Semi boards. Please find attached a patch for solving this 
issue.

Could you please add this patch to the official kernel source code?

Thanks,
Christian


--------------9A15101ABDC0C1C9E1618167
Content-Type: text/x-patch;
 name="pci.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pci.c.patch"

arch/powerpc/platforms/pasemi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
 		return;
 	}
 
+	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
 		if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
 			of_node_get(np);

--------------9A15101ABDC0C1C9E1618167--
