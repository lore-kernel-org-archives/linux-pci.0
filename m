Return-Path: <SRS0=uFxo=EC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B2C4363A
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01882072D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 20:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1803433AbgJ0UUO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:20:14 -0400
Received: from lists.nic.cz ([217.31.204.67]:36198 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1831263AbgJ0UT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 16:19:58 -0400
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 00739140862;
        Tue, 27 Oct 2020 21:19:55 +0100 (CET)
Date:   Tue, 27 Oct 2020 21:19:49 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201027211949.1f25d3b9@nic.cz>
In-Reply-To: <87a6w7wl1x.fsf@toke.dk>
References: <87imavwu7b.fsf@toke.dk>
        <20201027190344.4ffd9186@nic.cz>
        <87a6w7wl1x.fsf@toke.dk>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Oct 2020 20:00:58 +0100
Toke Høiland-Jørgensen <toke@redhat.com> wrote:

> Marek Behun <marek.behun@nic.cz> writes:
> 
> > Are you using stock U-Boot in the Omnia?  
> 
> I've tried both that and the latest upstream - didn't make a difference
> wrt the PCI issue. Only difference I've noticed other than that (apart
> from being able to turn more things on when using upstream) is that the
> upstream u-boot can't seem to find the eMMC chip on the Omnia. Any idea
> why? It doesn't matter right now since I'm just tftp-booting, but it
> would be kinda nice to get that fixed as well :)
> 
> -Toke
> 

No idea, I will have to look into that.
