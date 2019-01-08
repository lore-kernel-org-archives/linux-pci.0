Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F2C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 09:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C759E218A1
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAHJfM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:35:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:12675 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHJfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 04:35:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 01:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="115071569"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 08 Jan 2019 01:35:07 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Jan 2019 11:35:07 +0200
Date:   Tue, 8 Jan 2019 11:35:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with
 slot implemented bit set
Message-ID: <20190108093507.GX2469@lahna.fi.intel.com>
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 02:13:14PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 7, 2019 at 2:01 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > connected to Alpine Ridge Thunderbolt controller. This port has slot
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
> > If there is nothing connected to any of the Thunderbolt ports the root
> > port will not have any runtime PM active children and is thus
> > automatically runtime suspended pretty soon after boot by PCI PM core.
> > Now, when a device is connected the BIOS SMI handler responsible for
> > enumerating newly added devices is not able to find anything because the
> > port is in D3.
> >
> > For this reason we block power management of PCIe root and downstream
> > ports that have slot implemented set and have node in ACPI namespace.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
> > Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

However, I'm having second toughts about this because I remembered that
people put a lot of effort getting discrete graphics with power resource
attached to the root port powering off properly. If the root port
matches the criteria in this patch it will not be able to go into D3
anymore. It might affect others such as M.2 connected NVMe or WiFi chip
as well. For that reason I would still prefer blacklist, at least for now.
