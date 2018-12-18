Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38130C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126772184A
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeLRIzX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:55:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:51272 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRIzX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 03:55:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 00:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="260366992"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 18 Dec 2018 00:55:19 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 18 Dec 2018 10:55:18 +0200
Date:   Tue, 18 Dec 2018 10:55:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181218085518.GI2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217202827.GC28981@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 02:28:27PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 04, 2018 at 02:20:48PM +0300, Mika Westerberg wrote:
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
> 
> Ugh.  I don't see how this is a maintainable solution.  Are we going
> to have to just update this blacklist empirically as we get reports of
> systems that are "broken"?

I was hoping not but for that we would need to have some means to
identify these. What you suggest below might be one way to avoid adding
the blacklist.

> I say "broken" because I don't think we can point to anything here
> that doesn't conform to the specs, so maybe we tripped over something
> that *should* be covered in the spec, or maybe we're just not
> interpreting something correctly.

That is indeed possible.

> For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> aren't using pciehp, we should assume any hotplug would be handled via
> acpiphp?  And in that case, we should avoid doing anything that would
> prevent platform firmware from enumerating things below the bridge?

I don't see why that would not work. This could cause "power regression"
on some systems but I think that's better than systems that do not work
at all.

> > Prevent this from happening by blacklisting PCI power management of this
> > particular Gigabyte system.
> > 
> > Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> 
> Is there a bugzilla or any other URL we could include here to help with
> future changes in this area?

No, this was reported internally.

I can file one if you think it is helpful.
