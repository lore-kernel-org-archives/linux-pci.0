Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42285C169D4
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1581222513
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581222513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbeKNCSx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:18:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:4071 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeKNCSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 21:18:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 08:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="86174255"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 13 Nov 2018 08:12:59 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 18:12:58 +0200
Date:   Tue, 13 Nov 2018 18:12:58 +0200
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
Message-ID: <20181113161258.GE2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com>
 <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
 <20181113114020.GV2500@lahna.fi.intel.com>
 <CA+CmpXt1cfqjz94=WsggKpNCUw3761-cewa_HTa0ETcYK7o+Hw@mail.gmail.com>
 <20181113152038.GD2500@lahna.fi.intel.com>
 <CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 05:38:53PM +0200, Yehezkel Bernat wrote:
> Good point. But I thought about per-TBT-device decision. If the platform is
> configured for IOMMU+"user" security level, while approving the device the user
> may want to set also in which IOMMU group to put all the PCIe devices connected
> to it. The same goes if kernel is supposed to auto-approve such devices based on
> an internal table. The point is that we can think on a configuration where the
> devices aren't tunneled yet and the decision about IOMMU can still be changed.

Right, some of these systems have security level set to "user" so there
we could have a way to put the device into passthrough mode before it
appears on the PCIe bus. That would require some sort of API on the
IOMMU side, though.

> As you mentioned this isn't the common configuration anyway, so it probably
> doesn't worth all this hassle.

AFAIK mixing the two is not something they are going to be supporting in
Windows so I would not expect it to be common. I think the ultimate goal
is to move away from security levels towards IOMMU DMA protection so in
future I would expect more and more systems with IOMMU enabled +
security level set to "none".

So I agree with you that it probably is not worth doing at least without
having more data about real performance issues around this. ;-)
