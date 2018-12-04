Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27813C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28D120672
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 18:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28D120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLDSEV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:04:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48931 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSEV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 13:04:21 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id f9c61c2cc873e88a; Tue, 4 Dec 2018 19:04:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, ptalbert@redhat.com
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Date:   Tue, 04 Dec 2018 19:04:08 +0100
Message-ID: <14167565.uHCdXzdPNX@aspire.rjw.lan>
In-Reply-To: <20181204001009.GA85090@google.com>
References: <2960808.4YCFhzuD0k@aspire.rjw.lan> <CAErSpo476FzJJ_OMGiPbR5SkJ2-41zR_Jy25Hhnw-dA51V5i6A@mail.gmail.com> <20181204001009.GA85090@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, December 4, 2018 1:10:09 AM CET Bjorn Helgaas wrote:
> On Wed, Nov 28, 2018 at 02:05:21PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 28, 2018 at 6:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Tuesday, November 27, 2018 9:25:14 PM CET Bjorn Helgaas wrote:
> > > > On Mon, Nov 26, 2018 at 11:37:20PM +0100, Rafael J. Wysocki wrote:
> > > > > On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> > > > > > Hi Bjorn,
> > > > > >
> > > > > > The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> > > > > >
> > > > > > Here's what lspci -v says about it (in a bad kernel):
> > > > > >
> > > > > > 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader
> > > > > > (rev 01)
> > > > > >         Subsystem: Acer Incorporated [ALI] Device 0704
> > > > > >         Flags: bus master, fast devsel, latency 0, IRQ 35
> > > > > >         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
> > > > > >         Capabilities: [40] Power Management version 3
> > > > > >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> > > > > >         Capabilities: [70] Express Endpoint, MSI 00
> > > > > >         Capabilities: [100] Advanced Error Reporting
> > > > > >         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
> > > > > >         Kernel driver in use: rtsx_pci
> > > > > >         Kernel modules: rtsx_pci
> > > >
> > > > Thanks a lot for bisecting this!
> > > >
> > > > With a good kernel (v4.19 or v4.20-rc with 17c91487364f reverted),
> > > > would you mind collecting "lspci -vv" output, the dmesg log with
> > > > "pci=earlydump", and the FADT dump?
> > >
> > > All of the information is attached to the BZ entry at
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=201801
> > 
> > Thanks!  I hope Patrick has a chance to look at this.  Per the
> > bugzilla mentioned in 17c91487364f, it fixes a problem with a custom
> > proprietary PCIe device, and there's a lot of good detailed analysis
> > there, so hopefully we can figure out a way to address both
> > situations.
> 
> I queued up a revert on for-linus, since we haven't made any progress on
> this yet.  I'll be on vacation much of this week, but I want to get
> the revert (or better, a fix if we can find one) in before -rc6 comes
> out next Sunday.

Thanks!

> If we figure out a fix before then, I'll drop the revert and use the
> fix instead.

