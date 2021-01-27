Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071EEC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 27 Jan 2021 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B377C207E8
	for <linux-pci@archiver.kernel.org>; Wed, 27 Jan 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhA0PmD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhA0PkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 10:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81166207CC;
        Wed, 27 Jan 2021 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611761972;
        bh=jnWaTgTjEiXLwIl71ozjyUIexPVv8coDp5HgeSvIPAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eSolqN6tHqQ0PDVntK44LMEXtuXPy8sGMBO07JjNGhqNWFtFsLcW3JUeCHs/z1LAa
         U5w9nLj0hS2uHQiu503HQlUiVTIZI85a1WP2hHxcnu84gsQ9xgXevcyFGWAUsJQnRC
         jJhQN7GlF4xrFRKWzM8fl/lv/GeXYMcheZ7af9xwVtxllUv6uaoY9Ytl6mdXpms7t9
         wnuCZsdLOZTUH7mYIq8lXnXGUXd2gBLf7y60zLzAatYwXe1DNfz3iM9g4D0oxCN4MD
         kInYfuVpHA5JchQP6v3X3y3PswSpTbIyQkMhOAuPVVt2JKxeFDZFjWF2mwgehR3GOa
         BQobHlPNxc7ag==
Date:   Wed, 27 Jan 2021 09:39:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/ACPI: _OSC cleanups
Message-ID: <20210127153928.GA2988033@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_HJzBM1+e3oU4b_y==0hoQJWJ+ZKxLCU5HCdnjdFYqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27, 2021 at 02:55:07PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 27, 2021 at 1:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Clean up a few _OSC-related things.
> >
> > We talked about the _OSC failure message in the last patch long ago, and I
> > just dropped the ball, sorry about that.  Previous discussion:
> > https://lore.kernel.org/linux-pci/20200602223618.GA845676@bjorn-Precision-5520/
> >
> > I'm happy to merge these given your ack, Rafael, or you can take them if
> > they look good to you.
> 
> They do look good to me, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the whole series.
> 
> I don't think it really matters which way they go in and I'm guessing
> that it will be somewhat more convenient to you to apply them, so
> please route them through the PCI tree.

Thanks, Rafael, I put these on my pci/enumeration branch for v5.12.
