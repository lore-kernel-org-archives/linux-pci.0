Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7EC433B4
	for <linux-pci@archiver.kernel.org>; Wed, 28 Apr 2021 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860DF61423
	for <linux-pci@archiver.kernel.org>; Wed, 28 Apr 2021 22:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhD1WW6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhD1WW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 18:22:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1568B61423;
        Wed, 28 Apr 2021 22:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619648529;
        bh=kUnxhYIz07QhQ79jP/H1e/MXJTvg9ka3nEgsxoKUo4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KQzY2Gac/vGnELmWd1eZgcXDLizXIm5e1JzNk6Rvlkn+JVJNQBeL0BIlNuySZbiBq
         Hw797X0SljIQO+jQvlMR3ubdyMX+1mdsqc33xA0AFRzi3IqAcl8dp9ik/D1+0VRugD
         2ru1XYAQnDhkifsATgKpvq2tbNAfLJlMAcFn6eN/2wVjerJF3DdsJ/aKbEWYyJ2J+W
         zb7doT0N39F/+6vb9NWHZbeGCgaM8fldNKJT/7uZXG9puh4AfKTHYug0agto9vd4Cg
         xb8chIx/Ze4RI1lbDF6/lwPeCJ8ui2UtmGk3ZHFrEEQDPiL2ptkaRf2SsV/MUt+M6D
         qUHDpnbtQfcqQ==
Date:   Wed, 28 Apr 2021 15:22:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: remove Wingman Kwok
Message-ID: <20210428152208.4ae31463@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <163af71165cb8a2025026fea8236e4f2@walle.cc>
References: <20210428085607.32075-1-michael@walle.cc>
        <20210428135443.7c1ef0f4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <163af71165cb8a2025026fea8236e4f2@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Apr 2021 23:39:00 +0200 Michael Walle wrote:
> Am 2021-04-28 22:54, schrieb Jakub Kicinski:
> > On Wed, 28 Apr 2021 10:56:06 +0200 Michael Walle wrote:  
> >> His email bounces with permanent error "550 Invalid recipient". His 
> >> last
> >> email on the LKML was from 2015-10-22 on the LKML.
> >> 
> >> Signed-off-by: Michael Walle <michael@walle.cc>  
> > 
> > FWIW does not apply to any networking tree, whose tree
> > are you targeting?  
> 
> This was on linux-next. I'm not sure through what tree
> these changes will go. I included all the original "L:"
> here.
> 
> I can rebase it onto net-next (or wait until after
> the merge window closes).

Rebase on net would be best - would you mind doing that in
around two days? (we're about to send the PR for 5.13)
