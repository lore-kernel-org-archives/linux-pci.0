Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFEC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FF221104
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeK1WlV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:41:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:1659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbeK1WlU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 17:41:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="93534588"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 28 Nov 2018 03:39:53 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 28 Nov 2018 13:39:52 +0200
Date:   Wed, 28 Nov 2018 13:39:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Message-ID: <20181128113952.GX2296@lahna.fi.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
 <20181128105415.GV2296@lahna.fi.intel.com>
 <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 12:24:27PM +0100, Rafael J. Wysocki wrote:
> I'm not sure if this is worth the extra complexity either, which is
> why I have no strong opinion here. :-)
> 
> Maybe you can add a comment, next to the prp_guids[] definition, to
> explain that the GUIDs are made equivalent to each other in order to
> avoid extra complexity in the properties handling code, with the
> caveat that the kernel will accept certain combinations of GUIDs and
> properties that are not defined strictly speaking without warning, but
> those combinations of GUIDs and properties are not expected to be used
> by firmware and they should be caught by firmware validation tools and
> reported as errors anyway.

Sure, I'll add the comment in the next version of the series.
