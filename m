Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349BC32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFCC2082E
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0jreEmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFCC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeKCAEo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeKCAEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 20:04:44 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF0620657;
        Fri,  2 Nov 2018 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541170642;
        bh=MScOZBYadNf7QadirTQ08OEntC/6QTb914ZPXV521Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0jreEmbU6a64n9S256jfgKA7zwtTFhhoXJA5WMGvfRGC85PtpSa3gFoAXGVF7CDY
         EZbPF3PSkDy9Nv4HjlfqRMcL03Jb8Zg5uAdAo/SitoX6FwN8Kgv4H/BYBGxq4Yq5mh
         WXp+EeFvF28ACvdzIKoMi8TPAGo0r6Czou+EpVNk=
Date:   Fri, 2 Nov 2018 09:57:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Message-ID: <20181102145720.GA160487@google.com>
References: <20181031194944.19233-1-tpiepho@impinj.com>
 <20181101135530.GA8020@e107981-ln.cambridge.arm.com>
 <1541118191.30311.206.camel@impinj.com>
 <20181102120635.GA30026@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102120635.GA30026@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 12:21:13PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Nov 02, 2018 at 12:23:12AM +0000, Trent Piepho wrote:
> > On Thu, 2018-11-01 at 13:55 +0000, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 31, 2018 at 07:49:59PM +0000, Trent Piepho wrote:
> > > > This fixes a regression introduced in merge 562df5c8521e.
> > > 
> > > A merge being a commits collection, the regression was certainly
> > > introduced by a specific commit in it, not the merge itself.
> > 
> > In this case it really is merge commit.
> > 
> > While the problem and fix are relatively obvious, finding how it came
> > to be broken was a challenge.  Most of the commit message is my proof
> > that this is a bug and not something done intentionally, by tracking
> > back the complicated route that caused the code to be in its current
> > state.
> > 
> > Basically there are two commits, on both branches of the merge, neither
> > of which caused a problem nor were they incorrect in any way at the
> > time they were committed.  When that merge combined this collection of
> > multiple commits, it did not do so correctly and that is the point a
> > bug appeared.
> > 
> > Or put another way, this problem was already fixed some time ago, but
> > in the merge commit the fix was dropped.
> > 
> > It seems like the proper way to attribute my fix is to the merge, as
> > that is what caused the regression.  There is no prior commit where one
> > can observe the regression.
> 
> You are right, I went through git history and I agree with your
> summary, that's what happened.
> 
> > > Also for the Fixes: tag and all references.
> > 
> > Would it be ok to refer to the commit this way the first time, then use
> > a shortened method for subsequent usages?  Otherwise talking about two
> > commits becomes very long.  This it what I have mostly done, other than
> > the "Fixes" line.  I'm surprised checkpatch didn't catch that.
> 
> I would like to ask Bjorn's opinion on this, I do not know if adding
> a Fixes: tag with a merge commit in it is common practice but that
> summarizes what happened so I assume it should be fine.

That sounds good to me.

> As for the shortened commit format I understand your point, I do not
> know if that's "official" from a kernel process standpoint.

It took me a while to figure out what '886 meant because it's unusual and
the "'" usually goes where the *missing* characters are.  Personally I
would use the full 

  886bc5ceb5cc ("PCI: designware: Add generic dw_pcie_wait_for_link()")

at the first reference and just 886bc5ceb5cc for subsequent references.

Thanks for chasing this down!  It's really a hassle to figure out things
that work separately but not together.

Bjorn
