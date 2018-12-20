Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A555CC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DDA21741
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 10:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeLTKGq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:06:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:62214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbeLTKGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 05:06:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 02:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="scan'208";a="112061478"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 20 Dec 2018 02:06:42 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Dec 2018 12:06:42 +0200
Date:   Thu, 20 Dec 2018 12:06:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181220100642.GY2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181217202827.GC28981@google.com>
 <20181218085518.GI2469@lahna.fi.intel.com>
 <20181218205850.GA12763@google.com>
 <20181219132324.GS2469@lahna.fi.intel.com>
 <20181219144518.GC12763@google.com>
 <20181219151558.GU2469@lahna.fi.intel.com>
 <20181219170915.3bojdcf7h7kiesyu@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219170915.3bojdcf7h7kiesyu@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 06:09:15PM +0100, Lukas Wunner wrote:
> > I think better example where this fails is normal Thunderbolt device
> > (not host) which includes PCIe switch and there is an PCIe endpoint, say
> > network interface connected to one of the downstream ports. That
> > downstream port has "Slot implemented" set but is not hotplug capable.
> > 
> > So the device would work correctly but if you take the recent "Runtime
> > D3, RTD3" system such as Lenovo Carbon X1 6th gen it keeps the whole
> > PCIe hierarchy from entering D3cold. I would rather not to break that ;-)
> 
> Yeah but as you say, those are Downstream Ports.  What if you constrain
> it to Root Ports?

Yes, that could work. I did not test it yet, though. Thinking this bit
further maybe we can contstrain it to ports that have slot implemented
set and have an ACPI companion instead of just root ports? Point being
that ports without ACPI companion could not possibly get ACPI Notify()
either.
