Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44586 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3LBNnu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 08:43:50 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.72)
	(envelope-from <bigeasy@linutronix.de>)
	id 1VnTmv-0005NV-EJ
	for linux-pci@vger.kernel.org; Mon, 02 Dec 2013 14:43:49 +0100
Date: Mon, 2 Dec 2013 14:43:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pci@vger.kernel.org
Subject: Could enabling MSI interrupts lead to problems?
Message-ID: <20131202134349.GA19436@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've been playing with PCIe parallel port cards. Both of them have the
MSI flag set and it is possible to enable MSI interrupts. The advantage
is that the interrupt is no longer shared with other devices and it
becomes edge instead of level.
Now I'm thinking about posting a patch which always calls
pci_enable_msi() on init so we have MSI support in parport_pc driver if
possible. I know that atleast XHCI has a flag not to enable MSI on some
FRESCO_LOGIC devices because they announce it but can't generate
interrupts with MSI enabled. Is this something "usual" and I should only
enable MSI based on a whitelist or is this more something exceptional?

Sebastian
