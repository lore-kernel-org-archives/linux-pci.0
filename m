Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE7C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A92183E
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555533317;
	bh=Us4Mh7NyDCpZ8PIITSv+u78YLzC6mwrmxrBVkQ4WdS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Aj/Ze4JgbgxICxmmO1F/qkfgKYjY2LrQykLx/AVOMW6tH140Eb13V9SxiVimJNYt7
	 ze2dPUZMZIOOqssysOSWIRVsdzES88GlcVpUR5V1r0Hd4pxK9UfPAx97/bZKX/3cot
	 FAXEY3MT1QWFZlk6Fyh39oLficjCYI03vldALzPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfDQUfQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQUfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 16:35:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B91B217F4;
        Wed, 17 Apr 2019 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555533315;
        bh=Us4Mh7NyDCpZ8PIITSv+u78YLzC6mwrmxrBVkQ4WdS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02FwyfrZnnCqceCZcyg0aTSI1q6tBoMZKA6mviL57ryyHUJ/R29KCxM9DG5cgT3YE
         aCZVqqTtqKfWH49R8b28XsXEH1pXOMwqeRXCRTbS1z9nMq4d2Xg5+4iku2MGJ4TqzV
         kCLxr4oVKT2OU7Qs/8yvVmdrL6OOOXzGNnEScfvw=
Date:   Wed, 17 Apr 2019 15:35:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/PCI: fix a memory leak bug
Message-ID: <20190417203514.GT126710@google.com>
References: <1555510730-9060-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555510730-9060-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 09:18:50AM -0500, Wenwen Wang wrote:
> In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> found through pirq_find_routing_table(). If the table is not found and
> 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> pcibios_get_irq_routing_table() using kmalloc(). In the following
> execution, if the I/O APIC is used, this table is actually not used.
> However, in that case, the allocated table is not freed, which is a memory
> leak bug.
> 
> To fix this issue, free the allocated table if it is not used.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

I added Ingo's reviewed-by (since the only change from v1 was to make the
local variable name change he suggested) and applied this to pci/misc for
v5.2, thanks!

> ---
>  arch/x86/pci/irq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index 52e5510..d3a73f9 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
>  
>  void __init pcibios_irq_init(void)
>  {
> +	struct irq_routing_table *rtable = NULL;
> +
>  	DBG(KERN_DEBUG "PCI: IRQ init\n");
>  
>  	if (raw_pci_ops == NULL)
> @@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
>  	pirq_table = pirq_find_routing_table();
>  
>  #ifdef CONFIG_PCI_BIOS
> -	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
> +	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
>  		pirq_table = pcibios_get_irq_routing_table();
> +		rtable = pirq_table;
> +	}
>  #endif
>  	if (pirq_table) {
>  		pirq_peer_trick();
> @@ -1145,8 +1149,10 @@ void __init pcibios_irq_init(void)
>  		 * If we're using the I/O APIC, avoid using the PCI IRQ
>  		 * routing table
>  		 */
> -		if (io_apic_assign_pci_irqs)
> +		if (io_apic_assign_pci_irqs) {
> +			kfree(rtable);
>  			pirq_table = NULL;
> +		}
>  	}
>  
>  	x86_init.pci.fixup_irqs();
> -- 
> 2.7.4
> 
