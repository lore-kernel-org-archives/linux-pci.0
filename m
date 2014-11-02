Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:47794 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbaKBXhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 2 Nov 2014 18:37:14 -0500
Message-ID: <5456C024.4060103@hauke-m.de>
Date: Mon, 03 Nov 2014 00:37:08 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org
Subject: PCIe host controller without IO port access.
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am currently writing a driver for a PCIe host controller which does
not support IO port access.

My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
but then it allocates some generic IORESOURCE_IO memory in
arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
the fist PCIe controller, but when the second controller gets registered
I am getting this: "unable to allocate I/O port region (-16)".

Is there an example for an arm driver for a PCIe controller which does
not support IO port access?

Should I change arch/arm/kernel/bios32.c in a way so that it would
ignore the io port mem?

Hauke
