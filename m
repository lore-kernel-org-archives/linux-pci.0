Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06148C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC0F22507
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC0F22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbeKMViM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:38:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:62267 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbeKMViL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 16:38:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 03:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="249314799"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 13 Nov 2018 03:40:21 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 13:40:20 +0200
Date:   Tue, 13 Nov 2018 13:40:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        David Woodhouse <dwmw2@infradead.org>,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Message-ID: <20181113114020.GV2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com>
 <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 01:13:31PM +0200, Yehezkel Bernat wrote:
> On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > > Just one point:
> > > Have you considered the option to add this property per (TBT?) device?
> >
> > No. ;-)
> >
> > You mean that one device uses security levels and another IOMMU? I don't
> > think it is possible without having some sort of table in the IOMMU
> > driver telling which devices it needs identity map and which not. Also
> > not sure what would be the benefit?
> 
> For performance, of course. If some devices are considered safe (maybe a list
> communicated by platform firmware), the kernel may decide to configure them to
> passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
> wrong.)

At least I'm not aware of such an option. Windows for example enables
IOMMU for everything and I think macOS does the same. In Linux (with
these patches) we put all internal devices already passthrough mode so
things like internal graphics should not be affected. eGPUs are
different thing, though.

> > > If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
> > > it should be on this level.
> > > Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
> > > decision will be communicated per device by a new sysfs attribute anyway, if
> > > needed?
> >
> > Not sure what you mean by "AST"? The IOMMU decision is pretty much
> > system-wide.
> 
> Sorry, I meant ATS, Address Translation Service, mentioned in patch 3 in this
> series, and possibly be enabled for some devices for performance, as mentioned
> there.

Thanks for clarifying :)

> So if needed, this will be another attribute, and definitely
> per-device, isn't it?

Yes, we may want to add a way enable ATS for external devices (perhaps
global option or per-device attribute) if it turns out to cause
performance issues. However, I think it can be done later if needed. I
have not seen a single device actually supporting ATS (with the
exception of the "hacked" one in the linked thesis of patch 3/4 ;-))
