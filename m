Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99FC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 04:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6F2077B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 04:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siojCPH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfCUE5u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:57:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46750 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfCUE5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 00:57:50 -0400
Received: by mail-io1-f65.google.com with SMTP id b9so4188651iot.13;
        Wed, 20 Mar 2019 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dyLsgRjy52GT6zOA+aLJRUshJeDc3eyQetzOoKEFkc=;
        b=siojCPH1RG6sCukAfkZk2VjfJF+9XBYR34fEZ5mmaWuNRrN9YBmk+pQzk9PH+2JblD
         Lmn12S29Ec8LWfYdkHI9mo3dKPoFjqpakChfNHHFVNw4lq0GNCcRG91z3hKClpEhIhI2
         GLM5F7sEoTSGYtnxJRCn3O+xT12mlXKy9xmV0yzU0stTrecBBK0aUjfdgh4pkIBWnCSF
         Rx56AjrmXSEhVx57HG4qxjHkIxXFK7B/rWT427+jWHjYzMx6Fk/A396QJ6uDEeSjUmbz
         nco1JOMfwEOj+VYqww2J5xu8T5UICNQCFhSaFmssY5DmBYsWzBA9qno+zs7NuaeI1aSx
         LO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dyLsgRjy52GT6zOA+aLJRUshJeDc3eyQetzOoKEFkc=;
        b=kF7BcHAKy170ivcUGSY7X2cFU8TemvynkEZyF6wSGkR4zqdCJumpp7YHzbbkfvon2i
         sxvwZlEntu+cvqW43qtHYgNavDPqvFRC7944ypAPTw2ViC5ixCObqY/rtcyZNH4MAztV
         hn83T/G25P+whQQwosPd5bUImSZVjAbhptfaGARv+TNY8QX1/NZpHstprN+bWAo2mRLA
         ZU7Ckj8gT3yyyfw10p7s/p29RPHDCkHIARBEbUbhFvu3bgqW3m2Wu1pMrBLMfWtjsSod
         LYayrtoXIZfAe8dCtjoR+FwYUnLo0/2repFHYerS15H7HZfemZfSbINanZSI0LNjPGt/
         RF9w==
X-Gm-Message-State: APjAAAXRA7O9TbmOlCCo4Yj/VHwyWQwPH+hCx2wYnMTyBKPKP+vwbkV0
        iFQUrsGYNtn8F+Ay8HNqnzq+qh3g3WNkQl0IG88=
X-Google-Smtp-Source: APXvYqysPOoVymEmDIJkeTCu5EOAxrkkxA/slINgH6zE9mD1kpvqjNEjJiKTStjYu4l0yvNtQmzIA6XTnc5gWyQQJd8=
X-Received: by 2002:a6b:e305:: with SMTP id u5mr1342124ioc.262.1553144268944;
 Wed, 20 Mar 2019 21:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190222194808.15962-1-mr.nuke.me@gmail.com> <20190320205233.GE251185@google.com>
 <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com> <156dec38-438d-1ce9-64fa-af95d37c14bd@gmail.com>
In-Reply-To: <156dec38-438d-1ce9-64fa-af95d37c14bd@gmail.com>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 21 Mar 2019 15:57:37 +1100
Message-ID: <CAOSf1CHpoO-1zbT75A+DtHZ5nE3xdaMYDr9kVRpJY=EuJHk9EQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>, austin_bolen@dell.com,
        Alex Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Shyam_Iyer@dell.com,
        Lukas Wunner <lukas@wunner.de>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 21, 2019 at 12:27 PM Alex G <mr.nuke.me@gmail.com> wrote:
