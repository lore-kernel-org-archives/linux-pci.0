Return-Path: <SRS0=X3es=PR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83843C43387
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573F920883
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 08:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfAIIPX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:15:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35511 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbfAIIPX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jan 2019 03:15:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26DE7209BD; Wed,  9 Jan 2019 09:15:21 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id EE3B420712;
        Wed,  9 Jan 2019 09:15:20 +0100 (CET)
Date:   Wed, 9 Jan 2019 09:15:20 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20190109091520.23641675@windsurf>
In-Reply-To: <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
        <20181218144702.752d97cd@windsurf>
        <20181218153404.45b038cf@windsurf>
        <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
        <20181218213716.70d27f1f@windsurf>
        <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
        <20190108114817.2bb15d5e@windsurf>
        <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Luis,

On Tue, 8 Jan 2019 23:22:05 +0000, Luís Mendes wrote:

> > Sorry for the long delay, the Christmas/New Year vacation and some
> > personal issues got in the way.  
> No problem, life has its priorities! and by the way: Happy new year!

Thanks, you too!


> > You will most likely have to increase CONFIG_LOG_BUF_SHIFT to avoid
> > having dropped messages, as my additional debug messages are quite
> > verbose. I'm using CONFIG_LOG_BUF_SHIFT=16.  
> The logs from the new kernel are not starting at 0.0 sec, as
> CONFIG_LOG_BUF_SHIFT=16 wasn't large enough, but for the reverted
> patch case I changed to CONFIG_LOG_BUF_SHIFT=17.
> If you find relevant information can be missing tell me and I will
> recompile the kernel with the patch
> 1f08673eef1236f7d02d93fcf596bb8531ef0d12 applied and
> CONFIG_LOG_BUF_SHIFT=17. I believe it won't be needed though, since
> the pci logs are practically complete.

Sadly, the kern_4.20_debug.log file is incomplete. I would like to at
least see it starting from:

Jan  8 22:57:51 picolo kernel: [    6.792819] mvebu-pcie soc:pcie: MEM: [mem 0xd0000000-0xefffffff], IO: [io  0xffe00000-0xffefffff]

(this line from the reverted log, but I'd like to see it in the non-reverted log as well)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
