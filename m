Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ACC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCFD2086B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 23:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y5euTXCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCFD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeKGIsW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeKGIsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 03:48:21 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD912083D;
        Tue,  6 Nov 2018 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541546443;
        bh=QkxJS33/931SZmN8xFiN/errCtyyvefM/HjeAlqTP4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5euTXCWe3AT4bT8rf6itq0FNPTBu/9NVtDUGrnRWnKixje8JeKSpn+sfvWn2q7Bv
         LQtC+C5JJ8ZQuenDXWYcJ3MKExWK32w/iVElmm64Y+44aiyZyzI4CgrWYswKFBolLr
         NQIO038SXGrDJT9gA9EC8NYSeWOdeDAQI78RK1us=
Date:   Tue, 6 Nov 2018 17:20:41 -0600
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
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181106232040.GA85755@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106220059.GA4139@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sumeet, Srinivas for INT3401 questions below]
[Beginning of thread:
https://lore.kernel.org/linux-pci/20181102181055.130531-1-brian.woods@amd.com/]

On Tue, Nov 06, 2018 at 11:00:59PM +0100, Borislav Petkov wrote:
> On Tue, Nov 06, 2018 at 03:42:56PM -0600, Bjorn Helgaas wrote:
> > This isn't some complicated new device where the programming model
> > changed on the new CPU.  This is a thermometer that was already
> > supported.  ACPI provides plenty of functionality that could be used
> > to support this generically, e.g., see drivers/acpi/thermal.c,
> > drivers/thermal/int340x_thermal/processor_thermal_device.c, etc.
> 
> Ok, you say ACPI but how do you envision practically doing that? I mean,
> this is used by old boxes too - ever since K8. So how do we go and add
> ACPI functionality to old boxes?
> 
> Or do you mean it should simply be converted to do pci_register_driver()
> with a struct pci_driver pointer which has all those PCI device IDs in a
> table? I'm looking at the last example
> drivers/thermal/int340x_thermal/processor_thermal_device.c you gave above.

No, there would be no need to change anything for boxes already in the
field.  But for *new* systems, you could make devices or thermal zones
in the ACPI namespace (they might even already be there for use by
Windows).

drivers/thermal/int340x_thermal/processor_thermal_device.c claims
either INT3401 ACPI devices or listed PCI devices.  It looks like it
tries the platform (INT3401) devices first, and if it finds any, it
ignores any matching PCI devices.  This *could* be so it uses INT3401
devices on new platforms and falls back to the PCI devices otherwise,
although there *are* recent updates that add PCI IDs.

It looks like INT3401 is Intel-specific since it uses a PPCC method
which isn't defined by the ACPI spec.  But AMD could define a similar
PNP ID and have new platforms expose ACPI devices with _TMP methods
that know how to read the sensor on that platform.

Or maybe even drivers/acpi/thermal.c, which claims every Thermal Zone
(ACPI 6.2, sec 11), would be sufficient.  I don't know what the
relationship between hwmon and other thermal stuff, e.g.,
Documentation/thermal/sysfs-api.txt is.  acpi/thermal.c looks tied
into the drivers/thermal stuff (it registers "thermal_zone" devices),
but not to hwmon.

> > But maybe there's some real value in the nitty-gritty device-specific
> > code in amd_nb.c.  If so, I guess you're stuck with updates like this
> > and negotiating with the distros to do backports and new releases.
> 
> Well, even if it is converted to a different registration scheme, you
> still need to add new PCI device IDs to the table, no? So *some* sort of
> enablement still needs to happen.

As long as we have a driver that knows how to claim a known PNP ID,
and every new platform exposes a device compatible with that ID, the
driver should just work.

Bjorn
