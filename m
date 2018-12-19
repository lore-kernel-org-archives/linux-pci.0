Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A097C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB33218D8
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeLSRJS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:09:18 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:55815 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSRJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 12:09:18 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id AE3822801BBD8;
        Wed, 19 Dec 2018 18:09:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6B22A1DD452; Wed, 19 Dec 2018 18:09:15 +0100 (CET)
Date:   Wed, 19 Dec 2018 18:09:15 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181219170915.3bojdcf7h7kiesyu@wunner.de>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com>
 <20181219132324.GS2469@lahna.fi.intel.com>
 <20181219144518.GC12763@google.com>
 <20181219151558.GU2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219151558.GU2469@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 05:15:58PM +0200, Mika Westerberg wrote:
> On Wed, Dec 19, 2018 at 08:45:19AM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 19, 2018 at 03:23:24PM +0200, Mika Westerberg wrote:
> > > On Tue, Dec 18, 2018 at 02:58:50PM -0600, Bjorn Helgaas wrote:
> > > > > > For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> > > > > > basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> > > > > > aren't using pciehp, we should assume any hotplug would be handled via
> > > > > > acpiphp?  And in that case, we should avoid doing anything that would
> > > > > > prevent platform firmware from enumerating things below the bridge?
> > > 
> > > Actually it looks like it would break power management of other
> > > components such as xHCI and Thunderbolt controller which are connected
> > > to a downstream port that has "Slot implemented" set as well.
> > 
> > To be precise, I think you mean that if we avoided power management on
> > ports with "Slot Implemented", ports leading to xHCI and Thunderbolt
> > would consume more power but would work correctly, right?  And the
> > theory is that those ports work even if the OS puts them into D3
> > because the firmware is smart enough to wake them up before poking
> > things below them?  Doesn't that make the port's power state out of
> > sync with what the OS thinks it is?
> 
> I think better example where this fails is normal Thunderbolt device
> (not host) which includes PCIe switch and there is an PCIe endpoint, say
> network interface connected to one of the downstream ports. That
> downstream port has "Slot implemented" set but is not hotplug capable.
> 
> So the device would work correctly but if you take the recent "Runtime
> D3, RTD3" system such as Lenovo Carbon X1 6th gen it keeps the whole
> PCIe hierarchy from entering D3cold. I would rather not to break that ;-)

Yeah but as you say, those are Downstream Ports.  What if you constrain
it to Root Ports?

Thanks,

Lukas
