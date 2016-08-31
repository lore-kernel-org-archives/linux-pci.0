Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935292AbcHaRmk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Aug 2016 13:42:40 -0400
Message-ID: <57C716F5.1080808@redhat.com>
Date: Wed, 31 Aug 2016 13:42:13 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
CC: Paul Menzel <pmenzel@molgen.mpg.de>,
        Andi Kleen <ak@linux.intel.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Mark Haswell Power Control Unit as having non-compliant
 BARs
References: <20160831155009.3216.93787.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160831155009.3216.93787.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/31/2016 11:50 AM, Bjorn Helgaas wrote:
> The Haswell Power Control Unit has a non-PCI register (CONFIG_TDP_NOMINAL)
> where BAR 0 is supposed to be.  This is erratum HSE43 in the spec update
> referenced below:
> 
>   The PCIe* Base Specification indicates that Configuration Space Headers
>   have a base address register at offset 0x10.  Due to this erratum, the
>   Power Control Unit's CONFIG_TDP_NOMINAL CSR (Bus 1; Device 30; Function
>   3; Offset 0x10) is located where a base register is expected.
> 
> Mark the PCU as having non-compliant BARs so we don't try to probe any of
> them.  There are no other BARs on this device.
> 
> Rename the quirk so it's not Broadwell-specific.
> 
> Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=153881
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/fixup.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 837ea36..6d52b94 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -553,15 +553,21 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
>  
>  /*
> - * Broadwell EP Home Agent BARs erroneously return non-zero values when read.
> + * Device [8086:2fc0]
> + * Erratum HSE43
> + * CONFIG_TDP_NOMINAL CSR Implemented at Incorrect Offset
> + * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-spec-update.html
>   *

Bjorn,

I really think you should point at this doc:

http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v3-datasheet-vol-2.html

Section 5.4, Device 30 Function 3

which states (at the bottom of the config space diagram) "Note: The CSR located
at offset in Device 30, Function 3, Offset 0x10 is not a Configuration Space
Header and SW should not treat it as such."

as it is more informative of the issue.

I'm also slightly concerned about blacklisting the rest of the config space, but
I don't see any systems that have non-zero BARs but that's a lesser issue.

Beyond that, testing went well.

P.
