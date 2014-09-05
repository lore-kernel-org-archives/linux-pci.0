Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbaIEQhN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Sep 2014 12:37:13 -0400
Message-ID: <5409E6CF.8060109@ti.com>
Date: Fri, 5 Sep 2014 12:37:35 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCI Keystone driver on host-designware
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Bjorn,

Thank you first for queueing the Keystone PCI driver patch for v3.18.

I have pulled today from pci/host-designware branch at 
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
and tested PCI driver on Keystone and it works as expected.

Could you also clarify the following?

1. The DT documentation 
(Documentation/devicetree/bindings/pci/pci-keystone.txt) that was part 
of the PCI driver commit is missing in the branch. Was this intentional? 
Do you want me to send a patch for this or it gets merged through some 
other subystem (Documentation?)

2. I have subsequently send a patch to the list and got some reviews 
done to remove the bootargs dependency on the Keystone PCI driver. The 
same is available at
https://lkml.org/lkml/2014/8/8/486
Could you please apply this as well?

Regards,

Murali
