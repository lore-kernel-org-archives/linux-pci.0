Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712BAC64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 06:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261292098A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 06:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHnR3rkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261292098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJDNl5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:41:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43995 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeJDNl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2018 09:41:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id p24-v6so2879632pff.10;
        Wed, 03 Oct 2018 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7v/Ja+Lq5+B4yKE1dTAlKzuYtn+OMr8F5awEI9XnsFs=;
        b=YHnR3rkPMbf5hnlbcqgP044aMQjvMyZ1ySZ03PSexi/03EOAP/sCb3pdFnf5hSEHcP
         4gJpeVKTsocnI6hjEyGW9KMc/sOJ+o/tKDJ+72nzCQjbjp+1/8Gaioyze7gAdvsd7gqU
         NuNM73u00R15u87oJAwmIDgfhVy3dKNQLGjHkf4/BEY13VPRuHu1pzGhnSn7pSDolNq8
         FUs28HNuOoAx/p88mDFRbqrYewlHVzrZ7d8Azd8tM1InuKNjpU+i0fO+UUorGo9GPYbq
         S2vRvTjQctQYcdlEifZdmXk6JlWo8tPWh6F4PgUJc+pwG79USAyz6/N6b4X81CW/un3Z
         mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7v/Ja+Lq5+B4yKE1dTAlKzuYtn+OMr8F5awEI9XnsFs=;
        b=K96pApkuJYVF6LOeYnTdvRFncgLnquasqOKMMAsJXbny9H32z7lMpMmXqbG/hns0kK
         /+SXP1Vm7hgFDKhtDkW0sLnkzGCWOte+r5lPM4Ji4nqbWJQX3mH/QcSQyPStup9beAhT
         VqvoKYS09fV6A4ewKtYnSLUaRwPAAgIGBRghFWJVvs0o/LQfDsMjsl1V0pSe64gycWEy
         dYWnlFI9auSQq8Cn2l1Tz9nxa8CaPb8vh4JFj4EG1Evh593jqKF+YR/oo8rp7Rf7UHDc
         KjovrazFfZ8UTWOH6Suyt3ty6DyY+CYXb9GzogpbhJ31vkE8ZvFjKVQsrNnn4+XbPi+u
         Nx9A==
X-Gm-Message-State: ABuFfoiaYLGpfeTtQXXaXZ0msZQCnKgKNewYgOS9jXvujj8V2l7tCgie
        bghK+mbrKltARSRWM/pxA68=
X-Google-Smtp-Source: ACcGV60suxW1JbnsBcuE75HHWH9GK8Ls3jwmVxBdvoGxK2j37GPEvNOtQN2jblI2V8SakYXDSFH1SA==
X-Received: by 2002:a63:8e43:: with SMTP id k64-v6mr4343298pge.75.1538635811982;
        Wed, 03 Oct 2018 23:50:11 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id r73-v6sm7649816pfk.157.2018.10.03.23.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 23:50:11 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 6F488160683; Wed,  3 Oct 2018 23:50:11 -0700 (PDT)
Date:   Wed, 3 Oct 2018 23:50:11 -0700
From:   Lance Roy <ldr709@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/16] x86/PCI: Replace spin_is_locked() with lockdep
Message-ID: <20181004065011.GC896@E570.localdomain>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-2-ldr709@gmail.com>
 <20181003160051.GF120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003160051.GF120535@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 03, 2018 at 11:00:51AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 02, 2018 at 10:38:47PM -0700, Lance Roy wrote:
> > lockdep_assert_held() is better suited to checking locking requirements,
> > since it won't get confused when someone else holds the lock. This is
> > also a step towards possibly removing spin_is_locked().
> >
> > Signed-off-by: Lance Roy <ldr709@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: <linux-pci@vger.kernel.org>
>
> I assume you plan to merge the whole series together.  I don't object
> to that, but I don't know enough to be able to formally ack this.
>
> It would be useful to include a tiny bit more detail in the changelog.
> The spin_is_locked() documentation doesn't mention anything about
> differences with respect to the lock being held by self vs by someone
> else, so I can't tell where the confusion arises.
The difference is that spin_is_locked() will return true when someone else holds
the lock, while lockdep_assert_held() asserts that the current thread holds the
lock. How about the following for an new changelog?

lockdep_assert_held() is better suited to checking locking requirements,
since it only checks if the current thread holds the lock regardless of
whether someone else does. This is also a step towards possibly removing
spin_is_locked().

Thanks,
Lance

> Bjorn
>
> > ---
> >  arch/x86/pci/i386.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> > index ed4ac215305d..24bb58a007de 100644
> > --- a/arch/x86/pci/i386.c
> > +++ b/arch/x86/pci/i386.c
> > @@ -59,7 +59,7 @@ static struct pcibios_fwaddrmap *pcibios_fwaddrmap_lookup(struct pci_dev *dev)
> >  {
> >  	struct pcibios_fwaddrmap *map;
> >
> > -	WARN_ON_SMP(!spin_is_locked(&pcibios_fwaddrmap_lock));
> > +	lockdep_assert_held(&pcibios_fwaddrmap_lock);
> >
> >  	list_for_each_entry(map, &pcibios_fwaddrmappings, list)
> >  		if (map->dev == dev)
> > --
> > 2.19.0
> >
