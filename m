Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C904C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F962086C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGIhduY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F962086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeKGXJY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbeKGXJX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 18:09:23 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3FE20827;
        Wed,  7 Nov 2018 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541597938;
        bh=plqyVMmwSeRWeNQCuL+ZxiUUW6gHULnNniL/ZqnXyDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGIhduY6vYBRJrj7VVkLKqSWNwH4hXN9WCvG+nXStAKQUNrmjcmrXL6q65WUMP2O/
         N9oAgDIz3TL6eQs+nAyrPG0/VrQ1nSDzWc/w1XbGrdZ5w0GnuON7NDn/r6NL8UB89d
         ei6TNOpqlEQBu+vBE8p22eqGbqXbZ/igjBoI6e9U=
Date:   Wed, 7 Nov 2018 07:38:56 -0600
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
Message-ID: <20181107133856.GA238955@google.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <20181107091838.GA10835@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107091838.GA10835@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 10:18:38AM +0100, Borislav Petkov wrote:
> On Tue, Nov 06, 2018 at 05:20:41PM -0600, Bjorn Helgaas wrote:
> > Or maybe even drivers/acpi/thermal.c, which claims every Thermal Zone
> > (ACPI 6.2, sec 11), would be sufficient.  I don't know what the
> > relationship between hwmon and other thermal stuff, e.g.,
> > Documentation/thermal/sysfs-api.txt is.  acpi/thermal.c looks tied
> > into the drivers/thermal stuff (it registers "thermal_zone" devices),
> > but not to hwmon.
> 
> Err, I still don't think I'm catching your drift but let me stop you
> right there: amd_nb is not there only for hwmon/k10temp. It is a small
> interface glue if you will, which exports the CPU functionality in PCI
> config space to other consumers.
> 
> So it is not really a driver - it is used by drivers to talk/query CPU
> settings through it.
> 
> With that said, I don't think I understand all that talk about PNP IDs
> and ACPI methods. But maybe I'm missing something...

Firmware supplies ACPI namespace.  The namespace contains an abstract
description of the platform, including devices.  Devices are
identified by PNP IDs, which are analogous to PCI vendor/device IDs,
except that a device may have several generic "compatible device IDs"
in addition to an ID unique to the device.  Devices may also contain
methods (supplied by firmware as part of the namespace), which are
essentially bytecode that can be executed by the ACPI interpreter in
the kernel.  Linux drivers claim ACPI devices based on PNP ID and
operate them using either ACPI methods (which can decouple the driver
from device specifics) or the usual direct MMIO/IO port/MSR style.

Here's an outline of how it *could* work:

  - AMD defines "AMD0001" device ID for the CPU temp sensor
  - BIOS supplies AMD0001 devices in the ACPI namespace
  - Each AMD0001 device has a _TMP method (supplied by BIOS and
    specific to the CPU)
  - Linux driver claims AMD0001 devices
  - Driver reads temp sensors by executing _TMP methods (Linux ACPI
    interpreter runs the bytecode)

That way when you release a new platform with different temp sensors,
you update the BIOS AMD0001 devices and _TMP methods to know about
them, and the old Linux driver works unchanged.

Bjorn
