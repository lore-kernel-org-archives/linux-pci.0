Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37800 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbHDXA7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 19:00:59 -0400
Received: by igbpg9 with SMTP id pg9so21711901igb.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 16:00:59 -0700 (PDT)
Date: Tue, 4 Aug 2015 18:00:50 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 0/9] ARM: PCI: kill pcibios_msi_controller()
Message-ID: <20150804230050.GE17327@google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 04, 2015 at 04:53:48PM -0500, Bjorn Helgaas wrote:
> The first 5 patches here are essentially the same as Lorenzo's v4 posting
> at
> http://lkml.kernel.org/1438169598-24490-1-git-send-email-lorenzo.pieralisi@arm.com
> 
> I added some at the end to fix what look like some X-Gene bugs to me, and
> to make X-Gene use pci_scan_root_bus_msi() like the other drivers that use
> msi_controller.
> 
> v4->v5 changes:
> - Declare pci_scan_root_bus_msi() in drivers/pci/pci.h instead of
>   include/linux/pci.h.  I like the idea, but I hope we can replace this and
>   other "scan_root_bus" interfaces with a single, more-generic interface,
>   so I'd rather not expose this one widely.

This is one thing I screwed up already.  pci_scan_root_bus_msi() can't be
declared in drivers/pci/pci.h because that's not visible to
arch/arm/kernel/bios32.c.

In case anybody wants to try it, I updated the branch here:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration
