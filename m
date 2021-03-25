Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7BC433E1
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0922161A2D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYQrT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCYQq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 12:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17FE661A16;
        Thu, 25 Mar 2021 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616690817;
        bh=XDSpgiMwLXpSi0DeO5zI9TpSBGRc8mVOW9ocu02P7hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pANO59Hy9KdhMWb8VT+AJRkMbByYezSLJpEwH5huqGS0A6kK6tx1totwF35nP+T7u
         ARlUyhHyIwPuYKW9PE82J0pbkIsWgga1ETzKR36BjR7mRmn+OO5QyKVFFwmJ+ktjsJ
         jO1mz+Ebo3ysTRJOf0/Spcv4NwZbEwbV9m3obh70dR0vWDJO4rWZ3YuZjnQ+rgzwqU
         2rgfyNkqix3RBtsNj7NVLHUpajYmsMJNED4muy5qjfyNGlEG7yhKc61i/8TtbylEdw
         0EbVeG9hw4dOtEaxOAPPjCUxOZqeXcabkU42oKqzn6X3zDHus8QAdfyKM5UIyQo5ss
         5pcJV5Dvm+0wQ==
Date:   Thu, 25 Mar 2021 18:46:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     info@metux.net, raphael.norwitz@nutanix.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFy+fdL8PdD2CgOy@unreal>
References: <YFW78AfbhYpn16H4@unreal>
 <20210320085942.3cefcc48@x1.home.shazbot.org>
 <YFcGlzbaSzQ5Qota@unreal>
 <20210322111003.50d64f2c@omen.home.shazbot.org>
 <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
 <YFxL4o/QpmhM8KiH@unreal>
 <20210325162637.6ewxkxhvogdsgdxv@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325162637.6ewxkxhvogdsgdxv@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 09:56:37PM +0530, Amey Narkhede wrote:
> On 21/03/25 10:37AM, Leon Romanovsky wrote:
> > On Wed, Mar 24, 2021 at 11:17:29AM -0600, Alex Williamson wrote:
> > > On Wed, 24 Mar 2021 17:13:56 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:

<...>

> > I expect that QEMU sets same reset policy for all devices at the same
> > time instead of trying per-device to guess which one works.
> >
> The current reset attribute does the same thing internally you described
> at the end.
> > And yes, you will be able to bypass kernel, but at least this interface
> > will be broader than initial one that serves only SO and workarounds.
> >
> What does it mean by "bypassing" kernel?
> I don't see any problem with SO and workaround if that is the only
> way an user can use their device. Why are you expecting every vendor to
> develop quirk? Also I don't see any point of using linked list to
> unnecessarily complicate a simple thing.

Please reread our conversation with Alex, it has answers to both of your
questions.

Thanks

> 
> Thanks,
> Amey
