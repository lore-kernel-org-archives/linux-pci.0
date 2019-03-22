Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B924DC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D1F2083D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbfCVMSb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:31 -0400
Received: from foss.arm.com ([217.140.101.70]:43144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390514AbfCVMSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CDF5374;
        Fri, 22 Mar 2019 05:18:30 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CF863F614;
        Fri, 22 Mar 2019 05:18:28 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:18:22 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20190322121822.GA26257@e107981-ln.cambridge.arm.com>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
 <95d1076c-5490-3803-f394-9a0928c2cccb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d1076c-5490-3803-f394-9a0928c2cccb@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 22, 2019 at 01:09:13PM +0100, Marek Vasut wrote:
> On 3/22/19 12:31 PM, Lorenzo Pieralisi wrote:
> > On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> >> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >>
> >> Reestablish the PCIe link very early in the resume process in case it
> >> went down to prevent PCI accesses from hanging the bus. Such accesses
> > 
> > Hi Marek, Kazufumi,
> 
> Hi,
> 
> > Apologies for the delay.
> > 
> > Just as a clarification, when you state "in case it went down" isn't
> > this supposed to happen for every suspend cycle ? Let me know and I
> > will add a comment to the patch commit log.
> 
> It does happen on every suspend/resume cycle and if you manually put a
> remote endpoint into non-L0 state.

Ok I will update the log then.

> >> can happen early in the PCI resume process, in the resume_noirq, thus
> >> the link must be reestablished in the resume_noirq callback of the
> >> driver.
> >>
> >> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> > 
> > This looks like a fix (most likely fixing initial S2R support, please
> > help me chase the commit ID), should we consider it for stable kernels ?
> > 
> > Without it I understand S2R is actually broken on platforms with this
> > host bridge.
> I don't think this ever worked, so it's hard to find a Fixes: commit for
> this.

If we want to send it to stable kernels we have to select which versions
we are covering. I think the only options for a Fixes: tag are either
the initial S2R support commit for the platforms this driver runs on
or the initial driver commit that harks back to v3.16 AFAICS.

I will queue it next week so there is some time to think about it.

Thanks,
Lorenzo
