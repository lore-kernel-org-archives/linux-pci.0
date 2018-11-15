Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D028C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F40E21780
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F40E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbeKPDzF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:55:05 -0500
Received: from foss.arm.com ([217.140.101.70]:38760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388808AbeKPDzF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 22:55:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C486780D;
        Thu, 15 Nov 2018 09:46:18 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADAD63F718;
        Thu, 15 Nov 2018 09:46:15 -0800 (PST)
Date:   Thu, 15 Nov 2018 17:46:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
References: <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115121627.GA2500@lahna.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 02:16:27PM +0200, Mika Westerberg wrote:
> On Thu, Nov 15, 2018 at 01:07:36PM +0100, Lukas Wunner wrote:
> > On Thu, Nov 15, 2018 at 01:37:37PM +0200, Mika Westerberg wrote:
> > > On Thu, Nov 15, 2018 at 11:13:56AM +0000, Lorenzo Pieralisi wrote:
> > > > I have strong objections to the way these bindings have been forced upon
> > > > everybody; if that's the way *generic* ACPI bindings are specified I
> > > > wonder why there still exists an ACPI specification and related working
> > > > group.
> > > > 
> > > > I personally (but that's Bjorn and Rafael choice) think that this is
> > > > not a change that belongs in PCI core, ACPI bindings are ill-defined
> > > > and device tree bindings are non-existing.
> > > 
> > > Any idea where should I put it then? These systems are already out there
> > > and we need to support them one way or another.
> > 
> > I suppose those are all Thunderbolt, so could be handled by the
> > existing ->is_thunderbolt bit?
> > 
> > It was said in this thread that ->is_external is more generic in
> > that it could also be used on PCIe slots, however that use case
> > doesn't appear to lend itself to the "plug in while laptop owner
> > is getting coffee" attack.  To access PCIe slots on a server you
> > normally need access to a data center.  On a desktop, you usually
> > have to open the case, by which time the coffee may already have
> > been fetched.  So frankly the binding seems a bit over-engineered
> > to me and yet another thing that BIOS writers may get wrong.
> 
> I would not say it should include PCIe slots but there are other cables
> that carry PCIe and I was thinking we could make it to support those as
> well.
> 
> I have no problem using is_thunderbolt here, though if we don't want to
> support non-Thunderbolt external devices this way.
> 
> However, the question here is more that where I should put the _DSD
> parsing code if it is not suitable to be placed inside PCI/ACPI core as
> I've done in this patch? ;-)

Do you really need to parse it if the dev->is_thunderbolt check is enough ?

Thanks,
Lorenzo
