Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA823C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31520850
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 18:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB31520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLDSeW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:34:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:33147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSeV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Dec 2018 13:34:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 10:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96092207"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 04 Dec 2018 10:34:17 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Dec 2018 20:34:16 +0200
Date:   Tue, 4 Dec 2018 20:34:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181204183416.GD2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <6545061.J5ZaFccAEN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6545061.J5ZaFccAEN@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 06:55:41PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 4, 2018 12:20:48 PM CET Mika Westerberg wrote:
> > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > connected to an Alpine Ridge Thunderbolt controller. This port has slot
> > implemented bit set in the config space but other than that it is not
> > hotplug capable in the sense we are expecting in Linux (it has
> > dev->is_hotplug_bridge set to 0):
> > 
> > 00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
> >         Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
> >         Memory behind bridge: 78000000-8fffffff [size=384M]
> >         Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
> >         ...
> >         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> >         ...
> >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> >                         Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
> >                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> >                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> >                         Changed: MRL- PresDet+ LinkState+
> > 
> > This system is using ACPI based hotplug to notify the OS that it needs
> > to rescan the PCI bus (ACPI hotplug).
> > 
> > If there is nothing connected in any of the Thunderbolt ports the root
> > port will not have any runtime PM active children and is thus
> > automatically runtime suspended pretty soon after boot by PCI PM core.
> > Now, when a device is connected the BIOS SMI handler responsible for
> > enumerating newly added devices is not able to find anything because the
> > port is in D3.
> > 
> > Prevent this from happening by blacklisting PCI power management of this
> > particular Gigabyte system.
> > 
> > Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > I checked booting Windows on the same system and it does not put any of the
> > PCIe root ports to low power states so there is no issue in Windows. I'm
> > also quite certain Windows does not have similar blacklist.
> 
> Well, that only means that Windows uses a different approach to decide whether
> or not to use PCI PM on PCIe root ports (but we knew that that would be the
> case upfront, didn't we?).

Indeed we did.

> > I wonder if our pci_bridge_d3_possible() heuristics would need to be
> > refined somehow? At least if this blacklist starts growing.
> 
> Because Windows uses a different approach here, there will be systems for
> which Linux will decide to use PCI PM with PCIe root ports and Windows
> won't (or vice versa).  That will cause Linux to use configurations that
> have not been validated against Windows, so it is likely that some of them
> will not work.  Hence, the need for a blacklist is not a surprise really.

Fair enough :)

> So
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

> BTW, what version of Windows you have tested?

I only tested Windows 10 1803.
