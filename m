Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D2AC04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96537214C1
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96537214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbeLDI5m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:57:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:39022 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeLDI5m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Dec 2018 03:57:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 00:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="115470868"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga002.jf.intel.com with SMTP; 04 Dec 2018 00:57:35 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Dec 2018 10:57:35 +0200
Date:   Tue, 4 Dec 2018 10:57:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v3 1/4] PCI / ACPI: Identify untrusted PCI devices
Message-ID: <20181204085735.GR3078@lahna.fi.intel.com>
References: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
 <20181129155153.35840-2-mika.westerberg@linux.intel.com>
 <20181204002800.GB85090@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204002800.GB85090@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 03, 2018 at 06:28:00PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 29, 2018 at 06:51:50PM +0300, Mika Westerberg wrote:
> > A malicious PCI device may use DMA to attack the system. An external
> > Thunderbolt port is a convenient point to attach such a device. The OS
> > may use IOMMU to defend against DMA attacks.
> > 
> > Recent BIOSes with Thunderbolt ports mark these externally facing root
> > ports with this ACPI _DSD [1]:
> 
> I'm not 100% comfortable with the "Recent BIOSes" wording because that
> suggests that we can rely on the fact that *all* BIOSes newer than
> some date X mark these ports.
> 
> Since this _DSD usage is Microsoft-specific and not required by either
> PCIe or ACPI specs, we can't rely on it.  A BIOS that doesn't
> implement it may not be Windows-certified, but it's perfectly
> spec-compliant otherwise and we have to keep in mind the possibility
> that ports without this _DSD may still be externally visible and may
> still be attack vectors.

OK.

I will change it to "Some BIOSes .." following what you suggested
earlier. That should make it clear not all BIOSes are required to
implement this.

> >   Name (_DSD, Package () {
> >       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
> >       Package () {
> >           Package () {"ExternalFacingPort", 1},
> > 	  Package () {"UID", 0 }
> >       }
> >   })
> > 
> > If we find such a root port, mark it and all its children as untrusted.
> > The rest of the OS may use this information to enable DMA protection
> > against malicious devices. For instance the device may be put behind an
> > IOMMU to keep it from accessing memory outside of what the driver has
> > allocated for it.
> > 
> > While at it, add a comment on top of prp_guids array explaining the
> > possible caveat resulting when these GUIDs are treated equivalent.
> > 
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
