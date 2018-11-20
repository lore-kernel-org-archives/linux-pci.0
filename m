Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E0C5ACBA
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43000214D9
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43000214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeKUIOt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:14:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56464 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUIOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 03:14:49 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 9c5788b6f960a75e; Tue, 20 Nov 2018 22:43:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Mario.Limonciello@dell.com, mika.westerberg@linux.intel.com,
        lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, jacob.jun.pan@intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, ckellner@redhat.com,
        anthony.wong@canonical.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date:   Tue, 20 Nov 2018 22:43:35 +0100
Message-ID: <35089177.HEBOdrcs2c@aspire.rjw.lan>
In-Reply-To: <20181116105738.GA21277@red-moon>
References: <20181113112700.GT2500@lahna.fi.intel.com> <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM> <20181116105738.GA21277@red-moon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, November 16, 2018 11:57:38 AM CET Lorenzo Pieralisi wrote:
> On Thu, Nov 15, 2018 at 07:33:54PM +0000, Mario.Limonciello@dell.com wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Thursday, November 15, 2018 1:01 PM
> > > To: Lorenzo Pieralisi
> > > Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> > > Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob jun Pan;
> > > Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonciello,
> > > Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
> > > 
> > > 
> > > [EXTERNAL EMAIL]
> > > 
> > > On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > > > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> > > 
> > > Yes, we need to parse it one way or another. dev->is_thunderbolt is
> > > based on heuristics which do not apply anymore when the thing gets
> > > integrated in the SoC.
> > > 
> > > The _DSD is there already (on existing systems) and is being used by
> > > Windows so I don't understand why we cannot take advantage of it? Every
> > > new system with Thunderbolt ports will have it.
> 
> We have different opinions on this, there is no point in me reiterating
> it over and over, I am against the approach taken to solve this problem
> first in defining the bindings outside the ACPI specifications and
> second by acquiescing to what has been done so that it will be done
> over and over again.

Arguably, however, we are on the receiving end of things here and even if
we don't use this binding, that won't buy us anything (but it will introduce
a fair amount of disappointment among both users and OEMs).

If Windows uses it, then systems will ship with it regardless of what Linux
does with it, so your "acquiescing to what has been done" argument leads to
nowhere in this particular case.  It's just a matter of whether or not
Linux will provide the same level of functionality as Windows with respect
to this and IMO it would be impractical to refuse to do that for purely
formal reasons.

> I will raise the point in the appropriate forum, it is up to Bjorn
> and Rafael to decide on this patch.

For the record, my opinion is that there's a little choice on whether or not
to use this extra information that firmware is willing to give us.  It could
be defined in a better way and so on, but since it is in use anyway, we really
have nothing to gain by refusing to use it.

Now, where the handling of it belongs to is a separate matter that should be
decided on its own.

Thanks,
Rafael


