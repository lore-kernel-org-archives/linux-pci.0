Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34352 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab2HQRgY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 13:36:24 -0400
Received: by pbbrr13 with SMTP id rr13so3636242pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 10:36:24 -0700 (PDT)
Message-ID: <502E8115.90507@gmail.com>
Date: Fri, 17 Aug 2012 10:36:21 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org
CC: linux-mips <linux-mips@linux-mips.org>
Subject: PCI Section mismatch error in linux-next.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For MIPS, Thierry Reding's patch in linux-next (PCI: Keep 
pci_fixup_irqs() around after init) causes:

WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from 
the function pci_fixup_irqs() to the function 
.init.text:pcibios_update_irq()

The MIPS implementation of pcibios_update_irq() is __init, so there is 
conflict with the removal of __init from pci_fixup_irqs() and 
pdev_fixup_irq().

Can you guys either remove the patch from linux-next, or improve it to 
also fix up any architecture implementations of pdev_update_irq()?


Thanks,
David Daney
