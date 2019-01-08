Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B45C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 11:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1862087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="AcZtlXtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfAHLjN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:39:13 -0500
Received: from lekensteyn.nl ([178.21.112.251]:59513 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfAHLjM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 06:39:12 -0500
X-Greylist: delayed 2434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 06:39:11 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GkkBMi9rK4MY2T/zGv2N61kd/bH3KUwoSZkccuMtahg=;
        b=AcZtlXtpimm6QfXL3Qr3wX/Lb4KZv+g6SKRcnTHxuL15pxSDK/swW0tJ2ZaOR68YnHcZYczvowWPupg3Z4bJLm9qgBIEA5/aurLT5RsEy+dAob+En/vs8MTeQSGHRhqBhTjrz2vtuAT6ivkINCc/5cMz2KXYb33o0AVrq0CFbHqhD+Q5LuhQ37pS1WGi5Bx4ZAns3vRKnUpv7RU62caLy3rIKix9jt+RX1LAErNkEudbHC/Uf570KZ8/6QRzaBIEntNUgiwgYycYrvrGIDH6lVVZOD/f23wk7YmN3a8tHnPWUJm9X2QT2gM1BKrJbX/t5ynkcGXNv+WlTOM37FCKMw==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1ggp5X-0005W6-1z; Tue, 08 Jan 2019 11:58:28 +0100
Date:   Tue, 8 Jan 2019 11:58:24 +0100
From:   Peter Wu <peter@lekensteyn.nl>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with
 slot implemented bit set
Message-ID: <20190108105824.GC23218@al>
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
 <20190108093507.GX2469@lahna.fi.intel.com>
 <20190108101600.5qbeks5ux6wgpbpy@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108101600.5qbeks5ux6wgpbpy@wunner.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Tue, Jan 08, 2019 at 11:16:00AM +0100, Lukas Wunner wrote:
> Hi Peter,
> 
> On Tue, Jan 08, 2019 at 11:35:07AM +0200, Mika Westerberg wrote:
> > On Mon, Jan 07, 2019 at 02:13:14PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 7, 2019 at 2:01 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > > > connected to Alpine Ridge Thunderbolt controller. This port has slot
> > > > implemented bit set in the config space but other than that it is not
> > > > hotplug capable in the sense we are expecting in Linux (it has
> > > > dev->is_hotplug_bridge set to 0):
> > > >
> > > > 00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
> > > >         Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
> > > >         Memory behind bridge: 78000000-8fffffff [size=384M]
> > > >         Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
> > > >         ...
> > > >         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> > > >         ...
> > > >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> > > >                         Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
> > > >                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> > > >                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> > > >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> > > >                         Changed: MRL- PresDet+ LinkState+
> > > >
> > > > This system is using ACPI based hotplug to notify the OS that it needs
> > > > to rescan the PCI bus (ACPI hotplug).
> > > >
> > > > If there is nothing connected to any of the Thunderbolt ports the root
> > > > port will not have any runtime PM active children and is thus
> > > > automatically runtime suspended pretty soon after boot by PCI PM core.
> > > > Now, when a device is connected the BIOS SMI handler responsible for
> > > > enumerating newly added devices is not able to find anything because the
> > > > port is in D3.
> > > >
> > > > For this reason we block power management of PCIe root and downstream
> > > > ports that have slot implemented set and have node in ACPI namespace.
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
> > > > Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Thanks!
> > 
> > However, I'm having second toughts about this because I remembered that
> > people put a lot of effort getting discrete graphics with power resource
> > attached to the root port powering off properly. If the root port
> > matches the criteria in this patch it will not be able to go into D3
> > anymore. It might affect others such as M.2 connected NVMe or WiFi chip
> > as well. For that reason I would still prefer blacklist, at least for now.
> 
> Would this patch:
> 
>     https://patchwork.ozlabs.org/patch/1021317/
> 
> break runtime D3cold for the discrete GPU on Optimus laptops such as
> your Clevo P651RA?  Specifically, is the Root Port above the GPU
> marked "(Slot+)" in lspci -vv?  (There doesn't seem to be raw lspci
> output in https://github.com/Lekensteyn/acpi-stuff)

Thanks for bringing this into my attention. There are a couple of full
lspci dumps, for example for the Dell XPS 9560.
https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/lspci-bare-metal.txt
This has upstream port 00:01.0 attached to GPU 01:00.0

    00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05) (prog-if 00 [Normal decode])
        ...
        Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00

and would indeed be negatively affected by this patch. I can observe the
same for the Clevo P651RA (for which I can also send the full lspci dump
if you need).
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
