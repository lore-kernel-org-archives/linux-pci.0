Return-Path: <SRS0=Uo2K=37=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C4C352A3
	for <linux-pci@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B179420714
	for <linux-pci@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581432051;
	bh=epryJXwBJzpuD4aUUStzK1/25c4ehwhe9weUoJWNEh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Xi2lpDgKkmLOBVCZozL8Ny0I4lGRe1Ir+fMJv7i8/qCmXcwFmefKKDlkOPbgS9iX6
	 CU6+DVoqLNFc5tWrl7takK5ugsKwWUjjNnHmrffvpP66HObicrtlBzP0oJoIwY6ELv
	 vZsWB72f2PiUSCSazi2w0/SKhE5ghXhuDVouSEsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgBKOkv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgBKOkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 09:40:51 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A0720708;
        Tue, 11 Feb 2020 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581432050;
        bh=epryJXwBJzpuD4aUUStzK1/25c4ehwhe9weUoJWNEh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V7a0XhiG3r8z0EjgeehlOeCfMa/c4DGSQnZjetd7BK3r7qnFisGTF9p2VZiyZBt6h
         EBHJPROC+YEQGEdL0gBJklfcjpXPtoID5SlyVW9k7d5YkbWEBYb6toCBSbzhr+Bp6n
         N5Vi6hFlDLRbvuiKgUn/FzW+ReD6t1YHD9vjBtd4=
Date:   Tue, 11 Feb 2020 08:40:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: pcie: kernel log - BAR 15: no space for... BAR 15: failed to
 assign..
Message-ID: <20200211144048.GA208842@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+jdEK73ji4MsuV3jsDih8qNG5p9Ywzn_1iuTseGNp2cBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 07:36:00PM +0530, Muni Sekhar wrote:
> On Tue, Feb 11, 2020 at 3:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Feb 09, 2020 at 07:59:41AM +0530, Muni Sekhar wrote:
> > > Hi all,
> > >
> > > After rebooting the system following messages are seen in dmesg.
> > > Not sure if these indicate a problem. Can some one look at these and
> > > confirm if this is problem or can be ignored ?
> > >
> > > Also any suggestions as to what would cause this?
> > >
> > > [    1.084728] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.084813] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.084890] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > > [    1.084949] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > > [    1.085037] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085108] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085199] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085270] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085343] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> > > [    1.085403] pci 0000:00:1c.2: BAR 13: assigned [io  0x2000-0x2fff]
> > > [    1.085470] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085540] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085613] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > > [    1.085672] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > > [    1.085738] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085808] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085884] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > > 0x00200000 64bit pref]
> > > [    1.085954] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > > 0x00200000 64bit pref]
> > > [    1.086026] pci 0000:00:1c.0: PCI bridge to [bus 01]
> > > [    1.086083] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > > [    1.086144] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]
> >
> > The "no space" and "failed to assign" messages are all for bridge
> > windows (13 is the I/O window, 14 is the MMIO window, 15 is the MMIO
> > pref window).  I can't tell if you have any devices below these
> > bridges (lspci would show them).  If you don't have any devices below
> > these bridges, you can ignore the messages.
>
> I have the devices below these bridges. FPGA endpoint is connected to
> '00:1c.0 PCI bridge' and Ethernet controller is connected to '00:1c.3
> PCI bridge'.
> Does these messages impact the functionality of the connected devices?

Yes.  We tried to allocate 0x00200000 of prefetchable MMIO to 00:1c.0
for use by the FPGA endpoint.  But this failed, so there is no
prefetchable MMIO available for the FPGA.  The 0xd0400000-0xd07fffff
non-prefetachable MMIO space *is* available for it.

Similarly, we were unable to allocate 0x00200000 of prefetchable MMIO
for the 00:1c.3 bridge for use by the ethernet controller.  I don't
know what non-prefetchable MMIO space was allocated or what the NIC
needs.

"lspci -v" will show you what the FPGA and the NIC need.

> If so what kind of impact and is there any solution for this?

> Also, I'd like to know why "no space" and "failed to assign"
> messages displayed?

These messages mean we tried to allocate space for the bridges but we
unable to do so.  This is because either the host bridge didn't have
big enough apertures (on x86, these usually come from ACPI _CRS
methods), or there's a bug in the Linux allocation algorithms.

I can't tell anything more without seeing the complete dmesg log,
which contains the host bridge aperture information and the BAR sizes
of the FPGA and NIC.

Bjorn
