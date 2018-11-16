Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3BC43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804E2245E
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A804E2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeKPTnq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:43:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:29113 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeKPTnq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 14:43:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 01:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,239,1539673200"; 
   d="scan'208";a="109077639"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga002.jf.intel.com with SMTP; 16 Nov 2018 01:32:08 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 16 Nov 2018 11:32:10 +0200
Date:   Fri, 16 Nov 2018 11:32:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yehezkel Bernat <yehezkelshb@gmail.com>, ashok.raj@intel.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>,
        rjw@rjwysocki.net, Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        iommu@lists.linux-foundation.org, lukas@wunner.de,
        jacob.jun.pan@intel.com, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181116093210.GK4179@lahna.fi.intel.com>
References: <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181116091804.GA4548@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116091804.GA4548@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 16, 2018 at 01:18:04AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 09:10:26PM +0200, Mika Westerberg wrote:
> > FireWire is kind of different but there are connectors such as
> > ExpressCard and NVMe (over U.2 connector) which carry PCIe and are
> > relatively easy to access without need for a screwdriver. AFAIK some
> > eGPUs are also using some other proprietary (non-TBT) connector that
> > carries PCIe.
> 
> U.2 is a data center internal form factor with hot plug capability. If
> you enable an iommu for that by default you will make a lot of people
> very unhappy.

Well, it needs the other bit in ACPI DMAR table to be enabled by default
so I don't think anyone in data center domain will notice ;-)

> More importantly NVMe is now used for the current/next generation
> Compact Flash and SD cards, which contain full PCIe gen 3 links.

OK, thanks for the information - I did not know that. I guess those
belong to the "external" category as well.
