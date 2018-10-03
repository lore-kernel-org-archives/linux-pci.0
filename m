Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A14C64EB8
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421BB21473
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vwmz/wg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421BB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJCWtx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeJCWtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 18:49:52 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15972089F;
        Wed,  3 Oct 2018 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538582453;
        bh=CDuJLaorSungbZRfLtKY71JC7+5e1F9M4ZS1KNsJd98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwmz/wg9tM2twKiBCs/z/lTP+xnqdTtH5fIv8jymuGsQkUNKXfvMleWrMDKxBKsG9
         r9FQY1/gMMOhMCfasIs2MmMOQ9TzKtpZc52INpQOmE8H2J4yqTSqDKS5S1vDmMFC9T
         ZzWZSamlHmDwzT83wUIQlZzOZKJHkrfCUvn68tuo=
Date:   Wed, 3 Oct 2018 11:00:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lance Roy <ldr709@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/16] x86/PCI: Replace spin_is_locked() with lockdep
Message-ID: <20181003160051.GF120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-2-ldr709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003053902.6910-2-ldr709@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 02, 2018 at 10:38:47PM -0700, Lance Roy wrote:
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <linux-pci@vger.kernel.org>

I assume you plan to merge the whole series together.  I don't object
to that, but I don't know enough to be able to formally ack this.

It would be useful to include a tiny bit more detail in the changelog.
The spin_is_locked() documentation doesn't mention anything about
differences with respect to the lock being held by self vs by someone
else, so I can't tell where the confusion arises.

Bjorn

> ---
>  arch/x86/pci/i386.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index ed4ac215305d..24bb58a007de 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -59,7 +59,7 @@ static struct pcibios_fwaddrmap *pcibios_fwaddrmap_lookup(struct pci_dev *dev)
>  {
>  	struct pcibios_fwaddrmap *map;
>  
> -	WARN_ON_SMP(!spin_is_locked(&pcibios_fwaddrmap_lock));
> +	lockdep_assert_held(&pcibios_fwaddrmap_lock);
>  
>  	list_for_each_entry(map, &pcibios_fwaddrmappings, list)
>  		if (map->dev == dev)
> -- 
> 2.19.0
> 
