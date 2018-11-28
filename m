Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45730C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDBA2081B
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 10:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDBA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeK1Vzi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:55:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:49185 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeK1Vzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 16:55:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 02:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="253809969"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 28 Nov 2018 02:54:16 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 28 Nov 2018 12:54:15 +0200
Date:   Wed, 28 Nov 2018 12:54:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Message-ID: <20181128105415.GV2296@lahna.fi.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 06:14:43PM +0100, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 8c7c4583b52d..4bdad32f62c8 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
> >         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> >         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> >                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> > +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> > +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> > +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> >  };
> 
> One observation here.  Note that I really have no strong opinion on
> that, so this is not an objection, but IMO it is fair to make things
> clear for everybody.
> 
> So this causes the External facing port GUID (which already is the
> case with the Hotplug in D3 GUID for that matter) to be practically
> equivalent to the ACPI _DSD device properties GUID.  This means that
> Linux will consider a combination of any of these GUIDs with any
> properties defined for any of them as valid, which need not be the
> case in Windows.
> 
> For example, since the ExternalFacingPort property is defined along
> with the External facing port GUID, Windows will likely ignore it if
> it is used in a combination with the Hotplug in D3 GUID or the ACPI
> _DSD device properties GUID.  If the firmware combines the Hotplug in
> D3 GUID or the ACPI _DSD device properties GUID with that property,
> Windows will not regard it as valid, most likely, but Linux will use
> it just fine.  In the face of ASL bugs, which are inevitable (at least
> just because ASL is code written by humans), that may become a real
> problem, as systems successfully tested with Windows may not work with
> Linux as expected and vice versa because of it.

That's a fair point.

> >From the ecosystem purity perspective this should be avoided, but then
> I do realize that this allows code to be re-used and avoids quite a
> bit of complexity.  The likelihood of an ASL bug that will expose this
> issue is arguably small, so maybe it is not a practical concern after
> all.

One option assuming we want to prevent the potential discrepancy you
described above is to add ACPI specific property accessors that take
GUID as parameter. Then it would only look properties inside that
particular _DSD entry. I'm not sure if it is worth the added complexity,
though.
