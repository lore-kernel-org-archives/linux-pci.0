Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A1DC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 07:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB792073F
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555399414;
	bh=JBX8ZoIdLC/6sS3DUdXQ2cvwGwXFzLiJ8t41ml+ycRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WnIZ2Z4xCApl7gKCf2N/q7Cs8l7D1Hy6s9X1tfgW6CxloA4EofTZI17IJgbdH+bAI
	 Ada9+IgipiiwBAsMBbL4tiXyeroMdJk9zLMJuOjciFZYZ3gEDiKBxGOFZ70OTGmJAG
	 2NlPAUl396wEKo0VmVTXuQuosOTUawOIaeZGP6eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfDPHXd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:23:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34552 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDPHXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 03:23:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so1652273wmf.1;
        Tue, 16 Apr 2019 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrGXPuW39LplhySUkRwA1s1zOaRJ4W+2puff9jsZHPw=;
        b=TfN/eBLvOyIk4nnfKvdEdynlMYlTstXF18x5YyAhR8W6sSTporVApePoZgai+42jsg
         OGKPZcQCa+tqxa8vD+KEY4yrFYTGM2AnXlVq6Ttq0BqSOrlQrYHYAu5pjtUnjrCv0pNX
         MGjSjaSEB16eqeHNjIbVmtQNPpqqbemuBXPUJBTKDmLj9JCSicQT6V66QBz37DW08Ac0
         3o6U4KzBLHW6wlKcQ9KVI8TLtlT8P2Wqw6nF53xDwe2agINJXKkrFYbmkDIqA+dhvVwN
         fGHNIDmLEPYWIy00qCgfJ5C2xNBgnr8kM4+sJvO/y2XyfNHP83Oe24Fa4jp8lDD9WZYO
         3+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrGXPuW39LplhySUkRwA1s1zOaRJ4W+2puff9jsZHPw=;
        b=uLXYq6XsYFDdiwgdYxPo16ZCLsaOFXCwa9j6CO96hH8BGoc1OjeuHbgfK1A/IHzs6b
         Xg01Np5PSBzbiVnlGOc/4VwFqJU3kDQKfNb48oVlyHPLhdoiAw2qgqiSLfWqKgdXEZsX
         Ip36NQErFAD1HJUqylp4PvvzrQs2QfwdQdB0/HSHd2IGFnjZgzbdI+9U1JjoDrjKQcGy
         CRouLdnf45wb4HPPBrN4zzvWf3F0lr2bQu3Lzd8pAuP8YO3iqs8keo8crV3HnnQBZu87
         zrts/mQL4nVPLcyyG+bcjGEAdPotLq+S2RYiIB9sT3Owzk4BBGar4FU8Hbq68Kg1MidF
         0SjA==
X-Gm-Message-State: APjAAAW/wofcqKNC/JnlytxzjvokhmOcYe88S1RqCgD+UQfULNavSenk
        CjAdqcQq1KX841iw/+G4avxY+aPq
X-Google-Smtp-Source: APXvYqwbXwkoCdEI4xj+dXxuioxHMSXvpnurkArKKHQUiSxgRqA3JDa4m6nET8w4Cmrz/qvlRVPwVA==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr25455436wmf.77.1555399411361;
        Tue, 16 Apr 2019 00:23:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a17sm17772101wmg.40.2019.04.16.00.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:23:30 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:23:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: fix a memory leak bug
Message-ID: <20190416072327.GA127769@gmail.com>
References: <1555340058-3065-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555340058-3065-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Wenwen Wang <wang6495@umn.edu> wrote:

> In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
> found through pirq_find_routing_table(). If the table is not found and
> 'CONFIG_PCI_BIOS' is defined, the table is then allocated in
> pcibios_get_irq_routing_table() using kmalloc(). In the following
> execution, if the I/O APIC is used, this table is actually not used.
> However, in that case, the allocated table is not freed, which can lead to
> a memory leak bug.
> 
> To fix this issue, this patch frees the allocated table if it is not used.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  arch/x86/pci/irq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index 52e5510..d9bcb96 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
>  
>  void __init pcibios_irq_init(void)
>  {
> +	struct irq_routing_table *itable = NULL;
> +

Minor style nit: the canonical name of irq_routing_table local variables 
is usually 'rtable' or 'rt' - let's not add a third naming variant with 
'itable'?

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
> +		itable = pirq_table;
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
> +			kfree(itable);
>  			pirq_table = NULL;
> +		}

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
