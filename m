Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:19313 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab2BBLHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2012 06:07:14 -0500
Received: from G9W0369G.americas.hpqcorp.net (g9w0369g.houston.hp.com [16.216.193.232])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g5t0007.atlanta.hp.com (Postfix) with ESMTPS id 63B48142F4
	for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2012 11:07:13 +0000 (UTC)
From: "Fischer, Anna" <anna.fischer@hp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 2 Feb 2012 11:05:36 +0000
Subject: PCI MSI-X vectors in /proc/interrupts
Message-ID: <0199E0D51A61344794750DC57738F58E758ACB536F@GVW1118EXC.americas.hpqcorp.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm developing a kernel device driver which is using 2 PCI MSI-X vectors. 

When the device comes up and I call pci_enable_msix() the kernel prints 

"[snip] irq 45 for MSI/MSI-X"
"[snip] irq 46 for MSI/MSI-X"

So it seems as if IRQs 45 and 46 are allocated for my device. However, when I look into /proc/interrupts, it lists my device under IRQ 42 and 43. Is it expected that those IRQ numbers match, e.g. something is broken in my device driver or kernel code? I use Linux 3.2.0-rc7.

Thanks for your help.

Anna
