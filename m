Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E765C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D221B21582
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D221B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeKPFKA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:10:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:28335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeKPFKA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 00:10:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 11:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="106597779"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 15 Nov 2018 11:00:55 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 15 Nov 2018 21:00:54 +0200
Date:   Thu, 15 Nov 2018 21:00:54 +0200
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
Message-ID: <20181115190054.GD4179@lahna.fi.intel.com>
References: <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> Do you really need to parse it if the dev->is_thunderbolt check is enough ?

Yes, we need to parse it one way or another. dev->is_thunderbolt is
based on heuristics which do not apply anymore when the thing gets
integrated in the SoC.

The _DSD is there already (on existing systems) and is being used by
Windows so I don't understand why we cannot take advantage of it? Every
new system with Thunderbolt ports will have it.
