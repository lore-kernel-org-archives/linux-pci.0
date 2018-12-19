Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE9C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2005B218CD
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeLSPQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:16:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:61769 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbeLSPQE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 10:16:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 07:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="99950054"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 19 Dec 2018 07:15:59 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Dec 2018 17:15:58 +0200
Date:   Wed, 19 Dec 2018 17:15:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181219151558.GU2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com>
 <20181219132324.GS2469@lahna.fi.intel.com>
 <20181219144518.GC12763@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219144518.GC12763@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 08:45:19AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 19, 2018 at 03:23:24PM +0200, Mika Westerberg wrote:
> > On Tue, Dec 18, 2018 at 02:58:50PM -0600, Bjorn Helgaas wrote:
> > > > > For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> > > > > basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> > > > > aren't using pciehp, we should assume any hotplug would be handled via
> > > > > acpiphp?  And in that case, we should avoid doing anything that would
> > > > > prevent platform firmware from enumerating things below the bridge?
> > > > 
> > > > I don't see why that would not work. This could cause "power regression"
> > > > on some systems but I think that's better than systems that do not work
> > > > at all.
> > > 
> > > Yeah, I think that would be better, assuming it wouldn't cause a flood
> > > of power regressions.  I'd even rather have a whitelist of systems
> > > where we use acpiphp and it's safe to do power management.
> > 
> > Actually it looks like it would break power management of other
> > components such as xHCI and Thunderbolt controller which are connected
> > to a downstream port that has "Slot implemented" set as well.
> 
> To be precise, I think you mean that if we avoided power management on
> ports with "Slot Implemented", ports leading to xHCI and Thunderbolt
> would consume more power but would work correctly, right?  And the
> theory is that those ports work even if the OS puts them into D3
> because the firmware is smart enough to wake them up before poking
> things below them?  Doesn't that make the port's power state out of
> sync with what the OS thinks it is?

I think better example where this fails is normal Thunderbolt device
(not host) which includes PCIe switch and there is an PCIe endpoint, say
network interface connected to one of the downstream ports. That
downstream port has "Slot implemented" set but is not hotplug capable.

So the device would work correctly but if you take the recent "Runtime
D3, RTD3" system such as Lenovo Carbon X1 6th gen it keeps the whole
PCIe hierarchy from entering D3cold. I would rather not to break that ;-)

> > I have another idea, though. Windows says the Gigabyte system platform
> > role is "Desktop" whereas on another system where Windows does power
> > manage the ports the role is "Mobile". I think this maps directly to
> > ACPI FADT table Preferred_PM_Profile field (there is sysfs attribute
> > /sys/firmware/acpi/pm_profile exposing this as well).
> > 
> > I wonder if we could use this information in pci_bridge_d3_possible() so
> > that anything with "Desktop" profile returns false when native PCIe
> > hotplug is not used?
> 
> Hmmmm.  I guess it's plausible that Windows might be more aggressive
> about power management for "Mobile" roles as opposed to "Desktop".
> But there's not really a logical connection to this situation (PCI
> hotplug is a rare, non-latency sensitive event, so why wouldn't we
> save power on the Desktop as well?), so it feels like a heuristic that
> might coincidentally work sometimes but is liable to break at others.

OK.

> Popping back up to the top of the stack, what's the situation on other
> systems?  On this system, PCI_EXP_SLTCAP_HPC is not set.  Do other systems
> have that set but clear OSC_PCI_EXPRESS_NATIVE_HP_CONTROL so we don't use
> pciehp?  Should this be some sort of quirk?  I guess that's morally
> equivalent to the blacklist.  But maybe it would be a more direct hint to
> BIOS writers that this is a defect?

Yes, typically these systems have PCI_EXP_SLTCAP_HPC set but BIOS does
not allow "PCIeHotplug" in _OSC which prevents pciehp from controlling
them.

I'm not sure if this is actually a defect in BIOS because again this
works fine in Windows and I don't see in any specs (ACPI/PCIe) saying
you cannot do this.

By a quirk you mean add DMI based quirk somewhere in drivers/pci/quirks.c
which makes this root port to have ->is_hotplug_bridge set?
