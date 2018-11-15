Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A7C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 12:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AFB223DD
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 12:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AFB223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbeKOWPO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:15:14 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:53295 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeKOWPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 17:15:14 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C7FD7100D9403;
        Thu, 15 Nov 2018 13:07:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4077B15429E; Thu, 15 Nov 2018 13:07:36 +0100 (CET)
Date:   Thu, 15 Nov 2018 13:07:36 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181115120736.pscly6zwd3k2tvd2@wunner.de>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115113737.GW2500@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 01:37:37PM +0200, Mika Westerberg wrote:
> On Thu, Nov 15, 2018 at 11:13:56AM +0000, Lorenzo Pieralisi wrote:
> > I have strong objections to the way these bindings have been forced upon
> > everybody; if that's the way *generic* ACPI bindings are specified I
> > wonder why there still exists an ACPI specification and related working
> > group.
> > 
> > I personally (but that's Bjorn and Rafael choice) think that this is
> > not a change that belongs in PCI core, ACPI bindings are ill-defined
> > and device tree bindings are non-existing.
> 
> Any idea where should I put it then? These systems are already out there
> and we need to support them one way or another.

I suppose those are all Thunderbolt, so could be handled by the
existing ->is_thunderbolt bit?

It was said in this thread that ->is_external is more generic in
that it could also be used on PCIe slots, however that use case
doesn't appear to lend itself to the "plug in while laptop owner
is getting coffee" attack.  To access PCIe slots on a server you
normally need access to a data center.  On a desktop, you usually
have to open the case, by which time the coffee may already have
been fetched.  So frankly the binding seems a bit over-engineered
to me and yet another thing that BIOS writers may get wrong.

Well, just my 2 cents anyway.

Lukas
