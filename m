Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:60012 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933500AbbBBUm7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 15:42:59 -0500
Received: by mail-oi0-f42.google.com with SMTP id i138so45935501oig.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 12:42:58 -0800 (PST)
Date: Mon, 2 Feb 2015 14:42:53 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
	lorenzo.pieralisi@arm.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH 0/6] PCI: MMCONFIG clean up
Message-ID: <20150202204253.GB5176@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 19, 2014 at 05:04:45PM +0100, Tomasz Nowicki wrote:
> MMCFG ACPI table has no arch dependencies so it can be used across all
> architectures. Currently MMCONFIG related code resides in arch/x86 directories.
> This patch set is goint to isolate non-architecure specific code and make
> it accessible from drivers/pci/ directory.
> 
> Tomasz Nowicki (6):
>   x86, acpi, pci: Reorder logic of pci_mmconfig_insert() function
>   x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/
>     directory
>   x86, acpi, pci: Move PCI config space accessors.
>   x86, acpi, pci: mmconfig_{32,64}.c code refactoring - remove code
>     duplication.
>   x86, acpi, pci: mmconfig_64.c becomes default implementation for arch
>     agnostic low-level direct PCI config space accessors via MMCONFIG.
>   pci, acpi: Share ACPI PCI config space accessors.

Hi Tomasz,

I'm just checking to make sure we aren't deadlocked here, with me waiting
for you and you waiting for me.  I gave you some comments about
abbreviations (MCFG/MMCFG/MMCONFIG/ECAM), weak functions, code placement
(drivers/acpi vs. drivers/pci), and the mmio_config_*() naming, so I've
been waiting to continue those discussions.  But maybe you're waiting for
me, too?

I think this sort of cleanup is a great idea and I hope we can make some
progress on it.  If it's easier to do it in small pieces, e.g., starting
out by moving code and renaming things with no functional changes, that
would be great with me.

Bjorn
