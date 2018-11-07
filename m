Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A394C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 21:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96BA21104
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 21:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyjKRkiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96BA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeKHHDT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeKHHDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 02:03:19 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7554620989;
        Wed,  7 Nov 2018 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541626264;
        bh=9OcHz1ZO9RiJIz00bdBrKdzIAigrSQHuInkicXsdwkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyjKRkiYL4HpIad0mRaiwAgRDWqBLpOkiwqWK4eRIbqTLOcf7+jCqdpqz1Zo0p3mh
         W09pcDm8ELYfnmqeNjsbpNDTjXVPokRQG69fD+qXQ94chEJzg/YiPDqXY9E3UyIWy2
         SellyX5qUhdzLnchbnRPTzLLkJDG0/ZqnUwsDJ1Y=
Date:   Wed, 7 Nov 2018 15:31:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Woods, Brian" <Brian.Woods@amd.com>,
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
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181107213103.GA41183@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <75748b089ee696d5cbaa5c0ce68bad228699894c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75748b089ee696d5cbaa5c0ce68bad228699894c.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 11:15:37AM -0800, Srinivas Pandruvada wrote:
> On Tue, 2018-11-06 at 17:20 -0600, Bjorn Helgaas wrote:
> > [+cc Sumeet, Srinivas for INT3401 questions below]
> > [Beginning of thread:
> > 
> https://lore.kernel.org/linux-pci/20181102181055.130531-1-brian.woods@amd.com/
> > ]
> > 
> > On Tue, Nov 06, 2018 at 11:00:59PM +0100, Borislav Petkov wrote:
> > > On Tue, Nov 06, 2018 at 03:42:56PM -0600, Bjorn Helgaas wrote:
> > > > This isn't some complicated new device where the programming
> > > > model changed on the new CPU.  This is a thermometer that was
> > > > already supported.  ACPI provides plenty of functionality that
> > > > could be used to support this generically, e.g., see
> > > > drivers/acpi/thermal.c,
> > > > drivers/thermal/int340x_thermal/processor_thermal_device.c,
> > > > etc.
> > > 
> > > Ok, you say ACPI but how do you envision practically doing that?
> > > I mean, this is used by old boxes too - ever since K8. So how do
> > > we go and add ACPI functionality to old boxes?
> > > 
> > > Or do you mean it should simply be converted to do
> > > pci_register_driver() with a struct pci_driver pointer which has
> > > all those PCI device IDs in a table? I'm looking at the last
> > > example
> > > drivers/thermal/int340x_thermal/processor_thermal_device.c you
> > > gave above.
> > 
> > No, there would be no need to change anything for boxes already in
> > the field.  But for *new* systems, you could make devices or
> > thermal zones in the ACPI namespace (they might even already be
> > there for use by Windows).
> > 
> > drivers/thermal/int340x_thermal/processor_thermal_device.c claims
> > either INT3401 ACPI devices or listed PCI devices. 
> 
> To enumerate a driver to get processor temperature and get power
> properties, we have two methods:
> -  The older Atom processors valleyview and Baytrail had no PCI device
> for the processor thermal management. There was INT3401 ACPI device to
> handle this.
> 
> - The newer processors for core and Atom, has a dedicate PCI device and
> there is no INT3401 ACPI device anymore.

This is really interesting because it's completely the reverse of what
I would have expected.

You use INT3401 on the *older* processors, where int3401_add() is
called for any platform devices with INT3401 PNP ID:

  int3401_add(plat_dev)                   # platform/ACPI .probe
    proc_thermal_add(dev)
      adev = ACPI_COMPANION(dev)
      int340x_thermal_zone_add(adev)
	thermal_zone_device_register()

The sensors are read in this path, where thermal_zone_get_temp() is
the generic thermal entry point:

  thermal_zone_get_temp()
    tz->ops->get_temp()
      int340x_thermal_get_zone_temp()    # ops.get_temp
	acpi_evaluate_integer(..., "_TMP", ...)

The above works for any platform that supplies the INT3401 device
because the _TMP method that actually reads the sensor is supplied by
the platform firmware.

On *newer* processors, you apparently use this path:

  proc_thermal_pci_probe(pci_dev)        # PCI .probe
    pci_enable_device(pci_dev)
    proc_thermal_add(dev)
      adev = ACPI_COMPANION(dev)
      int340x_thermal_zone_add(adev)
	thermal_zone_device_register()

Except for enabling the PCI device and a BSW_THERMAL hack, this is
exactly the *SAME*: you add a thermal zone for the ACPI device and
read the sensor using ACPI _TMP methods.

But now you have to add new PCI IDs (Skylake, Broxton, CannonLake,
CoffeeLake, GeminiLake, etc) for every new platform.  This seems like
a regression, not an improvement.  What am I missing?

> Since OEM systems will have different power properties and thermal
> trips, there is a companion ACPI device, which provides PPCC and
> thermal trips and optionally output from another temperature sensor
> from the default on processor cores.

Bjorn
