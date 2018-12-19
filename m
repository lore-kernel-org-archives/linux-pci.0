Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC19C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494BC218AF
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeLSNX3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:23:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:46342 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbeLSNX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 08:23:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 05:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="99923792"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 19 Dec 2018 05:23:25 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Dec 2018 15:23:24 +0200
Date:   Wed, 19 Dec 2018 15:23:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181219132324.GS2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218205850.GA12763@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 02:58:50PM -0600, Bjorn Helgaas wrote:
> > > For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> > > basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> > > aren't using pciehp, we should assume any hotplug would be handled via
> > > acpiphp?  And in that case, we should avoid doing anything that would
> > > prevent platform firmware from enumerating things below the bridge?
> > 
> > I don't see why that would not work. This could cause "power regression"
> > on some systems but I think that's better than systems that do not work
> > at all.
> 
> Yeah, I think that would be better, assuming it wouldn't cause a flood
> of power regressions.  I'd even rather have a whitelist of systems
> where we use acpiphp and it's safe to do power management.

Actually it looks like it would break power management of other
components such as xHCI and Thunderbolt controller which are connected
to a downstream port that has "Slot implemented" set as well.

I have another idea, though. Windows says the Gigabyte system platform
role is "Desktop" whereas on another system where Windows does power
manage the ports the role is "Mobile". I think this maps directly to
ACPI FADT table Preferred_PM_Profile field (there is sysfs attribute
/sys/firmware/acpi/pm_profile exposing this as well).

I wonder if we could use this information in pci_bridge_d3_possible() so
that anything with "Desktop" profile returns false when native PCIe
hotplug is not used?

> > > Is there a bugzilla or any other URL we could include here to help with
> > > future changes in this area?
> > 
> > No, this was reported internally.
> > 
> > I can file one if you think it is helpful.
> 
> I think a kernel.org bugzilla that archived the "lspci -vv", a dmesg
> log, and an acpidump might be helpful.

Here it is:

https://bugzilla.kernel.org/show_bug.cgi?id=202031
