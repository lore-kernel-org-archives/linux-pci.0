Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56EFC04EB9
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6431A20864
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 00:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQb1RrT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6431A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbeLDAKL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeLDAKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 19:10:11 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AA220850;
        Tue,  4 Dec 2018 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543882210;
        bh=LqMDhAqIFqnVtVKSE73p4MrjOihxgMCZ9SzAiAV0l5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQb1RrT1fu6murp45DYH3wu/V6m1S8MQg6k0JxEFQEVfTW7JFUU4vRifoeEM9pRHk
         MaS7HsZIkiUm9K6OvchipEPlRrJFiwETClGnrC9Ik7pSRB6q2bVzROz6vVVe0Y1abM
         zg6UIoFHZH/XzQbbggcBsvCMnSZsbZEAJNeHm0SI=
Date:   Mon, 3 Dec 2018 18:10:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, ptalbert@redhat.com
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Message-ID: <20181204001009.GA85090@google.com>
References: <2960808.4YCFhzuD0k@aspire.rjw.lan>
 <1675729.7aZxPkvRd8@aspire.rjw.lan>
 <20181127202514.GB112381@google.com>
 <3669527.fZMjlSGqLg@aspire.rjw.lan>
 <CAErSpo476FzJJ_OMGiPbR5SkJ2-41zR_Jy25Hhnw-dA51V5i6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo476FzJJ_OMGiPbR5SkJ2-41zR_Jy25Hhnw-dA51V5i6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 02:05:21PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 28, 2018 at 6:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, November 27, 2018 9:25:14 PM CET Bjorn Helgaas wrote:
> > > On Mon, Nov 26, 2018 at 11:37:20PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> > > > > Hi Bjorn,
> > > > >
> > > > > The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> > > > >
> > > > > Here's what lspci -v says about it (in a bad kernel):
> > > > >
> > > > > 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader
> > > > > (rev 01)
> > > > >         Subsystem: Acer Incorporated [ALI] Device 0704
> > > > >         Flags: bus master, fast devsel, latency 0, IRQ 35
> > > > >         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
> > > > >         Capabilities: [40] Power Management version 3
> > > > >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> > > > >         Capabilities: [70] Express Endpoint, MSI 00
> > > > >         Capabilities: [100] Advanced Error Reporting
> > > > >         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
> > > > >         Kernel driver in use: rtsx_pci
> > > > >         Kernel modules: rtsx_pci
> > >
> > > Thanks a lot for bisecting this!
> > >
> > > With a good kernel (v4.19 or v4.20-rc with 17c91487364f reverted),
> > > would you mind collecting "lspci -vv" output, the dmesg log with
> > > "pci=earlydump", and the FADT dump?
> >
> > All of the information is attached to the BZ entry at
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=201801
> 
> Thanks!  I hope Patrick has a chance to look at this.  Per the
> bugzilla mentioned in 17c91487364f, it fixes a problem with a custom
> proprietary PCIe device, and there's a lot of good detailed analysis
> there, so hopefully we can figure out a way to address both
> situations.

I queued up a revert on for-linus, since we haven't made any progress on
this yet.  I'll be on vacation much of this week, but I want to get
the revert (or better, a fix if we can find one) in before -rc6 comes
out next Sunday.

If we figure out a fix before then, I'll drop the revert and use the
fix instead.

Bjorn
