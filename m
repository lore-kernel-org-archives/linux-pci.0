Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B97C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1690421582
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 14:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1690421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbeKOAxy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:53:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:51395 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbeKOAxx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 19:53:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 06:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,232,1539673200"; 
   d="scan'208";a="96249221"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 14 Nov 2018 06:50:18 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 14 Nov 2018 16:50:17 +0200
Date:   Wed, 14 Nov 2018 16:50:17 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Message-ID: <20181114145017.GQ2500@lahna.fi.intel.com>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
 <20181113125910.GB2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF51F@FRAEML521-MBX.china.huawei.com>
 <20181113150749.GC2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF7B5@FRAEML521-MBX.china.huawei.com>
 <20181114095225.GN2500@lahna.fi.intel.com>
 <20181114133014.ge7cy2r2vrrtt6xx@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114133014.ge7cy2r2vrrtt6xx@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 02:30:14PM +0100, Lukas Wunner wrote:
> On Wed, Nov 14, 2018 at 11:52:25AM +0200, mika.westerberg@linux.intel.com wrote:
> > On Tue, Nov 13, 2018 at 03:57:47PM +0000, Shameerali Kolothum Thodi wrote:
> > > > The smb_mb() thing is not that clear (at least to me) because it is used
> > > > in two places in the driver and both seem to be making write to
> > > > ctrl->cmd_busy visible to other CPUs but I don't see where we deal with
> > > > the read part.
> > > > 
> > > > I may be missing something, though.
> > > 
> > > I think the read part is in wait_event_timeout() which evaluates the
> > > condition. The wake_up is called from the pciehp_isr().  Since the flag
> > > is being updated in both process level and interrupt handler context,
> > > smp_mb() is used. I think the same now applies to  ctrl->slot_ctrl now
> > > as this being used in process context and interrupt context as well.
> > 
> > Right, but that would require to use another read/general barrier in the
> > pciehp_isr() before we read the variable in case interrupt happens
> > immediately on another CPU (at least that's my understanding).
> 
> In pcie_do_write_cmd(), please just move the
> 
> 	ctrl->slot_ctrl = slot_ctrl;
> 
> above the call to pcie_capability_write_word().
> 
> AFAICS an explicit memory barrier isn't needed here because of the call to
> pcie_capability_write_word(), which "will [ordinarily] be guaranteed to be
> fully ordered and uncombined" (Documentation/memory-barriers.txt, section
> "KERNEL I/O BARRIER EFFECTS").
> 
> The memory barrier in pciehp_isr() is also bogus because the following
> wake_up() implies a memory barrier if a task was woken.  (And if none
> was woken, who cares.)
> 
> 
> > Since I'm
> > not too comfortable with all these barriers to be honest I would prefer
> > reading the slot control register directly in pciehp_isr() :-)
> 
> That is an approach I'd strongly object to:  While pciehp itself only
> signals very few interrupts (making an additional mmio read appear to
> be negligible), it may share its interrupt with other devices.  On my
> MacBookPro9,1, a hotplug port of the Thunderbolt controller shares
> its interrupt line with the Wifi card and SD card reader, and those
> may signal a huge number of interrupts.  On such a machine an additional
> mmio read per interrupt becomes a problem.

OK.

I just sent a patch moving ctrl->slot_ctrl assignment to happen before
pcie_capability_write_word().
