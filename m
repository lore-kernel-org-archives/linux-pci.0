Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5386C433DB
	for <linux-pci@archiver.kernel.org>; Fri, 29 Jan 2021 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6249164DFB
	for <linux-pci@archiver.kernel.org>; Fri, 29 Jan 2021 16:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhA2Qfz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Jan 2021 11:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhA2Qdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 11:33:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C5164DD6;
        Fri, 29 Jan 2021 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611937499;
        bh=hn8flzqxkxpOR59mqZkMFGF2Hu/kKp5uLtbNUzoFq/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TllZ/cL3gLOyf6FqCqFehZiqnzk53xwoR22NUi5D/Uv3NAsq0tWKCx67XgKsaWrT2
         hvG6/ou/QYaw/5BU6jJ8bFYRTdJuy8a77boVN80cO6p3ga391lcx7q/8AKv6VYbztR
         dIjvZiB0pg3cSxPXffK1+B7Aj5qm5wQ4vb1JH5iG66yix3ePNiDuaxOVSMGCreONcr
         1M7pqzezcd2Tp2cgQmCjeIBFNBeRF713287iUnFz9SweDYFACs+Yyy4p3BYtZ9D0jb
         o2ga1zHmTiOeAPq+UqA8iHX48kbP42pYvVDWBv5b1LppywnLiBWF/xMCp7XZZt15OZ
         DV6Llj3EFfbig==
Date:   Fri, 29 Jan 2021 10:24:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Fix 'ARM/TEXAS INSTRUMENT KEYSTONE
 CLOCKSOURCE' capitalization
Message-ID: <20210129162458.GA85288@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126195111.GA2909572@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 01:51:11PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2021 at 01:34:57PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix capitalization typo in 'ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE'.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I'll just merge this via the PCI tree unless anybody objects.

Applied to pci/misc for v5.12.

> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cc1e6a5ee6e6..52311efad03e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2603,7 +2603,7 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/clk/keystone/
> >  
> > -ARM/TEXAS INSTRUMENT KEYSTONE ClOCKSOURCE
> > +ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE
> >  M:	Santosh Shilimkar <ssantosh@kernel.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  L:	linux-kernel@vger.kernel.org
> > -- 
> > 2.25.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
