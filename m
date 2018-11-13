Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B5C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F395B223C8
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395B223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeKMUdx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:33:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:11734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbeKMUdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 15:33:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 02:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="90729178"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga006.jf.intel.com with SMTP; 13 Nov 2018 02:36:17 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 12:36:16 +0200
Date:   Tue, 13 Nov 2018 12:36:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, lukas@wunner.de, ckellner@redhat.com,
        anthony.wong@canonical.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Message-ID: <20181113103616.GQ2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 04:22:25PM +0000, Mario.Limonciello@dell.com wrote:
> > +DMA protection utilizing IOMMU
> > +------------------------------
> > +Recent systems shipping with Windows 10 version 1803 or later may support a
> > +feature called `Kernel DMA Protection for Thunderbolt 3`_.  This means that
> 
> Keep in mind there will be systems that ship with Linux that enable this feature too ;)

Yes, you are absolutely right. I sometimes forgot that fact ;-)

> It might be better to make it time frame and platform  firmware oriented as it's
> entirely possible for an OEM to have a field firmware upgrade that may enable this
> functionality from the platform and allow an end user to upgrade to a sufficiently
> protected kernel or Windows OS to take advantage of it.

I agree. I will update this in the next version.
