Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC7C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4872087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfC0LVA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:21:00 -0400
Received: from foss.arm.com ([217.140.101.70]:52884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0LVA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 07:21:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73B24A78;
        Wed, 27 Mar 2019 04:20:59 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33E8F3F557;
        Wed, 27 Mar 2019 04:20:57 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:20:52 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        vaerov@amazon.com, benh@kernel.crashing.org, alisaidi@amazon.com,
        zeev@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: al: Add Amazon Annapurna Labs PCIe host
 controller driver
Message-ID: <20190327112052.GA8331@e107981-ln.cambridge.arm.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <1553594455-30436-1-git-send-email-jonnyc@amazon.com>
 <20190326121727.GA4171@e107981-ln.cambridge.arm.com>
 <07838dad0e0cdb14c42080ef19c11829f72c8814.camel@infradead.org>
 <20190326155837.GA8820@e107981-ln.cambridge.arm.com>
 <d02a76ff37dc2db153c7b9c4d00a0399f9ac1b47.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02a76ff37dc2db153c7b9c4d00a0399f9ac1b47.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 27, 2019 at 09:52:15AM +0000, David Woodhouse wrote:
> On Tue, 2019-03-26 at 15:58 +0000, Lorenzo Pieralisi wrote:
> > > We did that internally. You really don't want me telling engineers to
> > > post to the list *first* without running things by me to get the basics
> > > right. Not to start with, at least.
> > 
> > Hi David,
> > 
> > I am obviously in favour of internal review and I do not question it was
> > carried out internally, I just kindly ask developers to drop review tags
> > given internally when going to public mailing lists - I understand it is
> > churn for you but I prefer them to be given explicitly.
> 
> Sure, I've provided mine in public now.
> 
> I will attempt to remember your preference, although I'm not sure I
> think it's necessary.
> 
> What's the failure mode we're protecting against here? That my
> engineers are lying and have *faked* my reviewed-by tag?
> 
> Don't you think I'd *eat* them if I ever found that happening?

As I wrote above, I did not question the internal review process at all,
we do internal review at ARM too in preparation for posting publicly but
I think the patches review should take place on public mailing lists and
tags should be given accordingly, that's it.

You may see it as churn, fair enough, it is not a big deal either.

> What's next? That you only accept such tags in signed email, so that
> the dishonest engineer in question can't *fake* an email from me to the
> list? They know I'm afflicted by Exchange so they can always send that
> fake message with a message-id matching another message they know is
> already in my inbox, so Exchange will helpfully discard theirs. :)

There is nothing next :) - I just would like to see patches discussions
and reviews taking place on linux-pci@vger.kernel.org for PCI patches,
I do not think I am asking too much.

Thanks,
Lorenzo
