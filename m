Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59532 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047AbcBERkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 12:40:39 -0500
Date: Fri, 5 Feb 2016 11:40:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Cc: linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Sunjin Yang <fan4326@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI device driver broken between 4.2 and 4.3
Message-ID: <20160205174035.GB24785@localhost>
References: <56A32702.7080909@mcc.vniiem.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <56A32702.7080909@mcc.vniiem.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang, Yinghai, Sunjin, linux-kernel]

On Sat, Jan 23, 2016 at 10:08:50AM +0300, Олег Мороз wrote:
> Hello. I've got a device driver for MIL-1553b card called TA1-PCI,
> which could be found at
> https://github.com/qmor/elcus-1553-driver-linux
> Card is using PLX_PCI9030 PCI controller.
> Today i've found that this driver compiles, installes, but is not
> working as it should.
> Looks like it not receives any interrupts from PCI. I've test it
> again with kernel
> 4.2 and it works okay. What changes was made in PCI subsystem from
> 4.2 to 4.3
> which could have impact this driver work.

Sunjin reported another driver, RocketRAID 272x, with the same
problem.  "pci=routeirq" is a workaround:
https://bugzilla.kernel.org/show_bug.cgi?id=111211#c7

Олег bisected the problem with his driver to Jiang's patch,
991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") and found that "pci=routeirq" was a workaround.

I don't think Sunjin has bisected this, but the RocketRAID driver
stopped working at the same time and the same workaround works, so we
assume it is the same problem.

Prior to 991de2e59090, we called pcibios_enable_irq() in the
pci_enable_device() path, which recursively called
pcibios_enable_irq() for upstream bridges via pci_enable_bridge().

After 991de2e59090, we call pcibios_enable_irq() from the
pci_device_probe() path instead of the pci_enable_device() path.  This
does *not* call pcibios_enable_irq() for upstream bridges.

I think this is what Yinghai meant in his response, but I didn't
understand the connection.

This is a pretty serious problem that should affect many devices
behind bridges, so I think we need a PCI or ACPI core fix.  Jiang?

Bjorn
