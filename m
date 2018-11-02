Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC5C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 23:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC8E2081F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 23:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8E2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeKCIjM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:39:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeKCIjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Nov 2018 04:39:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pzsfQp6ePQH9; Sat,  3 Nov 2018 00:30:00 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD3B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:3b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E428E1EC0A67;
        Sat,  3 Nov 2018 00:29:59 +0100 (CET)
Date:   Sat, 3 Nov 2018 00:29:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181102232948.GC26770@zn.tnic>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102195925.GB160487@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 02:59:25PM -0500, Bjorn Helgaas wrote:
> This isn't my code, and I'm not really objecting to these changes, but
> from where I sit, the fact that you need this sort of vendor-specific
> topology discovery is a little bit ugly and seems like something of a
> maintenance issue.  You could argue that this is sort of an "AMD CPU
> driver", which is entitled to be device-specific, and that does make
> some sense.

It is a bunch of glue code which enumerates the PCI devices a CPU
has and other in-kernel users can use that instead of doing the
discovery/enumeration themselves.

> But device-specific code is typically packaged as a driver that uses
> driver registration interfaces like acpi_bus_register_driver(),
> pci_register_driver(), etc.  That gives you a consistent structure
> and, more importantly, a framework for dealing with hotplug.  It
> doesn't look like amd_nb.c would deal well with hot-add of CPUs.

If you mean physical hotadd, then that's a non-issue as, AFAIK, AMD
doesn't support that.

Now, TBH I've never tried soft-offlining the cores of a node and then
check whether using the PCI devices of that node would work.

Now, I don't mind this getting converted to a proper PCI driver as long
as it is not a module as it has to be present at all times. Other than
that, I'm a happy camper.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
