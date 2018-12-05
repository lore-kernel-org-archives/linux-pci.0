Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61876C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3159B20850
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3159B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeLENqr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:46:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:43132 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeLENqr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 08:46:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 05:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="127316470"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Dec 2018 05:46:43 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Dec 2018 15:46:42 +0200
Date:   Wed, 5 Dec 2018 15:46:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181205134642.GR2469@lahna.fi.intel.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181204204049.4zr7onei267t4pic@wunner.de>
 <20181205092034.GI2469@lahna.fi.intel.com>
 <20181205094818.jmdy2mg6b6is7jy3@wunner.de>
 <20181205104029.GL2469@lahna.fi.intel.com>
 <20181205132214.kaojqse4dbcvodxz@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205132214.kaojqse4dbcvodxz@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 05, 2018 at 02:22:14PM +0100, Lukas Wunner wrote:
> On Wed, Dec 05, 2018 at 12:40:29PM +0200, Mika Westerberg wrote:
> > On Wed, Dec 05, 2018 at 10:48:18AM +0100, Lukas Wunner wrote:
> > > Does the root port have a _RMV and/or _SUN object?  We could e.g.
> > > disallow runtime PM for any bridge with _RMV present and the HPC
> > > bit not set in the Slot Capabilities.
> > 
> > Unfortunately it does not have either of those methods :/ It pretty much
> > looks like a "normal root port" from OS perspective.
> > 
> > Below is the ASL related to the root port (RP05) in question:
> 
> The information might be buried in the Device Labeling DSM but I can't
> make sense of it because I only have access to the PCI Firmware Spec 3.0,
> which is too old.

Good point. I have 3.2 but only ones in that _DSM are:

  4 = PCI Bus Capabilities
  6 = LTR Maximum Latency
  8 = Avoid power-on Reset Delay Duplication on Sx Resume
  9 = Device Readiness Durations

Only thing that could be relevant is 4 (PCI Bus Capabilities) but I
don't see anything in the spec saying it could be hot plug capable :(
