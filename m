Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1DC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA79223B0
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 19:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA79223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeKMFqE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:46:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:11230 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeKMFqD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 00:46:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 11:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="273433761"
Received: from araj-mobl1.jf.intel.com ([10.24.14.254])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2018 11:51:21 -0800
Date:   Mon, 12 Nov 2018 11:51:21 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        iommu@lists.linux-foundation.org, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Message-ID: <20181112195121.GC5367@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-3-mika.westerberg@linux.intel.com>
 <20181112110900.16cfee48@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112110900.16cfee48@t450s.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 11:09:00AM -0700, Alex Williamson wrote:
> On Mon, 12 Nov 2018 19:06:26 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> > in DMAR ACPI table for BIOS to report compliance about platform
> > initiated DMA restricted to RMRR ranges when transferring control
> > to the OS. The OS treats this as a hint that the IOMMU should be
> > enabled to prevent DMA attacks from possible malicious devices.
> 
> Does this in any way suggest that there are additional recommended uses
> cases from Intel for RMRRs?  My concern here is the incompatibility we
> have with RMRRs and device assignment as we currently cannot assign
> devices where the IOVA address space is encumbered by RMRR
> requirements.  Unfortunately RMRRs do not indicate any sort or
> lifespan, so firmware enabling an RMRR simply to support some boot-time
> DMA encumbers the device with that RMRR for the life of that boot,
> unless we have VT-d code that decides it knows better.  Thanks,

IMO any new platform that requires RMRR should be a bug. It was designed 
originally for some legacy keyboard emulation etc.

The best behavior is to continue to not allow devices with RMRR be direct assigned.

Technically ignoring RMRR's and continuing to assign those devices is risky.
The problem is IF BIOS/SMM initiates some IO in the RMRR range and it happens to be
mapped by the direct assigned GPA its going to be ugly failure.
