Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBDC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F405B208E7
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 13:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F405B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKNXdd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:33:33 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:33159 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNXdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 18:33:33 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id DE2FA2800B483;
        Wed, 14 Nov 2018 14:30:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 859F015429D; Wed, 14 Nov 2018 14:30:14 +0100 (CET)
Date:   Wed, 14 Nov 2018 14:30:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Message-ID: <20181114133014.ge7cy2r2vrrtt6xx@wunner.de>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
 <20181113125910.GB2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF51F@FRAEML521-MBX.china.huawei.com>
 <20181113150749.GC2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF7B5@FRAEML521-MBX.china.huawei.com>
 <20181114095225.GN2500@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114095225.GN2500@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 11:52:25AM +0200, mika.westerberg@linux.intel.com wrote:
> On Tue, Nov 13, 2018 at 03:57:47PM +0000, Shameerali Kolothum Thodi wrote:
> > > The smb_mb() thing is not that clear (at least to me) because it is used
> > > in two places in the driver and both seem to be making write to
> > > ctrl->cmd_busy visible to other CPUs but I don't see where we deal with
> > > the read part.
> > > 
> > > I may be missing something, though.
> > 
> > I think the read part is in wait_event_timeout() which evaluates the
> > condition. The wake_up is called from the pciehp_isr().  Since the flag
> > is being updated in both process level and interrupt handler context,
> > smp_mb() is used. I think the same now applies to  ctrl->slot_ctrl now
> > as this being used in process context and interrupt context as well.
> 
> Right, but that would require to use another read/general barrier in the
> pciehp_isr() before we read the variable in case interrupt happens
> immediately on another CPU (at least that's my understanding).

In pcie_do_write_cmd(), please just move the

	ctrl->slot_ctrl = slot_ctrl;

above the call to pcie_capability_write_word().

AFAICS an explicit memory barrier isn't needed here because of the call to
pcie_capability_write_word(), which "will [ordinarily] be guaranteed to be
fully ordered and uncombined" (Documentation/memory-barriers.txt, section
"KERNEL I/O BARRIER EFFECTS").

The memory barrier in pciehp_isr() is also bogus because the following
wake_up() implies a memory barrier if a task was woken.  (And if none
was woken, who cares.)


> Since I'm
> not too comfortable with all these barriers to be honest I would prefer
> reading the slot control register directly in pciehp_isr() :-)

That is an approach I'd strongly object to:  While pciehp itself only
signals very few interrupts (making an additional mmio read appear to
be negligible), it may share its interrupt with other devices.  On my
MacBookPro9,1, a hotplug port of the Thunderbolt controller shares
its interrupt line with the Wifi card and SD card reader, and those
may signal a huge number of interrupts.  On such a machine an additional
mmio read per interrupt becomes a problem.

Thanks,

Lukas
