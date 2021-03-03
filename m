Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A7BC4332D
	for <linux-pci@archiver.kernel.org>; Wed,  3 Mar 2021 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD65600EF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Mar 2021 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbhCCU4D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Mar 2021 15:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574339AbhCCRXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Mar 2021 12:23:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD3164ED9;
        Wed,  3 Mar 2021 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614792145;
        bh=b3etKzN8+Flt4lhyAfeyvXRQgC1NJhMOnsuOZwf8mq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I8Oj1MT+LBmFvA777R+D2HnATD/sdcXY/Di18boeujmTQfL3zx7huntP8/XC3+zkn
         9MEQshfmTNoSEYzQI6j6uFzmQdmfoVkprCiFSpCOmmP8DQVbNomc0YI+qnD8EM8SOu
         ub7W6jo8ul5RNt2ELBBhTT9qZ5X11z3sPb3pWZCwlb1/MZ76K+OP62pdT9j6HGCW//
         O27/bSWyOxpfmJqmlfLIZwVy498sbvEMOXwxqql5K+t5WuHyMQ36J/A6fl0kKx2CQ1
         YVBvyQ/z0F1+H63rz59giMHSYQV8L8EvunQZ+ekpdc2NZM6XoSalXr3HMp5tjOaUTL
         cISKUVh7Z+x1Q==
Date:   Wed, 3 Mar 2021 11:22:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [Bug 212039] New: PCI_COMMAND randomly flips to 0 after system
 resume, breaks the xHCI device
Message-ID: <20210303172223.GA634698@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-212039-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to linux-pci]

On Wed, Mar 03, 2021 at 05:08:37PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=212039
> 
>             Bug ID: 212039
>            Summary: PCI_COMMAND randomly flips to 0 after system resume,
>                     breaks the xHCI device
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: mainline, linux-next
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kai.heng.feng@canonical.com
>         Regression: No
> 
> After system resume, the read on PCI_COMMAND may randomly be 0 in
> pci_read_config_word(), which is called by __pci_set_master().

Comment #3 says this is not reproducible on Intel RVP.

What platform *does* it occur on?  Does it always happen on that
platform?

(You said "randomly" above, but I don't know it that means it happens
on some platforms but not others, or it happens sometimes on a give
platform but not always.)

> So it only enables Bus Master in next pci_read_config_word(),
> disabling "Memory Space", "I/O Space" at the same time.
> 
> This makes xHCI driver fail to access MMIO register, render USB
> unusable.

Apparently this only affect the xHCI device?  That's weird; the code
that restores config registers after resume should be pretty generic,
so a bug there should affect lots of devices.  But maybe there's some
firmware component since it seems to happen on some platforms but not
others.
