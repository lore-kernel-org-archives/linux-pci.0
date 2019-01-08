Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC5C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FAA2087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546940612;
	bh=TTw2bAtlyHRTWd61Ahvr7dAXIgMRKsIVvyDQdIOjJC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AUT5sNKQgWl56XsBRP4WdBOBGkQpDj4115lSrbvmrCvYCl79nTlrOXtHWKE02/Ce1
	 1fnwHeybIN6kIqtWQfaQ5zrr2RFfUZ7/sj3cEnFCL1C6HAkdD6oWOecDWqwcJHIBH2
	 Fz2meDMw/0ztgNdj1KB0GmeJtG48ijvx4M8gpYcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfAHJnc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:43:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39794 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHJnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2019 04:43:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so2800890oia.6;
        Tue, 08 Jan 2019 01:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsINFIiWUZChQ7SYAm/mY2YrRMNq+PkQ/o+z+Br1am4=;
        b=VuNobMlQv3Wa/QCMdTBd52rCrojVr46BjZz7WS+xNRvZ/Ymz7A2/ONy3Try1g83WL3
         tisuE8CxJI62UOexBtdwVY4SC7qgdA5nDp+8F4JG2T59U5sZqy1TMOxEpycB/TeGPY1u
         jlaVZviqdpv10v3puhAxqoeIhdyMTe0QMpphZn8txMmrJzqK2vvvsGqWrP1LX0zLBtYp
         Bh583UTkp+4J0wEWXUH8wYUFmIRXAWqEKyRGUXMq5zGinzn1DyywImdcXYp/KYT/fnTI
         V91uJrOsyg2/LV+DSIJOs5XIiHjtXfLFsHdP0d6Jo7Q+ZsnnVoFSxPGzOQ8uNgYK/3o1
         3hyg==
X-Gm-Message-State: AJcUukc81fLVK8RK9phOl+8gLnANhYlCrdVABDbsvVhikaJqHeT2epcg
        s4RuZwDWM44dnscP990/07l3mQPXJK2aiZ8p85U=
X-Google-Smtp-Source: ALg8bN5w1VUfNbcPNVX0Tk1CPabVw9NcXzGgBQiUzH6PHACLXJypT+eC4Dw8B7q5Ub/eZurqnjjHAv1W/y8f4Xz+UA0=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr676579oix.246.1546940610831;
 Tue, 08 Jan 2019 01:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com> <20190108093507.GX2469@lahna.fi.intel.com>
In-Reply-To: <20190108093507.GX2469@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jan 2019 10:43:19 +0100
Message-ID: <CAJZ5v0hD1wpKQDASx_rK0yJ5r16RMrZ7p9YUHRVvV002f8UuVA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with slot
 implemented bit set
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 8, 2019 at 10:35 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
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

Blacklist would be fine by me too.
