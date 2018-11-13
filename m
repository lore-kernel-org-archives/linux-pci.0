Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0724C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC522419
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BC522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeKMVYs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:24:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:2750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbeKMVYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 16:24:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="85455127"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 13 Nov 2018 03:27:01 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 13:27:00 +0200
Date:   Tue, 13 Nov 2018 13:27:00 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <20181113112700.GT2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:56:36AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 12, 2018 at 07:02:03PM +0100, Lukas Wunner wrote:
> > On Mon, Nov 12, 2018 at 07:06:25PM +0300, Mika Westerberg wrote:
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
> > >  	}
> > >  }
> > >  
> > > +static void set_pcie_external(struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *parent;
> > > +
> > > +	/*
> > > +	 * Walk up the device hierarchy and check for any upstream
> > > +	 * bridge that has is_external_facing set to true. This means
> > > +	 * the hierarchy is below PCIe port that is exposed externally
> > > +	 * (such as Thunderbolt).
> > > +	 */
> > > +	parent = pci_upstream_bridge(dev);
> > > +	while (parent) {
> > > +		if (parent->is_external) {
> > > +			dev->is_external = true;
> > > +			break;
> > > +		}
> > > +
> > > +		parent = pci_upstream_bridge(parent);
> > > +	}
> > > +}
> > > +
> > 
> > This looks pretty much like a duplication of the is_thunderbolt bit
> > in struct pci_dev and the pci_is_thunderbolt_attached() helper.
> > 
> > Why constrain the functionality to ports with the _DSD property
> > instead of making it available for *any* Thunderbolt port?
> 
> I assume it is because this is just not needed for Thuderbolt ports but
> rather for all PCIe devices that are "external" (whatever that is
> supposed to mean), ie it is valid also for PCIe slots.

Yes, that was the idea. We could have other "external" devices that are
not using Thunderbolt as the interconnect.

We could do so that we automatically set "is_external" for devices with
"is_thunderbolt" so it should cover those as well.

> To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
> and not thoroughly defined and I would question its detection at
> PCI/ACPI core level, I would hope this can be clarified at ACPI
> specification level, at least.

I guess that is the way they envision to use _DSD. Instead of having
single UUID that covers all properties (like what we have with device
properties) they have one UUID per property "class". I certainly hope we
don't need to keep extending prp_guids[] array each time they invent
another "class" of properties.
