Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:55219 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3FHCaH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 22:30:07 -0400
MIME-Version: 1.0
Date: Sat, 8 Jun 2013 10:30:05 +0800
Message-ID: <CACVXFVNgG=-EZ+_dTL2+0CDeN+x5nS2=S52mYeavzMJpKGJNMQ@mail.gmail.com>
Subject: EHCI: read status register is very slow in ehci_irq
From: Ming Lei <tom.leiming@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@vger.kernel.org, x86@kernel.org,
	linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I found on my machine(lenovo T410), most of time only reading the status
register in the entry of ehci_irq may take 2~4 microseconds, and sometimes
it is extremely slow and the read can consume > 100 microseconds.

I measure the time by adding two trace events around the below line in
entry of ehci_irq().

         status = ehci_readl(ehci, &ehci->regs->status)

Looks it should be a platform-dependent issue and I didn't
observe that on some arm platform.

Could anyone give a hint about the problem?

Thanks,
-- 
Ming Lei
