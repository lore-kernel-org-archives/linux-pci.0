Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73414C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4595220873
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4595220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeK0JdD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:33:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52079 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0JdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 04:33:03 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 035f868819a7f287; Mon, 26 Nov 2018 23:37:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Patrick Talbert <ptalbert@redhat.com>
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
Date:   Mon, 26 Nov 2018 23:37:20 +0100
Message-ID: <1675729.7aZxPkvRd8@aspire.rjw.lan>
In-Reply-To: <2960808.4YCFhzuD0k@aspire.rjw.lan>
References: <2960808.4YCFhzuD0k@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> Hi Bjorn,
> 
> The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> 
> Here's what lspci -v says about it (in a bad kernel):
> 
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader 
> (rev 01)
>         Subsystem: Acer Incorporated [ALI] Device 0704
>         Flags: bus master, fast devsel, latency 0, IRQ 35
>         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
>         Kernel driver in use: rtsx_pci
>         Kernel modules: rtsx_pci
> 
> When it doesn't work, it doesn't generate any interrupts on device insertion
> and removal and this seems to be reproducible 100% of the time.
> 
> Bisection turned up
> 
> commit de468b755464426c276df2daf1e54bcd64186020
> Merge: b1801bf05964 d6112f8def51
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Sat Oct 20 11:45:28 2018 -0500
> 
>     Merge branch 'pci/enumeration'
>     
>       - Remove x86 and arm64 node-local allocation for host bridge structures
>         (Punit Agrawal)
>     
>       - Pay attention to device-specific _PXM node values (Jonathan Cameron)
>     
>       - Support new Immediate Readiness bit (Felipe Balbi)
>     
>     * pci/enumeration:
>       PCI: Add support for Immediate Readiness
>       ACPI/PCI: Pay attention to device-specific _PXM node values
>       x86/PCI: Remove node-local allocation when initialising host controller
>       arm64: PCI: Remove node-local allocations when initialising host controller
> 
> as the first bad commit, but the "PCI: Add support for Immediate Readiness"
> one was tested as "good" (full bisect log is attached).
> 
> I wonder if you have any ideas on what to check?

So reverting 17c91487364f (PCI/ASPM: Do not initialize link state when
aspm_disabled is set) on top of 4.20-rc4 makes the problem go away.

I guess that the device in question needs pcie_aspm_cap_init() to be
called for it even though the FADT says "NO_ASPM".

Thanks,
Rafael



