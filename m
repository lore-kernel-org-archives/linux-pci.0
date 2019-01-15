Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B5C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 22:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99727208E4
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547591036;
	bh=zAtqgBC4h2q9jX3PMTEWUV3FixX+VUwODgGmw4weCKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rMj2ZqjMP2ukIGVJTP+yDd9FIHnjiDXANwLv9avfEE+8GEzVKqiD7xTa4FbIwc/Tq
	 YZchSacLgT1YyPcMBbut/jq66AGSJ5qOm2LAwKPKKR5fjFxH8bmiJKV11APadDZ3wG
	 Hzn5Do4mYgcHiraJIqa+79EAkTIeNdPzSFAAj5U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfAOWXz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbfAOWXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 17:23:55 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B725020866;
        Tue, 15 Jan 2019 22:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547591034;
        bh=zAtqgBC4h2q9jX3PMTEWUV3FixX+VUwODgGmw4weCKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djzKtrJRmM64aq1ZGaZlC+LyE2ldXkEcWYzOeeIa3RSX1V8lraPX2Uhq+YgQD2IEd
         sSrwcei1S2GK0ru2GcGhuKXQigLdfG5s+d9oi0H1f4uPmr5gWoDcpnwkTW1IJV/1oQ
         L4Xv35luvaa6wPO47THH3/iF4DiGwkTxejhM4ghg=
Date:   Tue, 15 Jan 2019 16:23:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20190115222352.GA158366@google.com>
References: <20181218004455.20186-1-mst@redhat.com>
 <20181220194950.GD183878@google.com>
 <20181220161052-mutt-send-email-mst@kernel.org>
 <20181220223158.GG183878@google.com>
 <20181220173535-mutt-send-email-mst@kernel.org>
 <20190114230507-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114230507-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[-cc stable]

On Mon, Jan 14, 2019 at 11:07:27PM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 20, 2018 at 05:36:03PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 20, 2018 at 04:31:58PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Dec 20, 2018 at 04:26:54PM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 20, 2018 at 01:49:50PM -0600, Bjorn Helgaas wrote:
> > > > > On Mon, Dec 17, 2018 at 07:45:41PM -0500, Michael S. Tsirkin wrote:
> > > > > > commit 1f82de10d6b1 ("PCI/x86: don't assume prefetchable ranges are 64bit")
> > > > > > added probing of bridge support for 64 bit memory each time bridge is
> > > > > > re-enumerated.
> > > > > > 
> > > > > > Unfortunately this probing is destructive if any device behind
> > > > > > the bridge is in use at this time.
> > > > > > 
> > > > > > This was observed in the field, see
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01711.html
> > > > > > and specifically
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
> > > > > > 
> > > > > > There's no real need to re-probe the bridge features as the
> > > > > > registers in question never change - detect that using
> > > > > > the memory flag being set (it's always set on the 1st pass since
> > > > > > all PCI2PCI bridges support memory forwarding) and skip the probing.
> > > > > > Thus, only the first call will perform the disruptive probing and sets
> > > > > > the resource flags as required - which we can be reasonably sure happens
> > > > > > before any devices have been configured.
> > > > > > Avoiding repeated calls to pci_bridge_check_ranges might be even nicer.
> > > > > > Unfortunately I couldn't come up with a clean way to do it without a
> > > > > > major probing code refactoring.
> > > > > 
> > > > > I'm OK with major probe code refactoring as long as it's done
> > > > > carefully.  Doing a special-case fix like this solves the immediate
> > > > > problem but adds to the long-term maintenance problem.
> > > > > 
> > > > > As far as I can tell, everything in pci_bridge_check_ranges() should
> > > > > be done once at enumeration-time, e.g., in the pci_read_bridge_bases()
> > > > > path, and pci_bridge_check_ranges() itself should be removed.
> > > > > 
> > > > > If that turns out to be impossible for some reason, we need a comment
> > > > > explaining why.
> > > > 
> > > > Maybe possible but I am not sure how.
> > > > 
> > > > Here's why:
> > > > 
> > > > Upon hotplug we want to poke at new bridges if any, but not the old
> > > > ones.  The issue is that e.g. with ACPI hotplug the event that Linux
> > > > knows how to handle is by design a heavy weight bus rescan.
> > > 
> > > Yeah, it's tricky.  But I don't think it's PCI or ACPI that makes this
> > > tricky; I think it's just the historical baggage of the PCI core
> > > design that makes it hard.
> > > 
> > > Even in the ACPI hotplug path, I think we use this pci_scan_device()
> > > path:
> > > 
> > >   pci_scan_device
> > >     pci_setup_device
> > >       case PCI_HEADER_TYPE_NORMAL:
> > >         pci_read_bases(6)             # normal PCI BARs
> > >       case PCI_HEADER_TYPE_BRIDGE:
> > >         pci_read_bases(2)             # bridge BARs (not windows)
> > > 
> > > Unfortunately that path doesn't call pci_read_bridge_bases() to read
> > > the bridge windows; that currently happens in pcibios_fixup_bus(),
> > > which is only called from pci_scan_child_bus_extend().
> > > 
> > > This is a broken design because reading the bridge apertures is not at
> > > all platform-specific, so it shouldn't be done in a pcibios hook.
> > > And, more to the issue at hand, it shouldn't be done in
> > > pci_scan_child_bus() either.  We might have to *update* the windows
> > > when scanning child buses, but we should be able to do the work of
> > > finding out what windows are implemented and their properties
> > > somewhere in the pci_setup_device() path.
> > > 
> > > > Specifically 
> > > > 
> > > > pci_read_bridge_bases does not
> > > > seem to be called on ACPI hotplug path.
> > > > 
> > > > Rather,
> > > > 
> > > > pci_assign_unassigned_root_bus_resources
> > > > pci_assign_unassigned_bridge_resources
> > > > 
> > > > would be the two functions in question.
> > > > 
> > > > 
> > > > Would above explanation be sufficient? If not, since I understand your
> > > > reluctance to pile up hacks, would you be open to doing the suggested
> > > > rewrite yourself? Me and xuyandong can help test it.
> > > 
> > > I'll be on vacation or holiday most of the time until the new year,
> > > but I put a reminder on my calendar to look at this again then.  I'm
> > > pretty sure we've tried to unravel this in the past, but I can't
> > > remember what issues we tripped over.  Maybe we can make some progress
> > > by restricting the problem we're trying to solve.
> > > 
> > > Thanks for bringing this up!  This is a wart in the PCI core that has
> > > bothered me for a long time, and maybe this is the incentive we need
> > > to make some progress on it.
> > 
> > Sounds good, let me know when I can help with testing.
> 
> FWIW this patch has been in -next through my tree for a while now with
> no ill effects. And the bug it fixes is real. So ... nudge nudge ...
> 
> Would you consider merging if I added a bg fat FIXME on top
> saying the fact that we re-probe multiple times is
> a sign that probing needs to be cleaned up?

I don't think we've really exhausted the possibilities for a cleaner
fix yet.  I have some ideas and would like to test them myself before
making a fool of myself in public.  Is there any chance one of you
could post a minimal way to reproduce the problem?  I fiddled with the
qemu stuff in
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
but it's far from minimal and doesn't include the hot-add parts of the
recipe.  I'm pretty much qemu-illiterate, so any hints would be much
appreciated.

Bjorn
