Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41086 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbcJGVAO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 17:00:14 -0400
Message-ID: <1475873741.11323.325.camel@linux.intel.com>
Subject: Re: [PATCH 0/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org
Date: Fri, 07 Oct 2016 23:55:41 +0300
In-Reply-To: <cover.1475733022.git.lukas@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> Somehow it went completely under my radar that v4.8 added another
> struct pci_platform_pm_ops for Intel Mobile Internet Devices.
> 
> There's a commit queued for v4.9 on Bjorn's pci/pm branch which adds
> a mandatory ->get_power hook to pci_platform_pm_ops and implements
> it for acpi_pci_platform_pm, but not mid_pci_platform_pm.
> 
> The following patch fixes that.  It's not a build issue, the missing
> hook in mid_pci_platform_pm only becomes a problem at runtime.
> 
> @Andy: Could you look over this and provide an ack?  I do not have
> an Intel MID so I was only able to compile-test the patch.

Without this I got nothing but constant reboot.

Acked-and-tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nevertheless please address my comments.

> The ->get_power hook is currently only called to update a device's
> current_state after resume (both at runtime and after system sleep)
> and after changing its power state using the platform in
> pci_platform_power_transition().  The result of the ->get_power hook
> is ignored unless it's D3cold.  Since intel-mid PCI devices can only
> be suspended to D3hot,

Strictly speaking platform supports it, but we don't use these feature.

>  the return value is irrelevant on this platform,
> the hook just needs to be present to make pci_set_platform_pm() happy.
> 
> If you want to test the patch, you need to apply it either on Bjorn's
> pci/pm branch or linux-next:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci
> /pm

I'm using linux-next.


> 
> Thanks,
> 
> Lukas
> 
> Lukas Wunner (1):
>   x86/platform/intel-mid: Retrofit pci_platform_pm_ops ->get_power
> hook
> 
>  arch/x86/include/asm/intel-mid.h  |  1 +
>  arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
>  drivers/pci/pci-mid.c             |  6 ++++++
>  3 files changed, 26 insertions(+)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
