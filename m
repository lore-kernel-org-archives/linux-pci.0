Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64926 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751922AbeGBFsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Jul 2018 01:48:39 -0400
From: "Skidanov, Alexey" <alexey.skidanov@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "alexey.skidanov@gmail.com" <alexey.skidanov@gmail.com>
Subject: Link Up and Link Down handling 
Date: Mon, 2 Jul 2018 05:48:07 +0000
Message-ID: <040863540BC4D141BEB177532350882862B196A1@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The PCIe spec defines the Data Link Layer State Changed Events - Link Up and Link Down.  So the flows look like this:

Link Down Flow:
-	Root Port driver is notified about the link down by the interrupt
-	Root Port driver notifies the device driver (struct pci_driver.remove() callback)
-	Host Driver cleanups all allocated resources
-	Root Port Driver removes the device object from the OS  
Link Up flow
-	Root Port driver is notified about the link up by the interrupt
-	Root Port Driver adds the device object to the OS
-	Root Port driver notifies the device driver (struct pci_driver.probe() callback)
-	Host Driver initializes all needed resources

Do I miss something? Appreciate your notes.

Thanks,
Alexey
