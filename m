Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3443CC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D5A208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 22:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D5A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeK1JcV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:32:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48351 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1JcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 04:32:21 -0500
Received: from 79.184.252.167.ipv4.supernova.orange.pl (79.184.252.167) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 16363634018e03a9; Tue, 27 Nov 2018 23:32:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Patrick Talbert <ptalbert@redhat.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Date:   Tue, 27 Nov 2018 23:32:52 +0100
Message-ID: <2589393.XVIVmOtOXj@aspire.rjw.lan>
In-Reply-To: <20181127202514.GB112381@google.com>
References: <2960808.4YCFhzuD0k@aspire.rjw.lan> <1675729.7aZxPkvRd8@aspire.rjw.lan> <20181127202514.GB112381@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, November 27, 2018 9:25:14 PM CET Bjorn Helgaas wrote:
> On Mon, Nov 26, 2018 at 11:37:20PM +0100, Rafael J. Wysocki wrote:
> > On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> > > Hi Bjorn,
> > > 
> > > The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> > > 
> > > Here's what lspci -v says about it (in a bad kernel):
> > > 
> > > 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader 
> > > (rev 01)
> > >         Subsystem: Acer Incorporated [ALI] Device 0704
> > >         Flags: bus master, fast devsel, latency 0, IRQ 35
> > >         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
> > >         Capabilities: [40] Power Management version 3
> > >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> > >         Capabilities: [70] Express Endpoint, MSI 00
> > >         Capabilities: [100] Advanced Error Reporting
> > >         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
> > >         Kernel driver in use: rtsx_pci
> > >         Kernel modules: rtsx_pci
> 
> Thanks a lot for bisecting this!
> 
> With a good kernel (v4.19 or v4.20-rc with 17c91487364f reverted),
> would you mind collecting "lspci -vv" output, the dmesg log with
> "pci=earlydump", and the FADT dump?

I'll do that tomorrow.

> I'm interested in the initial state of the device at handoff from
> BIOS, and what Linux changes even when aspm_disabled is set.

OK

> If we can't figure out a way to fix both this issue and the one fixed
> by 17c91487364f, I guess the fallback will be to revert 17c91487364f
> since it's better to allow a system that was previously broken to
> remain broken than it is to break a system that previously worked.

Well, depending on how many systems are affected by the issues fixed by
17c91487364f IMO.

Arguably, if the FADT says "NO_ASPM", then the platform should not need the
OS to initialize ASPM to work.  I guess a manual workaround (like an extra
kernel command line option or similar) should suffice in this particular
case.

> But obviously I hope we can figure out a solution that fixes both
> cases.

Of course.

