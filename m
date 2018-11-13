Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F47C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDDB22507
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDDB22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbeKMVaW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:30:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:1726 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbeKMVaW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 16:30:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="249313650"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 13 Nov 2018 03:32:33 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 13:32:32 +0200
Date:   Tue, 13 Nov 2018 13:32:32 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Message-ID: <20181113113232.GU2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181113085424.GC25808@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113085424.GC25808@8bytes.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 09:54:24AM +0100, Joerg Roedel wrote:
> On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> > Lu Baolu (1):
> >   iommu/vt-d: Force IOMMU on for platform opt in hint
> > 
> > Mika Westerberg (3):
> >   PCI / ACPI: Identify external PCI devices
> >   iommu/vt-d: Do not enable ATS for external devices
> >   thunderbolt: Export IOMMU based DMA protection support to userspace
> 
> Looks good to me. Which tree should go this trough? In case its not the
> IOMMU tree, for the iommu-parts:

I was thinking to take them through Thunderbolt tree.

> 	Acked-by: Joerg Roedel <jroedel@suse.de>
> 	Reviewed-by: Joerg Roedel <jroedel@suse.de>

Thanks!
