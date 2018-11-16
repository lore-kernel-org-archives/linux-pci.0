Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEBCC43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 10:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959A32089D
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 10:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKPVJK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:09:10 -0500
Received: from foss.arm.com ([217.140.101.70]:49536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPVJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 16:09:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACAAD80D;
        Fri, 16 Nov 2018 02:57:19 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946F73F5BD;
        Fri, 16 Nov 2018 02:57:16 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:57:38 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mario.Limonciello@dell.com
Cc:     mika.westerberg@linux.intel.com, lukas@wunner.de,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, ckellner@redhat.com,
        anthony.wong@canonical.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181116105738.GA21277@red-moon>
References: <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
 <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 07:33:54PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Thursday, November 15, 2018 1:01 PM
> > To: Lorenzo Pieralisi
> > Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> > Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob jun Pan;
> > Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonciello,
> > Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> > 
> > Yes, we need to parse it one way or another. dev->is_thunderbolt is
> > based on heuristics which do not apply anymore when the thing gets
> > integrated in the SoC.
> > 
> > The _DSD is there already (on existing systems) and is being used by
> > Windows so I don't understand why we cannot take advantage of it? Every
> > new system with Thunderbolt ports will have it.

We have different opinions on this, there is no point in me reiterating
it over and over, I am against the approach taken to solve this problem
first in defining the bindings outside the ACPI specifications and
second by acquiescing to what has been done so that it will be done
over and over again.

I will raise the point in the appropriate forum, it is up to Bjorn
and Rafael to decide on this patch.

Lorenzo
