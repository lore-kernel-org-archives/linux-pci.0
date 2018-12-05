Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3523C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24F206B7
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB24F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeLEJUj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:20:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:62576 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeLEJUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 04:20:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:20:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="104986309"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 05 Dec 2018 01:20:35 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Dec 2018 11:20:34 +0200
Date:   Wed, 5 Dec 2018 11:20:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181205092034.GI2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181204204049.4zr7onei267t4pic@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204204049.4zr7onei267t4pic@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 09:40:49PM +0100, Lukas Wunner wrote:
> > I wonder if our pci_bridge_d3_possible() heuristics would need to be
> > refined somehow? At least if this blacklist starts growing.
> 
> We do blacklist such non-native hotplug ports, but of course only if
> the Hot-Plug Capable bit is set:
> 
> 	/*
> 	 * Hotplug ports handled by firmware in System Management Mode
> 	 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
> 	 */
> 	if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
> 		return false;
> 
> I guess your question boils down to, is there any better way to recognize
> ports which are handled by the platform firmware?

Exactly :) Gigabyte makes lots of motherboards and many of them have
USB-C ports so it may be that they use the same BIOS accross them.

> Does acpiphp bind to this port?

It does, yes but AFAIK it binds to any PCI bus (bridge) if it has an
ACPI companion.
