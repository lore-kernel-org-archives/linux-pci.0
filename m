Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C4C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F89223D0
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDYU1TXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F89223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeKNAqP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387892AbeKNAqP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:15 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BD8223C8;
        Tue, 13 Nov 2018 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542120466;
        bh=G/SQTqC0KrL2++i5H59g/QIk1eK7oFtlXMI/deBiCFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDYU1TXEyhpSm8ow2r10wDZjMs5xaa0ct5oVE5LyR6/FuquJ3U9eWsanRRFrRi5+z
         6ezXFFJjKso2GdfuC7bQGVIXh01/380hS6CFtLYkY9oeU3HIEpKMquV0xBOcXp/hOO
         sQ9yy1LX/2lHaI/bj/8QAHCJrx7R5COvLV44DC/Q=
Date:   Tue, 13 Nov 2018 08:47:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20181113144746.GA69034@google.com>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
 <20181113071712.GA2353@gmail.com>
 <20181113102004.GC10502@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113102004.GC10502@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Martin, Rafael, Len, linux-acpi]

On Tue, Nov 13, 2018 at 11:20:04AM +0100, Borislav Petkov wrote:
> On Tue, Nov 13, 2018 at 08:17:12AM +0100, Ingo Molnar wrote:
> > 
> > * Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > PCI changes:
> > > 
> > >   - Pay attention to device-specific _PXM node values (Jonathan Cameron)
> > 
> > There's a new boot regression, my AMD ThreadRipper system (MSI X399 SLI 
> > PLUS (MS-7B09)) hangs during early bootup, and I have bisected it down to 
> > this commit:
> > 
> >   bad7dcd94f39: ACPI/PCI: Pay attention to device-specific _PXM node values
> > 
> > Reverting it solves the hang.
> > 
> > Unfortunately there's no console output when it hangs, even with 
> > earlyprintk. It just hangs after the "loading initrd" line.
> > 
> > Config is an Ubuntu-ish config with PROVE_LOCKING=y and a few other debug 
> > options.
> > 
> > All my other testsystems boot fine with similar configs, so it's probably 
> > something specific to this system.

Martin reported the same thing [1] (unfortunately the archive didn't
capture Martin's original emails, I think because they were multi-part
messages with attachments).

Looks like Martin might have a similar system:

  DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Taichi, BIOS P3.30 08/14/2018
  smpboot: CPU0: AMD Ryzen Threadripper 2950X 16-Core Processor (family: 0x17, model: 0x8, stepping: 0x2)

Given how painful this is to debug, I queued up a revert on my
for-linus branch until we figure out what sanity checks are needed to
make the original patch safe.

I would expect proximity information to be basically just a hint for
optimization, not a functional requirement, so it would be really
interesting to figure out why this causes such a catastrophic failure.
Maybe there's a way to improve that path as well so it would be more
robust or at least more debuggable.

Bjorn

[1] https://lore.kernel.org/linux-pci/20180912152140.3676-2-Jonathan.Cameron@huawei.com
