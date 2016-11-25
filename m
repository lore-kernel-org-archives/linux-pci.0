Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:60889 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbcKYHrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Nov 2016 02:47:53 -0500
Date: Fri, 25 Nov 2016 08:01:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, clemens@ladisch.de,
        linux-pci@vger.kernel.org
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161125070159.ner7xvizvo2upb6h@pd.tnic>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 24, 2016 at 09:39:57PM -0200, Rogério Brito wrote:
> Before I go on describing the problems that I have, I want to say that I can
> bisect the kernel, apply patches and give feedback for the problems that I
> am seeing.

Good. We're going to need them.

Please checkout lates Linus kernel:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git

build it, boot it on your machine, catch dmesg and send it to me.

Thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
