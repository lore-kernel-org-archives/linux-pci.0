Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab3DVUYt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 16:24:49 -0400
Message-ID: <1366662287.2918.459.camel@bling.home>
Subject: Re: 2013 Linux Plumbers ACPI/PM, PCI Microconference proposal call
 for participaton
From: Alex Williamson <alex.williamson@redhat.com>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Date: Mon, 22 Apr 2013 14:24:47 -0600
In-Reply-To: <CAL-B5D3mP-Eo7yzZb=ZJ_+GK5YGzKZV2p0SD05s3fXDR2BGorA@mail.gmail.com>
References: <CAL-B5D3mP-Eo7yzZb=ZJ_+GK5YGzKZV2p0SD05s3fXDR2BGorA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-04-18 at 15:52 -0600, Myron Stowe wrote:
> All:
> 
> We would like to hold a combined ACPI/PM, PCI focused microconference
> as part of this year's Linux Plumbers conference but first we need to
> show that there is enough interest and material that needs covered.
> 
> There is a lot of activity in these subsystems so please respond by
> submitting presentation or discussion proposals that you would be
> willing to cover for consideration (respond to this mail on the
> linux-pci list for tracking purposes please).  You should also feel
> free to submit ideas as proposals that others could cover.  This is
> the "Plumbers" conference so topics concerning userspace interaction
> with the kernel and not just topics concerning pure kernel subsystem
> internals would be greatly welcomed.

A few PCI discussion topics:

PCI secondary bus resets - How to avoid surprise hotplugs and/or how to
re-architect the device reset interface.

pci_is_pcie() - Not just for PCIe capabilities?  How to handle
non-compliant PCIe devices that don't expose a capability.

I/O port pci-sysfs resource files - Fix or remove?

Thanks,
Alex

