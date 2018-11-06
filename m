Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B2C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546192086B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yQf2ERJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546192086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKGHKP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeKGHKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 02:10:15 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B572083D;
        Tue,  6 Nov 2018 21:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541540579;
        bh=RiWmuU2IRgm9uNhmfdnA1rMKWj/qgJAF0GlYQfkOwaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQf2ERJ0xSCf8V6nt8TkDjb6kmS/SiBosYuMjs1d7nbZWzuKwMBxvLOqJw/8vmOMq
         45w2jcRY2f3rN+HPXBHfYsMtsFsXBZzfFTY1B5weoalZdSUGzYF2khiV/61Go34uV2
         9f2Snca39RkwrhaJOp/tA9oMyg8uULODl0kOc4aQ=
Date:   Tue, 6 Nov 2018 15:42:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181106214256.GA65443@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105215650.GG26868@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 10:56:50PM +0100, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 03:45:37PM -0600, Bjorn Helgaas wrote:
> > amd_nb.c prevents us from achieving that goal.  These patches don't
> > add new functionality; they merely describe minor topographical
> > differences in new hardware.  We usually try to do that in a more
> > generic way, e.g., via an ACPI method, so the new platform can update
> > the ACPI method and use an old, already-qualified, already-shipped
> > kernel.
> > 
> > I'm not strenuously objecting to these because this isn't a *huge*
> > deal, but I suspect it is a source of friction for distros that don't
> > want to update and requalify their software for every new platform.
> 
> Err, how is this any different from adding distro support for a new CPU
> family?
> 
> This is basically the same thing. When distros add support for new
> hardware, they have to backport patches for upstream. These PCI devices
> which are part of the CPU are part of that hardware enablement.
> 
> So there's no way around doing that enablement. I don't think you can do
> "old distro, new hardware" stuff without *some* hw enablement.

Just depends on how hard you want to work on defining abstract
interfaces.

This isn't some complicated new device where the programming model
changed on the new CPU.  This is a thermometer that was already
supported.  ACPI provides plenty of functionality that could be used
to support this generically, e.g., see drivers/acpi/thermal.c,
drivers/thermal/int340x_thermal/processor_thermal_device.c, etc.

But maybe there's some real value in the nitty-gritty device-specific
code in amd_nb.c.  If so, I guess you're stuck with updates like this
and negotiating with the distros to do backports and new releases.

Bjorn
