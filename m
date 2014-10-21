Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.166]:31782 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932702AbaJUOrB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Oct 2014 10:47:01 -0400
Date: Tue, 21 Oct 2014 16:37:10 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: <linux-pci@vger.kernel.org>
Subject: Question regarding pci_request_region()
Message-ID: <20141021143709.GA19376@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I've some questions regarding pci_request_region(). Is there a similar function
that allows me to request the memory from a PCIe device, but not a whole BAR?

in drivers/mcb/mcb-pci.c I do a pci_request_region() for BAR 0. But I only need
the first 0x200 bytes. pci_request_region() locks the memory and thus probing of
mcb attached sub devices fails, as they can't do a request_mem on their part of
the PCI memory space until the mcb parser is done and releases BAR0.

Generally this is no problem when you build all drivers as modules, but once I
do build in drivers, probing fails. Before rewriting all mcb based drivers to
use deferred probing I wanted to ask if there is a more clean way to do this.

Thanks in advance,
       Johannes
