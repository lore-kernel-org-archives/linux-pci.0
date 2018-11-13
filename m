Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828120896
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E828120896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeKMURb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:17:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeKMURb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 15:17:31 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cV3JelEndFhk; Tue, 13 Nov 2018 11:20:04 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E6F81EC00CD;
        Tue, 13 Nov 2018 11:20:04 +0100 (CET)
Date:   Tue, 13 Nov 2018 11:20:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [GIT PULL] PCI changes for v4.20
Message-ID: <20181113102004.GC10502@zn.tnic>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
 <20181113071712.GA2353@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181113071712.GA2353@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 08:17:12AM +0100, Ingo Molnar wrote:
> 
> * Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > PCI changes:
> > 
> >   - Pay attention to device-specific _PXM node values (Jonathan Cameron)
> 
> There's a new boot regression, my AMD ThreadRipper system (MSI X399 SLI 
> PLUS (MS-7B09)) hangs during early bootup, and I have bisected it down to 
> this commit:
> 
>   bad7dcd94f39: ACPI/PCI: Pay attention to device-specific _PXM node values
> 
> Reverting it solves the hang.
> 
> Unfortunately there's no console output when it hangs, even with 
> earlyprintk. It just hangs after the "loading initrd" line.
> 
> Config is an Ubuntu-ish config with PROVE_LOCKING=y and a few other debug 
> options.
> 
> All my other testsystems boot fine with similar configs, so it's probably 
> something specific to this system.

Lemme add Tom, he might have an idea.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
