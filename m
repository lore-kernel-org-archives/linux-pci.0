Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B23C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 20:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51D6218B0
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545166738;
	bh=ZkHBouKwD9dlWFsZDfNhZAD+PkjfmWVyJxr/vmD4o/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IsahSIbkY98E++JA3W5bLEiA7lBFjpyWKZA7PmRrJH4HBVi2ZoHg0MkmnG/trQA75
	 TcaIqSmCp+/rjWSQtKaSOIhhZ4JWG5VtMhTk2U84bZMeP6WwnmCW0oWrcCoG3KxzBe
	 j9UU8qqIAPlfwPkjBRDFfbNq8KSKtwl94yP8ZnxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLRU65 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRU65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 15:58:57 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A560217D9;
        Tue, 18 Dec 2018 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545166736;
        bh=ZkHBouKwD9dlWFsZDfNhZAD+PkjfmWVyJxr/vmD4o/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKd31GC7rH5MlmPAJsA+U8Ca5fFkEuSkqYnM4XjJIjmoH3KDcAqiW9HEHBlt1m4T6
         sHbTwcg2DQQAzdUEmC/5cdNCAfBVyQlo0vM7clUzczXXxzWqrVLlk6Ocoz8GwPj4bQ
         kHyFgC4e27OZiee0Ul7JzBwP9JVifZRD9XhRR04c=
Date:   Tue, 18 Dec 2018 14:58:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181218205850.GA12763@google.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218085518.GI2469@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 10:55:18AM +0200, Mika Westerberg wrote:
> On Mon, Dec 17, 2018 at 02:28:27PM -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 04, 2018 at 02:20:48PM +0300, Mika Westerberg wrote:
> > > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > > connected to an Alpine Ridge Thunderbolt controller. This port has slot
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
> > > If there is nothing connected in any of the Thunderbolt ports the root
> > > port will not have any runtime PM active children and is thus
> > > automatically runtime suspended pretty soon after boot by PCI PM core.
> > > Now, when a device is connected the BIOS SMI handler responsible for
> > > enumerating newly added devices is not able to find anything because the
> > > port is in D3.
> > 
> > Ugh.  I don't see how this is a maintainable solution.  Are we going
> > to have to just update this blacklist empirically as we get reports of
> > systems that are "broken"?
> 
> I was hoping not but for that we would need to have some means to
> identify these. What you suggest below might be one way to avoid adding
> the blacklist.
> 
> > I say "broken" because I don't think we can point to anything here
> > that doesn't conform to the specs, so maybe we tripped over something
> > that *should* be covered in the spec, or maybe we're just not
> > interpreting something correctly.
> 
> That is indeed possible.
> 
> > For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
> > basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
> > aren't using pciehp, we should assume any hotplug would be handled via
> > acpiphp?  And in that case, we should avoid doing anything that would
> > prevent platform firmware from enumerating things below the bridge?
> 
> I don't see why that would not work. This could cause "power regression"
> on some systems but I think that's better than systems that do not work
> at all.

Yeah, I think that would be better, assuming it wouldn't cause a flood
of power regressions.  I'd even rather have a whitelist of systems
where we use acpiphp and it's safe to do power management.

> > Is there a bugzilla or any other URL we could include here to help with
> > future changes in this area?
> 
> No, this was reported internally.
> 
> I can file one if you think it is helpful.

I think a kernel.org bugzilla that archived the "lspci -vv", a dmesg
log, and an acpidump might be helpful.

Bjorn
