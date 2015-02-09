Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vserver.eikelenboom.it ([84.200.39.61]:45504 "EHLO
	smtp.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198AbbBIMRl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 07:17:41 -0500
Date: Mon, 9 Feb 2015 13:17:35 +0100
From: Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <1655784801.20150209131735@eikelenboom.it>
To: Stefan Bader <stefan.bader@canonical.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
In-Reply-To: <54D8823F.9080900@canonical.com>
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Monday, February 9, 2015, 10:47:43 AM, you wrote:

> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>> 
>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>> 
>>> Hi Thomas,
>>>         This patch set includes three hotfixes related Xen IRQ for v3.19.
>>> Sorry for the long delay to get these two regressions fixed, it really
>>> cost me some time to read and understand Xen IRQ code.
>> 
>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
>>> too once it reaches the mainstream kernel.
>> 
>>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).
>>> It's a temporary solution, I will send the formal fix for v3.20 and
>>> it has passed tests too.
>> 
>>> Patch 3 fixes an issue found when reading code. There's no real bug
>>> reports related to this issue yet.
>> 
>>> Great thanks to Konrad and Sander for testing fixes for these regressions.
>> 
>>> Regards,
>>> Gerry
>> 
>> Hi Gerry,
>> 
>> Since these patches now are: tested, reviewed and have landed into mainline,
>> could you also provide the backports for 3.17 and 3.18 where required ?

> This would be my attempt of backporting those to 3.18 (I have not tried whether
> they would apply to 3.17 as well). Those seem to work when test-booting and
> Sander said he will give them a try as well. But better check yourself I did not
> mess anything up while backporting. One of the three patches seemed not to be
> required at all.

> -Stefan

Hi Stefan / Gerry,

Happy to inform you i have tested stefan's backport-patches on Intel and AMD:

- Patches apply cleanly to kernel's 3.18.6 and 3.17.8 and compile.
  (hmm, 3.17 seems to be already EOL according to www.kernel.org ?)
- Fixes the subtle issues i had.

So .. Tested-by: Sander Eikelenboom <linux@eikelenboom.it>

Thanks !

--
Sander

>> 
>> The number of people running into these (subtle) issues with these stable
>> kernels seems to be steadily increasing.
>> 
>> --
>> Sander
>> 
>>> Jiang Liu (3):
>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>     cffe0a2b5a34
>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_gsi
>> 
>>>  arch/x86/include/asm/acpi.h |    1 +
>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>  arch/x86/pci/xen.c          |   49 ++-----------------------------------------
>>>  drivers/acpi/pci_irq.c      |    1 -
>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>> 
>> 


