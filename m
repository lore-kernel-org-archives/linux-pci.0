Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63325 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762294AbcALObs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 09:31:48 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net,
	hanjun.guo@linaro.org, jiang.liu@linux.intel.com,
	stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI hostbridge init based on ACPI
Date: Tue, 12 Jan 2016 15:30:25 +0100
Message-ID: <4945809.OlUZI8D7JL@wuerfel>
In-Reply-To: <5693D0AE.4020306@codeaurora.org>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <20160111153949.GA2366@red-moon> <5693D0AE.4020306@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 11 January 2016 10:56:30 Sinan Kaya wrote:
> 
> #_dmesg_|_grep_resource
> [    2.945762] pci_bus 0000:00: root bus resource [io  0x0000-0xefff window] (bus address [0x1000-0xffff])
> [    3.652201] pci_bus 0002:00: root bus resource [io  0xf000-0x1dfff window] (bus address [0x1000-0xffff])
> [    6.546716] pci_bus 0006:00: root bus resource [io  0x1e000-0x2cfff window] (bus address [0x1000-0xffff])
> / #

This is bad. We normally want to stay out of the first 0x1000 bytes of the Linux space,
to prevent drivers from poking into the ISA registers.

We can have one of the buses be the "primary" bus that has its first 0x1000 bytes of
I/O space mapped into the respective Linux addresses, but mapping the second 0x1000
bytes into the reserved space is the worst possible outcome here, as legacy ISA
drivers will now poke at random other devices that are intentionally moved to
high addresses to stay of of that range.
 
> Since we are talking about what ACPI dictates vs. what kernel does. Here is something that got me 
> while testing.
> 
> Somebody sneaked in a 0x10003 upper limit on PCI addresses for some reason below. There is nothing magic
> about 0x10003 and I'm wonding why we have this limit.

I/O ports are at aligned addresses, the highest 4-byte address you can access
is 0xfffc with the default 0x10000 port limit per bus. This limit is generally
seen as sufficient because that is what x86 has. Most PCI devices have no I/O ports
at all, and the ones that have them have only a couple of bytes of address space
in it.

	Arnd
