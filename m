Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47CC43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 12:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF947214DE
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 12:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF947214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeKUXPO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:15:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbeKUXPO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 18:15:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC10353C;
        Wed, 21 Nov 2018 04:41:01 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 016493F5A0;
        Wed, 21 Nov 2018 04:40:57 -0800 (PST)
Date:   Wed, 21 Nov 2018 12:40:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com,
        lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, jacob.jun.pan@intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, ckellner@redhat.com,
        anthony.wong@canonical.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181121124045.GA21385@e107981-ln.cambridge.arm.com>
References: <20181113112700.GT2500@lahna.fi.intel.com>
 <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
 <20181116105738.GA21277@red-moon>
 <35089177.HEBOdrcs2c@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35089177.HEBOdrcs2c@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 10:43:35PM +0100, Rafael J. Wysocki wrote:
> On Friday, November 16, 2018 11:57:38 AM CET Lorenzo Pieralisi wrote:
> > On Thu, Nov 15, 2018 at 07:33:54PM +0000, Mario.Limonciello@dell.com wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Sent: Thursday, November 15, 2018 1:01 PM
> > > > To: Lorenzo Pieralisi
> > > > Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> > > > Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob jun Pan;
> > > > Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonciello,
> > > > Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
> > > > 
> > > > 
> > > > [EXTERNAL EMAIL]
> > > > 
> > > > On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > > > > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> > > > 
> > > > Yes, we need to parse it one way or another. dev->is_thunderbolt is
> > > > based on heuristics which do not apply anymore when the thing gets
> > > > integrated in the SoC.
> > > > 
> > > > The _DSD is there already (on existing systems) and is being used by
> > > > Windows so I don't understand why we cannot take advantage of it? Every
> > > > new system with Thunderbolt ports will have it.
> > 
> > We have different opinions on this, there is no point in me reiterating
> > it over and over, I am against the approach taken to solve this problem
> > first in defining the bindings outside the ACPI specifications and
> > second by acquiescing to what has been done so that it will be done
> > over and over again.
> 
> Arguably, however, we are on the receiving end of things here and even if
> we don't use this binding, that won't buy us anything (but it will introduce
> a fair amount of disappointment among both users and OEMs).
> 
> If Windows uses it, then systems will ship with it regardless of what Linux
> does with it, so your "acquiescing to what has been done" argument leads to
> nowhere in this particular case.  It's just a matter of whether or not
> Linux will provide the same level of functionality as Windows with respect
> to this and IMO it would be impractical to refuse to do that for purely
> formal reasons.
> 
> > I will raise the point in the appropriate forum, it is up to Bjorn
> > and Rafael to decide on this patch.
> 
> For the record, my opinion is that there's a little choice on whether
> or not to use this extra information that firmware is willing to give
> us.  It could be defined in a better way and so on, but since it is in
> use anyway, we really have nothing to gain by refusing to use it.

AFAIK PCI firmware bindings should go into PCI firmware specifications,
not Microsoft webpages.

If we deviate from this model there is no way to tell whether that extra
information is right or wrong, it is not necessarily about this patch,
it is about changing the way these bindings are deployed in future
systems.

> Now, where the handling of it belongs to is a separate matter that should be
> decided on its own.

I think that the way these bindings were deployed is wrong, I agree this
is not the right forum to discuss that though. What you will do with
this patch is not my call anyway, I just expressed my opinion.

Thanks,
Lorenzo
