Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F25C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6321780
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F6321780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeKOVVb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:21:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeKOVVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 16:21:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B497A78;
        Thu, 15 Nov 2018 03:14:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A9D3F718;
        Thu, 15 Nov 2018 03:14:03 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:13:56 +0000
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
Message-ID: <20181115111356.GA599@e107981-ln.cambridge.arm.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115102239.GU2500@lahna.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 12:22:39PM +0200, Mika Westerberg wrote:
> On Tue, Nov 13, 2018 at 11:45:36AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Nov 13, 2018 at 01:27:00PM +0200, Mika Westerberg wrote:
> > 
> > [...]
> > 
> > > > To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
> > > > and not thoroughly defined and I would question its detection at
> > > > PCI/ACPI core level, I would hope this can be clarified at ACPI
> > > > specification level, at least.
> > > 
> > > I guess that is the way they envision to use _DSD. Instead of having
> > > single UUID that covers all properties (like what we have with device
> > > properties) they have one UUID per property "class". I certainly hope we
> > > don't need to keep extending prp_guids[] array each time they invent
> > > another "class" of properties.
> > 
> > It is even worse than that. This is a unilateral/obscure change that
> > won't be part of ACPI specifications (I guess it was easier to add a
> > UUID than add this to the ACPI specifications through the AWSG) but it
> > is still supposed to be applicable to ACPI PCI bindings on any
> > platforms/arches; this way of adding bindings does not work and it
> > has to be rectified.
> 
> I agree.
> 
> For the existing property "classes" such as the one here I don't think
> we can do anything. There are systems already with these included in
> their ACPI tables.
> 
> I wonder if you have any objections regarding this patch?

I have strong objections to the way these bindings have been forced upon
everybody; if that's the way *generic* ACPI bindings are specified I
wonder why there still exists an ACPI specification and related working
group.

I personally (but that's Bjorn and Rafael choice) think that this is
not a change that belongs in PCI core, ACPI bindings are ill-defined
and device tree bindings are non-existing.

At the very least Microsoft should be asked to publish and discuss
these bindings within the ACPI and UEFI forums.

Lorenzo
