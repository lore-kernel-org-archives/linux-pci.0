Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42236 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbG2Tdq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 15:33:46 -0400
Date: Wed, 29 Jul 2015 21:33:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Subject: Re: [PATCH v3 0/3] x86/pci/intel-mid-pci: fix to get eMMC detected
In-Reply-To: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1507292128330.3825@nanos>
References: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 29 Jul 2015, Andy Shevchenko wrote:

> On Intel Edison we have an interesting implementation of x86 platform without
> legacy PIC and with specific PCI. There are devices which are not using
> interrupt line 0, but have it assigned in the PCI configuration. By default
> first come gets it, though the first eMMC host controller is the actual user
> for IRQ0. 
> 
> So, this series provides a quirk (patch 1) to resolve the issue, a small fix of
> error code (patch 2), and a sparse warning fix (patch 3).
> 
> Changelog v3:
> - address Thomas' comments
> - massage changelog (what Thomas proposed)
> 
> Andy Shevchenko (3):
>   x86/pci/intel_mid_pci: work around for IRQ0 assignment
>   x86/pci/intel_mid_pci: propagate actual return code
>   x86/pci/intel_mid_pci: fix a sparse warning

I've picked them up. If you get the tip-bot mails, you might notice a
few edits on the changelogs. 

    - Sentence starts with an upper case letter.

    - You cannot fix a sparse warning.

    - "This patch does ...." is just horrible. When one reads a patch
      he already knows that it is a patch.

Please avoid these things in the future.

Thanks,

	tglx
