Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vserver.eikelenboom.it ([84.200.39.61]:39443 "EHLO
	smtp.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbbBEUIJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Feb 2015 15:08:09 -0500
Date: Thu, 5 Feb 2015 21:07:57 +0100
From: Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <1369609199.20150205210757@eikelenboom.it>
To: Jiang Liu <jiang.liu@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Stefan Bader <stefan@krikkit.de>
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
In-Reply-To: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com>
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Tuesday, January 20, 2015, 3:21:04 AM, you wrote:

> Hi Thomas,
>         This patch set includes three hotfixes related Xen IRQ for v3.19.
> Sorry for the long delay to get these two regressions fixed, it really
> cost me some time to read and understand Xen IRQ code.

> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
> too once it reaches the mainstream kernel.

> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).
> It's a temporary solution, I will send the formal fix for v3.20 and
> it has passed tests too.

> Patch 3 fixes an issue found when reading code. There's no real bug
> reports related to this issue yet.

> Great thanks to Konrad and Sander for testing fixes for these regressions.

> Regards,
> Gerry

Hi Gerry,

Since these patches now are: tested, reviewed and have landed into mainline,
could you also provide the backports for 3.17 and 3.18 where required ?

The number of people running into these (subtle) issues with these stable
kernels seems to be steadily increasing.

--
Sander

> Jiang Liu (3):
>   xen/pci: Kill function xen_setup_acpi_sci()
>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>     cffe0a2b5a34
>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_gsi

>  arch/x86/include/asm/acpi.h |    1 +
>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>  arch/x86/pci/xen.c          |   49 ++-----------------------------------------
>  drivers/acpi/pci_irq.c      |    1 -
>  4 files changed, 16 insertions(+), 61 deletions(-)


