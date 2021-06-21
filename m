Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40043C48BE5
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jun 2021 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A4861151
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jun 2021 09:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFUJti (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:49:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFUJt2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 05:49:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E3771FB;
        Mon, 21 Jun 2021 02:47:14 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932403F718;
        Mon, 21 Jun 2021 02:47:12 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:47:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: aardvark: Fix kernel panic during PIO
 transfer
Message-ID: <20210621094706.GA26022@lpieralisi>
References: <162322862108.3345.4160808336030929680.b4-ty@arm.com>
 <20210617201523.GA3104553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617201523.GA3104553@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 17, 2021 at 03:15:23PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 09, 2021 at 09:50:39AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, 8 Jun 2021 22:36:55 +0200, Pali Roh�r wrote:
> > > Trying to start a new PIO transfer by writing value 0 in PIO_START register
> > > when previous transfer has not yet completed (which is indicated by value 1
> > > in PIO_START) causes an External Abort on CPU, which results in kernel
> > > panic:
> > > 
> > >     SError Interrupt on CPU0, code 0xbf000002 -- SError
> > >     Kernel panic - not syncing: Asynchronous SError Interrupt
> > > 
> > > [...]
> > 
> > Applied to pci/aardvark, thanks!
> > 
> > [1/1] PCI: aardvark: Fix kernel panic during PIO transfer
> >       https://git.kernel.org/lpieralisi/pci/c/f77378171b
> 
> Since this fixes a panic and only affects aardvark, I cherry picked
> this to my for-linus branch.
> 
> Can you drop it, Lorenzo?  It's currently the only thing on your
> pci/aardvark branch, so I just dropped that whole branch from -next.

I have dropped the branch from my tree as well as requested.

Thanks,
Lorenzo
