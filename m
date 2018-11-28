Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848AC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FD92133F
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/mdPKJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FD92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbeK2He0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeK2He0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 02:34:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78482206B6;
        Wed, 28 Nov 2018 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543437092;
        bh=Ux9i1AmHLCZTd0JFoLEbAyBVU76ZExrYv2HMhOdVoLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/mdPKJmr/Es2asQedRI+sOK5ezxyEq62bRHM3ORcUeSzsykVquDQ6+NwIZONX4Mt
         XMYTofvVJbo0cnfK7OUXeVC+DIrpq+SkB4xg74gp6NA0o4p8Gp+VhKLzhGgUMhOQxO
         XsxQ2yIuTwxSamhy71Wonp4xj+Pk8624U7LgR0Zs=
Date:   Wed, 28 Nov 2018 14:31:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Message-ID: <20181128203128.GA178809@google.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <20181127001711.GC212532@google.com>
 <20181127085426.GI2296@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127085426.GI2296@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 10:54:26AM +0200, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 06:17:11PM -0600, Bjorn Helgaas wrote:
> > Hi Mika,
> 
> Hi,
> 
> > On Mon, Nov 26, 2018 at 02:15:23PM +0300, Mika Westerberg wrote:
> > > Recent systems with Thunderbolt ports may support IOMMU natively.
> > 
> > This sentence doesn't make sense to me.  There's no logical connection
> > between having an IOMMU and having a Thunderbolt port.
> > 
> > > This means that the platform utilizes IOMMU to prevent DMA attacks
> > > over externally exposed PCIe root ports (typically Thunderbolt
> > > ports)
> > 
> > Nor this one.  The platform only uses the IOMMU to prevent DMA attacks
> > if the OS chooses to do that.

I think by "platform" you're referring to the system firmware; I was
only thinking of the hardware, so the IOMMU wouldn't be used unless
someone (the OS) enabled it.  But your cover letter talks about the
BIOS enabling some IOMMU functionality.

> I guess I'm trying to say here that the recent changes add such support
> to the platform BIOS that allows the OS to enable IOMMU without being
> compromised by a malicious device that is already connected. The BIOS
> sets the new ACPI DMAR bit in that case.

Ah, there's useful info to this effect in your [0/4] cover letter.
That info and the URL should be in the changelog of one of the patches so
it doesn't get lost.

> > > The system BIOS marks these PCIe root ports as being externally facing
> > > ports by implementing following ACPI _DSD [1] under the root port in
> > > question:
> > 
> > There's no standard that requires this, so the best we can say is that
> > a system BIOS *may* mark externally facing ports with this mechanism.
> 
> There is no standard but I'm quite sure this is something that will be
> required to be implemented properly by the OEM by Microsoft hardware
> compatibility suite.

Sure.  Your statement suggests that all external ports will be marked
with the _DSD.  I'm just pointing out that the OS can't assume that
because there are probably systems in the field that predate the _DSD.

Bjorn
