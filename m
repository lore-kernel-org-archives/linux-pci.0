Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9AAC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F4A21019
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552519275;
	bh=4KYB1fuOeXgs3tIm3qTCeEG5sbuyLpyDeRE1rHgjPRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1dvYBiHCc8kDAaYMXKzDdQMQcjx5Y8xyhp4VlUBHuob4X0h2HtoKwn7weGylye+9I
	 6V9nd789BrWTi9qJgAxA4HZ72DH4QU4qcLTsm4EW7n0xqbc90ltLdhE14F2lu/9oZk
	 B8sgPRtbKOusiQiYfpAkHPTiv1zE0UM+VOQA0lQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfCMXVP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfCMXVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 19:21:14 -0400
Received: from localhost (unknown [12.208.228.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1521720854;
        Wed, 13 Mar 2019 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552519274;
        bh=4KYB1fuOeXgs3tIm3qTCeEG5sbuyLpyDeRE1rHgjPRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipEEOeCvWq+dY98ZUS9UGgzufcRz31+wbmuTXAHdkeJPBiLkhfvg12981/rpmytfZ
         C8psuQSeY55Ajjx0VCDNpPU+4zYvDKwZ2VXsz5yzZN0WOPkgIB15/12EmkKKIUUsbE
         SoisercyhfV/8XNFo1aht9Z7ZSotfI7z6TrdKG1I=
Date:   Wed, 13 Mar 2019 18:21:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
Message-ID: <20190313232112.GC210027@google.com>
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jesse,

On Wed, Mar 13, 2019 at 11:50:07AM -0500, Jesse Hathaway wrote:
> Two regressions cause Linux to hang on boot when a Comtrol PCI card
> is present.
> 
> If I revert the following two commits, I can boot again and the card
> operates without issue:
> 
> 1302fcf0d03e (refs/bisect/bad) PCI: Configure *all* devices, not just
> hot-added ones
> 1c3c5eab1715 sched/core: Enable might_sleep() and smp_processor_id()
> checks early

I'm very sorry about the regression, but thank you very much for
narrowing it down and reporting it!

How did you narrow it down to *two* commits, and do you have to revert
both of them to avoid the hang?  Usually a bisection identifies a
single commit, and the two you mention aren't related.

> ; lspci -vs 82:00.0
> 82:00.0 Multiport serial controller: Comtrol Corporation Device 0061
>         Subsystem: Comtrol Corporation Device 0061
>         Flags: 66MHz, medium devsel, IRQ 35, NUMA node 1
>         Memory at c8004000 (32-bit, non-prefetchable) [size=4K]
>         Memory at c8000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Hot-plug capable
>         Capabilities: [48] Power Management version 2
>         Kernel driver in use: rp2
>         Kernel modules: rp2
> 
> Is it possible that the problem is that the card claims to support
> Hot-plug, but does not?
> 
> I would love to help fix this issue, please let me know what other
> information would be helpful to provide.

Can you collect a complete dmesg log (with a working kernel) and
output of "sudo lspci -vvxxx"?  You can open a bug report at
https://bugzilla.kernel.org, attach the logs there, and respond here
with the URL.

Where does the hang happen?  Is it when we configure the Comtrol card?

Bjorn
