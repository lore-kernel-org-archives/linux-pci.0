Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB952C433ED
	for <linux-pci@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8686128E
	for <linux-pci@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhDLOFM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241463AbhDLOFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 10:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3433D61244;
        Mon, 12 Apr 2021 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618236294;
        bh=Z0EN6ZQtPiLEfYDv/M/XHThH4BKVgI72c6A02CQSK88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcVqJNLiPG2l+61SuuJwPlRbV2XhKq6QCuoK8q7fuVTuXqNRDOzBFZQRX1MnojR46
         O6FfCgPQ5g3hp+MgMsyyoO9cNUKjFrACvqO6vGg3dJtWBrpQ/SNLcuQ1wr7iCPEA/o
         iekEbjv6WikzmEGgl3hFJnW2Rv+x07AhAFFANYOvhQYbHQC5YFA1LSq/RqlQYyD2hs
         Sod0Ui3wJCNt1H3DTXh80p5IiGUoT5XauOVzuZrIyi7sFPvPvtNLsrcjN+cf86UesQ
         DJ04IQNLbGu+t+eiBcizWXGSCzSLUgypwFBq4lwwVelRysSOH3CKHvqSYpoLboUqwj
         qmYU3RTPCs8Zw==
Received: by pali.im (Postfix)
        id 0592F687; Mon, 12 Apr 2021 16:04:51 +0200 (CEST)
Date:   Mon, 12 Apr 2021 16:04:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210412140451.672makicwd6z6oln@pali>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
 <20210410162622.GA23381@wunner.de>
 <20210412022555.GA41644@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412022555.GA41644@C02WT3WMHTD6>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 11 April 2021 20:25:55 Keith Busch wrote:
> On Sat, Apr 10, 2021 at 06:26:22PM +0200, Lukas Wunner wrote:
> > 
> > 1.5 sec is definitely too long.  This sounds like a quirk of this
> > specific hardware.  Try to find out if the hardware can be configured
> > differently to respond quicker.
> 
> While 1.5 sec is long, pcie spec's device control 2 register has an option to
> be even longer: up to 64 seconds for a config access timeout! I'm not sure of
> the reasoning to allow something that high, but I think the operating system
> would be not be too happy with that.

So what can we do in this case? On single core CPU it means that raw
spin lock would completely block any operation on CPU for 64 seconds.

Do you know what is the timeout for other registers?
