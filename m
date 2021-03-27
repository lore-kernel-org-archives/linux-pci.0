Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA6C433DB
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 06:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8183601FB
	for <linux-pci@archiver.kernel.org>; Sat, 27 Mar 2021 06:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhC0GDQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Mar 2021 02:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhC0GC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 02:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08889619AB;
        Sat, 27 Mar 2021 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616824977;
        bh=vJLK3mU/mYXW2zAN69H1AT5oKhmRrXT3I2N/5ZFnso0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDyFO9d/KzK+318L7Y4W43TDiXdjDmWdSca4x55Ikn2fGbSiDlW0NGCsF1Sd4UTkB
         vW3gw1w44W1rNpLOApqvX/JPrD9xfme9Y98x/bvgAIOhMWzjYwWv9I2Y0qd6pZRK4n
         aVhmEHkweybQs0NOAugs+1NG2PKmyZ6Hcv0PqWPc5eIXnIHPdgwUEYAWpHTwzfeu4E
         BGTAF0Sn5W3bFrNUYcPn8hQLySXDZojHw5t9UC2DdkeKcNtsY78e9mF2ESwW8DYpE1
         MoDZZj/fwvMLMeR2xv4WNfidxnl0jkw/A3vebh6hNjmbrCoR3cvkS92uLUPpYgF/tc
         aDPeD7tZxiwrA==
Date:   Sat, 27 Mar 2021 09:02:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YF7KjnhFKSm56GOH@unreal>
References: <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
 <YFxL4o/QpmhM8KiH@unreal>
 <20210325085504.051e93f2@omen.home.shazbot.org>
 <YFy11u+fm4MEGU5X@unreal>
 <20210325115324.046ddca8@omen.home.shazbot.org>
 <YF2B3oZfkYGEha/w@unreal>
 <20210326082007.58ef9ac4@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326082007.58ef9ac4@x1.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 08:20:07AM -0600, Alex Williamson wrote:
> On Fri, 26 Mar 2021 09:40:30 +0300
> Leon Romanovsky <leon@kernel.org> wrote:

<...>

> > 
> > It supports by writing: echo "bus,pm" > reset_methods.
> > Regarding comma, IMHO it is easiest pattern for the parsing.
> > 
> > Anyway, The in-kernel implementation is not important to me.
> 
> Too bad, it should have been apparent from the sample code that it was
> using a comma separated list with re-ordering support.  Thanks,

Excellent, both of us think that "bus,pm" is the easiest way to
implement policy decision.

Thanks

> 
> Alex
> 
