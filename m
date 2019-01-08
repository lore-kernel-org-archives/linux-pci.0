Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C86C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 10:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4716A2087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 10:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAHKQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:16:04 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:55771 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2019 05:16:04 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 52C562801B54D;
        Tue,  8 Jan 2019 11:16:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E687C16686; Tue,  8 Jan 2019 11:16:00 +0100 (CET)
Date:   Tue, 8 Jan 2019 11:16:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with
 slot implemented bit set
Message-ID: <20190108101600.5qbeks5ux6wgpbpy@wunner.de>
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
 <20190108093507.GX2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108093507.GX2469@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Peter,

On Tue, Jan 08, 2019 at 11:35:07AM +0200, Mika Westerberg wrote:
> On Mon, Jan 07, 2019 at 02:13:14PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 7, 2019 at 2:01 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > > connected to Alpine Ridge Thunderbolt controller. This port has slot
> > > implemented bit set in the config space but other than that it is not
> > > hotplug capable in the sense we are expecting in Linux (it has
> > > dev->is_hotplug_bridge set to 0):
> > >
> > > 00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
> > >         Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
> > >         Memory behind bridge: 78000000-8fffffff [size=384M]
> > >         Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
> > >         ...
> > >         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> > >         ...
> > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > >                         Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
> > >                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> > >                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> > >                         Changed: MRL- PresDet+ LinkState+
> > >
> > > This system is using ACPI based hotplug to notify the OS that it needs
> > > to rescan the PCI bus (ACPI hotplug).
> > >
> > > If there is nothing connected to any of the Thunderbolt ports the root
> > > port will not have any runtime PM active children and is thus
> > > automatically runtime suspended pretty soon after boot by PCI PM core.
> > > Now, when a device is connected the BIOS SMI handler responsible for
> > > enumerating newly added devices is not able to find anything because the
> > > port is in D3.
> > >
> > > For this reason we block power management of PCIe root and downstream
> > > ports that have slot implemented set and have node in ACPI namespace.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
> > > Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks!
> 
> However, I'm having second toughts about this because I remembered that
> people put a lot of effort getting discrete graphics with power resource
> attached to the root port powering off properly. If the root port
> matches the criteria in this patch it will not be able to go into D3
> anymore. It might affect others such as M.2 connected NVMe or WiFi chip
> as well. For that reason I would still prefer blacklist, at least for now.

Would this patch:

    https://patchwork.ozlabs.org/patch/1021317/

break runtime D3cold for the discrete GPU on Optimus laptops such as
your Clevo P651RA?  Specifically, is the Root Port above the GPU
marked "(Slot+)" in lspci -vv?  (There doesn't seem to be raw lspci
output in https://github.com/Lekensteyn/acpi-stuff)

Thanks,

Lukas
