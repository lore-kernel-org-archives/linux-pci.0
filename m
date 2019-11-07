Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE853C5DF60
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9E21882
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fBw9/3DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfKGPm0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:42:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGPmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 10:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cfQe+TqAPfiHi0Od9OyJixFH/1rtoMH2zyZ+3Zby/hE=; b=fBw9/3DFOgRSdfYbjn68RW2bB
        hrYxOrqcfd11KLjCTxjcx2IxvvNw1hywL//q3/3fZpseMQUDFmFIqbU/zRIQBGblYkv7iX2/5nGkB
        /w/zd9667oxMdM4jb/i7q0boVix8NNLnMmOIIH4LD4Zfnu+6mh9pR/9n0YLr0HH+X0R3iwHF4KnsB
        ed6b7+htv4rt6gbnKql0MnD2OLKq2UBlVyCePioS1eOP61fU254IAMXEPHFPd9vJQAyCsm4L0Q8tQ
        59FXofOzb3fvO6Yoa5BYnSP4AtkXi7je/mB3O2MW+wIODOsqBtU29wbnV2rJkGA6uJe2j/7zFNiMM
        VUPE3r+wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSjvU-0006su-IA; Thu, 07 Nov 2019 15:42:24 +0000
Date:   Thu, 7 Nov 2019 07:42:24 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Message-ID: <20191107154224.GA26224@infradead.org>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <20191107093952.GA13826@infradead.org>
 <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
 <20191107153736.GA16006@infradead.org>
 <c0d62e0f1f8d1d6f31b2a63757aad471ced1df28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d62e0f1f8d1d6f31b2a63757aad471ced1df28.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 03:40:15PM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-11-07 at 07:37 -0800, hch@infradead.org wrote:
> > On Thu, Nov 07, 2019 at 02:12:50PM +0000, Derrick, Jonathan wrote:
> > > > How does this compare to simplify disabling VMD?
> > > 
> > > It's a moot point since Keith pointed out a few flaws with this set,
> > > however disabling VMD is not an option for users who wish to
> > > passthrough VMD
> > 
> > And why would you ever pass through vmd instead of the actual device?
> > That just makes things go slower and adds zero value.
> 
> Ability to use physical Root Ports/DSPs/etc in a guest. Slower is
> acceptable for many users if it fits within a performance window

What is the actual use case?  What does it enable that otherwise doesn't
work and is actually useful?  And real use cases please and no marketing
mumble jumble.
