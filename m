Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F3C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F792243E
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrmTryQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F792243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeKNUXr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:23:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37333 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKNUXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 15:23:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so14136845wmc.2;
        Wed, 14 Nov 2018 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dGVNalAlUla5dwr9j7vWc9GqcmFVNI56HiRwYDboDkY=;
        b=FrmTryQ01XcAdb+CxfNru0yCA/gGQ1nOF67dlrybp37xg2EDgC/5TNJnCUpO8SvYi3
         7ZoF7PgCUoKJel9+Uq5RAHGWeqB7vnJI0/N+gM/niempPBwDsVMo7OedvUfQ28sfZpEv
         7SigffQMoEGw0H6/jmPvSofTViYmvvzd+npEZZgMd0eLtRfqNS8VYj8+MCMs8W8isWxb
         oBfOfvq6Wve9QdCBPuQT16zJf47GWa/oJuP2IjBzMAiSeBLPp86NGX3yzA4QWgEZ2GkO
         Ea7mTkcjqjQeBI2SfUS21sveGQbMa0TMW5cOdvxcYAXUPH8bxTydOFeJhfw0DA0CZD9N
         GB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGVNalAlUla5dwr9j7vWc9GqcmFVNI56HiRwYDboDkY=;
        b=hR/lLzCMWi9GsTfixjK9xfGZsOdFxuat2zfqoAXG5vwZ7IuVqLGuTCqX6p4/brNpuH
         KluKmLg0XHua9L5PB9KMDLhIHs5nyQP1EgtgwYQVI46MDugASO+AdSz7R0CONqyekGQ8
         IdWB02kx8jh2mwXFu1Fwl8ewUVZmXqunV8a+P49/JJzQ8X1uegmHcyYhhPKG/A0N3fNx
         VuVAKExg34HpdUuZNenWK8wggUfYL+51tzvLX3UBszY2M3IeO0YVyYX9pIGf2kyNrPUs
         13N4PGEDylSKcLinTEdLcUHNOcZVrQOBp6/zQ6KQyQJrDqD69fTUsu7UrSZDwHnOYnxF
         eiNQ==
X-Gm-Message-State: AGRZ1gLECedFRh3cwNFDCnWC/4koCfbIFrv30EP46YUbRG3/ulaLq2ot
        M/FTTw5LYx8RujAvaNrwdeI=
X-Google-Smtp-Source: AJdET5f+QT7zdH5M2y2hsMFKK0v6Twifd1Lmjd3LEjBry3v91c7Wt9x5Dp8ms/HTlnKCIkTGsbs/Mw==
X-Received: by 2002:a1c:8a91:: with SMTP id m139-v6mr1329144wmd.27.1542190867746;
        Wed, 14 Nov 2018 02:21:07 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f68sm7603536wmd.15.2018.11.14.02.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 02:21:07 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:21:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [GIT PULL] PCI changes for v4.20
Message-ID: <20181114102104.GA57814@gmail.com>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
 <20181113071712.GA2353@gmail.com>
 <20181113102004.GC10502@zn.tnic>
 <20181113144746.GA69034@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113144746.GA69034@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Martin, Rafael, Len, linux-acpi]
> 
> On Tue, Nov 13, 2018 at 11:20:04AM +0100, Borislav Petkov wrote:
> > On Tue, Nov 13, 2018 at 08:17:12AM +0100, Ingo Molnar wrote:
> > > 
> > > * Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > 
> > > > PCI changes:
> > > > 
> > > >   - Pay attention to device-specific _PXM node values (Jonathan Cameron)
> > > 
> > > There's a new boot regression, my AMD ThreadRipper system (MSI X399 SLI 
> > > PLUS (MS-7B09)) hangs during early bootup, and I have bisected it down to 
> > > this commit:
> > > 
> > >   bad7dcd94f39: ACPI/PCI: Pay attention to device-specific _PXM node values
> > > 
> > > Reverting it solves the hang.
> > > 
> > > Unfortunately there's no console output when it hangs, even with 
> > > earlyprintk. It just hangs after the "loading initrd" line.
> > > 
> > > Config is an Ubuntu-ish config with PROVE_LOCKING=y and a few other debug 
> > > options.
> > > 
> > > All my other testsystems boot fine with similar configs, so it's probably 
> > > something specific to this system.
> 
> Martin reported the same thing [1] (unfortunately the archive didn't
> capture Martin's original emails, I think because they were multi-part
> messages with attachments).
> 
> Looks like Martin might have a similar system:
> 
>   DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Taichi, BIOS P3.30 08/14/2018
>   smpboot: CPU0: AMD Ryzen Threadripper 2950X 16-Core Processor (family: 0x17, model: 0x8, stepping: 0x2)
> 
> Given how painful this is to debug, I queued up a revert on my
> for-linus branch until we figure out what sanity checks are needed to
> make the original patch safe.

Thanks!

Took me about a day to bisect this, on this hard to bisect machine. :-/

> I would expect proximity information to be basically just a hint for 
> optimization, not a functional requirement, so it would be really 
> interesting to figure out why this causes such a catastrophic failure. 
> Maybe there's a way to improve that path as well so it would be more 
> robust or at least more debuggable.

Yeah.

Thanks,

	Ingo
