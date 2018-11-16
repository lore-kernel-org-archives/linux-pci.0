Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39380C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BC12145D
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 07:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BC12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeKPRMp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:12:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:17778 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPRMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 12:12:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 23:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,239,1539673200"; 
   d="scan'208";a="280455897"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 15 Nov 2018 23:01:25 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 16 Nov 2018 09:01:25 +0200
Date:   Fri, 16 Nov 2018 09:01:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lukas Wunner <lukas@wunner.de>, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181116070125.GG4179@lahna.fi.intel.com>
References: <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115190054.GD4179@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 09:00:54PM +0200, Mika Westerberg wrote:
> On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > Do you really need to parse it if the dev->is_thunderbolt check is enough ?
> 
> Yes, we need to parse it one way or another. dev->is_thunderbolt is
> based on heuristics which do not apply anymore when the thing gets
> integrated in the SoC.
> 
> The _DSD is there already (on existing systems) and is being used by
> Windows so I don't understand why we cannot take advantage of it? Every
> new system with Thunderbolt ports will have it.

Just to clarify a bit. We can use is_thunderbolt in place of is_external
if we don't want to deal with other possible "external" devices right now.

However, we still need to parse the _DSD and based on that fill the
is_thunderbolt for these devices (same way we do for is_external in this
series). So basically we just get rid of the is_external flag and use
is_thunderbolt instead.
