Return-Path: <SRS0=b3zO=PA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DFC43387
	for <linux-pci@archiver.kernel.org>; Sun, 23 Dec 2018 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA81920882
	for <linux-pci@archiver.kernel.org>; Sun, 23 Dec 2018 17:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbeLWRPE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Dec 2018 12:15:04 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46457 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbeLWRPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Dec 2018 12:15:04 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 527F93000088B;
        Sun, 23 Dec 2018 18:15:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2A2DF1D43B2; Sun, 23 Dec 2018 18:15:01 +0100 (CET)
Date:   Sun, 23 Dec 2018 18:15:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Message-ID: <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de>
 <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 23, 2018 at 02:00:15AM +0300, Sinan Kaya wrote:
> On Sat, Dec 22, 2018 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
> > > This driver depends on the PCI infrastructure but the dependency has not
> > > been explicitly called out.
> > >
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> >
> > This series doesn't have a cover letter so it's unclear to me through
> > which tree it's supposed to go in?  Each patch through the individual
> > subsystem tree or all through the same tree?  If the former I guess I
> > could push this to drm-misc...
> 
> Feel free to apply individual patches independently. Let me know which
> one you applied so that I can drop them on the next rev.

I've realized only now that this patch fixes fallout of commit
5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
which is part of Rafael's acpi pull for v4.21.

Usually such fixes go through the same tree as the offending commit,
so I'd expect Raphael to pick up the whole series and forward it to
Linus in the second half of the merge window.  I'm not sure if that's
how it'll play out though given the holidays.

Additionally, drm-misc is currently in a somewhat confusing state:
Normally fixes targeting v4.21 should have been applied to
drm-misc-next-fixes for the last 2 weeks, yet no new commits have
been applied to that branch since December 5, but plenty of stuff
that should have been applied (various fixes and a MAINTAINERS change)
went to drm-misc-next instead.  So it looks like a lot of folks picked
the wrong branch and drm-misc-next is now a mix of v4.22 features and
v4.21 fixes.  I think I should rather not add to this mess before a
drm-misc maintainer has had a chance to sort it out.

I'll be sure to keep an eye on this though.  The fallout addressed by
the patch is mostly confined to randconfigs I think, so waiting a few
more days probably won't hurt much.

Thanks,

Lukas
