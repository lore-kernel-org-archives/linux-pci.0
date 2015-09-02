Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58985 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbbIBHBt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Sep 2015 03:01:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZX237-0002Gy-0F
	for linux-pci@vger.kernel.org; Wed, 02 Sep 2015 09:01:47 +0200
Received: from 195.219.98.189 ([195.219.98.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 09:01:36 +0200
Received: from peio by 195.219.98.189 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 09:01:36 +0200
To: linux-pci@vger.kernel.org
From: Peio <peio@azkarate.eu>
Subject: Re: PCI rescan : can't assign mem
Date: Wed, 2 Sep 2015 07:01:28 +0000 (UTC)
Message-ID: <loom.20150902T084450-322@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com> <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai Lu <yinghai <at> kernel.org> writes:

> 
> On Tue, Sep 1, 2015 at 2:01 AM, Peio <peio <at> azkarate.eu> wrote:
> > Yinghai Lu <yinghai <at> kernel.org> writes:

> root bus resource:
> 
> [    0.277955] PCI host bridge to bus 0000:00
> [    0.277966] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.277975] pci_bus 0000:00: root bus resource [io  0x0000-0x006f]
> [    0.277983] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7]
> [    0.277991] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
> [    0.278000] pci_bus 0000:00: root bus resource [mem 0x000a0000-
0x000bffff]
> [    0.278008] pci_bus 0000:00: root bus resource [mem 0x000c0000-
0x000dffff]
> [    0.278016] pci_bus 0000:00: root bus resource [mem 0x000e0000-
0x000fffff]
> [    0.278025] pci_bus 0000:00: root bus resource [mem 0x80000000-
0x909ffffe]
> 
> and 00:02.0 use almost all
> 
> [    0.278221] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
> [    0.278239] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff 
pref]
> 
> so we have no chance to allocate MMIO to 00:1c.0
> 

Any workaround?. 

Is the BIOS responsible for allocating memory resources in Linux?.
Perhaps changing some BIOS parameter ACPI related?.
If I change BIOS parameters I'll need a fresh install or the actual kernel 
reconigzes changes?.

