Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF146C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EAB20818
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EAB20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeKHErV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:47:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:65171 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKHErV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 23:47:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 11:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="272195407"
Received: from spandruv-mobl3.jf.intel.com ([10.251.141.153])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2018 11:15:37 -0800
Message-ID: <75748b089ee696d5cbaa5c0ce68bad228699894c.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Borislav Petkov <bp@alien8.de>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Wed, 07 Nov 2018 11:15:37 -0800
In-Reply-To: <20181106232040.GA85755@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
         <20181102181055.130531-3-brian.woods@amd.com>
         <20181102195925.GB160487@google.com> <20181102232948.GC26770@zn.tnic>
         <20181105214537.GA19420@google.com> <20181105215650.GG26868@zn.tnic>
         <20181106214256.GA65443@google.com> <20181106220059.GA4139@zn.tnic>
         <20181106232040.GA85755@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-11-06 at 17:20 -0600, Bjorn Helgaas wrote:
> [+cc Sumeet, Srinivas for INT3401 questions below]
> [Beginning of thread:
> 
https://lore.kernel.org/linux-pci/20181102181055.130531-1-brian.woods@amd.com/
> ]
> 
> On Tue, Nov 06, 2018 at 11:00:59PM +0100, Borislav Petkov wrote:
> > On Tue, Nov 06, 2018 at 03:42:56PM -0600, Bjorn Helgaas wrote:
> > > This isn't some complicated new device where the programming
> > > model
> > > changed on the new CPU.  This is a thermometer that was already
> > > supported.  ACPI provides plenty of functionality that could be
> > > used
> > > to support this generically, e.g., see drivers/acpi/thermal.c,
> > > drivers/thermal/int340x_thermal/processor_thermal_device.c, etc.
> > 
> > Ok, you say ACPI but how do you envision practically doing that? I
> > mean,
> > this is used by old boxes too - ever since K8. So how do we go and
> > add
> > ACPI functionality to old boxes?
> > 
> > Or do you mean it should simply be converted to do
> > pci_register_driver()
> > with a struct pci_driver pointer which has all those PCI device IDs
> > in a
> > table? I'm looking at the last example
> > drivers/thermal/int340x_thermal/processor_thermal_device.c you gave
> > above.
> 
> No, there would be no need to change anything for boxes already in
> the
> field.  But for *new* systems, you could make devices or thermal
> zones
> in the ACPI namespace (they might even already be there for use by
> Windows).
> 
> drivers/thermal/int340x_thermal/processor_thermal_device.c claims
> either INT3401 ACPI devices or listed PCI devices. 

To enumerate a driver to get processor temperature and get power
properties, we have two methods:
-  The older Atom processors valleyview and Baytrail had no PCI device
for the processor thermal management. There was INT3401 ACPI device to
handle this.

- The newer processors for core and Atom, has a dedicate PCI device and
there is no INT3401 ACPI device anymore.
Since OEM systems will have different power properties and thermal
trips, there is a companion ACPI device, which provides PPCC and
thermal trips and optionally output from another temperature sensor
from the default on processor cores.

Thanks,
Srinivas



>  It looks like it
> tries the platform (INT3401) devices first, and if it finds any, it
> ignores any matching PCI devices.  This *could* be so it uses INT3401
> devices on new platforms and falls back to the PCI devices otherwise,
> although there *are* recent updates that add PCI IDs.
> 
> It looks like INT3401 is Intel-specific since it uses a PPCC method
> which isn't defined by the ACPI spec.  But AMD could define a similar
> PNP ID and have new platforms expose ACPI devices with _TMP methods
> that know how to read the sensor on that platform.
> 
> Or maybe even drivers/acpi/thermal.c, which claims every Thermal Zone
> (ACPI 6.2, sec 11), would be sufficient.  I don't know what the
> relationship between hwmon and other thermal stuff, e.g.,
> Documentation/thermal/sysfs-api.txt is.  acpi/thermal.c looks tied
> into the drivers/thermal stuff (it registers "thermal_zone" devices),
> but not to hwmon.
> 
> > > But maybe there's some real value in the nitty-gritty device-
> > > specific
> > > code in amd_nb.c.  If so, I guess you're stuck with updates like
> > > this
> > > and negotiating with the distros to do backports and new
> > > releases.
> > 
> > Well, even if it is converted to a different registration scheme,
> > you
> > still need to add new PCI device IDs to the table, no? So *some*
> > sort of
> > enablement still needs to happen.
> 
> As long as we have a driver that knows how to claim a known PNP ID,
> and every new platform exposes a device compatible with that ID, the
> driver should just work.
> 
> Bjorn

