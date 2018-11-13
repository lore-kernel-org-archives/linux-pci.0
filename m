Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7914C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7444F22511
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7444F22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeKMVLV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:11:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:33112 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeKMVLV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 16:11:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="99851293"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 13 Nov 2018 03:13:37 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 13:13:36 +0200
Date:   Tue, 13 Nov 2018 13:13:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Message-ID: <20181113111336.GS2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112181214.xaahc5wni4vuwl6h@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112181214.xaahc5wni4vuwl6h@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 07:12:14PM +0100, Lukas Wunner wrote:
> On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> > Recent systems shipping with Windows 10 version 1803 or newer may be
> > utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
> > different from the previous security level based scheme because the
> > connected device cannot access system memory outside of the regions
> > allocated for it by the driver.
> > 
> > When enabled the BIOS makes sure no device can do DMA outside of RMRR
> > (Reserved Memory Region Record) regions. This means that during OS boot,
> > before it enables IOMMU, none of the connected devices can bypass DMA
> > protection for instance by overwriting the data structures used by the
> > IOMMU. The BIOS communicates support for this to the OS by setting a new
> > bit in ACPI DMAR table [1].
> > 
> > Because these systems utilize an IOMMU to block possible DMA attacks,
> > typically (but not always) the Thunderbolt security level is set to "none"
> > which means that all PCIe devices are immediately usable. This also means
> > that Linux needs to follow Windows 10 and enable IOMMU automatically when
> > running on such system otherwise connected devices can read/write system
> > memory pretty much without any restrictions.
> 
> What if the system is booted from a Thunderbolt-attached disk?
> Won't this suddenly break with these patches?

Like Yehezkel commented, it either is not supported or alternatively it
is (the BIOS/boot loader utilizes IOMMU as well), loads the OS image and
what is needed from the disk, disables BME (bus mastering enable) and
resets the IOMMU back to the default state before handing over to the OS.

> That would seem like a pretty significant regression.  What if the
> only GPU in the system is Thunderbolt-attached?  Is it possible to
> recognize such scenarios and automatically exempt affected devices
> from IOMMU blocking?

"IOMMU blocking" does not mean that the device cannot be used at all. It
actually means that the device is immediately usable and can do DMA as
the driver has programmed (using DMA-API) but it cannot access any
memory outside of those regions the driver has programmed.

The point of this exercise is to prevent so called drive-by DMA attacks
where you go to take a cup of coffee and during that time someone plugs
in a malicous device to Thunderbolt port of your laptop and reads all
your secrets.

When IOMMU is enabled the malicous device still is usable (assuming
there is driver for it) but it cannot go and read all the memory, just
the memory driver has programmed.

So in your GPU case it should just work assuming the GPU has a driver.
