Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BFFC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286E8218AE
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545230724;
	bh=9AQXShcSPbBId+URrHxWcVwijfM4K0bBMQQ678YgTe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QovWxk3tcsjlKmOruZDxlA95CfaY75nCSvhbcXcr7c3OyVk0D0JAr+CSs7lrGT8v7
	 fQwG1Z3WTWxcfkSefi0J5SvIwRORS8mfaF9mbfmlgvC0l0RlEzxJlt6S+HVSJkBWGC
	 exKJiH6Yd0VnUDQamnZ7FDTQ/SmYtRQPG/Vo5Z8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeLSOpW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbeLSOpV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 09:45:21 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E7021841;
        Wed, 19 Dec 2018 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545230720;
        bh=9AQXShcSPbBId+URrHxWcVwijfM4K0bBMQQ678YgTe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DheA+fEG975C1tEFgWO0rK7VpSHAvR4YQ0b9knbAdtTp+2Ac25MMC/NDtir9N/PCy
         12CqEoTmttrPMfoaqw8xnSKCBkAPKRZl5OX86t06ggLi+oJWro6UGxVPAzsPvMki3I
         9kcdCQxNvMg8JoxwFq1Xysz+QFVTJDFyaoUDbT/o=
Date:   Wed, 19 Dec 2018 08:45:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181219144518.GC12763@google.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com>
 <20181219132324.GS2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219132324.GS2469@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 03:23:24PM +0200, Mika Westerberg wrote:
> On Tue, Dec 18, 2018 at 02:58:50PM -0600, Bjorn Helgaas wrote:
> > > > For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> > > > basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> > > > aren't using pciehp, we should assume any hotplug would be handled via
> > > > acpiphp?  And in that case, we should avoid doing anything that would
> > > > prevent platform firmware from enumerating things below the bridge?
> > > 
> > > I don't see why that would not work. This could cause "power regression"
> > > on some systems but I think that's better than systems that do not work
> > > at all.
> > 
> > Yeah, I think that would be better, assuming it wouldn't cause a flood
> > of power regressions.  I'd even rather have a whitelist of systems
> > where we use acpiphp and it's safe to do power management.
> 
> Actually it looks like it would break power management of other
> components such as xHCI and Thunderbolt controller which are connected
> to a downstream port that has "Slot implemented" set as well.

To be precise, I think you mean that if we avoided power management on
ports with "Slot Implemented", ports leading to xHCI and Thunderbolt
would consume more power but would work correctly, right?  And the
theory is that those ports work even if the OS puts them into D3
because the firmware is smart enough to wake them up before poking
things below them?  Doesn't that make the port's power state out of
sync with what the OS thinks it is?

> I have another idea, though. Windows says the Gigabyte system platform
> role is "Desktop" whereas on another system where Windows does power
> manage the ports the role is "Mobile". I think this maps directly to
> ACPI FADT table Preferred_PM_Profile field (there is sysfs attribute
> /sys/firmware/acpi/pm_profile exposing this as well).
> 
> I wonder if we could use this information in pci_bridge_d3_possible() so
> that anything with "Desktop" profile returns false when native PCIe
> hotplug is not used?

Hmmmm.  I guess it's plausible that Windows might be more aggressive
about power management for "Mobile" roles as opposed to "Desktop".
But there's not really a logical connection to this situation (PCI
hotplug is a rare, non-latency sensitive event, so why wouldn't we
save power on the Desktop as well?), so it feels like a heuristic that
might coincidentally work sometimes but is liable to break at others.

Popping back up to the top of the stack, what's the situation on other
systems?  On this system, PCI_EXP_SLTCAP_HPC is not set.  Do other systems
have that set but clear OSC_PCI_EXPRESS_NATIVE_HP_CONTROL so we don't use
pciehp?  Should this be some sort of quirk?  I guess that's morally
equivalent to the blacklist.  But maybe it would be a more direct hint to
BIOS writers that this is a defect?

> > I think a kernel.org bugzilla that archived the "lspci -vv", a dmesg
> > log, and an acpidump might be helpful.
> 
> Here it is:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202031

Thanks!

Bjorn
