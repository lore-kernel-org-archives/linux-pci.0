Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C421874
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553110507;
	bh=jvvLiH2iJjCgEDrTXP1PkXjPrCfbbo/h+b/rmsBSqXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYEgHnCNQ0VO/E7wDyUOZol8ee1gWx3/+evfzwhSb/0mLx9QFdqq+tiQxbHPhXIHB
	 NZPrEX/rxVi217qCikGKtpOSEeN4peE8aDZ2MiMvIm61C+m/FX149V6iK87bTUAIzv
	 GwJSpPUBsBbWK23p/LyIJjmTgvk1UG9DWEvGp5S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCTTfG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTTfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 15:35:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0DF21873;
        Wed, 20 Mar 2019 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553110506;
        bh=jvvLiH2iJjCgEDrTXP1PkXjPrCfbbo/h+b/rmsBSqXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xdbgb0nEmA5Mw2YPK89F0gzKHmn4GcYv8HDSERy5wrfGpkM4zCtG/4SIGpK+AJ3ak
         xBIpdwVy+y72hcmUOBBQGGvUn/i22qfZAaTTgi1p8EK/ya2BT5awVUVDVr1uU6S99X
         mE5Uc94b0q018x+m8F7exk7JNPtdBne/yRvJjn4M=
Date:   Wed, 20 Mar 2019 14:35:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190320193504.GC251185@google.com>
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <20190319011214.7847-1-mr.nuke.me@gmail.com>
 <20190320134632.GA251185@google.com>
 <dc22ee5c-5c63-a28d-c709-986287bb4a7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc22ee5c-5c63-a28d-c709-986287bb4a7e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 20, 2019 at 08:48:33AM -0500, Alex G. wrote:
> On 3/20/19 8:46 AM, Bjorn Helgaas wrote:
> > On Mon, Mar 18, 2019 at 08:12:04PM -0500, Alexandru Gagniuc wrote:
> > > A threaded IRQ with a NULL handler does not work with level-triggered
> > > interrupts. request_threaded_irq() will return an error:
> > > 
> > >    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
> > >    pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> > > 
> > > For level interrupts we need to silence the interrupt before exiting
> > > the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
> > > 
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > 
> > What's your thought regarding Lukas' comment?  If you do repost this,
> > please add a Fixes: tag to help connect this with the initial commit.
> 
> I like Lukas's idea. I should have this re-posted by end of week, unless
> there's an urgency to get it out earlier.

It would have been ideal to get the fix in -rc2, but I guess the end
of the week is OK because it's probably already too late for me to
apply it, run it through 0-day, get it in -next, and ask Linus to pull
it for -rc2.

Bjorn