>
> On 3/20/19 4:44 PM, Linus Torvalds wrote:
> > On Wed, Mar 20, 2019 at 1:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> AFAICT, the consensus there was that it would be better to find some
> >> sort of platform solution instead of dealing with it in individual
> >> drivers.  The PCI core isn't really a driver, but I think the same
> >> argument applies to it: if we had a better way to recover from readl()
> >> errors, that way would work equally well in nvme-pci and the PCI core.
> >
> > I think that patches with the pattern "if (disconnected) don't do IO"
> > are fundamentally broken and we should look for alternatives in all
> > cases.
> >
> > They are fundamentally broken because they are racy: if it's an actual
> > sudden disconnect in the middle of IO, there's no guarantee that we'll
> > even be notified in time.
> >
> > They are fundamentally broken because they add new magic special cases
> > that very few people will ever test, and the people who do test them
> > tend to do so with old irrelevant kernels.
> >
> > Finally, they are fundamentally broken because they always end up
> > being just special cases. One or two special case accesses in a
> > driver, or perhaps all accesses of a particular type in just _one_
> > special driver.
> >
> > Yes, yes, I realize that people want error reporting, and that
> > hot-removal can cause various error conditions (perhaps just parity
> > errors for the IO, but also perhaps other random errors caused by
> > firmware perhaps doing special HW setup).
> >
> > But the "you get a fatal interrupt, so avoid the IO" kind of model is
> > completely broken, and needs to just be fixed differently. See above
> > why it's so completely broken.
> >
> > So if the hw is set up to send some kinf of synchronous interrupt or
> > machine check that cannot sanely be handled (perhaps because it will
> > just repeat forever), we should try to just disable said thing.
> >
> > PCIe allows for just polling for errors on the bridges, afaik. It's
> > been years since I looked at it, and maybe I'm wrong. And I bet there
> > are various "platform-specific value add" registers etc that may need
> > tweaking outside of any standard spec for PCIe error reporting. But
> > let's do that in a platform driver, to set up the platform to not do
> > the silly "I'm just going to die if I see an error" thing.
> >
> > It's way better to have a model where you poll each bridge once a
> > minute (or one an hour) and let people know "guys, your hardware
> > reports errors", than make random crappy changes to random drivers
> > because the hardware was set up to die on said errors.
> >
> > And if some MIS person wants the "hardware will die" setting, then
> > they can damn well have that, and then it's not out problem, but it
> > also means that we don't start changing random drivers for that insane
> > setting. It's dead, Jim, and it was the users choice.
> >
> > Notice how in neither case does it make sense to try to do some "if
> > (disconnected) dont_do_io()" model for the drivers.
>
> I disagree with the idea of doing something you know can cause an error
> to propagate. That being said, in this particular case we have come to
> rely a little too much on the if (disconnected) model.

My main gripe with the if (disconnected) model is that it's only
really good for inactive devices. If a device is being used then odds
are the driver will do an MMIO before the pci core has had a chance to
mark the device as broken so you crash anyway.

> You mentioned in the other thread that fixing the GHES driver will pay
> much higher dividends. I'm working on reviving a couple of changes to do
> just that. Some industry folk were very concerned about the "don't
> panic()" approach, and I want to make sure I fairly present their
> arguments in the cover letter.
>
> I'm hoping one day we'll have the ability to use page tables to prevent
> the situations that we're trying to fix today in less than ideal ways.
> Although there are other places in msi.c that use if (disconnected), I'm
> okay with dropping this change -- provided we come up with an equivalent
> fix.

What's the idea there? Scan the ioremap space for mappings over the
device BARs and swap them with a normal memory page?

> But even if FFS doesn't crash, do we really want to lose hundreds of
> milliseconds to SMM --on all cores-- when all it takes is a couple of
> cycles to check a flag?

Using pci_dev_is_disconnected() to opportunistically avoid waiting for
MMIO timeouts is fair enough IMO, even if it's a bit ugly. It would
help your case if you did some measurements to show the improvement
and look for other cases it might help. It might also be a good idea
to document when it is appropriate to use pci_is_dev_disconnected() so
we aren't stuck having the same argument again and again, but that's
probably a job for Bjorn though.

Oliver
