Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CDC67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDAB21476
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 22:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQH2cym4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDAB21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeJSGSq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeJSGSq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 02:18:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7D420866;
        Thu, 18 Oct 2018 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539900940;
        bh=NR+HGgysltSBVqhS0cFOctXdlc9FHGSD+bYmdF6BxT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQH2cym47C28ItijN+0LGmTjTIBFbbBooFrtod88THeKOp2jNS2SXJr4RoTG2Dlsb
         r7VkVPpjvrCCYekUwGr4LqDtk0ZUIqyuEf3k5wOsUw4dmxkj35naEgfYd/XuOL/6TU
         QZVhpzkVjzl30VJBm/vOF54M+SAnfkxSBAK9Zj3w=
Date:   Thu, 18 Oct 2018 17:15:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018183721.27467-1-gpiccoli@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> Recently was noticed in an HP GEN9 system that kdump couldn't succeed
> due to an irq storm coming from an Intel NIC, narrowed down to be lack
> of clearing the MSI/MSI-X enable bits during the kdump kernel boot.
> For that, we need an early quirk to manually turn off MSI/MSI-X for
> PCI devices - this was worked as an optional boot parameter in a
> subsequent patch.
> 
> Problem is that in our test system, the Intel NICs were not present in
> any secondary bus under the first PCIe root complex, so they couldn't
> be reached by the recursion in check_dev_quirk(). Modern systems,
> specially with multi-processors and multiple NUMA nodes expose multiple
> root complexes, describing more than one PCI hierarchy domain. Currently
> the simple recursion present in the early-quirks code from x86 starts a
> descending recursion from bus 0000:00, and reach many other busses by
> navigating this hierarchy walking through the bridges. This is not
> enough in systems with more than one root complex/host bridge, since
> the recursion won't "traverse" to other root complexes by starting
> statically in 0000:00 (for more details, see [0]).
> 
> This patch hence implements the full bus/device/function scan in
> early_quirks(), by checking all possible busses instead of using a
> recursion based on the first root bus or limiting the search scope to
> the first 32 busses (like it was done in the beginning [1]).

I don't want to expand the early quirk infrastructure unless there is
absolutely no other way to solve this.  The early quirk stuff is
x86-specific, and it's not obvious that this problem is x86-only.

This patch scans buses 0-255, but still only in domain 0, so it won't
help with even more complicated systems that use other domains.

I'm not an IRQ expert, but it seems wrong to me that we are enabling
this interrupt before we're ready for it.  The MSI should target an
IOAPIC.  Can't that IOAPIC entry be masked until later?  I guess the
kdump kernel doesn't know what MSI address the device might be using.

Could the IRQ core be more tolerant of this somehow, e.g., if it
notices incoming interrupts with no handler, could it disable the
IOAPIC entry and fall back to polling periodically until a handler is
added?

> [0] https://bugs.launchpad.net/bugs/1797990
> 
> [1] From historical perspective, early PCI scan dates back
> to BitKeeper, added by Andi Kleen's "[PATCH] APIC fixes for x86-64",
> on October/2003. It initially restricted the search to the first
> 32 busses and slots.
> 
> Due to a potential bug found in Nvidia chipsets, the scan
> was changed to run only in the first root bus: see
> commit 8659c406ade3 ("x86: only scan the root bus in early PCI quirks")
> 
> Finally, secondary busses reachable from the 1st bus were re-added back by:
> commit 850c321027c2 ("x86/quirks: Reintroduce scanning of secondary buses")
> 
> Reported-by: Dan Streetman <ddstreet@canonical.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
>  arch/x86/kernel/early-quirks.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 50d5848bf22e..fd50f9e21623 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -731,7 +731,6 @@ static int __init check_dev_quirk(int num, int slot, int func)
>  	u16 vendor;
>  	u16 device;
>  	u8 type;
> -	u8 sec;
>  	int i;
>  
>  	class = read_pci_config_16(num, slot, func, PCI_CLASS_DEVICE);
> @@ -760,11 +759,8 @@ static int __init check_dev_quirk(int num, int slot, int func)
>  	type = read_pci_config_byte(num, slot, func,
>  				    PCI_HEADER_TYPE);
>  
> -	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
> -		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
> -		if (sec > num)
> -			early_pci_scan_bus(sec);
> -	}
> +	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE)
> +		return -1;
>  
>  	if (!(type & 0x80))
>  		return -1;
> @@ -787,8 +783,11 @@ static void __init early_pci_scan_bus(int bus)
>  
>  void __init early_quirks(void)
>  {
> +	int bus;
> +
>  	if (!early_pci_allowed())
>  		return;
>  
> -	early_pci_scan_bus(0);
> +	for (bus = 0; bus < 256; bus++)
> +		early_pci_scan_bus(bus);
>  }
> -- 
> 2.19.0
> 
