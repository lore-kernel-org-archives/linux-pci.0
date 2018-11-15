Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F496C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2A822506
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2A822506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeKPFlO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:41:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:5289 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPFlO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 00:41:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 11:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="92381520"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 15 Nov 2018 11:32:01 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 15 Nov 2018 21:32:01 +0200
Date:   Thu, 15 Nov 2018 21:32:01 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yehezkel Bernat <yehezkelshb@gmail.com>, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        David Woodhouse <dwmw2@infradead.org>,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181115193201.GF4179@lahna.fi.intel.com>
References: <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181115192741.4ugt6usmsemokxle@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115192741.4ugt6usmsemokxle@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 08:27:41PM +0100, Lukas Wunner wrote:
> On Thu, Nov 15, 2018 at 09:10:26PM +0200, Mika Westerberg wrote:
> > I was thinking we could cover all these with is_external filling them
> > based on the _DSD or some other means in the kernel.
> > 
> > We would then deal all such devices as "untrusted" by default.
> 
> Tinfoil hat on, even internal devices could be malicious.
> What's the downside of enabling the feature for everything?

Mostly performance, I think. That's the main reason we put all non
external devices to passthrough IOMMU mode.
