Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38480 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238AbbGHKFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jul 2015 06:05:18 -0400
Message-ID: <1436349911.10819.64.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] x86: intel-mid-pci: fix to get eMMC detected
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Date: Wed, 08 Jul 2015 13:05:11 +0300
In-Reply-To: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-17 at 22:03 +0300, Andy Shevchenko wrote:
> On Intel Edison we have a nice implementation of x86 platform without 
> legacy
> PIC and with specific PCI. There are devices which are not using 
> interrupt by
> some reasons, but have them as IRQ0 in the PCI configuration. 
> Suprisingly the
> first eMMC host controller is the actual user for IRQ0. Since we have 
> serial
> driver implemented that enumerates unused serial IP (one of four) 
> which has
> IRQ0 assigned we, in case it gets it first by pci_enable_device(), 
> lost a
> possibility to probe eMMC. 

Any comments on that?

> 
> So, this series provides a workaround (patch 2) and small fix of 
> error code
> (patch 1).
> 
> I wonder if this can go to v4.2. What do you think?
> 
> Andy Shevchenko (2):
>   x86: intel_mid_pci: propagate actual return code
>   x86: intel_mid_pci: work around for IRQ0 assignment
> 
>  arch/x86/pci/intel_mid_pci.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
