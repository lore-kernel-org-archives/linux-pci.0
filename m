Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA446E9271B
	for <linux-pci@archiver.kernel.org>; Thu,  5 Oct 2023 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJER0g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJERZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 13:25:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E03210D
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 10:22:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623D6C433CD;
        Thu,  5 Oct 2023 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526548;
        bh=mqBeiX5OVUWwXM68XaY4QT/4g94lUfVx5Y0ylvmxGdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b8k/rCsdz8pan5dRzi8+/lsUavpUwau3IowbSWxRcJacux6rT2FM9myFuRJkLfMPy
         YAblnbLnKkRLu5zeThqy0rguCwQinKnQ9grOFusje/CT7qof1Tg3q5BWgVAI8puOyP
         D2RrlClv4ySdPz6nQPITmneWfNF7fPEToTOWyvuO0kdf1nPs0AACg0ItjywMbUhjDF
         gbS7GfEC0UTIAq8cqAhtcuy0ZjNeiZqhxo/jo3S8/6oEfV7hJRQS//nxd83SWJS/gx
         Yi42VZRIlleZdbzQpSAeqKv6V0q68iw5Wb/9rtneLrR6apPj9OubqJCOX0tE8nM4NP
         h9fWPCwO1ZpCA==
Date:   Thu, 5 Oct 2023 12:22:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Witt <kernel@witt.link>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231005172226.GA781644@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923d8df0-1112-aca9-8289-c6e2457298cd@witt.link>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 05:57:52PM +0200, Thomas Witt wrote:
> On 05/10/2023 17:30, Bjorn Helgaas wrote:
> ...

> > Right, without the denylist, I expect Thomas' TUXEDO to fail, but I
> > still hope we can figure out why.  If we just keep it on the denylist,
> > that system will suffer from more power consumption than necessary,
> > but only after suspend/resume.
> > 
> > A denylist seems like the absolute last resort.  In this case we don't
> > know about anything *wrong* with those platforms; all we know is that
> > our resume path doesn't work.  It's likely that it fails on other
> > platforms we haven't heard about, too.
> 
> The best guess from Mika and David was a firmware issue, but I run the same
> Firmware revision as Werner. I even reflashed the Firmware, but that did not
> change anything:

Possibly a BIOS settings difference?

> Quoting David Box:
> > I agree that we should pursue an exception for your system. This is
> > looking like a firmware bug. One thing we did notice in the turbostat
> > results is your IRTL (Interrupt Response Time Limit) values are bogus:
> >
> > cpu6: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> > cpu6: MSR_PKGC6_IRTL: 0x00008000 (valid, 0 ns)
> > cpu6: MSR_PKGC7_IRTL: 0x00008000 (valid, 0 ns)
> > cpu6: MSR_PKGC8_IRTL: 0x00008000 (valid, 0 ns)
> > cpu6: MSR_PKGC9_IRTL: 0x00008000 (valid, 0 ns)
> > cpu6: MSR_PKGC10_IRTL: 0x00008000 (valid, 0 ns)
> >
> > This is despite the PKGC configuration register showing that all
> > states are enabled:
> >
> > cpu6: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, UNdemote-C1,
> demote-
> C3, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
> >
> > Firmware sets this.

I can't find this discussion, but if there's a firmware issue related
to IRTL MSRs, I would want the workaround in intel-idle.c or whatever
code deals with the MSRs, not in the ASPM code.

Bjorn
