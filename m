Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9791C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C020866
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 09:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1C020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLNJYc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:24:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:4911 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbeLNJYc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 04:24:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 01:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="scan'208";a="118313849"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga002.jf.intel.com with SMTP; 14 Dec 2018 01:24:28 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Dec 2018 11:24:27 +0200
Date:   Fri, 14 Dec 2018 11:24:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181214092427.GR2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 02:20:48PM +0300, Mika Westerberg wrote:
> Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> connected to an Alpine Ridge Thunderbolt controller. This port has slot
> implemented bit set in the config space but other than that it is not
> hotplug capable in the sense we are expecting in Linux (it has
> dev->is_hotplug_bridge set to 0):

I guess we can conclude here that we cannot reliably identify root ports
such as this one using ACPI description, which leaves us the blacklist.

If there are no objections, can we get this into v4.21?

Thanks :)
