Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54280 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757292Ab3J1SJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2013 14:09:58 -0400
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: AER driver on ARM platform
Date: Mon, 28 Oct 2013 18:09:55 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B7046265B4@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
	<CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
 <CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
In-Reply-To: <CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andrewl,

Thanks. I got some questions on AER irq handling below. 

>> > Yes. That was it. It probes the driver now. Did you try error inject feature?
>> 
>> I did have a look at that, but it really depends on what exactly you want to test. There are
>> many things this won't help you with, you ought to examine the aer inject driver to see
>> what it does. For example if you are bringing up a new device and want to see it raise an
>> AER interrupt then aer inject won't help. In this case you'll need to find a way to trigger real
>> errors.
>> 

What is the IRQ line tied to the AER driver? Since this is handling the root port error irq as well as the upstream/downstream device irqs. Does this driver assumes that error interrupt is raised on Legacy IRQ0 or MSI IRQ 0 for all of the ports (root, downstream and upstream)? When I have dumped the irq number in the AER driver it shows Legacy irq0 (when nomsi boot parameter is used) or MSI irq0. Our PCIe IP acts as a RC and has a separate IRQ line (12) for root port irq as below

12 Error Interrupts
           [0] System error (OR of fatal, nonfatal, correctable errors) (RC mode only)
           [1] PCIe fatal error (RC mode only)
           [2] PCIe non-fatal error (RC mode only)
           [3] PCIe correctable error (RC mode only)
           [4] AXI Error due to fatal condition in AXI bridge (EP/RC modes)
           [5] PCIe advanced error (RC mode only)

Does that mean, I need to modify the AER driver to support separate IRQ line for root port (port_type = PCI_EXP_TYPE_ROOT_PORT) for the hw I am working on. Any help?


Murali Karicheri
Linux Kernel, Software Development
>> Andrew Murray
