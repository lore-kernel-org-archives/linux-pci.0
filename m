Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC770C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 12:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EA4204FD
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 12:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EA4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKBV2T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:28:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBV2T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 17:28:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ABA8A78;
        Fri,  2 Nov 2018 05:21:19 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6440B3F71E;
        Fri,  2 Nov 2018 05:21:18 -0700 (PDT)
Date:   Fri, 2 Nov 2018 12:21:13 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Check for link training status in link up
 check
Message-ID: <20181102120635.GA30026@e107981-ln.cambridge.arm.com>
References: <20181031194944.19233-1-tpiepho@impinj.com>
 <20181101135530.GA8020@e107981-ln.cambridge.arm.com>
 <1541118191.30311.206.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541118191.30311.206.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 12:23:12AM +0000, Trent Piepho wrote:
> On Thu, 2018-11-01 at 13:55 +0000, Lorenzo Pieralisi wrote:
> > On Wed, Oct 31, 2018 at 07:49:59PM +0000, Trent Piepho wrote:
> > > This fixes a regression introduced in merge 562df5c8521e.
> > 
> > A merge being a commits collection, the regression was certainly
> > introduced by a specific commit in it, not the merge itself.
> 
> In this case it really is merge commit.
> 
> While the problem and fix are relatively obvious, finding how it came
> to be broken was a challenge.  Most of the commit message is my proof
> that this is a bug and not something done intentionally, by tracking
> back the complicated route that caused the code to be in its current
> state.
> 
> Basically there are two commits, on both branches of the merge, neither
> of which caused a problem nor were they incorrect in any way at the
> time they were committed.  When that merge combined this collection of
> multiple commits, it did not do so correctly and that is the point a
> bug appeared.
> 
> Or put another way, this problem was already fixed some time ago, but
> in the merge commit the fix was dropped.
> 
> It seems like the proper way to attribute my fix is to the merge, as
> that is what caused the regression.  There is no prior commit where one
> can observe the regression.

You are right, I went through git history and I agree with your
summary, that's what happened.

> > Also for the Fixes: tag and all references.
> 
> Would it be ok to refer to the commit this way the first time, then use
> a shortened method for subsequent usages?  Otherwise talking about two
> commits becomes very long.  This it what I have mostly done, other than
> the "Fixes" line.  I'm surprised checkpatch didn't catch that.

I would like to ask Bjorn's opinion on this, I do not know if adding
a Fixes: tag with a merge commit in it is common practice but that
summarizes what happened so I assume it should be fine.

As for the shortened commit format I understand your point, I do not
know if that's "official" from a kernel process standpoint.

Lorenzo
