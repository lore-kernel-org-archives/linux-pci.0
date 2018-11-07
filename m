Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA4AC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD83720827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 16:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD83720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeKHBiU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:38:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeKHBiU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 20:38:20 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lK5pCVWiX6yr; Wed,  7 Nov 2018 17:07:20 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 180A51EC0402;
        Wed,  7 Nov 2018 17:07:20 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:07:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181107160707.GA14169@zn.tnic>
References: <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <20181107091838.GA10835@zn.tnic>
 <20181107133856.GA238955@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107133856.GA238955@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 07:38:56AM -0600, Bjorn Helgaas wrote:
> Firmware supplies ACPI namespace.  The namespace contains an abstract
> description of the platform, including devices.  Devices are
> identified by PNP IDs, which are analogous to PCI vendor/device IDs,
> except that a device may have several generic "compatible device IDs"
> in addition to an ID unique to the device.  Devices may also contain
> methods (supplied by firmware as part of the namespace), which are
> essentially bytecode that can be executed by the ACPI interpreter in
> the kernel.  Linux drivers claim ACPI devices based on PNP ID and
> operate them using either ACPI methods (which can decouple the driver
> from device specifics) or the usual direct MMIO/IO port/MSR style.
> 
> Here's an outline of how it *could* work:
> 
>   - AMD defines "AMD0001" device ID for the CPU temp sensor
>   - BIOS supplies AMD0001 devices in the ACPI namespace
>   - Each AMD0001 device has a _TMP method (supplied by BIOS and
>     specific to the CPU)
>   - Linux driver claims AMD0001 devices
>   - Driver reads temp sensors by executing _TMP methods (Linux ACPI
>     interpreter runs the bytecode)

Thanks for explaining.

> That way when you release a new platform with different temp sensors,
> you update the BIOS AMD0001 devices and _TMP methods to know about
> them, and the old Linux driver works unchanged.

So I don't know about temp sensors - I'm talking about amd_nb which is
something... well, I explained already what it is in my previous mail so
I won't repeat myself.

Anyway, if there is such a PNP ID device - and I believe I have stumbled
upon some blurb about it in the BKDGs - which says "this device
represents the PCI device IDs of a CPU" and if that can be used to
register amd_nb through it, then sure, I don't see why not.

This way, when new CPU comes out and the same PNP ID device is present,
amd_nb would load, sure.

Maybe Brian knows more on the subject...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
