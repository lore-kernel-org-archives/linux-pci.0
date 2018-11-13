Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A4C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EFC216FD
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EFC216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbeKMUxi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:53:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:58837 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeKMUxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 15:53:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 02:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="85450005"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 13 Nov 2018 02:55:59 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 12:55:58 +0200
Date:   Tue, 13 Nov 2018 12:55:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Message-ID: <20181113105558.GR2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 06:59:02PM +0200, Yehezkel Bernat wrote:
> On Mon, Nov 12, 2018 at 6:06 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Recent systems shipping with Windows 10 version 1803 or later may
> > support a feature called Kernel DMA protection [1]. In practice this
> > means that Thunderbolt connected devices are placed behind an IOMMU
> > during the whole time it is connected (including during boot) making
> > Thunderbolt security levels redundant. Some of these systems still have
> > Thunderbolt security level set to "user" in order to support OS
> > downgrade (the older version of the OS might not support IOMMU based DMA
> > protection so connecting a device still relies on user approval then).
> >
> > Export this information to userspace by introducing a new sysfs
> > attribute (iommu_dma_protection). Based on it userspace tools can make
> > more accurate decision whether or not authorize the connected device.
> >
> > In addition update Thunderbolt documentation regarding IOMMU based DMA
> > protection.
> >
> > [1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> I can't comment on the IOMMU side, but the Thunderbolt side looks good to me.

Thanks!

> Just one point:
> Have you considered the option to add this property per (TBT?) device?

No. ;-)

You mean that one device uses security levels and another IOMMU? I don't
think it is possible without having some sort of table in the IOMMU
driver telling which devices it needs identity map and which not. Also
not sure what would be the benefit?

> If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
> it should be on this level.
> Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
> decision will be communicated per device by a new sysfs attribute anyway, if
> needed?

Not sure what you mean by "AST"? The IOMMU decision is pretty much
system-wide.
