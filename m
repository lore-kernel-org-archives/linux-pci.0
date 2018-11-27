Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E919C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F35B208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 20:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7KANS72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeK1HYV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeK1HYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 02:24:20 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7D420873;
        Tue, 27 Nov 2018 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543350316;
        bh=lhOOZSdDHB39hiHUJ1gc3PVNwldijxaEv1yJeDjOJbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7KANS72ytXRKFgaBrsx5PAwmMrR/rUpEQ5DNEPfLZuRwUAe2UHrfB8dMoL1hIbx9
         N+XjnphPOSs+nj5D8Injv0MvHOPTburaDA3v2gcPEZK3cwGLFbnOjK2kXeDMf8ZuVe
         Pna4FXPyQKObIFI4Utb3wGK7wjut/eZ/2oTK9Ubs=
Date:   Tue, 27 Nov 2018 14:25:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Patrick Talbert <ptalbert@redhat.com>
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Message-ID: <20181127202514.GB112381@google.com>
References: <2960808.4YCFhzuD0k@aspire.rjw.lan>
 <1675729.7aZxPkvRd8@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675729.7aZxPkvRd8@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 26, 2018 at 11:37:20PM +0100, Rafael J. Wysocki wrote:
> On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> > Hi Bjorn,
> > 
> > The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> > 
> > Here's what lspci -v says about it (in a bad kernel):
> > 
> > 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader 
> > (rev 01)
> >         Subsystem: Acer Incorporated [ALI] Device 0704
> >         Flags: bus master, fast devsel, latency 0, IRQ 35
> >         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >         Capabilities: [70] Express Endpoint, MSI 00
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
> >         Kernel driver in use: rtsx_pci
> >         Kernel modules: rtsx_pci

Thanks a lot for bisecting this!

With a good kernel (v4.19 or v4.20-rc with 17c91487364f reverted),
would you mind collecting "lspci -vv" output, the dmesg log with
"pci=earlydump", and the FADT dump?

I'm interested in the initial state of the device at handoff from
BIOS, and what Linux changes even when aspm_disabled is set.

If we can't figure out a way to fix both this issue and the one fixed
by 17c91487364f, I guess the fallback will be to revert 17c91487364f
since it's better to allow a system that was previously broken to
remain broken than it is to break a system that previously worked.

But obviously I hope we can figure out a solution that fixes both
cases.

> > When it doesn't work, it doesn't generate any interrupts on device insertion
> > and removal and this seems to be reproducible 100% of the time.
> 
> So reverting 17c91487364f (PCI/ASPM: Do not initialize link state when
> aspm_disabled is set) on top of 4.20-rc4 makes the problem go away.
> 
> I guess that the device in question needs pcie_aspm_cap_init() to be
> called for it even though the FADT says "NO_ASPM".
